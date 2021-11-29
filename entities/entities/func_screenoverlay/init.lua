AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:SetBounds(min, max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionBounds(min, max)
	self:SetTrigger(true)
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		ent:ConCommand("r_screenoverlay " .. self:GetDesiredOverlay())
		ent:EmitSound(self:GetDesiredEntranceSound(),75,100,1)
		self.func_screenoverlayOverlay = self
	end
end

function ENT:EndTouch(ent)
	if self:GetResetOnExit() then
		if ent:IsPlayer() then
			ent:ConCommand("r_screenoverlay \"\"")
			ent:EmitSound(self:GetDesiredExitSound(),75,100,1)
			self.func_screenoverlayOverlay = nil
		end
	end
end

function ENT:AcceptInput(name, activator, caller)
	if name == "EnableResetOnExit" then
		self:SetResetOnExit(true)
		return true
	end
	if name == "DisableResetOnExit" then
		self:SetResetOnExit(false)
		return true
	end
end

function ENT:KeyValue( key, value )
	if key == "desired_overlay" then
		self:SetDesiredOverlay(value)
		print("Setting desired overlay to " .. value)
	end
	if key == "desired_entrance_sound" then
		self:SetDesiredEntranceSound(value)
		print("Setting desired entrance sound to " .. value)
	end
	if key == "desired_exit_sound" then
		self:SetDesiredExitSound(value)
		print("Setting desired exit sound to " .. value)
	end
	if key == "reset_on_exit" then
		self:SetResetOnExit(value == "1")
	end
end
