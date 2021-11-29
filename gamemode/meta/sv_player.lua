
function PLAYER:Notify(str)
    netstream.Start(self, 'BREACH.ReceiveNotify', str)
end

function PLAYER:EnableSpectator()
    self:StripWeapons()
    self:StripAmmo()

    self:SetTeam(TEAM_SPECTATOR)
    self:Spectate(OBS_MODE_FIXED)
    self:SetMoveType(MOVETYPE_NOCLIP)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

    self:SetNoDraw(true)
    self:SetNotSolid(true)
    self:DrawWorldModel(false)
    self:DrawShadow(false)
    self:SetNoTarget(true)
    self:GodEnable()
end

function PLAYER:DisableSpectator()
    self:SetTeam(TEAM_UNASSIGNED)
    self:SetMoveType(MOVETYPE_WALK)
    self:SetCollisionGroup(COLLISION_GROUP_NONE)

    self:SetNoDraw(false)
    self:SetNotSolid(false)
    self:DrawWorldModel(true)
    self:DrawShadow(false)
    self:SetNoTarget(false)
    self:GodDisable()
end
