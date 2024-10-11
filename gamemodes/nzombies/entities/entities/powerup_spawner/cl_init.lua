include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	if !nzRound:InState(ROUND_CREATE) then return end

	self:DrawModel()

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local ent = ply:GetEyeTrace().Entity
	if IsValid(ent) and ent:EntIndex() == self:EntIndex() then
		if !self.loopglow or !IsValid(self.loopglow) then
			local global = nzPowerUps:Get(self:GetPowerUp()).global
			local colorvec1 = global and nzMapping.Settings.powerupcol["global"][1] or nzMapping.Settings.powerupcol["local"][1]
			local colorvec2 = global and nzMapping.Settings.powerupcol["global"][2] or nzMapping.Settings.powerupcol["local"][2]
			local colorvec3 = global and nzMapping.Settings.powerupcol["global"][3] or nzMapping.Settings.powerupcol["local"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_ABSORIGIN_FOLLOW)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(1,1,1))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_ABSORIGIN_FOLLOW)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(1,1,1))
			end
		end
	else
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end
end

function ENT:IsTranslucent()
	return true
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local scroller = self:GetDoScroll() and " | Scroll ("..self:GetScrollTime().."s Default / "..self:GetScrollTimeRare().."s Rare)" or ""
		local randomizer = self:GetRandomize() and " | Randomize ("..self:GetRandomizeRound().." Rounds)" or ""
		
		local name = self:GetPowerUp()
		local pdata = nzPowerUps:Get(self:GetPowerUp())
		if pdata.name then
			name = pdata.name
		end

		return "Power-Up Spawner | "..name..scroller..randomizer
	end
end