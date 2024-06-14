AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Blastfurnace Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.AATBlastFurnace = function(self, duration, attacker, inflictor)
		if self.IsAATTurned and self:IsAATTurned() then return end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.perk_blastfurnace_logic) then
			self.perk_blastfurnace_logic:UpdateDuration(duration)
			return self.perk_blastfurnace_logic
		end

		self.perk_blastfurnace_logic = ents.Create("status_effect_aat_blastfurnace")
		self.perk_blastfurnace_logic:SetPos(self:GetPos())
		self.perk_blastfurnace_logic:SetParent(self)
		self.perk_blastfurnace_logic:SetOwner(self)

		self.perk_blastfurnace_logic:SetAttacker(attacker)
		self.perk_blastfurnace_logic:SetInflictor(inflictor)

		self.perk_blastfurnace_logic:Spawn()
		self.perk_blastfurnace_logic:Activate()

		self.perk_blastfurnace_logic:SetOwner(self)
		self.perk_blastfurnace_logic:UpdateDuration(duration)
		self:SetNWEntity("PERK.BlastFurnaceLogic", self.perk_blastfurnace_logic)
		return self.perk_blastfurnace_logic
	end

	hook.Add("OnZombieKilled", "PERK.BlastFurnaceLogic", function(self)
		if IsValid(self.perk_blastfurnace_logic) then
			return self.perk_blastfurnace_logic:Remove()
		end
	end)
end

entMeta.AATIsBlastFurnace = function(self)
	return IsValid(self:GetNWEntity("PERK.BlastFurnaceLogic"))
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

	if CLIENT then return end
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
	if SERVER and IsValid(p) and p.Ignite then
		p:Ignite(newtime)
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
	ParticleEffectAttach("bo4_alistairs_fireball_kill", PATTACH_POINT_FOLLOW, ent, 1)
	ent:EmitSound("NZ.POP.BlastFurnace.Die")

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageForce(vector_up)

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 8))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10))
	end

	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if SERVER and IsValid(p) then
		self:InflictDamage(p)
	end
end
