local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function EFFECT:Init(data)
	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.Dir = data:GetNormal()

	if not IsValid(self.WeaponEnt) then return end

	local angpos = self.WeaponEnt:GetAttachment(self.Attachment)

	if not angpos or not angpos.Pos then
		angpos = {
			Pos = vector_origin,
			Ang = angle_zero
		}
	end

	self.Position = self:GetTracerShootPos(angpos.Pos, self.WeaponEnt, self.Attachment)
	self.Norm = self.Dir

	local dir = self.Norm
		
	if dlight_cvar:GetBool() then
    	local dlight

    	if IsValid(self.WeaponEnt) then
    		dlight = DynamicLight(self.WeaponEnt:EntIndex())
    	else
    		dlight = DynamicLight(0)
    	end

    	local fadeouttime = 0.1
 
    	if (dlight) then
    		dlight.Pos = self.Position + dir * 1 - dir:Angle():Right() * 5
    		dlight.r = 50
    		dlight.g = 235
    		dlight.b = 20
    		dlight.brightness = 1
    		dlight.Decay = 500
    		dlight.Size = 256
    		dlight.DieTime = CurTime() + fadeouttime
    	end
   end

	ParticleEffectAttach("bo3_mk3_muzzleflash", PATTACH_POINT_FOLLOW, self.WeaponEnt, self.Attachment)    
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end