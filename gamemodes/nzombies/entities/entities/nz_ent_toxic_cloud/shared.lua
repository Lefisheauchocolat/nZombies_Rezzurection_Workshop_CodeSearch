AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "Stench"
ENT.Author			= "fox"
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

	self.alivetime = 1
	self.killtime = CurTime() + 8

	util.ScreenShake(self:GetPos(), 10, 255, 1, 150)
	self:EmitSound("nz_moo/zombies/vox/_quad/_classic/explo/explo_0"..math.random(3)..".mp3")
	--ParticleEffect("zmb_gas_explo", self:GetPos() + Vector(0,0,4), Angle(0,0,0), self)
	ParticleEffect("zmb_toxicpuddle_small", self:GetPos() + Vector(0,0,3), Angle(-90,0,0), self)

	if !self.StartLP then
		self.StarLP = true
		self:EmitSound("nz_moo/zombies/vox/_spitter/acid/spitter_acid_loop_02.wav",65)
	end

	if CLIENT then return end
	util.BlastDamage(self, self, self:GetPos(), 150, 15)
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 85)) do
			if v:IsPlayer() and v:GetNotDowned() and v:Health() > 1 then
				self:InflictDamage(v)

				--[[if v:IsPlayer() and v:HasPerk("mask") then continue end
				v:NZNovaGas(1)]]
			end
		end

		if self.killtime < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self.alivetime = 0.25 + self.alivetime

	self:NextThink(CurTime() + 0.45)
	return true
end

function ENT:InflictDamage(ent)
	local dmg = 4 * self.alivetime

	local damage = DamageInfo()
	damage:SetDamageType(DMG_DROWN)
	damage:SetAttacker(self)
	damage:SetInflictor(self)
	damage:SetDamage(dmg)
	damage:SetDamageForce(ent:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:EmitSound("nz_moo/zombies/vox/_spitter/acid/spitter_acid_fadeout2.mp3",70)
	self:StopSound("nz_moo/zombies/vox/_spitter/acid/spitter_acid_loop_02.wav")
end
