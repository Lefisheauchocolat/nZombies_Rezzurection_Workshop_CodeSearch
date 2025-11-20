AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Tesla Flechette"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 6

ENT.Range = 80
ENT.BlastRange = 120

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	local ang = self:GetAngles()
	local ent = data.HitEntity
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetAngles(ang)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetPos(data.HitPos)
		if IsValid(ent) and IsValid(data.HitObject) and !ent:IsWorld() then
			self:SetParent(ent)
		end
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:StopParticles()
	self:EmitSound("TFA_BO2_TESLAGAT.Proj.Charge")
	self.killtime = CurTime() + self.Life
	self.fuckangle = data.HitNormal:Angle()
	self.hitwall = data.HitNormal:Dot(Vector(0,0,-1)) < 0.9 
end

function ENT:StartTouch(ent)
	if self.Impacted then return end

	local ply = self:GetOwner()
	if ent == ply then return end
	if not ent:IsSolid() then return end
	if nzombies and !(ent:IsNextBot() or ent:IsNPC()) then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if ent:Health() <= 0 then return end

	self.Impacted = true
	self:SetParent(ent)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	self:StopParticles()
	self:EmitSound("TFA_BO2_TESLAGAT.Proj.Charge")
	self.killtime = CurTime() + self.Life
	self.hitwall = true
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	ParticleEffectAttach("bo2_teslagat_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	util.SpriteTrail(self, 3, Color(90, 0, 255), true, 24, 0, 0.3, 0.1, "effects/laser_citadel1")
	self:SetTrigger(true)
end

function ENT:Think()
	local pos = self:GetPos()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = pos
			dlight.r = 5*(math.random(6))
			dlight.g = 15
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()

		if self.Impacted and not self:GetActivated() and (self.killtime - self.Life) + 1.2 < CurTime() then
			self:CustomActivate()
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

		if self:GetActivated() then
			local p = self:GetParent()
			if IsValid(p) and (p:IsNPC() or p:IsPlayer() or p:IsNextBot()) and p:Health() <= 0 then
				self:Remove()
				return false
			end

			for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v:BO2IsSparky() then continue end
					if v:Health() <= 0 then continue end
					if v.NZBossType then continue end

					v:BO2Sparky((self.killtime - CurTime()) + 0.15)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:CustomActivate()
	local p = self:GetParent()
	if IsValid(p) then
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
			phys:Sleep(true)
		end
	end

	if self.fuckangle then
		self:SetAngles(self.fuckangle)
	end

	self:SetActivated(true)

	self:EmitSound("TFA_BO2_TESLAGAT.Proj.Loop")
	self:EmitSound("TFA_BO2_TESLAGAT.Proj.Loop2")

	ParticleEffect("bo2_teslagat_impact", self:GetPos(), angle_zero)
	ParticleEffectAttach(self.hitwall and "bo2_teslagat_wall" or "bo2_teslagat_ground", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	local p = self:GetParent() or self
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.BlastRange)) do
		if v:IsSolid() and not v:IsWorld() then
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if nzombies and v:IsPlayer() then continue end

			self:InflictDamage(v)
		end
	end

	util.ScreenShake(self:GetPos(), 4, 255, 1, self.BlastRange*2)
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	if nzombies then
		damage:SetDamageForce(ent:GetUp()*math.random(6000,9000) + (ent:WorldSpaceCenter() - self:GetPos()):GetNormalized()*math.random(4000,8000))
	else
		damage:SetDamageForce(ent:GetUp()*math.random(1000,6000) + (ent:WorldSpaceCenter() - self:GetPos()):GetNormalized()*math.random(2000,6000))
	end
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageType(ent:IsNextBot() and DMG_ENERGYBEAM or DMG_SHOCK)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 18))
	end

	if ent:IsNPC() then
		ent:StopParticles()
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	if (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsRagdoll() or ent:IsVehicle()) then
		ParticleEffectAttach("bo2_teslagat_shock", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
	end

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	if SERVER then
		self:Explode()
	end

	ParticleEffect("bo2_teslagat_impact", self:GetPos(), angle_zero)

	self:EmitSound("TFA_BO2_TESLAGAT.Act")
	self:StopSound("TFA_BO2_TESLAGAT.Proj.Loop")
	self:StopSound("TFA_BO2_TESLAGAT.Proj.Loop2")
end
