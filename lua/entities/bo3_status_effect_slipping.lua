AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Slipping Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO3Slip = function(self, duration)
		if self:IsPlayer() then
			return
		end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo3_slipping_logic) then
			self.bo3_slipping_logic:UpdateDuration(duration)
			return self.bo3_slipping_logic
		end

		self.bo3_slipping_logic = ents.Create("bo3_status_effect_slipping")
		self.bo3_slipping_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_slipping_logic:SetParent(self)
		self.bo3_slipping_logic:SetOwner(self)

		self.bo3_slipping_logic:Spawn()
		self.bo3_slipping_logic:Activate()

		self.bo3_slipping_logic:SetOwner(self)
		self.bo3_slipping_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.SlippingLogic", self.bo3_slipping_logic)
		return self.bo3_slipping_logic
	end

	hook.Add("OnNPCKilled", "BO3.SlippingLogic", function(self)
		if IsValid(self.bo3_slipping_logic) then
			return self.bo3_slipping_logic:Remove()
		end
	end)
	if engine.ActiveGamemode() == "nzombies" then
		hook.Add("OnZombieKilled", "BO3.SlippingLogic", function(self)
			if IsValid(self.bo3_slipping_logic) then
				return self.bo3_slipping_logic:Remove()
			end
		end)
	end
end

local nzombies = engine.ActiveGamemode() == "nzombies"

entMeta.BO3IsSlipping = function(self)
	return IsValid(self:GetNW2Entity("BO3.SlippingLogic"))
end

ENT.SetupDataTables = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		self:SetAngles(p:GetForward():Angle())
		if SERVER and p:IsNPC() then
			p.OldMoveVelocity = p:GetMoveVelocity()
			p:StopMoving()
			p:SetSchedule(SCHED_NPC_FREEZE)
		end
	end

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

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNPC() then
			p:SetGroundEntity(nil)
			p:SetLocalVelocity(self:GetForward() * 50)
		end
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
	if IsValid(p) and p:IsNPC() then
		if SERVER then
			p:SetMoveVelocity(p.OldMoveVelocity)
		end
		p:SetSchedule(SCHED_ALERT_FACE)
	end
end

ENT.Draw = function(self)
end