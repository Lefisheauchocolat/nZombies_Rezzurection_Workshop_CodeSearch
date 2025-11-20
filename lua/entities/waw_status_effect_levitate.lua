AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Levitate Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.WAWLevitate = function(self, duration, attacker, inflictor, upgraded)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and (self.NZBossType or self.IsMooBossZombie or string.find(self:GetClass(), "zombie_boss")) then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end
		if upgraded == nil then
			upgraded = false
		end

		if IsValid(self.waw_levitate_logic) then
			self.waw_levitate_logic:UpdateDuration(duration)
			return self.waw_levitate_logic
		end

		self.waw_levitate_logic = ents.Create("waw_status_effect_levitate")
		self.waw_levitate_logic:SetPos(self:WorldSpaceCenter())
		self.waw_levitate_logic:SetParent(self)
		self.waw_levitate_logic:SetOwner(self)

		self.waw_levitate_logic:SetUpgraded(upgraded)
		self.waw_levitate_logic.Attacker = attacker
		self.waw_levitate_logic.Inflictor = inflictor

		self.waw_levitate_logic:Spawn()
		self.waw_levitate_logic:Activate()

		self.waw_levitate_logic:SetOwner(self)
		self.waw_levitate_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.LevitateLogic", self.waw_levitate_logic)
		return self.waw_levitate_logic
	end

	hook.Add("PlayerDeath", "WAW.LevitateLogic", function(self)
		if IsValid(self.waw_levitate_logic) then
			return self.waw_levitate_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "WAW.LevitateLogic", function(self)
		if IsValid(self.waw_levitate_logic) then
			return self.waw_levitate_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "WAW.LevitateLogic", function(self)
			if IsValid(self.waw_levitate_logic) then
				return self.waw_levitate_logic:Remove()
			end
		end)
	end
end

entMeta.WAWLevitating = function(self)
	return IsValid(self:GetNW2Entity("WAW.LevitateLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")
	//self:NetworkVar("Entity", 0, "Attacker")
	//self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		ParticleEffectAttach(self:GetUpgraded() and "waw_levitator_zomb_2" or "waw_levitator_zomb", PATTACH_POINT_FOLLOW, p, 2)
		ParticleEffectAttach(self:GetUpgraded() and "waw_levitator_zomb_floor_2" or "waw_levitator_zomb_floor", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		self:EmitSound("TFA_WAW_LEVITATOR.Wait")
	end

	if CLIENT then return end
	if not IsValid(p) then self:Remove() return end
	if not p:IsPlayer() then
		p.OldCollision = p:GetCollisionGroup()
		p:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	self:TrapNextBot(p)
	self:TrapNPC(p)
	self:TrapPlayer(p)

	local tr = util.QuickTrace(self:GetPos(), vector_up*math.Rand(18,26), {self, p, self.Attacker})
	self.finalpos = tr.HitPos
	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if nzombies and IsValid(p) and p:IsValidZombie() then
		p:SetNW2Bool("OnAcid", true)
		p:Freeze(newtime)
		if p.PlaySound and p.ElecSounds then
			local sndlvl = p.SoundVolume
			for k, v in nzLevel.GetZombieArray() do
				if k < 2 then sndlvl = 511 break end
			end

			p:PlaySound(p.ElecSounds[math.random(#p.ElecSounds)], sndlvl, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, 2, 1)
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		local fraction = 1 - math.Clamp((self.statusEnd - CurTime()) / self.duration, 0, 1)
		local rate = fraction * (self.duration * engine.TickInterval())

		if p:IsNPC() then
			if p:Alive() then
				p:SetSchedule(SCHED_NPC_FREEZE)
			end
			p:SetGroundEntity(Entity(0))
			p:SetPos(LerpVector(rate, p:GetPos(), self.finalpos))
		end

		if p:IsNextBot() then
			if nzombies then
				p.DoCollideWhenPossible = nil
				if p:GetCollisionGroup() ~= COLLISION_GROUP_PASSABLE_DOOR then
					p:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
				end

				if !self.iskilling and p.PlaySound and p.ElecSounds and p.NextSound and (p.NextSound - engine.TickInterval()*2) < CurTime() then
					p:PlaySound(p.ElecSounds[math.random(#p.ElecSounds)],vol, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, 2, 1)
				end
			else
				p:SetGroundEntity(Entity(0))
				if p:GetPos().z < self.finalpos.z then
					p:SetPos(LerpVector(fraction, p:GetPos(), p:GetPos() + p:OBBCenter()))
				else
					p:SetPos(LerpVector(rate, p:GetPos(), self.finalpos))
				end
				p.loco:SetVelocity(vector_origin)
			end
		end

		if p:IsPlayer() then
			p:SetGroundEntity(Entity(0))
			p:SetPos(LerpVector(rate, p:GetPos(), self.finalpos))
			p:SetLocalVelocity(vector_origin)
		end

		if nzombies and (self.statusEnd - engine.TickInterval()) < CurTime() and !self.iskilling and p.TempBehaveThread and p.DeathRaySequences then
			self.iskilling = true

			local seq = p.DeathRaySequences[math.random(#p.DeathRaySequences)]
			local id, time = p:LookupSequence(seq)
			self.statusEnd = CurTime() + (time - math.Rand(0.15,0.3))

			p.NextSound = CurTime() + time
			p:SetNW2Bool("OnAcid", false)
			p:TempBehaveThread(function(p)
				p:SetSpecialAnimation(true)
				p:PlaySequenceAndWait(seq)
			end)
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

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
		bot.OldGravity = bot.loco:GetGravity()
		bot:SetGroundEntity(nil)
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
		npc:ClearSchedule()
		npc:ClearEnemyMemory(npc:GetEnemy())

		npc:StopMoving()
		npc:SetVelocity(vector_origin)
		npc:SetMoveVelocity(vector_origin)

		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.TrapPlayer = function(self, ply)
	if ply:IsPlayer() then
		ply.OldGravity = ply:GetGravity()
		ply:SetGravity(0)
		ply:Freeze(true)
	end
end

ENT.InflictDamage = function(self, ent)
	self:EmitSound("TFA_BO2_JETGUN.Gib")

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetDamagePosition(self:GetPos())
	damage:SetDamageForce(vector_up)

	ent:SetHealth(1)
	if ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	if nzombies then
		ent:SetNW2Bool("WavePopKilled", true)
	else
		ent:SetNW2Bool("RemoveRagdoll", true)
	end

	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_WAW_LEVITATOR.Wait")
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if !nzombies and p:Health() <= 0 then
			ParticleEffectAttach("bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		end

		if SERVER then
			if !p:IsPlayer() and p.OldCollision and p:GetCollisionGroup() ~= p.OldCollision then
				p:SetCollisionGroup(p.OldCollision)
			end

			if nzombies and p:IsValidZombie() then
				p:SetNW2Bool("OnAcid", false)

				if !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end

				p.loco:SetGravity(p.OldGravity or 1000)
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			end

			if p:IsPlayer() and p:IsFrozen() then
				if p.OldGravity and p:GetGravity() ~= p.OldGravity then
					p:SetGravity(p.OldGravity)
				end
				p:Freeze(false)
			end
		end
	end
end

ENT.Draw = function(self)
end
