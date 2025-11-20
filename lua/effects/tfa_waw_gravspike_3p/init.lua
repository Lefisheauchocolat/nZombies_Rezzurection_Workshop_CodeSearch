EFFECT.Life      = 0.085
EFFECT.HeatSize  = 0.70
EFFECT.FlashSize = 0.70

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	if not IsValid(self.WeaponEnt) then return end

	if !self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid() then
		self.CL_FPDrawFX = CreateParticleSystem(self.WeaponEnt, "waw_gravspike_3p_trail", PATTACH_POINT_FOLLOW, self.Attachment)
	end

	local WorldModelElements = self.WeaponEnt:GetStatRaw("WorldModelElements", TFA.LatestDataVersion)
	if WorldModelElements and WorldModelElements['grav_dw'] and IsValid(WorldModelElements['grav_dw'].curmodel) then
		local wmodel = WorldModelElements['grav_dw'].curmodel
		if !self.CL_3PDrawFXb or !self.CL_3PDrawFXb:IsValid() then
			self.CL_3PDrawFXb = CreateParticleSystem(wmodel, "waw_gravspike_3p_trail", PATTACH_POINT_FOLLOW, self.Attachment)
		end
	end
end

function EFFECT:Think()
	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetDG4Slamming and self.WeaponEnt:GetDG4Slamming() then
		if !self.WeaponEnt:IsCarriedByLocalPlayer() or !self.WeaponEnt:IsFirstPerson() then
			return true
		end
	end

	if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
		self.CL_FPDrawFX:StopEmission()
		self.CL_FPDrawFX = nil
	end
	if self.CL_3PDrawFXb and IsValid(self.CL_3PDrawFXb) then
		self.CL_3PDrawFXb:StopEmission()
		self.CL_3PDrawFXb = nil
	end
	return false
end

function EFFECT:Render()
end