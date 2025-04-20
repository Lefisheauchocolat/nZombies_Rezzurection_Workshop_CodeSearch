include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Think()
	if self:GetOverride() then
		if not self.NZHudIcon and nzRound:InState(ROUND_CREATE) then
			local build = self:GetBuildable()
			local tbl = nzBuilds:GetBuildParts(build)
			local id = self:GetPartID()
			local icon = tbl[id].icon
			self.NZHudIcon = icon
		elseif self.NZHudIcon and nzRound:InProgress() then
			self.NZHudIcon = nil
		end
	end
end

function ENT:Draw()
	local ply = LocalPlayer()
	if self:GetRed() and not self:GetSemtexHack() then
		if not ply.GetShovel or not IsValid(ply:GetShovel()) or not ply:GetShovel():IsGolden() then return end
		if not nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then return end
	end
	self:DrawModel()
end

function ENT:GetNZTargetText()
	if not nzRound:InProgress() then
		if self:GetOverride() then
			local build = self:GetBuildable()
			local name = nzBuilds:GetBuildable(build).name
			local parttab = nzBuilds:GetBuildParts(build)
			local partname = parttab[self:GetPartID()].id
			return "Dig Site | "..name.." | "..partname..""
		else
			return "Dig Site"
		end
	end

	if self:GetActivated() then return end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply.GetShovel and IsValid(ply:GetShovel()) then
		if self:GetRed() then
			if not ply:GetShovel():IsGolden() then return end
			if not nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then return end
		end

		return "Press & Hold "..string.upper(input.LookupBinding("+USE")).." - Dig"
	else
		return "Shovel Required"
	end
end

function ENT:IsTranslucent()
	return true
end