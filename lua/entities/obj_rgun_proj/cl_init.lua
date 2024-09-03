AddCSLuaFile()
include("shared.lua")

function ENT:Initialize()
	ParticleEffectAttach( self:GetUpgraded() and "raygun_trail_pap" or "raygun_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
end