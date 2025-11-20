EFFECT.Mat = Material("effects/laser_citadel1")
EFFECT.DotMat = Material("effects/hypelaserdot")
EFFECT.LampMat = Material("effects/tfalaserdot")

EFFECT.LaserDistance = 1000
EFFECT.LaserThickness = 4 //multiplied by math.random(5)
EFFECT.LaserFOV = 12

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
		self.OwnerEnt = self.WeaponEnt:GetOwner()
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()

	self.MaxLife = engine.TickInterval()
	self.LifeTime = self.MaxLife
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
end

function EFFECT:Think()
	if IsValid(self.WeaponEnt) and (self.WeaponEnt:GetStatus() == TFA.Enum.STATUS_CHARGE_UP) then
		self.LifeTime = self.MaxLife
	else
		self.LifeTime = self.LifeTime - FrameTime()
	end

	if self.LifeTime <= 0 and IsValid(self.TFALaserDot) then
		self.TFALaserDot:Remove()
	end

	return self.LifeTime > 0
end

function EFFECT:Render()
	local progress = 1
	local rand = math.random(5)

	if self.WeaponEnt and IsValid(self.WeaponEnt) then
		self.StartPos = self:GetTracerShootPos(self.StartPos, self.WeaponEnt, self.Attachment)
		progress = math.max(self.WeaponEnt:GetStatusProgress(), 0.05)

		if self.OwnerEnt and IsValid(self.OwnerEnt) and self.OwnerEnt:IsPlayer() then
			local tr = util.QuickTrace(self.OwnerEnt:GetShootPos(), self.WeaponEnt:GetAimVector()*self.LaserDistance, {self.OwnerEnt, self.WeaponEnt})
			self.EndPos = tr.HitPos
			self.Normal = (self.EndPos - self.StartPos):GetNormalized()
		end
	end

	if not IsValid(self.TFALaserDot) then
		local lamp = ProjectedTexture()
		self.TFALaserDot = lamp
		lamp:SetTexture(self.LampMat:GetString("$basetexture"))
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

	local width = (self.LaserThickness * progress * rand)

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.EndPos, width, width, self.Color2)

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, width, 0, 1, self.Color2)

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.StartPos, width*2, width*2, self.Color2)
end