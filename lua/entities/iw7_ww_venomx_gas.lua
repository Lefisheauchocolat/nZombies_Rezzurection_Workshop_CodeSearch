AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Venom Gas"

--[Parameters]--
ENT.Delay = 2.5
ENT.DelayPaP = 5
ENT.Range = 220

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data, phys)
	timer.Simple(0, function()
		if not self:IsValid() then return end
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
	end)

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(0.1)
		phys:EnableDrag(true)
		phys:Wake()
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("iw7_venomx_gas_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.Delay = self.DelayPaP
		self.color = Color(200, 150, 50, 255)
	else
		ParticleEffectAttach("iw7_venomx_gas", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(200, 255, 0, 255)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	if self:WaterLevel() > 1 then SafeRemoveEntity(self) return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		local ply = self:GetOwner()
		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if (v:IsPlayer() or v:IsNPC() or v:IsNextBot()) then
				if v == ply then continue end
				if v.Alive and not v:Alive() then continue end
				if v:Health() <= 0 then continue end
				if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

				self:InflictDamage(v)
			end
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime() + (1/3))
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up*-2000)
	damage:SetDamageType(DMG_RADIATION)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(200, ent:GetMaxHealth() / 32))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end
