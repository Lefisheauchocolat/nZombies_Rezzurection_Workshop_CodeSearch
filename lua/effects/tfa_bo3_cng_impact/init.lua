EFFECT.Life      = 0.085
EFFECT.HeatSize  = 0.70
EFFECT.FlashSize = 0.70

local ang_correct = Angle(90,0,0)
function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local ang = data:GetNormal():Angle() + ang_correct
	local charged = tobool(data:GetFlags() > 1)

	if charged then
		ParticleEffect("bo3_cng_charge_hit", pos, ang)
	end
	ParticleEffect("bo3_cng_hit", pos, ang)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end