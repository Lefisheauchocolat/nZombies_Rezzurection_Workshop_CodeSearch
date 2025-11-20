
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
ENT.PrintName = "Nano Swarm Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OPAQUE
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.AWNanoSwarm = function(self, duration, attacker, inflictor, damagedelay, damageratio, damage)
		if self:GetCreationTime() + 0.5 > CurTime() then return end
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if damagedelay == nil then
			damagedelay = 0.2
		end
		if damageratio == nil then
			damageratio = 0.01
		end
		if damage == nil then
			damage = nzombies and 75 or 5
		end

		if IsValid(self.aw_nanoswarm_logic) then
			self.aw_nanoswarm_logic:UpdateDuration(duration)
			return self.aw_nanoswarm_logic
		end

		local hitboxid
		local bone = self:LookupBone("j_spineupper") or self:LookupBone("ValveBiped.Bip01_Pelvis")
		if !bone then
			for i = 0, self:GetHitBoxCount(0) do
				local hitgroup = self:GetHitBoxHitGroup(i,0)
				if (hitgroup == HITGROUP_GENERIC) or (hitgroup == HITGROUP_STOMACH) then
					hitboxid = i
					bone = self:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		self.aw_nanoswarm_logic = ents.Create("aw_status_effect_nanoswarm")
		self.aw_nanoswarm_logic:SetPos(bone and self:GetPos() or self:WorldSpaceCenter())

		if bone then
			self.aw_nanoswarm_logic:FollowBone(self, bone)
		else
			self.aw_nanoswarm_logic:SetParent(self)
		end

		self.aw_nanoswarm_logic:SetOwner(self)

		if inflictor == nil then
			inflictor = self.aw_nanoswarm_logic
		end

		self.aw_nanoswarm_logic.Attacker = attacker
		self.aw_nanoswarm_logic.Inflictor = inflictor
		self.aw_nanoswarm_logic.DOTDelay = damagedelay
		self.aw_nanoswarm_logic.DamageRatio = damageratio
		self.aw_nanoswarm_logic.Damage = damage

		if hitboxid then
			self.aw_nanoswarm_logic.HitBoxID = hitboxid
		end

		self.aw_nanoswarm_logic:Spawn()
		self.aw_nanoswarm_logic:Activate()

		self.aw_nanoswarm_logic:SetOwner(self)
		self.aw_nanoswarm_logic:UpdateDuration(duration)
		self:SetNW2Entity("AW.NanoSwarmLogic", self.aw_nanoswarm_logic)
		return self.aw_nanoswarm_logic
	end

	hook.Add("OnNPCKilled", "AW.NanoSwarmLogic", function(self)
		if IsValid(self.aw_nanoswarm_logic) then
			return self.aw_nanoswarm_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "AW.NanoSwarmLogic", function(self)
			if IsValid(self.aw_nanoswarm_logic) then
				return self.aw_nanoswarm_logic:Remove()
			end
		end)
	end
end

entMeta.AWIsNanoSwarmed = function(self)
	return IsValid(self:GetNW2Entity("AW.NanoSwarmLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetModel("models/dav0r/hoverball.mdl")
	//self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)

	if CLIENT then return end

	local p = self:GetParent()
	if IsValid(p) and p:IsNextBot() then
		if not p.OldAccel then
			p.OldAccel = p.loco:GetAcceleration()
			p.OldSpeed = p.loco:GetDesiredSpeed()
		end
		if nzombies and p:IsValidZombie() then
			p:SetRunSpeed(1)
			p:SpeedChanged()
		else
			p.loco:SetAcceleration(math.min(p.OldAccel, 15))
			p.loco:SetDesiredSpeed(math.min(p.OldSpeed, 15))
		end
	end

	if IsValid(p) and p:IsNPC() then
		if not p.OldSpeed then
			p.OldSpeed = p:GetMoveVelocity()
		end

		p:SetMoveVelocity(p:GetMoveVelocity() * 0.4)
		self.npc_spd = p:GetMoveVelocity()
	end


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
	if IsValid(p) then
		if p:IsNPC() then
			p:SetMoveVelocity(self.npc_spd)
		end

		if (!self.NextAttack or self.NextAttack < CurTime()) then
			self.NextAttack = CurTime() + self.DOTDelay
			self:InflictDamage(p)
		end
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	if not IsValid(ent) then return end

	local offset = vector_origin
	if self.HitBoxID then
		local mins, maxs = ent:GetHitBoxBounds(self.HitBoxID, 0)
		offset:Set(Vector(math.random(mins[1], maxs[1]), math.random(mins[2], maxs[2]), math.random(mins[3], maxs[3])))
	end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_BULLET)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(self:GetPos() + offset)
	damage:SetDamageForce(-ent:GetForward()*1000)
	damage:SetDamage(self.Damage + math.max(nzombies and (nzRound:GetZombieHealth()*self.DamageRatio) or ent:GetMaxHealth()*self.DamageRatio, 5))

	if math.random(4) == 1 then
		local head = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !head then
			head = ent:LookupBone("j_head")
		end

		if !head then
			for i = 0, self:GetHitBoxCount(0) do
				if self:GetHitBoxHitGroup(i, 0) == HITGROUP_HEAD then
					head = self:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		if head then
			damage:SetDamagePosition(ent:GetBonePosition(head))
		end
	end

	if IsValid(self.Inflictor) and self.Inflictor:IsWeapon() and self.Inflictor.SendHitMarker then
		local res = {['Entity'] = ent, ['Hit'] = true, ['HitPos'] = self:GetPos() + offset}
		self.Inflictor:SendHitMarker(self.Attacker, res, damage)
	end

	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	if self.infectionfxpvs and IsValid(self.infectionfxpvs) then
		self.infectionfxpvs:StopEmission()
	end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNextBot() then
			if nzombies then
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			else
				p.loco:SetAcceleration(p.OldAccel)
				p.loco:SetDesiredSpeed(p.OldSpeed)
			end
		end

		if p:IsNPC() then
			p:SetMoveVelocity(p.OldSpeed)
			if p:Alive() and p:Health() > 0 then
				p:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end
end

ENT.Draw = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		if !self.infectionfxpvs or !IsValid(self.infectionfxpvs) then
			self.infectionfxpvs = CreateParticleSystem(p, "aw_nanoswarm_infect", PATTACH_ABSORIGIN_FOLLOW, 0)
		else
			local head = p:LookupBone("ValveBiped.Bip01_Head1")
			if !head then
				head = p:LookupBone("j_head")
			end

			if !head then
				for i = 0, p:GetHitBoxCount(0) do
					local hitgroup = p:GetHitBoxHitGroup(i,0)
					if (hitgroup == HITGROUP_HEAD) or (hitgroup == HITGROUP_GENERIC) then
						head = p:GetHitBoxBone(i, 0)
						break
					end
				end
			end

			if head then
				self.infectionfxpvs:SetControlPoint(1, p:GetBonePosition(head))
			end
		end
	end
end
