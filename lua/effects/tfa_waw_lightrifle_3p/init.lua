function EFFECT:Init(data)
	if not IsValid(data:GetEntity()) then return end
	self.Upgraded = data:GetFlags() == 2
	ParticleEffectAttach(self.Upgraded and "waw_lightrifle_3p_2" or "waw_lightrifle_3p", PATTACH_POINT_FOLLOW, data:GetEntity(), data:GetAttachment())    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end