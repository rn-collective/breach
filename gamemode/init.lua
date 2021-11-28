
AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'shared.lua'
include 'shared.lua'

function BREACH:InitializeAddons()
    for i = 1, #engine.GetAddons() do
        local addonID = engine.GetAddons()[i].wsid
        resource.AddWorkshop(addonID)
        rnlib.p('Added \'%s\' to content auto-download', addonID)
    end
end
