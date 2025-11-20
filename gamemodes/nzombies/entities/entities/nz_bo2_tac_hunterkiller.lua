
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Hunter Killer Drone"
ENT.NZThrowIcon = Material("vgui/icon/ks_menu_harpie_single_256.png", "unlitgeneric smooth")

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
	self:Explode(data.HitPos - data.HitNormal)

	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if self:GetCreationTime() + engine.TickInterval() > CurTime() then return end
	if not (ent:IsNPC() or ent:IsNextBot()) then return end
	if ent == self:GetOwner() then return end

	self.Impacted = true

	self:StopSound("TFA_BO2_HKDRONE.Loop")
	self:Explode(self:GetPos())

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
				end
				self.NextTargetCheck = CurTime() + 0.25 //wait 0.25;
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
			end

			if self.TargetPos then
				self.Ratio = math.Clamp(self.Ratio + FrameTime(), 0, 1)
				self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), (self.TargetPos - self:GetPos()):Angle()))
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
	local ply = self:GetOwner()
	if not IsValid(ply) then return false end

	local min_cos = (self:GetCreationTime() + 1.2 < CurTime()) and -1 or 0.6
	local targets = {}
	local tr = {
		start = self:GetPos(),
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	if nzLevel then
		for k, v in nzLevel.GetZombieArray() do
			if not IsValid(v) or (v.Alive and not v:Alive()) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			local normal = (v:GetPos() - self:GetPos()):GetNormalized()
			local cosa = self:GetForward():Dot(normal)
			if cosa < min_cos then continue end

			table.insert(targets, v)
		end
	else
		for k, v in pairs(ents.FindInPVS(ply)) do
			if not v:IsValidZombie() then continue end
			if v:Health() <= 0 then continue end
			if v.Alive and not v:Alive() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			local normal = (v:GetPos() - self:GetPos()):GetNormalized()
			local cosa = self:GetForward():Dot(normal)
			if cosa < min_cos then continue end

			table.insert(targets, v)
		end
	end

	if table.IsEmpty(targets) then
		return false
	end

	local targetpos
	local bestrating = -1

	// trace around the enemy to figure out whos in the most open area
	for i, ent in pairs(targets) do
		local currating = 0
		tr.filter = {self, ply, ent}

		tr.endpos = ent:GetPos() + vector_up
		local t1 = util.TraceLine(tr)
		if not t1.Hit then
			currating = currating + 4
		end

		tr.endpos = ent:EyePos()
		local t2 = util.TraceLine(tr)
		if not t2.Hit then
			currating = currating + 3
		end

		tr.start = ent:GetPos()
		tr.endpos = ent:EyePos() + vector_up*96
		local t3 = util.TraceLine(tr)
		if not t3.Hit then
			currating = currating + 2
		end

		if currating > bestrating then
			bestrating = currating
			targetpos = ent:GetPos() + vector_up

			if bestrating >= 9 then
				return targetpos
			end
		end
	end

	//if its open enough, attack
	if bestrating >= 3 then
		return targetpos
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

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_ENERGYBEAM)

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if IsValid(ply) and v:IsNPC() and v:Disposition(ply) == D_LI then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and v ~= ply then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			damage:SetDamage(v:Health() + 666)
			damage:SetDamagePosition(v:WorldSpaceCenter())
			damage:SetDamageForce(v:GetUp()*math.random(12000,16000) + (v:GetPos() - pos):GetNormalized()*math.random(8000,14000))

			if v:IsPlayer() then
				local distfac = pos:Distance(v:GetPos())
				distfac = 1 - math.Clamp((distfac/self.Range), 0, 0.8)
				damage:SetDamage(120 * distfac)
			end

			if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then
				damage:SetDamage(math.max(1200, v:GetMaxHealth() / 8))
			end

			if v:IsNPC() then v:SetSchedule(SCHED_ALERT_STAND) end
			v:TakeDamageInfo(damage)
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

