include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	if not nzRound:InState(ROUND_CREATE) then return end
	self:DrawModel()
end

function ENT:IsTranslucent()
	return true
end