local usekey = "" .. string.upper(input.LookupBinding( "+use", true )) .. " - "

local traceents = {
	["wall_buys"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		local wepclass = ent:GetWepClass()
		local price = ent:GetPrice()
		local wep = weapons.Get(wepclass)
		if !wep then return "INVALID WEAPON" end

		local pap = false
		local hacked = false
		local upgrade
		local upgrade2

		if wep.NZPaPReplacement then
			upgrade = wep.NZPaPReplacement
			if ply:HasWeapon(upgrade) then
				pap = true
			end

			local wep2 = weapons.Get(wep.NZPaPReplacement)
			if wep2.NZPaPReplacement then
				upgrade2 = wep2.NZPaPReplacement
				if ply:HasWeapon(upgrade2) then
					pap = true
				end
			end
		end

		if ent.GetHacked and ent:GetHacked() then
			hacked = true
		end

		local name = wep.PrintName
		local ammo_price = hacked and 4500 or math.ceil((price - (price % 10))/2)
		local ammo_price_pap = hacked and math.ceil((price - (price % 10))/2) or 4500
		local text = ""

		if !ply:HasWeapon( wepclass ) then
			if !pap then
				text = "Press "..usekey..name.." [Cost: "..string.Comma(price).."]"
			else
				text = "Press "..usekey.."Upgraded Ammo ["..string.Comma(ammo_price_pap).."]"
			end
		else
			if ply:HasWeapon( wepclass ) then
				text = "Press "..usekey.."Ammo ["..string.Comma(ammo_price).."], Upgraded Ammo ["..string.Comma(ammo_price_pap).."]"
			else
				text = "You already have this Weapon"
			end
		end
		if nzRound:InState(ROUND_CREATE) then
			text = ""..name.." | "..string.upper(wepclass).." | Price "..string.Comma(price)..""
		end

		return text
	end,
	["breakable_entry"] = function(ent)
		if ent:GetHasPlanks() and ent:GetNumPlanks() < GetConVar("nz_difficulty_barricade_planks_max"):GetInt() then
			local text = "Hold " .. usekey .. "Rebuild Barricade"
			return text
		end
	end,
	["ammo_box"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		local text = "Press " .. usekey .. "Ammo [" .. string.Comma(ent:AmmoPrice(ply)) .. "]"
		return text
	end,
	["ammo_mod"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		local text = "Press " .. usekey .. "Random AAT [" .. string.Comma(ent:GetPrice()) .. "]"
		return text
	end,
	["stinky_lever"] = function(ent)
		local text = "Press " .. usekey .. "Hasten your demise"
		return text
	end,
	["random_box"] = function(ent)
		if not ent:GetOpen() then
			local price = nzPowerUps:IsPowerupActive("firesale") and 10 or nzMapping.Settings.rboxprice or 950
			return "Press " .. usekey .. "Open Mystery Box [Cost: "..price.."]"
		end
	end,
	["random_box_windup"] = function(ent)
		if !ent:GetWinding() and ent:GetWepClass() != "nz_box_teddy" then
			local wepclass = ent:GetWepClass()
			local wep = weapons.Get(wepclass)
			local name = "UNKNOWN"
			if wep != nil then
				name = wep.PrintName
			end
			if name == nil then name = wepclass end
			name = usekey .. "Take " .. name

			return name
		end
	end,
	["perk_machine"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		local n_aats = (nzMapping.Settings.aats or 2)
		local nz_maxperks = ply:GetMaxPerks()
		local text = ""

		if ent:BrutusLocked() then
			text = "Press " .. usekey .. "Unlock [Cost: 2000]"
		elseif !ent:IsOn() then
			text = "You must turn on the electricity first!"
		elseif ent:GetBeingUsed() and (ply == ent:GetLastUser() or ent:GetPerkID() == "pap") then
			text = "Currently in Use"
		else
			if ent:GetPerkID() == "pap" then
				local wep = ply:GetActiveWeapon()
				if ent:GetHasPapGun() then
					local pickup = "Upgraded Weapon"
					if ent.GetPapWeapon then
						local wep = weapons.Get(ent:GetPapWeapon())
						if wep.NZPaPName then
							pickup = wep.NZPaPName
						end
					end

					text = "Press " .. usekey .. "Take "..pickup
				else
					if IsValid(wep) and wep:HasNZModifier("pap") then
						local n_aats = (nzMapping.Settings.aats or 2)
						local repaptext = wep.NZRePaPText or "Repack"

						if wep:CanRerollPaP() and (n_aats > 0 or wep.OnRePaP) then
							local cost = ent:GetUpgradePrice()
							if nzPowerUps:IsPowerupActive("bonfiresale") then
								cost = math.Round(cost/5)
							end

							text = ("Press "..usekey..repaptext.." [Cost: "..string.Comma(cost).."]")
						else
							text = "This weapon cannot be upgraded any further"
						end
					else
						local cost = ent:GetPrice()
						if nzPowerUps:IsPowerupActive("bonfiresale") then
							cost = math.Round(cost/5)
						end

						text = ("Press "..usekey.."Pack-a-Punch Weapon [Cost: "..string.Comma(cost).."]")
					end
				end

				if nzRound:InProgress() and nzMapping.Settings.randompap and ent.GetSelected and (!ent:GetSelected() and !nzPowerUps:IsPowerupActive("bonfiresale")) then
					text = false
				end
			else
				local perkData = nzPerks:Get(ent:GetPerkID())
				local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
				local perkname = {
					["IW"] = "name_skin",
					["VG"] = "name_vg",
				}

				local perkname = perkData.name
				local customname = perkname[perktype]
				if customname and perkData[customname] then
					perkname = perkData[customname]
				end

				text = "Press "..usekey..perkname.." [Cost: " .. string.Comma(ent:GetPrice()) .. "]"
				if #ply:GetPerks() >= nz_maxperks then
					text = "You may only carry " .. nz_maxperks.. " perks"
				end

				if ply:HasPerk(ent:GetPerkID()) and (!nzMapping.Settings.perkupgrades or ply:HasUpgrade(ent:GetPerkID())) then
					text = "You already own this perk"
				elseif ply:HasPerk(ent:GetPerkID()) and !ply:HasUpgrade(ent:GetPerkID()) and ent.GetUpgradePrice then
					text = "Press "..usekey.."Upgrade "..perkname.." [Cost: " .. string.Comma(ent:GetUpgradePrice()) .. "]"
				end
			end
		end

		if ent.GetWinding and ent:GetWinding() then
			text = ""
		end

		if ply:IsInCreative() and !ent:BrutusLocked() and !ent:IsOn() then
			local perkData = nzPerks:Get(ent:GetPerkID())
			local perkname = perkData.name
			if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
				perkname = perkData.name_skin
			end

			local dohide = ent:GetDoorActivated() and " | Door Activated" or ""
			local randomize = ent:GetRandomize() and " | Randomized" or ""
			local randomfizz = ent:GetRandomizeFizz() and " | Use Wunderfizz List" or ""
			local randomizerounds = ent:GetRandomizeRounds() and " | Randomize Interval "..ent:GetRandomizeInterval() or ""

			text = "Perk Machine | "..perkname.." | '"..ent:GetPerkID().."'"..dohide..randomize..randomfizz..randomizerounds
		end

		return text
	end,
	["nz_teleporter"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		local text = ""
		if !ent:GetUseable() then return text end
		if !ent:IsOn() then
			text = "You must turn on the electricity first!"
		elseif ent:GetBeingUsed() then
			text = "Teleporting..."
		elseif ent:GetOnCooldown() then
			text = "Teleporter on cooldown!"
		else
			if #ent:GetDestinationsUnlocked() <= 0 then
				text = "A door must be unlocked for this"
			else
				-- Its on
				text = "Press " .. usekey .. "Use Teleporter [Cost: " .. string.Comma(ent:GetPrice()) .. "]"
			end
		end

		if !ply:GetNotDowned() then
			text = "You cannot use this when down"
		end

		if ply:IsInCreative() then
			text = "Press " .. usekey .. " to Test Teleporter"
		elseif #ent:GetDestinations() <= 0 then
			text = "This cannot be used, it is improperly configured"
		end

		return text
	end,
	/*["buyable_ending"] = function(ent)
		return "Press " .. usekey .. "End game [Cost: " .. string.Comma(ent:GetPrice()) .. "]"
	end,*/
	["player_spawns"] = function() if nzRound:InState( ROUND_CREATE ) then return "Player Spawn" end end,
	["nz_spawn_zombie_normal"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Spawn" end end,
	["nz_spawn_zombie_special"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Special Spawn" end end,
	["nz_spawn_zombie_boss"] = function() if nzRound:InState( ROUND_CREATE ) then return "Zombie Boss Spawn" end end,
	["pap_weapon_trigger"] = function(ent)
		local wepclass = ent:GetWepClass()
		local wep = weapons.Get(wepclass)
		local name = "UNKNOWN"
		if wep != nil then
			name = nz.Display_PaPNames[wepclass] or nz.Display_PaPNames[wep.PrintName] or "Upgraded "..wep.PrintName
		end
		name = "Press " .. usekey .. "for " .. name .. ""

		return name
	end,
	["wunderfizz_machine"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
		
		local blockedperks = {
			["wunderfizz"] = true,
			["pap"] = true,
		}
		local nz_maxperks = ply:GetMaxPerks()
		local text = ""

		if nzMapping.Settings.cwfizz then
			if not ent:IsOn() then
				text = "You must turn on the electricity first!"
			else
				if !ply:IsInCreative() and nzMapping.Settings.cwfizzround and nzRound:GetNumber() < nzMapping.Settings.cwfizzround then
					text = "Come back on round "..nzMapping.Settings.cwfizzround.." to use the Der Wunderfizz!"
				else
					text = "Press "..usekey.."Purchase a variety of perks"
				end
			end
		elseif not ent:IsOn() then
			text = "The Wunderfizz Orb is currently at another location"
		elseif ent:GetBeingUsed() and IsValid(ent:GetUser()) then
			if ent:GetUser() == ply then
				if ent:GetPerkID() ~= "" and not ent:GetIsTeddy() then
					local perkData = nzPerks:Get(ent:GetPerkID())
					local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
					local perkname = {
						["IW"] = "name_skin",
						["VG"] = "name_vg",
					}

					local perkname = perkData.name
					local customname = perkname[perktype]
					if customname and perkData[customname] then
						perkname = perkData[customname]
					end

					text = "Press "..usekey..perkname
				else/*if ent:GetIsTeddy() then
					text = "Changing Location..."
				else
					text = "Selecting Beverage..."
				end*/
					text = ""
				end
			else
				if ent:GetPerkID() ~= "" and not ent:GetIsTeddy() then
					local perkData = nzPerks:Get(ent:GetPerkID())
					local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
					local perkname = {
						["IW"] = "name_skin",
						["VG"] = "name_vg",
					}

					local perkname = perkData.name
					local customname = perkname[perktype]
					if customname and perkData[customname] then
						perkname = perkData[customname]
					end

					text = perkname
				elseif ent:GetIsTeddy() then
					text = "You may now clown "..ent:GetUser():Nick()
				else
					text = ""
				end
			end
		elseif not ent:GetBeingUsed() and ent:IsOn() then
			if #ply:GetPerks() >= nz_maxperks then
				text = "You may only carry "..nz_maxperks.." perks"
			else
				local b_no_perks = true
				for k, v in pairs(nzMapping.Settings.wunderfizzperklist) do
					if !blockedperks[k] and tobool(v[1]) and !ply:HasPerk(k) then
						b_no_perks = false
						break
					end
				end

				if b_no_perks then
					text = "You cannot carry any more perks!"
				else
					text = "Press "..usekey.."Use Wunderfizz Orb [Cost: "..string.Comma(ent:GetPrice()).."]"
				end
			end
		end

		return text
	end,
	["item_suitcharger"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		if ply:Armor() < ply:GetMaxArmor() then
			return "Press & Hold "..usekey.."recharge armor"
		else
			return ""
		end
	end,
	["item_healthcharger"] = function(ent)
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

		if ply:Health() < ply:GetMaxHealth() then
			return "Press & Hold "..usekey.."heal"
		else
			return ""
		end
	end,
	["prop_thumper"] = function(ent)
		return "Press "..usekey.."toggle Thumper"
	end,
}

local ents = ents
local surface = surface
local draw = draw

local ents_FindByClass = ents.FindByClass
local ents_FindInSphere = ents.FindInSphere

local color_black_180 = Color(0, 0, 0, 180)
local color_black_120 = Color(0, 0, 0, 120)
local color_black_100 = Color(0, 0, 0, 100)
local color_nzwhite = Color(225, 235, 255,255)
local color_gold = Color(255, 255, 100, 255)
local color_red = Color(255, 20, 20, 255)
local color_white_50 = Color(255, 255, 255, 50)

if GetConVar("nz_hud_show_targeticon") == nil then
	CreateClientConVar("nz_hud_show_targeticon", 1, true, false, "Enable or disable displaying an entity's HUD icon above their hint string. (0 false, 1 true), Default is 1.", 0, 1)
end

local cl_drawhud = GetConVar("cl_drawhud")
local nz_betterscaling = GetConVar("nz_hud_better_scaling")
local nz_perkrowmod = GetConVar("nz_hud_perk_row_modulo")
local nz_showicons = GetConVar("nz_hud_show_targeticon")

local zmhud_icon_frame = Material("nz_moo/icons/perk_frame.png", "unlitgeneric smooth")
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
local zmhud_icon_interact = Material("vgui/hud/hud_grenadethrowback_glow.png", "unlitgeneric smooth")

local function GetDoorText( ent )
	local door_data = ent:GetDoorData()
	local text = ""
	
	--[[if istable(door_data) then
		PrintTable(door_data)
	else
		print("fuck")
	end]]


	if door_data and nzRound:InState(ROUND_CREATE) then
	local link = door_data.link
	local price = tonumber(door_data.price)
	local req_elec = tobool(door_data.elec)
		if tobool(door_data.elec) and tonumber(door_data.price) == 0 then
			text = "This door will open when electricity is turned on."
		elseif link then
		if req_elec then
			text = "Door Price: " .. string.Comma(price) .." Points. Requires Power. Door Flag: " .. string.Comma(link) ..""
			else
			text = "Door Price: " .. string.Comma(price) .." Points. Door Flag: " .. string.Comma(link) ..""
		end
			else
			text ="wiener."
		end
	elseif door_data and tonumber(door_data.buyable) == 1 then
		local price = tonumber(door_data.price)
		local req_elec = tobool(door_data.elec)
		

		if ent:IsLocked() then
			if req_elec and !IsElec() then
				text = "You must turn on the electricity first!"
			elseif price > 0 then
				text = "Press " .. usekey .. "Clear Debris [Cost: " .. string.Comma(price) .. "]"
			elseif price < 0 then
				text = "Press " .. usekey .. "Salvage [+" .. string.Comma(price * -1) .. "]"
			else
				text = "Press " .. usekey .. "Clear Debris"
			end
		end
		elseif door_data and tonumber(door_data.buyable) != 1 and nzRound:InState( ROUND_CREATE ) then
		if link then
		text = "Door cannot be purchased and opens when flag " .. string.Comma(link) .. " is activated"
		else
		text = "This door is locked and cannot be bought in-game."
		end
		--PrintTable(door_data)
	end
	return text
end

local function GetText( ent )
	if !IsValid(ent) then return "" end
	
	if ent.GetNZTargetText then return ent:GetNZTargetText() end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	local class = ent:GetClass()
	local text = ""

	local neededcategory, deftext, hastext = ent:GetNWString("NZRequiredItem"), ent:GetNWString("NZText"), ent:GetNWString("NZHasText")
	local itemcategory = ent:GetNWString("NZItemCategory")

	if neededcategory != "" then
		local hasitem = ply:HasCarryItem(neededcategory)
		text = hasitem and hastext != "" and hastext or deftext
	elseif deftext != "" then
		text = deftext
	elseif itemcategory != "" then
		local item = nzItemCarry.Items[itemcategory]
		local hasitem = ply:HasCarryItem(itemcategory)
		if hasitem then
			text = item and item.hastext or "You already have this"
		else
			text = usekey .. "Take"
		end
	elseif ent:IsPlayer() then
		if ent:GetNotDowned() then
			local health = ent:Health()
			local armor = ent:Armor()
			if armor <= 0 then
				armor = ""
			else
				armor = " | "..armor.." AP"
			end

			text = ent:Nick().." - "..health.." HP"..armor
		else
			text = usekey.."Revive "..ent:Nick()
		end
	elseif ent:IsDoor() or ent:IsButton() or ent:GetClass() == "class C_BaseEntity" or ent:IsBuyableProp() then
		text = GetDoorText(ent)
	else
		text = traceents[class] and traceents[class](ent)
	end

	return text
end

local function GetMapScriptEntityText()
	local text = ""
	local pos = EyePos()

	for k, v in nzLevel.GetTriggerZoneArray() do
		if IsValid(v) and v:NearestPoint(pos):DistToSqr(pos) <= 1 then
			text = GetDoorText(v)
			break
		end
	end

	return text
end

local perkmachineclasses = {
	["wunderfizz_machine"] = true,
	["perk_machine"] = true,
}

local function DrawTargetID(text, ent, dist)
	if not text then return end

	local font = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))
	local font2 = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))

	local ply = LocalPlayer()
	local b_spectating = false
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
		b_spectating = true
	end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.IsSpecial and wep:IsSpecial() then
		local papapunch = (IsValid(ent) and ent:GetClass() == "perk_machine" and ent:GetPerkID() == "pap")
		if (wep.NZSpecialCanUse and papapunch and !wep.NZSpecialPAP) or (wep.NZSpecialPAP and !papapunch) then
			return
		end
		if !wep.NZSpecialCanUse and !wep.NZSpecialPAP then
			return
		end
	end

	if ply.GetUsingSpecialWeapon and ply:GetUsingSpecialWeapon() and IsValid(wep) and !wep.NZSpecialPAP then return end

	if nzRevive.Players and nzRevive.Players[ply:EntIndex()] then
		local rply = nzRevive.Players[ply:EntIndex()].RevivePlayer
		if !ply:GetNotDowned() and IsValid(rply) and rply:IsPlayer() then return end
	end

	if !ply:GetNotDowned() and not ply:GetDownedWithTombstone() then return end

	local modern = nzDisplay.modernHUDs[nzMapping.Settings.hudtype]
	local scw, sch = ScrW(), ScrH()
	local scale = (scw/1920 + 1)/2
	local lowres = scale < 0.96
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = scale
	end

	if lowres then
		font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
		font2 = ("nz.ammo."..GetFontType(nzMapping.Settings.ammofont))
	end

	// grenade rethrow
	for k, v in pairs(ents_FindInSphere(ply:GetPos(), 64)) do
		if v.NZNadeRethrow and v:GetCreationTime() + 0.25 < CurTime() then
			local nadekey = GetConVar("nz_key_grenade"):GetInt()
			text = "Press "..string.upper(input.GetKeyName(nadekey)).." - Rethrow Grenade"
			ent = v
			break
		end

		if (!text or text == "") and v:GetClass() == "breakable_entry" and v:GetHasPlanks() and v:GetNumPlanks() < 6 and v:GetPos():DistToSqr(ply:GetPos()) <= 2500 then
			text = "Hold "..usekey.."Rebuild Barricade"
			ent = v
			break
		end
	end

	// tombstone
	if ply:GetDownedWithTombstone() then text = "Press & Hold "..usekey.."Feed the Zombies" end

	surface.SetFont(font)
	local tw, th = surface.GetTextSize(text)

	if IsValid(ent) then
		local showicons = nz_showicons:GetBool()

		// player perks
		if showicons and ent:IsPlayer() then
			local perks = ent:GetPerks()
			local size = 34
			local num, row = 0, 0
			local curtime = CurTime()

			for _, perk in pairs(perks) do
				local icon = GetPerkIconMaterial(perk)
				if not icon or icon:IsError() then
					icon = zmhud_icon_missing
				end

				local fuck = math.min(#perks, nz_perkrowmod:GetInt())

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_white)

				local data = nzPerks:Get(perk)
				if data and data.mmohud then
					local mmohud = data.mmohud
					if (!mmohud.upgradeonly or (mmohud.upgradeonly and ent:HasUpgrade(v))) and (!mmohud.solo or game.SinglePlayer()) then
						if (mmohud.countup and mmohud.max and ent:GetNW2Int(tostring(mmohud.count), 0) >= mmohud.max) or (mmohud.countdown and ent:GetNW2Int(tostring(mmohud.count), 0) == 0) or (mmohud.delay and ent:GetNW2Float(tostring(mmohud.delay), 0) > curtime) then
							surface.SetDrawColor(color_white_50)
						end
					end
				end

				surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale, (sch - 280*pscale - (th+12)) - size*row, size*pscale, size*pscale)

				if ent:HasUpgrade(perk) then
					surface.SetDrawColor(color_gold)
					surface.SetMaterial(GetPerkFrameMaterial())
					surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale, (sch - 280*pscale - (th+12)) - size*row, size*pscale, size*pscale)
				end

				if perk == "phd" and ent:GetNW2Bool("nz.PHDJumpd", false) then
					surface.SetDrawColor(color_red)
					surface.SetMaterial(GetPerkFrameMaterial())
					surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale, (sch - 280*pscale - (th+12)) - size*row, size*pscale, size*pscale)
				end

				if perk == "cherry" and ent:GetNW2Bool("nz.CherryBool", false) then
					surface.SetDrawColor(color_red)
					surface.SetMaterial(GetPerkFrameMaterial())
					surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale, (sch - 280*pscale - (th+12)) - size*row, size*pscale, size*pscale)
				end

				if perk == "vulture" and ent:HasVultureStink() then
					surface.SetMaterial(zmhud_vulture_glow)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale - 15*pscale, (sch - 280*pscale - (th+12)) - size*row - 15*pscale, 64*pscale, 64*pscale)

					local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
					surface.SetTexture(stink)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(scw/2 + (num*(size + 2)*pscale) - (fuck/2)*size*pscale, (sch - 280*pscale - (th+12)) - size*row - 42*pscale, 42*pscale, 42*pscale)
				end

				num = num + 1
				if num%(nz_perkrowmod:GetInt()) == 0 then row = row + 1 num = 0 end
			end
		end

		surface.SetDrawColor(color_white)

		// hud icon
		if showicons then
			local targeticon

			local wpos = scw/2 - 32*pscale
			local ypos = sch - 280*pscale - (th+48*pscale)
			/*if ent:IsPlayer() and !ent:GetNotDowned() and !ply:GetPlayerReviving() then
				local syrette = nzMapping.Settings.syrette
				if syrette then
					local revdata = weapons.Get(tostring(syrette))
					if revdata and revdata.NZHudIcon then
						targeticon = (modern and revdata.NZHudIcon_t7) and revdata.NZHudIcon_t7 or revdata.NZHudIcon
					end
				end
			else*/if ent:IsPlayer() then
				if ent.GetDownButtons and ent:HasUpgrade("whoswho") and ent:HasButtonDown(IN_USE) and ent:HasButtonDown(IN_RELOAD) then 
					if ent:GetNW2Float("nz.ChuggaTeleDelay", 0) < CurTime() and dist < 4096 then
						text = "Hold "..usekey.."Grab on"
						tw, th = surface.GetTextSize(text)
					end
				else
					local gum = nzGum:GetActiveGumData(ent)
					if gum and gum.icon then
						targeticon = gum.icon
						ypos = sch - 280*pscale + (th-48*pscale) + 24*pscale
					end
				end
			elseif ent.NZHudIcon then
				targeticon = (modern and ent.NZHudIcon_t7) and ent.NZHudIcon_t7 or ent.NZHudIcon
			elseif ent.GetWepClass then
				local wepdata = weapons.Get(tostring(ent:GetWepClass()))
				if wepdata and wepdata.NZHudIcon then
					targeticon = (modern and wepdata.NZHudIcon_t7) and wepdata.NZHudIcon_t7 or wepdata.NZHudIcon
				end
			end

			if targeticon and not targeticon:IsError() then
				surface.SetMaterial(targeticon)
				surface.DrawTexturedRect(wpos, ypos, 64*pscale, 64*pscale)
			end
		end

		// perk machines
		if perkmachineclasses[ent:GetClass()] and (nzRound:InState(ROUND_CREATE) or (ent.IsOn and ent:IsOn() or IsElec())) then
			local perkData = nzPerks:Get(ent:GetPerkID())
			if perkData and (perkData.desc) and (!ent.GetWinding or !ent:GetWinding()) then
				local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
				local perkcolors = {
					["VG"] = "color_vg",
					["CLASSIC"] = "color_classic",
					["CW"] = "color_cw",
				}

				local textcolor = perkData.color
				local customcolor = perkcolors[perktype]
				if customcolor and perkData[customcolor] then
					textcolor = perkData[customcolor]
				end

				local tw2, th2 = surface.GetTextSize(perkData.desc)
				local bad = tw2 > scw and "nz.ammo2."..GetFontType(nzMapping.Settings.ammofont) or nil

				draw.SimpleTextOutlined("Effect: "..perkData.desc, bad or font2, scw/2, sch - 230*pscale, textcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, (nzMapping.Settings.fontthicc or 1), color_black_180)
				if perkData.desc2 then
					draw.SimpleTextOutlined("Modifier: "..perkData.desc2, bad or font2, scw/2, sch - 200*pscale, textcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, (nzMapping.Settings.fontthicc or 1), color_black_180)
				end

				if showicons then
					local icon = GetPerkIconMaterial(ent:GetPerkID())
					if icon and !icon:IsError() then
						surface.SetMaterial(icon)
						surface.DrawTexturedRect(scw/2 - 32, sch - 280*pscale - (th+48), 64, 64)
					end
				end
			end
		end

		// secondary descriptions
		if ent.GetNZTargetText and ent.GetNZTargetText2 then
			local text2 = ent:GetNZTargetText2()
			if text2 and text2 ~= "" then
				draw.SimpleTextOutlined(text2, font, scw/2, sch - 230*pscale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, (nzMapping.Settings.fontthicc or 2), color_black_180)
			end
		end
	end

	// textbox background
	if text ~= "" and modern then
		surface.SetDrawColor(color_black_100)
		surface.DrawRect(scw/2 - ((tw/2)+12), sch - 280*pscale - (th/2), tw+24, th)
	end

	local textcolor = color_white
	if nzMapping.Settings.textcolor and IsColor(nzMapping.Settings.textcolor) then
		textcolor = nzMapping.Settings.textcolor
	end

	draw.SimpleTextOutlined(text, font, scw/2, sch - 280*pscale, textcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, (nzMapping.Settings.fontthicc or 2), color_black_180)
end

function GM:HUDDrawTargetID()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawHintHUD() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local tr = ply:GetEyeTrace()
	local ent = tr.Entity
	local dist = tr.HitPos:DistToSqr(ply:EyePos())

	if IsValid(ent) and dist < 14400 then
		DrawTargetID(GetText(ent), ent, dist)
	else
		DrawTargetID(GetMapScriptEntityText())
	end
end
