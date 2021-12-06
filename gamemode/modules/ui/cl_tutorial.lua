
local title = 'НАЖМИТЕ ПРОБЕЛ'

local PANEL = {}
DEFINE_BASECLASS 'EditablePanel'

function PANEL:Init()
    if IsValid(BREACH.Tutorial) then
        BREACH.Tutorial:Remove()
    end
    BREACH.Tutorial = self
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:MakePopup()
    self:SetAlpha(0)
    self:AlphaTo(255, .2, 0)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0)
    surface.DrawRect(0, 0, w, h)

    surface.SetFont 'BREACH.Menu'
    local _w, _h = surface.GetTextSize(title)
    surface.SetTextColor(255, 255, 255, math.abs(math.sin(CurTime())*255))
    surface.SetTextPos((w*.5)-_w/2, h*.9)
    surface.DrawText(title)
end

function PANEL:OnKeyCodePressed(keyCode)
    if keyCode == KEY_SPACE then
        self:Remove()
    end
end

function PANEL:Remove()
    self:AlphaTo(0, .2, 0, function()
        BaseClass.Remove(self)
    end)
end

vgui.Register('BREACH.Tutorial', PANEL, 'EditablePanel')