
SWEP.PrintName = 'Keycards Base'
SWEP.Category = 'SCP: Snow Seazon'
SWEP.WorldModel = Model 'models/snowseazon/card_v1/card_snowseazon.mdl'
SWEP.ViewModel = Model 'models/1000shells/snowseazon/keycards/c_keycard.mdl'
SWEP.UseHands = true
SWEP.HoldType = 'slam'
SWEP.Skin = 0
SWEP.KeycardLevel = 0
SWEP.Pos = Vector(2, -2, -4)
SWEP.Ang = Angle(90, -20, 0)

function SWEP:Initialize()
    self:SetSkin(self.Skin)
    self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
    self:SetHoldType(self.HoldType)
    self.IdleDelay = CurTime() + .75
    self:PlaySequence 'draw'

    local vm = self.Owner:GetViewModel()
    if vm && vm:IsValid() && vm:GetSkin() != self.Skin then
        vm:SetSkin(self.Skin)
    end

    self.HolsterDelay = nil
    timer.Simple(.25, function()
        if ( self && self:IsValid() ) then
            self.Deployed = true
        end
    end)
end

local position_idle = Vector(0, -6, 2)
local position_walk = Vector(2, -2, -4)

local angle_idle = Angle(180, 80, 0)
local angle_walk = Angle(90, -20, 0)

function SWEP:Think()
    if ( ( self.IdleDelay || 0 ) < CurTime() && !self.IdlePlaying ) then
        self.IdlePlaying = true
        self:PlaySequence( "idle", true )
    end

    if ( self.Owner:KeyDown( IN_USE ) ) then
        if ( ( self.IdleDelay || 0 ) < CurTime() ) then
        self:AnimationUse()
        end
    end

    local vel = self.Owner:GetVelocity():Length2DSqr()
    if ( vel <= .25 && !self.Owner:Crouching() ) then
        self.Pos = position_idle
        self.Ang = angle_idle
    elseif ( vel > .25 && self.Owner:OnGround() ) then
        self.Pos = position_walk
        self.Ang = angle_walk
    end
end

function SWEP:AnimationUse()
    self.IdleDelay = CurTime() + .6
    self:PlaySequence 'insert'
end

function SWEP:CreateWorldModel()
	if ( !self.WModel ) then
		self.WModel = ClientsideModel( self.WorldModel, RENDERGROUP_OPAQUE )
		self.WModel:SetNoDraw( true )
    end

	return self.WModel
end

function SWEP:Holster(wep)
    return true
end

function SWEP:DrawWorldModel()
	local wm = self:CreateWorldModel()
	local pl = self:GetOwner()

	if ( pl && pl:IsValid() ) then
		local bone = self.Owner:LookupBone( "ValveBiped.Bip01_R_Hand" )
        if ( !bone ) then return end

		local pos, ang = self.Owner:GetBonePosition( bone )
		if ( bone ) then
			ang:RotateAroundAxis( ang:Right(), self.Ang.p )
			ang:RotateAroundAxis( ang:Forward(), self.Ang.y )
			ang:RotateAroundAxis( ang:Up(), self.Ang.r )

			wm:SetRenderOrigin( pos + ang:Right() * self.Pos.x + ang:Forward() * self.Pos.y + ang:Up() * self.Pos.z )
			wm:SetRenderAngles( ang )
            if ( wm:GetSkin() != self.Skin ) then
                wm:SetSkin( self.Skin )
            end
			wm:DrawModel()
		end
	else
        self:SetRenderOrigin( nil )
        self:SetRenderAngles( nil )

        if ( self:GetSkin() != self.Skin ) then
            self:SetSkin( self.Skin )
        end

        self:DrawModel()
	end
end

function SWEP:PrimaryAttack()
    local tr = {}
    tr.start = self.Owner:GetShootPos()
    tr.endpos = tr.start + self.Owner:GetAimVector() * 85
    tr.filter = self.Owner
    tr = util.TraceLine( tr )

    if ( tr.Hit ) then
        local ent = tr.Entity
        if ( ent && ent:IsValid() ) then
            if ( ( self.IdleDelay || 0 ) < CurTime() ) then
                self.Owner:ConCommand( "+use" )
                timer.Simple( .25, function()
                    if ( !( self && self:IsValid() ) || !( self.Owner && self.Owner:IsValid() ) ) then return end
                    self.Owner:ConCommand( "-use" )
                end )
            end
        end
    end
end

function SWEP:CanSecondaryAttack() return false end
