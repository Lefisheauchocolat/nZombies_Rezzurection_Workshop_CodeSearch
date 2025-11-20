local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

EFFECT.Life      = 0.085
EFFECT.HeatSize  = 0.70
EFFECT.FlashSize = 0.70

function EFFECT:Init(data)
	self.Position = blankvec
	self.WeaponEnt = data:GetEntity()
	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	self.Dir = data:GetNormal()

	local owent

	if IsValid(self.WeaponEnt) then
		owent = self.WeaponEnt:GetOwner()
	end

	if not IsValid(owent) then
		owent = self.WeaponEnt:GetParent()
	end

	if IsValid(owent) and owent:IsPlayer() then
		if owent ~= LocalPlayer() or owent:ShouldDrawLocalPlayer() then
			self.WeaponEnt = owent:GetActiveWeapon()
			if not IsValid(self.WeaponEnt) then return end
		else
			self.WeaponEnt = owent:GetViewModel()

			local theirweapon = owent:GetActiveWeapon()

			if IsValid(theirweapon) and theirweapon.ViewModelFlip or theirweapon.ViewModelFlipped then
				self.Flipped = true
			end

			if not IsValid(self.WeaponEnt) then return end
		end
	end

	if dlight_cvar:GetBool() then
		local dlight

    	if IsValid(self.WeaponEnt) then
    		dlight = DynamicLight(self.WeaponEnt:EntIndex())
    	else
    		dlight = DynamicLight(0)
    	end

    	local fadeouttime = 0.25

    	if (dlight) then
    		dlight.Pos = owent:GetPos() + vector_up
    		dlight.r = 20
    		dlight.g = 150
    		dlight.b = 255
    		dlight.brightness = 1
    		dlight.Decay = 2500
    		dlight.Size = 512
    		dlight.DieTime = CurTime() + fadeouttime
    	end
    end

    ParticleEffect("bo3_zodsword_slam", owent:GetPos(), Angle(0,0,0), self.WeaponEnt)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end