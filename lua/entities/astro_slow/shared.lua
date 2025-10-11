AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "astro_slow"
ENT.Author			= "fox, moo"
ENT.Contact			= "don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetNoDraw(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.killtime = CurTime() + 3.5

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think() -- Literally just modified the nova gas slow code to better suit the funny spaceman
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 72)) do
			if v:IsPlayer() and v:GetNotDowned() and v:Health() > 1 then

				v:NZAstroSlow(0.95)
			end
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
end

