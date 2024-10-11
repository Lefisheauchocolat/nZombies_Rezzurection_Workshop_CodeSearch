if not ConVarExists("nz_papattachments") then CreateConVar("nz_papattachments", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_NOTIFY}, "Whether Pack-a-Punching a CW2.0 weapon will attach random attachments for each category. Will also strip players of attachments at the beginning of the game.") end

/*hook.Add("PlayerSpawn", "RemoveCW2Attachments", function(ply)
	if GetConVar("nz_papattachments"):GetBool() and CustomizableWeaponry then
		for k,v in pairs(ply.CWAttachments) do
			CustomizableWeaponry:removeAttachment(ply, k)
		end
	end
end)*/

function GetPriorityWeaponSlot(ply)
	-- Create some variables to use
	local maxnum = ply:HasPerk("mulekick") and 3 or 2
	local tbl = {}
	local first
	
	-- Loop through weapons
	for k,v in pairs(ply:GetWeapons()) do
		local slot = v:GetNWInt("SwitchSlot")
		-- Mark this slot as being used
		tbl[slot] = true
		-- Also save whichever weapon has slot 1 in case the activeweapon doesnt have a slot
		if slot == 1 then first = v end
	end
	-- Now loop through the maxnumber we can have
	for i = 1, maxnum do
		-- If this slot hasn't been taken, return it
		if !tbl[i] then return i end
	end
	-- If we didn't return before (all slots taken), check the activeweapon
	local activewep = ply:GetActiveWeapon()
	local id = activewep:GetNWInt("SwitchSlot")
	-- Only replace it if it has an ID (default is 0)
	if id > 0 then
		return id, activewep
	end
	-- Else we should return the weapon stored in slot 1, if nothing at all just return slot 1 alone
	if first then return 1, first else return 1 end
end

local usesammo = {
	["grenade"] = "nz_grenade",
	["specialgrenade"] = "nz_specialgrenade",
	["equipment"] = "nz_equipment",
}

