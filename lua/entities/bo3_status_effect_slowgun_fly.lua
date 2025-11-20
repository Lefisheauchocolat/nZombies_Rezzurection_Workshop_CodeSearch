AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Slowgun Flying Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO3ParalyzerFly = function(self, flyer)
		if not IsValid(flyer) then return end
		if IsValid(self.bo3_flying_logic) then return end

		self.bo3_flying_logic = ents.Create("bo3_status_effect_slowgun_fly")
		self.bo3_flying_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_flying_logic:SetParent(self)
		self.bo3_flying_logic:SetOwner(self)
		self.bo3_flying_logic.WeaponEnt = flyer

		self.bo3_flying_logic:Spawn()
		self.bo3_flying_logic:Activate()
		self.bo3_flying_logic:SetOwner(self)

		self:SetNW2Entity("BO3.FlyerLogic", self.bo3_flying_logic)
		return self.bo3_flying_logic
	end

	hook.Add("PlayerDeath", "BO3.FlyerLogic", function(self)
		if IsValid(self.bo3_flying_logic) then
			self.bo3_flying_logic:Remove()
		end
	end)
end

entMeta.BO3IsFlying = function(self)
	return IsValid(self:GetNW2Entity("BO3.FlyerLogic"))
end

ENT.SetupDataTables = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	if CLIENT then return end
	if !IsValid(self.WeaponEnt) or !self.WeaponEnt.IsTFAWeapon then
		SafeRemoveEntity(self)
	end

	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration
end

ENT.Think = function(self)
	if CLIENT then return false end

	local wep = self.WeaponEnt
	if !IsValid(wep) then
		self:Remove()
		return false
	end

	local ply = wep:GetOwner()
	if IsValid(ply) and !ply:VisibleVec(self:GetPos()) then
		self:Remove()
		return false
	end

	if wep:GetStatus() == TFA.Enum.STATUS_SHOOTING then
		self.statusEnd = CurTime() + self.duration
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
end

ENT.Draw = function(self)
end