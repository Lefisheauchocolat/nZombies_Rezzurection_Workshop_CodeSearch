local plyMeta = FindMetaTable("Player")
local lastSwitchSlot = nil
AccessorFunc(plyMeta, "iLastWeaponSlot", "LastWeaponSlot", FORCE_NUMBER)
AccessorFunc(plyMeta, "iCurrentWeaponSlot", "CurrentWeaponSlot", FORCE_NUMBER)

function plyMeta:SelectWeapon(class)
	local wep = self:GetWeapon(class)
	if not IsValid(wep) then return end

	if IsValid(self.DoWeaponSwitch) then
		if self.DoWeaponSwitch == wep then
			self.DoWeaponSwitch = nil
			net.Start("TFA_HolsterCancle")
			net.SendToServer()
			return
		end
	end

	local active = self:GetActiveWeapon()
	if active == wep then
		net.Start("TFA_HolsterCancle")
		net.SendToServer()
		self.DoWeaponSwitch = nil
		return
	end

	self.DoWeaponSwitch = wep
end

function GM:CreateMove(cmd)
	local ply = LocalPlayer()
	local wep = ply.DoWeaponSwitch

	if IsValid(wep) then
		cmd:SelectWeapon(wep)

		local slot = wep:GetNWInt("SwitchSlot", 0)
		if slot > 2 and not ply:HasPerk("mulekick") then
			ply.DoWeaponSwitch = nil
		end

		local active = ply:GetActiveWeapon()
		if active == wep then
			local slot = active:GetNWInt("SwitchSlot", 0)
			if not active:IsSpecial() and slot > 0 then
				ply:SetCurrentWeaponSlot(slot)
			end

			ply.DoWeaponSwitch = nil
		elseif wep.NZSpecialCategory == "grenade" and ply:GetAmmoCount("nz_grenade") <= 0 then
			ply.DoWeaponSwitch = nil
		end
	end
end

function GM:PlayerBindPress(ply, bind, pressed)
	if not (nzRound:InProgress() or nzRound:InState(ROUND_GO)) then return end

	local wep = ply:GetActiveWeapon()
	local maxslot = ply:HasPerk("mulekick") and 3 or 2

	if not ply:GetCurrentWeaponSlot() then
		if IsValid(wep) then
			ply:SetCurrentWeaponSlot(math.Clamp(wep:GetNWInt("SwitchSlot", 1), 1, maxslot))
		else
			ply:SetCurrentWeaponSlot(1)
		end
	end

	local curslot = ply:GetCurrentWeaponSlot()
	local lastslot = ply:GetLastWeaponSlot() or 1
	local isspecial = IsValid(wep) and wep:IsSpecial() or false

	local slot = nil

	if string.find(bind, "slot1") and pressed then slot = 1 end
	if string.find(bind, "slot2") and pressed then slot = 2 end
	if string.find(bind, "slot3") and pressed then slot = 3 end

	if string.find(bind, "invnext") and pressed then
		slot = curslot + 1
		if slot > maxslot then slot = 1 end
	end

	if string.find(bind, "invprev") and pressed then
		slot = curslot - 1
		if slot < 1 then slot = maxslot end
	end

	if bind == "+menu" and pressed and not nzRound:InState(ROUND_CREATE) then
		if isspecial then
			slot = math.Clamp(curslot, 1, maxslot)
		elseif lastslot ~= curslot then
			slot = math.Clamp(lastslot, 1, maxslot)
		else
			slot = curslot + 1
			if slot > maxslot then slot = 1 end
		end
	end

if slot and pressed then
	local currentSwitch = ply.DoWeaponSwitch

	for _, v in pairs(ply:GetWeapons()) do
		if v:GetNWInt("SwitchSlot") == slot then
			if IsValid(currentSwitch) and currentSwitch == v then
				ply.DoWeaponSwitch = nil
				LastSwitchWeapon = nil
				net.Start("TFA_HolsterCancle")
				net.SendToServer()
				return true
			end

			if IsValid(wep) and not isspecial and wep:GetNWInt("SwitchSlot", 0) > 0 then
				ply:SetLastWeaponSlot(wep:GetNWInt("SwitchSlot"))
			end

			ply:SelectWeapon(v:GetClass())
			LastSwitchWeapon = v
			return true
		end
	end

	if IsValid(currentSwitch) then
		ply.DoWeaponSwitch = nil
		LastSwitchWeapon = nil
		net.Start("TFA_HolsterCancle")
		net.SendToServer()
	end

	return true
end


	if string.find(bind, "slot") and pressed then return true end
end