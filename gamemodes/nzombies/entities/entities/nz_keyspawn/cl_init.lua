include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	if self:GetUsed() then
		if self.pvslight and IsValid(self.pvslight) then
			self.pvslight:StopEmission()
		end
		return
	end

	self:DrawModel()

	local color = self:GetCustomGlow()
	if (!self.pvslight or !IsValid(self.pvslight)) and color ~= vector_origin then
		local glow = CreateParticleSystem(self, "nzr_key_loop", PATTACH_ABSORIGIN_FOLLOW)
		glow:SetControlPoint(2, color)
		self.pvslight = glow
	end
end

function ENT:Initialize()
	if self:GetHudIcon() ~= "" and file.Exists("materials/"..self:GetHudIcon(), "GAME") then
		self.NZHudIcon = Material(self:GetHudIcon(), "unlitgeneric smooth")
	end
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local consume = self:GetSingleUse() and " | Single Use" or ""
		local num = 0
		for k, v in pairs(ents.FindByClass("nz_keyspawn")) do
			num = num + 1
			if v == self then break end
		end
		local fuckered = self:GetFlag() ~= "" and " | Flag '"..self:GetFlag().."'" or ""

		return "Key "..num.." | '"..self:GetPickupHint().."'"..consume..fuckered
	end

	if self:GetUsed() then return end
	return "Press "..string.upper(input.LookupBinding("+USE")).." - "..self:GetPickupHint()
end

function ENT:IsTranslucent()
	return true
end
