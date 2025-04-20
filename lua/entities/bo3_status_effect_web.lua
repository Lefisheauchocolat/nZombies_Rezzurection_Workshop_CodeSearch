
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
ENT.PrintName = "Widows Nade Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3SpiderWeb = function(self, duration, attacker)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and string.find(self:GetClass(), "zombie_boss") then return end

		if duration == nil then
			duration = 0
		end
		if duration < 2 then
			duration = 2
		end
		if attacker == nil then
			attacker = self
		end

		if IsValid(self.bo3_webnade_logic) then
			self.bo3_webnade_logic:UpdateDuration(duration)
			return self.bo3_webnade_logic
		end

		self.bo3_webnade_logic = ents.Create("bo3_status_effect_web")
		self.bo3_webnade_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_webnade_logic:SetParent(self)
		self.bo3_webnade_logic:SetOwner(self)
		self.bo3_webnade_logic:SetAttacker(attacker)

		self.bo3_webnade_logic:Spawn()
		self.bo3_webnade_logic:Activate()

		self.bo3_webnade_logic:SetOwner(self)
		self.bo3_webnade_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.WebnadeLogic", self.bo3_webnade_logic)
		return self.bo3_webnade_logic
	end

	hook.Add("OnNPCKilled", "BO3.WebnadeLogic", function(self)
		if IsValid(self.bo3_webnade_logic) then
			return self.bo3_webnade_logic:Remove()
		end
	end)

	if nzombies then
		hook.Add("OnZombieKilled", "BO3.WebnadeLogic", function(self)
			if IsValid(self.bo3_webnade_logic) then
				return self.bo3_webnade_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsWebbed = function(self)
	return IsValid(self:GetNW2Entity("BO3.WebnadeLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		self:EmitSound("TFA_BO3_SPIDERNADE.Loop")
		ParticleEffectAttach("bo3_spidernade_zomb", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		if SERVER then
			self:TrapNextBot(p)
			self:TrapNPC(p)
		end
	end

	if CLIENT then return end
	self.nextattack = CurTime() + math.Rand(1, 2)
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
	if nzombies and IsValid(p) and p:IsValidZombie() then
		p:Freeze(newtime)
	end

	self.duration = newtime + math.Rand(-1,1)
	self.statusEnd = CurTime() + self.duration
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNextBot() then
			p.loco:SetAcceleration(0)
			p.loco:SetDesiredSpeed(0)
			if nzombies and p:IsValidZombie() then
				p:SetBlockAttack(true)
			end
		end

		if self.nextattack < CurTime() then
			self:InflictDamage(p)
			self.nextattack = CurTime() + math.Rand(1.5, 3)
		end
	end

	if self.statusEnd < CurTime() then
		self:StopSound("TFA_BO3_SPIDERNADE.Loop")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
		bot.OldAccel = bot.loco:GetAcceleration()
		bot.OldSpeed = bot.loco:GetDesiredSpeed()

		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)
	end
end

ENT.TrapNPC = function(self, npc)
	if npc:IsNPC() then
		npc:StopMoving()
		npc:SetVelocity(vector_origin)
		npc:SetMoveVelocity(vector_origin)
		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	self:StopSound("TFA_BO3_SPIDERNADE.Loop")
	self:EmitSound("TFA_BO3_SPIDERNADE.End")

	if IsValid(p) then
		p:StopParticles()

		if SERVER then
			if p:IsNextBot() then
				if nzombies then
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
end

ENT.InflictDamage = function(self, ent)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamage(10)
	damage:SetDamageType(DMG_RADIATION)
	damage:SetAttacker(self:GetAttacker())
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if damage:GetDamage() >= ent:Health() and ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent:TakeDamageInfo(damage)
end

ENT.Draw = function(self)
end
