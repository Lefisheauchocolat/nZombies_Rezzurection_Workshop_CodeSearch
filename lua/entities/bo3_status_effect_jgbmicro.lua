
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
ENT.PrintName = "Shrink Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_BOTH

local nzombies = engine.ActiveGamemode() == "nzombies"
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO3Shrink = function(self, duration, upgrade, attacker)
		if upgrade == nil then
			upgrade = false
		end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo3_shrinkgun_logic) then
			self.bo3_shrinkgun_logic:UpdateDuration(duration)
			return self.bo3_shrinkgun_logic
		end

		self.bo3_shrinkgun_logic = ents.Create("bo3_status_effect_jgbmicro")
		self.bo3_shrinkgun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_shrinkgun_logic:SetParent(self)
		self.bo3_shrinkgun_logic:SetOwner(self)
		self.bo3_shrinkgun_logic:SetModel("models/hunter/plates/plate.mdl")
		self.bo3_shrinkgun_logic:SetUpgraded(upgrade)
		self.bo3_shrinkgun_logic:SetAttacker(attacker or self)

		self.bo3_shrinkgun_logic:Spawn()
		self.bo3_shrinkgun_logic:Activate()

		self.bo3_shrinkgun_logic:SetOwner(self)
		self.bo3_shrinkgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.ShrinkgunLogic", self.bo3_shrinkgun_logic)
		return self.bo3_shrinkgun_logic
	end

	hook.Add("PlayerDeath", "BO3.ShrinkgunLogic", function(self)
		if IsValid(self.bo3_shrinkgun_logic) then
			return self.bo3_shrinkgun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.ShrinkgunLogic", function(self)
		if IsValid(self.bo3_shrinkgun_logic) then
			return self.bo3_shrinkgun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.ShrinkgunLogic", function(self)
			if IsValid(self.bo3_shrinkgun_logic) then
				return self.bo3_shrinkgun_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsShrunk = function(self)
	return IsValid(self:GetNW2Entity("BO3.ShrinkgunLogic", nil))
end

entMeta.BO3IsKicked = function(self)
	if not IsValid(self:GetNW2Entity("BO3.ShrinkgunLogic", nil)) then return end
	return self:GetNW2Entity("BO3.ShrinkgunLogic"):GetKicked()
end

local function CollisionBoxClear(ent, pos, minBound, maxBound)
	local tr = util.TraceHull({
		start = pos,
		endpos = pos + vector_up*32,
		mins = minBound,
		maxs = maxBound,
		filter = {self, ent},
		mask = MASK_PLAYERSOLID
	})

	if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
		return false
	end

	return !tr.StartSolid || !tr.AllSolid
end

ENT.Draw = function(self)
end

ENT.SetupDataTables = function(self)
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar( "Bool", 1, "Kicked")
	self:NetworkVar( "Entity", 0, "Attacker")
	self:NetworkVar( "Entity", 1, "Inflictor")
end

ENT.Initialize = function(self)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:UseTriggerBounds(true, 12)

	self:SetInflictor(self)
	self.Assistor = self:GetAttacker()

	local p = self:GetParent()
	if IsValid(p) then
		//p.OldHealth = p:Health()
		p.OldCollision = p:GetCollisionGroup()
		p.OldScale = p:GetModelScale()

		p.OldOBBMins = p:OBBMins()
		p.OldOBBMaxs = p:OBBMaxs()

		p:SetModelScale(0.5, 0.5)
		p:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		p:SetHealth(1)

		p:EmitSound("TFA_BO3_JGB.ZMB.Shrink")
		ParticleEffectAttach("bo3_jgb_shrink", PATTACH_POINT_FOLLOW, p, 1)

		local headbone = p:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = p:LookupBone("j_head") end
		if headbone then
			p:ManipulateBoneScale(headbone, Vector(3.5,3.5,3.5))
		end

		if p:IsPlayer() then
			p.OldViewHeigh = p:GetViewOffset()
			p:SetViewOffset(p:GetViewOffsetDucked())
		end
	end

	if CLIENT then return end
	self:NPCChaseCheck()
	self:SetTrigger(true)
	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.statusEnd - CurTime() > newtime then return end
	self.duration = newtime
	self.statusEnd = (CurTime() + newtime) + math.Rand(-0.15, 0.15)
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:BO3IsKicked() and not p:IsNextBot() then
		if p:IsOnGround() then
			self:Squish()
			self:Remove()
			return false
		end
	end

	local npc = self.ChaserNPC
	if IsValid(npc) then
		if IsValid(p) and not p:Alive() and npc.OldCollision then
			npc:SetCollisionGroup(npc.OldCollision)
		end

		npc:UpdateEnemyMemory(p, p:GetPos())
		npc:SetSaveValue("m_vecLastPosition", p:GetPos())
		npc:SetSchedule(self:GetKicked() and SCHED_ALERT_STAND or SCHED_FORCED_GO_RUN)
	end

	if self.statusEnd < CurTime() and not p:BO3IsKicked() and CollisionBoxClear(p, p:GetPos() + vector_up, p.OldOBBMins, p.OldOBBMaxs) then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

local speed = 500
local halfspeed = 250

ENT.NPCChaseCheck = function(self)
	local npc = self.Assistor
	local ply = self:GetParent()
	if not IsValid(npc) or not npc:IsNPC() then return end
	if not IsValid(ply) then return end

	npc:ClearSchedule()
	npc:ClearEnemyMemory(npc:GetEnemy())
	npc:SetEnemy(ply)

	self.ChaserNPC = npc
end

ENT.Kick = function(self)
	local ent = self:GetParent()
	local ply = self:GetAttacker()
	
	ent:EmitSound("TFA_BO3_JGB.ZMB.Kick")
	ent:SetGroundEntity(nil)
	self:SetKicked(true)

	local aim = (ent:GetPos() - ply:GetPos()):GetNormalized()
	local mult = math.Clamp((ply:GetVelocity():Length() / (ply:IsNPC() and (ply:GetSequenceGroundSpeed(ply:GetMovementSequence())) or ply:GetWalkSpeed())), 1, 3)

	if ent:IsNextBot() then
		local forward = ply:GetForward() * math.random(8000,14000)
		local side = aim * 8000
		local up = ent:GetUp() * math.random(8000,14000)

		local damage = DamageInfo()
		damage:SetDamage(ent:Health() + 666)
		damage:SetDamageType(DMG_MISSILEDEFENSE)
		damage:SetAttacker(self:GetAttacker())
		damage:SetInflictor(self:GetInflictor())
		damage:SetDamageForce((up*mult) + (side*mult) + (forward*mult))
		damage:SetDamagePosition(ent:WorldSpaceCenter())

		if ent.IsDrGNextbot and ent.RagdollOnDeath and util.IsValidRagdoll(ent:GetModel()) then
			ent:DrG_RagdollDeath(damage)
		else
			ent:TakeDamageInfo(damage)
			if nzombies and self.Assistor and self:GetAttacker() ~= self.Assistor and self.Assistor:IsPlayer() then
				local helper = self.Assistor
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(helper) then return end
					helper:GivePoints(10)
				end)
			end

			if ply:IsPlayer() then
				self:NotifyJGBAchievment(ply)
			end
		end

		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if headbone then
			ent:ManipulateBoneScale(headbone, Vector(1,1,1))
		end

		return
	end

	if ply:IsNPC() and ent:IsPlayer() then
		ply.OldCollision = ply:GetCollisionGroup()
		ply:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	end

	ent:SetLocalAngularVelocity(Angle(speed * mult, math.random(-20,20),0))
	ent:SetVelocity((ent:GetUp() * halfspeed) * mult + (aim * halfspeed) * mult)
	ent:SetGroundEntity(nil)
