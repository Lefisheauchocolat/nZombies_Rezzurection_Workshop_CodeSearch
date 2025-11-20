EFFECT.Mat = Material("effects/laser_tracer")
EFFECT.Col1 = Color(100, 255, 50)
EFFECT.Col2 = Color(80, 250, 80)
EFFECT.ColA = Color(255, 60, 60)
EFFECT.ColB = Color(255, 20, 20)
EFFECT.Speed = 8192
EFFECT.TracerLength = 512

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

//Init( data table )
function EFFECT:Init(data)
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.random = math.random(2)
	if self.random == 2 then
		self.Col1 = self.ColA
		self.Col2 = self.ColB
	end

	if IsValid(self.WeaponEnt) and self.WeaponEnt.GetMuzzleAttachment then
		self.Attachment = self.WeaponEnt:GetMuzzleAttachment()
	end

	self.StartPos = self:GetTracerShootPos(self.Position, self.WeaponEnt, self.Attachment)
	self.EndPos = data:GetOrigin()
	self.Normal = (self.EndPos - self.StartPos):GetNormalized()
	self.Length = (self.EndPos - self.StartPos):Length()
	self.Life = 0
	self.MaxLife = self.Length / self.Speed
	self:SetRenderBoundsWS(self.StartPos, self.EndPos, Vector(1000,1000,1000))
	self.CurPos = self.StartPos

	if IsValid(self.WeaponEnt) and self.WeaponEnt:GetSilenced() then
		util.ParticleTracerEx("waw_xray_jump_"..self.random, self.StartPos, self.EndPos, false, self.WeaponEnt:EntIndex(), 0)
		ParticleEffect("waw_xray_impact_"..self.random, self.EndPos, self.Normal:Angle() - Angle(90,0,0))

		if dlight_cvar:GetBool() then
			local dlight = DynamicLight(self:EntIndex())
			local fadeouttime = 0.5

			if (dlight) then
				dlight.Pos = self.EndPos - self.Normal*6
				dlight.r = self.random == 1 and 60 or 255
				dlight.g = self.random == 1 and 255 or 50
				dlight.b = self.random == 1 and 20 or 50
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
	if IsValid(self.WeaponEnt) and self.WeaponEnt:GetSilenced() then
		return false
	end

	self.Life = self.Life + FrameTime() * (1 / self.MaxLife)
	if self.Life >= 1 then
		ParticleEffect("waw_xray_impact_"..self.random, self.EndPos, self.Normal:Angle() - Angle(90,0,0))
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
