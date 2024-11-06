function EFFECT:Init(data)
	self.Origin = data:GetOrigin()
	self.Angles = data:GetAngles()

	local dlight = DynamicLight(self:EntIndex(), false)
	if dlight then
		dlight.pos = self:GetPos()
		dlight.r = 220
		dlight.g = 60
		dlight.b = 225
		dlight.brightness = 1
		dlight.Decay = 500
		dlight.Size = 350
		dlight.DieTime = CurTime() + 1
	end

	CreateParticleSystemNoEntity("nz_perks_phd", self.Origin, self.Angles)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end