local function OnWeaponAdded( wep )
	if not wep:IsSpecial() then
		wep.Weight = 10000
	end

	local heldwep = wep:GetNWInt("SwitchSlot", 0) > 0

	timer.Simple(0, function()
		if not IsValid(wep) then return end
		local ply = wep:GetOwner()
		if not IsValid(ply) or not ply:IsPlayer() then return end

		if !nzRound:InState(ROUND_CREATE) and !heldwep then
			if wep.NZSpecialCategory and wep.NZSpecialCategory == "trap" then
				if wep.IsTFAWeapon then
					local oldammo = wep.Primary_TFA.Ammo
					local newammo = GetNZAmmoID("equipment")

					wep.Primary.Ammo = game.GetAmmoName(newammo)
					wep.Primary_TFA.Ammo = game.GetAmmoName(newammo)
					wep.Primary_TFA.OldAmmo = oldammo
					wep:ClearStatCache("Primary.Ammo")
				else
					local oldammo = wep.Primary.Ammo
					local newammo = GetNZAmmoID("equipment")

					wep.Primary.Ammo = game.GetAmmoName(newammo)
					wep.Primary.OldAmmo = oldammo
				end
			elseif !wep.NZSpecialCategory then
				local slot, exists = GetPriorityWeaponSlot(ply)
				wep:SetNWInt("SwitchSlot", slot)

				if wep.IsTFAWeapon then
					local oldammo = wep.Primary_TFA.Ammo
					local newammo = wep:GetPrimaryAmmoType()

					wep.Primary.Ammo = game.GetAmmoName(newammo)
					wep.Primary_TFA.Ammo = game.GetAmmoName(newammo)
					wep.Primary_TFA.OldAmmo = oldammo
					wep:ClearStatCache("Primary.Ammo")
				else
					local oldammo = wep.Primary.Ammo
					local newammo = wep:GetPrimaryAmmoType()

					wep.Primary.Ammo = game.GetAmmoName(newammo)
					wep.Primary.OldAmmo = oldammo
				end
			end
		end

		if wep.NZPaPME then
			wep:ApplyNZModifier("pap")
			wep.NZPaPME = nil
		end

		local gum = nzGum:GetActiveGum(ply)
		if (gum == "all_powered_up") and not wep:HasNZModifier("pap") and (!wep.NZSpecialCategory or (wep.NZSpecialCategory and wep.OnPaP)) then
			wep:ApplyNZModifier("pap")

			ply:EmitSound("nz_moo/perkacolas/pap/ready.mp3", SNDLVL_GUNFIRE)
			nzGum:TakeUses(ply)

			if wep.NZPaPReplacement then
				local wep2 = ply:Give(wep.NZPaPReplacement)
				if IsValid(wep2) then
					wep2:ApplyNZModifier("pap")
					wep2:GiveMaxAmmo()
				end
			end
		end

		local wepdata = wep.NZSpecialWeaponData
		if wepdata then
			local ammo = wepdata.AmmoType
			if wep.NZSpecialCategory == "trap" then
				ammo = GetNZAmmoID("equipment")
			end
			local maxammo = wepdata.MaxAmmo
			if wep.NZRegenTakeClip then
				maxammo = maxammo - wep:Clip1()
			end

			if ammo and maxammo and ammo ~= "" and maxammo > 0 then
				if wep.NoSpawnAmmo then
					if wep.StoredNZAmmo then
						ply:SetAmmo(wep.StoredNZAmmo, GetNZAmmoID(ammo) or ammo)
						wep.StoredNZAmmo = nil

						if wep.StoredNZAmmo2 then
							ply:SetAmmo(wep.StoredNZAmmo2, wep:GetSecondaryAmmoType())
							wep.StoredNZAmmo2 = nil
						end
					end
				else
					ply:SetAmmo(maxammo, GetNZAmmoID(ammo) or ammo) -- Special weapon ammo or just that ammo
				end
			end
		end

		if wep.NZSpecialCategory then return end

		if not wep.NZSpecialCategory then
			if ply:HasPerk("staminup") then
				wep:ApplyNZModifier("staminup")
			elseif heldwep and wep:HasNZModifier("staminup") then
				wep:RevertNZModifier("staminup")
			end

			if ply:HasPerk("deadshot") then
				wep:ApplyNZModifier("deadshot")
			elseif heldwep and wep:HasNZModifier("deadshot") then
				wep:RevertNZModifier("deadshot")
			end

			if ply:HasPerk("dtap2") then
				wep:ApplyNZModifier("dtap2")
			elseif heldwep and wep:HasNZModifier("dtap2") then
				wep:RevertNZModifier("dtap2")
			end

			if ply:HasPerk("dtap") then
				wep:ApplyNZModifier("dtap")
			elseif heldwep and wep:HasNZModifier("dtap") then
				wep:RevertNZModifier("dtap")
			end

			if ply:HasPerk("vigor") then
				wep:ApplyNZModifier("vigor")
			elseif heldwep and wep:HasNZModifier("vigor") then
				wep:RevertNZModifier("vigor")
			end

			if ply:HasPerk("candolier") then
				wep:ApplyNZModifier("candolier")
			elseif heldwep and wep:HasNZModifier("candolier") then
				wep:RevertNZModifier("candolier")
			end

			if ply:HasUpgrade("speed") then
				wep:ApplyNZModifier("speed")
			elseif heldwep and wep:HasNZModifier("speed") then
				wep:RevertNZModifier("speed")
			end

			if !heldwep then
				if not wep.NoSpawnAmmo then
					wep:GiveMaxAmmo()
				end

				if wep.Base then
					nzCamos:RandomizeCamo(wep, wep.LastCamo)
				end
			end

			ply:SelectWeapon(wep:GetClass())
		end

		if wep.StoredNZAmmo then
			local ammo1 = wep.NZSpecialCategory and wep:GetPrimaryAmmoType() or GetNZAmmoID(wep:GetNWInt("SwitchSlot", 0))
			ply:SetAmmo(wep.StoredNZAmmo, GetNZAmmoID(ammo1) or ammo1)
			wep.StoredNZAmmo = nil
		end
		if wep.StoredNZAmmo2 then
			ply:SetAmmo(wep.StoredNZAmmo2, wep:GetSecondaryAmmoType())
			wep.StoredNZAmmo2 = nil
		end

		wep:ApplyNZModifier("equip")

		/*if wep.ArcCW then
			ply:StripWeapon(wep:GetClass())
			ply:EmitSound("arccw.wav", 511)
			ply:ChatPrint("Maybe next time you'll follow directions. Go use TFA.")
		end*/

		if (wep.ArcCW or wep.CW20Weapon or wep.IsFAS2Weapon or (wep.Base and wep.Base:find("mg_base"))) and !ply.receivedNZWEPwarning then
			ply.receivedNZWEPwarning = true
			ply:ChatPrint("This version of nzombies is designed for TFA weapons only")
			ply:ChatPrint("Expect errors and most weapon modifying effects to not work")
			ply:ChatPrint("Sorry for the inconvenience")
		end
	end)
