AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Electro Sphere"

--[Parameters]--
ENT.Delay = 10

ENT.Range = 200
ENT.RangePaP = 400

ENT.AttackDelay = 0.125
ENT.AttackDelayPaP = 0.1

ENT.MaxKills = 24
ENT.MaxKillsPaP = 48
ENT.MaxHits = 3
ENT.MaxHitsPaP = 4

ENT.NextAttack = 0
ENT.Hits = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Charged")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopSound("TFA.GHOSTS.NX1.Loop")
	self:StopParticles()

	self:SetHitPos(data.HitPos - data.HitNormal)
	self:InflictDamage(data.HitEntity)

	if self:GetCharged() then
		self:Explode(self:GetHitPos())
	else
		if self:GetUpgraded() then
			ParticleEffect("ghosts_nx1_impact_small_2", pos, angle_zero)
		else
			ParticleEffect("ghosts_nx1_impact_small", self:GetPos(), angle_zero)
		end
	end

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		if self:GetCharged() or self.Hits >= self.MaxHits then
			self:StopSound("TFA.GHOSTS.NX1.Loop")
			self:StopParticles()

			self:SetHitPos(self:GetPos())
			self:Explode(self:GetHitPos())

			self:Remove()
		else
			if self:GetUpgraded() then
				ParticleEffect("ghosts_nx1_impact_2", pos, angle_zero)
			else
				ParticleEffect("ghosts_nx1_impact_small", self:GetPos(), angle_zero)
			end

			self.Hits = self.Hits + 1
			self:InflictDamage(ent)
		end
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("ghosts_nx1_trail_charged_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.Range = self.RangePaP
		self.AttackDelay = self.AttackDelayPaP
		self.MaxKills = self.MaxKillsPaP
		self.MaxHits = self.MaxHitsPaP
		self.color = Color(180, 255, 150)
	else
		ParticleEffectAttach(self:GetCharged() and "ghosts_nx1_trail_charged" or "ghosts_nx1_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(50, 150, 255)
	end

	self:EmitSoundNet("TFA.GHOSTS.NX1.Loop")
	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	self.TargetsToIgnore = {}
	self.Kills = 0
	self:SetTrigger(true)
end

function ENT:Think()
	local pos = self:GetPos()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.Dlight = self.Dlight or DynamicLight(self:EntIndex())
		if self.Dlight then
			self.Dlight.pos = pos
			self.Dlight.r = self.color.r
			self.Dlight.g = self.color.g
			self.Dlight.b = self.color.b
			self.Dlight.brightness = 2
			self.Dlight.Decay = 1000
			self.Dlight.Size = 200
			self.Dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self:GetCharged() and self.NextAttack < CurTime() and self.Kills < self.MaxKills then
			local tr = {
				start = pos,
				filter = self,
				mask = MASK_SOLID_BRUSHONLY
			}

			for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == self:GetOwner() then continue end
					if v:Health() <= 0 then continue end
					if v.Alive and not v:Alive() then continue end
					if table.HasValue(self.TargetsToIgnore, v) then continue end

					if self.Kills >= self.MaxKills then
						break
					end

					tr.endpos = v:WorldSpaceCenter()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					self:InflictDamage(v, true)

					self.NextAttack = CurTime() + self.AttackDelay
					break
				end
			end
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode(pos)
	if not self:GetCharged() then return end

	self:StopSound("TFA.GHOSTS.NX1.Loop")
	self:EmitSound("TFA.GHOSTS.NX1.Explode")

	if self:GetUpgraded() then
		ParticleEffect("ghosts_nx1_impact_2", pos, angle_zero)
	else
		ParticleEffect("ghosts_nx1_impact", pos, angle_zero)
	end

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) then
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if !self:VisibleVec(v:GetPos()) then continue end

			self:InflictDamage(v)
		end
	end

	util.ScreenShake(pos, 10, 255, 2.5, self.Range*2)

	self:Remove()
end

function ENT:InflictDamage(ent, kill)
	if not IsValid(ent) then return end
	if not ent:IsSolid() then return end
	if ent:Health() <= 0 then return end
	if ent == self:GetOwner() then return end
	if nzombies and ent:IsPlayer() then return end

	self.Damage = self.mydamage or self.Damage

	if self:GetUpgraded() then
		util.ParticleTracerEx("ghosts_nx1_arc_2", self:GetPos(), ent:EyePos(), false, self:EntIndex(), ent:EntIndex())
	else
		util.ParticleTracerEx("ghosts_nx1_arc", self:GetPos(), ent:EyePos(), false, self:EntIndex(), ent:EntIndex())
	end

	ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
	if ent:OnGround() then
		ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
	end
	if nzombies and ent:IsValidZombie() and not ent.IsMooSpecial then
		ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 3)
		ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 4)
	end

	local damage = DamageInfo()
	damage:SetDamage(kill and ent:Health() + 666 or self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_SHOCK)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 12))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent.NukeGunShocked = true
	ent:TakeDamageInfo(damage)
	ent.NukeGunShocked = nil

	self.Kills = self.Kills + 1
	self.TargetsToIgnore[self.Kills] = ent
end

function ENT:OnRemove()
	self:StopSound("TFA.GHOSTS.NX1.Loop")

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.Dlight = self.Dlight or DynamicLight(self:EntIndex())
		if self.Dlight then
			self.Dlight.pos = self:GetHitPos()
			self.Dlight.r = self.color.r
			self.Dlight.g = self.color.g
			self.Dlight.b = self.color.b
			self.Dlight.brightness = self:GetCharged() and 4 or 2
			self.Dlight.Decay = self:GetCharged() and 1200 or 400
			self.Dlight.Size = self:GetCharged() and 1024 or 256
			self.Dlight.DieTime = CurTime() + 1
		end
	end
end