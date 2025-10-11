AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "brutus_gas_cloud"
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

	util.ScreenShake(self:GetPos(), 10, 255, 1, 150)
	self:EmitSound("nz_moo/zombies/vox/_cellbreaker/smoke_grenade/smoke_primendrop_0"..math.random(0,1)..".mp3")
	self:EmitSound("nz_moo/zombies/vox/_cellbreaker/smoke_grenade/smoke.mp3")
	ParticleEffectAttach("ins_m203_smokegrenade",PATTACH_POINT_FOLLOW,self,1)

	if CLIENT then return end
	--util.BlastDamage(self, self, self:GetPos(), 150, 15)
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
			if v:IsPlayer() and v:GetNotDowned() and v:Health() > 1 then
				self:InflictDamage(v)

				if v:IsPlayer() and v:HasPerk("mask") then continue end
				v:NZDecayGas(1)
			end
		end
		if not IsValid(self:GetParent()) then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_NERVEGAS)
	damage:SetAttacker(self)
	damage:SetInflictor(self)
	damage:SetDamage(2)
	damage:SetDamageForce(ent:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(damage)
end
