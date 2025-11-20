EFFECT.Mat = Material("cable/smoke")
EFFECT.DotMat = Material("effects/hypelaserdot")

EFFECT.Color1 = Color(255, 40, 40, 255)
EFFECT.Color2 = Color(255, 0, 0, 255)

EFFECT.TracerWidth = 32 //max size of tractor beam at fullcharge
EFFECT.MaxLife = 0.2

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
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))

	if self.HitWorld then
		ParticleEffect("bo1_icelazer_impact", self.EndPos, self.HitNormal:Angle())
		util.Decal("Scorch", self.EndPos - self.HitNormal, self.EndPos + self.HitNormal)
	end
end

//Think
function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	return self.Life < 1
end

//Draw the effect
local lerpedcol = Color(225, 225, 225, 225)

function EFFECT:Render()
	lerpedcol.r = Lerp(self.Life, self.Color1.r, self.Color2.r)
	lerpedcol.g = Lerp(self.Life, self.Color1.g, self.Color2.g)
	lerpedcol.b = Lerp(self.Life, self.Color1.b, self.Color2.b)
	lerpedcol.a = Lerp(self.Life, self.Color1.a, self.Color2.a)

	local time = (1 - self.Life)

	render.SetMaterial(self.Mat)
	render.DrawBeam(self.StartPos, self.EndPos, self.TracerWidth*time, 0, 0, lerpedcol)

	render.SetMaterial(self.DotMat)
	render.DrawSprite(self.EndPos, self.TracerWidth*time, self.TracerWidth*time, lerpedcol)
end
