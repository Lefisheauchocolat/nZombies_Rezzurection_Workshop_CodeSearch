EFFECT.Mat = Material("effects/laser_citadel1")
EFFECT.Mat2 = Material("cable/smoke")
EFFECT.DotMat = Material("effects/hypelaserdot")

EFFECT.TracerWidth = 20
EFFECT.MaxLife = 1

EFFECT.RingStepSize = 4
EFFECT.RingTightness = 0.1
EFFECT.RingDistance = 4
EFFECT.RingSpeed = 12

EFFECT.Color = Color(255, 220, 0, 255)
EFFECT.Color2 = Color(255, 10, 255, 255)

//Init( data table )
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.HitNormal = data:GetNormal()
	self.HitWorld = (data:GetFlags() == 1)

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	self.Life = 0
	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Ang = self.Normal:Angle()

	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))

	if self.HitWorld then
		ParticleEffect("bo1_icelazer_impact", self.EndPos, self.HitNormal:Angle())
	end
end

//Think
function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	return self.Life < 1
end

//Draw the effect
function EFFECT:Render()
	local time = (1 - self.Life)

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.EndPos, self.TracerWidth*time, self.TracerWidth*time, self.Color)

	render.SetMaterial(self.Mat2)
	render.DrawBeam(self.StartPos, self.EndPos, (self.TracerWidth*0.5)*time, 0, 0, self.Color2)

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, self.TracerWidth*time, 0, 1, self.Color)

	//credit Deika for Laser Jetpack code = 436037322
	//credit DeltaWolf for Gluon Gun SWEP code i tried to use originally = 437008347

	local Forward = self.Ang:Forward()
	local Right = self.Ang:Right()
	local Up = self.Ang:Up()

	local LastPos

	for i=0, self.Length, self.RingStepSize do
		local sin = math.sin(CurTime() * -self.RingSpeed + i * self.RingTightness)
		local cos = math.cos(CurTime() * -self.RingSpeed + i * self.RingTightness)

		local curpos = self.StartPos + (Forward * i) + (Up * sin * self.RingDistance) + (Right * cos * self.RingDistance)

		if (LastPos) then
			render.SetMaterial(self.Mat2)
			render.DrawBeam(LastPos, curpos, 1*time, 0, 0, self.Color2)

			render.SetMaterial(self.Mat)
			render.DrawBeam(LastPos, curpos, 2*time, 0, 0, self.Color)
		end
		LastPos = curpos
	end
end
