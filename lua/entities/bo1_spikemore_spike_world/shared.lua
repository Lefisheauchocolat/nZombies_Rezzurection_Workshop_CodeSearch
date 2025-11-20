ENT.Type = "anim"
ENT.PrintName = "Spike Stuck"
ENT.Author = "TFA"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	if CLIENT then return end
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableGravity(false)
		phys:EnableCollisions(false)
		phys:EnableMotion(false)
	end

	SafeRemoveEntityDelayed(self, math.Rand(10,12))
end
