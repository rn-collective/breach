
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

function PLAYER:SpawnByHelicopter(pos)
    local pb = 8

    local tr = util.TraceHull({
        start = pos + Vector(0, 0, 72),
        endpos = pos + Vector(0, 0, 2),
        filter = {k, self},
        maxs = Vector(pb, pb, 1),
        mins = Vector(-pb, pb, 0)
    })

    local tr2 = util.TraceHull({
        start = pos + Vector(0, 0, 2),
        endpos = pos + Vector(0, 0, 72),
        filter = {k, self},
        maxs = Vector(pb, pb, 1),
        mins = Vector(-pb, pb, 0)
    })

    if !tr.Hit && !tr.StartSolid && !tr2.Hit && !tr2.StartSolid then
        self:SetPos(pos)
        self:SetEyeAngles(Angle(0, math.Rand(-180, 180), 0))

        local insertion = ents.Create 'mw_infil'
        insertion:SetPos(pos)
        insertion:SetAngles(Angle(0, math.Rand(-180, 180), 0))
        insertion:SetOwner(self)
        insertion:Spawn()
    end
end