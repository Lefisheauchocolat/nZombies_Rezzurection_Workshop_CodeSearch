-- Main Tables
nzFridge = nzFridge or AddNZModule("Fridge")

nzFridge.Weapons = {}

if SERVER then
	util.AddNetworkString("nzFridge.Sync")

	function nzFridge:PlayerData(ply)
		if not IsValid(ply) then return end
		if table.IsEmpty(nzFridge.Weapons) then return end
		return nzFridge.Weapons[ply:SteamID64()]
	end

	function nzFridge:BuildWeapons()
		local fridge = ents.FindByClass("nz_weaponlocker")[1]
		if not IsValid(fridge) then return end

		local name = nzMapping.CurrentConfig
		if !file.Exists("nz/", "DATA") then
			file.CreateDir("nz")
		end
		if !file.Exists("nz/weaponlocker", "DATA") then
			file.CreateDir("nz/weaponlocker")
		end

		local jsondata = file.Read("nz/weaponlocker/"..game.GetMap()..";"..name..".txt", "DATA")
		if jsondata then
			local data = util.JSONToTable(jsondata)
			if not data then return end

			local boxlist = fridge:GetUseBoxList()
			local blacklist = fridge.BlacklistWeapons

			for k, v in pairs(data) do
				local wep = tostring(v.weapon)

				if boxlist and nzMapping.Settings.rboxweps and not nzMapping.Settings.rboxweps[wep] then
					continue
				end
				if blacklist and blacklist[wep] then
					continue
				end
				if nzWeps.IsWonderWeapon and nzWeps:IsWonderWeapon(wep) then
					continue
				end

				nzFridge.Weapons[v.player] = v
			end

			PrintTable(nzFridge.Weapons)
		end
	end

	function nzFridge:StoreWeapons()
		if table.IsEmpty(nzFridge.Weapons) then return end

		local name = nzMapping.CurrentConfig
		local tab = util.TableToJSON(nzFridge.Weapons)

		if !file.Exists("nz/", "DATA") then
			file.CreateDir("nz")
		end
		if !file.Exists("nz/weaponlocker", "DATA") then
			file.CreateDir("nz/weaponlocker")
		end

		file.Write("nz/weaponlocker/"..game.GetMap()..";"..name..".txt", tab)
	end

	function nzFridge:StoreWeapon(ply, wep)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not IsValid(wep) or not wep:IsWeapon() then return end

		local wepname = (wep.PrintName and wep.PrintName ~= "") and wep.PrintName or wep.ClassName
		if wep:HasNZModifier("pap") and wep.NZPaPName then
			wepname = wep.NZPaPName
		end

		local data = {
			player = ply:SteamID64(),
			weapon = wep:GetClass(),
			name = wepname,
		}

		if wep.Primary and wep.Primary.ClipSize and wep.Primary.ClipSize > 0 then
			data.clip1 = wep:Clip1()
		end
		if wep.Secondary and wep.Secondary.ClipSize and wep.Secondary.ClipSize > 0 then
			data.clip2 = wep:Clip2()
		end

		local ammo1 = wep:GetPrimaryAmmoType()
		if ammo1 > 0 then
			data.ammo1 = ply:GetAmmoCount(ammo1)
		end
		local ammo2 = wep:GetSecondaryAmmoType()
		if ammo2 > 0 then
			data.ammo2 = ply:GetAmmoCount(ammo2)
		end

		if wep:HasNZModifier("pap") then
			data.pap = true
		end
		if wep:HasNZModifier("repap") then
			data.repap = true
		end

		if wep:GetNW2String("nzPaPCamo", "") ~= "" then
			data.camo = wep:GetNW2String("nzPaPCamo")
		end
		if wep:GetNW2String("nzAATType", "") ~= "" then
			data.aat = wep:GetNW2String("nzAATType")
		end

		nzFridge.Weapons[ply:SteamID64()] = data

		ply:SetNW2String("nzFridgeWep", wepname)
		ply:StripWeapon(wep:GetClass())
	end

	function nzFridge:PickupWeapon(ply)
		if not IsValid(ply) or not ply:IsPlayer() then return end

		local data = nzFridge.Weapons[ply:SteamID64()]
		if not data then return end

		local slot, exists = GetPriorityWeaponSlot(ply)
		local validgun = IsValid(exists)

		if validgun then
			exists:Holster()
			ply:SetActiveWeapon(nil)
			nzFridge:StoreWeapon(ply, exists)
		end

		local wep = ply:Give(data.weapon)
		if validgun then
			ply:SelectWeapon(wep:GetClass())
		end

		wep.NoSpawnAmmo = true

		if wep.IsTFAWeapon and wep.Primary_TFA.Ammo then
			ply:SetAmmo(0, wep.Primary_TFA.Ammo)
		end

		if data.ammo1 then
			wep.StoredNZAmmo = tonumber(data.ammo1)
			if wep.IsTFAWeapon and wep.Primary_TFA.Ammo and wep:GetPrimaryAmmoType() > 0 then
				ply:SetAmmo(tonumber(data.ammo1), wep.Primary_TFA.Ammo)
				ply:SetAmmo(tonumber(data.ammo1), "nz_weapon_ammo_"..slot.."_ammo")
			end
		end
		if data.ammo2 then
			wep.StoredNZAmmo2 = tonumber(data.ammo2)
			if wep.IsTFAWeapon and wep.Secondary_TFA and wep.Secondary_TFA.Ammo and wep:GetSecondaryAmmoType() > 0 then
				ply:SetAmmo(tonumber(data.ammo2), wep.Secondary_TFA.Ammo)
			end
		end

		if data.clip1 then
			wep:SetClip1(tonumber(data.clip1))
		end
		if data.clip2 then
			wep:SetClip2(tonumber(data.clip2))
		end

		timer.Simple(0, function()
			if not IsValid(wep) then return end

			if data.pap then
				wep:ApplyNZModifier("pap")
			end
			if data.repap then
				wep:ApplyNZModifier("repap")
			end
			if data.camo then
				wep:SetNW2String("nzPaPCamo", tostring(data.camo))
			end
			if data.aat then
				wep:SetNW2String("nzAATType", tostring(data.aat))
			end

			if IsValid(ply) then
				if data.ammo1 then
					ply:SetAmmo(tonumber(data.ammo1), GetNZAmmoID(slot))
				end
				if data.ammo2 then
					ply:SetAmmo(tonumber(data.ammo2), wep:GetSecondaryAmmoType())
				end
			end

			timer.Simple(0, function()
				if not IsValid(wep) then return end
				if data.clip1 then
					wep:SetClip1(tonumber(data.clip1))
				end
				if data.clip2 then
					wep:SetClip2(tonumber(data.clip2))
				end
			end)
		end)

		if !validgun then
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:SetNW2String("nzFridgeWep", "")
			end)
			nzFridge.Weapons[ply:SteamID64()] = nil
		end
	end
end
