EFFECT.Mat = Material("effects/laser_citadel1")
EFFECT.Mat2 = Material("cable/smoke")
EFFECT.DotMat = Material("effects/hypelaserdot")
EFFECT.LampMat = Material("effects/tfalaserdot")

EFFECT.LaserDistance = 1000
EFFECT.LaserThickness = 4 //multiplied by math.random(5)
EFFECT.LaserFOV = 4

EFFECT.RingStepSize = 4
EFFECT.RingTightness = 0.1
EFFECT.RingDistance = 2

EFFECT.Color = Color(255, 160, 0, 255)
EFFECT.Color2 = Color(255, 220, 0, 255)
EFFECT.Color4 = Color(255, 10, 255, 255)

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
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Ang = self.Normal:Angle()
	self.Hit = false

	self.MaxLife = engine.TickInterval()
	self.LifeTime = self.MaxLife
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
end

function EFFECT:Think()
	if IsValid(self.WeaponEnt) and (self.WeaponEnt:GetStatus() == TFA.Enum.STATUS_ICE_CHARGE_UP) then
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
			self.Ang = self.Normal:Angle()
			self.HitNormal = tr.HitNormal
			self.Hit = tr.Hit and !tr.HitSky
		end
	end

	self.Length = (self.EndPos - self.StartPos):Length()

	if not IsValid(self.TFALaserDot) then
		local lamp = ProjectedTexture()
		self.TFALaserDot = lamp
		lamp:SetTexture(self.LampMat:GetString("$basetexture"))
		lamp:SetFarZ(self.LaserDistance)
		lamp:SetFOV(self.LaserFOV)
		lamp:SetPos(self.StartPos)
		lamp:SetAngles(self.Ang)
		lamp:SetBrightness(2)
		lamp:SetNearZ(1)
		lamp:SetEnableShadows(false)
		lamp:Update()
	end

	local lamp = self.TFALaserDot

	if IsValid(lamp) then
		local ang = self.Ang
		ang:RotateAroundAxis(ang:Forward(), math.Rand(-180, 180))
		lamp:SetPos(self.StartPos)
		lamp:SetAngles(ang)
		lamp:SetColor(self.Color4)
		lamp:SetFOV(self.LaserFOV * progress * (rand * 0.5))
		lamp:Update()
	end

	local width = (self.LaserThickness * progress * rand)

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.EndPos, width, width, self.Color2)

	if self.Hit then
		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(self.EndPos, self.HitNormal, width, width, self.Color2, math.Rand(-180,180))
	end
end