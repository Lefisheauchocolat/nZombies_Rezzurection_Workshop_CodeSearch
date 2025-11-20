EFFECT.LifeTime = 0.5

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	local flags = data:GetFlags() or 1
	self.Upgraded = flags > 1
	if not IsValid(self.WeaponEnt) then return end

	if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
		self.CL_3PDrawFX = CreateParticleSystem(self.WeaponEnt, self.Upgraded and "aw_sword_trail_3p_2" or "aw_sword_trail_3p", PATTACH_POINT_FOLLOW, self.Attachment)
	end

	self.MaxLife = 0.5
	self.LifeTime = self.MaxLife
end

function EFFECT:Think()
	if self.LifeTime then
		self.LifeTime = self.LifeTime - FrameTime()

		if IsValid(self.WeaponEnt) and self.LifeTime > 0 then
			if !self.WeaponEnt:IsCarriedByLocalPlayer() or !self.WeaponEnt:IsFirstPerson() then
				return true
			end
		end
	end

	if self.CL_3PDrawFX and IsValid(self.CL_3PDrawFX) then
		self.CL_3PDrawFX:StopEmission()
		self.CL_3PDrawFX = nil
	end

	return false
end

function EFFECT:Render()
end