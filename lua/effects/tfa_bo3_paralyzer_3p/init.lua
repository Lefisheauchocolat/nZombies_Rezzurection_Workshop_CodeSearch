local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function EFFECT:Init(data)
	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	self.Dir = data:GetNormal()
	self.Upgraded = data:GetFlags() > 0

	local owent

	if IsValid(self.WeaponEnt) then
		owent = self.WeaponEnt:GetOwner()
	end

	if not IsValid(owent) then
		owent = self.WeaponEnt:GetParent()
	end

	if IsValid(owent) and owent:IsPlayer() then
		if owent ~= LocalPlayer() or owent:ShouldDrawLocalPlayer() then
			self.WeaponEnt = owent:GetActiveWeapon()
			if not IsValid(self.WeaponEnt) then return end
		end
	end

	if IsValid(self.WeaponEntOG) and self.WeaponEntOG.MuzzleAttachment then
		self.Attachment = self.WeaponEnt:LookupAttachment(self.WeaponEntOG.MuzzleAttachment)

		if not self.Attachment or self.Attachment <= 0 then
			self.Attachment = 1
		end
	end

	local angpos = self.WeaponEnt:GetAttachment(self.Attachment)
	if not angpos or not angpos.Pos then
		angpos = {
			Pos = vector_origin,
			Ang = angle_zero
		}
	end

	self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)

	self.MaxLife = engine.TickInterval()
	self.LifeTime = self.MaxLife

	if self.WeaponEntOG:IsCarriedByLocalPlayer() && !LocalPlayer():ShouldDrawLocalPlayer() then
		ParticleEffectAttach(self.Upgraded and "bo3_paralyzer_muzzleflash_pap" or "bo3_paralyzer_muzzleflash", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
	else
		ParticleEffectAttach(self.Upgraded and "bo3_paralyzer_muzzleflash_3p_pap" or "bo3_paralyzer_muzzleflash_3p", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
	end
end

function EFFECT:Think()
	if IsValid(self.WeaponEnt) and (self.WeaponEnt:GetStatus() == TFA.Enum.STATUS_SHOOTING) then
		self.LifeTime = self.MaxLife
	else
		self.LifeTime = self.LifeTime - RealFrameTime()
	end

	if IsValid(self.WeaponEnt) and dlight_cvar:GetBool() then
		local angpos = self.WeaponEnt:GetAttachment(self.Attachment)
		if not angpos or not angpos.Pos then
			angpos = {
				Pos = vector_origin,
				Ang = angle_zero
			}
		end

		self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)

    	local dlight

    	if IsValid(self.WeaponEnt) then
    		dlight = DynamicLight(self.WeaponEnt:EntIndex())
    	else
    		dlight = DynamicLight(0)
    	end

    	local fadeouttime = 0.5
 
    	if (dlight) then
    		dlight.Pos = self.Position + self.Dir * 1 - self.Dir:Angle():Right() * 5
    		dlight.r = self.Upgraded and 255 or 120
    		dlight.g = self.Upgraded and 165 or 150
    		dlight.b = self.Upgraded and 195 or 255
    		dlight.brightness = 1
    		dlight.Decay = 4000
    		dlight.Size = 256
    		dlight.DieTime = CurTime() + fadeouttime
    	end
	end

	if self.LifeTime <= 0 and IsValid(self.WeaponEnt) then
		self.WeaponEnt:CleanParticles()
	end

	return self.LifeTime > 0
end

function EFFECT:Render()
end
