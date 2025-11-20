EFFECT.Life      = 0.085
EFFECT.HeatSize  = 0.70
EFFECT.FlashSize = 0.70

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	ParticleEffectAttach(data:GetFlags() == 2 and "bo1_molotov_trail_2" or "bo1_molotov_trail", PATTACH_POINT_FOLLOW, data:GetEntity(), data:GetAttachment())    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end