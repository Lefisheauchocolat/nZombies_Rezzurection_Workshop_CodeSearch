include("shared.lua")

function ENT:Draw()
	if !self.LightningEffects or !IsValid(self.LightningEffects) then
		self.LightningEffects = CreateParticleSystem(self, self:GetUpgraded() and "nz_perks_banana_goop_acid" or "nz_perks_banana_goop", PATTACH_POINT_FOLLOW, 0)
	end
end

function ENT:IsTranslucent()
	return true
end