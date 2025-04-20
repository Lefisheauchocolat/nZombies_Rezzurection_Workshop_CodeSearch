include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")
local color_backup = Color(40, 255, 60, 255)

function ENT:Initialize()
	local build = self:GetBuildable()
	local tbl = nzBuilds:GetBuildParts(build)
	local id = self:GetPartID()
	local icon = tbl[id].icon
	self.NZHudIcon = icon
end

function ENT:Draw()
	if (not view_cvar:GetBool()) and nzRound:InState(ROUND_CREATE) then
		self:DrawModel()
	end

	if self:GetActivated() then
		if self.pvslight and IsValid(self.pvslight) then
			self.pvslight:StopEmission()
		end
		return
	end

	self:DrawModel()

	if !self.pvslight or !IsValid(self.pvslight) then
		local mc = nzMapping.Settings.boxlightcolor
		local color = Vector(1,0.7,0)
		if mc and IsColor(mc) then
			color = Vector(mc.r/255, mc.g/255, mc.b/255)
		end
		local glow = CreateParticleSystem(self, "nzr_key_loop", PATTACH_ABSORIGIN_FOLLOW)
		glow:SetControlPoint(2, color)
		self.pvslight = glow
	end
end

function ENT:Think()
	/*if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if not self:GetActivated() and (dlight) then
			local color = nzMapping.Settings.boxlightcolor or color_backup
			dlight.pos = self:WorldSpaceCenter()
			dlight.r = color.r
			dlight.g = color.g
			dlight.b = color.b
			dlight.brightness = 0.5
			dlight.Decay = 2500
			dlight.Size = 64
			dlight.DieTime = CurTime() + 0.1
		end
	end*/

	self:NextThink(CurTime())
	return true
end

function ENT:GetNZTargetText()
	local parttab = nzBuilds:GetBuildParts(self:GetBuildable())
	local name = parttab[self:GetPartID()].id

	if (not view_cvar:GetBool()) and nzRound:InState(ROUND_CREATE) then
		return name
	end

	if self:GetActivated() then return end
	return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup "..name
end

function ENT:IsTranslucent()
	return true
end