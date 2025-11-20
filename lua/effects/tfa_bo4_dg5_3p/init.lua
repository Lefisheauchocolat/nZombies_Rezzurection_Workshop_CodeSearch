local blankvec   = Vector(0, 0, 0)
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	if not IsValid(self.WeaponEnt) then return end
	self.Passed = false

	ParticleEffectAttach("bo4_dg5_spark", PATTACH_POINT_FOLLOW, self.WeaponEnt, 3)

	local WorldModelElements = self.WeaponEnt:GetStatRaw("WorldModelElements", TFA.LatestDataVersion)
	if WorldModelElements then
		local element = WorldModelElements['dg5_dw']
		if element then
			self.wmodel = element.curmodel
			if self.wmodel and IsValid(self.wmodel) then
				ParticleEffectAttach("bo4_dg5_spark", PATTACH_POINT_FOLLOW, self.wmodel, 4)
			end
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end