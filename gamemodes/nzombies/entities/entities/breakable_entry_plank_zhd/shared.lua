AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "breakable_entry_plank"
ENT.Author			= "GhostlyMoo"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:Initialize()
	self:SetModel("models/moo/_codz_ports_props/t8/zm/p8_zm_barricade_board_bare/moo_codz_p8_zm_barricade_board_bare.mdl")
	self.AutomaticFrameAdvance = true
	self.Torn = true
	self.ZombieUsing = nil
	self.Enhanced = false

	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	--self:SetModelScale(1)
	--[[if CLIENT then
		local scale = Vector(1,0.9,1.35)
		local mat = Matrix()
		mat:Scale(scale)
		self:EnableMatrix("RenderMultiply", mat)
	end]]
end

function ENT:Think()

	if SERVER then
		if self.ZombieUsing and !IsValid(self.ZombieUsing) then
			self.ZombieUsing = nil
		end

		if self.ZombieUsing and IsValid(self.ZombieUsing) and !self.ZombieUsing.BarricadeTearing then
			self.ZombieUsing = nil
		end
	end

	self:NextThink( CurTime() )

	return true
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end

if SERVER then
	function ENT:UpdateTransmitState() return TRANSMIT_ALWAYS end
end