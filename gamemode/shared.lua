
GM.Name 	= "Breach"
GM.Website 	= "https://discord.gg/yjQv9pYwbC"
GM.Author 	= 'SCP: Snow Seazon'

BREACH = BREACH || {}
BREACH.Author = GM.Author
BREACH.Version = 'Beta 1.0'
BREACH.Files = {
	'meta/cl_player.lua',
	'meta/sv_player.lua'
}

function BREACH:Core()
	for i = 1, #self.Files do
		rnlib.i(self.Files[i])
		rnlib.p('Loaded \'%s\'', self.Files[i])
	end
end
BREACH:Core()

function GM:GetGameDescription()
	return self['Name']
end

hook.Add('InitPostEntity', 'BREACH.Exec', function()
	RunConsoleCommand('sv_location', 'ru')
	RunConsoleCommand('hostname', 'SCP: Snow Seazon > '..BREACH['Version'])
	if SERVER then
		timer.Simple(1, function()
			BREACH:InitializeAddons()
		end)
	end
end)