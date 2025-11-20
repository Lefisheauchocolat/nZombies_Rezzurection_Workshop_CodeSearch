AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Gravity Spike"

--[Parameters]--
ENT.Range = 256
ENT.Consumption = 1

DEFINE_BASECLASS(ENT.Base)

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:PhysicsInit( SOLID_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	self:SetMoveType( MOVETYPE_NONE )

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Think()
	local p = self:GetParent()
	if SERVER then
		if not p:GetActivated() and not self.HasEmitParticle then
			self.HasEmitParticle = true
			ParticleEffectAttach( "waw_gravspike_3p", PATTACH_POINT_FOLLOW, self, 1 )
		end
		if not IsValid(p) then
			SafeRemoveEntity(self)
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopParticles()
end
