local pcftime = 0

function EFFECT:Init(data)
	self.Owner = data:GetEntity()
	self.SlideTime = CurTime() + data:GetScale()
	self.Velocity = self.Owner:GetVelocity()
end

function EFFECT:Think()
	if IsValid(self.Owner) then
		self:SetPos(self.Owner:GetPos())
		self.Velocity = self.Owner:GetVelocity()
	end

	pcftime = pcftime + 1
	if pcftime%3 == 0 then
		CreateParticleSystemNoEntity("nz_perks_phd_slide_fire", self:GetPos() + (self.Velocity*engine.TickInterval()), self.Velocity:Angle())
	end

	return IsValid(self.Owner) and self.SlideTime and self.SlideTime > CurTime()
end

function EFFECT:Render()
	//light
	self.Dlight = self.DLight or DynamicLight(self:EntIndex(), false)
	if self.Dlight then
		self.Dlight.pos = self:GetPos()
		self.Dlight.r = 220
		self.Dlight.g = 60
		self.Dlight.b = 225
		self.Dlight.brightness = 0.5
		self.Dlight.Decay = 2000
		self.Dlight.Size = 256
		self.Dlight.DieTime = CurTime() + 1
	end
end
