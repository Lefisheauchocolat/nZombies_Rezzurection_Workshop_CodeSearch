EFFECT.Life      = 0.085
EFFECT.HeatSize  = 0.70
EFFECT.FlashSize = 0.70

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	ParticleEffectAttach("waw_crossbow_attach_3p", PATTACH_POINT_FOLLOW, data:GetEntity(), data:GetAttachment())    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end