local blankvec   = Vector(0, 0, 0)

EFFECT.Life = 5

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	ParticleEffectAttach("nzr_building_loop", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end