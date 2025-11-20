AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Slowgun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3Slow = function(self, duration, attacker, inflictor, upgrade)
		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end
		if upgrade == nil then
			upgrade = false
		end

		if IsValid(self.bo3_slowgun_logic) then
			self.bo3_slowgun_logic:UpdateDuration(duration)
			return self.bo3_slowgun_logic
		end

		self.bo3_slowgun_logic = ents.Create("bo3_status_effect_slowgun")
		self.bo3_slowgun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_slowgun_logic:SetParent(self)
		self.bo3_slowgun_logic:SetOwner(self)

		self.bo3_slowgun_logic.Attacker = attacker
		self.bo3_slowgun_logic.Inflictor = inflictor
		self.bo3_slowgun_logic:SetUpgraded(upgrade)

		self.bo3_slowgun_logic:Spawn()
		self.bo3_slowgun_logic:Activate()
		
		self.bo3_slowgun_logic:SetOwner(self)
		
		self.bo3_slowgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.SlowgunLogic", self.bo3_slowgun_logic)
		return self.bo3_slowgun_logic
	end

	hook.Add("PlayerDeath", "BO3.SlowgunLogic", function(self)
		if IsValid(self.bo3_slowgun_logic) then
			return self.bo3_slowgun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.SlowgunLogic", function(self)
		if IsValid(self.bo3_slowgun_logic) then
			return self.bo3_slowgun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.SlowgunLogic", function(self)
			if IsValid(self.bo3_slowgun_logic) then
				return self.bo3_slowgun_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsSlowed = function(self)
	return IsValid(self:GetNW2Entity("BO3.SlowgunLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")

	self:NetworkVar("Float", 0, "StatusStart")
	self:NetworkVar("Float", 1, "StatusEnd")

	//self:NetworkVar("Entity", 0, "Attacker")
	//self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		self:EmitSound("TFA_BO3_PARALYZER.Slow")
		ParticleEffectAttach(self:GetUpgraded() and "bo3_paralyzer_zomb_pap" or "bo3_paralyzer_zomb", PATTACH_ABSORIGIN, p, 0)
	end

	if CLIENT then return end
	if not IsValid(p) then return self:Remove() end
	if p:IsNextBot() then
		p.OldAccel = p.loco:GetAcceleration()
		p.OldSpeed = p.loco:GetDesiredSpeed()
	end
	if p:IsNPC() then
		p.OldVelocity = p:GetMoveVelocity()
	end

	self.bosstrapped = false
	if nzombies and (p.NZBossType or p.IsMooBossZombie or string.find(p:GetClass(), "nz_zombie_boss")) then
		self.bosstrapped = true
	end

	self.statusStart = CurTime()
	self:SetStatusStart(CurTime())
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	//if self.statusEnd - CurTime() > newtime then return end

	self.duration = newtime
	self.statusEnd = self.statusEnd + newtime
	self:SetStatusEnd(self.statusEnd)

	local p = self:GetParent()
	if SERVER and IsValid(p) then
		if p:IsNextBot() and !self.bosstrapped then
			p.loco:SetDesiredSpeed(p.loco:GetDesiredSpeed() * 0.8)
			p.loco:SetAcceleration(p.loco:GetAcceleration() * 0.8)
			self.nb_loco = p.loco:GetDesiredSpeed()
			self.nb_accel = p.loco:GetAcceleration()
		end
		if p:IsNPC() then
			p:SetMoveVelocity(p:GetMoveVelocity() * 0.7)
			self.npc_spd = p:GetMoveVelocity()
		end
	end
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNPC() then
			if self.npc_spd:LengthSqr() > 12 then
				p:SetMoveVelocity(self.npc_spd)
			else
				p:StopMoving()
				if p:Alive() then
					p:SetSchedule(SCHED_NPC_FREEZE)
				end
			end
		end
		if p:IsNextBot() and !self.bosstrapped then
			if self.nb_loco > 12 then
				p.loco:SetDesiredSpeed(self.nb_loco)
				p.loco:SetAcceleration(self.nb_accel)
			else --slow enough, just set to 0
				if nzombies and p:IsValidZombie() then
					p:SetBlockAttack(true)
				end
				p.loco:SetVelocity(vector_origin)
				p.loco:SetDesiredSpeed(0)
			end
		end

		local time = 5
		local rand = math.Rand(0.95,1.05)
		if self:GetUpgraded() then
			time = 4
		end
		if nzombies and nzPowerUps:IsPowerupActive("insta") then
			time = 2
		end

		if self:GetStatusEnd() > self:GetStatusStart() + (time*rand) then
			self:InflictDamage(p)
			self:StopSound("TFA_BO3_PARALYZER.Slow")
			self:Remove()
			return false
		end
	end

	if self.statusEnd < CurTime() then
		self:StopSound("TFA_BO3_PARALYZER.Slow")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	self:EmitSound("TFA_BO3_PARALYZER.Explode")

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetDamageForce(vector_up)

	if nzombies and self.bosstrapped then
		damage:SetDamage(math.max(1000, ent:GetMaxHealth() / 10))
	end

	if ent:IsNPC() then
		ent:SetHealth(1)
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	if nzombies then
		if !self.bosstrapped then
			ent:SetNW2Bool("WavePopKilled", true)
		end
	else
		ent:SetNW2Bool("RemoveRagdoll", true)
	end

	ent:TakeDamageInfo(damage)
	self:Remove()
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_BO3_PARALYZER.Slow")

	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if !nzombies and p:Health() <= 0 then
			ParticleEffectAttach("bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		end

		if SERVER then
			if p:IsNextBot() and !self.bosstrapped then
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
				p:SetMoveVelocity(p.OldVelocity)
				p:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end
end

ENT.Draw = function(self)
end