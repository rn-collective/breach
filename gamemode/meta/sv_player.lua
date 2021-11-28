
function PLAYER:Notify(str)
    netstream.Start(self, 'BREACH.ReceiveNotify', str)
end
