AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Transfur Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local nzombies = engine.ActiveGamemode() == "nzombies"
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO3Vril = function(self, duration, upgrade, assist)
		if upgrade == nil then
			upgrade = false
		end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo3_vrillgun_logic) then
			self.bo3_vrillgun_logic:UpdateDuration(duration)
			return self.bo3_vrillgun_logic
		end

		self.bo3_vrillgun_logic = ents.Create("bo3_status_effect_vr11")
		self.bo3_vrillgun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_vrillgun_logic:SetParent(self)
		self.bo3_vrillgun_logic:SetOwner(self)
		self.bo3_vrillgun_logic:SetUpgraded(upgrade)
		if assist then
			self.bo3_vrillgun_logic:SetAssist(assist)
		end

		self.bo3_vrillgun_logic:Spawn()
		self.bo3_vrillgun_logic:Activate()

		self.bo3_vrillgun_logic:SetOwner(self)

		self.bo3_vrillgun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.VrillLogic", self.bo3_vrillgun_logic)
		return self.bo3_vrillgun_logic
	end

	hook.Add("PlayerDeath", "BO3.VrillLogic", function(self)
		if IsValid(self.bo3_vrillgun_logic) then
			return self.bo3_vrillgun_logic:Remove()
		end
	end)
end

entMeta.BO3IsTransfur = function(self)
	return IsValid(self:GetNW2Entity("BO3.VrillLogic"))
end

entMeta.BO3IsTransfurPAP = function(self)
	if not IsValid(self:GetNW2Entity("BO3.VrillLogic")) then return nil end
	return self:GetNW2Entity("BO3.VrillLogic"):GetUpgraded()
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Entity", 0, "Assist")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO3_VR11.Effect.OneShot")
		if SERVER then
			p:SetNoTarget(true)
			if p.SetTargetPriority then
				p:SetTargetPriority(TARGET_PRIORITY_NONE)
			end
		end
		ParticleEffectAttach("bo3_vr11_player_smoke", PATTACH_POINT_FOLLOW, p, 0)
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

	local p = self:GetParent()
	if IsValid(p) then
		p:SetNoTarget(true)
		if p.SetTargetPriority then
			p:SetTargetPriority(TARGET_PRIORITY_NONE)
		end
	end

	self.duration = newtime
	self.statusEnd = self.statusEnd + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if p:Health() <= 0 then
			p:StopParticles()
			self:Remove()
			return false
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
	if IsValid(p) then
		p:StopParticles()
		if SERVER then
			p:SetNoTarget(false)
			if nzombies and !nzPowerUps:IsPlayerPowerupActive(p, "zombieblood") then
				p:SetTargetPriority(TARGET_PRIORITY_PLAYER)
			end
		end
	end
end

ENT.Draw = function(self)
end