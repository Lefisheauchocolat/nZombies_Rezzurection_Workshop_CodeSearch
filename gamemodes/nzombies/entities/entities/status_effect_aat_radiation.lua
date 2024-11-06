AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Radiation Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.AATRadiation = function(self, duration, attacker, inflictor, blockattack)
		if self.IsAATTurned and self:IsAATTurned() then return end
		local boss = false
		if nzombies and (self.NZBossType or self.IsMooBossZombie or self.IsMiniBoss or string.find(self:GetClass(), "zombie_boss")) then
			boss = true
		end
		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end
		if blockattack == nil then
			blockattack = true
		end

		if IsValid(self.aat_fallout_logic) then
			self.aat_fallout_logic:UpdateDuration(duration)
			return self.aat_fallout_logic
		end

		self.aat_fallout_logic = ents.Create("status_effect_aat_radiation")
		self.aat_fallout_logic:SetPos(self:WorldSpaceCenter())
		self.aat_fallout_logic:SetParent(self)
		self.aat_fallout_logic:SetOwner(self)
		self.aat_fallout_logic.IsBoss = boss

		self.aat_fallout_logic.Attacker = attacker
		self.aat_fallout_logic.Inflictor = inflictor
		self.aat_fallout_logic.BlockAttack = blockattack

		self.aat_fallout_logic:Spawn()
		self.aat_fallout_logic:Activate()

		self.aat_fallout_logic:SetOwner(self)
		self.aat_fallout_logic:UpdateDuration(duration)
		self:SetNW2Entity("AAT.RadiationLogic", self.aat_fallout_logic)
		return self.aat_fallout_logic
	end

	hook.Add("OnNPCKilled", "AAT.RadiationLogic", function(self)
		if IsValid(self.aat_fallout_logic) then
			return self.aat_fallout_logic:Remove()
		end
	end)
	hook.Add("OnZombieKilled", "AAT.RadiationLogic", function(self)
		if IsValid(self.aat_fallout_logic) then
			return self.aat_fallout_logic:Remove()
		end
	end)
end

entMeta.IsAATRadiated = function(self)
	return IsValid(self:GetNW2Entity("AAT.RadiationLogic"))
end

/*ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end*/

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) and !self.IsBoss then
		ParticleEffectAttach("bo3_aat_fallout_zomb_floor", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		ParticleEffectAttach("bo3_aat_fallout_zomb", PATTACH_POINT_FOLLOW, p, 2)

		if p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach("bo3_aat_fallout_eyes", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach("bo3_aat_fallout_eyes", PATTACH_POINT_FOLLOW, p, 4)
		end
	end

	if CLIENT then return end
	self:TrapNPC(p)
	if p:IsValidZombie() then
		self.DesiredSpeed = p.DesiredSpeed
		p:SetRunSpeed(1)
		p:SpeedChanged()

		if self.BlockAttack then
			p:SetBlockAttack(true)
		end
	end

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
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd and self.statusEnd < CurTime() then
		/*if not self.dothething then
			self.dothething = true
			local p = self:GetParent()
			if IsValid(p) and !self.IsBoss and p:IsValidZombie() then
				if p.DoSpecialAnimation and p.ShrinkSequences and (!p.ShouldCrawl or !p:GetCrawler()) then
					local seq = p.ShrinkSequences[math.random(#p.ShrinkSequences)]
					local id, time = p:LookupSequence(seq)

					p:Freeze(time)
					p:DoSpecialAnimation(seq)
					if p:IsValidZombie() and not p.IsMooSpecial then
						ParticleEffectAttach("bo3_aat_fallout_eyes", PATTACH_POINT_FOLLOW, p, 3)
						ParticleEffectAttach("bo3_aat_fallout_eyes", PATTACH_POINT_FOLLOW, p, 4)
					end

					if id >= 0 then
						newtime = time + engine.TickInterval()*math.random(-2,2)
					end

					if p.PlaySound and p.ElecSounds then
						self.zombsound = p.ElecSounds[math.random(#p.ElecSounds)]
						p:PlaySound(self.zombsound, p.SoundVolume or SNDLVL_NORM, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, CHAN_STATIC)
					end

					self.duration = newtime
					self.statusEnd = CurTime() + newtime
				end
			end
		else*/
			self:InflictDamage(self:GetParent())
			self:Remove()
			return false
		//end
	end

	self:NextThink(CurTime())
	return true
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

		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.InflictDamage = function(self, ent)
	if not IsValid(ent) then return end
	ent:SetNW2Bool("NZNoRagdoll", true)

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if self.IsBoss then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 6))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if p:Health() <= 0 then
			if self.zombsound then
				p:StopSound(self.zombsound)
			end
			ParticleEffect("bo2_jetgun_shread", p:WorldSpaceCenter(), Angle(0,0,0))

			p:EmitSound("TFA_BO2_JETGUN.Gib")

			ParticleEffectAttach("bo3_aat_fallout_kill", PATTACH_POINT_FOLLOW, p, 2)
		else
			if p:GetNW2Bool("NZNoRagdoll") then
				//ParticleEffect("bo3_gersch_kill", p:WorldSpaceCenter(), angle_zero)
				p:SetNW2Bool("NZNoRagdoll", false)
			end
		end

		if SERVER then
			if p:IsValidZombie() then
				if self.BlockAttack and !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end
				p:SetRunSpeed(self.DesiredSpeed)
				p:SpeedChanged()
			end

			if p:IsNPC() then
				p:SetMoveVelocity(p.OldSpeed)
				p:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end
end

ENT.Draw = function(self)
end