end

--Hooks
hook.Add("WeaponEquip", "nzOnWeaponAdded", OnWeaponAdded)

hook.Add("PlayerDroppedWeapon", "nzWeaponDropFix", function(ply, wep)
	if not IsValid(ply) or not IsValid(wep) then return end
	if not ply:IsPlayer() then return end
	if nzRound:InState(ROUND_CREATE) then return end

	if wep:GetNWInt("SwitchSlot", 0) > 0 and !wep.StoredNZAmmo then
		if wep.NZSpecialCategory then
			local ammo1 = wep:GetPrimaryAmmoType()
			if ammo1 > 0 then
				wep.StoredNZAmmo = ply:GetAmmoCount(ammo1)
			end

			local ammo2 = wep:GetSecondaryAmmoType()
			if !wep.StoredNZAmmo2 and wep.Secondary and wep.Secondary.ClipSize and ammo2 > 0 then
				wep.StoredNZAmmo2 = ply:GetAmmoCount(ammo2)
			end
		else
			wep.StoredNZAmmo = ply:GetAmmoCount(GetNZAmmoID(wep:GetNWInt("SwitchSlot", 0)))

			local ammo2 = wep:GetSecondaryAmmoType()
			if !wep.StoredNZAmmo2 and wep.Secondary and wep.Secondary.ClipSize and ammo2 > 0 then
				wep.StoredNZAmmo2 = ply:GetAmmoCount(ammo2)
			end
		end
	end
end)

hook.Add("PlayerCanPickupWeapon", "nzWeaponReplacer", function(ply, wep)
	if not IsValid(ply) or not IsValid(wep) then return end
	if nzRound:InState(ROUND_CREATE) then return end

	if !wep.NZSpecialCategory and !wep.NZIgnorePickup then
		local id = wep:GetNWInt("SwitchSlot", 0)
		if id > 0 then
			for k, v in ipairs(ply:GetWeapons()) do
				if v:GetNWInt("SwitchSlot", 0) > 0 and v:GetNWInt("SwitchSlot", 0) == id then
					v.Holster = function() return true end -- Allow instant holstering
					timer.Simple(0, function()
						if not IsValid(ply) or not IsValid(wep) then return end
						ply:SelectWeapon(wep:GetClass())
						if IsValid(v) then
							ply:StripWeapon(v:GetClass())
						end
					end)
					return
				end
			end
		end

		local slot, exists = GetPriorityWeaponSlot(ply)
		if IsValid(exists) and not wep.NZSpecialCategory and not wep.NZIgnorePickup then
			exists.Holster = function() return true end -- Allow instant holstering
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(wep) then return end
				ply:SelectWeapon(wep:GetClass())
				if IsValid(exists) then
					ply:StripWeapon(exists:GetClass())
				end
			end)
		end
	end
end)

hook.Add("PlayerCanPickupWeapon", "PreventWhosWhoWeapons", function(ply, wep)
	if IsValid(wep:GetOwner()) and wep:GetOwner():GetClass() == "whoswho_downed_clone" then
		return false
	end
end)

-- Meta stuff
local meta = FindMetaTable("Player")
function meta:GiveNoAmmo(class)
	local wep = self:Give(class)
	if IsValid(wep) then wep.NoSpawnAmmo = true end
	return wep
end