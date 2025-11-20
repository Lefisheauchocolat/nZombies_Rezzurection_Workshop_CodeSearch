EFFECT.Life      = 0.085

function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	local flag = data:GetFlags() or 0
	local cyborg = flag > 0
	ParticleEffectAttach(tobool(cyborg) and "bo2_jetgun_shread_blue" or "bo2_jetgun_grind", PATTACH_POINT_FOLLOW, data:GetEntity(), data:GetAttachment())    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end