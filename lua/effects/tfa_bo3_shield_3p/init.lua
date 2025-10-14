function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end

	ParticleEffectAttach("bo3_shield_electrify", PATTACH_ABSORIGIN_FOLLOW, self.WeaponEnt, 0)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end