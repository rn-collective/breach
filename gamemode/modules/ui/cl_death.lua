
local PANEL = {}
DEFINE_BASECLASS 'EditablePanel'

function PANEL:Init()
    if IsValid(BREACH.Death) then
        BREACH.Death:Remove()
    end
    BREACH.Death = self
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:MakePopup()
    self:SetAlpha(0)
    self:AlphaTo(255, .3, 0)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 66)
    surface.DrawRect(0, 0, w, h)
    rnlib.DrawBlur(self, 10)
end

function PANEL:Remove()
    self:AlphaTo(0, .3, 0, function()
        BaseClass.Remove(self)
    end)
end

vgui.Register('BREACH.Death', PANEL, 'EditablePanel')