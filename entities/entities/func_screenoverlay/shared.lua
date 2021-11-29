ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.PrintName = "Overlay Brush"
ENT.Category = "SCPRP"
ENT.Author = "Az"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false

function ENT:SetupDataTables()

	self:NetworkVar( "String",	0, "DesiredOverlay", { KeyName = "desired_overlay" } )
	self:NetworkVar( "String",	1, "DesiredEntranceSound", { KeyName = "desired_entrance_sound" } )
	self:NetworkVar( "String",	2, "DesiredExitSound", { KeyName = "desired_exit_sound" } )
	self:NetworkVar( "Bool", 0, "ResetOnExit", { KeyName = "reset_on_exit" } )

end