AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Xmas Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.WAWXmasInfect = function(self, duration, attacker, inflictor)
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

		if IsValid(self.waw_xmasgun_logic) then
			self.waw_xmasgun_logic:UpdateDuration(duration)
			return self.waw_xmasgun_logic
		end

		self.waw_xmasgun_logic = ents.Create("waw_status_effect_xmas")
		self.waw_xmasgun_logic:SetPos(self:WorldSpaceCenter() + vector_up*math.random(-2,6))
		self.waw_xmasgun_logic:SetParent(self)
		self.waw_xmasgun_logic:SetOwner(self)

		self.waw_xmasgun_logic:SetXmasC(math.random(2))
		self.waw_xmasgun_logic.Attacker = attacker
		self.waw_xmasgun_logic.Inflictor = inflictor

		self.waw_xmasgun_logic:Spawn()
		self.waw_xmasgun_logic:Activate()

		self.waw_xmasgun_logic:SetOwner(self)
		self.waw_xmasgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.XmasgunLogic", self.waw_xmasgun_logic)
		return self.waw_xmasgun_logic
	end

	hook.Add("PlayerDeath", "WAW.XmasgunLogic", function(self)
		if IsValid(self.waw_xmasgun_logic) then
			return self.waw_xmasgun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "WAW.XmasgunLogic", function(self)
		if IsValid(self.waw_xmasgun_logic) then
			return self.waw_xmasgun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "WAW.XmasgunLogic", function(self)
			if IsValid(self.waw_xmasgun_logic) then
				return self.waw_xmasgun_logic:Remove()
			end
		end)
	end
end

entMeta.WAWIsXmasInfected = function(self)
	return IsValid(self:GetNW2Entity("WAW.XmasgunLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Int", 0, "XmasC")
	//self:NetworkVar("Entity", 0, "Attacker")
	//self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO3_WAFFE.Death")
		if SERVER and p:IsNPC() then
			p:ClearSchedule()
			p:ClearEnemyMemory(p:GetEnemy())
		end

		self:SetXmasC(math.Clamp(self:GetXmasC(), 1, 2))
		ParticleEffectAttach("waw_xray_infect_"..self:GetXmasC(), PATTACH_ABSORIGIN_FOLLOW, p, 0)
		ParticleEffectAttach("waw_xmas_spiral", PATTACH_ABSORIGIN_FOLLOW, p, 0)

		if nzombies and p:IsValidZombie() and not p.IsMooSpecial then
			ParticleEffectAttach(self:GetXmasC() == 1 and "waw_lightrifle_eyes" or "waw_lightrifle_eyes_2", PATTACH_POINT_FOLLOW, p, 3)
			ParticleEffectAttach(self:GetXmasC() == 1 and "waw_lightrifle_eyes" or "waw_lightrifle_eyes_2", PATTACH_POINT_FOLLOW, p, 4)
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

	local p = self:GetParent()
	if IsValid(p) then
		if nzombies and p:IsValidZombie() then
			if p.TempBehaveThread and p.AcidStunSequences then
				p:TempBehaveThread(function(p)
					local seq = p.AcidStunSequences[math.random(#p.AcidStunSequences)]
					local stat = p:GetNW2Entity("WAW.XmasgunLogic")
					if IsValid(stat) then
						local id, time = p:LookupSequence(seq)
						stat.statusEnd = stat.statusStart + (time - (math.Rand(0.1,0.5)))
					end

					p:SetSpecialAnimation(true)
					p:PlaySequenceAndWait(seq)
				end)
			else
				p:Freeze(newtime)
			end
		end
		if p:IsNPC() then
			p:Ignite(0)
		end
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNPC() and p:Alive() then
		p:SetSchedule(SCHED_NPC_FREEZE)
	end

	if self.statusEnd < CurTime() then
		if IsValid(p) then
			p:StopParticles()
			self:InflictDamage(p)
		end
		self:Explode()
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
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageForce(vector_up)

	ent:EmitSound("TFA_BO1_HELLFIRE.Ignite")

	ent:SetHealth(1)

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.Explode = function(self)
	local kills = 0
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 140)) do
		if v:IsNPC() or v:IsNextBot() then
			if (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then continue end
			if v:WAWIsXmasInfected() then continue end
			if v == self.Attacker then continue end
			if v == self:GetParent() then continue end
			if v:Health() <= 0 then continue end

			v:WAWXmasInfect(math.Rand(1.4,2.2), self.Attacker, self.Inflictor)
			kills = kills + 1
			if kills >= 4 then break end
		end
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
	end

	ParticleEffect("bo3_gersch_kill", self:GetPos(), angle_zero)
	self:EmitSound("TFA_BO3_GERSCH.Suck")
end

ENT.Draw = function(self)
end