end

ENT.NotifyJGBAchievment = function(self, ply)
	if IsValid(ply) and ply:IsPlayer() and ply:HasWeapon('tfa_bo3_shrinkray') then
		if not ply.jgbKills then ply.jgbKills = 0 end

		ply.jgbKills = ply.jgbKills + 1
		if ply.jgbKills == 6 then
			if not ply.bo3shrinkachievement then
				TFA.BO3GiveAchievement("Small Consolation", "vgui/overlay/achievment/shrinkray.png", ply)
				ply.bo3shrinkachievement = true
			end
		end
	end
end

ENT.Squish = function(self)
	local ent = self:GetParent()
	local ply = self:GetAttacker()

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(nzombies and DMG_MISSILEDEFENSE or DMG_REMOVENORAGDOLL)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:EmitSound("TFA_BO3_JGB.ZMB.Squish")
	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)

	if nzombies and IsValid(ply) and self.Assistor and ply ~= self.Assistor and self.Assistor:IsPlayer() then
		self.Assistor:GivePoints(10)
	end

	if IsValid(ply) and ply:IsPlayer() and (ent:IsNPC() or ent:IsNextBot()) then
		self:NotifyJGBAchievment(ply)
	end

	local gib = ents.Create("bo3_misc_gib")
	gib:SetPos(ent:WorldSpaceCenter())
	gib:Spawn()

	local phys = gib:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(0,math.random(400,1200),0))
		phys:SetVelocity(Vector(math.random(-100,100), math.random(-100,100), 150) * math.Rand(1,2))
	end

	util.Decal("Blood", ent:GetPos() + Vector(0,0,4), ent:GetPos() - Vector(0,0,4))

	self:SetKicked(true)
	
	self:Remove()
