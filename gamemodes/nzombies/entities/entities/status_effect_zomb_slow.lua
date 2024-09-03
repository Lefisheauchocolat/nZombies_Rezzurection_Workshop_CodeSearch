AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "ZombShell Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.ZombSlow = function(self, duration, ratio)
		if self.IsAATTurned and self:IsAATTurned() then return end
		if self.NZBossType or self.IsMooBossZombie then return end

		if duration == nil then
			duration = 0
		end
		if ratio == nil then
			ratio = 0.2
		end

		if IsValid(self.perk_zombshell_logic) then
			self.perk_zombshell_logic:UpdateDuration(duration)
			return self.perk_zombshell_logic
		end

		self.perk_zombshell_logic = ents.Create("status_effect_zomb_slow")
		self.perk_zombshell_logic:SetPos(self:GetPos())
		self.perk_zombshell_logic:SetParent(self)
		self.perk_zombshell_logic:SetOwner(self)
		self.perk_zombshell_logic:SetRatio(ratio)

		self.perk_zombshell_logic:Spawn()
		self.perk_zombshell_logic:Activate()

		self.perk_zombshell_logic:SetOwner(self)
		self.perk_zombshell_logic:UpdateDuration(duration)
		self:SetNWEntity("PERK.ZombShellLogic", self.perk_zombshell_logic)
		return self.perk_zombshell_logic
	end

	hook.Add("OnZombieKilled", "PERK.ZombShellLogic", function(self)
		if IsValid(self.perk_zombshell_logic) then
			return self.perk_zombshell_logic:Remove()
		end
	end)
end

entMeta.IsZombSlowed = function(self)
	return IsValid(self:GetNWEntity("PERK.ZombShellLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Float", 0, "Ratio")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if SERVER and IsValid(p) and p:IsValidZombie() then
		p.loco:SetVelocity(p.loco:GetVelocity() * self:GetRatio())
		p.loco:SetDesiredSpeed(p.loco:GetDesiredSpeed() * self:GetRatio())
		p.loco:SetAcceleration(p.loco:GetAcceleration() * self:GetRatio())
		self.nxb_spd = p.loco:GetDesiredSpeed()
	end

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

    self.duration = newtime
    self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNextBot() then
		p.loco:SetVelocity(p:GetForward() * self.nxb_spd)
		p.loco:SetDesiredSpeed(self.nxb_spd)
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) and p:IsValidZombie() then
		p.loco:SetAcceleration(p.Acceleration)
		p.loco:SetDesiredSpeed(p:GetRunSpeed())
	end
end
