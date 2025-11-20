AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Panther Projectile"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 200
ENT.Impacted = false
ENT.ImpactEffect = "waw_levitator_impact"
ENT.MaxKills = 12
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()
	self:SetHitPos(data.HitPos)
	self:Explode(data.HitPos)

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:InflictDamage(ent, self:GetPos())
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("waw_levitator_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.ImpactEffect = "waw_levitator_impact_2"
		self.color = Color(50, 245, 30, 255)
	else
		ParticleEffectAttach("waw_levitator_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(100, 240, 255, 255)
	end

	self:EmitSoundNet("TFA_WAW_LEVITATOR.Orb.Start")
	self:EmitSoundNet("TFA_WAW_LEVITATOR.Orb.Loop")
	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:StopParticles()
			self:SetHitPos(self:GetPos())
			self:Explode(self:GetPos())

			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect(pos)
	self:StopSound("TFA_WAW_LEVITATOR.Orb.Loop")
	self:EmitSound("TFA_WAW_LEVITATOR.Orb.End")

	ParticleEffect(self.ImpactEffect, pos, angle_zero)

	util.ScreenShake(pos, 5, 5, 2, self.Range*1.5)
end

function ENT:Explode(pos)
	self:DoExplosionEffect(pos)

	local ply = self:GetOwner()
	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end

	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
			if v:Health() <= 0 then continue end
			if v:WAWLevitating() then continue end
			if self.Kills >= self.MaxKills then break end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			if v == ply then continue end

			if v:IsPlayer() and IsValid(ply) and v ~= ply and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			v:WAWLevitate(math.Rand(2.5,5), ply, self.Inflictor, self:GetUpgraded())
			self.Kills = self.Kills + 1
		end
	end

	self:Remove()
end

function ENT:InflictDamage(ent, hitpos)
	self.Damage = self.mydamage or self.Damage

	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(self:GetForward()*math.random(60,80)*100)
	damage:SetDamageType(DMG_DISSOLVE)
	damage:SetDamagePosition(hitpos)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 9))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopSound("TFA_WAW_LEVITATOR.Orb.Loop")
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 420
			dlight.DieTime = CurTime() + 1
		end
	end
end