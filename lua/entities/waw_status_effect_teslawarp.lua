AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Teslawarp Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.WAWTeslaWarp = function(self, duration, attacker, inflictor, dosound)
		local boss = false
		if nzombies and (self.NZBossType or self.IsMooBossZombie or string.find(self:GetClass(), "zombie_boss")) then
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
		if dosound == nil then
			dosound = true
		end

		if IsValid(self.waw_teslawarp_logic) then
			self.waw_teslawarp_logic:UpdateDuration(duration)
			return self.waw_teslawarp_logic
		end

		self.waw_teslawarp_logic = ents.Create("waw_status_effect_teslawarp")
		self.waw_teslawarp_logic:SetPos(self:WorldSpaceCenter())
		self.waw_teslawarp_logic:SetParent(self)
		self.waw_teslawarp_logic:SetOwner(self)
		self.waw_teslawarp_logic.DoSound = dosound
		self.waw_teslawarp_logic.IsBoss = boss

		self.waw_teslawarp_logic.Attacker = attacker
		self.waw_teslawarp_logic.Inflictor = inflictor

		self.waw_teslawarp_logic:Spawn()
		self.waw_teslawarp_logic:Activate()

		self.waw_teslawarp_logic:SetOwner(self)
		self.waw_teslawarp_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.TeslaWarpLogic", self.waw_teslawarp_logic)
		return self.waw_teslawarp_logic
	end

	hook.Add("PlayerDeath", "WAW.TeslaWarpLogic", function(self)
		if IsValid(self.waw_teslawarp_logic) then
			return self.waw_teslawarp_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "WAW.TeslaWarpLogic", function(self)
		if IsValid(self.waw_teslawarp_logic) then
			return self.waw_teslawarp_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "WAW.TeslaWarpLogic", function(self)
			if IsValid(self.waw_teslawarp_logic) then
				return self.waw_teslawarp_logic:Remove()
			end
		end)
	end
end

entMeta.WAWTeslaWarping = function(self)
	return IsValid(self:GetNW2Entity("WAW.TeslaWarpLogic"))
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
		ParticleEffectAttach("waw_teslanade_floor", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		ParticleEffectAttach("waw_teslanade_zomb", PATTACH_POINT_FOLLOW, p, 2)
	end

	if CLIENT then return end
	self:TrapPlayer(p)
	self:TrapNPC(p)
	self:TrapNextBot(p)
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
	if IsValid(p) and !self.IsBoss then
		if nzombies and p:IsValidZombie() then
			p:Freeze(newtime)
			if p.DoSpecialAnimation and p.ShrinkSequences and (!p.ShouldCrawl or !p:GetCrawler()) then
				local seq = p.ShrinkSequences[math.random(#p.ShrinkSequences)]
				local id, time = p:LookupSequence(seq)
				p:DoSpecialAnimation(seq)
				if id >= 0 then
					newtime = time + engine.TickInterval()*math.random(-2,2)
				end
			end
			if p.PlaySound and p.ElecSounds then
				self.zombsound = p.ElecSounds[math.random(#p.ElecSounds)]
				p:PlaySound(self.zombsound, p.SoundVolume or SNDLVL_NORM, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, CHAN_STATIC)
			end
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

	if self.statusEnd and self.statusEnd < CurTime() then
		self:InflictDamage(self:GetParent())
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

ENT.InflictDamage = function(self, ent)
	if not IsValid(ent) then return end
	if self.DoSound then
		ent:EmitSound("TFA_WAW_QUIZZTESLA.Teleport")
	end

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamageType(DMG_REMOVENORAGDOLL)

	if nzombies and self.IsBoss then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 6))
	else
		ent:SetHealth(1)
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
			ParticleEffect("waw_teslanade_warpout", self:GetPos(), Angle(0,0,0))
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