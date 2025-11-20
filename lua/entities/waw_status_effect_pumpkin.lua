AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Pumpkin Gun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_BOTH
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.WAWPumpkin = function(self, duration, attacker, inflictor, upgraded)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and (self.NZBossType or self.IsMooBossZombie) then return end
		if duration == nil then
			duration = 0
		end
		if upgraded == nil then
			upgraded = false
		end

		if IsValid(self.waw_pumpkingun_logic) then
			self.waw_pumpkingun_logic:UpdateDuration(duration)
			return self.waw_pumpkingun_logic
		end

		self.waw_pumpkingun_logic = ents.Create("waw_status_effect_pumpkin")
		self.waw_pumpkingun_logic:SetPos(self:EyePos() - vector_up*6)
		self.waw_pumpkingun_logic:SetAngles(self:GetAngles())
		self.waw_pumpkingun_logic:SetParent(self)

		local headbone = self:LookupBone("ValveBiped.Bip01_Head1")
		for i = 0, self:GetHitBoxCount(0) do
			if self:GetHitBoxHitGroup(i,0) == HITGROUP_HEAD then
				headbone = self:GetHitBoxBone(i, 0)
				break
			end
		end
		if not headbone then
			for i = 0, self:GetHitBoxCount(0) do
				if self:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
					headbone = self:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		if nzombies then
			headbone = self:LookupBone("j_head") or self:LookupBone("j_spineupper")
			if headbone then
				self.waw_pumpkingun_logic.HeadBone = headbone
			end
		elseif headbone then
			self.waw_pumpkingun_logic.HeadBone = headbone
		end

		self.waw_pumpkingun_logic:SetOwner(self)
		self.waw_pumpkingun_logic:SetModel("models/weapons/tfa_waw/pumpkingun/pumpkingun_projectile.mdl")

		self.waw_pumpkingun_logic:SetUpgraded(upgraded)
		self.waw_pumpkingun_logic.Attacker = attacker
		self.waw_pumpkingun_logic.Inflictor = inflictor

		self.waw_pumpkingun_logic:Spawn()
		self.waw_pumpkingun_logic:Activate()

		self.waw_pumpkingun_logic:SetOwner(self)
		self.waw_pumpkingun_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.PumpkingunLogic", self.waw_pumpkingun_logic)
		return self.waw_pumpkingun_logic
	end

	hook.Add("PlayerDeath", "WAW.PumpkingunLogic", function(self)
		if IsValid(self.waw_pumpkingun_logic) then
			return self.waw_pumpkingun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "WAW.PumpkingunLogic", function(self)
		if IsValid(self.waw_pumpkingun_logic) then
			return self.waw_pumpkingun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "WAW.PumpkingunLogic", function(self)
			if IsValid(self.waw_pumpkingun_logic) then
				return self.waw_pumpkingun_logic:Remove()
			end
		end)
	end
end

entMeta.WAWIsPumpkin = function(self)
	return IsValid(self:GetNW2Entity("WAW.PumpkingunLogic"))
end

ENT.Draw = function(self)
	self:DrawModel()
end

ENT.IsTranslucent = function(self)
	return true
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")
end

ENT.Initialize = function(self)
	self:DrawShadow(false)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		if nzombies and p:IsValidZombie() then
			if not p.OldCollisionGroup then
				p.OldCollisionGroup = p:GetCollisionGroup()
			end
			p:SetCollisionGroup(COLLISION_GROUP_WORLD)
		end
		if p:IsNPC() then
			if not p.OldCollisionGroup then
				p.OldCollisionGroup = p:GetCollisionGroup()
			end
			p:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		end

		ParticleEffectAttach(self:GetUpgraded() and "waw_pumpkingun_cook_2" or "waw_pumpkingun_cook", PATTACH_POINT_FOLLOW, p, 2)
		timer.Simple(math.Rand(0,0.5), function()
			if not IsValid(p) then return end
			p:EmitSound("TFA_BO3_WAVEGUN.Microwave.Cook")
		end)
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
	if nzombies and IsValid(p) and p:IsValidZombie() then
		if p.Freeze then
			p:Freeze(newtime)
		end
		if p.DoSpecialAnimation and p.FireStaffDeathSequences and (!p.ShouldCrawl or !p:GetCrawler()) then
			local seq = p.FireStaffDeathSequences[math.random(#p.FireStaffDeathSequences)]
			local id, time = p:LookupSequence(seq)
			p:DoSpecialAnimation(seq)
			if id >= 0 then
				newtime = math.min(time, math.Rand(3,4))
			end
		end
		if p.PlaySound then
			if p.FireDeathSounds then
				p:PlaySound(p.FireDeathSounds[math.random(#p.FireDeathSounds)], 90, math.random(75, 95), 1, 2)
			elseif p.ElecSounds then
				p:PlaySound(p.ElecSounds[math.random(#p.ElecSounds)], 90, math.random(75, 95), 1, 2)
			end
			p.NextSound = CurTime() + newtime + engine.TickInterval()
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if self.HeadBone then
			local headpos, headang = p:GetBonePosition(self.HeadBone)
			self:SetPos(headpos)
			self:SetAngles(p:GetAngles())
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
		npc:SetVelocity(vector_origin)
		npc:SetMoveVelocity(vector_origin)

		if npc:Alive() then
			npc:SetSchedule(SCHED_NPC_FREEZE)
		end
		npc:Fire("HitByBugbait", math.Rand(0, 2))
	end
end

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetDamageType(nzombies and DMG_MISSILEDEFENSE or DMG_REMOVENORAGDOLL)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamage(ent:Health() + 666)

	if ent:IsNPC() then
		ent:SetHealth(1)
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent:TakeDamageInfo(damage)

	util.Decal("Scorch", ent:GetPos() - vector_up, ent:GetPos() + vector_up)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		p:StopSound("TFA_BO3_WAVEGUN.Microwave.Cook")
		self:EmitSound("TFA_BO3_WAVEGUN.Microwave.Ding")
		self:EmitSound("TFA_BO1_HELLFIRE.Ignite")

		if (!nzombies or (nzombies and !game.SinglePlayer())) and p:Health() <= 0 then
			ParticleEffectAttach(self:GetUpgraded() and "waw_pumpkingun_pop_2" or "waw_pumpkingun_pop", PATTACH_POINT_FOLLOW, p, 2)
		end

		if SERVER then
			if p.OldCollisionGroup then
				p:SetCollisionGroup(p.OldCollisionGroup)
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
end
