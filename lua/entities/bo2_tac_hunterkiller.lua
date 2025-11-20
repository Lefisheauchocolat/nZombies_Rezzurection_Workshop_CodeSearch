AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Hunter Killer Drone"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO3_GRENADE.Flux"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 220
ENT.ActivateDelay = 0.5
ENT.Activated = false //dont touch

ENT.Ratio = 0 //dont touch
ENT.CurveStrengthMin = 1
ENT.CurveStrengthMax = 2

ENT.BaseSpeed = 500
ENT.MaxSpeed = 2000
ENT.AccelerationTime = 0.5
ENT.AccelProgress = 0 //dont touch

DEFINE_BASECLASS(ENT.Base)

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopSound("TFA_BO2_HKDRONE.Loop")
	self:Explode(data.HitPos)

	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if not (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then return end
	self.Impacted = true

	self:StopSound("TFA_BO2_HKDRONE.Loop")
	self:Explode(self:GetTouchTrace().HitPos)

	self:Remove()
end

function ENT:CreateRocketTrail()
	if not SERVER then return end

	local rockettrail = ents.Create("env_rockettrail")
	rockettrail:DeleteOnRemove(self)

	rockettrail:SetPos(self:GetPos() - self:GetForward()*12)
	rockettrail:SetAngles(self:GetAngles())
	rockettrail:SetParent(self)
	rockettrail:SetMoveType(MOVETYPE_NONE)
	rockettrail:AddSolidFlags(FSOLID_NOT_SOLID)

	rockettrail:SetSaveValue("m_Opacity", 0.2)
	rockettrail:SetSaveValue("m_SpawnRate", 200)
	rockettrail:SetSaveValue("m_ParticleLifetime", 1)
	rockettrail:SetSaveValue("m_StartColor", Vector(0.1, 0.1, 0.1))
	rockettrail:SetSaveValue("m_EndColor", Vector(1, 1, 1))
	rockettrail:SetSaveValue("m_StartSize", 16)
	rockettrail:SetSaveValue("m_EndSize", 32)
	rockettrail:SetSaveValue("m_SpawnRadius", 4)
	rockettrail:SetSaveValue("m_MinSpeed", 16)
	rockettrail:SetSaveValue("m_MaxSpeed", 32)
	rockettrail:SetSaveValue("m_nAttachment", 1)
	rockettrail:SetSaveValue("m_flDeathTime", CurTime() + self.Delay)

	rockettrail:Activate()
	rockettrail:Spawn()

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		local pvcol = ply:GetPlayerColor()
		local pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)

		util.SpriteTrail(self, 2, pcolor, true, 2, 0, 0.4, 0.1, "effects/laser_citadel1")
		util.SpriteTrail(self, 3, pcolor, true, 2, 0, 0.4, 0.1, "effects/laser_citadel1")
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)
	self.AutomaticFrameAdvance = true
	self:ResetSequence("deploy")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self:EmitSound("TFA_BO2_HKDRONE.Launch")
	self:EmitSound("TFA_BO2_HKDRONE.Switch")

	self.killtime = CurTime() + self.Delay
	self.NextTargetCheck = CurTime() + self.ActivateDelay

	self:NextThink(CurTime())

	if CLIENT then return end
	util.SpriteTrail(self, 1, Color(90,90,90,60), true, 4, 1, 0.6, 0.1, "trails/smoke")
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if not self.Activated and (self:GetCreationTime() + self.ActivateDelay < CurTime()) then
			self:EmitSound("TFA_BO2_HKDRONE.Loop")
			self.Activated = true
			self:CreateRocketTrail()
		end

		if self.Activated then
			if self.NextTargetCheck < CurTime() then
				self.TargetPos = self:FindTargetPosition()
				if self.TargetPos and not self.HasEmitSound then
					self:EmitSound("TFA_BO2_HKDRONE.Target")
					self.HasEmitSound = true
					sound.EmitHint(SOUND_DANGER, self.TargetPos, self.Range, 0.5, IsValid(self:GetOwner()) and self:GetOwner() or self)
				end
				self.NextTargetCheck = CurTime() + 0.25
			end

			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				if self.AccelerationTime > 0 and self.AccelProgress < 1 then
					self.LastAccelThink = self.LastAccelThink or CurTime()
					self.AccelProgress = Lerp((CurTime() - self.LastAccelThink) / self.AccelerationTime, self.AccelProgress, 1)
				end

				phys:SetVelocity(self:GetForward() * Lerp(self.AccelProgress, self.BaseSpeed, (self:WaterLevel() > 0 and self.MaxSpeed/2 or self.MaxSpeed)))
				phys:AddAngleVelocity(VectorRand() * (math.sin(CurTime() * 30)) * math.random(self.CurveStrengthMin, self.CurveStrengthMax))

				self:SetAngles(phys:GetVelocity():Angle())

				if self.TargetPos then
					self.Ratio = math.Clamp(self.Ratio + FrameTime(), 0, 1)
					self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), (self.TargetPos - self:GetPos()):Angle()))
				end
			end
		end

		if self.killtime < CurTime() then
			self:StopSound("TFA_BO2_HKDRONE.Loop")
			self:Explode(self:GetPos())
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FindTargetPosition()
	local pos = self:GetPos()
	local ply = self:GetOwner()

	local min_cos = (self:GetCreationTime() + 1 < CurTime()) and -1 or 0.6 // ~53 degrees
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, 1600)) do
		if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if v:Health() <= 0 then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			local normal = (v:GetPos() - self:GetPos()):GetNormalized()
			local cosa = self:GetForward():Dot(normal)
			if cosa < min_cos then continue end

			return v:GetPos()
		end
	end

	return false
end

function ENT:DoExplosionEffect()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	self:EmitSound(self.ExplosionSound1)
	self:EmitSound(self.ExplosionSound2)
	self:EmitSound(self.ExplosionSound3)
	self:EmitSound(self.ExplosionSound4)
end

function ENT:Explode(pos)
	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			if v:IsPlayer() then
				local distfac = pos:Distance(v:GetPos())
				distfac = 1 - math.Clamp((distfac/self.Range), 0, 1)
				damage:SetDamage(200 * distfac)
			end

			damage:SetDamageForce(v:GetUp()*15000 + (v:GetPos() - pos):GetNormalized() * 10000)

			if v:IsNPC() then v:SetSchedule(SCHED_ALERT_STAND) end
			v:TakeDamageInfo(damage)

			if v:IsPlayer() then
				damage:SetDamage(self.Damage)
			end
		end
	end

	util.ScreenShake(pos, 10, 255, 1.5, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound("TFA_BO2_HKDRONE.Loop")
	self:StopSound("TFA_BO2_HKDRONE.Target")

	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 190
			dlight.b = 50
			dlight.brightness = 4
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end
end

