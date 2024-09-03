
function nzMapping:LoadMapSettings(data)
	if !data then return end

	if data.startwep then
		nzMapping.Settings.startwep = weapons.Get(data.startwep) and data.startwep or "robotnik_bo1_1911"
	else
		nzMapping.Settings.startwep = "robotnik_bo1_1911"
	end

	//register display type of starting pistol, for reasons
	local class = nzMapping.Settings.startwep
	if class then
		local wep = weapons.Get(class)
		if wep then
			if nzSpecialWeapons:ModifyWeapon(wep, "display", {DrawFunction = false, ToHolsterFunction = function(wep) return false end}) then
				wep.Category = "Other"
				wep.StoredNZAmmo = wep.Primary.ClipSize*4 //i realise now that this does nothing
				wep.NZSpecialShowHUD = true
				wep.NZTotalBlacklist = true
				wep.NZCamoBlacklist = true
				wep.NZSpecialCategory = "display"
				wep.NZSpecialWeaponData = {MaxAmmo = wep.Primary.ClipSize*4, AmmoType = wep.Primary.Ammo}
				weapons.Register(wep, class.."_display")
			end
		end
	end

	if data.nomodifierslot then //temporary fix for configs with previous mapsetting name 
		nzMapping.Settings.nomodifierslot = nil
		data.nomodifierslot = nil

		data.modifierslot = !tobool(data.nomodifierslot) //invert
	end

	if data.knife then
		nzMapping.Settings.knife = weapons.Get(data.knife) and data.knife or "tfa_bo1_knife"
	else
		nzMapping.Settings.knife = "tfa_bo1_knife"
	end
	if data.grenade then
		nzMapping.Settings.grenade = weapons.Get(data.grenade) and data.grenade or "tfa_bo1_m67"
	else
		nzMapping.Settings.grenade = "tfa_bo1_m67"
	end
	if data.bottle then
		nzMapping.Settings.bottle = weapons.Get(data.bottle) and data.bottle or "tfa_perk_bottle"
	else
		nzMapping.Settings.bottle = "tfa_perk_bottle"
	end
	if data.syrette then
		nzMapping.Settings.syrette = weapons.Get(data.syrette) and data.syrette or "tfa_bo2_syrette"
	else
		nzMapping.Settings.syrette ="tfa_bo2_syrette"
	end
	if data.paparms then
		nzMapping.Settings.paparms = weapons.Get(data.paparms) and data.paparms or "tfa_paparms"
	else
		nzMapping.Settings.paparms = "tfa_paparms"
	end
	if data.deathmachine then
		nzMapping.Settings.deathmachine = weapons.Get(data.deathmachine) and data.deathmachine or "tfa_nz_bo3_minigun"
	else
		nzMapping.Settings.deathmachine = "tfa_nz_bo3_minigun"
	end
	if data.shield and weapons.Get(data.shield) then
		nzMapping.Settings.shield = data.shield
	else
		nzMapping.Settings.shield = nil
	end

	nzMapping.Settings.eeurl = data.eeurl or nil
	nzMapping.Settings.script = data.script or nil
	nzMapping.Settings.scriptinfo = data.scriptinfo or nil

	if data.rboxweps then
		if table.Count(data.rboxweps) > 0 then
			local tbl = {}
			for k,v in pairs(data.rboxweps) do
				local wep = weapons.Get(k)
				if wep and !wep.NZTotalBlacklist and !wep.NZPreventBox then -- Weapons are keys
					tbl[k] = tonumber(v) or 10 -- Set weight to value or 10
				else
					wep = weapons.Get(v) -- Weapons are values (old format)
					if wep and !wep.NZTotalBlacklist and !wep.NZPreventBox then
						tbl[v] = 10 -- Set weight to 10
					else
						-- No valid weapon on either key or value
						if tonumber(k) == nil then -- For every key that isn't a number (new format keys are classes)
							tbl[k] = 10
						end
						if tonumber(v) == nil then -- Or for every value that isn't a number (old format values are classes)
							tbl[v] = 10 -- Insert them anyway to make use of mismatch
						end
					end
				end
			end
			nzMapping.Settings.rboxweps = tbl
		else
			nzMapping.Settings.rboxweps = nil
		end
	end

	-- Wunderfizz Perks --
	if data.wunderfizzperklist then
		for k, v in pairs(data.wunderfizzperklist) do
			if (!nzPerks.Data[k]) then
				data.wunderfizzperklist[k] = nil
				print("[nZ Perks] Removed invalid perk: " .. k)
			end
		end

		for k, v in pairs(nzPerks.Data) do
			if !data.wunderfizzperklist[k] then
				data.wunderfizzperklist[k] = {true, v.name}
			end
		end

		nzMapping.Settings.wunderfizzperklist = data.wunderfizzperklist
	else
		local wunderfizzlist = {}
		for k, v in pairs(nzPerks:GetList()) do
			if k != "wunderfizz" and k != "pap" then
				wunderfizzlist[k] = {true, v}
			end
		end

		nzMapping.Settings.wunderfizzperklist = wunderfizzlist
	end

	-- Powerups --
	if data.poweruplist then
		for k, v in pairs(data.poweruplist) do
			if (!nzPowerUps.Data[k]) then
				data.poweruplist[k] = nil
				print("[nZ PowerUps] Removed invalid powerup: " .. k)
			end
		end

		for k, v in pairs(nzPowerUps.Data) do
			if !data.poweruplist[k] then
				data.poweruplist[k] = {true, v.name}
			end
		end

		nzMapping.Settings.poweruplist = data.poweruplist
	else
		local poweruplist = {}
		for k, v in pairs(nzPowerUps.Data) do
			if v.natural then
				poweruplist[k] = {true, v.name}
			end
		end

		nzMapping.Settings.poweruplist = poweruplist
	end

	-- Gums --
	if data.gumlist then
		for k, v in pairs(data.gumlist) do
			if (!nzGum.Gums[k]) then
				data.gumlist[k] = nil
				print("[nZ Gums] Removed invalid gum: " .. k)
			end
		end

		for k, v in pairs(nzGum.Gums) do
			if !data.gumlist[k] then
				data.gumlist[k] = {true, nzGum.RollCounts[data.rare or nzGum.RareTypes.DEFAULT]}
			end
		end

		nzMapping.Settings.gumlist = data.gumlist
	else
		local gumlist = {}
		for id, data in pairs(nzGum.Gums) do
			gumlist[id] = {true, nzGum.RollCounts[data.rare or nzGum.RareTypes.DEFAULT]}
		end

		nzMapping.Settings.gumlist = gumlist
	end

	if data.gumpricelist then
		for k, v in pairs(nzGum.RoundPrices) do
			if !data.gumpricelist[k] then
				data.gumpricelist[k] = v
			end
		end

		nzMapping.Settings.gumpricelist = data.gumpricelist
	else
		nzMapping.Settings.gumpricelist = nzGum.RoundPrices
	end

	if data.gummultipliers then
		for k, v in pairs(nzGum.ChanceMultiplier) do
			if !data.gummultipliers[k] then
				data.gummultipliers[k] = v
			end
		end

		nzMapping.Settings.gummultipliers = data.gummultipliers
	else
		nzMapping.Settings.gummultipliers = nzGum.ChanceMultiplier
	end

	if data.gumcountresetrounds then
		for k, v in pairs(nzGum.RollCountResetRounds) do
			if !data.gumcountresetrounds[k] then
				data.gumcountresetrounds[k] = v
			end
		end

		nzMapping.Settings.gumcountresetrounds = data.gumcountresetrounds
	else
		nzMapping.Settings.gumcountresetrounds = nzGum.RollCountResetRounds
	end

	nzMapping.Settings.gumchanceresetrounds = data.gumchanceresetrounds or nzGum.RollChanceResetRounds

	-- Map General --
	nzMapping.Settings.gamemodeentities = data.gamemodeentities or nil
	nzMapping.Settings.specialroundtype = data.specialroundtype or "Hellhounds"
	nzMapping.Settings.zombietype = data.zombietype or "Kino der Toten"
	nzMapping.Settings.bosstype = data.bosstype or "Panzer"
	nzMapping.Settings.startpoints = data.startpoints and tonumber(data.startpoints) or 500
	nzMapping.Settings.range = data.range and tonumber(data.range) or 2000
	nzMapping.Settings.hp = data.hp and tonumber(data.hp) or 100

	nzMapping.Settings.navgroupbased = data.navgroupbased or nil
	nzMapping.Settings.sidestepping = data.sidestepping or nil
	nzMapping.Settings.badattacks = data.badattacks or nil

	-- Map Functionality --
	nzMapping.Settings.antipowerups = data.antipowerups or false
	nzMapping.Settings.antipowerupchance = data.antipowerupchance or 40
	nzMapping.Settings.antipowerupstart = data.antipowerupstart or 2
	nzMapping.Settings.antipowerupdelay = data.antipowerupdelay or 4

	nzMapping.Settings.perkupgrades = tobool(data.perkupgrades) or false
	nzMapping.Settings.aats = data.aats or 2
	nzMapping.Settings.roundperkbonus = data.roundperkbonus == nil and true or data.roundperkbonus
	nzMapping.Settings.solorevive = data.solorevive or 3
	nzMapping.Settings.modifierslot = data.modifierslot == nil and true or data.modifierslot
	nzMapping.Settings.dontkeepperks = data.dontkeepperks or false

	-- Map Visual --
	nzMapping.Settings.powerupoutline = data.powerupoutline or 0
	nzMapping.Settings.powerupstyle = data.powerupstyle or "style_classic"

	nzMapping.Settings.hudtype = data.hudtype or "Black Ops 1"
	nzMapping.Settings.mmohudtype = data.mmohudtype or "World at War/ Black Ops 1"
	nzMapping.Settings.poweruptype = data.poweruptype or "Black Ops 1"
	nzMapping.Settings.downsoundtype = data.downsoundtype or "Black Ops 3"
	nzMapping.Settings.icontype = (data.icontype) or "World at War/ Black Ops 1"
	nzMapping.Settings.turnedlist = data.turnedlist

	nzMapping.Settings.boxtype = data.boxtype or "Original"
	nzMapping.Settings.perkmachinetype = data.perkmachinetype or "Original"
	nzMapping.Settings.PAPtype = data.PAPtype or "Original"
	nzMapping.Settings.PAPcamo = data.PAPcamo or "nz_classic"

	-- Font --
	nzMapping.Settings.mainfont = (data.mainfont) or "Default NZR"
	nzMapping.Settings.smallfont = (data.smallfont) or "Default NZR"
	nzMapping.Settings.mediumfont = (data.mediumfont) or "Default NZR"
	nzMapping.Settings.roundfont = (data.roundfont) or "Classic NZ"
	nzMapping.Settings.ammofont = (data.ammofont) or "Default NZR"
	nzMapping.Settings.ammo2font = (data.ammo2font) or "Default NZR"
	nzMapping.Settings.fontthicc = tonumber(data.fontthicc) or 2

	-- Catalyst and ZCT and Burning --
	nzMapping.Settings.zct = data.zct or nil
	nzMapping.Settings.mutated = data.mutated or nil
	nzMapping.Settings.burning = data.burning or nil

	nzMapping.Settings.burningchance = data.burningchance == nil and 50 or data.burningchance
	nzMapping.Settings.burningrnd = data.burningrnd == nil and 13 or data.burningrnd


	nzMapping.Settings.redchance = data.redchance == nil and 85 or data.redchance
	nzMapping.Settings.redrnd = data.redrnd == nil and 2 or data.redrnd

	nzMapping.Settings.bluechance = data.bluechance == nil and 85 or data.bluechance
	nzMapping.Settings.bluernd = data.bluernd == nil and 6 or data.bluernd

	nzMapping.Settings.greenchance = data.greenchance == nil and 85 or data.greenchance
	nzMapping.Settings.greenrnd = data.greenrnd == nil and 14 or data.greenrnd

	nzMapping.Settings.yellowchance = data.yellowchance == nil and 85 or data.yellowchance
	nzMapping.Settings.yellowrnd = data.yellowrnd == nil and 12 or data.yellowrnd

	nzMapping.Settings.purplechance = data.purplechance == nil and 85 or data.purplechance
	nzMapping.Settings.purplernd = data.purplernd == nil and 16 or data.purplernd

	nzMapping.Settings.pinkchance = data.pinkchance == nil and 85 or data.pinkchance
	nzMapping.Settings.pinkrnd = data.pinkrnd == nil and 26 or data.pinkrnd


	nzMapping.Settings.poisonchance = data.poisonchance == nil and 20 or data.poisonchance
	nzMapping.Settings.poisonrnd = data.poisonrnd == nil and 10 or data.poisonrnd

	nzMapping.Settings.waterchance = data.waterchance == nil and 5 or data.waterchance
	nzMapping.Settings.waterrnd = data.waterrnd == nil and 12 or data.waterrnd

	nzMapping.Settings.firechance = data.firechance == nil and 15 or data.firechance
	nzMapping.Settings.firernd = data.firernd == nil and 14 or data.firernd

	nzMapping.Settings.electricchance = data.electricchance == nil and 10 or data.electricchance
	nzMapping.Settings.electricrnd = data.electricrnd == nil and 16 or data.electricrnd
	
	-- Timed Gameplay / Cold War Points --
	nzMapping.Settings.timedgame = data.timedgame or nil
	nzMapping.Settings.timedgametime = data.timedgametime == nil and 120 or data.timedgametime
	nzMapping.Settings.timedgamemaxtime = data.timedgamemaxtime == nil and 600 or data.timedgamemaxtime
	nzMapping.Settings.cwpointssystem = data.cwpointssystem or nil

	-- Zombie General --
	nzMapping.Settings.startingspawns = data.startingspawns == nil and 4 or data.startingspawns
	nzMapping.Settings.spawnperround = data.spawnperround == nil and 1 or data.spawnperround
	nzMapping.Settings.maxspawns = data.maxspawns == nil and 24 or data.maxspawns
	nzMapping.Settings.zombiesperplayer = data.zombiesperplayer == nil and 6 or data.zombiesperplayer
	nzMapping.Settings.spawnsperplayer = data.spawnsperplayer == nil and 6 or data.spawnsperplayer
	nzMapping.Settings.spawndelay = data.spawndelay == nil and 2 or data.spawndelay
	nzMapping.Settings.speedmulti = data.speedmulti == nil and 4 or data.speedmulti
	nzMapping.Settings.amountcap = data.amountcap == nil and 168 or data.amountcap -- change the message, my final word. good morning. :shushing_face:\
	nzMapping.Settings.healthstart = data.healthstart == nil and 75 or data.healthstart
	nzMapping.Settings.healthinc = data.healthinc == nil and 50 or data.healthinc
	nzMapping.Settings.healthmod = data.healthmod == nil and 0.1 or data.healthmod
	nzMapping.Settings.healthcap = data.healthcap == nil and 6660000 or data.healthcap
	NZZombiesMaxAllowed = nzMapping.Settings.startingspawns

	-- Map Color Options --
	nzMapping.Settings.zombieeyecolor = data.zombieeyecolor == nil and Color(0, 255, 255, 255) or Color(data.zombieeyecolor.r, data.zombieeyecolor.g, data.zombieeyecolor.b)
	nzMapping.Settings.boxlightcolor = data.boxlightcolor == nil and Color(0, 150,200,255) or Color(data.boxlightcolor.r, data.boxlightcolor.g, data.boxlightcolor.b) 
	nzMapping.Settings.textcolor = data.textcolor == nil and Color(0, 255, 255, 255) or Color(data.textcolor.r, data.textcolor.g, data.textcolor.b) 
	nzMapping.Settings.powerupcol = data.powerupcol or {
		["global"] = {
			[1] = Vector(0.196,1,0),
			[2] = Vector(0.568,1,0.29),
			[3] = Vector(0.262,0.666,0),
		},
		["local"] = {
			[1] = Vector(0.372,1,0.951),
			[2] = Vector(0.556,1,0.99),
			[3] = Vector(0,0.64,0.666),
		},
		["mini"] = {
			[1] = Vector(1,0.823,0),
			[2] = Vector(1,0.854,0.549),
			[3] = Vector(0.627,0.431,0),
		},
		["anti"] = {
			[1] = Vector(1,0.156,0.156),
			[2] = Vector(1,0.392,0.392),
			[3] = Vector(0.705,0,0),
		},
		["tombstone"] = {
			[1] = Vector(0.568,0,1),
			[2] = Vector(0.705,0.392,1),
			[3] = Vector(0.431,0,0.784),
		}
	}
	nzMapping.Settings.papmuzzlecol = data.papmuzzlecol or {
		[1] = Vector(0.470,0,1),
		[2] = Vector(0.431,0.156,1),
		[3] = Vector(0.647,0.549,1),
		[4] = Vector(0.196,0.078,0.431),
		[5] = Vector(0.235,0.078,0.705),
	}
	nzMapping.Settings.wallbuydata = data.wallbuydata or {
		["glow"] = (nzMapping.Settings.boxlightcolor or Color(0,150,200,255)),
		["chalk"] = Color(255,255,255,255),
		["alpha"] = 30,
		["material"] = "sprites/wallbuy_light",
		["sizew"] = 128,
		["sizeh"] = 42,
	}

	-- Data Structs --
	for k,v in pairs(nzSounds.struct) do
		nzMapping.Settings[v] = data[v] or {}
	end

	/*for k,v in pairs(nzDisplay.hudstruct) do
		nzMapping.Settings[v] = data[v] or {}
	end*/

	-- Anti Cheat --
	nzMapping.Settings.ac = data.ac == nil and false or data.ac
	nzMapping.Settings.acwarn = data.acwarn == nil and true or data.acwarn
	nzMapping.Settings.acsavespot = data.acsavespot == nil and true or data.acsavespot
	nzMapping.Settings.acpreventboost = data.acpreventboost == nil and true or data.acpreventboost
	nzMapping.Settings.acpreventcjump = data.acpreventcjump == nil and false or data.acpreventcjump
	nzMapping.Settings.actptime = data.actptime == nil and 5 or data.actptime

	nzMapping:SendMapData()
	nzSounds:RefreshSounds()
end

//thats right, were gonna fucking cheat
hook.Add("PostConfigLoad", "nzSneakyMapSettings", function()
	local data = nzMapping.Settings
	nzMapping:LoadMapSettings(data)
end)