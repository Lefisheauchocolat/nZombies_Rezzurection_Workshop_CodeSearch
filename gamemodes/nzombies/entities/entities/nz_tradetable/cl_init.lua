include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	local wep = self:GetWeapon()
	if IsValid(wep) then
		local camo = wep:GetNW2String("nzPaPCamo", "")
		if camo ~= "" and wep.TPaPOverrideMat and wep.HasNZModifier and wep:HasNZModifier("pap") then
			for k, v in pairs(wep.TPaPOverrideMat) do
				if wep:GetSubMaterial(k) == "" then
					wep:SetSubMaterial(k, camo)
				end
			end

			if wep.WElements and wep.WPaPOverrideMat then
				for _, element in pairs(wep.WElements) do
					local model = element.curmodel
					if IsValid(model) and wep.WPaPOverrideMat[model] then
						for k, v in pairs(wep.WPaPOverrideMat[model]) do
							if model:GetSubMaterial(k) == "" then
								model:SetSubMaterial(k, camo)
							end
						end
					end
				end
			end
		end
	end

	self:SetNextClientThink(CurTime())
	return true
end

function ENT:GetNZTargetText()
	if (not view_cvar:GetBool()) and nzRound:InState(ROUND_CREATE) then
		local price = self:GetPrice()
		if price > 0 then
			return "Trading Table | "..string.Comma(price).." Price"
		else
			return "Trading Table"
		end
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local gun = ply:GetActiveWeapon()
	if IsValid(gun) then
		if gun.IsTFAWeapon and (!TFA.Enum.ReadyStatus[gun:GetStatus()] or gun:GetSprinting()) then
			if self.NZHudIcon then
				self.NZHudIcon = nil
			end
			return ""
		end

		if not self:GetAllowWonder() and gun.NZWonderWeapon then
			return "Cannot place down Wonder Weapons!"
		end
	end

	local wep = self:GetWeapon()
	if IsValid(wep) then
		if wep.NZHudIcon and !wep.NZHudIcon:IsError() then
			if (!self.NZHudIcon or self.NZHudIcon ~= wep.NZHudIcon) then
				self.NZHudIcon = wep.NZHudIcon
			end
		elseif self.NZHudIcon then
			self.NZHudIcon = nil
		end

		local index = self:GetUserIndex()
		local ply2 = Entity(index)
		local pap = wep:HasNZModifier("pap")
		local name = (pap and wep.NZPaPName) and wep.NZPaPName or wep.PrintName

		local aat = wep:GetNW2String("nzAATType", "")
		if aat ~= "" and nzAATs:Get(aat) then
			name = name.." ("..nzAATs:Get(aat).name..")"
		end

		if ply:EntIndex() ~= index then
			local price = self:GetPrice()
			if price > 0 then
				if IsValid(ply2) and ply2:IsPlayer() then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..ply2:Nick().."'s "..name.." [Cost: "..string.Comma(price).."]"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..name.." [Cost: "..string.Comma(price).."]"
				end
			else
				if IsValid(ply2) and ply2:IsPlayer() then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..ply2:Nick().."'s "..name
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..name
				end
			end
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..name
		end
	else
		if self.NZHudIcon then
			self.NZHudIcon = nil
		end

		return "Press "..string.upper(input.LookupBinding("+USE")).." - Place held weapon"
	end
end
