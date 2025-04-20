
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
ENT.PrintName = "Portal Pull Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3PortalPull = function(self, duration, attacker, inflictor, vector)
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
		if vector == nil then
			vector = vector_origin
		end

		if IsValid(self.bo3_portalpull_logic) then
			self.bo3_portalpull_logic:UpdateDuration(duration)
			return self.bo3_portalpull_logic
		end

		self.bo3_portalpull_logic = ents.Create("bo3_status_effect_portalpull")
		self.bo3_portalpull_logic:SetPos(self:GetPos())
		self.bo3_portalpull_logic:SetParent(self)
		self.bo3_portalpull_logic:SetOwner(self)
		self.bo3_portalpull_logic:SetEndPos(vector)
		self.bo3_portalpull_logic:SetAttacker(attacker)
		self.bo3_portalpull_logic:SetInflictor(inflictor)

		self.bo3_portalpull_logic:Spawn()
		self.bo3_portalpull_logic:Activate()

		self.bo3_portalpull_logic:SetOwner(self)

		self.bo3_portalpull_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.PortalPullLogic", self.bo3_portalpull_logic)
		return self.bo3_portalpull_logic
	end

	hook.Add("PlayerDeath", "BO3.PortalPullLogic", function(self)
		if IsValid(self.bo3_portalpull_logic) then
			return self.bo3_portalpull_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.PortalPullLogic", function(self)
		if IsValid(self.bo3_portalpull_logic) then
			return self.bo3_portalpull_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.PortalPullLogic", function(self)
			if IsValid(self.bo3_portalpull_logic) then
				return self.bo3_portalpull_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsPulledIn = function(self)
	return IsValid(self:GetNW2Entity("BO3.PortalPullLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
	self:NetworkVar("Vector", 0, "EndPos")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()

	if CLIENT then return end
	if not p:IsPlayer() then
		//p:PhysicsDestroy()
		p.OldCollision = p:GetCollisionGroup()
		p:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end
	self:TrapNextBot(p)
	self:TrapNPC(p)
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
	self.statusEnd = self.statusEnd + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		local fraction = 1 - math.Clamp((self.statusEnd - CurTime()) / self.duration, 0, 1)
		local rate = fraction * (self.duration * engine.TickInterval()) * 2

		if p:IsNPC() then
			p:SetSchedule(SCHED_NPC_FREEZE)
			p:SetGroundEntity(Entity(0))
			p:SetPos(LerpVector(rate, p:GetPos(), self:GetEndPos()))
		end

		if p:IsNextBot() then
			p:SetGroundEntity(Entity(0))

			if p:GetPos().z < self:GetEndPos().z then
				p:SetPos(LerpVector(fraction, p:GetPos(), p:GetPos() + p:OBBCenter()))
			end

			p:SetPos(LerpVector(rate, p:GetPos(), self:GetEndPos()))
			p.loco:SetVelocity((self:GetEndPos() - self:GetPos()):GetNormalized() * 30)
		end

		if self:GetPos():DistToSqr(self:GetEndPos()) <= 576 then
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
	if bot:IsNextBot() then
		bot:SetGroundEntity(nil)
		//bot:SetPos(bot:GetPos() + bot:GetUp()*24)

		bot.loco:SetGravity(0)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
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

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamage(ent:Health() + 666)

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:EmitSound("TFA_BO3_IDGUN.Portal.CrushEnd")
	ent:SetHealth(1) //thanku jen
	ent:TakeDamageInfo(damage)
	//ent:Remove()
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		self:InflictDamage(p)
		if p.OldCollision then
			p:SetCollisionGroup(p.OldCollision)
		end
	end
end

ENT.Draw = function(self)
end