AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Cryofreeze Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.ATTCryoFreeze = function(self, duration, attacker, inflictor)
		if self.IsAATTurned and self:IsAATTurned() then return end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.perk_cryfreeze_logic) then
			self.perk_cryfreeze_logic:UpdateDuration(duration)
			return self.perk_cryfreeze_logic
		end

		self.perk_cryfreeze_logic = ents.Create("status_effect_aat_ice")
		self.perk_cryfreeze_logic:SetModel("models/dav0r/hoverball.mdl")
		self.perk_cryfreeze_logic:SetPos(self:GetPos())
		self.perk_cryfreeze_logic:SetParent(self)
		self.perk_cryfreeze_logic:SetOwner(self)

		self.perk_cryfreeze_logic:Spawn()
		self.perk_cryfreeze_logic:Activate()

		self.perk_cryfreeze_logic:SetAttacker(attacker)
		self.perk_cryfreeze_logic:SetInflictor(inflictor)

		self.perk_cryfreeze_logic:SetOwner(self)
		self.perk_cryfreeze_logic:UpdateDuration(duration)
		self:SetNWEntity("PERK.CryofreezeLogic", self.perk_cryfreeze_logic)
		return self.perk_cryfreeze_logic
	end

	hook.Add("OnZombieKilled", "PERK.CryofreezeLogic", function(self)
		if IsValid(self.perk_cryfreeze_logic) then
			return self.perk_cryfreeze_logic:Remove()
		end
	end)
end

entMeta.IsATTCryoFreeze = function(self)
	return IsValid(self:GetNWEntity("PERK.CryofreezeLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:SetMaterial("models/overlay/freeze_overlay")
		p:EmitSound("NZ.POP.Cryofreeze.Freeze")

		ParticleEffect("bo3_aat_freeze_explode", p:WorldSpaceCenter(), Angle(0,0,0))
		ParticleEffectAttach("bo4_freezegun_zomb_smoke", PATTACH_POINT_FOLLOW, p, 0)
	end

	if CLIENT then return end
	if IsValid(p) and p:IsNextBot() then
		p:SetCollisionGroup(COLLISION_GROUP_WORLD)
		p.loco:SetVelocity(vector_origin)
		p.loco:SetAcceleration(0)
		p.loco:SetDesiredSpeed(0)
		if engine.ActiveGamemode() == "nzombies" and p:IsValidZombie() then
			p:SetBlockAttack(true)
		end
	end

	self:SetTrigger(true)
	self:UseTriggerBounds(true, 6)
	self.statusStart = CurTime()
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if p.Freeze then
		p:Freeze(newtime)
	end

    self.duration = newtime
    self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_origin)
	damage:SetDamage(ent:Health() + 666)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or ent.IsMiniBoss) then
		damage:SetDamage(math.max(1000, ent:GetMaxHealth() / 8))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10))
	end

	ent:TakeDamageInfo(damage)
	ent:Remove()
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		self:InflictDamage(p)
		p:StopParticles()
		p:EmitSound("NZ.POP.Cryofreeze.Shatter")
		ParticleEffect("bo3_aat_freeze", p:WorldSpaceCenter(), Angle(0,0,0))
	end
end

ENT.StartTouch = function(self, ent)
	local p = self:GetParent()
	if IsValid(p) and ent:IsPlayer() then
		self:SetAttacker(ent)
		self:InflictDamage(p)
		self:Remove()
	end
end

ENT.OnTakeDamage = function(self, dmginfo)
	local p = self:GetParent()
	if IsValid(p) then
		self:SetAttacker(dmginfo:GetAttacker())
		self:InflictDamage(p)
		self:Remove()
	end
end
