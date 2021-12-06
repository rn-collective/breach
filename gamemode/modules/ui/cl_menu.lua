
_G['BreachMenuPressed'] = _G['BreachMenuPressed'] || false
_G['BreachMenuCanClose'] = _G['BreachMenuCanClose'] || false
local PANEL = {}
DEFINE_BASECLASS 'EditablePanel'
surface.CreateFont('BREACH.Menu', {
    font = 'NotCourierSans',
	extended = true,
	size = SScale(20),
	weight = 500,
	antialias = true
})

function PANEL:Init()
    if IsValid(BREACH.Menu) then
        BREACH.Menu:Remove()
    end
    BREACH.Menu = self
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0) --?????
    self:MakePopup()
    self:SetAlpha(0)
    self:AlphaTo(255, .2, 0)

    self:AddButton("startgame", ScrH()*.5, _G['BreachMenuPressed'] && 'Продолжить' || 'Играть', function()
        surface.PlaySound 'rn_scplc/button_press.wav'
        _G['BreachMenuPressed'] = true
        _G['BreachMenuCanClose'] = true
        self:Remove()
    end)

    self:AddButton("tutorial", ScrH()*.57, "Туториал", function()
        vgui.Create 'BREACH.Tutorial'
        surface.PlaySound 'rn_scplc/button_press.wav'
        self:Remove()
    end)

    self:AddButton("discord", ScrH()*.64, "Дискорд", function()
        gui.OpenURL 'https://discord.gg/qe6Brr6y7z'
        surface.PlaySound 'rn_scplc/button_press.wav'
    end)

    self:AddButton("content", ScrH()*.71, "Контент", function()
        gui.OpenURL 'https://steamcommunity.com/workshop/filedetails/?id=1985710128'
        surface.PlaySound 'rn_scplc/button_press.wav'
    end)

    self:AddButton("quit", ScrH()*.78, "Выйти", function(this)
        if this:GetText() == "Вы уверены?" then
            RunConsoleCommand("disconnect")
        end
        this:SetText("Вы уверены?")
        surface.PlaySound 'rn_scplc/button_press.wav'
    end)
end

function PANEL:AddButton(id, zpos, text, callback)
    self[id] = self:Add 'DButton'
    self[id]:SetSize(SScale(125), VScale(25))
    self[id]:SetPos((ScrW()*.5)-SScale(125)/2, zpos)
    self[id]:SetText(text)
    self[id]:SetFont 'BREACH.Menu'
    self[id]:SetTextColor(Color(255, 255, 255))
    self[id]:SetExpensiveShadow(2)
    self[id].Paint = function(this)
        if this:IsHovered() then
            this:SetTextColor(Color(227, 89, 115))
        else
            this:SetTextColor(Color(255, 255, 255))
        end
    end
    self[id].DoClick = callback
    self[id].Think = function(this)
        if this:IsHovered() then
            if !this.bHoveredBool then
                this.bHoveredBool = true
                --surface.PlaySound 'rn_scplc/button_selection.wav'
            end
        else
            this.bHoveredBool = false
        end
    end
end

local backgroun_logo = Material('rn_breach/logo.png', 'noclamp smooth')
function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 99)
    surface.DrawRect(0, 0, w, h)
    rnlib.DrawBlur(self, 5)

    local _w, _h = math.min(SScaleMin(1024/2), backgroun_logo:Width()), math.min(SScaleMin(128/2), backgroun_logo:Height())
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(backgroun_logo)
    surface.DrawTexturedRect((ScrW()*.5)-_w/2, ScrH()*.35, _w, _h)
end

function PANEL:Remove()
    self:AlphaTo(0, .2, 0, function()
        BaseClass.Remove(self)
    end)
end

vgui.Register('BREACH.Menu', PANEL, 'EditablePanel')

local function menuToggle()
    if input.IsKeyDown(KEY_ESCAPE) && gui.IsGameUIVisible() && _G['BreachMenuCanClose'] then
        if IsValid(BREACH.Tutorial) then
            BREACH.Tutorial:Remove()
        end

        if IsValid(BREACH.Menu) then
            BREACH.Menu:Remove()
        else
            vgui.Create 'BREACH.Menu'
        end

        gui.HideGameUI()
    end
end

hook.Add('PreRender', 'BREACH.Menu', menuToggle)

netstream.Hook('BREACH.OpenMenu', function()
    vgui.Create 'BREACH.Menu'
end)