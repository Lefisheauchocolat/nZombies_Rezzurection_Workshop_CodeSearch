AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Inferno"

--[Parameters]--
ENT.Delay = 0.35

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	ParticleEffectAttach("bo1_hellfire_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = 255
			dlight.g = 120
			dlight.b = 20
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity
	if ent:IsWorld() and ent:IsSolid() then
		self:Remove()
	end
end