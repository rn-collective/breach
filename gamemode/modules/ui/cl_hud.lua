
local badNames = {
    ['CHudAmmo'] = true,
    ['CHudBattery'] = true,
    ['CHudChat'] = true,
    ['CHudCrosshair'] = true,
    ['CHudCloseCaption'] = true,
    ['CHudDamageIndicator'] = true,
    ['CHudDeathNotice'] = true,
    ['CHudGeiger'] = true,
    ['CHudHealth'] = true,
    ['CHudMessage'] = true,
    ['CHudSecondaryAmmo'] = true,
    ['CHudPoisonDamageIndicator'] = true,
    ['CHudSquadStatus'] = true,
    ['CHudWeapon'] = true,
    ['CHudZoom'] = true,
    ['CHudSuitPower'] = true,
    ['CHUDQuickInfo'] = true
}

hook.Add('HUDShouldDraw', 'BREACH.HUDShouldDraw', function(name)
    if badNames[name] then return false end
end)