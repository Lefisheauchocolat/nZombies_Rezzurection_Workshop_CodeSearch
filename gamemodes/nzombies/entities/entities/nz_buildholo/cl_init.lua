include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()
end

function ENT:IsTranslucent()
	return true
end