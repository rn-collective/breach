
local PANEL = {}
DEFINE_BASECLASS 'EditablePanel'
surface.CreateFont('BREACH.TextScreen', {
    font = 'NotCourierSans',
	extended = true,
	size = SScale(15),
	weight = 500,
	antialias = true
})

function PANEL:Init()
    if IsValid(BREACH.TextScreen) then
        BREACH.TextScreen:Remove()
    end
    BREACH.TextScreen = self
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
    self:SetAlpha(0)
    self:AlphaTo(255, .3, 0)
    self.noticeStr = ''
    self.noticeDTime = 5
    timer.Create('BREACH.TextScreenFade', self.noticeDTime, 1, function()
        self:Remove()
    end)
end

function PANEL:Paint(w, h)
    surface.SetFont 'BREACH.TextScreen'
    local _w, _h = surface.GetTextSize(self.noticeStr)
	surface.SetTextColor(255, 255, 255)
	surface.SetTextPos((w*.5)-_w/2, h*.8)
	surface.DrawText(self.noticeStr)
end

function PANEL:SetDT(str, time)
    self:SetText(str); self:SetDeathTime(time)
end

function PANEL:SetText(str)
    self.noticeStr = tostring(str)
end

function PANEL:SetDeathTime(time)
    self.noticeDTime = tonumber(time)
    timer.Adjust('BREACH.TextScreenFade', time)
end

function PANEL:Remove()
    self:AlphaTo(0, .3, 0, function()
        BaseClass.Remove(self)
    end)
end

vgui.Register('BREACH.TextScreen', PANEL, 'EditablePanel')