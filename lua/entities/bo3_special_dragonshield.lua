
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
ENT.PrintName = "Dragon Shield"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO3_DRAGONSHIELD.Explode"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 140
ENT.RangePaP = 180
ENT.Kills = 0

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end

	self:Explode(data.HitNormal:Angle() - Angle(90,0,0))
	self:Remove()

	self.Impacted = true
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:Explode(self:GetForward():Angle())
		self:Remove()
		self.Impacted = true
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:UseTriggerBounds(true)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetNoDraw(true)

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_dragonshield_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.Range = self.RangePaP
	else
		ParticleEffectAttach("bo3_dragonshield_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end
	self:EmitSound("TFA_BO3_DRAGONSHIELD.Flux")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay
	
	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect(ang)
	ParticleEffect(self:GetUpgraded() and "bo3_dragonshield_impact_2" or "bo3_dragonshield_impact", self:GetPos(), ang)

	util.ScreenShake(self:GetPos(), 10, 5, 1.5, 450)

	self:EmitSound(self.ExplosionSound)
end

function ENT:Explode(ang)
	self:StopParticles()

	local ply = self:GetOwner()
	local tr = {
		start = self:WorldSpaceCenter(),
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(nzombies and DMG_BURN or DMG_SLOWBURN)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if nzombies and v:IsPlayer() then continue end
			if v == self:GetOwner() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			damage:SetDamage(v:Health() + 666)
			damage:SetDamageForce(v:GetUp()*18000 + (v:GetPos() - self:GetPos()):GetNormalized()*16000)
			damage:SetDamagePosition(tr1.Entity == v and tr1.HitPos or tr.endpos)

			if nzombies and v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss") then
				damage:SetDamage(math.max(1200, v:GetMaxHealth()/8))
			end

			v:TakeDamageInfo(damage)

			if IsValid(ply) and ply:IsPlayer() and (v:IsNPC() or v:IsNextBot()) and (damage:GetDamage() >= v:Health()) then
				self.Kills = self.Kills + 1
				if self.Kills == 10 and not ply.bo3dragonshieldac then
					TFA.BO3GiveAchievement("Blown Away", "vgui/overlay/achievment/dragonshield.png", ply)
					ply.bo3dragonshieldac = true
				end

				if nzombies then
					if not ply.DragonShieldFireKills then ply.DragonShieldFireKills = 0 end
					ply.DragonShieldFireKills = ply.DragonShieldFireKills + 1
				end
			end
		end
	end

	self:DoExplosionEffect(ang)
	self:Remove()
end

function ENT:OnRemove()
	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = self:GetUpgraded() and 255 or 40
			dlight.g = self:GetUpgraded() and 20 or 255
			dlight.b = self:GetUpgraded() and 20 or 60
			dlight.brightness = 4
			dlight.Decay = 2000
			dlight.Size = self.Range*2
			dlight.DieTime = CurTime() + 0.5
		end
	end
end