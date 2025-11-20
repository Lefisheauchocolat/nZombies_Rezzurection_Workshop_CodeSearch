
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
ENT.PrintName = "Alistairs Tornado Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Tornado = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and string.find(self:GetClass(), "nz_zombie_boss") then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo4_alitornado_logic) then
			self.bo4_alitornado_logic:UpdateDuration(duration)
			return self.bo4_alitornado_logic
		end

		self.bo4_alitornado_logic = ents.Create("bo4_status_effect_tornado")
		self.bo4_alitornado_logic:SetPos(self:GetPos())
		self.bo4_alitornado_logic:SetParent(self)
		self.bo4_alitornado_logic:SetOwner(self)

		self.bo4_alitornado_logic:Spawn()
		self.bo4_alitornado_logic:Activate()

		self.bo4_alitornado_logic:SetAttacker(attacker)
		self.bo4_alitornado_logic:SetInflictor(inflictor)

		self.bo4_alitornado_logic:SetOwner(self)
		self.bo4_alitornado_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.TornadoLogic", self.bo4_alitornado_logic)
		return self.bo4_alitornado_logic
	end
	hook.Add("PlayerDeath", "BO4.TornadoLogic", function(self)
		if IsValid(self.bo4_alitornado_logic) then
			return self.bo4_alitornado_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.TornadoLogic", function(self)
		if IsValid(self.bo4_alitornado_logic) then
			return self.bo4_alitornado_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.TornadoLogic", function(self)
			if IsValid(self.bo4_alitornado_logic) then
				self.bo4_alitornado_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsTornado = function(self)
	return IsValid(self:GetNW2Entity("BO4.TornadoLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if SERVER and IsValid(p) then
		if p:IsNextBot() then
			p:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			p.loco:SetDesiredSpeed(0)
			p.loco:SetAcceleration(0)
			//p.loco:SetVelocity(vector_origin)
		end

		if nzombies and p:IsValidZombie() then
			p:SetBlockAttack(true)
		end
	end

	if CLIENT then return end
	self.gibtime = 1 + math.Rand(-0.25,0.25)
	self.gibtime1 = 2 + math.Rand(-0.25,0.25)
	self.gibtime2 = 3 + math.Rand(-0.25,0.25)
	self.gibtime3 = 4 + math.Rand(-0.25,0.25)

	self.statusStart = CurTime()
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

    self.duration = newtime
    self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if nzombies then
		if IsValid(p) and p.GibRandom and !p.IsMooSpecial then
			if (self.statusStart + self.gibtime) < CurTime() then
				self:GibArmL(p)
			end
			if (self.statusStart + self.gibtime1) < CurTime() then
				self:GibArmR(p)
			end
			if (self.statusStart + self.gibtime2) < CurTime() then
				self:GibLegL(p)
			end
			if (self.statusStart + self.gibtime3) < CurTime() then
				self:GibLegR(p)
			end
		end
	end

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

ENT.GibArmL = function(self, ent)
	if not IsValid(ent) then return end
	if not ent.DeflateBones then return end
	if ent.LArmOff then return end
	ent.LArmOff = true

	if nzombies then
		local ply = self:GetAttacker()
		if IsValid(ply) and ply:IsPlayer() then
			ply:GivePoints(10)
		end
	end
	local lelbone = ent:LookupBone("j_elbow_le")
	if lelbone then
		ent:DeflateBones({
			"j_elbow_le",
			"j_wrist_le",
			"j_wristtwist_le",
			"j_thumb_le_1",
			"j_thumb_le_2",
			"j_thumb_le_3",
			"j_index_le_1",
			"j_index_le_2",
			"j_index_le_3",
			"j_mid_le_1",
			"j_mid_le_2",
			"j_mid_le_3",
			"j_ring_le_1",
			"j_ring_le_2",
			"j_ring_le_3",
			"j_pinky_le_1",
			"j_pinky_le_2",
			"j_pinky_le_3",
		})

		ent:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(3)..".mp3",100)
		if not ent.MarkedForDeath then
			ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 5)
		end
	end
end

ENT.GibArmR = function(self, ent)
	if not IsValid(ent) then return end
	if not ent.DeflateBones then return end
	if ent.RArmOff then return end
	ent.RArmOff = true

	if nzombies then
		local ply = self:GetAttacker()
		if IsValid(ply) and ply:IsPlayer() then
			ply:GivePoints(10)
		end
	end
	local relbone = ent:LookupBone("j_elbow_ri")
	if relbone then
		ent:DeflateBones({
			"j_elbow_ri",
			"j_wrist_ri",
			"j_wristtwist_ri",
			"j_thumb_ri_1",
			"j_thumb_ri_2",
			"j_thumb_ri_3",
			"j_index_ri_1",
			"j_index_ri_2",
			"j_index_ri_3",
			"j_mid_ri_1",
			"j_mid_ri_2",
			"j_mid_ri_3",
			"j_ring_ri_1",
			"j_ring_ri_2",
			"j_ring_ri_3",
			"j_pinky_ri_1",
			"j_pinky_ri_2",
			"j_pinky_ri_3",
		})

		ent:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(3)..".mp3",100)
		if not ent.MarkedForDeath then
			ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 6)
		end
	end
end

ENT.GibLegL = function(self, ent)
	if not IsValid(ent) then return end
	if not ent.DeflateBones then return end
	if ent.LlegOff then return end

	if nzombies then
		local ply = self:GetAttacker()
		if IsValid(ply) and ply:IsPlayer() then
			ply:GivePoints(10)
		end
	end
	local lleg = ent:LookupBone("j_knee_le")
	if lleg then
		ent.LlegOff = true
		ent:DeflateBones({
			"j_knee_le",
			"j_knee_bulge_le",
			"j_ankle_le",
			"j_ball_le",
		})

		ent:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(3)..".mp3",100)
		if not ent.MarkedForDeath then
			ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 7)
		end
	end
end

ENT.GibLegR = function(self, ent)
	if not IsValid(ent) then return end
	if not ent.DeflateBones then return end
	if ent.RlegOff then return end

	if nzombies then
		local ply = self:GetAttacker()
		if IsValid(ply) and ply:IsPlayer() then
			ply:GivePoints(10)
		end
	end
	local rleg = ent:LookupBone("j_knee_ri")
	if rleg then
		ent.RlegOff = true
		ent:DeflateBones({
			"j_knee_ri",
			"j_knee_bulge_ri",
			"j_ankle_ri",
			"j_ball_ri",
		})

		ent:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(3)..".mp3",100)
		if not ent.MarkedForDeath then
			ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 8)
		end
	end
end

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if nzombies and ent.GibHead then ent:GibHead() end
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if SERVER and IsValid(p) and nzombies and p:IsValidZombie() then
		if !p.IgnoreBlockAttackReset then
			p:SetBlockAttack(false)
		end
		p.loco:SetAcceleration(p.Acceleration)
		p.loco:SetDesiredSpeed(p:GetRunSpeed())
	end
end