end

ENT.StartTouch = function(self, ent)
	local p = self:GetParent()
	if IsValid(p) and (ent:IsPlayer() or (ent:IsNPC() and p:IsPlayer())) then
		local speed = ent:GetVelocity():Length()
		if speed < .1 and !ent:IsNPC() then return end

		self:SetAttacker(ent)
		self:SetInflictor(IsValid(ent:GetActiveWeapon()) and ent:GetActiveWeapon() or ent)

		local normal = (p:GetPos() - ent:GetPos()):GetNormalized()
		local forward = ent:GetAngles():Forward()
		local dot = forward:Dot(normal)

		if ent:IsNPC() and p:IsPlayer() then
			self:Kick()
		elseif p.GetHullType then
			if p:GetHullType() == HULL_HUMAN then
				if dot > .5 and speed > 0 then
					if not self:GetKicked() then
						self:Kick()
					end
				else
					self:Squish()
				end
			else
				self:Squish()
			end
		else
			if dot > .5 and speed > 0 then
				if not self:GetKicked() then
					self:Kick()
				end
			else
				self:Squish()
			end
		end
	end
end

ENT.OnTakeDamage = function(self, dmginfo)
	local p = self:GetParent()
	if IsValid(p) then
		p:TakeDamageInfo(dmginfo)
		self:Remove()
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:SetModelScale(1, 0.5)
		p:SetCollisionGroup(p.OldCollision)

		local headbone = p:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = p:LookupBone("j_head") end
		if headbone then
			p:ManipulateBoneScale(headbone, Vector(1,1,1))
		end

		if p:IsPlayer() then
			p:SetViewOffset(p.OldViewHeigh)
			local headbone = p:LookupBone("ValveBiped.Bip01_Head1")
			if headbone then
				p:ManipulateBoneScale(headbone, Vector(1,1,1))
			end
		end

		local npc = self.ChaserNPC
		if IsValid(npc) and npc.OldCollision then
			npc:SetCollisionGroup(npc.OldCollision)

			local enemy = npc:GetEnemy()
			if IsValid(enemy) and enemy == p then
				npc:ClearSchedule()
				npc:ClearEnemyMemory(npc:GetEnemy())
				npc:SetSchedule(math.random(3) == 1 and SCHED_RELOAD or (math.random(2) == 1 and SCHED_ALERT_SCAN or SCHED_MOVE_AWAY))
			end
		end

		if not self:GetKicked() then
			/*if SERVER and ((p.Alive and p:Alive()) or p:Health() > 0) then
				p:SetHealth(p.OldHealth)
			end*/
			p:EmitSound("TFA_BO3_JGB.ZMB.UnShrink")
			ParticleEffectAttach( "bo3_jgb_unshrink", PATTACH_POINT_FOLLOW, p, 1 )
		end
	end
end
