local plyMeta = FindMetaTable( "Player" )
AccessorFunc( plyMeta, "iLastWeaponSlot", "LastWeaponSlot", FORCE_NUMBER)
AccessorFunc( plyMeta, "iCurrentWeaponSlot", "CurrentWeaponSlot", FORCE_NUMBER)

//ugly fix for +menu not playing nice with special weapons

function plyMeta:SelectWeapon( class )
	local wep = self:GetWeapon(class)
	if !IsValid(wep) then return end

	if self.DoWeaponSwitch then
		if IsValid(self.DoWeaponSwitch) then
			return
		else
			self.DoWeaponSwitch = nil
		end
	end

	local wep2 = self:GetActiveWeapon()
	if wep2 == wep then
		for k, v in pairs(self:GetWeapons()) do
			local slot = v:GetNWInt("SwitchSlot", 0)
			if !v:IsSpecial() and self:GetCurrentWeaponSlot() and slot == math.Clamp(self:GetCurrentWeaponSlot(), 1, self:HasPerk('mulekick') and 3 or 2) then
				self.DoWeaponSwitch = v
				break
			end
		end
	else
		self.DoWeaponSwitch = wep
	end

	//print('Trying to switch weapons to '..self.DoWeaponSwitch:GetClass())
end

function GM:CreateMove( cmd )
	local ply = LocalPlayer()
	local wep = ply.DoWeaponSwitch
	if IsValid(wep) then
		cmd:SelectWeapon(wep)

		local slot = wep:GetNWInt("SwitchSlot", 0)
		if slot > 2 and !ply:HasPerk("mulekick") then
			ply.DoWeaponSwitch = nil
		end

		local active = ply:GetActiveWeapon()
		if (active == wep) then
			local slot = active:GetNWInt("SwitchSlot", 0)
			if !active:IsSpecial() and slot > 0 then
				ply:SetCurrentWeaponSlot(slot)
			end

			ply.DoWeaponSwitch = nil
		elseif wep.NZSpecialCategory and wep.NZSpecialCategory == "grenade" and ply:GetAmmoCount("nz_grenade") <= 0 then
			ply.DoWeaponSwitch = nil
		end
	end
end

function GM:PlayerBindPress( ply, bind, pressed )
	if nzRound:InProgress() or nzRound:InState(ROUND_GO) then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and !ply:GetCurrentWeaponSlot() then
			ply:SetCurrentWeaponSlot(wep:GetNWInt("SwitchSlot", 1))
		end

		local slot
		local curslot = ply:GetCurrentWeaponSlot() or 1
		local lastslot = ply:GetLastWeaponSlot() or 1
		local isspecial = IsValid(wep) and wep:IsSpecial() or false
		local maxslot = ply:HasPerk("mulekick") and 3 or 2

		if string.find(bind, "slot1") then
			slot = 1
		end
		if string.find(bind, "slot2") then
			slot = 2
		end
		if string.find(bind, "slot3") then
			slot = 3
		end

		if string.find(bind, "invnext") then
			slot = curslot + 1
			if slot > maxslot then
				slot = 1
			end
		end

		if string.find(bind, "invprev") then
			slot = curslot - 1
			if slot < 1 then
				slot = maxslot
			end
		end

		if !nzRound:InState(ROUND_CREATE) and (bind == "+menu" and pressed) then
			if isspecial then
				slot = math.Clamp(curslot, 1, maxslot)
			elseif lastslot ~= curslot then
				slot = math.Clamp(lastslot, 1, maxslot)
			else
				slot = curslot + 1
				if slot > maxslot then
					slot = 1
				end
			end
		end

		if slot then
			if IsValid(wep) then
				local switchslot = wep:GetNWInt("SwitchSlot", 0)
				if !isspecial and switchslot > 0 then
					ply:SetLastWeaponSlot(switchslot)
				end
			end

			if slot == 3 then
				for k, v in pairs(ply:GetWeapons()) do
					if v:GetNWInt("SwitchSlot") == slot then
						ply:SelectWeapon(v:GetClass())
						return true
					end
				end
				slot = 1
				for k, v in pairs(ply:GetWeapons()) do
					if v:GetNWInt("SwitchSlot") == slot then
						ply:SelectWeapon(v:GetClass())
						return true
					end
				end
			else
				for k, v in pairs(ply:GetWeapons()) do
					if v:GetNWInt("SwitchSlot") == slot then
						ply:SelectWeapon(v:GetClass())
						return true
					end
				end
			end
		end
		if string.find(bind, "slot") then return true end
	end
end
