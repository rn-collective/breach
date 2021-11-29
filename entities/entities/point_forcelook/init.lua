
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/oildrum001.mdl")
	self:SetColor(Color(0,0,0,0))
	self:SetSolid(SOLID_NONE)
end

function ENT:Think()
	for i, v in ipairs(player.GetAll()) do
		local tr = util.TraceLine({
			start = v:GetShootPos(),
			endpos = self:GetPos(),
			filter = {v, self, Entity(0)}
		})
		if not tr.Hit then
			local dmg = DamageInfo()
			dmg:SetDamage(2)
			dmg:SetAttacker(game.GetWorld())
			dmg:SetInflictor(game.GetWorld())
			v:TakeDamageInfo(dmg)
		end
	end
end