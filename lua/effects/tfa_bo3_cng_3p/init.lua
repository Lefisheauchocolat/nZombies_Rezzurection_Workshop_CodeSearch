function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	ParticleEffectAttach("bo3_cng_charge_3p", PATTACH_POINT_FOLLOW, data:GetEntity(), data:GetAttachment())    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end