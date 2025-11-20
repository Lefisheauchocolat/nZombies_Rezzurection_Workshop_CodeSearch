EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Col1 = Color(120, 240, 255)
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
	self.TracerLength = self.Distance

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Life = 0
	self.MaxLife = 0.1
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))

	self.EndPos = self.StartPos + (self.Normal *  math.Clamp(self.Length, 0, self.Distance))
	self.PFx = CreateParticleSystem(self, "bo2_frostgat_tracer", PATTACH_ABSORIGIN, 0)
	self.PFx:SetControlPoint(0, self.StartPos)
	self.PFx:SetControlPoint(1, self.EndPos)
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
function EFFECT:Render()
	render.SetMaterial(self.Mat)
	local startbeampos = Lerp(self.Life, self.StartPos, self.EndPos)
	local endbeampos = Lerp(self.Life + self.TracerLength / self.Length, self.StartPos, self.EndPos)
	render.DrawBeam(startbeampos, endbeampos, 6, 0, 1, self.Col1)
end
