EFFECT.Mat = Material("cable/smoke")
EFFECT.Mat2 = Material("cable/redlaser")
EFFECT.DotMat = Material("effects/hypelaserdot")
EFFECT.RingMat = Material("effects/select_ring")

EFFECT.LaserDistance = 250
EFFECT.LaserThickness = 12
EFFECT.LaserFOV = 12
EFFECT.LaserFade = 0.15
EFFECT.LaserDistance = 1000

EFFECT.Color = Color(255, 10, 10, 255)

EFFECT.Ratio = 1

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local cuntas, pcftime = 1, 0

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Upgraded = data:GetFlags() == 2
	self.Hit = data:GetMagnitude() == 2
	self.HitNormal = data:GetNormal()

	self.StartPos = self:GetTracerShootPos(data:GetStart(), self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.LaserDistance = self.WeaponEnt.BeamDistance
		self.Upgraded = self.WeaponEnt.Ispackapunched
	end

	if self.Upgraded then
		self.Color = Color(20, 20, 255, 255)
		self.Mat2 = Material("cable/blue_elec")
	end

	local distance_sqr = self.LaserDistance*self.LaserDistance
	self.Ratio = math.Clamp(self.StartPos:DistToSqr(self.EndPos) / distance_sqr, 0, 1)

	self.StartTime = game.SinglePlayer() and CurTime() or SysTime() + (self.LaserFade*0.5)
	self.MaxLife = self.LaserFade
	self.LifeTime = self.MaxLife

	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
end

function EFFECT:Think()
	self.LifeTime = self.LifeTime - FrameTime()

	if self.LifeTime <= 0 then
		if self.WeaponEnt and IsValid(self.WeaponEnt) then
			self.WeaponEnt:CleanParticles()
		end
		pcftime = 0
	end

	return self.LifeTime > 0
end

function EFFECT:Render()
	local ct_ = game.SinglePlayer() and CurTime() or SysTime()
	local lerp_time = (self.StartTime + self.LaserFade) - ct_
	local lerped = 1 - math.Clamp(lerp_time / self.LaserFade, 0, 0.96)
	local color = ColorAlpha(self.Color, 255*lerped)

	//light
	if dlight_cvar:GetBool() then
		self.Dlight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.Dlight then
			self.Dlight.pos = self.EndPos + self.HitNormal
			self.Dlight.r = self.Upgraded and 20 or 255
			self.Dlight.g = self.Upgraded and 20 or 10
			self.Dlight.b = self.Upgraded and 255 or 10
			self.Dlight.brightness = 1*lerped
			self.Dlight.Decay = 2000
			self.Dlight.Size = 200*lerped
			self.Dlight.DieTime = CurTime() + 0.5
		end
	end

	//impact
	pcftime = pcftime + 1
	if pcftime%3 == 0 and lerped >= 0.5 and self.Hit then
		ParticleEffect("bo3_hype_impact", self.EndPos, self.HitNormal:Angle())
		util.Decal("FadingScorch", self.EndPos - self.HitNormal, self.EndPos + self.HitNormal)
	end

	local fucker = math.Rand(0.8,1.2)*lerped

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.EndPos, 64*fucker, 64*fucker, ColorAlpha(self.Color, math.Rand(180, 255)*lerped))

	render.SetMaterial(self.DotMat)
	render.DrawQuadEasy(self.EndPos + self.HitNormal, self.HitNormal, 64*fucker, 64*fucker, color, math.Rand(-180,180))

	//beam
	cuntas = cuntas - FrameTime()
	if cuntas < 0 then cuntas = 1 end

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, self.LaserThickness*lerped, cuntas, (1*self.Ratio)+cuntas, color)

	render.SetMaterial(self.Mat2)
	render.DrawBeam(self.StartPos, self.EndPos, self.LaserThickness*lerped, cuntas, (1*self.Ratio)+cuntas, color)
end
