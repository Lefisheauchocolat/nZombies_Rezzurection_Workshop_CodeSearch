function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Upgraded = data:GetFlags() == 2
	if not IsValid(self.WeaponEnt) then return end

	ParticleEffectAttach(self.Upgraded and "bo3_waffe_3p_2" or "bo3_waffe_3p", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end