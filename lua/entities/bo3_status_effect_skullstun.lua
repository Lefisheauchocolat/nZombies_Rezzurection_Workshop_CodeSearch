
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
ENT.Type = "anim"
ENT.PrintName = "Skullgun2 Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3SkullStun = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo3_skullgun2_logic) then
			self.bo3_skullgun2_logic:UpdateDuration(duration)
			return self.bo3_skullgun2_logic
		end

		self.bo3_skullgun2_logic = ents.Create("bo3_status_effect_skullstun")
		self.bo3_skullgun2_logic:SetPos(self:GetPos())
		self.bo3_skullgun2_logic:SetParent(self)
		self.bo3_skullgun2_logic:SetOwner(self)

		self.bo3_skullgun2_logic:Spawn()
		self.bo3_skullgun2_logic:Activate()

		self.bo3_skullgun2_logic:SetAttacker(attacker)
		self.bo3_skullgun2_logic:SetInflictor(inflictor)
		
		self.bo3_skullgun2_logic:SetOwner(self)
		
		self.bo3_skullgun2_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.SkullStunLogic", self.bo3_skullgun2_logic)
		return self.bo3_skullgun2_logic
	end

	hook.Add("PlayerDeath", "BO3.SkullStunLogic", function(self)
		if IsValid(self.bo3_skullgun2_logic) then
			return self.bo3_skullgun2_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.SkullStunLogic", function(self)
		if IsValid(self.bo3_skullgun2_logic) then
			return self.bo3_skullgun2_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.SkullStunLogic", function(self)
			if IsValid(self.bo3_skullgun2_logic) then
				return self.bo3_skullgun2_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsSkullStund = function(self)
	return IsValid(self:GetNW2Entity("BO3.SkullStunLogic"))
end

entMeta.BO3SkullStunEndTime = function(self)
	if not IsValid(self:GetNW2Entity("BO3.SkullStunLogic")) then return nil end
	return self:GetNW2Entity("BO3.SkullStunLogic"):GetSkullStatusEnd()
end

entMeta.BO3SkullStunStartTime = function(self)
	if not IsValid(self:GetNW2Entity("BO3.SkullStunLogic")) then return nil end
	return self:GetNW2Entity("BO3.SkullStunLogic"):GetSkullStatusStart()
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")

	self:NetworkVar("Float", 0, "StatusStart")
	self:NetworkVar("Float", 1, "StatusEnd")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		ParticleEffectAttach("bo3_skull_zomb_kill", PATTACH_POINT_FOLLOW, p, 2)

		if nzombies and p:IsValidZombie() and p.PlaySound then
			p:PlaySound("weapons/tfa_bo3/skullgun/skull_scream_0"..math.random(0,3)..".wav", 80, math.random(95, 105), 0.5, 2)
		else
			if p.GetHullType then
				if p:GetHullType() == HULL_HUMAN then
					p:EmitSound("TFA_BO3_SKULL.Scream")
				end
			else
				p:EmitSound("TFA_BO3_SKULL.Scream")
			end
		end
	end

	self:SetStatusStart(CurTime())

	if CLIENT then return end
	self:TrapNextBot(p)
	self:TrapNPC(p)
	self.finalpos = self:GetPos() + vector_up*math.Rand(15,25)
	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if nzombies and p:IsValidZombie() and not (p.NZBossType or string.find(p:GetClass(), "zombie_boss")) then
		p:Freeze(newtime)
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
	self:SetStatusEnd(self.statusEnd)
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNPC() then
			p:SetGroundEntity(Entity(0))
			p:SetPos(LerpVector(FrameTime()*5, p:GetPos(), self.finalpos))
		end

		local time = 1 + math.random(5)*0.1
		if self:GetStatusEnd() > (self:GetStatusStart() + time) then
			self:InflictDamage(p)
			self:Remove()
			return false
		end
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapNextBot = function(self, bot)
	if nzombies and (bot.NZBossType or string.find(bot:GetClass(), "zombie_boss")) then return end

	if bot:IsNextBot() then
		bot.OldAccel = bot.loco:GetAcceleration()
		bot.OldSpeed = bot.loco:GetDesiredSpeed()

		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)
		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
	end
end

ENT.TrapNPC = function(self, npc)
	if npc:IsNPC() then
		npc:Ignite(0)
		npc:StopMoving()
		npc:SetVelocity(vector_origin)
		npc:SetMoveVelocity(vector_origin)
		npc:SetSchedule(SCHED_NPC_FREEZE)
		npc:Fire("HitByBugbait", math.Rand(0, 2))
	end
end

ENT.InflictDamage = function(self, ent)
	ent:EmitSound("TFA_BO3_GENERIC.Gib")
	ent:EmitSound("TFA_BO3_GENERIC.Lfe")

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetDamagePosition(ent:EyePos())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1600, ent:GetMaxHealth() / 6))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/8) + 1)
	else
		ent:SetHealth(1)
		if nzombies then
			ent:SetNW2Bool("WavePopKilled", true)
		else
			ent:SetNW2Bool("RemoveRagdoll", true)
		end
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	ent:TakeDamageInfo(damage)
	self:Remove()
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if !nzombies and p:Health() <= 0 then
			ParticleEffectAttach("bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		end

		if p:IsPlayer() then
			p:Freeze(false)
		end

		if p:IsNextBot() then
			if nzombies then
				if (p.NZBossType or string.find(p:GetClass(), "zombie_boss")) then return end
				if p:IsValidZombie() and !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			else
				p.loco:SetAcceleration(p.OldAccel)
				p.loco:SetDesiredSpeed(p.OldSpeed)
			end
		end

		if p:IsNPC() then
			p:SetSchedule(SCHED_ALERT_STAND)
		end
	end
end

ENT.Draw = function(self)
end