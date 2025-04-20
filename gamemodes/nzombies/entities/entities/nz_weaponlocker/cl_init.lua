include("shared.lua")


function ENT:Draw()
	self:DrawModel()
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local elec = self:GetElectric() and " | Requires Electricity" or ""
		local box = self:GetUseBoxList() and " | Box Weapons only" or ""
		local price = self:GetPrice() > 0 and " | Price "..string.Comma(self:GetPrice()) or ""
		return "Weapon Locker"..box..elec..price
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return ""
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local gun = ply:GetActiveWeapon()
	if IsValid(gun) then
		if gun.IsTFAWeapon and (!TFA.Enum.ReadyStatus[gun:GetStatus()] or gun:GetSprinting()) then
			return
		end
	end

	if self.badgun and self.badguntime and self.badguntime > CurTime() then
		return self.badgun
	end

	local wep = ply:GetNW2String("nzFridgeWep", "")
	if wep ~= "" then
		local price = self:GetPrice()
		if price > 0 then
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Retrieve "..wep.." Cost: ["..price.."]"
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Retrieve "..wep
		end
	else
		if IsValid(gun) then
			local wepname = (gun.PrintName and gun.PrintName ~= "") and gun.PrintName or gun.ClassName
			if gun.HasNZModifier and gun:HasNZModifier("pap") and gun.NZPaPName then
				wepname = gun.NZPaPName
			end

			return "Press "..string.upper(input.LookupBinding("+USE")).." - Stow "..wepname
		end
	end
end

function ENT:BadGun(class)
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	self.badguntime = CurTime() + 0.8
	self.badgun = (wep.PrintName and wep.PrintName ~= "") and "Cannot stow "..wep.PrintName.."!" or "Cannot stow "..wep.ClassName.."!"

	if wep.NZWonderWeapon then
		self.badgun = "Cannot stow Wonder Weapons!"
	end

	local starter = nzMapping.Settings.startwep
	if starter and wep:GetClass() == starter then
		self.badgun = "Cannot stow the starting weapon!"
	end

	if class then
		self.badgun = "Cannot retrieve "..ply:GetNW2String("nzFridgeWep", "").."!"
	end

	local guntimer = "badgun_"..self:EntIndex()

	if timer.Exists(guntimer) then timer.Remove(guntimer) end
	timer.Create(guntimer, 0.8, 1, function()
		if not IsValid(self) then return end
		self.badguntime = nil
		self.badgun = nil
	end)
end

function ENT:IsTranslucent()
	return true
end