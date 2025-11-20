AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Sliquifier Infection Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3Soap = function(self, duration, attacker, inflictor, upgrade)
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

		if IsValid(self.bo3_soapgun_logic) then
			self.bo3_soapgun_logic:UpdateDuration(duration)
			return self.bo3_soapgun_logic
		end

		self.bo3_soapgun_logic = ents.Create("bo3_status_effect_slipgun")
		self.bo3_soapgun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_soapgun_logic:SetParent(self)
		self.bo3_soapgun_logic:SetOwner(self)
		self.bo3_soapgun_logic:SetUpgraded(upgrade)

		self.bo3_soapgun_logic.Attacker = attacker
		self.bo3_soapgun_logic.Inflictor = inflictor

		self.bo3_soapgun_logic:Spawn()
		self.bo3_soapgun_logic:Activate()

		self.bo3_soapgun_logic:SetOwner(self)
		self.bo3_soapgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.SoapgunLogic", self.bo3_soapgun_logic)
		return self.bo3_soapgun_logic
	end

	hook.Add("PlayerDeath", "BO3.SoapgunLogic", function(self)
		if IsValid(self.bo3_soapgun_logic) then
			return self.bo3_soapgun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.SoapgunLogic", function(self)
		if IsValid(self.bo3_soapgun_logic) then
			return self.bo3_soapgun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.SoapgunLogic", function(self)
			if IsValid(self.bo3_soapgun_logic) then
				return self.bo3_soapgun_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsSoaped = function(self)
	return IsValid(self:GetNW2Entity("BO3.SoapgunLogic"))
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
		ParticleEffectAttach(self:GetUpgraded() and "bo3_sliquifier_zomb_smoke_2" or "bo3_sliquifier_zomb_smoke", PATTACH_ABSORIGIN_FOLLOW, p, 0)
	end

	if CLIENT then return end
	sound.EmitHint(SOUND_DANGER, self:GetPos(), 200, 0.5, IsValid(self:GetOwner()) and self:GetOwner() or self)
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
	self.statusEnd = (CurTime() + newtime) + math.Rand(0.5, 1.5)
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd < CurTime() then
		local p = self:GetParent()
		if IsValid(p) then
			p:StopParticles()
			self:Explode()
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	ent:EmitSound("TFA_BO3_SLIPGUN.Explode")
	if self:GetUpgraded() then
		ParticleEffect("bo3_sliquifier_impact_2", self:GetPos(), angle_zero)
	else
		ParticleEffect("bo3_sliquifier_impact", self:GetPos(), angle_zero)
	end

	local damage = DamageInfo()
	damage:SetDamage(nzombies and ent:Health() + 666 or 5500)
	damage:SetAttacker(IsValid(self.Attacker) and self.Attacker or ent)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)
	damage:SetDamageType(DMG_ALWAYSGIB)

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(800, ent:GetMaxHealth() / 12))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)

	local ply = self.Attacker
	if IsValid(ply) and ply:IsPlayer() then
		if not ply.SoapKills then ply.SoapKills = 0 end

		ply.SoapKills = ply.SoapKills + 1
		if ply.SoapKills == 12 and not ply.bo3soapachievment then
			TFA.BO3GiveAchievement("Slippery When Undead", "vgui/overlay/achievment/sliquifier.png", ply, 1)
			ply.bo3soapachievment = true
		end
	end
end

ENT.Explode = function(self)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetUpgraded() and 120 or 100)) do
		if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
			if v == self.Attacker then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end

			if not v:BO3IsSoaped() then
				v:BO3Soap(1, self.Attacker, self.Inflictor, self:GetUpgraded())
			end
		end
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
	end
end

ENT.Draw = function(self)
end