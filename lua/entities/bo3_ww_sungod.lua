AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Sun God"

--[Parameters]--
ENT.Delay = 6
ENT.Range = 200

ENT.UltDelay = 6
ENT.UltDelayPaP = 9
ENT.MaxKills = 24

ENT.Kills = 0
ENT.NextAttack = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()
	self:StopSound("TFA_BO3_SUNGOD.Loop")
	self:EmitSound("TFA_BO3_SUNGOD.Sweet")
	self:EmitSound("TFA_BO3_SUNGOD.Explode")
	ParticleEffect("bo3_sungod_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))

	self:SetHitPos(data.HitPos)

	if self.Charged then
		self:CustomActivate(data.HitPos - data.HitNormal)
		sound.Play("weapons/tfa_bo3/sungod/napalm_explosion.wav", self:WorldSpaceCenter(), SNDLVL_GUNFIRE, math.random(95,105), 1)
	else
		self:Explode(data.HitPos)
		self:Remove()
	end
end

function ENT:StartTouch(ent)
	if not (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then return end
	if ent == self:GetOwner() then return end
	if ent:Health() <= 0 then return end
	if nzombies and ent:IsPlayer() then return end

	if self.Charged then
		if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
			self:InflictDamage(ent)
		else
			self:Obliterate(ent)
		end
	else
		if self.Impacted then return end
		self.Impacted = true

		self:StopParticles()
		self:StopSound("TFA_BO3_SUNGOD.Loop")
		self:EmitSound("TFA_BO3_SUNGOD.Sweet")
		self:EmitSound("TFA_BO3_SUNGOD.Explode")
		ParticleEffect("bo3_sungod_impact", ent:GetPos(), angle_zero)

		self:SetHitPos(self:GetPos())
		self:Explode(self:GetPos())
		self:Remove()
	end
end

function ENT:CustomActivate(pos)
	self:SetAngles(angle_zero)

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetPos(pos)
		ParticleEffectAttach("bo3_sungod_ult", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	end)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.killtime = CurTime() + self.UltDelay
	self:EmitSound("TFA_BO3_SUNGOD.Ult.Loop")
	self:EmitSound("TFA_BO3_SUNGOD.Ult.Sweet")

	util.ScreenShake(pos, 10, 255, 2, self.Range*2)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 4)

	self:EmitSoundNet("TFA_BO3_SUNGOD.Loop")
	ParticleEffectAttach("bo3_sungod_beam", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	if self:GetUpgraded() then
		self.UltDelay = self.UltDelayPaP
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 70
			dlight.b = 100
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.5
		end
	end

	local ply = self:GetOwner()
	if SERVER then
		if self.Charged and self.Impacted and self.NextAttack < CurTime() then
			local tr = {
				start = self:GetPos(),
				filter = self,
				mask = MASK_SOLID_BRUSHONLY,
			}

			for k, v in pairs(ents.FindInSphere(self:GetPos(), 140)) do
				if self.Kills >= self.MaxKills then break end

				if not (v:IsNPC() or v:IsPlayer() or v:IsNextBot()) then continue end
				if nzombies and v:IsPlayer() then continue end
				if v:Health() <= 0 then continue end
				if v == ply then v:Ignite(1) continue end
				if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
				if nzombies and (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "nz_zombie_boss")) then continue end

				tr.endpos = v:WorldSpaceCenter()
				local tr1 = util.TraceLine(tr)
				if tr1.HitWorld then continue end

				self:Obliterate(v)

				self.Kills = self.Kills + 1
				self.NextAttack = CurTime() + 0.1
				break
			end
		end

		if (self.killtime < CurTime()) or (self.Kills >= self.MaxKills) then
			self:StopSound("TFA_BO3_SUNGOD.Loop")
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode(pos, ang)
	util.ScreenShake(pos, 10, 255, 2, self.Range*2)

	self.Damage = self.mydamage or self.Damage
	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
			if v == self:GetOwner() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end

			self:InflictDamage(v)
		end
	end
end

function ENT:Obliterate(ent)
	local damage = DamageInfo()
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetDamageForce(vector_up)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ParticleEffect("bo3_gersch_kill", ent:WorldSpaceCenter(), angle_zero)

	ent:EmitSound("weapons/tfa_bo3/sungod/exp_emp_rocket_mid.wav", SNDLVL_NORM, math.random(95,105), 1, CHAN_STATIC)
	ent:EmitSound("TFA_BO1_HELLFIRE.Ignite")

	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local distfac = self:GetPos():Distance(ent:GetPos())
	distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
	local fuck = distfac > 0.7 or (ent:Health() - self.mydamage <= 0)

	local damage = DamageInfo()
	damage:SetDamage(fuck and ent:Health() + 666 or self.mydamage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up*math.random(16000,24000) + (ent:GetPos() - self:GetPos()):GetNormalized()*math.random(10000,15000))
	damage:SetDamageType(DMG_SHOCK)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "nz_zombie_boss")) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 8))
	end

	if nzombies and fuck then
		damage:SetDamageForce(vector_up)
		ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
		if ent:OnGround() then
			ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end
	end

	if ent.Ignite then
		ent:Ignite(math.random(4,6))
	end

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound("TFA_BO3_SUNGOD.Loop")

	if self.Charged then
		self:StopSound("TFA_BO3_SUNGOD.Ult.Loop")
		self:StopSound("TFA_BO3_SUNGOD.Ult.Sweet")

		self:EmitSound("TFA_BO3_SUNGOD.Ult.Flux")
		self:EmitSound("TFA_BO3_SUNGOD.Ult.End")
	end

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = 255
			dlight.g = 70
			dlight.b = 100
			dlight.brightness = 4
			dlight.Decay = 2000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.5
		end
	end
end
