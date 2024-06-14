AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Blur Screen Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.PerkBlur = function(self, duration)
		if duration == nil then
			duration = 0
		end

		if IsValid(self.perk_blurscreen_logic) then
			self.perk_blurscreen_logic:UpdateDuration(duration)
			return self.perk_blurscreen_logic
		end

		self.perk_blurscreen_logic = ents.Create("status_effect_perkblur")
		self.perk_blurscreen_logic:SetPos(self:GetPos())
		self.perk_blurscreen_logic:SetParent(self)
		self.perk_blurscreen_logic:SetOwner(self)

		self.perk_blurscreen_logic:Spawn()
		self.perk_blurscreen_logic:Activate()

		self.perk_blurscreen_logic:SetOwner(self)
		self.perk_blurscreen_logic:UpdateDuration(duration)
		self:SetNW2Entity("PERK.BlurLogic", self.perk_blurscreen_logic)
		return self.perk_blurscreen_logic
	end
	hook.Add("PlayerDeath", "PERK.BlurLogic", function(self)
		if IsValid(self.perk_blurscreen_logic) then
			return self.perk_blurscreen_logic:Remove()
		end
	end)
end

entMeta.PerkBlurIntensity = function(self)
	local ent = self:GetNW2Entity("PERK.BlurLogic")
	if not IsValid(ent) then return 0 end

	return math.Clamp((ent.statusEnd - CurTime()) / ent.duration, 0, 1)
end

entMeta.HasPerkBlur = function(self)
	return IsValid(self:GetNW2Entity("PERK.BlurLogic"))
end

ENT.SetupDataTables = function(self)
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	//if CLIENT then return end
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

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
end
