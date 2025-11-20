
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
ENT.PrintName = "Wrath of the Ancients"

--[Parameters]--
ENT.Delay = 12
ENT.Impacted = false

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Mult")
	self:NetworkVar("Float", 1, "Charge")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()

	self:Explode(data.HitPos)
	self:SetHitPos(data.HitPos)

	if self:GetCharge() >= 1 then
		ParticleEffect("bo3_zmbbow_impact_big", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	else	
		ParticleEffect("bo3_zmbbow_impact_small", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	end

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end
	
	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:StopParticles()
		self:Explode(self:GetPos())

		if self:GetCharge() >= 1 then
			ParticleEffect("bo3_zmbbow_impact_big", self:GetPos(), Angle(0,0,0))
		else	
			ParticleEffect("bo3_zmbbow_impact_small", self:GetPos(), Angle(0,0,0))
		end

		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	if self:GetCharge() >= 1 then
		self:EmitSoundNet("TFA_BO3_ZMBBOW.FullCharge")
	end

	ParticleEffectAttach("bo3_zmbbow_trail", PATTACH_POINT_FOLLOW, self, 1)

	self.Range = 200 * self:GetMult()
	self.killtime = CurTime() + self.Delay

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		local vel = phys:GetVelocity()
		phys:SetAngles(vel:Angle())
		phys:SetVelocity(vel)
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

function ENT:Explode(pos)
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	self.Damage = self.mydamage or self.Damage
	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == ply then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v)
		end
	end
	
	util.ScreenShake(pos, 10*self:GetMult(), 255, 1*self:GetMult(), self.Range*1.5)

	self:EmitSound("TFA_BO3_ZMBBOW.Impact")
	self:EmitSound("TFA_BO3_ZMBBOW.Explode")
	if self:GetCharge() >= 1 then
		self:EmitSound("TFA_BO3_ZMBBOW.ExplodeSwt")
	end

	self:Remove()
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamageForce(ent:GetUp()*12000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 16000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(self.Damage, ent:GetMaxHealth() / 16))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/9))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = 255
			dlight.g = 220
			dlight.b = 40
			dlight.brightness = 3
			dlight.Decay = 500
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
end