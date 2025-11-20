include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()
end

function ENT:GetNZTargetText()
	if (view_cvar:GetBool()) then return end
	if nzRound:InState(ROUND_CREATE) then
		return "P.E.S. Spawn"
	end

	if self:GetActive() then
		local ply = LocalPlayer()
		if ply:HasWeapon('tfa_bo3_pes') then
			return "Already carrying P.E.S."
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Pressurized External Suit"
		end
	else
		return "You must turn on the electricity first!"
	end
end

function ENT:IsTranslucent()
	return true
end