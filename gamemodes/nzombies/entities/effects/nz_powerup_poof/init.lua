function EFFECT:Init(data)
	self.Origin = data:GetOrigin()
	self.Angles = data:GetAngles()
	self.MyScale = data:GetNormal()
	self.MyType = data:GetFlags()

	local ptype = nzPowerUps.PowerUpGlowTypes[self.MyType]
	local colorvec1 = nzMapping.Settings.powerupcol[ptype][1]
	local colorvec2 = nzMapping.Settings.powerupcol[ptype][2]
	local colorvec3 = nzMapping.Settings.powerupcol[ptype][3]

	if not nzMapping.Settings.powerupstyle then return end
	local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
	if style then
		local poof = CreateParticleSystemNoEntity(style.poof, self.Origin, self.Angles)
		if poof and IsValid(poof) then
			poof:SetControlPoint(2, colorvec1)
			poof:SetControlPoint(3, colorvec2)
			poof:SetControlPoint(4, colorvec3)
			poof:SetControlPoint(1, self.MyScale)
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end