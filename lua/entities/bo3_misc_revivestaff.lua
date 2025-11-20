
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
ENT.PrintName = "Wind"

--[Sound]--
ENT.PropelSound = Sound("TFA_BO3_STAFF_REV.Loop")

--[Parameters]--
ENT.Delay = 10

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	
	self:StopSound(self.PropelSound)
	self:Revive(data.HitPos)
	
	self:Remove()
	
	self.Impacted = true
end

local AvoidTbl = {
	prop_dynamic = true,
	nz_spawn_zombie_normal = true,
	nz_spawn_zombie_special = true,
	player_spawns = true,
}

function ENT:StartTouch(ent)
	if AvoidTbl[ent:GetClass()] then return end
	if ent == self:GetOwner() then return end
	
	self:StopSound(self.PropelSound)
	self:Revive(self:GetPos())

	self:Remove()
end

function ENT:Revive(pos)
	for k, v in pairs(ents.FindInSphere(pos, 70)) do
		if nzombies then
			if v:IsPlayer() then
				if !v:GetNotDowned() then
					v:Revive()
				else
					v:SetHealth(v:GetMaxHealth())
					v:SetArmor(math.Clamp(v:Armor() + 100, 0, 100))
				end
			end

			if v:IsValidZombie() then
				self:InflictDamage(v)
			end
		else
			if v:IsPlayer() then
				v:SetHealth(v:GetMaxHealth())
				v:SetArmor(math.Clamp(v:Armor() + 100, 0, 100))
			end

			if (v:IsNextBot() or v:IsNPC()) and (v:GetClass():find("zomb") or v:GetClass():find("headcrab")) then
				self:InflictDamage(v)
			end
		end
	end
	
	self:EmitSound("TFA_BO3_STAFF_REV.Impact")
	ParticleEffect("raygun_impact_pap", pos, Angle(0,0,0))

	self:Remove()
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(300000)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_SONIC, DMG_PREVENT_PHYSICS_FORCE))

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(ent:GetMaxHealth() / 12)
		damage:ScaleDamage((10 - nzRound:GetBossData(ent.NZBossType).dmgmul*10) + 1)
	end

	ent:TakeDamageInfo(damage)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)

	self:EmitSoundNet(self.PropelSound)
	
	ParticleEffectAttach("originstaff_revive_proj", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end
	
	self.killtime = CurTime() + self.Delay
	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound(self.PropelSound)
end