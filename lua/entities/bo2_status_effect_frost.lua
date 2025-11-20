AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Frostgat Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO2FrostFreeze = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		local boss = false
		if nzombies and (self.NZBossType or self.IsMooBossZombie or string.find(self:GetClass(), "zombie_boss")) then
			return
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

		if IsValid(self.bo2_frostgat_logic) then
			self.bo2_frostgat_logic:UpdateDuration(duration)
			return self.bo2_frostgat_logic
		end

		self.bo2_frostgat_logic = ents.Create("bo2_status_effect_frost")
		self.bo2_frostgat_logic:SetPos(self:WorldSpaceCenter())
		self.bo2_frostgat_logic:SetParent(self)
		self.bo2_frostgat_logic:SetOwner(self)

		self.bo2_frostgat_logic.Attacker = attacker
		self.bo2_frostgat_logic.Inflictor = inflictor

		self.bo2_frostgat_logic:Spawn()
		self.bo2_frostgat_logic:Activate()

		self.bo2_frostgat_logic:SetOwner(self)
		self.bo2_frostgat_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO2.FrostGatLogic", self.bo2_frostgat_logic)
		return self.bo2_frostgat_logic
	end

	hook.Add("PlayerDeath", "BO2.FrostGatLogic", function(self)
		if IsValid(self.bo2_frostgat_logic) then
			return self.bo2_frostgat_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO2.FrostGatLogic", function(self)
		if IsValid(self.bo2_frostgat_logic) then
			return self.bo2_frostgat_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO2.FrostGatLogic", function(self)
			if IsValid(self.bo2_frostgat_logic) then
				return self.bo2_frostgat_logic:Remove()
			end
		end)
	end
end

entMeta.BO2FrostFrozen = function(self)
	return IsValid(self:GetNW2Entity("BO2.FrostGatLogic"))
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
	if IsValid(p) then
		if nzombies then
			p:SetMaterial("models/overlay/freeze_overlay")
			self:EmitSound("NZ.POP.Cryofreeze.Freeze")
		else
			p:SetMaterial("models/weapons/tfa_bo4/winters/rus_ter_ice_slush")
			self:EmitSound("TFA_BO4_WINTERS.Freeze")
		end

		//ParticleEffect("bo2_frostgat_freeze_smoke", self:GetPos(), angle_zero)
		ParticleEffectAttach("bo2_frostgat_freeze", PATTACH_POINT_FOLLOW, p, 1)
		ParticleEffectAttach("bo4_freezegun_zomb_smoke", PATTACH_POINT_FOLLOW, p, 0)
	end

	if CLIENT then return end
	if not IsValid(p) then SafeRemoveEntity(self) return end

	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration

	self:TrapPlayer(p)
	self:TrapNPC(p)
	self:TrapNextBot(p)
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end
	local p = self:GetParent()
	if IsValid(p) then
		if nzombies and p:IsValidZombie() then
			return
		elseif p:IsNextBot() then
			local oldThread = p.BehaveThread
			p.BehaveThread = coroutine.create(function()
				coroutine.wait(newtime)
				p.BehaveThread = oldThread
			end)
		elseif p:GetClass() == "npc_metropolice" then
			duration = 1
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNPC() then
		if p:Alive() then
			p:SetSchedule(SCHED_NPC_FREEZE)
		end
		p:SetMoveVelocity(vector_origin)
	end

	if self.statusEnd and self.statusEnd < CurTime() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapPlayer = function(self, ply)
	if IsValid(ply) and ply:IsPlayer() then
		ply:Freeze(true)
	end
end

ENT.TrapNextBot = function(self, bot)
	if IsValid(bot) and bot:IsNextBot() then
		if not bot.OldAccel then
			bot.OldAccel = bot.loco:GetAcceleration()
			bot.OldSpeed = bot.loco:GetDesiredSpeed()
		end

		bot:SetCollisionGroup(COLLISION_GROUP_WORLD)
		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)

			if bot.DoSpecialAnimation and bot.IceStaffSequences then
				local seq = bot.IceStaffSequences[math.random(#bot.IceStaffSequences)]
				if (bot.ShouldCrawl or (bot.GetCrawler and bot:GetCrawler())) and bot.CrawlFreezeDeathSequences then
					seq = bot.CrawlFreezeDeathSequences[math.random(#bot.CrawlFreezeDeathSequences)]
				end
				local id, time = bot:LookupSequence(seq)
				bot:SetSpecialShouldDie(true)
				bot:DoSpecialAnimation(seq)
				if id >= 0 then
					self.duration = time + engine.TickInterval()
					self.statusEnd = CurTime() + self.duration
				end
			end

			bot:Freeze(self.duration)

			if bot.PlaySound and bot.DeathSounds then
				self.zombsound = bot.DeathSounds[math.random(#bot.DeathSounds)]
				bot:PlaySound(self.zombsound, bot.SoundVolume or SNDLVL_NORM, math.random(bot.MinSoundPitch, bot.MaxSoundPitch), 1, CHAN_STATIC)
			end
		end
	end
end

local crabs = {
	["npc_headcrab"] = true,
	["npc_headcrab_fast"] = true,
	["npc_headcrab_black"] = true,
}

ENT.TrapNPC = function(self, npc)
	if IsValid(npc) and npc:IsNPC() then
		if not npc.OldSpeed then
			npc.OldSpeed = npc:GetMoveVelocity()
		end

		if npc:GetClass() == "npc_combine_s" then
			npc:Fire("HitByBugbait",0)
		elseif npc.Ignite and not crabs[npc:GetClass()] then
			npc:Ignite(0)
		end

		npc:SetCollisionGroup(COLLISION_GROUP_WORLD)
		npc:StopMoving()
		npc:SetMoveVelocity(vector_origin)

		if npc.Freeze then
			npc:Freeze(5)
		end

		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.InflictDamage = function(self, ent)
	if not IsValid(ent) then return end
	self:StopSound("TFA_BO4_WINTERS.Freeze")
	if nzombies then
		self:EmitSound("NZ.POP.Cryofreeze.Shatter")
	else
		self:EmitSound("TFA_BO4_WINTERS.Break")
		self:EmitSound("TFA_BO4_WINTERS.Shatter")
	end

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamageType(nzombies and DMG_MISSILEDEFENSE or DMG_REMOVENORAGDOLL)

	if !ent:IsPlayer() then
		ent:SetHealth(1)
	end

	if nzombies then
		ent:SetNW2Bool("NZNoRagdoll", true)
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_BO4_WINTERS.Freeze")
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if p:Health() <= 0 then
			if self.zombsound then
				p:StopSound(self.zombsound)
			end

			if p:IsNPC() or p:IsNextBot() or p:IsPlayer() then
				local bone = p:LookupBone("ValveBiped.Bip01_Pelvis")
				for i = 0, p:GetHitBoxCount(0) do
					if p:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
						bone = p:GetHitBoxBone(i, 0)
						break
					end
				end
				local spine = p:LookupBone("j_spineupper")
				if nzombies and spine then
					bone = spine
				end

				if bone then
					local bonepos, boneang = p:GetBonePosition(bone)
					ParticleEffect(nzombies and "bo3_aat_freeze" or "bo4_freezegun_explode", bonepos, angle_zero)
				else
					ParticleEffect(nzombies and "bo3_aat_freeze" or "bo4_freezegun_explode", self:GetPos(), angle_zero)
				end
			end
		end

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

		if p:IsPlayer() then
			p:Freeze(false)
		end
	end
end

ENT.Draw = function(self)
end