EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Col1 = Color(255, 250, 245)
EFFECT.Col2 = Color(255, 255, 255)
EFFECT.Speed = 4096
EFFECT.TracerLength = 256

//Init( data table )
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.Distance = 4096
	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
		self.Distance = self.WeaponEnt.Primary.Range
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Life = 0
	self.MaxLife = 1.2
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))

	self.PFx = CreateParticleSystem(self, "waw_tpistol_tracer", PATTACH_ABSORIGIN, 0)
	self.PFx:SetControlPoint(0, self.StartPos)
	self.PFx:SetControlPoint(1, self.StartPos + (self.Normal *  math.Clamp(self.Length, 0, self.Distance)))
end

//Think
function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	if self.Life >= 1 and self.PFx and self.PFx:IsValid() then
		self.PFx:StopEmission()
	end

	return self.Life < 1
end

//Draw the effect
local lerpedcol = Color(225, 225, 225, 225)

function EFFECT:Render()
	/*render.SetMaterial(self.Mat)
	lerpedcol.r = Lerp(self.Life, self.Col1.r, self.Col2.r)
	lerpedcol.g = Lerp(self.Life, self.Col1.g, self.Col2.g)
	lerpedcol.b = Lerp(self.Life, self.Col1.b, self.Col2.b)
	lerpedcol.a = Lerp(self.Life, self.Col1.a, self.Col2.a)
	local startbeampos = Lerp(self.Life, self.StartPos, self.EndPos)
	local endbeampos = Lerp(self.Life + self.TracerLength / self.Length, self.StartPos, self.EndPos)
	render.DrawBeam(startbeampos, endbeampos, 5, 0, 1, lerpedcol)*/
end
