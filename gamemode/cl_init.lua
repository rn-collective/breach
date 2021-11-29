
include 'shared.lua'

function BREACH:InitializeClient()
    rnlib.p 'Client initialized'
    LocalPlayer():SetCanZoom(false)
    system.FlashWindow()
end
