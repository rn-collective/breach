
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
BREACH.Modules = {}

function BREACH:Core()
	for i = 1, #self.Files do
		rnlib.i(self.Files[i])
		rnlib.p('Loaded \'%s\'', self.Files[i])
	end

	-- modules
	for dir, status in pairs(BREACH.Modules) do
        if !status then continue end
        for _, file in ipairs(file.Find('breach/gamemode/modules/'..dir..'/*.lua','LUA')) do
            rnlib.i(dir..'/'..file)
            rnlib.p('%s | Loaded \'%s\' module', dir, string.Right(file, #file - 3))
        end
    end
end
BREACH:Core()

function GM:GetGameDescription()
	return self['Name']
end

hook.Add('InitPostEntity', 'BREACH.Initialization', function()
	RunConsoleCommand('sv_location', 'ru')
	RunConsoleCommand('hostname', 'SCP: Snow Seazon > '..BREACH['Version'])

	if SERVER then
		BREACH:InitializeServer()
	end

	if CLIENT then
		BREACH:InitializeClient()
	end
end)