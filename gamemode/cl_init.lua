
include 'shared.lua'

function BREACH:InitializeClient()
    rnlib.p 'Client initialized'
    LocalPlayer():SetCanZoom(false)
    system.FlashWindow()
end

hook.Add("CalcView", "CalcViewInfil", function  (ply,  origin,  angles,  fov,  znear,  zfar ) 
    if IsValid(ply:GetNWEntity("InfilPlayer")) then
        local p = ply:GetNWEntity("InfilPlayer")
        local attId = p:LookupAttachment("Camera")
        local attachment = p:GetAttachment(attId)

        if attachment != nil then
            local ease = 0.1
            local cycle = math.max(p:GetCycle() - (1 - ease), 0) / ease
            local position = LerpVector(cycle, attachment.Pos, origin)
            local rotation = LerpAngle(cycle, attachment.Ang, angles)
            local view = {
                origin = position,
                angles = rotation,
                fov = fov,
                znear = 1,
                -- zfar = 10000,
                drawviewer = true
            }
            return view
        end
    end
end)