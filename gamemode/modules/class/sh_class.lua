
BREACH.Classes, BREACH.Factions = {}, {}
function BREACH.Classes.Register(faction, data)
    if BREACH.Classes[id] then return end

    local CLASS = {
        id = id,
        name = name || 'Undefined',
        models = data.models || {'models/error.mdl'},
        support = data.support || false
    }

    BREACH.Classes[id] = CLASS
    rnlib.p('Registered "%s" (%s) class', name, id)
end

local constBlocked = math.pi
function BREACH.Factions.Register(id, name)
    _G['FACTION_'..id] = (#BREACH.Factions || 0) + 1
    BREACH.Factions[id] = name 
end

function BREACH.Factions.GetName(id)
    return BREACH.Factions[id]
end
