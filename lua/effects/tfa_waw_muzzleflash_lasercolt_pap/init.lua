local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local vec_blue = Vector(0.08, 0.08, 1)
local col_blue = Color(20, 20, 255, 255)

function EFFECT:Init(data)
	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	self.Dir = data:GetNormal()
	self.Color = col_blue
	self.PColor = vec_blue

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
		else
			self.WeaponEnt = owent:GetViewModel()

			local theirweapon = owent:GetActiveWeapon()

			if IsValid(theirweapon) and theirweapon.ViewModelFlip or theirweapon.ViewModelFlipped then
				self.Flipped = true
			end

			if not IsValid(self.WeaponEnt) then return end
		end

		local pvcol = owent:GetPlayerColor()
		local pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		self.Color = pcolor
		self.PColor = pvcol
	end

	if IsValid(self.WeaponEntOG) and self.WeaponEntOG.MuzzleAttachment then
		self.Attachment = self.WeaponEnt:LookupAttachment(self.WeaponEntOG.MuzzleAttachment)

		if not self.Attachment or self.Attachment <= 0 then
			self.Attachment = 1
		end

		if self.WeaponEntOG.Akimbo then
			self.Attachment = 2 - self.WeaponEntOG.AnimCycle
		end
	end

	local angpos = self.WeaponEnt:GetAttachment(self.Attachment)

	if not angpos or not angpos.Pos then
		angpos = {
			Pos = vector_origin,
			Ang = angle_zero
		}
	end

	if self.Flipped then
		local tmpang = (self.Dir or angpos.Ang:Forward()):Angle()
		local localang = self.WeaponEnt:WorldToLocalAngles(tmpang)
		localang.y = localang.y + 180
		localang = self.WeaponEnt:LocalToWorldAngles(localang)
		self.Dir = localang:Forward()
	end

	self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)
	self.Norm = self.Dir

	local dir = self.Norm

	if dlight_cvar:GetBool() then
    	local dlight

    	if IsValid(self.WeaponEnt) then
    		dlight = DynamicLight(self.WeaponEnt:EntIndex())
    	else
    		dlight = DynamicLight(0)
    	end

    	local fadeouttime = 0.1
 
    	if (dlight) then
    		dlight.Pos = self.Position + dir * 1 - dir:Angle():Right() * 5
    		dlight.r = self.Color.r
    		dlight.g = self.Color.g
    		dlight.b = self.Color.b
    		dlight.brightness = 0.5
    		dlight.Decay = 2500
    		dlight.Size = 200
    		dlight.DieTime = CurTime() + fadeouttime
    	end
	end

	local glow = CreateParticleSystem(self.WeaponEnt, "waw_lasercolt_muzzleflash_2", PATTACH_POINT_FOLLOW, self.Attachment)
	if self.PColor then
		glow:SetControlPoint(2, self.PColor)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end