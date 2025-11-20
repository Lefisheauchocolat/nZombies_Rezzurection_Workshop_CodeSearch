AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Light Gun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.WAWBlastXInfect = function(self, duration, attacker, inflictor, upgraded)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if upgraded == nil then
			upgraded = false
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

		if IsValid(self.waw_lightgun_logic) then
			self.waw_lightgun_logic:UpdateDuration(duration)
			return self.waw_lightgun_logic
		end

		self.waw_lightgun_logic = ents.Create("waw_status_effect_green")
		self.waw_lightgun_logic:SetPos(self:WorldSpaceCenter())
		self.waw_lightgun_logic:SetParent(self)
		self.waw_lightgun_logic:SetOwner(self)

		self.waw_lightgun_logic.Attacker = attacker
		self.waw_lightgun_logic.Inflictor = inflictor
		self.waw_lightgun_logic:SetUpgraded(upgraded)

		self.waw_lightgun_logic:Spawn()
		self.waw_lightgun_logic:Activate()

		self.waw_lightgun_logic:SetOwner(self)
		self.waw_lightgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.LightgunLogic", self.waw_lightgun_logic)
		return self.waw_lightgun_logic
	end
	
	hook.Add("PlayerDeath", "WAW.LightgunLogic", function(self)
		if IsValid(self.waw_lightgun_logic) then
			return self.waw_lightgun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "WAW.LightgunLogic", function(self)
		if IsValid(self.waw_lightgun_logic) then
			return self.waw_lightgun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "WAW.LightgunLogic", function(self)
			if IsValid(self.waw_lightgun_logic) then
				return self.waw_lightgun_logic:Remove()
			end
		end)
	end
end

entMeta.WAWIsBlastXInfected = function(self)
	return IsValid(self:GetNW2Entity("WAW.LightgunLogic"))
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
		if SERVER and p:IsNPC() then
			p:ClearSchedule()
			p:ClearEnemyMemory(p:GetEnemy())
		end

		ParticleEffectAttach(self:GetUpgraded() and "waw_lightrifle_infect_2" or "waw_lightrifle_infect", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		if nzombies and p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach(self:GetUpgraded() and "waw_lightrifle_eyes_2" or "waw_lightrifle_eyes", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach(self:GetUpgraded() and "waw_lightrifle_eyes_2" or "waw_lightrifle_eyes", PATTACH_POINT_FOLLOW, p, 4)
		end
	end

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	newtime = newtime + math.Rand(-0.25,0.25)

	local p = self:GetParent()
	if IsValid(p) then
		if nzombies and p:IsValidZombie() and p.FleeTarget then
			p:FleeTarget(newtime)
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNPC() then
		self:StupidNPC(p)
	end

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
	damage:SetDamageType(DMG_SHOCK)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 8))
	end

	ent:EmitSound("TFA_BO3_WAFFE.Bounce")
	ent:EmitSound("TFA_BO3_WAFFE.Sizzle")

	ParticleEffectAttach(self:GetUpgraded() and "bo3_waffe_electrocute_2" or "bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
	if ent:OnGround() then
		ParticleEffectAttach(self:GetUpgraded() and "bo3_waffe_ground_2" or "bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	/*local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
	end*/
end

ENT.Draw = function(self)
end

function ENT:StupidNPC(ent)
	if CLIENT then return end
	if not IsValid(ent) or not ent:IsNPC() then return end

	if ent:GetEnemy() ~= self then
		ent:ClearSchedule()
		ent:ClearEnemyMemory(ent:GetEnemy())
		ent:SetEnemy(self)
	end

	ent:SetSchedule(SCHED_FORCED_GO_RUN)
end
