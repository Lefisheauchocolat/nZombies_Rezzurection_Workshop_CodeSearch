AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Sparky Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO2Sparky = function(self, duration)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and (self.NZBossType or self.IsMooBossZombie) then return end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo2_sparky_logic) then
			self.bo2_sparky_logic:UpdateDuration(duration)
			return self.bo2_sparky_logic
		end

		self.bo2_sparky_logic = ents.Create("bo2_status_effect_sparky")
		self.bo2_sparky_logic:SetPos(self:WorldSpaceCenter())
		self.bo2_sparky_logic:SetParent(self)
		self.bo2_sparky_logic:SetOwner(self)

		self.bo2_sparky_logic:Spawn()
		self.bo2_sparky_logic:Activate()

		self.bo2_sparky_logic:SetOwner(self)
		self.bo2_sparky_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO2.SparkyLogic", self.bo2_sparky_logic)
		return self.bo2_sparky_logic
	end

	hook.Add("PlayerDeath", "BO2.SparkyLogic", function(self)
		if IsValid(self.bo2_sparky_logic) then
			return self.bo2_sparky_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO2.SparkyLogic", function(self)
		if IsValid(self.bo2_sparky_logic) then
			return self.bo2_sparky_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO2.SparkyLogic", function(self)
			if IsValid(self.bo2_sparky_logic) then
				return self.bo2_sparky_logic:Remove()
			end
		end)
	end
end

entMeta.BO2IsSparky = function(self)
	return IsValid(self:GetNW2Entity("BO2.SparkyLogic"))
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO4_DG5.ShockLoop")
		ParticleEffectAttach("bo2_teslagat_loop", PATTACH_POINT_FOLLOW, p, 2)
		if nzombies and p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach("bo2_teslagat_eyes", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach("bo2_teslagat_eyes", PATTACH_POINT_FOLLOW, p, 4)
		end
	end

	if CLIENT then return end
	if not IsValid(p) then SafeRemoveEntity(self) return end

	self:TrapPlayer(p)
	self:TrapNextBot(p)
	self:TrapNPC(p)

	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
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

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		p:StopSound("TFA_BO4_DG5.ShockLoop")

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
end
