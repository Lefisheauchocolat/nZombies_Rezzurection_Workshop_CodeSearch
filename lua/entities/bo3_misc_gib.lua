AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/zmb/gibs/p7_gib_chunk.mdl")
		self:SetBodygroup(0, math.random(0,10))

		self:SetModelScale(math.Rand(1,2))
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(true)
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		end

		SafeRemoveEntityDelayed(self, 3)
	end

	ParticleEffectAttach("horror_bloodgibs", PATTACH_ABSORIGIN_FOLLOW, self, 1)
end

function ENT:Think()
	if CLIENT then return false end

	if self:WaterLevel() > 1 then 
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		util.Decal("Blood", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	end
end