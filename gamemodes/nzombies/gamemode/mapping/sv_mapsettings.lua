
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
				data.wunderfizzperklist[k] = {false, v.name}
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
				data.poweruplist[k] = {false, v.name}
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

	-- Vulture drops --
	if data.vulturelist then
		for k, v in pairs(data.vulturelist) do
			if (!nzPerks.VultureData[k]) then
				data.vulturelist[k] = nil
				print("[nZ PowerUps] Removed invalid vulture drop: " .. k)
			end
		end

		for k, v in pairs(nzPerks.VultureData) do
			if !data.vulturelist[k] then
				data.vulturelist[k] = {false, v.name or string.NiceName(k)}
			end
		end

		nzMapping.Settings.vulturelist = data.vulturelist
	else
		local vulturelist = {}
		for k, v in pairs(nzPerks.VultureData) do
			if v.natural then
				vulturelist[k] = {true, v.name or string.NiceName(k)}
			end
		end

		nzMapping.Settings.vulturelist = vulturelist
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
				data.gumlist[k] = {false, nzGum.RollCounts[data.rare or nzGum.RareTypes.DEFAULT]}
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
	nzMapping.Settings.maxplayergumuses = data.maxplayergumuses and math.Round(data.maxplayergumuses) or 3
	nzMapping.Settings.gumstartprice = data.gumstartprice and math.Round(data.gumstartprice) or 0
	nzMapping.Settings.showgumstats = data.showgumstats == nil and true or tobool(data.showgumstats)

	-- Map General --
	nzMapping.Settings.gamemodeentities = data.gamemodeentities or nil
	nzMapping.Settings.specialroundtype = data.specialroundtype or "Hellhounds"
	nzMapping.Settings.zombietype = data.zombietype or "Kino der Toten"
	nzMapping.Settings.bosstype = data.bosstype or "None"
	nzMapping.Settings.startpoints = data.startpoints and tonumber(data.startpoints) or 500
	nzMapping.Settings.range = data.range and tonumber(data.range) or 2000
	nzMapping.Settings.navgroupbased = data.navgroupbased or nil

	-- Map Functionality --
	nzMapping.Settings.antipowerups = data.antipowerups or false
	nzMapping.Settings.antipowerupchance = data.antipowerupchance or 40
	nzMapping.Settings.antipowerupstart = data.antipowerupstart or 2
	nzMapping.Settings.antipowerupdelay = data.antipowerupdelay or 4

	nzMapping.Settings.poweruproundbased = tobool(data.poweruproundbased)
	nzMapping.Settings.maxpowerupdrops = data.maxpowerupdrops or 4
	if data.poweruprounds then
		for k, v in pairs(data.poweruprounds) do
			if (!nzPowerUps.Data[k]) then
				data.poweruprounds[k] = nil
			end
		end

		for k, v in pairs(nzPowerUps.Data) do
			if !data.poweruprounds[k] then
				data.poweruprounds[k] = v.rare and (v.chance > 0 and 10 or 20) or 0
			end
		end

		nzMapping.Settings.poweruprounds = data.poweruprounds
	else
		local poweruprounds = {}
		for k, v in pairs(nzPowerUps.Data) do
			poweruprounds[k] = v.rare and (v.chance > 0 and 10 or 20) or 0
		end

		nzMapping.Settings.poweruprounds = poweruprounds
	end

	nzMapping.Settings.cwfizz = tobool(data.cwfizz)
	nzMapping.Settings.cwfizzprice = data.cwfizzprice or 1000
	nzMapping.Settings.cwfizzperkslot = tobool(data.cwfizzperkslot)
	nzMapping.Settings.cwfizzslotprice = data.cwfizzslotprice or 10000
	nzMapping.Settings.cwfizzslotround = data.cwfizzslotround or 20
	nzMapping.Settings.cwfizzround = data.cwfizzround or 15

	nzMapping.Settings.movement = data.movement or 0
	nzMapping.Settings.playerperkmax = data.playerperkmax or 4
	nzMapping.Settings.perkupgrades = tobool(data.perkupgrades)
	nzMapping.Settings.aats = data.aats or 2
	nzMapping.Settings.roundperkbonus = data.roundperkbonus == nil and true or data.roundperkbonus
	nzMapping.Settings.solorevive = data.solorevive or 3
	nzMapping.Settings.modifierslot = data.modifierslot == nil and true or data.modifierslot
	nzMapping.Settings.maxperkslots = data.maxperkslots or 8
	nzMapping.Settings.dontkeepperks = tobool(data.dontkeepperks)
	nzMapping.Settings.tacticalupgrades = tobool(data.tacticalupgrades)
	nzMapping.Settings.tacticalkillcount = data.tacticalkillcount or 40
	nzMapping.Settings.maponlyrandomperks = tobool(data.maponlyrandomperks)
	nzMapping.Settings.gravity = data.gravity or 600
	nzMapping.Settings.juggbonus = data.juggbonus or 100
	nzMapping.Settings.papbeam = tobool(data.papbeam)
	nzMapping.Settings.randompap = tobool(data.randompap)
	nzMapping.Settings.randompapinterval = data.randompapinterval or 2
	nzMapping.Settings.randompaptime = data.randompaptime or 0
	nzMapping.Settings.minboxhit = data.minboxhit or 3
	nzMapping.Settings.maxboxhit = data.maxboxhit or 13
	nzMapping.Settings.boxstartuses = data.boxstartuses or 8
	nzMapping.Settings.rboxprice = data.rboxprice or 950
	nzMapping.Settings.maxteddypercent = data.maxteddypercent or 50
	nzMapping.Settings.minfizzuses = data.minfizzuses or 3
	nzMapping.Settings.maxfizzuses = data.maxfizzuses or 6
	nzMapping.Settings.specialsuseplayers = tobool(data.specialsuseplayers)
	nzMapping.Settings.downsystem = data.downsystem and tonumber(data.downsystem) or (nzMapping.Settings.dontkeepperks and 0 or 2)
	nzMapping.Settings.perkstokeep = data.perkstokeep and tonumber(data.perkstokeep) or 3

	nzMapping.Settings.dontkeepperks = nil

	nzMapping.Settings.roundwaittime = data.roundwaittime or 15
	nzMapping.Settings.specialroundwaittime = data.specialroundwaittime or 15
	nzMapping.Settings.specialroundmin = data.specialroundmin or 5
	nzMapping.Settings.specialroundmax = data.specialroundmax or 7
	nzMapping.Settings.forcefirstspecialround = tobool(data.forcefirstspecialround)
	nzMapping.Settings.firstspecialround = data.firstspecialround or 5
	nzMapping.Settings.slotrewardround = data.slotrewardround or 15
	nzMapping.Settings.slotrewardinterval = data.slotrewardinterval or 10
	nzMapping.Settings.slotrewardcount = data.slotrewardcount or 2

	nzMapping.Settings.nukedperks = tobool(data.nukedperks)
	nzMapping.Settings.nukedrandom = data.nukedrandom == nil and true or tobool(data.nukedrandom)
	nzMapping.Settings.nukedfizz = data.nukedfizz == nil and true or tobool(data.nukedfizz)
	nzMapping.Settings.nukedpap = data.nukedpap == nil and true or tobool(data.nukedpap)
	nzMapping.Settings.nukedroundmin = data.nukedroundmin or 3
	nzMapping.Settings.nukedroundmax = data.nukedroundmax or 5
	nzMapping.Settings.nukedspawn = nzMapping.Settings.nukedspawn or data.nukedspawn or nil

	nzMapping.Settings.gameovertext = data.gameovertext or "Game Over"
	nzMapping.Settings.survivedtext = data.survivedtext or "You Survived % Rounds"
	nzMapping.Settings.gamewintext = data.gamewintext or "Game Over"
	nzMapping.Settings.escapedtext = data.escapedtext or "You Escaped after % Rounds"
	nzMapping.Settings.gameovertime = data.gameovertime and tonumber(data.gameovertime) or 15
	nzMapping.Settings.gamewintime = data.gamewintime and tonumber(data.gamewintime) or 15
	nzMapping.Settings.gocamerawait = data.gocamerawait and tonumber(data.gocamerawait) or 5
	nzMapping.Settings.gocamerastart = nzMapping.Settings.gocamerastart or data.gocamerastart or {}
	nzMapping.Settings.gocameraend = nzMapping.Settings.gocameraend or data.gocameraend or {}

	-- Player Settings --
	nzMapping.Settings.hp = data.hp and tonumber(data.hp) or 150
	nzMapping.Settings.healthregendelay = data.healthregendelay and tonumber(data.healthregendelay) or 5
	nzMapping.Settings.healthregenratio = data.healthregenratio and math.Clamp(tonumber(data.healthregenratio), 0.01, 1) or 0.1
	nzMapping.Settings.healthregenrate = data.healthregenrate and tonumber(data.healthregenrate) or 0.05

	nzMapping.Settings.armor = data.armor or 200
	nzMapping.Settings.startarmor = data.startarmor or 0

	nzMapping.Settings.stamina = data.stamina and tonumber(data.stamina) or 100
	nzMapping.Settings.staminaregenamount = data.staminaregenamount and tonumber(data.staminaregenamount) or 4.5
	nzMapping.Settings.staminaregendelay = data.staminaregendelay and tonumber(data.staminaregendelay) or 0.5

	nzMapping.Settings.divingallowweapon = tobool(data.divingallowweapon)
	nzMapping.Settings.divingomnidirection = tobool(data.divingomnidirection)
	nzMapping.Settings.divingspeed = data.divingspeed and tonumber(data.divingspeed) or 1
	nzMapping.Settings.divingheight = data.divingheight and tonumber(data.divingheight) or 200
	nzMapping.Settings.divingwait = data.divingwait and tonumber(data.divingwait) or 0.2

	nzMapping.Settings.slidejump = tobool(data.slidejump)
	nzMapping.Settings.slidecooldown = data.slidecooldown or 0.4
	nzMapping.Settings.slideduration = data.slideduration or 0.6
	nzMapping.Settings.slidespeed = data.slidespeed or 1.3
	//nzMapping.Settings.slidestamina = data.slidestamina == nil and true or tobool(data.slidestamina)

	nzMapping.Settings.revivetime = data.revivetime and tonumber(data.revivetime) or 4
	nzMapping.Settings.downtime = data.downtime and tonumber(data.downtime) or 45
	nzMapping.Settings.flashlight = data.flashlight == nil and true or data.flashlight
	nzMapping.Settings.flashlightfov = data.flashlightfov and tonumber(data.flashlightfov) or 60
	nzMapping.Settings.flashlightfar = data.flashlightfar and tonumber(data.flashlightfar) or 750
	nzMapping.Settings.jumppower = data.jumppower and tonumber(data.jumppower) or 200

	-- Map Visual --
	nzMapping.Settings.typewriterintro = tobool(data.typewriterintro)
	nzMapping.Settings.typewritertext = data.typewritertext or "Berlin, Germany;Wittenau Sanatorium;September, 1945"
	nzMapping.Settings.typewriterdelay = data.typewriterdelay or 0.125
	nzMapping.Settings.typewriterlinedelay = data.typewriterlinedelay or 1.5
	nzMapping.Settings.typewriteroffset = data.typewriteroffset or 435

	nzMapping.Settings.gamebegintext = data.gamebegintext or "Round"
	nzMapping.Settings.blurpoweron = tobool(data.blurpoweron)
	nzMapping.Settings.monochrome = tobool(data.monochrome)
	nzMapping.Settings.powerupoutline = data.powerupoutline or 0
	nzMapping.Settings.powerupstyle = data.powerupstyle or "style_classic"

	nzMapping.Settings.hudtype = data.hudtype or "Black Ops 1"
	nzMapping.Settings.mmohudtype = data.mmohudtype or "World at War/ Black Ops 1"
	nzMapping.Settings.poweruptype = data.poweruptype or "Black Ops 1"
	nzMapping.Settings.downsoundtype = data.downsoundtype or "Black Ops 3"
	nzMapping.Settings.icontype = (data.icontype) or "World at War/ Black Ops 1"
	nzMapping.Settings.turnedlist = data.turnedlist

	nzMapping.Settings.boxtype = data.boxtype or nil
	nzMapping.Settings.perkmachinetype = data.perkmachinetype or "Classic"
	nzMapping.Settings.PAPtype = data.PAPtype or "Original"
	nzMapping.Settings.PAPcamo = data.PAPcamo or "nz_classic"

	nzMapping.Settings.skyintro = tobool(data.skyintro)
	nzMapping.Settings.skyintrotime = data.skyintrotime and tonumber(data.skyintrotime) or 1.4
	nzMapping.Settings.skyintroheight = data.skyintroheight and tonumber(data.skyintroheight) or 6000

	-- Font --
	nzMapping.Settings.mainfont = (data.mainfont) or "Black Ops 1"
	nzMapping.Settings.smallfont = (data.smallfont) or "Black Ops 1"
	nzMapping.Settings.mediumfont = (data.mediumfont) or "Black Ops 1"
	nzMapping.Settings.roundfont = (data.roundfont) or "Black Ops 1"
	nzMapping.Settings.ammofont = (data.ammofont) or "Black Ops 1"
	nzMapping.Settings.ammo2font = (data.ammo2font) or "Black Ops 1"
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
	nzMapping.Settings.timedgameroundwaittime = data.timedgameroundwaittime or 0.5
	nzMapping.Settings.cwpointssystem = data.cwpointssystem or nil

	-- Zombie General --
	nzMapping.Settings.startingspawns = data.startingspawns == nil and 35 or data.startingspawns
	nzMapping.Settings.spawnperround = data.spawnperround == nil and 0 or data.spawnperround
	nzMapping.Settings.maxspawns = data.maxspawns == nil and 35 or data.maxspawns
	nzMapping.Settings.zombiesperplayer = data.zombiesperplayer == nil and 0 or data.zombiesperplayer
	nzMapping.Settings.spawnsperplayer = data.spawnsperplayer == nil and 0 or data.spawnsperplayer
	nzMapping.Settings.spawndelay = data.spawndelay == nil and 2 or data.spawndelay
	nzMapping.Settings.speedmulti = data.speedmulti == nil and 4 or data.speedmulti
	nzMapping.Settings.startspeed = data.startspeed == nil and 0 or data.startspeed
	nzMapping.Settings.amountcap = data.amountcap == nil and 240 or data.amountcap -- change the message, my final word. good morning. :shushing_face:\
	nzMapping.Settings.healthstart = data.healthstart == nil and 75 or data.healthstart
	nzMapping.Settings.healthinc = data.healthinc == nil and 50 or data.healthinc
	nzMapping.Settings.healthmod = data.healthmod == nil and 0.1 or data.healthmod
	nzMapping.Settings.healthcap = data.healthcap == nil and 60000 or data.healthcap
	nzMapping.Settings.speedcap = data.speedcap == nil and 300 or data.speedcap
	nzMapping.Settings.lastzombiesprint = data.lastzombiesprint == nil and 3 or data.lastzombiesprint

	nzMapping.Settings.sidestepping = data.sidestepping or false
	nzMapping.Settings.badattacks = data.badattacks or false
	nzMapping.Settings.dmgincrease = data.dmgincrease or false
	nzMapping.Settings.stumbling = data.stumbling == nil and true or data.stumbling
	nzMapping.Settings.supertaunting = data.supertaunting == nil and false or data.supertaunting

	NZZombiesMaxAllowed = nzMapping.Settings.startingspawns

	-- Map Color Options --
	nzMapping.Settings.zombieeyecolor = data.zombieeyecolor == nil and Color(0, 255, 255, 255) or Color(data.zombieeyecolor.r, data.zombieeyecolor.g, data.zombieeyecolor.b)
	nzMapping.Settings.zombieeyecolor2 = data.zombieeyecolor2 == nil and Color(255, 0, 0, 255) or Color(data.zombieeyecolor2.r, data.zombieeyecolor2.g, data.zombieeyecolor2.b)
	nzMapping.Settings.boxlightcolor = data.boxlightcolor == nil and Color(0, 150,200,255) or Color(data.boxlightcolor.r, data.boxlightcolor.g, data.boxlightcolor.b) 
	nzMapping.Settings.textcolor = data.textcolor == nil and Color(255, 255, 255, 255) or Color(data.textcolor.r, data.textcolor.g, data.textcolor.b) 
	nzMapping.Settings.paplightcolor = data.paplightcolor == nil and Color(156, 81, 182, 255) or Color(data.paplightcolor.r, data.paplightcolor.g, data.paplightcolor.b)
	if data.powerupcol then
		for k, v in pairs(data.powerupcol) do
			if (!nzPowerUps.DefaultPowerUpColors[k]) then
				data.powerupcol[k] = nil
			end
		end

		for k, v in pairs(nzPowerUps.DefaultPowerUpColors) do
			if (!data.powerupcol[k]) then
				data.powerupcol[k] = v
			end
		end

		nzMapping.Settings.powerupcol = data.powerupcol
	else
		nzMapping.Settings.powerupcol = nzPowerUps.DefaultPowerUpColors
	end

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
	nzMapping.Settings.zombieeyechange = tobool(data.zombieeyechange)
	nzMapping.Settings.zombieeyeround = data.zombieeyeround or 25
	nzMapping.Settings.zombieeyetime = data.zombieeyetime or 30

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

	nzPerks:ResetMaxPlayerPerks()
	nzPerks:UpdatePerkMachines()

	GetConVar("nz_downtime"):SetFloat(nzMapping.Settings.downtime or 45)
	GetConVar("nz_revivetime"):SetFloat(nzMapping.Settings.revivetime or 4)
	RunConsoleCommand("sv_gravity", tostring(nzMapping.Settings.gravity or 600))
	RunConsoleCommand("sk_suitcharger_citadel_maxarmor", tostring(nzMapping.Settings.armor or 200))
	RunConsoleCommand("r_flashlightfov", tostring(nzMapping.Settings.flashlightfov or 45))
	RunConsoleCommand("r_flashlightfar", tostring(nzMapping.Settings.flashlightfar or 750))
end

//thats right, were gonna fucking cheat
hook.Add("PostConfigLoad", "nzSneakyMapSettings", function()
	local data = nzMapping.Settings
	nzMapping:LoadMapSettings(data)
end)