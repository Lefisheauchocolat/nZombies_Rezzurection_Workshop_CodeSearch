EFFECT.Life = 0
EFFECT.MaxLife = 1

local ang_correct = Angle(90,0,0)
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.EndPos = data:GetOrigin()

	self.Life = 0
	self.MaxLife = 0.4
	self:SetRenderBoundsWS(self.Position, self.EndPos, Vector(1000,1000,1000))

	self.PFx = CreateParticleSystem(self, "bo3_cng_tether", PATTACH_ABSORIGIN, 0)
	self.PFx:SetControlPoint(0, self.Position)
	self.PFx:SetControlPoint(1, self.EndPos)
end

function EFFECT:Think()
	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	if self.Life >= 1 and self.PFx and self.PFx:IsValid() then
		self.PFx:StopEmission()
	end

	return self.Life < 1
end

function EFFECT:Render()
end