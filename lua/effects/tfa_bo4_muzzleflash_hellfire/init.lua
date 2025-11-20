local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function EFFECT:Init(data)
	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()

	self.MaxLife = engine.TickInterval()
	self.LifeTime = self.MaxLife

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
	self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)

	if dlight_cvar:GetBool() then
    	if IsValid(self.WeaponEnt) then
    		self.dlight = DynamicLight(self.WeaponEnt:EntIndex())
    	else
    		self.dlight = DynamicLight(0)
    	end

		if self.dlight then
			self.dlight.Pos = self.Position
			self.dlight.r = 255
			self.dlight.g = 100
			self.dlight.b = 10
			self.dlight.brightness = 1
			self.dlight.Decay = 1000
			self.dlight.Size = 256
			self.dlight.DieTime = CurTime() + 0.2
    	end
    end

	ParticleEffectAttach("bo4_hellfire_muzzleflash", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)
end

function EFFECT:Think()
	if IsValid(self.WeaponEntOG) and (self.WeaponEntOG:GetStatus() == TFA.Enum.STATUS_SHOOTING) then
		self.LifeTime = self.MaxLife
		if self.dlight then
			local angpos = self.WeaponEnt:GetAttachment(self.Attachment)
			self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)

			self.dlight.Pos = self.Position
			self.dlight.r = 255
			self.dlight.g = 100
			self.dlight.b = 10
			self.dlight.brightness = 1
			self.dlight.Decay = 1000
			self.dlight.Size = 320 * math.Rand(0.95,1.05)
			self.dlight.DieTime = CurTime() + 0.2
		end
	else
		self.LifeTime = self.LifeTime - FrameTime()
		//self.dlight.DieTime = 0
	end

	return self.LifeTime > 0
end

function EFFECT:Render()
end