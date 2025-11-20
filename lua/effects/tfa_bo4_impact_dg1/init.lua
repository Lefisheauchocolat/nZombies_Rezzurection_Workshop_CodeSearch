local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local norm = data:GetNormal()
	local ply = data:GetEntity()

	if dlight_cvar:GetBool() then
		local dlight
    	if IsValid(ply) then
    		dlight = DynamicLight(ply:EntIndex())
    	else
    		dlight = DynamicLight(0)
    	end

    	local fadeouttime = 0.25
    	if (dlight) then
    		dlight.Pos = pos + norm*4
    		dlight.r = 255
    		dlight.g = 250
    		dlight.b = 90
    		dlight.brightness = 1
    		dlight.Decay = 1200
    		dlight.Size = 256
    		dlight.DieTime = CurTime() + fadeouttime
    	end
    end

    ParticleEffect("bo4_dg1_impact", pos + norm, -norm:Angle())
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end