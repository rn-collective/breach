
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

local client
hook.Add('HUDPaint', 'BREACH.HUD', function()
    client = LocalPlayer()
    if client:Team() == TEAM_SPECTATOR then
        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(5, 5, 5, 5)
    end
end)