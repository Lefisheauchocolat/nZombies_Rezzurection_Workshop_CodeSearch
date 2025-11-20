
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
ENT.PrintName = "Wavegun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3Microwave = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and string.find(self:GetClass(), "zombie_boss") then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo3_wavegun_logic) then
			self.bo3_wavegun_logic:UpdateDuration(duration)
			return self.bo3_wavegun_logic
		end

		self.bo3_wavegun_logic = ents.Create("bo3_status_effect_microwave")
		self.bo3_wavegun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_wavegun_logic:SetParent(self)
		self.bo3_wavegun_logic:SetOwner(self)

		self.bo3_wavegun_logic:Spawn()
		self.bo3_wavegun_logic:Activate()

		self.bo3_wavegun_logic:SetAttacker(attacker)
		self.bo3_wavegun_logic:SetInflictor(inflictor)

		self.bo3_wavegun_logic:SetOwner(self)
		self.bo3_wavegun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.WavegunLogic", self.bo3_wavegun_logic)
		return self.bo3_wavegun_logic
	end
end

entMeta.BO3IsCooking = function(self)
	return IsValid(self:GetNW2Entity("BO3.WavegunLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		ParticleEffectAttach(p:GetClass() == "nz_zombie_walker_cyborg" and "bo3_wavegun_eyes_blue" or "bo3_wavegun_eyes", PATTACH_POINT_FOLLOW, p, 2)
		timer.Simple(math.Rand(0,0.5), function()
			if not IsValid(p) then return end
			p:EmitSound("TFA_BO3_WAVEGUN.Microwave.Cook")
		end)
	end

	ParticleEffect("bo3_zapgun_impact_pap", self:GetPos(), Angle(0,0,0))

	if CLIENT then return end
	if not IsValid(p) then self:Remove() return end
	self:TrapNPC(p)
	self:TrapNextBot(p)
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
	if p.Freeze then
		p:Freeze(newtime)
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime + math.Rand(-0.5,0.5)
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if self.statusEnd < CurTime() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
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
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(ent:GetUp()*200)

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	/*local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
	end*/
end

ENT.Draw = function(self)
end
