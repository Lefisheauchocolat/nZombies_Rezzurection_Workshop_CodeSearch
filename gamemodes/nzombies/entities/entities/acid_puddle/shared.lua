AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "acid_puddle"
ENT.Author			= "laby"
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

	self.killtime = CurTime() + 5

	--util.ScreenShake(self:GetPos(), 10, 255, 1, 150)
	--self:EmitSound("bo1_overhaul/n6/xplo"..math.random(2)..".mp3")
	--ParticleEffect("bo3_sliquifier_puddle_2", self:GetPos(), Angle(0,0,0))
	ParticleEffectAttach("bo3_sliquifier_puddle_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	if CLIENT then return end
	--util.BlastDamage(self, self, self:GetPos(), 150, 15)
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
			if v:IsPlayer() and v:GetNotDowned() and v:Health() > 1 then
			if v:IsPlayer() and v:HasPerk("mask") then continue end
				self:InflictDamage(v)

			end
		end

		if self.killtime < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_POISON)
	damage:SetAttacker(self)
	damage:SetInflictor(self)
	damage:SetDamage(5)
	damage:SetDamageForce(ent:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(damage)
end
