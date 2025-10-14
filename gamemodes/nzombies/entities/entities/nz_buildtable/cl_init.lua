include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
	if buildtab then
		if buildtab.hudicon and !buildtab.hudicon:IsError() then
			self.NZHudIcon = buildtab.hudicon
		end

		if buildtab.weapon then
			self.WeaponClass = tostring(buildtab.weapon)
			if !self.NZHudIcon then
				local weptab = weapons.Get(self.WeaponClass)
				if weptab and weptab.NZHudIcon and !weptab.NZHudIcon:IsError() then
					self.NZHudIcon = weptab.NZHudIcon
				end
			end
		end

		if buildtab.name then
			self.BuildName = tostring(buildtab.name)
		end

		if buildtab.requiredtable then
			self.RequiredTable = tostring(buildtab.requiredtable)
		end
	end
end

function ENT:GetNZTargetText()
	local buildname = self.BuildName
	local price = self:GetPrice()

	if (not view_cvar:GetBool()) and nzRound:InState(ROUND_CREATE) then
		local pricestring = ""
		if price > 0 then
			pricestring = " | Price "..string.Comma(price)
		end

		local parttab = nzBuilds:GetBuildParts(self:GetBuildable())
		return buildname.." | "..#parttab.. " Parts"..pricestring
	end

	if self:GetBrutusLocked() then
		return "Press "..string.upper(input.LookupBinding("+USE")).." - Unlock [Cost: 2000]"
	end

	if self:GetRemainingParts() > 0 then
		return "Missing Parts Required - "..buildname
	else
		if not self:GetCompleted() then
			return "Press & Hold "..string.upper(input.LookupBinding("+USE")).." - Craft "..buildname
		else
			if self:GetUsed() then
				for k, v in ipairs(player.GetAll()) do
					if v:HasWeapon(self.WeaponClass) then
						return buildname.." will be available from the mystery box later"
					end
				end
				return buildname.." is now available from the mystery box"
			end

			local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
			if buildtab.text and isfunction(buildtab.text) then
				return buildtab.text(self)
			end

			local ply = LocalPlayer()
			if not IsValid(ply) then return end
			if IsValid(ply:GetObserverTarget()) then
				ply = ply:GetObserverTarget()
			end

			if self.WeaponClass and not ply:HasWeapon(self.WeaponClass) then
				if price > 0 then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Buy "..buildname.." [Cost: "..price.."]"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..buildname
				end
			else
				if price > 0 then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Repair "..buildname.." [Cost: "..(price * 2).."]"
				else
					return "Already Carrying "..buildname
				end
			end
		end
	end
end

function ENT:IsTranslucent()
	return true
end