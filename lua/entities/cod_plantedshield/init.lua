
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

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionBounds(Vector(-10,-10, 0), Vector(10, 10, 42))
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetUseType(SIMPLE_USE)

	self:EmitSound("TFA_BO2_SHIELD.ZMPlant")
	self:SetDestroyed(false)

	local health = self:Health()/self:GetMaxHealth()
	if health < 0.3 then
		self:SetBodygroup(0, 2)
		self.Damage = 2
	elseif health < 0.6 then
		self:SetBodygroup(0, 1)
		self.Damage = 1
	else
		self:SetBodygroup(0, 0)
		self.Damage = 0
	end

	if nzombies then
		self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		for k, v in pairs(ents.FindByClass("cod_plantedshield")) do
			if v:GetOwner() == self:GetOwner() and v ~= self then
				v:SetHealth(1)
				v:TakeDamage(666, self, self)
			end
		end
	end

	if CLIENT then return end
	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ply:IsPlayer() then
		ply.NextTrapUse = CurTime() + 0.5 //use delay
		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(self) then return end
			ply:AddBuildable(self)
		end)
	end

	if not util.IsInWorld(self:GetPos()) and IsValid(self:GetOwner()) then
		self:SetPos(self:GetOwner():GetPos())
	end
	self:SetTrigger(true)
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	local ratio = 0.2
	local bonus = 0.5
	local dmg = dmginfo:GetDamage() * ratio
	local newdmg = (dmginfo:GetDamage() - dmg) * bonus
	local damage = math.min(newdmg, 100)

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ply:HasPerk("amish") then
		damage = damage * 0.5
	end

	self:SetHealth(self:Health() - damage)

	local dmgtype = dmginfo:GetDamageType()
	if IsValid(ply) and self:GetElectrified() and attacker ~= self and TFA.ShieldDamageTypes[dmgtype] and bit.band(dmgtype, DMG_SHOCK) == 0 then
		self:ShockBlock(ply, attacker, dmginfo)
	end

	if self:Health() <= 0 then
		if IsValid(ply) then
			ply:EmitSound("TFA_BO2_SHIELD.Break")
		end
		self:SetDestroyed(true)
		self:Remove()
	else
		self:EmitSound("TFA_BO2_SHIELD.Hit")

		local pct = self:Health()/self:GetMaxHealth()
		if pct < 0.3 then
			self:SetBodygroup(0, 2)
			self.Damage = 2
		elseif pct < 0.6 then
			self:SetBodygroup(0, 1)
			self.Damage = 1
		else
			self:SetBodygroup(0, 0)
			self.Damage = 0
		end
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if ply ~= self:GetOwner() then return end
	if ply.NextTrapUse and ply.NextTrapUse > CurTime() then return end
	if IsValid(ply:GetShield()) then return end

	ply.NextTrapUse = CurTime() + 0.5
	ply:Give(self:GetShieldClass())
	self:EmitSound("TFA_BO2_SHIELD.Pickup")

	local health = self:Health()
	local max = self:GetMaxHealth()
	local shield = ply:GetShield()
	local damage = self.Damage

	local electrified = self:GetElectrified()
	local elechits = self:GetElectricHits()

	timer.Simple(0, function()
		if not IsValid(ply) then return end
		if not IsValid(shield) then return end

		shield:SetHealth(health)
		shield:SetMaxHealth(max)
		shield:SetBodygroup(0,damage)

		local wep = shield:GetWeapon()
		if IsValid(wep) then
			wep:SetDamage(damage)
			wep:SetClip1(math.Round(math.Clamp(health / max, 0, 1) * wep.Primary_TFA.ClipSize))
			if electrified and wep.Electrify then
				wep:Electrify(elechits)
			end
		end
	end)

	self:Remove()
end

//Electric shield shit
function ENT:ShockBlock(ply, ent, dmginfo)
	if CLIENT then return end
	if not IsValid(ply) or not IsValid(ent) then return end
	if not dmginfo then return end

	if ent.WasShockedThisTick then return end //shitty protection against inf loops
	if nzombies and !ent:IsValidZombie() then return end

	local hurtpos = dmginfo:GetReportedPosition()
	if hurtpos == vector_origin then
		hurtpos = ent:IsPlayer() and ent:GetShootPos() or ent:EyePos()
	end
	
	local dmgpos = dmginfo:GetDamagePosition()
	if dmgpos == vector_origin then
		dmgpos = self:GetPos() + self:OBBCenter()*1.5
	end

	local shockdmg = DamageInfo()
	shockdmg:SetDamage(self.ElectricHitDamage or 15)
	shockdmg:SetAttacker(ply)
	shockdmg:SetInflictor(self)
	shockdmg:SetDamageType(DMG_SHOCK)
	shockdmg:SetDamagePosition(hurtpos)
	shockdmg:SetReportedPosition(ply:GetShootPos())
	shockdmg:SetDamageForce(dmginfo:GetDamageForce()*-1.5)

	if nzombies and (ent:Health() - shockdmg:GetDamage()) > 0 then
		if ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss") then
			shockdmg:SetDamage(math.max(200, ent:GetMaxHealth() / 18))
		elseif ent.TempBehaveThread and ent.SparkySequences then
			ParticleEffectAttach("bo3_shield_electrify_zomb", PATTACH_ABSORIGIN_FOLLOW, ent, 2)
			if ent.PlaySound and ent.ElecSounds then
				ent:PlaySound(ent.ElecSounds[math.random(#ent.ElecSounds)], ent.SoundVolume or SNDLVL_NORM, math.random(ent.MinSoundPitch, ent.MaxSoundPitch), 1, 2)
			end

			ent:TempBehaveThread(function(ent)
				local seq = ent.SparkySequences[math.random(#ent.SparkySequences)]
				local id, time = ent:LookupSequence(seq)
				ent:PlaySequenceAndWait(seq)
				ent:StopParticles()
			end)
		end
	end

	ent.WasShockedThisTick = true
	ent:EmitSound("weapons/physcannon/superphys_small_zap"..math.random(4)..".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
	util.ParticleTracerEx("bo3_waffe_jump", dmgpos, hurtpos, false, self:EntIndex(), 0)

	ent:TakeDamageInfo(shockdmg)

	timer.Simple(0, function()
		if not IsValid(ent) then return end
		ent.WasShockedThisTick = nil
	end)

	self:SetElectricHits(self:GetElectricHits() + 1)
	if self:GetElectricHits() >= (self.ElectricHitsMax or 6) then
		self:DeElectrify()
	end
end

function ENT:Electrify(amount)
	if self:GetElectrified() then return end
	self:SetElectrified(true)
	self:SetElectricHits(amount or 0)
	self.LoopSoundID = self:StartLoopingSound("weapons/tfa_ghosts/teslatrap/loop_00.wav")
end

function ENT:DeElectrify(nosound)
	if !self:GetElectrified() then return end
	self:SetElectrified(false)
	self:SetElectricHits(0)
	if self.LoopSoundID then
		self:StopLoopingSound(self.LoopSoundID)
		self.LoopSoundID = nil
	end
	if !nosound then
		self:EmitSound("weapons/tfa_bo2/etrap/electrap_stop.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
	end
	self:StopParticles()
end