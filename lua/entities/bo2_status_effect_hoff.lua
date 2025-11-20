AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Blunderhoff Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO2HoffDance = function(self, duration, attacker, inflictor, nosound)
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

		if IsValid(self.bo2_hoff_logic) then
			self.bo2_hoff_logic:UpdateDuration(duration)
			return self.bo2_hoff_logic
		end

		self.bo2_hoff_logic = ents.Create("bo2_status_effect_hoff")
		self.bo2_hoff_logic:SetPos(self:WorldSpaceCenter())
		self.bo2_hoff_logic:SetParent(self)
		self.bo2_hoff_logic:SetOwner(self)

		self.bo2_hoff_logic.Attacker = attacker
		self.bo2_hoff_logic.Inflictor = inflictor

		if nosound then
			self.bo2_hoff_logic.NoSound = true
		end

		self.bo2_hoff_logic:Spawn()
		self.bo2_hoff_logic:Activate()

		self.bo2_hoff_logic:SetOwner(self)
		self.bo2_hoff_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO2.BlunderhoffLogic", self.bo2_hoff_logic)
		return self.bo2_hoff_logic
	end

	hook.Add("OnNPCKilled", "BO2.BlunderhoffLogic", function(self)
		if IsValid(self.bo2_hoff_logic) then
			return self.bo2_hoff_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO2.BlunderhoffLogic", function(self)
			if IsValid(self.bo2_hoff_logic) then
				return self.bo2_hoff_logic:Remove()
			end
		end)
	end
end

entMeta.BO2IsHoffDancing = function(self)
	return IsValid(self:GetNW2Entity("BO2.BlunderhoffLogic"))
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		if SERVER and p:IsNPC() then
			p:ClearSchedule()
			p:ClearEnemyMemory(p:GetEnemy())
		end

		ParticleEffectAttach("bo2_blunderhoff_dance", PATTACH_ABSORIGIN_FOLLOW, p, 0)

		if nzombies and p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach("bo2_blunderhoff_eyes", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach("bo2_blunderhoff_eyes", PATTACH_POINT_FOLLOW, p, 4)
		end
	end

	if CLIENT then return end
	self:TrapNPC(p)
	self:TrapNextBot(p)
	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration

	local ply = self.Attacker
	if nzombies and IsValid(ply) and ply:IsPlayer() then
		ply:GivePoints(10)
	end
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if IsValid(p) then
		if nzombies and p:IsValidZombie() then
			p:SetBlockAttack(true)

			p.OldCollision = p:GetCollisionGroup()
			p:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

			if p.TempBehaveThread and p.DanceSequences then
				if p.DanceSounds and !self.NoSound then
					self.dosound = p.DanceSounds[math.random(#p.DanceSounds)]
					p:PlaySound(self.dosound, SNDLVL_70dB)
				end

				p:TempBehaveThread(function(p)
					local seq = p.DanceSequences[math.random(#p.DanceSequences)]
					local stat = p:GetNW2Entity("BO2.BlunderhoffLogic")
					if IsValid(stat) then
						local id, time = p:LookupSequence(seq)
						stat.statusEnd = stat.statusStart + math.Clamp(time, 1, 10) - math.Rand(0,0.5)
					end

					p:SetSpecialAnimation(true)
					p:PlaySequenceAndWait(seq)
				end)
			else
				p:Freeze(newtime)
			end
		end
		/*if p:IsNPC() then
			p:Ignite(0)
		end*/
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.TrapNextBot = function(self, bot)
	if IsValid(bot) and bot:IsNextBot() and !self.IsBoss then
		if not bot.OldAccel then
			bot.OldAccel = bot.loco:GetAcceleration()
			bot.OldSpeed = bot.loco:GetDesiredSpeed()
		end

		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
	end
end

ENT.TrapNPC = function(self, npc)
	if IsValid(npc) and npc:IsNPC() then
		if not npc.OldSpeed then
			npc.OldSpeed = npc:GetMoveVelocity()
		end

		if npc:GetClass() == "npc_combine_s" then
			npc:Fire("HitByBugbait",0)
		elseif npc.Ignite then
			npc:Ignite(0)
		end

		npc:StopMoving()
		npc:SetMoveVelocity(vector_origin)
		if npc:Alive() then
			npc:SetSchedule(SCHED_NPC_FREEZE)
		end
	end
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	/*if IsValid(p) and p:IsNPC() then
		p:SetSchedule(SCHED_NPC_FREEZE)
	end*/

	if self.statusEnd < CurTime() then
		if IsValid(p) then
			p:StopParticles()
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	ent:StopParticles()

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(ent:IsNPC() and damage:SetDamage(DMG_REMOVENORAGDOLL) or DMG_MISSILEDEFENSE)
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageForce(vector_up)

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if self.dosound then
			p:StopSound(self.dosound)
		end
		if p.OldCollision then
			p:SetCollisionGroup(p.OldCollision)
		end

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
				p:SetMoveVelocity(p.OldSpeed)
				p:SetSchedule(SCHED_ALERT_STAND)
			end
		end

		self:EmitSound("TFA_BO2_BLUNDERHOFF.Explo")
		ParticleEffect("bo2_blunderhoff_infect", p:GetPos(), Angle(0,0,0))
	end
end

ENT.Draw = function(self)
end
