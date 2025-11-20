AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Shock Stun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OPAQUE
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3ShockStun = function(self, duration, attacker, damage)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and (self.NZBossType or self.IsMooBossZombie) then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if damage == nil then
			damage = 0
		end

		if IsValid(self.bo3_waffe_stun_logic) then
			self.bo3_waffe_stun_logic:UpdateDuration(duration)
			return self.bo3_waffe_stun_logic
		end

		local bone = (self:LookupBone("j_head") or self:LookupBone("j_neck")) or (self:LookupBone("ValveBiped.Bip01_Neck1") or self:LookupBone("ValveBiped.Bip01_Head1"))
		if !bone then
			for i = 0, self:GetHitBoxCount(0) do
				if self:GetHitBoxHitGroup(i,0) == HITGROUP_HEAD then
					bone = self:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		self.bo3_waffe_stun_logic = ents.Create("bo3_status_effect_shockloop")
		self.bo3_waffe_stun_logic:SetPos(self:GetPos())
		if bone then
			self.bo3_waffe_stun_logic:FollowBone(self, bone)
		else
			self.bo3_waffe_stun_logic:SetParent(self)
		end
		self.bo3_waffe_stun_logic:SetOwner(self)
		self.bo3_waffe_stun_logic.Attacker = attacker
		self.bo3_waffe_stun_logic.MyDamage = damage

		self.bo3_waffe_stun_logic:Spawn()
		self.bo3_waffe_stun_logic:Activate()

		self.bo3_waffe_stun_logic:SetOwner(self)
		self.bo3_waffe_stun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.WaffeStunLogic", self.bo3_waffe_stun_logic)
		return self.bo3_waffe_stun_logic
	end

	hook.Add("PlayerDeath", "BO3.WaffeStunLogic", function(self)
		if IsValid(self.bo3_waffe_stun_logic) then
			return self.bo3_waffe_stun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.WaffeStunLogic", function(self)
		if IsValid(self.bo3_waffe_stun_logic) then
			return self.bo3_waffe_stun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.WaffeStunLogic", function(self)
			if IsValid(self.bo3_waffe_stun_logic) then
				return self.bo3_waffe_stun_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsShockStun = function(self)
	return IsValid(self:GetNW2Entity("BO3.WaffeStunLogic"))
end

ENT.Initialize = function(self)
	self:SetModel("models/dav0r/hoverball.mdl")
	//self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO3_WAFFE.Sizzle")
		//ParticleEffectAttach("bo3_cng_shock", PATTACH_POINT_FOLLOW, p, 2)
		ParticleEffectAttach("bo3_cng_shock_a", PATTACH_ABSORIGIN_FOLLOW, self, 0)

		if nzombies and p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, p, 4)
		end
	end

	if CLIENT then return end
	if not IsValid(p) then SafeRemoveEntity(self) return end

	self:TrapPlayer(p)
	self:TrapNextBot(p)
	self:TrapNPC(p)

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
	if nzombies and IsValid(p) and p.Freeze and p:IsValidZombie() then
		p:SetNW2Bool("OnAcid", true)
		p:Freeze(newtime)
		if p.PlaySound and p.ElecSounds then
			p:PlaySound(p.ElecSounds[math.random(#p.ElecSounds)], p.SoundVolume or SNDLVL_TALKING, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, 2, 1)
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNPC() then
			if p:Alive() then
				p:SetSchedule(SCHED_NPC_FREEZE)
			end
			p:SetMoveVelocity(Vector(0,0,0))
		end
		if nzombies and p:IsNextBot() then
			if p.PlaySound and p.ElecSounds and p.NextSound and (p.NextSound - engine.TickInterval()*2) < CurTime() then
				p:PlaySound(p.ElecSounds[math.random(#p.ElecSounds)], p.SoundVolume or SNDLVL_TALKING, math.random(p.MinSoundPitch, p.MaxSoundPitch), 1, 2, 1)
			end
		end
	end

	if self.statusEnd < CurTime() then
		if IsValid(p) and self.MyDamage and self.MyDamage > 0 then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapPlayer = function(self, ply)
	if ply:IsPlayer() then
		ply:Freeze(true)
	end
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
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
	if npc:IsNPC() then
		if not npc.OldSpeed then
			npc.OldSpeed = npc:GetMoveVelocity()
		end

		if npc.Ignite then
			npc:Ignite(0)
		end

		npc:StopMoving()
		npc:SetMoveVelocity(vector_origin)

		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.InflictDamage = function(self, ent)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamage(self.MyDamage)
	damage:SetDamageType(DMG_SHOCK)
	damage:SetAttacker(self.Attacker)
	damage:SetInflictor(self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	ent.NukeGunShocked = true
	ent:TakeDamageInfo(damage)
	ent:Extinguish()
	ent.NukeGunShocked = nil
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		if p:Health() > 0 then
			p:StopParticles()
		end

		if p:GetNW2Bool("OnAcid", false) then
			p:SetNW2Bool("OnAcid", false)
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
	local p = self:GetParent()
	if IsValid(p) then
		if p:Health() > 0 then
			if !self.nukepvsshock or !IsValid(self.nukepvsshock) then
				self.nukepvsshock = CreateParticleSystem(p, "bo3_cng_shock", PATTACH_ABSORIGIN_FOLLOW, 0)
			end
		elseif self.nukepvsshock and self.nukepvsshock:IsValid() then
			self.nukepvsshock:StopEmissionAndDestroyImmediately()
		end
	elseif self.nukepvsshock and self.nukepvsshock:IsValid() then
		self.nukepvsshock:StopEmissionAndDestroyImmediately()
	end
end
