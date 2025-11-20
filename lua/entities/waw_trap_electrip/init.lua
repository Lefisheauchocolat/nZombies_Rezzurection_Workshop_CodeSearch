
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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local pvp_bool = GetConVar("sbox_playershurtplayers")
local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(CONTINUOUS_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)

	self:EmitSound("TFA_WAW_BBETTY.Plant")
	self:OverflowCheck()
	self:CustomActivate()

	sound.EmitHint(SOUND_COMBAT, self:GetPos(), 120, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ply:IsPlayer() then
		SafeRemoveEntityDelayed(self, self.Life)
		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(self) then return end
			ply:AddBuildable(self)
		end)
	end

	self:NextThink(CurTime())
end

function ENT:CustomActivate()
	local tr = {
		start = self:GetAttachment(1).Pos,
		filter = {self, self:GetOwner()},
		mask = MASK_SHOT_HULL,
	}

	local zappers = {}
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:GetClass() == self:GetClass() and not v:GetActivated() then
			tr.endpos = v:GetAttachment(1).Pos
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			table.insert(zappers, v)
		end
	end

	if not table.IsEmpty(zappers) then
		if #zappers > 1 then
			local pos = self:GetPos()
			table.sort(zappers, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
		end
		self:Rope(zappers[1])
	end
end

function ENT:Rope(ent)
	ent.ElectripWire = self
	ent:SetActivateTime(CurTime() + self.Delay)
	ent:SetActivated(true)
	self:SetActivateTime(CurTime() + self.Delay)
	self:SetActivated(true)
	self.ElectripWire = ent

	local HookAtt = Vector(0,0,11)

	local m_RopeLength = self:GetPos():Distance(ent:GetPos())
	local m_Width = 0.5
	local m_Slack = 1
	local m_RopeMat = "cable/cable2"
	local m_Force = 0
	local m_Ridgid = false
	local m_RopeColor = Color(140, 140, 140)

	constraint.Rope(ent, self, 0, 0, HookAtt, HookAtt, m_RopeLength, m_Slack, m_Force, m_Width, m_RopeMat, m_Ridgid, m_RopeColor)
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:Remove()
		return false
	end

	if self:GetActivated() and self:GetActivateTime() < CurTime() then
		if not self.HasEmitSound then
			self:EmitSound("TFA_WAW_ELECTRIP.Start")
			self.HasEmitSound = true
		end

		local zap = self.ElectripWire
		if IsValid(zap) and zap:GetActivated() then
			local tr = util.TraceLine({
				start = self:GetAttachment(1).Pos,
				endpos = zap:GetAttachment(1).Pos,
				filter = {self, zap},
				mask = MASK_SHOT_HULL,
			})

			local ent = tr.Entity
			if IsValid(ent) and ent:Health() > 0 and (ent:IsNPC() or ent:IsNextBot() or (!nzombies and ent:IsPlayer())) then
				self:InflictDamage(ent, tr.HitPos, -tr.HitNormal)
			end

			if not self.NextZap then self.NextZap = CurTime() + math.Rand(0.4,1.2) end
			if self.NextZap < CurTime() then
				self:EmitSound("weapons/tfa_bo3/stormbow/arc_0"..math.random(0,5)..".wav", SNDLVL_NORM, math.random(95,105), 0.5, CHAN_STATIC)
				util.ParticleTracerEx("bo3_waffe_jump", self:GetAttachment(1).Pos, zap:GetAttachment(1).Pos, false, self:EntIndex(), 1)
				self.NextZap = CurTime() + math.Rand(1.2,2.8)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, hitnorm)
	if CLIENT then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then return end
	if ent.ElectripCooldown and ent.ElectripCooldown > CurTime() then return end

	local ply = self:GetOwner()

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(nzombies and ent:Health() + 666 or self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_SHOCK)
	damage:SetDamageForce(hitnorm*math.random(10,20)*100)
	damage:SetDamagePosition(hitpos)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 6))
	end

	if ent == ply then
		damage:SetDamage(25)
	end

	if nzombies then
		ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
		if ent:OnGround() then
			ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end

		ent:EmitSound("TFA_BO3_WAFFE.Zap")
	else
		local fx = EffectData()
		fx:SetMagnitude(12)
		fx:SetStart(hitpos)
		fx:SetEntity(ent)
		util.Effect("TeslaHitboxes", fx)

		ent:EmitSound("ambient/energy/spark" .. math.random(1, 6) .. ".wav")
	end

	ent:EmitSound("TFA_BO3_WAFFE.Sizzle")

	ent.ElectripCooldown = CurTime() + self.Delay
	ent:TakeDamageInfo(damage)

	local ent = self.ElectripWire
	local dmg = math.random(2,4)
	if nzombies then
		dmg = dmg*5
	end

	self:TakeDamage(dmg, self, self)
	if IsValid(ent) then
		ent:TakeDamage(dmg, self, self)
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	local ply = self:GetOwner()

	self:SetHealth(self:Health() - dmginfo:GetDamage())

	if self:Health() <= 0 then
		local ent = self.ElectripWire

		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self:WorldSpaceCenter())
		fx:SetNormal(vector_up)
		fx:SetScale(25)

		util.Effect("cball_explode", fx)

		self:SetActivated(false)
		if IsValid(ent) then
			fx:SetEntity(ent)
			fx:SetOrigin(ent:WorldSpaceCenter())
			util.Effect("cball_explode", fx)

			ent.ElectripWire = nil
			ent:SetActivated(false)
			ent:Remove()
		end

		self:Remove()
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if IsValid(self:GetOwner()) and ply ~= self:GetOwner() then return end

	local ent = self.ElectripWire
	local health = self:Health()
	local max = self:GetMaxHealth()
	local gun = ply:GetWeapon("tfa_waw_electrip")
	if nzombies and (self:GetActivated() and IsValid(gun)) then return end

	local wep = ply:Give("tfa_waw_electrip", true)
	timer.Simple(0, function()
		if not IsValid(wep) then return end
		wep:SetClip2(math.Round(math.Clamp(health / max, 0, 1) * wep.Secondary_TFA.ClipSize))
	end)

	local ammotogive = IsValid(ent) and 2 or 1
	local ammo = "slam"
	if IsValid(wep) then
		ammo = wep:GetPrimaryAmmoType()
	end
	if IsValid(gun) then
		ammo = gun:GetPrimaryAmmoType()
		if (gun:Clip1() > 0 and ply:GetAmmoCount(ammo) >= 1) or ply:GetAmmoCount(ammo) >= 2 then
			ammotogive = 0

			timer.Simple(0, function()
				if not IsValid(self) then return end
				local fx = EffectData()
				fx:SetEntity(self)
				fx:SetOrigin(self:WorldSpaceCenter())
				fx:SetNormal(vector_up*-1)
				fx:SetScale(2)
				fx:SetMagnitude(2)
				fx:SetRadius(2)

				util.Effect("ElectricSpark", fx)
			end)
		end
	end

	ply:GiveAmmo(ammotogive, ammo, false)

	self:Remove()
	return
end
