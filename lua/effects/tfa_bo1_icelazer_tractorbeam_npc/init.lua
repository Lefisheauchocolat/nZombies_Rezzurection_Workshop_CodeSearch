EFFECT.Mat = Material("effects/laser_citadel1")
EFFECT.DotMat = Material("effects/tfalaserdot")
EFFECT.LaserDistance = 1000
EFFECT.LaserThickness = 4
EFFECT.LaserFOV = 10
EFFECT.Color = Color(255, 10, 10, 255)
EFFECT.Color2 = Color(255, 40, 40, 255)

function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
		if self.WeaponEnt.Primary.CylinderRange then
			self.LaserDistance = self.WeaponEnt.Primary.CylinderRange
		end
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()

	self.MaxLife = 0.025
	self.LifeTime = self.MaxLife
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
end

function EFFECT:Think()
	self.LifeTime = self.LifeTime - FrameTime()
	if self.LifeTime <= 0 and IsValid(self.TFALaserDot) then
		self.TFALaserDot:Remove()
	end

	return self.LifeTime > 0
end

function EFFECT:Render()
	local progress = 1
	local mult = math.random(2, 10) * 0.1
	local rand = math.random(5)

	if self.WeaponEnt and IsValid(self.WeaponEnt) then
		self.StartPos = self:GetTracerShootPos(self.StartPos, self.WeaponEnt, self.Attachment)
		progress = self.WeaponEnt:GetStatusProgress()
	end

	if not IsValid(self.TFALaserDot) then
		local lamp = ProjectedTexture()
		self.TFALaserDot = lamp
		lamp:SetTexture(self.DotMat:GetString("$basetexture"))
		lamp:SetFarZ(self.LaserDistance) -- How far the light should shine
		lamp:SetFOV(self.LaserFOV)
		lamp:SetPos(self.StartPos)
		lamp:SetAngles(self.Normal:Angle())
		lamp:SetBrightness(12)
		lamp:SetNearZ(1)
		lamp:SetEnableShadows(false)
		lamp:Update()
	end

	local lamp = self.TFALaserDot

	if IsValid(lamp) then
		local ang = self.Normal:Angle()
		ang:RotateAroundAxis(ang:Forward(), math.Rand(-180, 180))
		lamp:SetPos(self.StartPos)
		lamp:SetAngles(ang)
		lamp:SetColor(self.Color)
		lamp:SetFOV(self.LaserFOV * progress * (rand * 0.5))
		lamp:Update()
	end

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, (self.LaserThickness * progress * rand), 0, 1, self.Color2)
end