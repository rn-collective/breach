
local PANEL = {}

function PANEL:Init()
    if IsValid(BREACH.Scoreboard) then
        BREACH.Scoreboard:Remove()
    end
    BREACH.Scoreboard = self
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
end

vgui.Register('BREACH.Scoreboard', PANEL, 'EditablePanel')

--[[
local scoreboard = vgui.Create 'BREACH.Scoreboard'
hook.Add('ScoreboardShow', 'BREACH.Scoreboard', function()
    scoreboard:Setup()
    scoreboard:Show()
    return false
end)

hook.Add('ScoreboardHide', 'BREACH.Scoreboard', function()
    scoreboard:Hide()

    for _, panel in ipairs( scoreboard["playerPanels"] ) do
        panel:Remove()
    end
end)]]