AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Compact Nuke Gun Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OPAQUE
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3NukeAfterburn = function(self, duration, attacker, dodamage, delay, ratio)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if dodamage == nil then
			dodamage = true
		end
		if delay == nil or delay < 0 then
			delay = 0.5
		end
		if ratio == nil or ratio < 0 then
			ratio = 0.05
		end

		if IsValid(self.bo3_cng_logic) then
			self.bo3_cng_logic:UpdateDuration(duration)
			return self.bo3_cng_logic
		end

		local bone = self:LookupBone("j_spineupper") or self:LookupBone("ValveBiped.Bip01_Pelvis")
		if !bone then
			for i = 0, self:GetHitBoxCount(0) do
				local hitgroup = self:GetHitBoxHitGroup(i,0)
				if (hitgroup == HITGROUP_GENERIC) or (hitgroup == HITGROUP_STOMACH) then
					hitboxid = i
					bone = self:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		self.bo3_cng_logic = ents.Create("bo3_status_effect_nukeburn")
		self.bo3_cng_logic:SetPos(bone and self:GetPos() or self:WorldSpaceCenter())
		if bone then
			self.bo3_cng_logic:FollowBone(self, bone)
		else
			self.bo3_cng_logic:SetParent(self)
		end
		self.bo3_cng_logic:SetOwner(self)
		self.bo3_cng_logic.Attacker = attacker
		self.bo3_cng_logic.DoDamage = dodamage
		self.bo3_cng_logic.DOTDelay = delay
		self.bo3_cng_logic.DamageRatio = ratio

		self.bo3_cng_logic:Spawn()
		self.bo3_cng_logic:Activate()

		self.bo3_cng_logic:SetOwner(self)
		self.bo3_cng_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.NukeGunLogic", self.bo3_cng_logic)
		return self.bo3_cng_logic
	end

	hook.Add("PlayerDeath", "BO3.NukeGunLogic", function(self)
		if IsValid(self.bo3_cng_logic) then
			self:SetNW2Int("NukeBurning", self.NukeGunShocked and 2 or 1)
			self.bo3_cng_logic:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")
			return self.bo3_cng_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.NukeGunLogic", function(self)
		if IsValid(self.bo3_cng_logic) then
			self:SetNW2Int("NukeBurning", self.NukeGunShocked and 2 or 1)
			self.bo3_cng_logic:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")
			return self.bo3_cng_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.NukeGunLogic", function(self)
			if IsValid(self.bo3_cng_logic) then
				ParticleEffectAttach("bo3_cng_zomb", PATTACH_ABSORIGIN_FOLLOW, self, 0)
				self:SetNW2Int("NukeBurning", self.NukeGunShocked and 2 or 1)
				self.bo3_cng_logic:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")
				return self.bo3_cng_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsNukeBurning = function(self)
	return IsValid(self:GetNW2Entity("BO3.NukeGunLogic"))
end

ENT.SetupDataTables = function(self)
	//self:NetworkVar("Entity", 0, "Attacker")
end

ENT.Initialize = function(self)
	self:SetModel("models/dav0r/hoverball.mdl")
	//self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)

	local p = self:GetParent()
	if IsValid(p) then
		self:EmitSound("TFA_BO1_HELLFIRE.Ignite")
		self:EmitSound("TFA_BO1_MOLOTOV.Zomb.Burn")
		//ParticleEffectAttach("bo3_cng_zomb", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		ParticleEffectAttach("bo3_cng_zomb_a", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	if CLIENT then return end
	local time = self.DOTDelay
	if time > 0.1 then
		time = time + math.Rand(-0.1,0.1)
	end

	self.nextattack = CurTime() + time
	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.statusEnd - CurTime() > newtime then return end

	if newtime > 0.1 then
		newtime = newtime + math.Rand(-0.1,0.1)
	end

	self.duration = newtime
	self.statusEnd = CurTime() + self.duration
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if self.DoDamage and self.nextattack < CurTime() then
			local time = self.DOTDelay
			if time > 0.1 then
				time = time + math.Rand(-0.1,0.1)
			end

			self:InflictDamage(p)
			self.nextattack = CurTime() + time
		end
	end

	if self.statusEnd < CurTime() then
		self:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	self:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")

	if SERVER then
		if IsValid(p) and not p.NukeGunShocked then
			p:StopParticles()
		end
	end

	if self.nukepvsburn and IsValid(self.nukepvsburn) then
		self.nukepvsburn:StopEmission()
	end
end

ENT.InflictDamage = function(self, ent)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamage(math.max(nzombies and (nzRound:GetZombieHealth()*self.DamageRatio) or ent:GetMaxHealth()*self.DamageRatio, 10))
	damage:SetDamageType(nzombies and DMG_BURN or DMG_SLOWBURN)
	damage:SetAttacker(self.Attacker)
	damage:SetInflictor(self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if damage:GetDamage() >= ent:Health() and ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent:TakeDamageInfo(damage)
	ent:Extinguish()
end

ENT.Draw = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		if !self.nukepvsburn or !IsValid(self.nukepvsburn) then
			self.nukepvsburn = CreateParticleSystem(p, "bo3_cng_zomb", PATTACH_ABSORIGIN_FOLLOW, 0)
		end
	end
end
