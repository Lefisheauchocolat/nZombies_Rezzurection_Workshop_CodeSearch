
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
ENT.PrintName = "Electric Bolt"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO4_SCORPION.Impact"

--[Parameters]--
ENT.Delay = 10

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Charged")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()

	self:EmitSound(self.ExplosionSound)
	ParticleEffect("bo4_scorpion_impact", data.HitPos - data.HitNormal, data.HitNormal:Angle() - Angle(90,0,0))

	self:SetHitPos(data.HitPos)

	local ent = data.HitEntity
	if not ent:IsWorld() and ent:IsSolid() then
		self:InflictDamage(ent, data.HitPos)
	end

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:EmitSound(self.ExplosionSound)

		if self:GetCharged() and not ent:BO4IsSpinning() and not ent:BO4IsShocked() then
			self.Impacted = true
			ent:BO4Speeen(10, ply, self.Inflictor)
			self:Remove()
		else
			self:InflictDamage(ent, self:GetPos())
		end	
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
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay

	ParticleEffectAttach("bo4_scorpion_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

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

function ENT:InflictDamage(ent, hitpos)
	ParticleEffect("bo4_scorpion_hit", hitpos, self:GetUp():Angle())

	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(self:GetForward()*15000 + ent:GetUp()*2000)
	damage:SetDamageType(DMG_ENERGYBEAM)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 22))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	if nzombies and ent:IsPlayer() then return end
	ent:TakeDamageInfo(damage)

	if (ent:IsNPC() or ent:IsNextBot()) and IsValid(ply) and ply:IsPlayer() then
		if not self.Kills then self.Kills = 0 end

		self.Kills = self.Kills + 1
		if self.Kills == 9 then
			if not ply.bo4scorpachievement then
				TFA.BO3GiveAchievement("Constellation Prize", "vgui/overlay/achievment/Constellation_Prize.png", ply, 1)
				ply.bo4scorpachievement = true
			end
		end
	end
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = 255
			dlight.g = 255
			dlight.b = 50
			dlight.brightness = 3
			dlight.Decay = 2000
			dlight.Size = 128
			dlight.DieTime = CurTime() + 0.2
		end
	end
end