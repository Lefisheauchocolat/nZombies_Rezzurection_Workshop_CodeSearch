EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Col1 = Color(100, 255, 50)
EFFECT.Col2 = Color(80, 250, 80)
EFFECT.Speed = 8192
EFFECT.TracerLength = 512

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

//Init( data table )
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.EndPos = data:GetOrigin()

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Life = 0
	self.MaxLife = self.Length / self.Speed
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
	self.CurPos = self.StartPos

	if IsValid(self.WeaponEnt) and self.WeaponEnt:GetSilenced() then
		ParticleEffect("waw_xray_impact_1", self.EndPos, self.Normal:Angle())

		if dlight_cvar:GetBool() then
			local dlight = DynamicLight(self:EntIndex())
			local fadeouttime = 0.5

			if (dlight) then
				dlight.Pos = self.EndPos - self.Normal*6
				dlight.r = 60
				dlight.g = 255
				dlight.b = 20
				dlight.brightness = 1
				dlight.Decay = 2000
				dlight.Size = 256
				dlight.DieTime = CurTime() + fadeouttime
			end
		end
	end
end

//Think
function EFFECT:Think()
	if self.Life == 0 and IsValid(self.WeaponEnt) and self.WeaponEnt:GetSilenced() then
		util.ParticleTracerEx("waw_xray_jump_1", self.StartPos, self.EndPos, false, self.WeaponEnt:EntIndex(), 0)
	end

	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	if self.Life >= 1 then
		if IsValid(self.WeaponEnt) and !self.WeaponEnt:GetSilenced() then
			ParticleEffect("waw_xray_impact_1", self.EndPos, self.Normal:Angle())
		end
	end

	return self.Life < 1
end

//Draw the effect
local lerpedcol = Color(225, 225, 225, 225)

function EFFECT:Render()
	if IsValid(self.WeaponEnt) and self.WeaponEnt:GetSilenced() then return end

	render.SetMaterial(self.Mat)
	lerpedcol.r = Lerp(self.Life, self.Col1.r, self.Col2.r)
	lerpedcol.g = Lerp(self.Life, self.Col1.g, self.Col2.g)
	lerpedcol.b = Lerp(self.Life, self.Col1.b, self.Col2.b)
	lerpedcol.a = Lerp(self.Life, self.Col1.a, self.Col2.a)
	local startbeampos = Lerp(self.Life, self.StartPos, self.EndPos)
	local endbeampos = Lerp(self.Life + self.TracerLength / self.Length, self.StartPos, self.EndPos)
	render.DrawBeam(startbeampos, endbeampos, 5, 0, 1, lerpedcol)
end
