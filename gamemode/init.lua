
AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'shared.lua'
include 'shared.lua'
rnlib.AddContentDir 'materials/rn_breach/'
rnlib.AddContentDir 'sound/rn_breach/'

function BREACH:InitializeServer()
    rnlib.p 'Server initialized'
    for i = 1, #engine.GetAddons() do
        local addonID = engine.GetAddons()[i].wsid
        resource.AddWorkshop(addonID)
        rnlib.p('Added \'%s\' to content auto-download', addonID)
    end
end

hook.Add('PlayerInitialSpawn', 'BREACH.Initialization', function(client)
    client:_SetSimpleTimer(0, function()
        if table.HasValue(_G['BreachConfig']['basic']['executives'], client:SteamID()) then
            client:SetUserGroup 'superadmin'
            rnlib.p('Executive spawned: %s', client:SteamID())
        end

        client:SetCanZoom(false)
        client:EnableSpectator()

        if _G['BreachConfig'][game.GetMap()]['spawns']['basic']['startpos'] then
            client:SetPos(Vector(_G['BreachConfig'][game.GetMap()]['spawns']['basic']['startpos'][1]))
            client:SetEyeAngles(Angle(_G['BreachConfig'][game.GetMap()]['spawns']['basic']['startpos'][2]))
        end
    end)
end)

hook.Add('PrePlayerDraw', 'BREACH.Spectator', function(client)
    if client:Team() == TEAM_SPECTATOR then return true end
end)

hook.Add('PlayerNoClip', 'BREACH.Basic', function(client)
    return false
end)

hook.Add('PlayerUse', 'BREACH.Basic', function(client, ent)
    if client:Team() == TEAM_SPECTATOR then return false end
    for _, v in pairs(_G['BreachConfig'][game.GetMap()]['buttons']) do
        if Vector(v.pos[1]) == ent:GetPos() then
            if !client:HasKeyLevel(v.level) then
                ent:EmitDelayedSound('rn_breach/keycarduse2.ogg', 1)
                return false
            end
        end
    end
end)