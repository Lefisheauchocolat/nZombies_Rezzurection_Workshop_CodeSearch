local pcftime = 0

function EFFECT:Init(data)
	self.Owner = data:GetEntity()
	self.StartTime = CurTime()
	self.SlideTime = data:GetScale()
	self.Velocity = self.Owner:GetVelocity()

	self.Owner.PHDSliderFX = self
end

function EFFECT:Think()
	if IsValid(self.Owner) then
		self:SetPos(self.Owner:GetPos())
		self.Velocity = self.Owner:GetVelocity()

		if self.FuckOff and self.Owner.PHDSliderFX == self then
			self.Owner.PHDSliderFX = nil
		end
	end

	if pcftime < CurTime() then
		pcftime = CurTime() + (1/30)
		CreateParticleSystemNoEntity("nz_perks_phd_slide_fire", self:GetPos() + (self.Velocity*engine.TickInterval()), self.Velocity:Angle())
	end

	return IsValid(self.Owner) and self.StartTime and self.SlideTime and (self.StartTime + self.SlideTime) > CurTime() and !(self.FuckOff or game.SinglePlayer() and !self.Owner:GetSliding())
end

function EFFECT:Render()
	//light
	self.Dlight = self.DLight or DynamicLight(self:EntIndex(), false)
	if self.Dlight then
		local ratio = math.Clamp(((self.StartTime + self.SlideTime) - CurTime())/self.SlideTime, 0, 1)
		ratio = math.Remap(ratio, 0, 1, 0.5, 1)

		self.Dlight.pos = self:GetPos()
		self.Dlight.r = 220
		self.Dlight.g = 60
		self.Dlight.b = 225
		self.Dlight.brightness = 0.5
		self.Dlight.Decay = 2000
		self.Dlight.Size = 256*ratio
		self.Dlight.DieTime = CurTime() + 1
	end
end
