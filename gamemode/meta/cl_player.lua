
netstream.Hook('BREACH.ReceiveNotify', function(str)
    rnlib.p('[NOTIFY] '..str)
end)