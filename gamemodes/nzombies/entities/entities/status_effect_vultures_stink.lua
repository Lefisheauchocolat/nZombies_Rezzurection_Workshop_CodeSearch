AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Vulture Stink Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.VulturesStink = function(self, duration)
		if duration == nil then
			duration = 0
		end

		if IsValid(self.perk_vulturesstink_logic) then
			self.perk_vulturesstink_logic:UpdateDuration(duration)
			return self.perk_vulturesstink_logic
		end

		self.perk_vulturesstink_logic = ents.Create("status_effect_vultures_stink")
		self.perk_vulturesstink_logic:SetPos(self:WorldSpaceCenter())
		self.perk_vulturesstink_logic:SetParent(self)
		self.perk_vulturesstink_logic:SetOwner(self)

		self.perk_vulturesstink_logic:Spawn()
		self.perk_vulturesstink_logic:Activate()

		self.perk_vulturesstink_logic:SetOwner(self)
		self.perk_vulturesstink_logic:UpdateDuration(duration)
		self:SetNW2Entity("PERK.VultureStinkLogic", self.perk_vulturesstink_logic)
		return self.perk_vulturesstink_logic
	end
	hook.Add("PlayerDeath", "PERK.VultureStinkLogic", function(self)
		if IsValid(self.perk_vulturesstink_logic) then
			return self.perk_vulturesstink_logic:Remove()
		end
	end)
end

entMeta.HasVultureStink = function(self)
	return IsValid(self:GetNW2Entity("PERK.VultureStinkLogic"))
end

ENT.SetupDataTables = function(self)
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("NZ.Vulture.Stink.Start")
		p:EmitSound("NZ.Vulture.Stink.Loop")
		if SERVER then
			p:SetNoTarget(true)
			if nzombies then
				p:SetTargetPriority(TARGET_PRIORITY_NONE)
			end
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

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopSound("NZ.Vulture.Stink.Loop")
		p:EmitSound("NZ.Vulture.Stink.Stop")
		if SERVER then
			p:SetNoTarget(false)

			if nzombies then
				timer.Simple(0, function()
					if not IsValid(p) then return end
					local b_test = true
					if TFA.WWNoTargetIngore and !TFA.WWNoTargetIngore(p) then
						b_test = false
					end

					if !nzPowerUps:IsPlayerPowerupActive(p, "zombieblood") and b_test then
						p:SetTargetPriority(TARGET_PRIORITY_PLAYER)
					end
				end)
			end
		end
	end
end
