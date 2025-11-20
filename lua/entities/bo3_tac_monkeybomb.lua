
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
ENT.PrintName = "Monkey Bomb"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO3_GRENADE.Flux"

ENT.MonkeySong = "TFA_BO3_MNKEY.Song"
ENT.MonkeySongPAP = "TFA_BO3_MNKEY.Upg.Song"

--[Parameters]--
ENT.Burning = false
ENT.Delay = 7.5
ENT.DelayPAP = 8.5
ENT.ExplDelay = 6
ENT.ExplDelayPAP = 7

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self:EmitSound("TFA_BO3_MNKEY.VOX.Bounce")
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:ResetSequence("play")
	self.NextScream = CurTime() + 0.35

	local mins, maxs = self:GetModelBounds()
	mins, maxs = self:LocalToWorld(mins), self:LocalToWorld(maxs)

	for _, ent in pairs(ents.FindInBox(mins, maxs)) do
		if ent:GetClass() == "trigger_hurt" and ent:GetInternalVariable('damagetype') == DMG_BURN then
			self.Burning = true
			self:Ignite(self.Delay)
			break
		end
	end

	self:EmitSound(self.Burning and "TFA_BO3_MNKEY.VOX.Scream" or self.MonkeySong)
	
	self.killtime = CurTime() + self.Delay
	self.soundtime = CurTime() + self.ExplDelay

	ParticleEffectAttach("bo3_monkeybomb_glow", PATTACH_POINT_FOLLOW, self, 1)
	ParticleEffectAttach("bo3_monkeybomb_blink", PATTACH_POINT_FOLLOW, self, 2)
	self:SetActivated(true)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.AutomaticFrameAdvance = true
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")
	self:SetSkin(self:GetUpgraded() and 1 or 0)
	self:SetRoll(self:GetAngles())

	self:EmitSoundNet(self:GetUpgraded() and "TFA_BO3_MNKEY.VOX.Upg.Throw" or "TFA_BO3_MNKEY.VOX.Throw")

	self.Delay = self:GetUpgraded() and self.DelayPAP or self.Delay
	self.ExplDelay = self:GetUpgraded() and self.ExplDelayPAP or self.ExplDelay
	self.MonkeySong = self:GetUpgraded() and self.MonkeySongPAP or self.MonkeySong

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)

	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 20)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) and self:GetActivated() then
			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = 245
			dlight.g = 245
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 128
			dlight.DieTime = CurTime() + 0.1
		end
	end

	if SERVER then
		if self:GetActivated() then
			self:MonkeyBombNXB()
			self:MonkeyBomb()
		end

		if self.NextScream and self.NextScream < CurTime() and not self.HasEmitSound and self:GetUpgraded() then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 32)) do
				if not v:IsWorld() and v:IsSolid() then
					if v == self:GetOwner() then continue end
					if v:Health() <= 0 then continue end

					self:InflictDamage(v)
				end
			end

			ParticleEffect("bo3_monkeybomb_pap", self:WorldSpaceCenter(), Angle(0,0,0))
			self.NextScream = CurTime() + 1/2
		end

		if self:GetActivated() and self.soundtime < CurTime() and not self.HasEmitSound and not self.Burning then
			self.HasEmitSound = true
			//self:ResetSequence("death")

			self:EmitSound(self:GetUpgraded() and "TFA_BO3_MNKEY.VOX.Upg.Explode" or "TFA_BO3_MNKEY.VOX.Explode")
		end

		if self:GetActivated() and self.killtime < CurTime() then
			self:Explode()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
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

function ENT:Explode()
	self:StopSound("TFA_BO3_MNKEY.Scream")

	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v)
		end
	end

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:InflictDamage(ent)
	if CLIENT then return end

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*18000 + (ent:GetPos() - self:GetPos()):GetNormalized()*16000)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(damage)
end

function ENT:MonkeyBomb()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNPC() then
			if v:GetEnemy() ~= self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetEnemy(self)
			end

			v:UpdateEnemyMemory(self, self:GetPos())
			v:SetSaveValue("m_vecLastPosition", self:GetPos())
			v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function ENT:MonkeyBombNXB()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNextBot() then
			v.loco:FaceTowards(self:GetPos())
			v.loco:Approach(self:GetPos(), 99)
			if v.SetEnemy then
				v:SetEnemy(self)
			end
		end
	end
end

function ENT:OnRemove()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 4096)) do
			if v:IsNPC() and v:GetEnemy() == self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end
end
