
GM.Name 	= "Breach"
GM.Website 	= "https://discord.gg/yjQv9pYwbC"
GM.Author 	= 'SCP: Snow Seazon'

BREACH = BREACH || {}
BREACH.Author = GM.Author
BREACH.Version = 'Beta 1.0'
BREACH.Modules = {['ui'] = true}

local core_dump = rnlib.dump.Register 'BREACH.Init'
	core_dump:RegisterStoredTable()
	core_dump:AddValue(function(io, path)
		for dir, status in pairs(io) do
			if !status then continue end
			for _, file in ipairs(file.Find(Format(path..'*.lua', dir), 'LUA')) do
				rnlib.i(Format(path, dir)..file)
				rnlib.p('[BREACH] %s | Loaded \'%s\'', dir, file)
			end
		end
	end)
	core_dump:AddValue(function()
		local cfg, map_cfg = rnlib.yaml['Read']('gamemodes/breach/gamemode/configs/basic.yml') || {}, rnlib.yaml['Read']('gamemodes/breach/gamemode/configs/'..game.GetMap()..'.yml') || {}
		_G['BreachConfig'] = table.Merge(cfg, map_cfg)
	end)
	core_dump:Execute(1, {['meta'] = true}, 'breach/gamemode/%s/')
	core_dump:Execute(1, BREACH.Modules, 'breach/gamemode/modules/%s/')
	core_dump:Execute(2)
BREACH.Core = core_dump

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