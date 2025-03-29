nzTools:CreateTool("settings", {
	displayname = "Map Settings",
	desc = "Use the Tool Interface and press Submit to save changes",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
	end,
	Reload = function(wep, ply, tr, data)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Map Settings",
	desc = "Use the Tool Interface and press Submit to save changes",
	icon = "icon16/cog.png",
	weight = 25,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, tooldata)
		local data = table.Copy(nzMapping.Settings)
		local valz = {}
		valz["Row1"] = data.startwep or "Select ..."
		valz["Knife"] = data.knife or "Select ..."
		valz["Grenade"] = data.grenade or "Select ..."
		valz["Bottle"] = data.bottle or "Select ..."
		valz["Revive Syrette"] = data.syrette or "Select ..."
		valz["PaP Arms"] = data.paparms or "Select ..."
		valz["Death Machine"] = data.deathmachine or "Select ..."
		valz["Shield"] = data.shield or "Select ..."
		valz["Row2"] = data.startpoints or 500
		valz["Row3"] = data.eeurl or ""
		valz["Row4"] = data.script or false
		valz["Row5"] = data.scriptinfo or ""
		valz["Row6"] = data.gamemodeentities or false
		valz["Row7"] = data.specialroundtype or "Hellhounds"
		valz["Row8"] = data.bosstype or "None"
		valz["Row9"] = data.startingspawns == nil and 35 or data.startingspawns
		valz["Row10"] = data.spawnperround == nil and 0 or data.spawnperround
		valz["Row11"] = data.maxspawns == nil and 35 or data.maxspawns
		valz["Row13"] = data.zombiesperplayer == nil and 0 or data.zombiesperplayer
		valz["Row14"] = data.spawnsperplayer == nil and 0 or data.spawnsperplayer
		valz["SpawnDelay"] = data.spawndelay == nil and 2 or data.spawndelay
		valz["Row15"] = data.zombietype or "Kino der Toten"
		valz["Row16"] = data.hudtype or "Black Ops 1"
		valz["Row18"] = data.perkmachinetype or "Classic"
		valz["Row19"] = data.boxtype or "Original"
		valz["Row33"] = data.mainfont or "Black Ops 1"
		valz["Row34"] = data.smallfont or "Black Ops 1"
		valz["Row35"] = data.mediumfont or "Black Ops 1"
		valz["Row36"] = data.roundfont or "Black Ops 1"
		valz["Row37"] = data.ammofont or "Black Ops 1"
		valz["Row38"] = data.ammo2font or "Black Ops 1"
		valz["Row40"] = data.fontthicc or 2
		valz["Row41"] = data.icontype or "World at War/ Black Ops 1"
		valz["Row42"] = data.perkupgrades or false
		valz["Row43"] = data.PAPtype or "Original"
		valz["Row44"] = data.PAPcamo or "nz_classic"
		valz["Row45"] = data.hp or 150
		valz["Row46"] = data.range or 2000
		valz["Row48"] = data.eemdl or "Hula Doll"
		valz["Row49"] = data.speedmulti or 4
		valz["Row50"] = data.amountcap or 240
		valz["HealthStart"] = data.healthstart or 75
		valz["HealthIncrement"] = data.healthinc or 50
		valz["HealthMultiplier"] = data.healthmult or 0.1
		valz["HealthCap"] = data.healthcap or 60000
		valz["Row51"] = data.navgroupbased or false
		valz["Row52"] = data.sidestepping or false
		valz["ZStumbling"] = data.stumbling == nil and true or data.stumbling
		valz["ZSTaunts"] = data.supertaunting == nil and false or data.supertaunting
		valz["Row54"] = data.badattacks or false
		valz["DmgIncrease"] = data.dmgincrease or false
		valz["ZStartSpeed"] = data.startspeed or 0
		valz["ZSpeedCap"] = data.speedcap or 300
		valz["Row56"] = data.zct or false
		valz["Row57"] = data.mutated or false
		valz["Row58"] = data.aats or 2
		valz["Row59"] = data.poweruptype or "Black Ops 1"
		valz["Row60"] = data.mmohudtype or "World at War/ Black Ops 1"
		valz["Row61"] = data.downsoundtype or "Black Ops 3"
		valz["Row62"] = data.solorevive or 3
		valz["Row63"] = data.modifierslot == nil and true or data.modifierslot
		//valz["Row64"] = data.dontkeepperks or false
		valz["Row65"] = data.powerupstyle or "style_classic"
		valz["Row66"] = data.antipowerups or false
		valz["Row67"] = data.antipowerupchance or 40
		valz["Row68"] = data.antipowerupstart or 2
		valz["Row69"] = data.antipowerupdelay or 4
		valz["Row70"] = data.powerupoutline or 0
		valz["Row71"] = data.roundperkbonus == nil and true or data.roundperkbonus
		valz["Row72"] = data.healthregendelay or 5
		valz["Row73"] = data.healthregenratio or 0.1
		valz["Row74"] = data.healthregenrate or 0.05
		valz["Row75"] = data.revivetime or 4
		valz["Row76"] = data.playerperkmax or 4
		valz["Row77"] = data.downtime or 45
		valz["Row78"] = data.cwfizz or false
		valz["Row79"] = data.cwfizzprice or 1000
		valz["Row80"] = data.cwfizzperkslot or false
		valz["Row81"] = data.cwfizzslotprice or 10000
		valz["Row82"] = data.cwfizzslotround or 20
		valz["Row83"] = data.slidecooldown or 0.4
		valz["Row84"] = data.slidejump or false
		valz["Row85"] = data.cwfizzround or 15
		valz["Row86"] = data.slideduration or 0.6
		valz["Row87"] = data.slidespeed or 1.3
		//valz["Row88"] = data.slidestamina == nil and true or data.slidestamina
		valz["Row89"] = data.stamina or 100
		valz["Row90"] = data.staminaregenamount or 4.5
		valz["Row91"] = data.staminaregendelay or 0.5
		valz["Row93"] = data.tacticalupgrades or false
		valz["Row94"] = data.tacticalkillcount or 40
		valz["Row95"] = data.maxperkslots or 8
		valz["Row96"] = data.minboxhit or 3
		valz["Row97"] = data.maxboxhit or 13
		valz["Row98"] = data.boxstartuses or 8
		valz["Row99"] = data.poweruproundbased or false
		valz["Row100"] = data.minfizzuses or 4
		valz["Row101"] = data.maxfizzuses or 7
		valz["Row102"] = data.maxpowerupdrops or 4
		valz["Row103"] = data.maxteddypercent or 50
		valz["Row104"] = data.blurpoweron or false
		valz["Row105"] = data.maponlyrandomperks or false
		valz["Row106"] = data.typewriterintro or false
		valz["Row107"] = data.typewritertext or "Berlin, Germany;Wittenau Sanatorium;September, 1945"
		valz["Row108"] = data.typewriterdelay or 0.125
		valz["Row109"] = data.typewriterlinedelay or 1.5
		valz["Row110"] = data.typewriteroffset or 435
		valz["Row111"] = data.divingallowweapon or false
		valz["Row112"] = data.divingomnidirection or false
		valz["Row113"] = data.roundwaittime or 15
		valz["Row114"] = data.firstroundwaittime or 1
		valz["Row115"] = data.specialroundwaittime or 15
		valz["Row116"] = data.specialroundmin or 5
		valz["Row117"] = data.specialroundmax or 7
		valz["Row118"] = data.forcefirstspecialround or false
		valz["Row119"] = data.firstspecialround or 5
		valz["Row120"] = data.slotrewardround or 15
		valz["Row121"] = data.slotrewardinterval or 10
		valz["Row122"] = data.slotrewardcount or 2
		valz["Row123"] = data.juggbonus or 100
		valz["Row124"] = data.armor or 200
		valz["Row125"] = data.startarmor or 0
		valz["Row126"] = data.specialsuseplayers or false
		valz["Row127"] = data.gameovertime or 15
		valz["Row128"] = data.gocamerawait or 5
		valz["Row129"] = data.divingspeed or 1
		valz["Row130"] = data.divingheight or 200
		valz["Row131"] = data.divingwait or 0.2
		valz["Row132"] = data.downsystem or 0
		valz["Row133"] = data.perkstokeep or 3

		valz["Row134"] = data.skyintro or false
		valz["Row135"] = data.skyintrotime or 1.4
		valz["Row136"] = data.skyintroheight or 6000

		valz["PaPBeam"] = data.papbeam or false
		valz["RandomPaP"] = data.randompap or false
		valz["RandomPaPRound"] = data.randompapinterval or 2
		valz["RandomPaPTime"] = data.randompaptime or 0

		valz["NukedPerks"] = data.nukedperks or false
		valz["NukedFizz"] = data.nukedfizz == nil and true or data.nukedfizz
		valz["NukedPaP"] = data.nukedpap == nil and true or data.nukedpap
		valz["NukedRandom"] = data.nukedrandom == nil and true or data.nukedrandom
		valz["NukedRandomMin"] = data.nukedroundmin or 3
		valz["NukedRandomMax"] = data.nukedroundmax or 5

		valz["GameOverText"] = data.gameovertext or "Game Over"
		valz["GameOverSubText"] = data.survivedtext or "You Survived % Rounds"
		valz["GameWinText"] = data.gamewintext or "Game Over"
		valz["GameWinSubText"] = data.escapedtext or "You Escaped after % Rounds"

		valz["GameBeginText"] = data.gamebegintext or "Round"
		valz["RBoxPrice"] = data.rboxprice or 950
		valz["Colorless"] = data.monochrome or false
		valz["Movement"] = data.movement or 0
		valz["Gravity"] = data.gravity or 600
		valz["Flashlight"] = data.flashlight == nil and true or data.flashlight
		valz["FlashlightFOV"] = data.flashlightfov or 60
		valz["FlashlightFar"] = data.flashlightfar or 750
		valz["TurnedNames"] = data.turnedlist or {}
		valz["RBoxWeps"] = data.RBoxWeps or {}
		valz["GumRoundPrices"] = data.gumpricelist or nzGum.RoundPrices
		valz["GumChanceMults"] = data.gummultipliers or nzGum.ChanceMultiplier
		valz["GumResetRounds"] = data.gumcountresetrounds or nzGum.RollCountResetRounds
		valz["GumMaxUses"] = data.maxplayergumuses or 3
		valz["GumStartPrice"] = data.gumstartprice or 0
		valz["GumShowStats"] = data.showgumstats == nil and true or data.showgumstats
		valz["ColdWarPoints"] = data.cwpointssystem or false
		valz["JumpPower"] = data.jumppower or 200

		valz["TimedGameplay"] = data.timedgame or false
		valz["TimedGameplayTime"] = data.timedgametime or 120
		valz["TimedGameplayMaxTime"] = data.timedgamemaxtime or 600
		valz["TimedGameplayRoundWait"] = data.timedgameroundwaittime or 0.5

		-- Catalyst/ZCT/Burning --
		valz["EnableBurningZombies"] = data.burning or false
		valz["BurningChance"] = data.burningchance or 50
		valz["BurningRnd"] = data.burningrnd or 13

		valz["RedChance"] = data.redchance or 85
		valz["RedRnd"] = data.redrnd or 2

		valz["BlueChance"] = data.bluechance or 85
		valz["BlueRnd"] = data.bluernd or 6

		valz["GreenChance"] = data.greenchance or 85
		valz["GreenRnd"] = data.greenrnd or 14

		valz["YellowChance"] = data.yellowchance or 85
		valz["YellowRnd"] = data.yellowrnd or 12

		valz["PurpleChance"] = data.purplechance or 85
		valz["PurpleRnd"] = data.purplernd or 16

		valz["PinkChance"] = data.pinkchance or 85
		valz["PinkRnd"] = data.pinkrnd or 26

		valz["PoisonChance"] = data.poisonchance or 20
		valz["PoisonRnd"] = data.poisonrnd or 10

		valz["FireChance"] = data.firechance or 15
		valz["FireRnd"] = data.firernd or 14

		valz["ElectricChance"] = data.electricchance or 10
		valz["ElectricRnd"] = data.electricrnd or 16

		valz["WaterChance"] = data.waterchance or 5
		valz["WaterRnd"] = data.waterrnd or 12

		--[[
		valz["ACRow1"] = data.ac == nil and false or data.ac
		valz["ACRow2"] = data.acwarn == nil and true or data.acwarn
		valz["ACRow3"] = data.acsavespot == nil and true or tobool(data.acsavespot)
		valz["ACRow4"] = data.actptime == nil and 5 or data.actptime
		valz["ACRow5"] = data.acpreventboost == nil and true or tobool(data.acpreventboost)
		valz["ACRow6"] = data.acpreventcjump == nil and false or tobool(data.acpreventcjump)
		]]

		local WeaponList = weapons.GetList()

		if (ispanel(sndFilePanel)) then
			sndFilePanel:Remove()
		end

		local wunderfizzlist = {}
		for k,v in pairs(nzPerks:GetList()) do
			if k != "wunderfizz" and k != "pap" then
				wunderfizzlist[k] = {true, v}
			end
		end
		valz["Wunderfizz"] = data.wunderfizzperklist == nil and wunderfizzlist or data.wunderfizzperklist

		local poweruplist = {}
		for k,v in pairs(nzPowerUps:GetList()) do
			poweruplist[k] = {true, v}
		end
		valz["PowerUps"] = data.poweruplist or poweruplist

		local vulturelist = {}
		for k, v in pairs(nzPerks:GetVultureList()) do
			vulturelist[k] = {true, v}
		end
		valz["VultureDrops"] = data.vulturelist or vulturelist

		local gumlist = {}
		for k, v in pairs(nzGum.Gums) do
			gumlist[k] = {true, nzGum.RollCounts[v.rare or nzGum.RareTypes.DEFAULT]}
		end
		valz["GumsList"] = data.gumlist or gumlist

		local poweruprounds = {}
		for k, v in pairs(nzPowerUps.Data) do
			poweruprounds[k] = v.rare and (v.chance > 0 and 10 or 20) or 0
		end
		valz["PowerUpRounds"] = data.poweruprounds or poweruprounds

		for k, v in pairs(nzSounds.struct) do
			valz["SndRow" .. k] = data[v] or {}
		end

		local sheet = vgui.Create( "DPropertySheet", frame )
		sheet:SetSize( 495, 430 )
		sheet:SetPos( 5, 5 )

		--[[-------------------------------------------------------------------------
		Map Visuals
		---------------------------------------------------------------------------]]
		local function AddCosmeticStuff()
			local DProperties1 = vgui.Create( "DProperties", sheet )
			DProperties1:SetSize( 280, 220 )
			DProperties1:SetPos( 0, 0 )
			sheet:AddSheet("Cosmetic Settings", DProperties1, "icon16/palette.png", false, false, "Change player settings")

			local Row16 = 			DProperties1:CreateRow("HUD Settings", "HUD")
			local Row41 = 			DProperties1:CreateRow("HUD Settings", "Perk Icons")
			local Row59 = 			DProperties1:CreateRow("HUD Settings", "Power-Up Icons")
			local Row60 = 			DProperties1:CreateRow("HUD Settings", "Perk Stats Icons")

			local Row18 = 			DProperties1:CreateRow("Model Settings", "Perk Machines")
			local Row19 = 			DProperties1:CreateRow("Model Settings", "Mystery Box")
			local Row43 = 			DProperties1:CreateRow("Model Settings", "Pack-A-Punch")
			local bottlerow = 		DProperties1:CreateRow("Model Settings", "Perk Bottle")
			local syretterow = 		DProperties1:CreateRow("Model Settings", "Revive Syrette")
			local paparmsrow = 		DProperties1:CreateRow("Model Settings", "Pack-A-Punch Hands")

			local Row44 = 			DProperties1:CreateRow("Cosmetic Settings", "Pack-A-Punch Camo")
			local Row61 = 			DProperties1:CreateRow("Cosmetic Settings", "Downed Ambience")
			local powerupstylerow = DProperties1:CreateRow("Cosmetic Settings", "Power-Up Effect Style")
			local Row70 =			DProperties1:CreateRow("Cosmetic Settings", "Power-Up Outlines")
			local Colorlessrow =	DProperties1:CreateRow("Cosmetic Settings", "Monochrome Vision Until Power On")
			local Row104 =			DProperties1:CreateRow("Cosmetic Settings", "Blur Vision on Power On")

			local Row134 =			DProperties1:CreateRow("Cosmetic Settings", "Modern Warfare 3 Survival Intro")
			local Row135 =			DProperties1:CreateRow("Cosmetic Settings", "Survival Intro Time")
			local Row136 =			DProperties1:CreateRow("Cosmetic Settings", "Survival Intro Vertical Offset")

			local GameBeginText =	DProperties1:CreateRow("Text Settings", "Game Begin Text")
			local GameOverText =	DProperties1:CreateRow("Text Settings", "Game Over Text")
			local GameOverSubText =	DProperties1:CreateRow("Text Settings", "Game Over Sub Text")
			local GameWinText =		DProperties1:CreateRow("Text Settings", "Game Win Text")
			local GameWinSubText =	DProperties1:CreateRow("Text Settings", "Game Win Sub Text")

			local Row106 = 			DProperties1:CreateRow("Typewriter Settings", "Enable Intro Script") //YaPh1l Typewriter Intro
			local Row107 = 			DProperties1:CreateRow("Typewriter Settings", "Typewriter Script")
			local Row110 = 			DProperties1:CreateRow("Typewriter Settings", "Typewriter Script Offset")
			local Row108 = 			DProperties1:CreateRow("Typewriter Settings", "Typewriter Letter Delay")
			local Row109 = 			DProperties1:CreateRow("Typewriter Settings", "Typewriter Line Delay")

			local Row33 = 			DProperties1:CreateRow("Font Settings", "Main Menu Font")
			local Row34 = 			DProperties1:CreateRow("Font Settings", "Gun Name and Interact Font")
			local Row35 = 			DProperties1:CreateRow("Font Settings", "Point Display Font")
			local Row36 = 			DProperties1:CreateRow("Font Settings", "Round Font")
			local Row37 = 			DProperties1:CreateRow("Font Settings", "Ammo Font")
			local Row38 = 			DProperties1:CreateRow("Font Settings", "Ammo 2 Font")
			local Row40 = 			DProperties1:CreateRow("Font Settings", "Font Thickness")

			Row33:Setup( "Combo" )
			for k, v in pairs(nzRound.FontSelection) do
				Row33:AddChoice(k, k, k == valz["Row33"])
			end
			Row33.DataChanged = function( _, val ) valz["Row33"] = val end
			Row33:SetTooltip("Changes the font of the main font")

			Row34:Setup("Combo")
			for k, v in pairs(nzRound.FontSelection) do
				Row34:AddChoice(k, k, k == valz["Row34"])
			end
			Row34.DataChanged = function( _, val ) valz["Row34"] = val end
			Row34:SetTooltip("Changes the font of the name of your gun and interactibles")

			Row35:Setup( "Combo" )
			for k, v in pairs(nzRound.FontSelection) do
				Row35:AddChoice(k, k, k == valz["Row35"])
			end
			Row35.DataChanged = function( _, val ) valz["Row35"] = val end
			Row35:SetTooltip("Changes the font of the point displays")

			Row36:Setup( "Combo" )
			for k, v in pairs(nzRound.FontSelection) do
				Row36:AddChoice(k, k, k == valz["Row36"])
			end
			Row36.DataChanged = function( _, val ) valz["Row36"] = val end
			Row36:SetTooltip("Changes the font of the round")

			Row37:Setup( "Combo" )
			for k, v in pairs(nzRound.FontSelection) do
				Row37:AddChoice(k, k, k == valz["Row37"])
			end
			Row37.DataChanged = function( _, val ) valz["Row37"] = val end
			Row37:SetTooltip("Changes the font of points gained")

			Row38:Setup( "Combo" )
			for k, v in pairs(nzRound.FontSelection) do
				Row38:AddChoice(k, k, k == valz["Row38"])
			end
			Row38.DataChanged = function( _, val ) valz["Row38"] = val end
			Row38:SetTooltip("Changes the font of points gained")

			Row40:Setup("Generic")
			Row40:SetValue( valz["Row40"] )
			Row40.DataChanged = function( _, val ) valz["Row40"] = tonumber(val) end	

			Row16:Setup( "Combo" )
			for k, v in pairs(nzRound.HudSelectData) do
				Row16:AddChoice(k, k, k == valz["Row16"])
			end
			Row16.DataChanged = function( _, val ) valz["Row16"] = val end
			Row16:SetTooltip("Sets the HUD players will see in your map")

			Row41:Setup( "Combo" )
			for k, v in pairs(nzPerks.IconSets) do
				Row41:AddChoice(k, k, k == valz["Row41"])
			end
			Row41.DataChanged = function( _, val ) valz["Row41"] = val end
			Row41:SetTooltip("Changes the style of the perk icons")

			Row59:Setup( "Combo" )
			for k, v in pairs(nzDisplay.PowerupHudData) do
				Row59:AddChoice(k, k, k == valz["Row59"])
			end
			Row59.DataChanged = function( _, val ) valz["Row59"] = val end
			Row59:SetTooltip("Changes the style of powerup icons")

			Row60:Setup( "Combo" )
			for k, v in pairs(nzPerks.IconSets) do
				Row60:AddChoice(k, k, k == valz["Row60"])
			end
			Row60.DataChanged = function( _, val ) valz["Row60"] = val end
			Row60:SetTooltip("Changes the style of the mini perk icons that display active perk stats")

			Row18:Setup( "Combo" )
			for k, v in pairs(nzRound.PerkSelectData) do
				Row18:AddChoice(k, k, k == valz["Row18"])
			end
			Row18.DataChanged = function( _, val ) valz["Row18"] = val end
			Row18:SetTooltip("Sets the Perk Machines Appearance")

			Row19:Setup( "Combo" )
			for k, v in pairs(nzRound.BoxSkinData) do
				Row19:AddChoice(k, k, k == valz["Row19"])
			end
			Row19.DataChanged = function( _, val ) valz["Row19"] = val end
			Row19:SetTooltip("Sets the Mystery Box skin")
			
			Row43:Setup( "Combo" )
			for k,v in pairs(nzRound.PAPSelectData) do
				Row43:AddChoice(k, k, k == valz["Row43"])
			end
			Row43.DataChanged = function( _, val ) valz["Row43"] = val end
			Row43:SetTooltip("Sets the Pack-A-Punch skin")
			
			Row44:Setup( "Combo" )
			for k, v in pairs(nzCamos.Data) do
				Row44:AddChoice(nzCamos:Get(k).name, k, k == valz["Row44"])
			end
			Row44.DataChanged = function( _, val ) valz["Row44"] = val end
			Row44:SetTooltip("Sets the global Pack-A-Punch camo")
			
			paparmsrow:Setup( "Combo" )
			for k,v in pairs(WeaponList) do
				if v.Category and v.Category == "nZombies Knuckles" then
					paparmsrow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["PaP Arms"] == v.ClassName)
				end
			end
			paparmsrow.DataChanged = function( _, val ) valz["PaP Arms"] = val valz["PaP Arms"] = val end

			bottlerow:Setup( "Combo" )
			for k,v in pairs(WeaponList) do
				if v.Category and v.Category == "nZombies Bottles" then
					bottlerow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Bottle"] == v.ClassName)
				end
			end
			bottlerow.DataChanged = function( _, val ) valz["Bottle"] = val valz["Bottle"] = val end

			syretterow:Setup( "Combo" )
			for k,v in pairs(WeaponList) do
				if v.Category and v.Category == "nZombies Syrettes" then
					syretterow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Revive Syrette"] == v.ClassName)
				end
			end
			syretterow.DataChanged = function( _, val ) valz["Revive Syrette"] = val valz["Revive Syrette"] = val end

			Row61:Setup( "Combo" )
			for k, v in pairs(nzDisplay.HUDdowndata) do
				Row61:AddChoice(k, k, k == valz["Row61"])
			end
			Row61.DataChanged = function( _, val ) valz["Row61"] = val end
			Row61:SetTooltip("Changes downed sound, downed ambience, and revived sound")

			powerupstylerow:Setup("Combo")
			for k,v in pairs(nzPowerUps.Styles) do
				powerupstylerow:AddChoice(v.name, k, k == valz["Row65"])
			end
			powerupstylerow.DataChanged = function( _, val ) valz["Row65"] = val valz["Row65"] = val end

			Row70:Setup("Combo")
			Row70:AddChoice('Disabled', 0, valz["Row70"] == 0)
			Row70:AddChoice('Enabled', 1, valz["Row70"] == 1)
			Row70:AddChoice('Ignore Z', 2, valz["Row70"] == 2)
			Row70.DataChanged = function( _, val ) valz["Row70"] = val end
			Row70:SetTooltip("More of an accessibility option, enables a glowing halo around Power-Ups, ignorez makes the outline show through walls.")

			Colorlessrow:Setup("Boolean")
			Colorlessrow:SetValue(valz["Colorless"])
			Colorlessrow.DataChanged = function( _, val) valz["Colorless"] = tobool(val) end
			Colorlessrow:SetTooltip("Enable for players vision to be monochrome until the power is turned on.")

			Row104:Setup("Boolean")
			Row104:SetValue(valz["Row104"])
			Row104.DataChanged = function( _, val) valz["Row104"] = tobool(val) end
			Row104:SetTooltip("Enable for players vision to blur when power is turned on (or at gamestart when no power switch is present).")

			Row134:Setup("Boolean")
			Row134:SetValue(valz["Row134"])
			Row134.DataChanged = function( _, val) valz["Row134"] = tobool(val) end
			Row134:SetTooltip("Enable MW3-esque spawn animation (disabled if infil animation is enabled).")

			Row135:Setup("Generic")
			Row135:SetValue(valz["Row135"])
			Row135.DataChanged = function( _, val ) valz["Row135"] = tonumber(val) end
			Row135:SetTooltip("Time it takes for spawning animation to play out, in seconds. (Default 1.4)")

			Row136:Setup("Generic")
			Row136:SetValue(valz["Row136"])
			Row136.DataChanged = function( _, val ) valz["Row136"] = tonumber(val) end
			Row136:SetTooltip("Vertical offset from player spawns when animation starts, in hammer units. (Default 6000)")

			GameBeginText:Setup("Generic")
			GameBeginText:SetValue(valz["GameBeginText"])
			GameBeginText:SetTooltip("Only applies to the World at War and Black Ops 1/Black Ops 2 styled HUDs (Default 'Round')")
			GameBeginText.DataChanged = function( _, val ) valz["GameBeginText"] = tostring(val) end

			GameOverText:Setup("Generic")
			GameOverText:SetValue(valz["GameOverText"])
			GameOverText:SetTooltip("The text that says 'Game Over'")
			GameOverText.DataChanged = function( _, val ) valz["GameOverText"] = tostring(val) end

			GameOverSubText:Setup("Generic")
			GameOverSubText:SetValue(valz["GameOverSubText"])
			GameOverSubText:SetTooltip("THE % IS WHERE THE ROUND NUMBER GETS PUT!!! 'You Survived % Rounds'")
			GameOverSubText.DataChanged = function( _, val ) valz["GameOverSubText"] = tostring(val) end
		
			GameWinText:Setup("Generic")
			GameWinText:SetValue(valz["GameWinText"])
			GameWinText:SetTooltip("The text that says 'Game Over'")
			GameWinText.DataChanged = function( _, val ) valz["GameWinText"] = tostring(val) end

			GameWinSubText:Setup("Generic")
			GameWinSubText:SetValue(valz["GameWinSubText"])
			GameWinSubText:SetTooltip("THE % IS WHERE THE ROUND NUMBER GETS PUT!!! 'You Escaped after % Rounds'")
			GameWinSubText.DataChanged = function( _, val ) valz["GameWinSubText"] = tostring(val) end
		
			Row106:Setup("Boolean")
			Row106:SetValue(valz["Row106"])
			Row106.DataChanged = function( _, val) valz["Row106"] = tobool(val) end
			Row106:SetTooltip("Enable for world at war mission intro type writer opening.")

			Row107:Setup("Generic")
			Row107:SetValue(valz["Row107"])
			Row107.DataChanged = function( _, val ) valz["Row107"] = tostring(val) end
			Row107:SetTooltip("Seperate lines with a semicolon")

			Row108:Setup("Generic")
			Row108:SetValue(valz["Row108"])
			Row108.DataChanged = function( _, val ) valz["Row108"] = tonumber(val) end
			Row108:SetTooltip("Time between each character printed. (Default 0.125)")

			Row109:Setup("Generic")
			Row109:SetValue(valz["Row109"])
			Row109.DataChanged = function( _, val ) valz["Row109"] = tonumber(val) end
			Row109:SetTooltip("Time between each new line printed. (Default 1.5)")

			Row110:Setup("Generic")
			Row110:SetValue(valz["Row110"])
			Row110.DataChanged = function( _, val ) valz["Row110"] = tonumber(val) end
			Row110:SetTooltip("Vertical offset of the first line from bottom of screen. (Default 420, looks good with 3 lines or less)")
		end
		AddCosmeticStuff()
		--[[-------------------------------------------------------------------------
		Map Visuals
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Map Functionality
		---------------------------------------------------------------------------]]
		local DProperties = vgui.Create( "DProperties", sheet )
		DProperties:SetSize(280, 220)
		DProperties:SetPos( 0, 0 )
		sheet:AddSheet("Gameplay Settings", DProperties, "icon16/cog.png", false, false, "Set a list of general settings. The Easter Egg Song URL needs to be from Soundcloud.")

		local Shmoovment =		DProperties:CreateRow("Map Functionality", "Movement System")
		local Row132 = 			DProperties:CreateRow("Map Functionality", "Perk Loss On Down System")
		local Row58 = 			DProperties:CreateRow("Map Functionality", "Alternate Ammo Type System")
		local deathmachinerow = DProperties:CreateRow("Map Functionality", "Death Machine")
		local shieldrow = 		DProperties:CreateRow("Map Functionality", "Shield")
		local Row62 = 			DProperties:CreateRow("Map Functionality", "Solo Revives Count")
		local Row123 = 			DProperties:CreateRow("Map Functionality", "Juggernog Health Bonus")
		local Row42 = 			DProperties:CreateRow("Map Functionality", "Perk Upgrades")
		local Row63 = 			DProperties:CreateRow("Map Functionality", "Perk Modifier Slot")
		//local Row64 = 			DProperties:CreateRow("Map Functionality", "Lose All Perks on Down")
		local CWPoints = 		DProperties:CreateRow("Map Functionality", "Cold War Points System")
		local Row93 = 			DProperties:CreateRow("Map Functionality", "Special Grenade Upgrading")
		local Row94 = 			DProperties:CreateRow("Map Functionality", "Special Grenade Kill Requirement")
		local Row105 = 			DProperties:CreateRow("Map Functionality", "Map Only Random Perk Rewards")
		local Row126 = 			DProperties:CreateRow("Map Functionality", "Random Teleports Use Player Spawns")
		local Row127 = 			DProperties:CreateRow("Map Functionality", "Game Over Duration")
		local Row128 = 			DProperties:CreateRow("Map Functionality", "Game Over Camera Delay")
		local Row133 = 			DProperties:CreateRow("Map Functionality", "Bleedout Perk Count")
		local gravityrow = 		DProperties:CreateRow("Map Functionality", "Gravity")

		Shmoovment:Setup("Combo")
		Shmoovment:AddChoice("None", 0, valz["Movement"] == 0)
		Shmoovment:AddChoice("Sliding", 1, valz["Movement"] == 1)
		Shmoovment:AddChoice("Diving", 2, valz["Movement"] == 2)
		Shmoovment:AddChoice("Sliding + Diving", 3, valz["Movement"] == 3)
		Shmoovment.DataChanged = function( _, val ) valz["Movement"] = val end
		Shmoovment:SetTooltip("Enable additional movement abiltities for the config.")

		Row132:Setup("Combo")
		Row132:AddChoice("Lose all your perks", 0, valz["Row132"] == 0)
		Row132:AddChoice("Keep half your perks", 1, valz["Row132"] == 1)
		Row132:AddChoice("Bleedout half your perks", 3, valz["Row132"] == 3)
		Row132:AddChoice("Bleedout all your perks", 4, valz["Row132"] == 4)
		Row132:AddChoice("Bleedout a set amount of perks", 2, valz["Row132"] == 2)
		Row132.DataChanged = function( _, val ) valz["Row132"] = val end
		Row132:SetTooltip("Sets the functionality for how perks are lost when going down.")

		Row133:Setup("Generic")
		Row133:SetValue(valz["Row133"])
		Row133.DataChanged = function( _, val ) valz["Row133"] = tonumber(val) end
		Row133:SetTooltip("How many perks the player gets to keep when going down and using perk bleedout. (Default 3)")

		Row58:Setup("Combo")
		Row58:AddChoice("Disabled", 0, valz["Row58"] == 0)
		Row58:AddChoice("Only when no SWEP:OnRePaP()", 1, valz["Row58"] == 1)
		Row58:AddChoice("Always on (Default)", 2, valz["Row58"] == 2)
		Row58.DataChanged = function( _, val ) valz["Row58"] = val valz["Row58"] = val end
		Row58:SetTooltip("Enable for weapons to gain BO3-esque ammo mods when Pack-a-Punch'ed twice.")

		deathmachinerow:Setup( "Combo" )
		for k, v in pairs(WeaponList) do
			if v.Category and v.Category == "nZombies Powerups" then
				deathmachinerow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Death Machine"] == v.ClassName)
			end
		end
		deathmachinerow.DataChanged = function( _, val ) valz["Death Machine"] = val end

		shieldrow:Setup( "Combo" )
		for k, v in pairs(WeaponList) do
			if v.ShieldEnabled and v.NZSpecialCategory == "shield" then
				shieldrow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Shield"] == v.ClassName)
			end
		end
		shieldrow.DataChanged = function( _, val ) valz["Shield"] = val end
		shieldrow:SetTooltip("Sets a shield to be given to the player through means such as, Victorious Tortoise's upgrade ability, the 'Shield Up' Gobblegum, and potentially other addons.")

		Row62:Setup("Generic")
		Row62:SetValue(valz["Row62"])
		Row62:SetTooltip("How many solo revives the player gets in singleplayer. (SET TO 0 TO DISABLE)")
		Row62.DataChanged = function( _, val ) valz["Row62"] = tonumber(val) end

		Row42:Setup("Boolean")
		Row42:SetValue(valz["Row42"])
		Row42.DataChanged = function( _, val ) valz["Row42"] = val end
		Row42:SetTooltip("Enable for perk upgrades to be purchasable on this config.")

		Row63:Setup("Boolean")
		Row63:SetValue(valz["Row63"])
		Row63.DataChanged = function( _, val) valz["Row63"] = val end
		Row63:SetTooltip("Enable for all players fourth perk always being upgraded (Default On).")

		/*Row64:Setup("Boolean")
		Row64:SetValue(valz["Row64"])
		Row64.DataChanged = function( _, val) valz["Row64"] = val end
		Row64:SetTooltip("Enable for players to lose all perks on down, instead of only half.")*/

		CWPoints:Setup( "Boolean" )
		CWPoints:SetValue( valz["ColdWarPoints"] )
		CWPoints.DataChanged = function( _, val ) valz["ColdWarPoints"] = val end
		CWPoints:SetTooltip("Enable for CW styled points earning. (Only rewards points on kills)")

		gravityrow:Setup("Generic")
		gravityrow:SetValue(valz["Gravity"])
		gravityrow.DataChanged = function( _, val ) valz["Gravity"] = tonumber(val) end
		gravityrow:SetTooltip("Sets the gravity for the config. (Default 600)")

		Row93:Setup("Boolean")
		Row93:SetValue(valz["Row93"])
		Row93.DataChanged = function( _, val ) valz["Row93"] = tobool(val) end
		Row93:SetTooltip("Enable for special grenades that have SWEP:OnPaP() code to upgrade after a certain amount of kills with said special grenade.")

		Row94:Setup("Generic")
		Row94:SetValue(valz["Row94"])
		Row94.DataChanged = function( _, val ) valz["Row94"] = tonumber(val) end
		Row94:SetTooltip("Amount of special grenade kills required to become upgraded. (Default 40)")

		Row105:Setup("Boolean")
		Row105:SetValue(valz["Row105"])
		Row105.DataChanged = function( _, val) valz["Row105"] = tobool(val) end
		Row105:SetTooltip("Enable for (most) random perk rewards to only use perks that are physically on the map rather than the wunderfizz list.")

		Row123:Setup("Generic")
		Row123:SetValue(valz["Row123"])
		Row123.DataChanged = function( _, val ) valz["Row123"] = tonumber(val) end
		Row123:SetTooltip("How much health juggernog adds to the players max health. (Default 100)")

		Row126:Setup("Boolean")
		Row126:SetValue(valz["Row126"])
		Row126.DataChanged = function( _, val) valz["Row126"] = tobool(val) end
		Row126:SetTooltip("Enable for random teleports (Who's Who, Gersh Device, Q.E.D., Astronaut) to use player spawns instead of special spawns.")

		Row127:Setup("Generic")
		Row127:SetValue(valz["Row127"])
		Row127.DataChanged = function( _, val ) valz["Row127"] = tonumber(val) end
		Row127:SetTooltip("How long the Game Over state lasts. (Default 10 seconds)")

		Row128:Setup("Generic")
		Row128:SetValue(valz["Row128"])
		Row128.DataChanged = function( _, val ) valz["Row128"] = tonumber(val) end
		Row128:SetTooltip("Delay before the game over camera starts when all players go down, if one is setup. THIS ADDS TO THE TOTAL GAME OVER DURATION!!! (Default 5 seconds)")

		--[[-------------------------------------------------------------------------
		Perk Reward Settings
		---------------------------------------------------------------------------]]
		local Row76 = 			DProperties:CreateRow("Perk Slot Settings", "Starting Perk Slot Count")
		local Row95 = 			DProperties:CreateRow("Perk Slot Settings", "Maximum Perk Slot Count")
		local Row71 = 			DProperties:CreateRow("Perk Slot Settings", "Perk Slot Rewards")
		local Row120 =			DProperties:CreateRow("Perk Slot Settings", "Perk Slot Reward Starting Round")
		local Row121 =			DProperties:CreateRow("Perk Slot Settings", "Perk Slot Reward Round Interval")
		local Row122 =			DProperties:CreateRow("Perk Slot Settings", "Perk Slot Reward Count")

		Row76:Setup("Generic")
		Row76:SetValue(valz["Row76"])
		Row76.DataChanged = function( _, val ) valz["Row76"] = tonumber(val) end
		Row76:SetTooltip("How many perk slots the player starts with. (Default 4)")

		Row95:Setup("Generic")
		Row95:SetValue(valz["Row95"])
		Row95.DataChanged = function( _, val ) valz["Row95"] = tonumber(val) end
		Row95:SetTooltip("How many perk slots the player can obtain through any means. Perk slot count will never go above this number (Default 8)")

		Row71:Setup("Boolean")
		Row71:SetValue(valz["Row71"])
		Row71.DataChanged = function( _, val) valz["Row71"] = val end
		Row71:SetTooltip("Enable for all players to gain an additional perk slot by completing round 15 and 25 (Default On).")

		Row120:Setup("Generic")
		Row120:SetValue(valz["Row120"])
		Row120.DataChanged = function( _, val ) valz["Row120"] = tonumber(val) end
		Row120:SetTooltip("First round to reward all players a perk slot, if enabled. (Default 15)")

		Row121:Setup("Generic")
		Row121:SetValue(valz["Row121"])
		Row121.DataChanged = function( _, val ) valz["Row121"] = tonumber(val) end
		Row121:SetTooltip("Interval to reward a perk slot after the first perk slot is rewarded. (Default 10)")

		Row122:Setup("Generic")
		Row122:SetValue(valz["Row122"])
		Row122.DataChanged = function( _, val ) valz["Row122"] = tonumber(val) end
		Row122:SetTooltip("How many perk slots to reward throughout the game, THIS INCLUDES THE STARTING PERK SLOT ROUND! (Default 2)")

		--[[-------------------------------------------------------------------------
		Round Settings
		---------------------------------------------------------------------------]]
		local Row113 =			DProperties:CreateRow("Round Settings", "Round Preparation Time")
		local Row114 =			DProperties:CreateRow("Round Settings", "First Round Preparation Time")
		local Row115 =			DProperties:CreateRow("Round Settings", "Special Round Preparation Time")
		local Row116 =			DProperties:CreateRow("Round Settings", "Special Round Random Min")
		local Row117 =			DProperties:CreateRow("Round Settings", "Special Round Random Max")
		local Row118 =			DProperties:CreateRow("Round Settings", "Enable Set First Special Round")
		local Row119 =			DProperties:CreateRow("Round Settings", "First Special Round")

		Row113:Setup("Generic")
		Row113:SetValue(valz["Row113"])
		Row113.DataChanged = function( _, val ) valz["Row113"] = tonumber(val) end
		Row113:SetTooltip("Wait time between rounds, in seconds. (Default 15)")

		Row114:Setup("Generic")
		Row114:SetValue(valz["Row114"])
		Row114.DataChanged = function( _, val ) valz["Row114"] = tonumber(val) end
		Row114:SetTooltip("Wait time before first round starts, in seconds. (Default 1)")

		Row115:Setup("Generic")
		Row115:SetValue(valz["Row115"])
		Row115.DataChanged = function( _, val ) valz["Row115"] = tonumber(val) end
		Row115:SetTooltip("Wait time before a special round start after a normal round, in seconds. (Default 15)")

		Row116:Setup("Generic")
		Row116:SetValue(valz["Row116"])
		Row116.DataChanged = function( _, val ) valz["Row116"] = tonumber(val) end
		Row116:SetTooltip("Minimum amount of rounds before the next special round starts. (Default 5)")

		Row117:Setup("Generic")
		Row117:SetValue(valz["Row117"])
		Row117.DataChanged = function( _, val ) valz["Row117"] = tonumber(val) end
		Row117:SetTooltip("Maximum amount of rounds before the next special round starts. (Default 7)")

		Row118:Setup("Boolean")
		Row118:SetValue(valz["Row118"])
		Row118.DataChanged = function( _, val ) valz["Row118"] = tobool(val) end
		Row118:SetTooltip("Enable for the first special round of the game to always happen on a certain round.")

		Row119:Setup("Generic")
		Row119:SetValue(valz["Row119"])
		Row119.DataChanged = function( _, val ) valz["Row119"] = tonumber(val) end
		Row119:SetTooltip("First special round. (Default 5)")

		--[[-------------------------------------------------------------------------
		Nuked Settings
		---------------------------------------------------------------------------]]
		local nukedperkrow = 	DProperties:CreateRow("Nuketown Perk Settings", "Enable Nuketown Falling Perks")
		local nukedrandomrow =	DProperties:CreateRow("Nuketown Perk Settings", "Shuffle Perks on Game Start")
		local nukedfizzrow =	DProperties:CreateRow("Nuketown Perk Settings", "Include Der Wunderfizz")
		local nukedpaprow =		DProperties:CreateRow("Nuketown Perk Settings", "Include Pack-a-Punch")
		local nukedminrow = 	DProperties:CreateRow("Nuketown Perk Settings", "Falling Perk Round Random Min")
		local nukedmaxrow = 	DProperties:CreateRow("Nuketown Perk Settings", "Falling Perk Round Random Max")

		nukedperkrow:Setup("Boolean")
		nukedperkrow:SetValue(valz["NukedPerks"])
		nukedperkrow.DataChanged = function( _, val) valz["NukedPerks"] = tobool(val) end
		nukedperkrow:SetTooltip("Enable for perk machines to drop from the sky every so many rounds like in nuketown. (Perk machines that are hidden behind doors will be visible regardless)")

		nukedrandomrow:Setup("Boolean")
		nukedrandomrow:SetValue(valz["NukedRandom"])
		nukedrandomrow.DataChanged = function( _, val ) valz["NukedRandom"] = tobool(val) end
		nukedrandomrow:SetTooltip("Enable for perks to be shuffled before dropping from the sky. (Default On)")

		nukedminrow:Setup("Generic")
		nukedminrow:SetValue(valz["NukedRandomMin"])
		nukedminrow.DataChanged = function( _, val ) valz["NukedRandomMin"] = tonumber(val) end
		nukedminrow:SetTooltip("Minimum amount of rounds before the next perk machine drops. (Default 2)")

		nukedmaxrow:Setup("Generic")
		nukedmaxrow:SetValue(valz["NukedRandomMax"])
		nukedmaxrow.DataChanged = function( _, val ) valz["NukedRandomMax"] = tonumber(val) end
		nukedmaxrow:SetTooltip("Maximum amount of rounds before the next perk machine drops. (Default 5)")

		nukedfizzrow:Setup("Boolean")
		nukedfizzrow:SetValue(valz["NukedFizz"])
		nukedfizzrow.DataChanged = function( _, val) valz["NukedFizz"] = tobool(val) end
		nukedfizzrow:SetTooltip("Enable for Der Wunderfizz to also have nuketown perk functionality. (Default On)")

		nukedpaprow:Setup("Boolean")
		nukedpaprow:SetValue(valz["NukedPaP"])
		nukedpaprow.DataChanged = function( _, val) valz["NukedPaP"] = tobool(val) end
		nukedpaprow:SetTooltip("Enable for Pack-a-Punch to also have nuketown perk functionality. (Default On)")

		--[[-------------------------------------------------------------------------
		PaP Settings
		---------------------------------------------------------------------------]]
		local PaPBeam = 			DProperties:CreateRow("Pack-a-Punch Settings", "Enable Beam")
		local PaPRandomize =		DProperties:CreateRow("Pack-a-Punch Settings", "Randomize Location")
		local PaPRandomizeRound =	DProperties:CreateRow("Pack-a-Punch Settings", "Randomize Round Interval")
		local PaPRandomizeTimer =	DProperties:CreateRow("Pack-a-Punch Settings", "Randomize Timer")

		PaPBeam:Setup("Boolean")
		PaPBeam:SetValue(valz["PaPBeam"])
		PaPBeam.DataChanged = function( _, val ) valz["PaPBeam"] = tobool(val) end
		PaPBeam:SetTooltip("Enable for Pack-a-Punch to have a Mystery Box-esque Light that signals its location.")

		PaPRandomize:Setup("Boolean")
		PaPRandomize:SetValue(valz["RandomPaP"])
		PaPRandomize.DataChanged = function( _, val ) valz["RandomPaP"] = tobool(val) end
		PaPRandomize:SetTooltip("Enable for only one Pack-a-Punch location to be active at a time.")

		PaPRandomizeRound:Setup("Generic")
		PaPRandomizeRound:SetValue(valz["RandomPaPRound"])
		PaPRandomizeRound.DataChanged = function( _, val ) valz["RandomPaPRound"] = tonumber(val) end
		PaPRandomizeRound:SetTooltip("How many rounds before the Pack-a-Punch moves locations.")

		PaPRandomizeTimer:Setup("Generic")
		PaPRandomizeTimer:SetValue(valz["RandomPaPTime"])
		PaPRandomizeTimer.DataChanged = function( _, val ) valz["RandomPaPTime"] = tonumber(val) end
		PaPRandomizeTimer:SetTooltip("How long, in seconds, before the Pack-a-Punch moves locations. SET TO 0 TO DISABLE. (Overrides round based randomization)")

		--[[-------------------------------------------------------------------------
		Timed Gameplay
		---------------------------------------------------------------------------]]
		local TimedPlay = 			DProperties:CreateRow("Timed Gameplay", "Enable Timed Gameplay")
		local TimedPlayTime =		DProperties:CreateRow("Timed Gameplay", "Wait Time")
		local TimedPlayMaxTime =	DProperties:CreateRow("Timed Gameplay", "Max Wait Time")
		local TimedPlayRoundWait =	DProperties:CreateRow("Timed Gameplay", "Round Preparation Time")

		TimedPlay:Setup( "Boolean" )
		TimedPlay:SetValue( valz["TimedGameplay"] )
		TimedPlay.DataChanged = function( _, val ) valz["TimedGameplay"] = val end
		TimedPlay:SetTooltip("Enable for Timed Gameplay.(Rounds will automatically advance overtime.)")

		TimedPlayTime:Setup("Generic")
		TimedPlayTime:SetValue( valz["TimedGameplayTime"] )
		TimedPlayTime:SetTooltip("The amount time the Round will wait before transitioning to the next one.(Multiplied by the current round number.)")
		TimedPlayTime.DataChanged = function( _, val ) valz["TimedGameplayTime"] = tonumber(val) end

		TimedPlayMaxTime:Setup("Generic")
		TimedPlayMaxTime:SetValue( valz["TimedGameplayMaxTime"] )
		TimedPlayMaxTime:SetTooltip("The maximum amount time the Round will wait before transitioning to the next one.")
		TimedPlayMaxTime.DataChanged = function( _, val ) valz["TimedGameplayMaxTime"] = tonumber(val) end

		TimedPlayRoundWait:Setup("Generic")
		TimedPlayRoundWait:SetValue(valz["TimedGameplayRoundWait"])
		TimedPlayRoundWait:SetTooltip("Wait time between rounds for timed gameplay. (Default 0.5)")
		TimedPlayRoundWait.DataChanged = function(_, val) valz["TimedGameplayRoundWait"] = tonumber(val) end

		--[[-------------------------------------------------------------------------
		Scripting and Extensions
		---------------------------------------------------------------------------]]
		local Row4 = DProperties:CreateRow("Scripting and Extensions", "Includes Map Script?")
		local Row5 = DProperties:CreateRow("Scripting and Extensions", "Script Description")
		local Row6 = DProperties:CreateRow("Scripting and Extensions", "GM Extensions")

		Row4:Setup( "Boolean" )
		Row4:SetValue( valz["Row4"] )
		Row4.DataChanged = function( _, val ) valz["Row4"] = val end
		Row4:SetTooltip("Loads a .lua file with the same name as the config .txt from /lua/nzmapscripts - for advanced developers.")

		Row5:Setup( "Generic" )
		Row5:SetValue( valz["Row5"] )
		Row5.DataChanged = function( _, val ) valz["Row5"] = val end
		Row5:SetTooltip("Sets the description displayed when attempting to load the script.")

		Row6:Setup("Boolean")
		Row6:SetValue( valz["Row6"] )
		Row6.DataChanged = function( _, val ) valz["Row6"] = val end
		Row6:SetTooltip("Sets whether the gamemode should spawn in map entities from other gamemodes, such as ZS.")

		--[[-------------------------------------------------------------------------
		Anti Cheat
		---------------------------------------------------------------------------]]
		--[[
		local ACRow1 = DProperties:CreateRow("Anti-Cheat Settings", "Enabled?")
		local ACRow2 = DProperties:CreateRow("Anti-Cheat Settings", "Warn players?")
		local ACRow3 = DProperties:CreateRow("Anti-Cheat Settings", "Save Last Spots?")
		local ACRow5 = DProperties:CreateRow("Anti-Cheat Settings", "Prevent boosting?")
		local ACRow6 = DProperties:CreateRow("Anti-Cheat Settings", "No Crouch Jump?")
		local ACRow4 = DProperties:CreateRow("Anti-Cheat Settings", "Seconds for TP")

		ACRow1:Setup("Boolean")
		ACRow1:SetValue(valz["ACRow1"])
		ACRow1.DataChanged = function( _, val ) valz["ACRow1"] = val end

		ACRow2:Setup("Boolean")
		ACRow2:SetValue(valz["ACRow2"])
		ACRow2:SetTooltip("Shows \"Return to map!\" with a countdown on player's screens")
		ACRow2.DataChanged = function(_, val) valz["ACRow2"] = val end

		ACRow3:Setup("Boolean")
		ACRow3:SetValue(valz["ACRow3"])
		ACRow3:SetTooltip("Remembers the last spot a player was at before they were detected. (Uses more performance)")
		ACRow3.DataChanged = function(_, val) valz["ACRow3"] = val end

		ACRow5:Setup("Boolean")
		ACRow5:SetValue(valz["ACRow5"])
		ACRow5:SetTooltip("Cancels out vertical velocity when players boost up faster than jump speed")
		ACRow5.DataChanged = function(_, val) valz["ACRow5"] = val end

		ACRow6:Setup("Boolean")
		ACRow6:SetValue(valz["ACRow6"])
		ACRow6:SetTooltip("Turns crouch jumps into normal jumps to make climbing on stuff harder")
		ACRow6.DataChanged = function(_, val) valz["ACRow6"] = val end

		ACRow4:Setup("Generic")
		ACRow4:SetValue(valz["ACRow4"])
		ACRow4:SetTooltip("Amount of seconds before a cheating player is teleported.")
		ACRow4.DataChanged = function(_, val) valz["ACRow4"] = tonumber(val) end]]
		--[[-------------------------------------------------------------------------
		Map Functionality
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Player Settings Tab
		---------------------------------------------------------------------------]]
		local DProperties2 = vgui.Create( "DProperties", sheet )
		DProperties2:SetSize( 280, 220 )
		DProperties2:SetPos( 0, 0 )
		sheet:AddSheet("Player Settings", DProperties2, "icon16/user.png", false, false, "Change player settings")

		local Row1 = 			DProperties2:CreateRow("Player Loadout", "Starting Weapon")
		local kniferow = 		DProperties2:CreateRow("Player Loadout", "Starting Knife")
		local grenaderow = 		DProperties2:CreateRow("Player Loadout", "Starting Grenade")
		local Row2 = 			DProperties2:CreateRow("Player Loadout", "Starting Points")

		local Row45 = 			DProperties2:CreateRow("Health Settings", "Base Health")
		local Row72 = 			DProperties2:CreateRow("Health Settings", "Health Regen Delay")
		local Row73 = 			DProperties2:CreateRow("Health Settings", "Health Regen Amount")
		local Row74 = 			DProperties2:CreateRow("Health Settings", "Health Regen Rate")

		local Row124 = 			DProperties2:CreateRow("Armor Settings", "Max Armor")
		local Row125 = 			DProperties2:CreateRow("Armor Settings", "Starting Armor")

		local Row89 =			DProperties2:CreateRow("Stamina Settings", "Base Stamina")
		local Row91 =			DProperties2:CreateRow("Stamina Settings", "Stamina Regen Delay")
		local Row90 =			DProperties2:CreateRow("Stamina Settings", "Stamina Regen Amount")

		local Row111 = 			DProperties2:CreateRow("Diving Settings", "Allow Weapons While Diving")
		local Row112 = 			DProperties2:CreateRow("Diving Settings", "Allow Omnidirection Diving")
		local Row129 = 			DProperties2:CreateRow("Diving Settings", "Diving Speed")
		local Row130 = 			DProperties2:CreateRow("Diving Settings", "Diving Height")
		local Row131 = 			DProperties2:CreateRow("Diving Settings", "Diving Landing Wait")

		local Row84 =			DProperties2:CreateRow("Slide Settings", "Slide Jumping")
		//local Row88 =			DProperties2:CreateRow("Slide Settings", "Sliding Stamina")
		local Row83 =			DProperties2:CreateRow("Slide Settings", "Sliding Cooldown")
		local Row86 =			DProperties2:CreateRow("Slide Settings", "Sliding Duration")
		local Row87 =			DProperties2:CreateRow("Slide Settings", "Sliding Speed")

		local Row75 = 			DProperties2:CreateRow("Miscellaneous", "Revive Time")
		local Row77 = 			DProperties2:CreateRow("Miscellaneous", "Bleedout Time")
		local JumpPower =		DProperties2:CreateRow("Miscellaneous", "Jump Height")
		local FlashlightRow =	DProperties2:CreateRow("Miscellaneous", "Player Flashlight")
		local FlashlightFOV =	DProperties2:CreateRow("Miscellaneous", "Flashlight FOV")
		local FlashlightFar =	DProperties2:CreateRow("Miscellaneous", "Flashlight Distance")

		Row1:Setup("Combo")
		for k, v in pairs(WeaponList) do
			if !v.NZTotalBlacklist then
				if v.Category and v.Category != "" then
					Row1:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Row1"] == v.ClassName)
				else
					Row1:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Row1"] == v.ClassName)
				end
			end
		end

		Row1.Think = function(self)
			if self.Inner:IsEditing() and self:IsEnabled() and nzTools.OpenWeaponSelectMenu then
				nzTools:OpenWeaponSelectMenu(Row1, Row1)
				vgui.GetHoveredPanel():CloseMenu()
				self:SetEnabled(false)
			end

			if !self:IsEnabled() and !nzTools.WeaponSelectMenu then
				self:SetEnabled(true)
			end
		end

		Row1.DoClick = function()
			if Row1.optionData then
				valz["Row1"] = Row1.optionData
				Row1.Inner:SetValue(valz["Row1"])
			end
		end

		Row1.DataChanged = function( self, val ) valz["Row1"] = Row1.optionData or val end

		kniferow:Setup( "Combo" )
		for k,v in pairs(WeaponList) do
			if v.Category and v.Category == "nZombies Knives" then
				kniferow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Knife"] == v.ClassName)
			end
		end
		kniferow.DataChanged = function( _, val ) valz["Knife"] = val end

		grenaderow:Setup( "Combo" )
		for k,v in pairs(WeaponList) do
			if v.Category and v.Category == "nZombies Grenades" then
				grenaderow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Grenade"] == v.ClassName)
			end
		end
		grenaderow.DataChanged = function( _, val ) valz["Grenade"] = val end

		Row2:Setup("Generic")
		Row2:SetValue( valz["Row2"] )
		Row2.DataChanged = function( _, val ) valz["Row2"] = tonumber(val) end

		Row45:Setup("Generic")
		Row45:SetValue( valz["Row45"] )
		Row45.DataChanged = function( _, val ) valz["Row45"] = tonumber(val) end

		Row72:Setup("Generic")
		Row72:SetValue( valz["Row72"] )
		Row72.DataChanged = function( _, val ) valz["Row72"] = tonumber(val) end
		Row72:SetTooltip("Delay before the player starts regenerating health after last taking damage. (Default 5 seconds)")

		Row73:Setup("Int", {min = 1, max = 100})
		Row73:SetValue(math.Round(valz["Row73"]*100))
		Row73.DataChanged = function( _, val ) valz["Row73"] = math.max(0.01, val*0.01) end
		Row73:SetTooltip("Amount of hp restored each health regen tick. (Default 10 HP)")

		Row74:Setup("Generic")
		Row74:SetValue(valz["Row74"])
		Row74.DataChanged = function( _, val ) valz["Row74"] = tonumber(val) end
		Row74:SetTooltip("How long the delay is between each health increase from health regeneration. (Default 0.05s)")

		Row75:Setup("Generic")
		Row75:SetValue(valz["Row75"])
		Row75.DataChanged = function( _, val ) valz["Row75"] = tonumber(val) end
		Row75:SetTooltip("How long it takes to revive a player. (Default 4 seconds)")

		Row77:Setup("Generic")
		Row77:SetValue(valz["Row77"])
		Row77.DataChanged = function( _, val ) valz["Row77"] = tonumber(val) end
		Row77:SetTooltip("How long it takes for the player to bleedout and die. (Default 45 seconds)")

		FlashlightRow:Setup("Boolean")
		FlashlightRow:SetValue(valz["Flashlight"])
		FlashlightRow.DataChanged = function( _, val ) valz["Flashlight"] = tobool(val) end
		FlashlightRow:SetTooltip("Enable or disable the player flashlight from Half-Life 2.")

		Row84:Setup("Boolean")
		Row84:SetValue(valz["Row84"])
		Row84.DataChanged = function( _, val ) valz["Row84"] = tobool(val) end
		Row84:SetTooltip("Enables the ability to jump out of sliding like Black Ops 3.")

		/*Row88:Setup("Boolean")
		Row88:SetValue(valz["Row88"])
		Row88.DataChanged = function( _, val ) valz["Row88"] = tobool(val) end
		Row88:SetTooltip("Enables a stamina system for sliding like Black Ops 4's.")*/

		Row83:Setup("Generic")
		Row83:SetValue(valz["Row83"])
		Row83.DataChanged = function( _, val ) valz["Row83"] = tonumber(val) end
		Row83:SetTooltip("Cooldown before the player can slide again after sliding. (Default 0.4)")

		Row86:Setup("Generic")
		Row86:SetValue(valz["Row86"])
		Row86.DataChanged = function( _, val ) valz["Row86"] = tonumber(val) end
		Row86:SetTooltip("Duration of player slide in seconds. (Default 0.6)")

		Row87:Setup("Generic")
		Row87:SetValue(valz["Row87"])
		Row87.DataChanged = function( _, val ) valz["Row87"] = tonumber(val) end
		Row87:SetTooltip("Player sliding speed multiplier. (Default 1.3)")

		Row89:Setup("Generic")
		Row89:SetValue(valz["Row89"])
		Row89.DataChanged = function( _, val ) valz["Row89"] = tonumber(val) end
		Row89:SetTooltip("(Default 100)")

		Row90:Setup("Generic")
		Row90:SetValue(valz["Row90"])
		Row90.DataChanged = function( _, val ) valz["Row90"] = tonumber(val) end
		Row90:SetTooltip("Amount of stamina regenerated. (Default 4.5)")

		Row91:Setup("Generic")
		Row91:SetValue(valz["Row91"])
		Row91.DataChanged = function( _, val ) valz["Row91"] = tonumber(val) end
		Row91:SetTooltip("Delay before the players stamina starts regenerating. (Default 0.5)")

		Row111:Setup("Boolean")
		Row111:SetValue(valz["Row111"])
		Row111.DataChanged = function( _, val ) valz["Row111"] = tobool(val) end
		Row111:SetTooltip("its just like")

		Row112:Setup("Boolean")
		Row112:SetValue(valz["Row112"])
		Row112.DataChanged = function( _, val ) valz["Row112"] = tobool(val) end
		Row112:SetTooltip("black ops 6")

		Row124:Setup("Generic")
		Row124:SetValue( valz["Row124"] )
		Row124.DataChanged = function( _, val ) valz["Row124"] = tonumber(val) end
		Row124:SetTooltip("Maximum amount of armor the player can have. (Default 200)")

		Row125:Setup("Generic")
		Row125:SetValue( valz["Row125"] )
		Row125.DataChanged = function( _, val ) valz["Row125"] = tonumber(val) end
		Row125:SetTooltip("Amount of armor the player should spawn in with. (Default 0)")

		FlashlightFOV:Setup("Generic")
		FlashlightFOV:SetValue(valz["FlashlightFOV"])
		FlashlightFOV.DataChanged = function( _, val ) valz["FlashlightFOV"] = tonumber(val) end
		FlashlightFOV:SetTooltip("Default 60")

		FlashlightFar:Setup("Generic")
		FlashlightFar:SetValue(valz["FlashlightFar"])
		FlashlightFar.DataChanged = function( _, val ) valz["FlashlightFar"] = tonumber(val) end
		FlashlightFar:SetTooltip("Default 750")

		JumpPower:Setup("Generic")
		JumpPower:SetValue(valz["JumpPower"])
		JumpPower.DataChanged = function( _, val ) valz["JumpPower"] = tonumber(val) end
		JumpPower:SetTooltip("Default 200")

		Row129:Setup("Generic")
		Row129:SetValue(valz["Row129"])
		Row129.DataChanged = function( _, val ) valz["Row129"] = tonumber(val) end
		Row129:SetTooltip("Player diving speed multiplier. (Default 1)")

		Row130:Setup("Generic")
		Row130:SetValue(valz["Row130"])
		Row130.DataChanged = function( _, val ) valz["Row130"] = tonumber(val) end
		Row130:SetTooltip("Vertical velocity gained by diving. (Default 200)")

		Row131:Setup("Generic")
		Row131:SetValue(valz["Row131"])
		Row131.DataChanged = function( _, val ) valz["Row131"] = tonumber(val) end
		Row131:SetTooltip("Delay, in seconds, after the player lands from diving that they will then stand back up. (Default 0.2)")
		--[[-------------------------------------------------------------------------
		Player Settings Tab
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Zombie Settings Tab
		---------------------------------------------------------------------------]]
		local DProperties3 = vgui.Create( "DProperties", sheet )
		DProperties3:SetSize( 280, 220 )
		DProperties3:SetPos( 0, 0 )
		sheet:AddSheet( "Zombie Settings", DProperties3, "icon16/user_green.png", false, false, "Change zombie settings")

		local Row15 = DProperties3:CreateRow("Zombie Settings", "Zombie Type")
		Row15:Setup( "Combo" )
		for k, v in pairs(nzRound.ZombieSkinData) do
			Row15:AddChoice(k, k, k == valz["Row15"])
		end
		Row15.DataChanged = function( _, val ) valz["Row15"] = val end
		Row15:SetTooltip("Sets the zombies that will appear in your map.")
				
		local Row7 = DProperties3:CreateRow("Zombie Settings", "Special Round")
		Row7:Setup( "Combo" )
		local found = false
		for k, v in pairs(nzRound.SpecialData) do
			if !found and k == valz["Row7"] then
				found = true
			end
			Row7:AddChoice(k, k, k == valz["Row7"])
		end
		Row7:AddChoice("None", "None", !found)
		Row7.DataChanged = function( _, val ) valz["Row7"] = val end
		Row7:SetTooltip("Sets what type of special round will appear.")

		local Row8 = DProperties3:CreateRow( "Zombie Settings", "Boss" )
		Row8:Setup( "Combo" )
		local found = false
		for k, v in pairs(nzRound.BossData) do
			if !found and k == valz["Row8"] then
				found = true
			end
			Row8:AddChoice(k, k, k == valz["Row8"])
		end
		Row8:AddChoice("None", "None", !found)
		Row8.DataChanged = function( _, val ) valz["Row8"] = val end
		Row8:SetTooltip("Sets what type of boss will appear.")

		local Row46 = DProperties3:CreateRow( "Zombie Settings", "Zombie Search Range" )
		Row46:Setup("Generic")
		Row46:SetValue( valz["Row46"] )
		Row46.DataChanged = function( _, val ) valz["Row46"] = tonumber(val) end
		Row46:SetTooltip("Sets zombie search range. 0 is infinite search range and not recommended. Must be positive")

		local Row51 = DProperties3:CreateRow( "Zombie Settings", "Nav-Zone Based Zombie Spawning" )
		Row51:Setup( "Boolean" )
		Row51:SetValue( valz["Row51"] )
		Row51.DataChanged = function( _, val ) valz["Row51"] = val end
		Row51:SetTooltip("Makes use of the nav-zone system to determine where to spawn zombies. Ideally use it so zombies always spawn in areas near the player.")

		local Row50 = DProperties3:CreateRow("Zombie Progression", "Round Amount Cap")
		Row50:Setup("Generic")
		Row50:SetValue( valz["Row50"] )
		Row50:SetTooltip("The point at which the amount of zombies per round stops increasing.")
		Row50.DataChanged = function( _, val ) valz["Row50"] = tonumber(val) end
				
		local Row9 = DProperties3:CreateRow("Zombie Progression", "Starting Spawns")
		Row9:Setup("Generic")
		Row9:SetValue( valz["Row9"] )
		Row9:SetTooltip("Allowed zombies alive at once, can be increased per round with Spawns Per Round")
		Row9.DataChanged = function( _, val ) valz["Row9"] = tonumber(val) end

		local Row11 = DProperties3:CreateRow("Zombie Progression", "Max Spawns")
		Row11:Setup("Generic")
		Row11:SetValue( valz["Row11"] )
		Row11:SetTooltip("The max allowed zombies alive at any given time, it will NEVER go above this.")
		Row11.DataChanged = function( _, val ) valz["Row11"] = tonumber(val) end

		local Row10 = DProperties3:CreateRow("Zombie Progression", "Spawns Per Round")
		Row10:Setup("Generic")
		Row10:SetValue( valz["Row10"] )
		Row10:SetTooltip("Amount to increase spawns by each round (Cannot increase past Max Spawns)")
		Row10.DataChanged = function( _, val ) valz["Row10"] = tonumber(val) end

		local Row13 = DProperties3:CreateRow("Zombie Progression", "Zombies Per Player")
		Row13:Setup("Generic")
		Row13:SetValue( valz["Row13"] )
		Row13:SetTooltip("Extra zombies to kill per player (Ignores first player)")
		Row13.DataChanged = function( _, val ) valz["Row13"] = tonumber(val) end

		local Row14 = DProperties3:CreateRow("Zombie Progression", "Spawns Per Player")
		Row14:Setup("Generic")
		Row14:SetValue( valz["Row14"] )
		Row14:SetTooltip("Extra zombies allowed to spawn per player (Ignores first player and Max Spawns option)")
		Row14.DataChanged = function( _, val ) valz["Row14"] = tonumber(val) end
				
		local SpawnDelay = DProperties3:CreateRow("Zombie Progression", "Spawn Delay")
		SpawnDelay:Setup("Generic")
		SpawnDelay:SetValue( valz["SpawnDelay"] )
		SpawnDelay:SetTooltip("Interval in seconds that zombies spawn. Continually decreases per round. CANNOT GO BELOW 0.05!")
		SpawnDelay.DataChanged = function( _, val ) valz["SpawnDelay"] = tonumber(val) end
				
		local HealthStart = DProperties3:CreateRow("Zombie Progression", "Zombie Start Health")
		HealthStart:Setup("Generic")
		HealthStart:SetValue( valz["HealthStart"] )
		HealthStart:SetTooltip("The amount of health zombies have at the start of the game.")
		HealthStart.DataChanged = function( _, val ) valz["HealthStart"] = tonumber(val) end
				
		local HealthIncrement = DProperties3:CreateRow("Zombie Progression", "Zombie Health Increment")
		HealthIncrement:Setup("Generic")
		HealthIncrement:SetValue( valz["HealthIncrement"] )
		HealthIncrement:SetTooltip("The amount of health zombies gain each round before Round 10.")
		HealthIncrement.DataChanged = function( _, val ) valz["HealthIncrement"] = tonumber(val) end
				
		local HealthMultiplier = DProperties3:CreateRow("Zombie Progression", "Zombie Health Multiplier")
		HealthMultiplier:Setup("Generic")
		HealthMultiplier:SetValue( valz["HealthMultiplier"] )
		HealthMultiplier:SetTooltip("Multiply zombies health by this every round after Round 10.")
		HealthMultiplier.DataChanged = function( _, val ) valz["HealthMultiplier"] = tonumber(val) end
				
		local HealthCap = DProperties3:CreateRow("Zombie Progression", "Zombie Health Cap")
		HealthCap:Setup("Generic")
		HealthCap:SetValue( valz["HealthCap"] )
		HealthCap:SetTooltip("Maximum health that zombies can have.")
		HealthCap.DataChanged = function( _, val ) valz["HealthCap"] = tonumber(val) end

		local Row49 = DProperties3:CreateRow("Zombie Progression", "Zombie Speed Multiplier")
		Row49:Setup("Generic")
		Row49:SetValue( valz["Row49"] )
		Row49:SetTooltip("Controls the Rate at how fast the Zombies increase in speed.")
		Row49.DataChanged = function( _, val ) valz["Row49"] = tonumber(val) end

		local ZStartSpeed = DProperties3:CreateRow("Zombie Progression", "Zombie Start Speed")
		ZStartSpeed:Setup("Generic")
		ZStartSpeed:SetValue( valz["ZStartSpeed"] )
		ZStartSpeed:SetTooltip("The Speed that zombies start the game at.")
		ZStartSpeed.DataChanged = function( _, val ) valz["ZStartSpeed"] = tonumber(val) end

		local ZSpeedCap = DProperties3:CreateRow("Zombie Progression", "Zombie Speed Cap")
		ZSpeedCap:Setup("Generic")
		ZSpeedCap:SetValue( valz["ZSpeedCap"] )
		ZSpeedCap:SetTooltip("Maximum Speed that zombies can reach.(They can still randomly gain up to 35 additional speed and bypass this cap.)")
		ZSpeedCap.DataChanged = function( _, val ) valz["ZSpeedCap"] = tonumber(val) end
				
		local DmgIncrease = DProperties3:CreateRow( "Zombie Extras", "Zombie Attack Damage Scaling" )
		DmgIncrease:Setup( "Boolean" )
		DmgIncrease:SetValue( valz["DmgIncrease"] )
		DmgIncrease.DataChanged = function( _, val ) valz["DmgIncrease"] = val end
		DmgIncrease:SetTooltip("Enable this if you want the zombie attack damage to scale as the rounds progess like in Cold War.")

		local Row52 = DProperties3:CreateRow( "Zombie Extras", "Zombie Side-Stepping" )
		Row52:Setup( "Boolean" )
		Row52:SetValue( valz["Row52"] )
		Row52.DataChanged = function( _, val ) valz["Row52"] = val end
		Row52:SetTooltip("Enable this if you want zombies to dodge and weave your shots like in BO1 Ascension.")

		local Row54 = DProperties3:CreateRow( "Zombie Extras", "Bad Attack Animations" )
		Row54:Setup( "Boolean" )
		Row54:SetValue( valz["Row54"] )
		Row54.DataChanged = function( _, val ) valz["Row54"] = val end
		Row54:SetTooltip("Enable this if you want zombies to use their Bo3 attack animations as a posed to their Bo4 ones.")

		local ZStumbling = DProperties3:CreateRow( "Zombie Extras", "Zombie Stumbling" )
		ZStumbling:Setup( "Boolean" )
		ZStumbling:SetValue( valz["ZStumbling"] )
		ZStumbling.DataChanged = function( _, val ) valz["ZStumbling"] = val end
		ZStumbling:SetTooltip("Disable this if you don't want zombies to stumble like in BO4 onward.")

		local ZSTaunts = DProperties3:CreateRow( "Zombie Extras", "Zombie Super Taunts" )
		ZSTaunts:Setup( "Boolean" )
		ZSTaunts:SetValue( valz["ZSTaunts"] )
		ZSTaunts.DataChanged = function( _, val ) valz["ZSTaunts"] = val end
		ZSTaunts:SetTooltip("Zombies will play a special animation which allows them to speed up from walking speed.")
		--[[-------------------------------------------------------------------------
		Catalysts and ZCT and Burning
		---------------------------------------------------------------------------]]
		------ Burning ------
		local EnableBurningZombies = DProperties3:CreateRow( "Burning Zombies", "Burning Zombies" )
		EnableBurningZombies:Setup( "Boolean" )
		EnableBurningZombies:SetValue( valz["EnableBurningZombies"] )
		EnableBurningZombies.DataChanged = function( _, val ) valz["EnableBurningZombies"] = val end
		EnableBurningZombies:SetTooltip("Enable for Burning Zombies to appear in your config.")

		local BurningChance = DProperties3:CreateRow("Burning Zombies", "Burning Chance")
		BurningChance:Setup("Generic")
		BurningChance:SetValue( valz["BurningChance"] )
		BurningChance:SetTooltip("Chance of Burning Zombies appearing. (0 to disable)")
		BurningChance.DataChanged = function( _, val ) valz["BurningChance"] = tonumber(val) end

		local BurningRnd = DProperties3:CreateRow("Burning Zombies", "Burning Round")
		BurningRnd:Setup("Generic")
		BurningRnd:SetValue( valz["BurningRnd"] )
		BurningRnd:SetTooltip("Round when Burning Zombies can start appearing. (-1 for on Power)")
		BurningRnd.DataChanged = function( _, val ) valz["BurningRnd"] = tonumber(val) end

		------ ZCTaco ------
		local Row56 = DProperties3:CreateRow( "ZCT Zombies", "Zombie Chicken Taco(ZCT)" )
		Row56:Setup( "Boolean" )
		Row56:SetValue( valz["Row56"] )
		Row56.DataChanged = function( _, val ) valz["Row56"] = val end
		Row56:SetTooltip("Enable for ZCT zombies to appear in your config.")

		-- Red --
		local RedChance = DProperties3:CreateRow("ZCT Zombies", "Red Chance")
		RedChance:Setup("Generic")
		RedChance:SetValue( valz["RedChance"] )
		RedChance:SetTooltip("Chance of Zombies appearing as Red. (0 to disable)")
		RedChance.DataChanged = function( _, val ) valz["RedChance"] = tonumber(val) end

		local RedRnd = DProperties3:CreateRow("ZCT Zombies", "Red Round")
		RedRnd:Setup("Generic")
		RedRnd:SetValue( valz["RedRnd"] )
		RedRnd:SetTooltip("Round when Red Zombies can start appearing. (-1 for on Power)")
		RedRnd.DataChanged = function( _, val ) valz["RedRnd"] = tonumber(val) end

		-- Blue --
		local BlueChance = DProperties3:CreateRow("ZCT Zombies", "Blue Chance")
		BlueChance:Setup("Generic")
		BlueChance:SetValue( valz["BlueChance"] )
		BlueChance:SetTooltip("Chance of Zombies appearing as Blue. (0 to disable)")
		BlueChance.DataChanged = function( _, val ) valz["BlueChance"] = tonumber(val) end

		local BlueRnd = DProperties3:CreateRow("ZCT Zombies", "Blue Round")
		BlueRnd:Setup("Generic")
		BlueRnd:SetValue( valz["BlueRnd"] )
		BlueRnd:SetTooltip("Round when Blue Zombies can start appearing. (-1 for on Power)")
		BlueRnd.DataChanged = function( _, val ) valz["BlueRnd"] = tonumber(val) end

		-- Green --
		local GreenChance = DProperties3:CreateRow("ZCT Zombies", "Green Chance")
		GreenChance:Setup("Generic")
		GreenChance:SetValue( valz["GreenChance"] )
		GreenChance:SetTooltip("Chance of Zombies appearing as Green. (0 to disable)")
		GreenChance.DataChanged = function( _, val ) valz["GreenChance"] = tonumber(val) end

		local GreenRnd = DProperties3:CreateRow("ZCT Zombies", "Green Round")
		GreenRnd:Setup("Generic")
		GreenRnd:SetValue( valz["GreenRnd"] )
		GreenRnd:SetTooltip("Round when Green Zombies can start appearing. (-1 for on Power)")
		GreenRnd.DataChanged = function( _, val ) valz["GreenRnd"] = tonumber(val) end

		-- Yellow --
		local YellowChance = DProperties3:CreateRow("ZCT Zombies", "Yellow Chance")
		YellowChance:Setup("Generic")
		YellowChance:SetValue( valz["YellowChance"] )
		YellowChance:SetTooltip("Chance of Zombies appearing as Yellow. (0 to disable)")
		YellowChance.DataChanged = function( _, val ) valz["YellowChance"] = tonumber(val) end

		local YellowRnd = DProperties3:CreateRow("ZCT Zombies", "Yellow Round")
		YellowRnd:Setup("Generic")
		YellowRnd:SetValue( valz["YellowRnd"] )
		YellowRnd:SetTooltip("Round when Yellow Zombies can start appearing. (-1 for on Power)")
		YellowRnd.DataChanged = function( _, val ) valz["YellowRnd"] = tonumber(val) end

		-- Purple --
		local PurpleChance = DProperties3:CreateRow("ZCT Zombies", "Purple Chance")
		PurpleChance:Setup("Generic")
		PurpleChance:SetValue( valz["PurpleChance"] )
		PurpleChance:SetTooltip("Chance of Zombies appearing as Purple. (0 to disable)")
		PurpleChance.DataChanged = function( _, val ) valz["PurpleChance"] = tonumber(val) end

		local PurpleRnd = DProperties3:CreateRow("ZCT Zombies", "Purple Round")
		PurpleRnd:Setup("Generic")
		PurpleRnd:SetValue( valz["PurpleRnd"] )
		PurpleRnd:SetTooltip("Round when Purple Zombies can start appearing. (-1 for on Power)")
		PurpleRnd.DataChanged = function( _, val ) valz["PurpleRnd"] = tonumber(val) end

		-- Pink --
		local PinkChance = DProperties3:CreateRow("ZCT Zombies", "Pink Chance")
		PinkChance:Setup("Generic")
		PinkChance:SetValue( valz["PinkChance"] )
		PinkChance:SetTooltip("Chance of Zombies appearing as Pink. (0 to disable)")
		PinkChance.DataChanged = function( _, val ) valz["PinkChance"] = tonumber(val) end

		local PinkRnd = DProperties3:CreateRow("ZCT Zombies", "Pink Round")
		PinkRnd:Setup("Generic")
		PinkRnd:SetValue( valz["PinkRnd"] )
		PinkRnd:SetTooltip("Round when Pink Zombies can start appearing. (-1 for on Power)")
		PinkRnd.DataChanged = function( _, val ) valz["PinkRnd"] = tonumber(val) end

		----- Cataylsts -----
		local Row57 = DProperties3:CreateRow( "Catalyst Zombies", "Catalyst Zombies" )
		Row57:Setup( "Boolean" )
		Row57:SetValue( valz["Row57"] )
		Row57.DataChanged = function( _, val ) valz["Row57"] = val end
		Row57:SetTooltip("Enable for Catalyst zombies to appear in your config.")

		-- Poison --
		local PoisonChance = DProperties3:CreateRow("Catalyst Zombies", "Poison Chance")
		PoisonChance:Setup("Generic")
		PoisonChance:SetValue( valz["PoisonChance"] )
		PoisonChance:SetTooltip("Chance of Zombies turning into Poison Catalysts. (0 to disable)")
		PoisonChance.DataChanged = function( _, val ) valz["PoisonChance"] = tonumber(val) end

		local PoisonRnd = DProperties3:CreateRow("Catalyst Zombies", "Poison Round")
		PoisonRnd:Setup("Generic")
		PoisonRnd:SetValue( valz["PoisonRnd"] )
		PoisonRnd:SetTooltip("Round when Poison Cataylsts can start appearing. (-1 for on Power)")
		PoisonRnd.DataChanged = function( _, val ) valz["PoisonRnd"] = tonumber(val) end

		-- Water --
		local WaterChance = DProperties3:CreateRow("Catalyst Zombies", "Water Chance")
		WaterChance:Setup("Generic")
		WaterChance:SetValue( valz["WaterChance"] )
		WaterChance:SetTooltip("Chance of Zombies turning into Water Catalysts. (0 to disable)")
		WaterChance.DataChanged = function( _, val ) valz["WaterChance"] = tonumber(val) end

		local WaterRnd = DProperties3:CreateRow("Catalyst Zombies", "Water Round")
		WaterRnd:Setup("Generic")
		WaterRnd:SetValue( valz["WaterRnd"] )
		WaterRnd:SetTooltip("Round when Water Catalysts can start appearing. (-1 for on Power)")
		WaterRnd.DataChanged = function( _, val ) valz["WaterRnd"] = tonumber(val) end

		-- Fire --
		local FireChance = DProperties3:CreateRow("Catalyst Zombies", "Fire Chance")
		FireChance:Setup("Generic")
		FireChance:SetValue( valz["FireChance"] )
		FireChance:SetTooltip("Chance of Zombies turning into Fire Catalysts. (0 to disable)")
		FireChance.DataChanged = function( _, val ) valz["FireChance"] = tonumber(val) end

		local FireRnd = DProperties3:CreateRow("Catalyst Zombies", "Fire Round")
		FireRnd:Setup("Generic")
		FireRnd:SetValue( valz["FireRnd"] )
		FireRnd:SetTooltip("Round when Fire Catalysts can start appearing. (-1 for on Power)")
		FireRnd.DataChanged = function( _, val ) valz["FireRnd"] = tonumber(val) end

		-- Electric --
		local ElectricChance = DProperties3:CreateRow("Catalyst Zombies", "Electric Chance")
		ElectricChance:Setup("Generic")
		ElectricChance:SetValue( valz["ElectricChance"] )
		ElectricChance:SetTooltip("Chance of Zombies turning into Electric Catalysts. (0 to disable)")
		ElectricChance.DataChanged = function( _, val ) valz["ElectricChance"] = tonumber(val) end

		local ElectricRnd = DProperties3:CreateRow("Catalyst Zombies", "Electric Round")
		ElectricRnd:Setup("Generic")
		ElectricRnd:SetValue( valz["ElectricRnd"] )
		ElectricRnd:SetTooltip("Round when Electric Catalysts can start appearing. (-1 for on Power)")
		ElectricRnd.DataChanged = function( _, val ) valz["ElectricRnd"] = tonumber(val) end
		--[[-------------------------------------------------------------------------
		Zombie Settings Tab
		---------------------------------------------------------------------------]]

		local function UpdateData() -- Will remain a local function here. There is no need for the context menu to intercept
			if !weapons.Get( valz["Row1"] ) then data.startwep = nil else data.startwep = valz["Row1"] end
			if !weapons.Get( valz["Knife"] ) then data.knife = nil else data.knife = valz["Knife"] end
			if !weapons.Get( valz["Grenade"] ) then data.grenade = nil else data.grenade = valz["Grenade"] end
			if !weapons.Get( valz["Bottle"] ) then data.bottle = nil else data.bottle = valz["Bottle"] end
			if !weapons.Get( valz["Revive Syrette"] ) then data.syrette = nil else data.syrette = valz["Revive Syrette"] end
			if !weapons.Get( valz["PaP Arms"] ) then data.paparms = nil else data.paparms = valz["PaP Arms"] end
			if !weapons.Get( valz["Death Machine"] ) then data.deathmachine = nil else data.deathmachine = valz["Death Machine"] end
			if !weapons.Get( valz["Shield"] ) then data.shield = "tfa_bo2_tranzitshield" else data.shield = valz["Shield"] end
			if !tonumber(valz["Row2"]) then data.startpoints = 500 else data.startpoints = tonumber(valz["Row2"]) end
			if !valz["Row3"] or valz["Row3"] == "" then data.eeurl = nil else data.eeurl = valz["Row3"] end
			if !valz["Row4"] then data.script = nil else data.script = valz["Row4"] end
			if !valz["Row5"] or valz["Row5"] == "" then data.scriptinfo = nil else data.scriptinfo = valz["Row5"] end
			if !valz["Row6"] or valz["Row6"] == "0" then data.gamemodeentities = nil else data.gamemodeentities = tobool(valz["Row6"]) end
			if !valz["Row7"] then data.specialroundtype = "Hellhounds" else data.specialroundtype = valz["Row7"] end
			if !valz["Row8"] then data.bosstype = "None" else data.bosstype = valz["Row8"] end
			if !tonumber(valz["Row9"]) then data.startingspawns = 35 else data.startingspawns = tonumber(valz["Row9"]) end
			if !tonumber(valz["Row10"]) then data.spawnperround = 0 else data.spawnperround = tonumber(valz["Row10"]) end
			if !tonumber(valz["Row11"]) then data.maxspawns = 35 else data.maxspawns = tonumber(valz["Row11"]) end
			if !tonumber(valz["Row13"]) then data.zombiesperplayer = 0 else data.zombiesperplayer = tonumber(valz["Row13"]) end
			if !tonumber(valz["Row14"]) then data.spawnsperplayer = 0 else data.spawnsperplayer = tonumber(valz["Row14"]) end
			if !tonumber(valz["SpawnDelay"]) then data.spawndelay = 2 else data.spawndelay = tonumber(valz["SpawnDelay"]) end
			if !valz["Row15"] then data.zombietype = "Kino der Toten" else data.zombietype = valz["Row15"] end
			if !valz["Row16"] then data.hudtype = "Black Ops 1" else data.hudtype = valz["Row16"] end
			if valz["Row18"] == nil then data.perkmachinetype = "Classic" else data.perkmachinetype = tostring(valz["Row18"]) end
			if !valz["Row19"] then data.boxtype = "Original" else data.boxtype = valz["Row19"] end
			if !valz["Row33"] then data.mainfont = "Black Ops 1" else data.mainfont = valz["Row33"] end
			if !valz["Row34"] then data.smallfont = "Black Ops 1" else data.smallfont = valz["Row34"] end
			if !valz["Row35"] then data.mediumfont = "Black Ops 1" else data.mediumfont = valz["Row35"] end
			if !valz["Row36"] then data.roundfont = "Black Ops 1" else data.roundfont = valz["Row36"] end
			if !valz["Row37"] then data.ammofont = "Black Ops 1" else data.ammofont = valz["Row37"] end
			if !valz["Row38"] then data.ammo2font = "Black Ops 1" else data.ammo2font = valz["Row38"] end
			if !tonumber(valz["Row40"]) then data.fontthicc  = 2 else data.fontthicc  = tonumber(valz["Row40"]) end
			if !valz["Row41"] then data.icontype = "Rezzurrection" else data.icontype = valz["Row41"] end
			if !valz["Row42"] then data.perkupgrades = false else data.perkupgrades = tobool(valz["Row42"]) end
			if !valz["Row43"] then data.PAPtype = "Original" else data.PAPtype = valz["Row43"] end
			if !valz["Row44"] then data.PAPcamo = "nz_classic" else data.PAPcamo = valz["Row44"] end
			if !tonumber(valz["Row45"]) then data.hp = 150 else data.hp = tonumber(valz["Row45"]) end
			if !tonumber(valz["Row46"]) then data.range = 0 else data.range = tonumber(valz["Row46"]) end
			if !valz["Row49"] then data.speedmulti = 4 else data.speedmulti = tonumber(valz["Row49"]) end
			if !valz["Row50"] then data.amountcap = 240 else data.amountcap = tonumber(valz["Row50"]) end -- world the change, my good evening message. final. :jack_o_lantern:
			if !valz["HealthStart"] then data.healthstart = 75 else data.healthstart = tonumber(valz["HealthStart"]) end
			if !valz["HealthIncrement"] then data.healthinc = 50 else data.healthinc = tonumber(valz["HealthIncrement"]) end
			if !valz["HealthMultiplier"] then data.healthmult = 0.1 else data.healthmult = tonumber(valz["HealthMultiplier"]) end
			if !valz["HealthCap"] then data.healthcap = 60000 else data.healthcap = tonumber(valz["HealthCap"]) end
			if !valz["Row51"] then data.navgroupbased = nil else data.navgroupbased = valz["Row51"] end
			if !valz["Row52"] then data.sidestepping = false else data.sidestepping = valz["Row52"] end
			if !valz["DmgIncrease"] then data.dmgincrease = false else data.dmgincrease = valz["DmgIncrease"] end
			if valz["ZStumbling"] == nil then data.stumbling = true else data.stumbling = valz["ZStumbling"] end
			if valz["ZSTaunts"] == nil then data.supertaunting = false else data.supertaunting = valz["ZSTaunts"] end
			if !valz["ZStartSpeed"] then data.startspeed = 0 else data.startspeed = tonumber(valz["ZStartSpeed"]) end
			if !valz["ZSpeedCap"] then data.speedcap = 300 else data.speedcap = tonumber(valz["ZSpeedCap"]) end
			if !valz["Row54"] then data.badattacks = false else data.badattacks = valz["Row54"] end
			if !valz["Row56"] then data.zct = false else data.zct = valz["Row56"] end
			if !valz["Row57"] then data.mutated = false else data.mutated = valz["Row57"] end
			if !valz["Row58"] then data.aats = 2 else data.aats = tonumber(valz["Row58"]) end
			if !valz["Row59"] then data.poweruptype = "Black Ops 1" else data.poweruptype = tostring(valz["Row59"]) end
			if !valz["Row60"] then data.mmohudtype = "World at War/ Black Ops 1" else data.mmohudtype = tostring(valz["Row60"]) end
			if !valz["Row61"] then data.downsoundtype = "Black Ops 3" else data.downsoundtype = tostring(valz["Row61"]) end
			if !valz["Row62"] then data.solorevive = 3 else data.solorevive = tonumber(valz["Row62"]) end
			if valz["Row63"] == nil then data.modifierslot = true else data.modifierslot = tobool(valz["Row63"]) end
			//if !valz["Row64"] then data.dontkeepperks = false else data.dontkeepperks = tobool(valz["Row64"]) end
			if !valz["Row65"] then data.powerupstyle = "style_classic" else data.powerupstyle = tostring(valz["Row65"]) end
			if !valz["Row66"] then data.antipowerups = false else data.antipowerups = tobool(valz["Row66"]) end
			if !valz["Row67"] then data.antipowerupchance = 40 else data.antipowerupchance = tonumber(valz["Row67"]) end
			if !valz["Row68"] then data.antipowerupstart = 2 else data.antipowerupstart = tonumber(valz["Row68"]) end
			if !valz["Row69"] then data.antipowerupdelay = 4 else data.antipowerupdelay = tonumber(valz["Row69"]) end
			if !valz["Row70"] then data.powerupoutline = 0 else data.powerupoutline = tonumber(valz["Row70"]) end
			if valz["Row71"] == nil then data.roundperkbonus = true else data.roundperkbonus = tobool(valz["Row71"]) end
			if valz["Row72"] == nil then data.healthregendelay = 5 else data.healthregendelay = tonumber(valz["Row72"]) end
			if valz["Row73"] == nil then data.healthregenratio = 0.1 else data.healthregenratio = math.max(tonumber(valz["Row73"]), 0.01) end
			if valz["Row74"] == nil then data.healthregenrate = 0.05 else data.healthregenrate = tonumber(valz["Row74"]) end
			if valz["Row75"] == nil then data.revivetime = 4 else data.revivetime = tonumber(valz["Row75"]) end
			if valz["Row76"] == nil then data.playerperkmax = 4 else data.playerperkmax = tonumber(valz["Row76"]) end
			if valz["Row77"] == nil then data.downtime = 45 else data.downtime = tonumber(valz["Row77"]) end
			if valz["Row78"] == nil then data.cwfizz = false else data.cwfizz = tobool(valz["Row78"]) end
			if valz["Row79"] == nil then data.cwfizzprice = 1000 else data.cwfizzprice = tonumber(valz["Row79"]) end
			if valz["Row80"] == nil then data.cwfizzperkslot = false else data.cwfizzperkslot = tobool(valz["Row80"]) end
			if valz["Row81"] == nil then data.cwfizzslotprice = 10000 else data.cwfizzslotprice = tonumber(valz["Row81"]) end
			if valz["Row82"] == nil then data.cwfizzslotround = 20 else data.cwfizzslotround = tonumber(valz["Row82"]) end
			if valz["Row83"] == nil then data.slidecooldown = 0.4 else data.slidecooldown = tonumber(valz["Row83"]) end
			if valz["Row84"] == nil then data.slidejump = false else data.slidejump = tobool(valz["Row84"]) end
			if valz["Row85"] == nil then data.cwfizzround = 15 else data.cwfizzround = tonumber(valz["Row85"]) end
			if valz["Row86"] == nil then data.slideduration = 0.6 else data.slideduration = tonumber(valz["Row86"]) end
			if valz["Row87"] == nil then data.slidespeed = 1.3 else data.slidespeed = tonumber(valz["Row87"]) end
			//if valz["Row88"] == nil then data.slidestamina = true else data.slidestamina = tobool(valz["Row88"]) end
			if valz["Row89"] == nil then data.stamina = 100 else data.stamina = tonumber(valz["Row89"]) end
			if valz["Row90"] == nil then data.staminaregenamount = 4.5 else data.staminaregenamount = tonumber(valz["Row90"]) end
			if valz["Row91"] == nil then data.staminaregendelay = 0.5 else data.staminaregendelay = tonumber(valz["Row91"]) end
			if valz["Row93"] == nil then data.tacticalupgrades = false else data.tacticalupgrades = tobool(valz["Row93"]) end
			if valz["Row94"] == nil then data.tacticalkillcount = 40 else data.tacticalkillcount = tonumber(valz["Row94"]) end
			if valz["Row95"] == nil then data.maxperkslots = 8 else data.maxperkslots = tonumber(valz["Row95"]) end
			if valz["Row96"] == nil then data.minboxhit = 3 else data.minboxhit = tonumber(valz["Row96"]) end
			if valz["Row97"] == nil then data.maxboxhit = 13 else data.maxboxhit = tonumber(valz["Row97"]) end
			if valz["Row98"] == nil then data.boxstartuses = 8 else data.boxstartuses = tonumber(valz["Row98"]) end
			if valz["Row99"] == nil then data.poweruproundbased = false else data.poweruproundbased = tobool(valz["Row99"]) end
			if valz["Row100"] == nil then data.minfizzuses = 4 else data.minfizzuses = tonumber(valz["Row100"]) end
			if valz["Row101"] == nil then data.maxfizzuses = 7 else data.maxfizzuses = tonumber(valz["Row101"]) end
			if valz["Row102"] == nil then data.maxpowerupdrops = 4 else data.maxpowerupdrops = tonumber(valz["Row102"]) end
			if valz["Row103"] == nil then data.maxteddypercent = 50 else data.maxteddypercent = tonumber(valz["Row103"]) end
			if valz["Row104"] == nil then data.blurpoweron = false else data.blurpoweron = tobool(valz["Row104"]) end
			if valz["Row105"] == nil then data.maponlyrandomperks = false else data.maponlyrandomperks = tobool(valz["Row105"]) end
			if valz["Row106"] == nil then data.typewriterintro = false else data.typewriterintro = tobool(valz["Row106"]) end
			if valz["Row107"] == nil then data.typewritertext = "Berlin, Germany;Wittenau Sanatorium;September, 1945" else data.typewritertext = tostring(valz["Row107"]) end
			if valz["Row108"] == nil then data.typewriterdelay = 0.125 else data.typewriterdelay = tonumber(valz["Row108"]) end
			if valz["Row109"] == nil then data.typewriterlinedelay = 1.5 else data.typewriterlinedelay = tonumber(valz["Row109"]) end
			if valz["Row110"] == nil then data.typewriteroffset = 420 else data.typewriteroffset = tonumber(valz["Row110"]) end
			if valz["Row111"] == nil then data.divingallowweapon = false else data.divingallowweapon = tobool(valz["Row111"]) end
			if valz["Row112"] == nil then data.divingomnidirection = false else data.divingomnidirection = tobool(valz["Row112"]) end
			if valz["Row113"] == nil then data.roundwaittime = 15 else data.roundwaittime = tonumber(valz["Row113"]) end
			if valz["Row114"] == nil then data.firstroundwaittime = 1 else data.firstroundwaittime = tonumber(valz["Row114"]) end
			if valz["Row115"] == nil then data.specialroundwaittime = 15 else data.specialroundwaittime = tonumber(valz["Row115"]) end
			if valz["Row116"] == nil then data.specialroundmin = 5 else data.specialroundmin = tonumber(valz["Row116"]) end
			if valz["Row117"] == nil then data.specialroundmax = 7 else data.specialroundmax = tonumber(valz["Row117"]) end
			if valz["Row118"] == nil then data.forcefirstspecialround = false else data.forcefirstspecialround = tobool(valz["Row118"]) end
			if valz["Row119"] == nil then data.firstspecialround = 5 else data.firstspecialround = tonumber(valz["Row119"]) end
			if valz["Row120"] == nil then data.slotrewardround = 15 else data.slotrewardround = tonumber(valz["Row120"]) end
			if valz["Row121"] == nil then data.slotrewardinterval = 10 else data.slotrewardinterval = tonumber(valz["Row121"]) end
			if valz["Row122"] == nil then data.slotrewardcount = 2 else data.slotrewardcount = tonumber(valz["Row122"]) end
			if valz["Row123"] == nil then data.juggbonus = 100 else data.juggbonus = tonumber(valz["Row123"]) end
			if valz["Row124"] == nil then data.armor = 200 else data.armor = tonumber(valz["Row124"]) end
			if valz["Row125"] == nil then data.startarmor = 0 else data.startarmor = tonumber(valz["Row125"]) end
			if valz["Row126"] == nil then data.specialsuseplayers = false else data.specialsuseplayers = tobool(valz["Row126"]) end
			if valz["Row127"] == nil then data.gameovertime = 15 else data.gameovertime = tonumber(valz["Row127"]) end
			if valz["Row128"] == nil then data.gocamerawait = 5 else data.gocamerawait = tonumber(valz["Row128"]) end
			if valz["Row129"] == nil then data.divingspeed = 1 else data.divingspeed = tonumber(valz["Row129"]) end
			if valz["Row130"] == nil then data.divingheight = 200 else data.divingheight = tonumber(valz["Row130"]) end
			if valz["Row131"] == nil then data.divingwait = 0.2 else data.divingwait = tonumber(valz["Row131"]) end
			if valz["Row132"] == nil then data.downsystem = 0 else data.downsystem = tonumber(valz["Row132"]) end
			if valz["Row133"] == nil then data.perkstokeep = 3 else data.perkstokeep = tonumber(valz["Row133"]) end
			if valz["Row134"] == nil then data.skyintro = false else data.skyintro = tobool(valz["Row134"]) end
			if valz["Row135"] == nil then data.skyintrotime = 1.4 else data.skyintrotime = tonumber(valz["Row135"]) end
			if valz["Row136"] == nil then data.skyintroheight = 6000 else data.skyintroheight = tonumber(valz["Row136"]) end
			if valz["JumpPower"] == nil then data.jumppower = 200 else data.jumppower = tonumber(valz["JumpPower"]) end
			if valz["GameBeginText"] == nil then data.gamebegintext = "Round" else data.gamebegintext = tostring(valz["GameBeginText"]) end
			if valz["RBoxPrice"] == nil then data.rboxprice = 950 else data.rboxprice = tonumber(valz["RBoxPrice"]) end
			if valz["Colorless"] == nil then data.monochrome = false else data.monochrome = tobool(valz["Colorless"]) end
			if valz["PaPBeam"] == nil then data.papbeam = false else data.papbeam = tobool(valz["PaPBeam"]) end
			if valz["NukedPerks"] == nil then data.nukedperks = false else data.nukedperks = tobool(valz["NukedPerks"]) end
			if valz["NukedRandom"] == nil then data.nukedrandom = true else data.nukedrandom = tobool(valz["NukedRandom"]) end
			if valz["NukedFizz"] == nil then data.nukedfizz = true else data.nukedfizz = tobool(valz["NukedFizz"]) end
			if valz["NukedPaP"] == nil then data.nukedpap = true else data.nukedpap = tobool(valz["NukedPaP"]) end
			if valz["NukedRandomMin"] == nil then data.nukedroundmin = 3 else data.nukedroundmin = tonumber(valz["NukedRandomMin"]) end
			if valz["NukedRandomMax"] == nil then data.nukedroundmax = 5 else data.nukedroundmax = tonumber(valz["NukedRandomMax"]) end
			if valz["RandomPaP"] == nil then data.randompap = false else data.randompap = tobool(valz["RandomPaP"]) end
			if valz["RandomPaPRound"] == nil then data.randompapinterval = 2 else data.randompapinterval = tonumber(valz["RandomPaPRound"]) end
			if valz["RandomPaPTime"] == nil then data.randompaptime = 0 else data.randompaptime = tonumber(valz["RandomPaPTime"]) end
			if valz["Movement"] == nil then data.movement = 0 else data.movement = tonumber(valz["Movement"]) end
			if valz["Gravity"] == nil then data.gravity = 600 else data.gravity = tonumber(valz["Gravity"]) end
			if valz["Flashlight"] == nil then data.flashlight = true else data.flashlight = tobool(valz["Flashlight"]) end
			if valz["FlashlightFOV"] == nil then data.flashlightfov = 60 else data.flashlightfov = tonumber(valz["FlashlightFOV"]) end
			if valz["FlashlightFar"] == nil then data.flashlightfar = 750 else data.flashlightfar = tonumber(valz["FlashlightFar"]) end
			if valz["GameOverText"] == nil then data.gameovertext = "Game Over" else data.gameovertext = tostring(valz["GameOverText"]) end
			if valz["GameOverSubText"] == nil then data.survivedtext = "You Survived % Rounds" else data.survivedtext = tostring(valz["GameOverSubText"]) end
			if valz["GameWinText"] == nil then data.gamewintext = "Game Over" else data.gamewintext = tostring(valz["GameWinText"]) end
			if valz["GameWinSubText"] == nil then data.escapedtext = "You Escaped after % Rounds" else data.escapedtext = tostring(valz["GameWinSubText"]) end
			if !valz["TurnedNames"] then data.turnedlist = {} else data.turnedlist = valz["TurnedNames"] end
			if !valz["RBoxWeps"] or table.Count(valz["RBoxWeps"]) < 1 then data.rboxweps = nil else data.rboxweps = valz["RBoxWeps"] end
			if valz["Wunderfizz"] == nil then data.wunderfizzperklist = wunderfizzlist else data.wunderfizzperklist = valz["Wunderfizz"] end
			if valz["PowerUps"] == nil then data.poweruplist = poweruplist else data.poweruplist = valz["PowerUps"] end
			if valz["VultureDrops"] == nil then data.vulturelist = vulturelist else data.vulturelist = valz["VultureDrops"] end
			if valz["PowerUpRounds"] == nil then data.poweruprounds = poweruprounds else data.poweruprounds = valz["PowerUpRounds"] end
			if valz["GumsList"] == nil then data.gumlist = gumlist else data.gumlist = valz["GumsList"] end
			if valz["GumRoundPrices"] == nil then data.gumpricelist = nzGum.RoundPrices else data.gumpricelist = valz["GumRoundPrices"] end
			if valz["GumChanceMults"] == nil then data.gummultipliers = nzGum.ChanceMultiplier else data.gummultipliers = valz["GumChanceMults"] end
			if valz["GumResetRounds"] == nil then data.gumcountresetrounds = nzGum.RollCountResetRounds else data.gumcountresetrounds = valz["GumResetRounds"] end
			if valz["GumMaxUses"] == nil then data.maxplayergumuses = 3 else data.maxplayergumuses = math.Round(valz["GumMaxUses"]) end
			if valz["GumStartPrice"] == nil then data.gumstartprice = 0 else data.gumstartprice = tonumber(valz["GumStartPrice"]) end
			if valz["GumShowStats"] == nil then data.showgumstats = true else data.showgumstats = tobool(valz["GumShowStats"]) end

			--[[
			if valz["ACRow1"] == nil then data.ac = false else data.ac = tobool(valz["ACRow1"]) end
			if valz["ACRow2"] == nil then data.acwarn = nil else data.acwarn = tobool(valz["ACRow2"]) end
			if valz["ACRow3"] == nil then data.acsavespot = nil else data.acsavespot = tobool(valz["ACRow3"]) end
			if valz["ACRow4"] == nil then data.actptime = 5 else data.actptime = valz["ACRow4"] end
			if valz["ACRow5"] == nil then data.acpreventboost = true else data.acpreventboost = tobool(valz["ACRow5"]) end
			if valz["ACRow6"] == nil then data.acpreventcjump = false else data.acpreventcjump = tobool(valz["ACRow6"]) end
			]]

			if !valz["TimedGameplay"] then data.timedgame 						= nil else data.timedgame 				= valz["TimedGameplay"] end
			if !valz["TimedGameplayTime"] then data.timedgametime 				= 120 else data.timedgametime 			= tonumber(valz["TimedGameplayTime"]) end
			if !valz["TimedGameplayMaxTime"] then data.timedgamemaxtime 		= 600 else data.timedgamemaxtime 		= tonumber(valz["TimedGameplayMaxTime"]) end
			if !valz["TimedGameplayRoundWait"] then data.timedgameroundwaittime = 0.5 else data.timedgameroundwaittime	= tonumber(valz["TimedGameplayRoundWait"]) end
			if !valz["ColdWarPoints"] then data.cwpointssystem 					= nil else data.cwpointssystem 			= valz["ColdWarPoints"] end

			-- Mixed Rounds --
			if !valz["MixedSpawn1Enemy"] then data.mixedtype1 = "none" else data.mixedtype1 = valz["MixedSpawn1Enemy"] end
			if !valz["MixedSpawn2Enemy"] then data.mixedtype2 = "none" else data.mixedtype2 = valz["MixedSpawn2Enemy"] end
			if !valz["MixedSpawn3Enemy"] then data.mixedtype3 = "none" else data.mixedtype3 = valz["MixedSpawn3Enemy"] end
			if !valz["MixedSpawn4Enemy"] then data.mixedtype4 = "none" else data.mixedtype4 = valz["MixedSpawn4Enemy"] end

			if !valz["MixedSpawn1UseSpecial"] then data.mixedtype1usespecial 				= nil else data.mixedtype1usespecial 			= valz["MixedSpawn1UseSpecial"] end
			if !valz["MixedSpawn2UseSpecial"] then data.mixedtype2usespecial 				= nil else data.mixedtype2usespecial 			= valz["MixedSpawn2UseSpecial"] end
			if !valz["MixedSpawn3UseSpecial"] then data.mixedtype3usespecial 				= nil else data.mixedtype3usespecial 			= valz["MixedSpawn3UseSpecial"] end
			if !valz["MixedSpawn4UseSpecial"] then data.mixedtype4usespecial 				= nil else data.mixedtype4usespecial 			= valz["MixedSpawn4UseSpecial"] end

			if !valz["MixedSpawn1Chance"] 	then data.mixedtype1chance 						= 0 	else data.mixedtype1chance 			= tonumber(valz["MixedSpawn1Chance"]) 		end
			if !valz["MixedSpawn1Rnd"] 		then data.mixedtype1rnd 						= 0 	else data.mixedtype1rnd 			= tonumber(valz["MixedSpawn1Rnd"]) 			end
			if !valz["MixedSpawn1Mod"] 		then data.mixedtype1mod 						= 0.5 	else data.mixedtype1mod 			= tonumber(valz["MixedSpawn1Mod"]) 			end

			if !valz["MixedSpawn2Chance"] 	then data.mixedtype2chance 						= 0 	else data.mixedtype2chance 			= tonumber(valz["MixedSpawn2Chance"]) 		end
			if !valz["MixedSpawn2Rnd"] 		then data.mixedtype2rnd 						= 0 	else data.mixedtype2rnd 			= tonumber(valz["MixedSpawn2Rnd"]) 			end
			if !valz["MixedSpawn2Mod"] 		then data.mixedtype2mod 						= 0.5 	else data.mixedtype2mod 			= tonumber(valz["MixedSpawn2Mod"]) 			end
			
			if !valz["MixedSpawn3Chance"] 	then data.mixedtype3chance 						= 0 	else data.mixedtype3chance 			= tonumber(valz["MixedSpawn3Chance"]) 		end
			if !valz["MixedSpawn3Rnd"] 		then data.mixedtype3rnd 						= 0 	else data.mixedtype3rnd 			= tonumber(valz["MixedSpawn3Rnd"]) 			end
			if !valz["MixedSpawn3Mod"] 		then data.mixedtype3mod 						= 0.5 	else data.mixedtype3mod 			= tonumber(valz["MixedSpawn3Mod"]) 			end
			
			if !valz["MixedSpawn4Chance"] 	then data.mixedtype4chance 						= 0 	else data.mixedtype4chance 			= tonumber(valz["MixedSpawn4Chance"]) 		end
			if !valz["MixedSpawn4Rnd"] 		then data.mixedtype4rnd 						= 0 	else data.mixedtype4rnd 			= tonumber(valz["MixedSpawn4Rnd"]) 			end
			if !valz["MixedSpawn4Mod"] 		then data.mixedtype4mod 						= 0.5 	else data.mixedtype4mod 			= tonumber(valz["MixedSpawn4Mod"]) 			end
			-- Mixed Rounds --

			-- Catalyst/ZCT --
			if !valz["EnableBurningZombies"] then data.burning 				= nil else data.burning 			= valz["EnableBurningZombies"] end

			if !valz["BurningChance"] then data.burningchance 				= 50 else data.burningchance 		= tonumber(valz["BurningChance"]) end
			if !valz["BurningRnd"] then data.burningrnd 					= 13 else data.burningrnd 			= tonumber(valz["BurningRnd"]) end


			if !valz["RedChance"] then data.redchance 				= 85 else data.redchance 		= tonumber(valz["RedChance"]) end
			if !valz["RedRnd"] then data.redrnd 					= 2 else data.redrnd 			= tonumber(valz["RedRnd"]) end

			if !valz["BlueChance"] then data.bluechance 			= 85 else data.bluechance 		= tonumber(valz["BlueChance"]) end
			if !valz["BlueRnd"] then data.bluernd 					= 6 else data.bluernd 			= tonumber(valz["BlueRnd"]) end

			if !valz["GreenChance"] then data.greenchance 			= 85 else data.greenchance 		= tonumber(valz["GreenChance"]) end
			if !valz["GreenRnd"] then data.greenrnd 				= 14 else data.greenrnd 		= tonumber(valz["GreenRnd"]) end

			if !valz["YellowChance"] then data.yellowchance 		= 85 else data.yellowchance 	= tonumber(valz["YellowChance"]) end
			if !valz["YellowRnd"] then data.yellowrnd 				= 12 else data.yellowrnd 		= tonumber(valz["YellowRnd"]) end

			if !valz["PurpleChance"] then data.purplechance 		= 85 else data.purplechance 		= tonumber(valz["PurpleChance"]) end
			if !valz["PurpleRnd"] then data.purplernd 				= 16 else data.purplernd 			= tonumber(valz["PurpleRnd"]) end

			if !valz["PinkChance"] then data.pinkchance 			= 85 else data.pinkchance 		= tonumber(valz["PinkChance"]) end
			if !valz["PinkRnd"] then data.pinkrnd 					= 26 else data.pinkrnd 			= tonumber(valz["PinkRnd"]) end


			if !valz["PoisonChance"] then data.poisonchance 		= 20 else data.poisonchance 		= tonumber(valz["PoisonChance"]) end
			if !valz["PoisonRnd"] then data.poisonrnd 				= 10 else data.poisonrnd 			= tonumber(valz["PoisonRnd"]) end

			if !valz["WaterChance"] then data.waterchance 			= 5 else data.waterchance 			= tonumber(valz["WaterChance"]) end
			if !valz["WaterRnd"] then data.waterrnd 				= 12 else data.waterrnd 			= tonumber(valz["WaterRnd"]) end

			if !valz["FireChance"] then data.firechance 			= 15 else data.firechance 			= tonumber(valz["FireChance"]) end
			if !valz["FireRnd"] then data.firernd 					= 14 else data.firernd 				= tonumber(valz["FireRnd"]) end

			if !valz["ElectricChance"] then data.electricchance 	= 10 else data.electricchance 		= tonumber(valz["ElectricChance"]) end
			if !valz["ElectricRnd"] then data.electricrnd 			= 16 else data.electricrnd 			= tonumber(valz["ElectricRnd"]) end

			for k,v in pairs(nzSounds.struct) do
				if (valz["SndRow" .. k] == nil) then
					data[v] = {}
				else
					data[v] = valz["SndRow" .. k]
				end
			end

			nzMapping:SendMapData( data )
		end

		local color_grey_50 = Color(50, 50, 50)
		local color_grey_200 = Color(200, 200, 200)
		local color_red = Color(150, 50, 50)

		if (MapSDermaButton != nil) then
			MapSDermaButton:Remove()
		end

		MapSDermaButton = vgui.Create( "DButton", frame )
		MapSDermaButton:SetText( "Submit" )
		MapSDermaButton:SetPos( 10, 435 )
		MapSDermaButton:SetSize( 480, 30 )
		MapSDermaButton.DoClick = UpdateData

		------------------------------------------------------------------------
		//Box Weapons
		------------------------------------------------------------------------
		local function AddBoxWeaponStuff()
			local weplist = {}
			local numweplist = 0

			local rboxpanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Random Box", rboxpanel, "icon16/box.png", false, false, "Set which weapons appear in the Random Box.")
			rboxpanel.Paint = function() return end

			local rbweplist = vgui.Create("DScrollPanel", rboxpanel)
			rbweplist:SetPos(0, 110)
			rbweplist:SetSize(465, 250)
			rbweplist:SetPaintBackground(true)
			rbweplist:SetBackgroundColor(color_grey_200)

			local function InsertWeaponToList(name, class, weight, tooltip)
				weight = weight or 10
				if IsValid(weplist[class]) then return end
				weplist[class] = vgui.Create("DPanel", rbweplist)
				weplist[class]:SetSize(365, 16)
				weplist[class]:SetPos(0, numweplist*16)
				valz["RBoxWeps"][class] = weight

				local dname = vgui.Create("DLabel", weplist[class])
				dname:SetText(name)
				dname:SetTextColor(color_grey_50)
				dname:SetPos(5, 0)
				dname:SetSize(250, 16)
					
				local dhover = vgui.Create("DPanel", weplist[class])
				dhover.Paint = function() end
				dhover:SetText("")
				dhover:SetSize(365, 16)
				dhover:SetPos(0,0)
				if tooltip then
					dhover:SetTooltip(tooltip)
				end

				local dweight = vgui.Create("DNumberWang", weplist[class])
				dweight:SetPos(295, 1)
				dweight:SetSize(40, 14)
				dweight:SetTooltip("The chance of this weapon appearing in the box")
				dweight:SetMinMax( 1, 100 )
				dweight:SetValue(valz["RBoxWeps"][class])
				function dweight:OnValueChanged(val)
					valz["RBoxWeps"][class] = val
				end
					
				local ddelete = vgui.Create("DImageButton", weplist[class])
				ddelete:SetImage("icon16/delete.png")
				ddelete:SetPos(335, 0)
				ddelete:SetSize(16, 16)
				ddelete.DoClick = function()
					valz["RBoxWeps"][class] = nil
					weplist[class]:Remove()
					weplist[class] = nil
					local num = 0
					for k,v in pairs(weplist) do
						v:SetPos(0, num*16)
						num = num + 1
					end
					numweplist = numweplist - 1
				end

				numweplist = numweplist + 1
			end

			local boxproperties = vgui.Create( "DProperties", rboxpanel )
			boxproperties:SetSize(465, 105)
			boxproperties:SetPos(0, 0)

			local RBoxPrice =		boxproperties:CreateRow("Settings", "Random Box Price")
			local Row96 = 			boxproperties:CreateRow("Settings", "Minimum Box Uses")
			local Row97 = 			boxproperties:CreateRow("Settings", "Maximum Box Uses")
			local Row98 = 			boxproperties:CreateRow("Settings", "Maximum Starting Box Uses")
			local Row103 =			boxproperties:CreateRow("Settings", "Maximum Teddy Chance")

			Row96:Setup("Generic")
			Row96:SetValue(valz["Row96"])
			Row96.DataChanged = function( _, val ) valz["Row96"] = tonumber(val) end
			Row96:SetTooltip("How many times the Random Box can be used before there is a chance to roll Teddy. (Default 3)")

			Row97:Setup("Generic")
			Row97:SetValue(valz["Row97"])
			Row97.DataChanged = function( _, val ) valz["Row97"] = tonumber(val) end
			Row97:SetTooltip("How many times the Random Box can be used before every use has the maximum chance of Teddy. (Default 13)")

			Row98:Setup("Generic")
			Row98:SetValue(valz["Row98"])
			Row98.DataChanged = function( _, val ) valz["Row98"] = tonumber(val) end
			Row98:SetTooltip("How many times the starting Random Box can be used before it is forced to move, ONLY APPLIES TO FIRST BOX OF THE GAME. (Default 8)")

			Row103:Setup("Generic")
			Row103:SetValue(valz["Row103"])
			Row103.DataChanged = function( _, val ) valz["Row103"] = math.Round(tonumber(val)) end
			Row103:SetTooltip("Maximum percentage to roll Teddy. (Default 50%)")

			RBoxPrice:Setup("Generic")
			RBoxPrice:SetValue(valz["RBoxPrice"])
			RBoxPrice.DataChanged = function( _, val ) valz["RBoxPrice"] = tonumber(val) end
			RBoxPrice:SetTooltip("How much the a box spin costs. (Default 950)")

			local thefucker0 = boxproperties.Categories["Settings"]
			local resetsettins = vgui.Create("DButton", thefucker0)
			resetsettins:SetText("Reset")
			resetsettins:SetPos(65, 2)
			resetsettins:SetSize(40, 20)
			resetsettins.DoClick = function()
				Row96:SetValue(3)
				Row97:SetValue(13)
				Row98:SetValue(8)
				Row103:SetValue(50)
				RBoxPrice:SetValue(950)
				valz["Row96"] = 3
				valz["Row97"] = 13
				valz["Row98"] = 8
				valz["Row103"] = 50
				valz["RBoxPrice"] = 950
			end

			if nzMapping.Settings.rboxweps then
				for k,v in pairs(nzMapping.Settings.rboxweps) do
					local wep = weapons.Get(k)
					if wep then
						if wep.Category and wep.Category != "" then
							local special = wep.NZSpecialCategory and " ("..wep.NZSpecialCategory..")" or ""
							InsertWeaponToList(wep.PrintName != "" and wep.PrintName or k, k, v or 10, k.." ["..wep.Category.."]"..special)
						else
							InsertWeaponToList(wep.PrintName != "" and wep.PrintName or k, k, v or 10, k.." [No Category]")
						end
					end
				end
			else
				for k,v in pairs(WeaponList) do
					-- By default, add all weapons that have print names unless they are blacklisted
					if v.PrintName and v.PrintName != "" and !nzConfig.WeaponBlackList[v.ClassName] and v.PrintName != "Scripted Weapon" and !v.NZPreventBox and !v.NZTotalBlacklist then
						if v.Category and v.Category != "" then
							local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
							InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
							break
						else
							InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." [No Category]")
							break
						end
					end
					-- The rest are still available in the dropdown
				end
			end

			local wepentry = vgui.Create( "DButton", rboxpanel )
			local wepadd = vgui.Create( "DButton", rboxpanel )

			wepentry:SetPos( 0, 365 )
			wepentry:SetSize( 146, 20 )
			wepentry:SetText( "Weapon ..." )

			wepentry.DoClick = function( panel, index, value )
				nzTools:OpenWeaponSelectMenu(wepentry, wepadd, true)
			end

			wepadd:SetText( "Add" )
			wepadd:SetPos( 150, 365 )
			wepadd:SetSize( 53, 20 )
			wepadd.DoClick = function()
				local v = weapons.Get(wepentry.optionData)
				if v then
					if v.Category and v.Category != "" then
						local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
						InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
					else
						InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." [No Category]")
					end
				end
				wepentry:SetText( "Weapon..." )
			end

			local wepmore = vgui.Create( "DButton", rboxpanel )
			wepmore:SetText( "More ..." )
			wepmore:SetPos( 207, 365 )
			wepmore:SetSize( 53, 20 )
			wepmore.DoClick = function()
				local morepnl = vgui.Create("DFrame")
				morepnl:SetSize(300, 170)
				morepnl:SetTitle("More weapon options ...")
				morepnl:Center()
				morepnl:SetDraggable(true)
				morepnl:ShowCloseButton(true)
				morepnl:MakePopup()

				local morecat = vgui.Create("DComboBox", morepnl)
				morecat:SetSize(150, 20)
				morecat:SetPos(10, 30)
				local cattbl = {}
				for k,v in SortedPairsByMemberValue(WeaponList, "PrintName") do
					if v.Category and v.Category != "" then
						if !cattbl[v.Category] then
							morecat:AddChoice(v.Category, v.Category, false)
							cattbl[v.Category] = true
						end
					end
				end
				morecat:AddChoice(" Category ...", nil, true)

				local morecatadd = vgui.Create("DButton", morepnl)
				morecatadd:SetText( "Add all" )
				morecatadd:SetPos( 165, 30 )
				morecatadd:SetSize( 60, 20 )
				morecatadd.DoClick = function()
					local cat = morecat:GetOptionData(morecat:GetSelectedID())
					if cat and cat != "" then
						for k,v in SortedPairsByMemberValue(WeaponList, "PrintName") do
							if v.Category and v.Category == cat and !nzConfig.WeaponBlackList[v.ClassName] and !v.NZPreventBox and !v.NZTotalBlacklist then
								local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
								InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
							end
						end
					end
				end

				local morecatdel = vgui.Create("DButton", morepnl)
				morecatdel:SetText( "Remove all" )
				morecatdel:SetPos( 230, 30 )
				morecatdel:SetSize( 60, 20 )
				morecatdel.DoClick = function()
					local cat = morecat:GetOptionData(morecat:GetSelectedID())
					if cat and cat != "" then
						for k,v in pairs(weplist) do
							local wep = weapons.Get(k)
							if wep then
								if wep.Category and wep.Category == cat then
									valz["RBoxWeps"][k] = nil
									weplist[k]:Remove()
									weplist[k] = nil
									local num = 0
									for k,v in pairs(weplist) do
										v:SetPos(0, num*16)
										num = num + 1
									end
									numweplist = numweplist - 1
								end
							end
						end
					end
				end

				local moreprefix = vgui.Create("DComboBox", morepnl)
				moreprefix:SetSize(150, 20)
				moreprefix:SetPos(10, 60)
				local prefixtbl = {}
				for k,v in pairs(WeaponList) do
					local prefix = string.sub(v.ClassName, 0, string.find(v.ClassName, "_"))
					if prefix and !prefixtbl[prefix] then
						moreprefix:AddChoice(prefix, prefix, false)
						prefixtbl[prefix] = true
					end
				end
				moreprefix:AddChoice(" Prefix ...", nil, true)

				local moreprefixadd = vgui.Create("DButton", morepnl)
				moreprefixadd:SetText( "Add all" )
				moreprefixadd:SetPos( 165, 60 )
				moreprefixadd:SetSize( 60, 20 )
				moreprefixadd.DoClick = function()
					local prefix = moreprefix:GetOptionData(moreprefix:GetSelectedID())
					if prefix and prefix != "" then
						for k,v in SortedPairsByMemberValue(WeaponList, "PrintName") do
							local wepprefix = string.sub(v.ClassName, 0, string.find(v.ClassName, "_"))
							if wepprefix and wepprefix == prefix and !nzConfig.WeaponBlackList[v.ClassName] and !v.NZPreventBox and !v.NZTotalBlacklist then
								if v.Category and v.Category != "" then
									local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
									InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
								else
									InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." [No Category]")
								end
							end
						end
					end
				end

				local moreprefixdel = vgui.Create("DButton", morepnl)
				moreprefixdel:SetText( "Remove all" )
				moreprefixdel:SetPos( 230, 60 )
				moreprefixdel:SetSize( 60, 20 )
				moreprefixdel.DoClick = function()
					local prefix = moreprefix:GetOptionData(moreprefix:GetSelectedID())
					if prefix and prefix != "" then
						for k,v in pairs(weplist) do
							local wepprefix = string.sub(k, 0, string.find(k, "_"))
							if wepprefix and wepprefix == prefix then
								valz["RBoxWeps"][k] = nil
								weplist[k]:Remove()
								weplist[k] = nil
								local num = 0
								for k,v in pairs(weplist) do
									v:SetPos(0, num*16)
									num = num + 1
								end
								numweplist = numweplist - 1
							end
						end
					end
				end

				local removeall = vgui.Create("DButton", morepnl)
				removeall:SetText( "Remove all" )
				removeall:SetPos( 10, 100 )
				removeall:SetSize( 140, 25 )
				removeall.DoClick = function()
					for k,v in pairs(weplist) do
						valz["RBoxWeps"][k] = nil
						weplist[k]:Remove()
						weplist[k] = nil
						numweplist = 0
					end
				end

				local addall = vgui.Create("DButton", morepnl)
				addall:SetText( "Add all" )
				addall:SetPos( 150, 100 )
				addall:SetSize( 140, 25 )
				addall.DoClick = function()
					for k,v in pairs(weplist) do
						valz["RBoxWeps"][k] = nil
						weplist[k]:Remove()
						weplist[k] = nil
						numweplist = 0
					end
					for k,v in SortedPairsByMemberValue(WeaponList, "PrintName") do
						-- By default, add all weapons that have print names unless they are blacklisted
						if v.PrintName and v.PrintName != "" and !nzConfig.WeaponBlackList[v.ClassName] and v.PrintName != "Scripted Weapon" and !v.NZPreventBox and !v.NZTotalBlacklist then
							if v.Category and v.Category != "" then
								local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
								InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
							else
								InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." [No Category]")
							end
						end
						-- The same reset as when no random box list exists on server
					end
				end

				local reload = vgui.Create("DButton", morepnl)
				reload:SetText( "Reload from server" )
				reload:SetPos( 10, 130 )
				reload:SetSize( 280, 25 )
				reload.DoClick = function()
					-- Remove all and insert from random box list
					for k,v in pairs(weplist) do
						valz["RBoxWeps"][k] = nil
						weplist[k]:Remove()
						weplist[k] = nil
						numweplist = 0
					end
					if nzMapping.Settings.rboxweps then
						for k,v in pairs(nzMapping.Settings.rboxweps) do
							local wep = weapons.Get(v)
							if wep then
								if wep.Category and wep.Category != "" then
									local special = wep.NZSpecialCategory and " ("..wep.NZSpecialCategory..")" or ""
									InsertWeaponToList(wep.PrintName != "" and wep.PrintName or v, v, 10, v.." ["..v.Category.."]"..special)
								else
									InsertWeaponToList(wep.PrintName != "" and wep.PrintName or v, v, 10, v.." [No Category]")
								end
							end
						end
					end
				end
			end
		end

		------------------------------------------------------------------------
		//Gums
		------------------------------------------------------------------------
		local function AddGumStuff()
			local gumspanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Gobble Gums", gumspanel, "icon16/sport_8ball.png", false, false, "Set which gums can be rolled at the gobble gum machine.")
			gumspanel.Paint = function() return end

			local gumslistpanel = vgui.Create("DScrollPanel", gumspanel)
			gumslistpanel:SetPos(0, 145)
			gumslistpanel:SetSize(465, 250)
			gumslistpanel:SetPaintBackground(true)
			gumslistpanel:SetBackgroundColor( color_grey_200 )

			local gumschecklist = vgui.Create( "DIconLayout", gumslistpanel )
			gumschecklist:SetSize(465, 195)
			gumschecklist:SetPos(2, 2)
			gumschecklist:SetSpaceY( 5 )
			gumschecklist:SetSpaceX( 5 )

			local purpgum = {}
			local greengum = {}
			local oranggum = {}
			local bluegum = {}
			for k, v in SortedPairsByMemberValue(nzGum.Gums, "type", false) do
				if v.type == nzGum.Types.USABLE or v.type == nzGum.Types.USABLE_WITH_TIMER then
					purpgum[k] = (v.rare or nzGum.RareTypes.DEFAULT)
				end
				if v.type == nzGum.Types.TIME then
					greengum[k] = (v.rare or nzGum.RareTypes.DEFAULT)
				end
				if v.type == nzGum.Types.SPECIAL then
					oranggum[k] = (v.rare or nzGum.RareTypes.DEFAULT)
				end
				if v.type == nzGum.Types.ROUNDS then
					bluegum[k] = (v.rare or nzGum.RareTypes.DEFAULT)
				end
			end

			local sorted_gums = {}
			for k, v in SortedPairsByValue(purpgum) do
				sorted_gums[#sorted_gums + 1] = k
			end
			for k, v in SortedPairsByValue(greengum) do
				sorted_gums[#sorted_gums + 1] = k
			end
			for k, v in SortedPairsByValue(oranggum) do
				sorted_gums[#sorted_gums + 1] = k
			end
			for k, v in SortedPairsByValue(bluegum) do
				sorted_gums[#sorted_gums + 1] = k
			end

			for _, id in pairs(sorted_gums) do
				local data = nzGum.Gums[id]
				if not data then continue end

				local rarity = data.rare or nzGum.RareTypes.DEFAULT

				local gumdesc = "["..id.."]\n"..data.desc or "No Description Available"
				if nzGum:GetHowActivatesText(id) ~= "" then
					gumdesc = gumdesc.." ("..nzGum:GetHowActivatesText(id)..")"
				end

				local gumitem = gumschecklist:Add("DPanel")
				gumitem:SetSize(145, 40)
				gumitem:SetTooltip(gumdesc)

				local check = gumitem:Add("DCheckBox")
				check:SetPos(128,2)

				if (nzMapping.Settings.gumlist and istable(nzMapping.Settings.gumlist[id]) and isbool(nzMapping.Settings.gumlist[id][1])) then
					check:SetValue(nzMapping.Settings.gumlist[id][1])
				else
					if nzMapping.Settings.gumlist then
						nzMapping.Settings.gumlist[id] = {false, nzGum.RollCounts[rarity]}
					end
					check:SetValue(false)
				end

				check.OnChange = function(self, val)
					if !valz["GumsList"][id] then
						valz["GumsList"][id] = {false, nzGum.RollCounts[rarity]}
					end
					valz["GumsList"][id][1] = val
				end

				local name = gumitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(88, 20)
				name:SetPos(42,1)
				name:SetText(data.name)

				local text = gumitem:Add("DLabel")
				text:SetText(nzGum.RarityNames[rarity])
				text:SetFont("Trebuchet18")
				text:SetTextColor(color_red)
				text:SizeToContents()
				text:SetPos(42, 20)

				local icon = gumitem:Add("DImage")
				icon:SetPos(2, 2)
				icon:SetSize(38, 38)
				icon:SetMaterial(data.icon)

				local wang = gumitem:Add("DNumberWang")
				wang:SetSize(23, 18)
				wang:SetPos(120, 20)
				wang:SetMin(0)
				wang:SetMax(99)
				wang:SetDecimals(0)
				wang:SetValue(nzMapping.Settings.gumlist and nzMapping.Settings.gumlist[id][2] or nzGum.RollCounts[rarity])
				wang.OnValueChanged = function(val)
					timer.Simple(0, function()
						valz["GumsList"][id][2] = wang:GetValue()
					end)
				end
			end

			local gumproperties = vgui.Create( "DProperties", gumspanel )
			gumproperties:SetSize(455, 140)
			gumproperties:SetPos(0, 0)

			local gumsettings1 = gumproperties:CreateRow("Settings", "Max Player Gum Rolls")
			gumsettings1:Setup("Int", {min = 1, max = 99})
			gumsettings1:SetValue(valz["GumMaxUses"])
			gumsettings1.DataChanged = function( _, val ) valz["GumMaxUses"] = math.Clamp(math.Round(val), 1, 2096) end
			gumsettings1:SetTooltip("How many times the player can roll the gum machine in a single round (DEFAULT: 3).")

			local gumsettings2 = gumproperties:CreateRow("Settings", "Starting Gobble Gum Price")
			gumsettings2:Setup("Int", {min = 0, max = 1024500})
			gumsettings2:SetValue(valz["GumStartPrice"])
			gumsettings2.DataChanged = function( _, val ) valz["GumStartPrice"] = math.Round(val) end
			gumsettings2:SetTooltip("How much the first purchase of the gobble gum machine will cost.")

			local gumsettings3 = gumproperties:CreateRow("Settings", "Display Additional Gum Stats")
			gumsettings3:Setup("Boolean")
			gumsettings3:SetValue(valz["GumShowStats"])
			gumsettings3.DataChanged = function( _, val ) valz["GumShowStats"] = tobool(val) end
			gumsettings3:SetTooltip("Enable for the Gum Machine to display remaining player rolls, remaining amount of the currently rolled gum, and the total remaining gum count.")

			local thefucker0 = gumproperties.Categories["Settings"]
			local resetsettins = vgui.Create("DButton", thefucker0)
			resetsettins:SetText("Reset")
			resetsettins:SetPos(65, 2)
			resetsettins:SetSize(40, 20)
			resetsettins.DoClick = function()
				gumsettings1:SetValue(3)
				gumsettings2:SetValue(0)
				gumsettings3:SetValue(1)
				valz["GumMaxUses"] = 3
				valz["GumStartPrice"] = 0
				valz["GumShowStats"] = true
			end

			-- Round Resets ---------------------------------------------------------------------
			local gumrow1 = gumproperties:CreateRow("Gum refill round intervals", "Normal")
			gumrow1:Setup("Int", { min = 1, max = 255 })
			gumrow1:SetValue(valz["GumResetRounds"][nzGum.RareTypes.DEFAULT])
			gumrow1.DataChanged = function( _, val ) valz["GumResetRounds"][nzGum.RareTypes.DEFAULT] = math.max(val, 1) end
			gumrow1:SetTooltip("How many rounds it takes for a 'Normal' rarity gum to refill (DEFAULT: 4).")

			local gumrow2 = gumproperties:CreateRow("Gum refill round intervals", "Mega")
			gumrow2:Setup("Int", { min = 1, max = 255 })
			gumrow2:SetValue(valz["GumResetRounds"][nzGum.RareTypes.MEGA])
			gumrow2.DataChanged = function( _, val ) valz["GumResetRounds"][nzGum.RareTypes.MEGA] = math.max(val, 1) end
			gumrow2:SetTooltip("How many rounds it takes for a 'Mega' rarity gum to refill (DEFAULT: 4).")

			local gumrow3 = gumproperties:CreateRow("Gum refill round intervals", "Rare Mega")
			gumrow3:Setup("Int", { min = 1, max = 255 })
			gumrow3:SetValue(valz["GumResetRounds"][nzGum.RareTypes.RAREMEGA])
			gumrow3.DataChanged = function( _, val ) valz["GumResetRounds"][nzGum.RareTypes.RAREMEGA] = math.max(val, 1) end
			gumrow3:SetTooltip("How many rounds it takes for a 'Rare Mega' rarity gum to refill (DEFAULT: 6).")

			local gumrow4 = gumproperties:CreateRow("Gum refill round intervals", "Ultra Rare Mega")
			gumrow4:Setup("Int", { min = 1, max = 255 })
			gumrow4:SetValue(valz["GumResetRounds"][nzGum.RareTypes.ULTRARAREMEGA])
			gumrow4.DataChanged = function( _, val ) valz["GumResetRounds"][nzGum.RareTypes.ULTRARAREMEGA] = math.max(val, 1) end
			gumrow4:SetTooltip("How many rounds it takes for a 'Ultra Rare Mega' rarity gum to refill (DEFAULT: 8).")

			local gumrow5 = gumproperties:CreateRow("Gum refill round intervals", "Whimsical")
			gumrow5:Setup("Int", { min = 1, max = 255 })
			gumrow5:SetValue(valz["GumResetRounds"][nzGum.RareTypes.PINWHEEL])
			gumrow5.DataChanged = function( _, val ) valz["GumResetRounds"][nzGum.RareTypes.PINWHEEL] = math.max(val, 1) end
			gumrow5:SetTooltip("How many rounds it takes for a 'Whimsical' rarity gum to refill (DEFAULT: 2).")

			local thefucker1 = gumproperties.Categories["Gum refill round intervals"]
			local resetrounds = vgui.Create("DButton", thefucker1)
			resetrounds:SetText("Reset")
			resetrounds:SetPos(145, 2)
			resetrounds:SetSize(40, 20)
			resetrounds.DoClick = function()
				valz["GumResetRounds"] = {
					[nzGum.RareTypes.DEFAULT] = 4,
					[nzGum.RareTypes.MEGA] = 4,
					[nzGum.RareTypes.RAREMEGA] = 6,
					[nzGum.RareTypes.ULTRARAREMEGA] = 8,
					[nzGum.RareTypes.PINWHEEL] = 2,
				}
				gumrow1:SetValue(4)
				gumrow2:SetValue(4)
				gumrow3:SetValue(6)
				gumrow4:SetValue(8)
				gumrow5:SetValue(2)
			end

			-- Chance Modifiers ---------------------------------------------------------------------
			local gumultrow1 = gumproperties:CreateRow("Gum chance multipliers", "Normal")
			gumultrow1:Setup("Float", { min = 0.01, max = 1 })
			gumultrow1:SetValue(valz["GumChanceMults"][nzGum.RareTypes.DEFAULT])
			gumultrow1.DataChanged = function( _, val ) valz["GumChanceMults"][nzGum.RareTypes.DEFAULT] = val end
			gumultrow1:SetTooltip("'Normal' rarity gum chances are multiplied by this value before rolling (DEFAULT: 1).")

			local gumultrow2 = gumproperties:CreateRow("Gum chance multipliers", "Mega")
			gumultrow2:Setup("Float", { min = 0.01, max = 1 })
			gumultrow2:SetValue(valz["GumChanceMults"][nzGum.RareTypes.MEGA])
			gumultrow2.DataChanged = function( _, val ) valz["GumChanceMults"][nzGum.RareTypes.MEGA] = val end
			gumultrow2:SetTooltip("'Mega' rarity gum chances are multiplied by this value before rolling (DEFAULT: 0.4).")

			local gumultrow3 = gumproperties:CreateRow("Gum chance multipliers", "Rare Mega")
			gumultrow3:Setup("Float", { min = 0.01, max = 1 })
			gumultrow3:SetValue(valz["GumChanceMults"][nzGum.RareTypes.RAREMEGA])
			gumultrow3.DataChanged = function( _, val ) valz["GumChanceMults"][nzGum.RareTypes.RAREMEGA] = val end
			gumultrow3:SetTooltip("'Rare Mega' rarity gum chances are multiplied by this value before rolling (DEFAULT: 0.2).")

			local gumultrow4 = gumproperties:CreateRow("Gum chance multipliers", "Ultra Rare Mega")
			gumultrow4:Setup("Float", { min = 0.01, max = 1 })
			gumultrow4:SetValue(valz["GumChanceMults"][nzGum.RareTypes.ULTRARAREMEGA])
			gumultrow4.DataChanged = function( _, val ) valz["GumChanceMults"][nzGum.RareTypes.ULTRARAREMEGA] = val end
			gumultrow4:SetTooltip("'Ultra Rare Mega' rarity gum chances are multiplied by this value before rolling (DEFAULT: 0.1).")

			local gumultrow5 = gumproperties:CreateRow("Gum chance multipliers", "Whimsical")
			gumultrow5:Setup("Float", { min = 0.01, max = 1 })
			gumultrow5:SetValue(valz["GumChanceMults"][nzGum.RareTypes.PINWHEEL])
			gumultrow5.DataChanged = function( _, val ) valz["GumChanceMults"][nzGum.RareTypes.PINWHEEL] = val end
			gumultrow5:SetTooltip("'Whimsical' rarity gum chances are multiplied by this value before rolling (DEFAULT: 0.2).")

			local thefucker2 = gumproperties.Categories["Gum chance multipliers"]
			local resetmults = vgui.Create("DButton", thefucker2)
			resetmults:SetText("Reset")
			resetmults:SetPos(135, 2)
			resetmults:SetSize(40, 20)
			resetmults.DoClick = function()
				valz["GumChanceMults"] = {
					[nzGum.RareTypes.DEFAULT] = 1,
					[nzGum.RareTypes.MEGA] = 0.4,
					[nzGum.RareTypes.RAREMEGA] = 0.2,
					[nzGum.RareTypes.ULTRARAREMEGA] = 0.1,
					[nzGum.RareTypes.PINWHEEL] = 0.1,
				}
				gumultrow1:SetValue(1)
				gumultrow2:SetValue(0.4)
				gumultrow3:SetValue(0.2)
				gumultrow4:SetValue(0.1)
				gumultrow5:SetValue(0.3)
			end

			-- Gum Prices ---------------------------------------------------------------------
			local gumprice1 = gumproperties:CreateRow("Gum machine prices", "Rounds 1-9")
			gumprice1:Setup("Int", { min = 1, max = 1024500 })
			gumprice1:SetValue(valz["GumRoundPrices"][1])
			gumprice1.DataChanged = function( _, val ) valz["GumRoundPrices"][1] = val end
			gumprice1:SetTooltip("Gobbel Gum machine price for rounds 1-9 (DEFAULT: 1500).")

			local gumprice2 = gumproperties:CreateRow("Gum machine prices", "Rounds 10-19")
			gumprice2:Setup("Int", { min = 1, max = 1024500 })
			gumprice2:SetValue(valz["GumRoundPrices"][2])
			gumprice2.DataChanged = function( _, val ) valz["GumRoundPrices"][2] = val end
			gumprice2:SetTooltip("Gobbel Gum machine price for rounds 10-19 (DEFAULT: 2500).")

			local gumprice3 = gumproperties:CreateRow("Gum machine prices", "Rounds 20-29")
			gumprice3:Setup("Int", { min = 1, max = 1024500 })
			gumprice3:SetValue(valz["GumRoundPrices"][3])
			gumprice3.DataChanged = function( _, val ) valz["GumRoundPrices"][3] = val end
			gumprice3:SetTooltip("Gobbel Gum machine price for rounds 20-29 (DEFAULT: 4500).")

			local gumprice4 = gumproperties:CreateRow("Gum machine prices", "Rounds 3-39")
			gumprice4:Setup("Int", { min = 1, max = 1024500 })
			gumprice4:SetValue(valz["GumRoundPrices"][4])
			gumprice4.DataChanged = function( _, val ) valz["GumRoundPrices"][4] = val end
			gumprice4:SetTooltip("Gobbel Gum machine price for rounds 30-39 (DEFAULT: 9500).")

			local gumprice5 = gumproperties:CreateRow("Gum machine prices", "Rounds 40-49")
			gumprice5:Setup("Int", { min = 1, max = 1024500 })
			gumprice5:SetValue(valz["GumRoundPrices"][5])
			gumprice5.DataChanged = function( _, val ) valz["GumRoundPrices"][5] = val end
			gumprice5:SetTooltip("Gobbel Gum machine price for rounds 40-49 (DEFAULT: 16500).")

			local gumprice6 = gumproperties:CreateRow("Gum machine prices", "Rounds 50-59")
			gumprice6:Setup("Int", { min = 1, max = 1024500 })
			gumprice6:SetValue(valz["GumRoundPrices"][6])
			gumprice6.DataChanged = function( _, val ) valz["GumRoundPrices"][6] = val end
			gumprice6:SetTooltip("Gobbel Gum machine price for rounds 50-59 (DEFAULT: 32500).")

			local gumprice7 = gumproperties:CreateRow("Gum machine prices", "Rounds 60-69")
			gumprice7:Setup("Int", { min = 1, max = 1024500 })
			gumprice7:SetValue(valz["GumRoundPrices"][7])
			gumprice7.DataChanged = function( _, val ) valz["GumRoundPrices"][7] = val end
			gumprice7:SetTooltip("Gobbel Gum machine price for rounds 60-69 (DEFAULT: 64500).")

			local gumprice8 = gumproperties:CreateRow("Gum machine prices", "Rounds 70-79")
			gumprice8:Setup("Int", { min = 1, max = 1024500 })
			gumprice8:SetValue(valz["GumRoundPrices"][8])
			gumprice8.DataChanged = function( _, val ) valz["GumRoundPrices"][8] = val end
			gumprice8:SetTooltip("Gobbel Gum machine price for rounds 70-79 (DEFAULT: 128500).")

			local gumprice9 = gumproperties:CreateRow("Gum machine prices", "Rounds 80-89")
			gumprice9:Setup("Int", { min = 1, max = 1024500 })
			gumprice9:SetValue(valz["GumRoundPrices"][9])
			gumprice9.DataChanged = function( _, val ) valz["GumRoundPrices"][9] = val end
			gumprice9:SetTooltip("Gobbel Gum machine price for rounds 80-89 (DEFAULT: 256500).")

			local gumprice10 = gumproperties:CreateRow("Gum machine prices", "Rounds 90-99")
			gumprice10:Setup("Int", { min = 1, max = 1024500 })
			gumprice10:SetValue(valz["GumRoundPrices"][10])
			gumprice10.DataChanged = function( _, val ) valz["GumRoundPrices"][10] = val end
			gumprice10:SetTooltip("Gobbel Gum machine price for rounds 90-99 (DEFAULT: 512500).")

			local gumprice11 = gumproperties:CreateRow("Gum machine prices", "Rounds 100-255")
			gumprice11:Setup("Int", { min = 1, max = 1024500 })
			gumprice11:SetValue(valz["GumRoundPrices"][11])
			gumprice11.DataChanged = function( _, val ) valz["GumRoundPrices"][11] = val end
			gumprice11:SetTooltip("Gobbel Gum machine price for rounds 100-255 (DEFAULT: 1024500).")
		
			local thefucker3 = gumproperties.Categories["Gum machine prices"]
			local resetprices = vgui.Create("DButton", thefucker3)
			resetprices:SetText("Reset")
			resetprices:SetPos(120, 2)
			resetprices:SetSize(40, 20)
			resetprices.DoClick = function()
				valz["GumRoundPrices"] = {
					[1] = 1500, //1-9
					[2] = 2500, //10-19
					[3] = 4500, //20-29
					[4] = 9500, //30-39
					[5] = 16500, //40-49
					[6] = 32500, //50-59
					[7] = 64500, //60-69
					[8] = 128500, //70-79
					[9] = 256500, //80-89
					[10] = 512500, //90-99
					[11] = 1024500, //100-255
				}
				gumprice1:SetValue(1500)
				gumprice2:SetValue(2500)
				gumprice3:SetValue(4500)
				gumprice4:SetValue(9500)
				gumprice5:SetValue(16500)
				gumprice6:SetValue(32500)
				gumprice7:SetValue(64500)
				gumprice8:SetValue(128500)
				gumprice9:SetValue(256500)
				gumprice10:SetValue(512500)
				gumprice11:SetValue(1024500)
			end
		end

		------------------------------------------------------------------------
		//Perks
		------------------------------------------------------------------------
		local function AddWunderfizzStuff()
			local perkpanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Wunderfizz", perkpanel, "icon16/drink.png", false, false, "Set which perks appears in Der Wunderfizz.")
			perkpanel.Paint = function() return end

			local perklistpnl = vgui.Create("DScrollPanel", perkpanel)
			perklistpnl:SetPos(0, 130)
			perklistpnl:SetSize(475, 265)
			perklistpnl:SetPaintBackground(true)
			perklistpnl:SetBackgroundColor( color_grey_200 )

			local perkchecklist = vgui.Create( "DIconLayout", perklistpnl )
			perkchecklist:SetSize( 475, 265 )
			perkchecklist:SetPos( 5, 0 )
			perkchecklist:SetSpaceY( 5 )
			perkchecklist:SetSpaceX( 5 )

			for k, v in SortedPairsByMemberValue(wunderfizzlist, 2) do
				local perkdata = nzPerks:Get(k)
				if perkdata == nil then continue end

				local perkitem = perkchecklist:Add("DPanel")
				perkitem:SetSize( 148, 42 )

				local text = "["..tostring(k).."]"
				if perkdata.desc then
					text = text.."\nBase: "..perkdata.desc
					if perkdata.desc2 then
						text = text.."\nModifier: "..perkdata.desc2
					end
				end
				perkitem:SetTooltip(text)

				local check = perkitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.wunderfizzperklist and istable(nzMapping.Settings.wunderfizzperklist[k]) and isbool(nzMapping.Settings.wunderfizzperklist[k][1])) then
					check:SetValue(nzMapping.Settings.wunderfizzperklist[k][1])
				else
					check:SetValue(true)
				end

				check.OnChange = function(self, val)
					if !valz["Wunderfizz"][k] then
						valz["Wunderfizz"][k] = {false, perkdata.name}
					end
					valz["Wunderfizz"][k][1] = val
				end

				local icon = perkitem:Add("DImage")
				icon:SetPos(108, 2)
				icon:SetSize(38, 38)
				icon:SetMaterial(GetPerkIconMaterial(k))

				local name = perkitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(v[2])
			end

			local perkproperties = vgui.Create( "DProperties", perkpanel )
			perkproperties:SetSize(455, 125)
			perkproperties:SetPos(0, 0)

			local perksetting1 = perkproperties:CreateRow("Settings", "Enable Cold War Wunderfizz" )
			perksetting1:Setup("Boolean")
			perksetting1:SetValue(valz["Row78"])
			perksetting1.DataChanged = function( _, val ) valz["Row78"] = tobool(val) end
			perksetting1:SetTooltip("Enable for CW styled wunderfizz machine functionality.")

			local perksetting2 = perkproperties:CreateRow("Settings", "Wunderfizz Tax" )
			perksetting2:Setup("Int", {min = 0, max = 10000})
			perksetting2:SetValue(valz["Row79"])
			perksetting2.DataChanged = function( _, val ) valz["Row79"] = val end
			perksetting2:SetTooltip("The additional cost ontop of each perks price for buying it from the Cold War Wunderfizz. (Default 1000)")

			local perksetting6 = perkproperties:CreateRow("Settings", "Wunderfizz Activation Round")
			perksetting6:Setup("Generic")
			perksetting6:SetValue(valz["Row85"])
			perksetting6.DataChanged = function( _, val ) valz["Row85"] = tonumber(val) end
			perksetting6:SetTooltip("What round the Cold War Wunderfizz becomes usable. (Default 15)")

			local perksetting3 = perkproperties:CreateRow("Settings", "Wunderfizz Perk Slot" )
			perksetting3:Setup("Boolean")
			perksetting3:SetValue(valz["Row80"])
			perksetting3.DataChanged = function( _, val ) valz["Row80"] = tobool(val) end
			perksetting3:SetTooltip("Enable to be able to purchase perk slots from the Cold War Wunderfizz.")

			local perksetting4 = perkproperties:CreateRow("Settings", "Wunderfizz Perk Slot Price" )
			perksetting4:Setup("Generic")
			perksetting4:SetValue(valz["Row81"])
			perksetting4.DataChanged = function( _, val ) valz["Row81"] = val end
			perksetting4:SetTooltip("How much buying a perk slot from the CW fizz costs. (Default 10000)")

			local perksetting5 = perkproperties:CreateRow("Settings", "Wunderfizz Perk Slot Activation Round" )
			perksetting5:Setup("Generic")
			perksetting5:SetValue(valz["Row82"])
			perksetting5.DataChanged = function( _, val ) valz["Row82"] = tonumber(val) end
			perksetting5:SetTooltip("What round the perk slot becomes available to purchase from the CW fizz. (Default 20)")

			local thefucker0 = perkproperties.Categories["Settings"]
			local resetperks = vgui.Create("DButton", thefucker0)
			resetperks:SetText("Reset")
			resetperks:SetPos(65, 2)
			resetperks:SetSize(40, 20)
			resetperks.DoClick = function()
				perksetting1:SetValue(0)
				perksetting2:SetValue(1000)
				perksetting3:SetValue(0)
				perksetting4:SetValue(10000)
				perksetting5:SetValue(20)
				valz["Row78"] = false
				valz["Row79"] = 1000
				valz["Row80"] = false
				valz["Row81"] = 10000
				valz["Row82"] = 20
			end
		end

		------------------------------------------------------------------------
		//PowerUps
		------------------------------------------------------------------------
		local function AddPowerupStuff()
			local poweruppanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Powerups", poweruppanel, "icon16/asterisk_orange.png", false, false, "Set which powerups can be dropped from zombies.")
			poweruppanel.Paint = function() return end

			local poweruplistpnl = vgui.Create("DScrollPanel", poweruppanel)
			poweruplistpnl:SetPos(0, 110)
			poweruplistpnl:SetSize(475, 285)
			poweruplistpnl:SetPaintBackground(true)
			poweruplistpnl:SetBackgroundColor( color_grey_200 )

			local powerupchecklist = vgui.Create( "DIconLayout", poweruplistpnl )
			powerupchecklist:SetSize( 475, 285 )
			powerupchecklist:SetPos( 5, 0 )
			powerupchecklist:SetSpaceY( 5 )
			powerupchecklist:SetSpaceX( 5 )

			local locals = {}
			local globals = {}
			for k, v in pairs(poweruplist) do
				local pdata = nzPowerUps:Get(k)
				if pdata.global then
					globals[k] = pdata.name
				else
					locals[k] = pdata.name
				end
			end

			local sorted_powerups = {}
			for k, v in SortedPairsByValue(locals) do
				sorted_powerups[#sorted_powerups + 1] = k
			end
			for k, v in SortedPairsByValue(globals) do
				sorted_powerups[#sorted_powerups + 1] = k
			end

			for _, k in pairs(sorted_powerups) do
				local powerupdata = nzPowerUps:Get(k)

				local powerupitem = powerupchecklist:Add("DPanel")
				powerupitem:SetSize( 148, 42 )

				local text = "["..tostring(k).."]"
				if powerupdata.desc then
					text = text.."\nDefault: "..powerupdata.desc
					if powerupdata.duration and powerupdata.duration > 0 then
						text = text.." ("..powerupdata.duration.."s)"
					end
					if powerupdata.antidesc then
						text = text.."\nAnti: "..powerupdata.antidesc
					end
					if powerupdata.antiduration and powerupdata.antiduration > 0 then
						text = text.." ("..powerupdata.antiduration.."s)"
					end
				end
				powerupitem:SetTooltip(text)

				local check = powerupitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.poweruplist and istable(nzMapping.Settings.poweruplist[k]) and isbool(nzMapping.Settings.poweruplist[k][1])) then
					check:SetValue(nzMapping.Settings.poweruplist[k][1])
				else
					check:SetValue(true)
				end

				check.OnChange = function(self, val)
					if !valz["PowerUps"][k] then
						valz["PowerUps"][k] = {false, powerupdata.name}
					end
					valz["PowerUps"][k][1] = val
				end

				local icon = powerupitem:Add("DImage")
				icon:SetPos(108, 2)
				icon:SetSize(38, 38)
				icon:SetMaterial(GetPowerupIconMaterial(k))
				if nzMapping.Settings.powerupcol then
				local col_vec = powerupdata.global and nzMapping.Settings.powerupcol["global"][1] or nzMapping.Settings.powerupcol["local"][1]
				local desca = powerupitem:Add("DLabel")
				desca:SetTextColor(Color(255*col_vec[1], 255*col_vec[2], 255*col_vec[3]))
				desca:SetSize(60, 20)
				desca:SetPos(3,24)
				desca:SetFont("Trebuchet18")
				desca:SetText(powerupdata.global and "Global" or "Local")
				
				
				local descb = powerupitem:Add("DLabel")
				descb:SetTextColor(desca:GetTextColor())
				descb:SetSize(60, 20)
				descb:SetPos(5,24)
				descb:SetFont("Trebuchet18")
				descb:SetText(desca:GetText())

				local descc = powerupitem:Add("DLabel")
				descc:SetTextColor(desca:GetTextColor())
				descc:SetSize(60, 20)
				descc:SetPos(4,25)
				descc:SetFont("Trebuchet18")
				descc:SetText(desca:GetText())

				local descd = powerupitem:Add("DLabel")
				descd:SetTextColor(desca:GetTextColor())
				descd:SetSize(60, 20)
				descd:SetPos(4,23)
				descd:SetFont("Trebuchet18")
				descd:SetText(desca:GetText())

				local desc = powerupitem:Add("DLabel")
				desc:SetTextColor(color_grey_50)
				desc:SetSize(60, 20)
				desc:SetPos(4,24)
				desc:SetFont("Trebuchet18")
				desc:SetText(desca:GetText())

				local name = powerupitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(powerupdata.name)

				local wang = powerupitem:Add("DNumberWang")
				wang:SetSize(28, 18)
				wang:SetPos(80, 20)
				wang:SetMin(0)
				wang:SetMax(1000)
				wang:SetDecimals(0)
				wang:SetValue(nzMapping.Settings.poweruprounds and nzMapping.Settings.poweruprounds[k] or poweruprounds[k])
				wang:SetTooltip("Activation round number.")
				wang.OnValueChanged = function(val)
					timer.Simple(0, function()
						valz["PowerUpRounds"][k] = wang:GetValue()
					end)
				end
			end
end
			local vultures = {}
			for k, v in pairs(vulturelist) do
				vultures[k] = v[2] or "error"
			end

			local sorted_vultures = {}
			for k, v in SortedPairsByValue(vultures) do
				sorted_vultures[#sorted_vultures + 1] = k
			end

			for _, k in pairs(sorted_vultures) do
				local vulturedata = nzPerks:GetVultureDrop(k)

				local vultureitem = powerupchecklist:Add("DPanel")
				vultureitem:SetSize( 148, 42 )

				local text = "["..tostring(k).."]"
				if vulturedata.desc then
					text = text.."\n"..vulturedata.desc
					if vulturedata.timer and vulturedata.timer > 0 then
						text = text.." ("..vulturedata.timer.."s timer)"
					end
				end
				vultureitem:SetTooltip(text)

				local check = vultureitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.vulturelist and istable(nzMapping.Settings.vulturelist[k]) and isbool(nzMapping.Settings.vulturelist[k][1])) then
					check:SetValue(nzMapping.Settings.vulturelist[k][1])
				else
					check:SetValue(true)
				end

				check.OnChange = function(self, val)
					if !valz["VultureDrops"][k] then
						valz["VultureDrops"][k] = {false, vulturedata.name or string.NiceName(k)}
					end
					valz["VultureDrops"][k][1] = val
				end

				local icona = vultureitem:Add("DImage")
				icona:SetPos(108, 2)
				icona:SetSize(38, 38)
				icona:SetMaterial(GetPerkFrameMaterial())

				if !vulturedata.nodraw then
					local icon = vgui.Create("SpawnIcon" , vultureitem)
					icon:SetPos(110, 2)
					icon:SetSize(32, 32)
					icon:SetModel(vulturedata.model)
				end
				if nzMapping.Settings.powerupcol then
				local col_vec = nzMapping.Settings.powerupcol["mini"][1]
				local desca = vultureitem:Add("DLabel")
				desca:SetTextColor(Color(255*col_vec[1], 255*col_vec[2], 255*col_vec[3]))
				desca:SetSize(60, 20)
				desca:SetPos(3,24)
				desca:SetFont("Trebuchet18")
				desca:SetText("Vulture")

				local descb = vultureitem:Add("DLabel")
				descb:SetTextColor(desca:GetTextColor())
				descb:SetSize(60, 20)
				descb:SetPos(5,24)
				descb:SetFont("Trebuchet18")
				descb:SetText(desca:GetText())

				local descc = vultureitem:Add("DLabel")
				descc:SetTextColor(desca:GetTextColor())
				descc:SetSize(60, 20)
				descc:SetPos(4,25)
				descc:SetFont("Trebuchet18")
				descc:SetText(desca:GetText())

				local descd = vultureitem:Add("DLabel")
				descd:SetTextColor(desca:GetTextColor())
				descd:SetSize(60, 20)
				descd:SetPos(4,23)
				descd:SetFont("Trebuchet18")
				descd:SetText(desca:GetText())

				local desc = vultureitem:Add("DLabel")
				desc:SetTextColor(color_grey_50)
				desc:SetSize(60, 20)
				desc:SetPos(4,24)
				desc:SetFont("Trebuchet18")
				desc:SetText(desca:GetText())

				local name = vultureitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(vulturedata.name or string.NiceName(k))
			end
end
			local pproperties = vgui.Create( "DProperties", poweruppanel )
			pproperties:SetSize(455, 105)
			pproperties:SetPos(0, 0)

			local Row99 = pproperties:CreateRow("Settings", "Enable Round Based Power-Ups")
			Row99:Setup("Boolean")
			Row99:SetValue(valz["Row99"])
			Row99.DataChanged = function( _, val ) valz["Row99"] = tobool(val) end
			Row99:SetTooltip("Enable for Power-Ups to only spawn after X amount of rounds.")

			local Row102 = pproperties:CreateRow("Settings", "Max Power-Ups Per Round")
			Row102:Setup("Generic")
			Row102:SetValue(valz["Row102"])
			Row102.DataChanged = function( _, val ) valz["Row102"] = tonumber(val) end
			Row102:SetTooltip("How many Power-Ups can spawn naturally in a single round.")

			local Row66 = pproperties:CreateRow("Settings", "Enable Anti Power-Ups")
			Row66:Setup("Boolean")
			Row66:SetValue(valz["Row66"])
			Row66.DataChanged = function( _, val ) valz["Row66"] = tobool(val) end
			Row66:SetTooltip("Enable anti Power-Ups spawning on this config")

			local Row67 = pproperties:CreateRow("Settings", "Max Anti Power-Ups Chance")
			Row67:Setup("Generic")
			Row67:SetValue(valz["Row67"])
			Row67.DataChanged = function( _, val ) valz["Row67"] = tonumber(val) end
			Row67:SetTooltip("How many Power-Ups to spawn before having a 100% chance of an Anti Power-Up. (Default 40)")

			local Row68 = pproperties:CreateRow("Settings", "Power-Up Count Before Anti Power-Ups")
			Row68:Setup("Generic")
			Row68:SetValue(valz["Row68"])
			Row68.DataChanged = function( _, val ) valz["Row68"] = tonumber(val) end
			Row68:SetTooltip("Amount of Power-Ups that must be picked up before Anti Power-Ups have a chance to start spawning. (Default is 2)")

			local Row69 = pproperties:CreateRow("Settings", "Anti Power-Up Spawn Delay")
			Row69:Setup("Generic")
			Row69:SetValue(valz["Row69"])
			Row69.DataChanged = function( _, val ) valz["Row69"] = tonumber(val) end
			Row69:SetTooltip("Time (in seconds) it takes for Anti Power-Ups to activate after spawning. (Default is 4)")
		
			local thefucker0 = pproperties.Categories["Settings"]
			local resetpowerups = vgui.Create("DButton", thefucker0)
			resetpowerups:SetText("Reset")
			resetpowerups:SetPos(65, 2)
			resetpowerups:SetSize(40, 20)
			resetpowerups.DoClick = function()
				Row99:SetValue(0)
				Row66:SetValue(0)
				Row67:SetValue(40)
				Row68:SetValue(2)
				Row69:SetValue(4)
				valz["Row99"] = false
				valz["Row66"] = false
				valz["Row67"] = 40
				valz["Row68"] = 2
				valz["Row69"] = 4
			end
		end

		//getting around the 200 local var limit
		AddBoxWeaponStuff()
		AddWunderfizzStuff()
		AddPowerupStuff()
		AddGumStuff()

		------------------Sound Chooser----------------------------
		-- So we can create the elements in a loop
		local SndMenuMain = { 
			[1] = {
				["Title"] = "Round Start",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow1"]
			},
			[2] = {
				["Title"] = "Round End",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow2"]
			},
			[3] = {
				["Title"] = "Special Round Start",
				["ToolTip"] = "Eg. Dog Round",
				["Bind"] = valz["SndRow3"]
			},
			[4] = {
				["Title"] = "Special Round End",
				["ToolTip"] = "Eg. Dog Round",
				["Bind"] = valz["SndRow4"]
			},
			[5] = {
				["Title"] = "Dog Round",
				["ToolTip"] = "ONLY for dog rounds!",
				["Bind"] = valz["SndRow5"]
			},
			[6] = {
				["Title"] = "Game Over",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow6"]
			},
			[7] = {
				["Title"] = "Easter Egg Song",
				["ToolTip"] = "Remember to sail the seas safely",
				["Bind"] = valz["SndRow24"]
			},
			[8] = {
				["Title"] = "Pack-A-Punch Sound",
				["ToolTip"] = "Pap weapon shoot sound",
				["Bind"] = valz["SndRow25"]
			},
			[9] = {
				["Title"] = "First Round Start",
				["ToolTip"] = "Round music to play on the first round.",
				["Bind"] = valz["SndRow28"]
			},
			[10] = {
				["Title"] = "Purchase Sound",
				["ToolTip"] = "Sound that plays upon the player buying things.",
				["Bind"] = valz["SndRow39"]
			},
			[11] = {
				["Title"] = "Power On Sound",
				["ToolTip"] = "Sound that plays upon the Power being turned on.",
				["Bind"] = valz["SndRow40"]
			},
			[12] = {
				["Title"] = "Who's Who Looper",
				["ToolTip"] = "Sound that plays when Who's Who teleport is used.",
				["Bind"] = valz["SndRow41"]
			},
			[13] = {
				["Title"] = "Kaboom Sound",
				["ToolTip"] = "Sound that plays on all clients when a nuke Power-Up is picked up.",
				["Bind"] = valz["SndRow44"]
			},
			[14] = {
				["Title"] = "Sky Intro Sound",
				["ToolTip"] = "Sound that plays during the Modern Warfare 3 Survival intro animation.",
				["Bind"] = valz["SndRow47"]
			},
			--[[[10] = {
				["Title"] = "Round Underscore Song",
				["ToolTip"] = "Music that plays during normal rounds.(Can have multiple)",
				["Bind"] = valz["SndRow32"]
			},
			[11] = {
				["Title"] = "Special Round Underscore Song",
				["ToolTip"] = "Music that plays during special rounds.(Can have multiple)",
				["Bind"] = valz["SndRow33"]
			},]]
		}

		local SndMenuPowerUp = { 
			[1] = {
				["Title"] = "Spawn",
				["ToolTip"] = "Played on the Power-Up itself when it spawns",
				["Bind"] = valz["SndRow7"]
			},
			[2] = {
				["Title"] = "Loop",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow29"]
			},
			[3] = {
				["Title"] = "Grab",
				["ToolTip"] = "When players get the Power-Up",
				["Bind"] = valz["SndRow8"]
			},
			[4] = {
				["Title"] = "Insta Kill",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow9"]
			},
			[5] = {
				["Title"] = "Fire Sale",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow10"]
			},
			[6] = {
				["Title"] = "Death Machine",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow11"]
			},
			[7] = {
				["Title"] = "Carpenter",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow12"]
			},
			[8] = {
				["Title"] = "Nuke",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow13"]
			},
			[9] = {
				["Title"] = "Double Points",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow14"]
			},
			[10] = {
				["Title"] = "Max Ammo",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow15"]
			},
			[11] = {
				["Title"] = "Zombie Blood",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow16"]
			},
			[12] = {
				["Title"] = "Bonus Points",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow26"]
			},
			[13] = {
				["Title"] = "Bonfire Sale",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow27"]
			},
			[14] = {
				["Title"] = "TimeWarp",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow30"]
			},
			[15] = {
				["Title"] = "Berzerk",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow31"]
			},
			[16] = {
				["Title"] = "Infinite Ammo",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow32"]
			},
			[17] = {
				["Title"] = "Invulnerability",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow33"]
			},
			[18] = {
				["Title"] = "Quick Foot",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow34"]
			},
			[19] = {
				["Title"] = "Broken Bottle",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow35"]
			},
			[20] = {
				["Title"] = "Perk Bottle",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow36"]
			},
			[21] = {
				["Title"] = "Pack-A-Punch",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow37"]
			},
			[22] = {
				["Title"] = "Random Weapon",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow38"]
			},
			[23] = {
				["Title"] = "Random Gum",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow45"]
			},
			[24] = {
				["Title"] = "Full Armor",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow46"]
			},
		}

		local SndMenuBox = { 
			[1] = {
				["Title"] = "Shake",
				["ToolTip"] = "When the teddy appears and the box starts hovering",
				["Bind"] = valz["SndRow17"]
			},
			[2] = {
				["Title"] = "Poof",
				["ToolTip"] = "When the box moves to another destination",
				["Bind"] = valz["SndRow18"]
			},
			[3] = {
				["Title"] = "Laugh",
				["ToolTip"] = "When the teddy appears",
				["Bind"] = valz["SndRow19"]
			},
			[4] = {
				["Title"] = "Bye Bye",
				["ToolTip"] = "Plays along with Shake",
				["Bind"] = valz["SndRow20"]
			},
			[5] = {
				["Title"] = "Jingle",
				["ToolTip"] = "When weapons are shuffling",
				["Bind"] = valz["SndRow21"]
			},
			[6] = {
				["Title"] = "Open",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow22"]
			},
			[7] = {
				["Title"] = "Close",
				["ToolTip"] = "",
				["Bind"] = valz["SndRow23"]
			}
		}

		local sndPanel = vgui.Create("DPanel", sheet)
		local sndheight, sndwidth = sheet:GetSize()
		sndPanel:SetSize(sndheight, (sndwidth - 50))
		sheet:AddSheet("Custom Sounds", sndPanel, "icon16/sound_add.png", false, false, "Customize the sounds that play for certain events.")

		local wrapper = vgui.Create("DPanel", sndPanel)
		wrapper:SetSize(500, 363)
		wrapper:SetPos(0, 0)

		-- A modifiable list of all sounds bound to currently selected event:
		local curSndList = vgui.Create("DListView", wrapper)
		curSndList:Dock(RIGHT)
		curSndList:SetSize(330, 200)
		curSndList:SetMultiSelect(false)
		curSndList:SetSortable(false)

		local curSndTbl = nil -- All sounds for currently selected Event Item
		local function DeleteNewItem(text, line)
			table.RemoveByValue(curSndTbl, text)
			curSndList:RemoveLine(line)
		end

		local soundsPlayed = {}
		curSndList.OnRowRightClick = function(lineID, line)
			local file = curSndList:GetLine(line):GetColumnText(1)
			local fileSubMenu = DermaMenu()	
			local function StopPlayedSounds()
				for k,v in pairs(soundsPlayed) do
					LocalPlayer():StopSound(v)
				end
			end

			fileSubMenu:AddOption("Play", function()
				StopPlayedSounds()		
				table.insert(soundsPlayed, file)	
				curSound = CreateSound(LocalPlayer(), file)
				curSound:Play()
			end)

			fileSubMenu:AddOption("Stop", function()
				StopPlayedSounds()		
			end)

			fileSubMenu:AddSpacer()
			fileSubMenu:AddSpacer()
			fileSubMenu:AddSpacer()
			fileSubMenu:AddOption("Remove", function()
				DeleteNewItem(file, line)
			end)

			fileSubMenu:Open()
		end

		local newCol = curSndList:AddColumn("Assigned Sounds")
		newCol:SetToolTip("A random sound from the list will play")
		local theList = nil 
		local function NewSelectedItem(list, tbl)
			curSndTbl = tbl
			theList = list
			curSndList:Clear()
			for k,v in pairs(tbl) do
				local newline = curSndList:AddLine(v)
				newline:SetToolTip(v)
			end
		end

		local function AddNewItem(text)
			table.insert(curSndTbl, text)
			local newline = curSndList:AddLine(text)
			newline:SetTooltip(text)
		end

		local selectedData = {}
		if (ispanel(sndFilePanel)) then sndFilePanel:Remove() end
		sndFilePanel = nil -- We want to keep this reference so only 1 file menu exists at a time
		sndFileMenu = nil -- Keep this so we don't restructure and reset the file menu EVERY TIME

		local function ChooseSound() -- Menu to make selecting mounted sounds effortless
			local eventItem = theList:GetLine(theList:GetSelectedLine())
			if (!list || !eventItem) then return end

			sndFilePanel = vgui.Create("DFrame", frame)
			sndFilePanel:SetSize(500, 475)
			--sndFilePanel:Dock(FILL)
			sndFilePanel:SetTitle(eventItem:GetColumnText(1) .. " Sound")
			sndFilePanel:SetDeleteOnClose(true)
			sndFilePanel.OnClose = function()
				-- Pretend to close it so users can continue where they left off when adding another sound
				sndFileMenu:SetParent(frame)
				sndFileMenu:Hide()
					
				sndFilePanel = nil
			end

			if (!ispanel(sndFileMenu)) then
				fileMenu = vgui.Create("DFileBrowser", sndFilePanel)
				fileMenu:Dock(FILL)	
				fileMenu:SetPath("GAME")
				fileMenu:SetFileTypes("*.wav *.mp3 *.ogg")
				fileMenu:SetBaseFolder("sound")
				fileMenu:SetOpen(true)
				sndFileMenu = fileMenu
			else
				sndFileMenu:SetParent(sndFilePanel)
				sndFileMenu:Show()
			end

			local soundsPlayed = {}
			function fileMenu:OnRightClick(filePath, selectedPnl)
				lastPath = fileMenu:GetCurrentFolder()

				if (SERVER) then return end
				filePath = string.Replace(filePath, "sound/", "")
				local fileSubMenu = DermaMenu()

				local function StopPlayedSounds()
					for k,v in pairs(soundsPlayed) do
						LocalPlayer():StopSound(v)
					end
				end

				fileSubMenu:AddOption("Play", function()
					StopPlayedSounds()		
					table.insert(soundsPlayed, filePath)	
					curSound = CreateSound(LocalPlayer(), filePath)
					curSound:Play()
				end)

				fileSubMenu:AddOption("Stop", function()
					StopPlayedSounds()		
				end)

				fileSubMenu:AddSpacer()
				fileSubMenu:AddSpacer()
				fileSubMenu:AddSpacer()
				fileSubMenu:AddOption("Add", function()
					AddNewItem(filePath)
				end)

				fileSubMenu:Open()
			end
		end

		local catList = vgui.Create("DCategoryList", wrapper)
		catList:Dock(FILL)
		catList:Center()

		local addBtn = vgui.Create("DButton", curSndList)
		addBtn:SetText("Add Sound")
		addBtn:Dock(BOTTOM)
		addBtn.DoClick = function()
			ChooseSound()
		end

		-- Menu categories with Event Lists inside
		local mainCat = catList:Add("Main")
		local powerupCat = catList:Add("Power-Ups")
		powerupCat:SetExpanded(false)
		local boxCat = catList:Add("Mystery Box")
		boxCat:SetExpanded(false)
		local mainSnds = vgui.Create("DListView", mainCat)
		local powerUpSnds = vgui.Create("DListView", powerupCat)
		local boxSnds = vgui.Create("DListView", boxCat)

		mainSnds:SetSortable(false)
		powerUpSnds:SetSortable(false)
		boxSnds:SetSortable(false)

		local function AddDList(listView)
			listView:Dock(LEFT)
			listView:AddColumn("Event")
		end

		AddDList(mainSnds)
		AddDList(powerUpSnds)
		AddDList(boxSnds)
		mainCat:SetContents(mainSnds)
		powerupCat:SetContents(powerUpSnds)
		boxCat:SetContents(boxSnds)

		local function AddContents(tbl, listView)
			for k,v in ipairs(tbl) do
				local newItem = listView:AddLine(v["Title"])
				if (v["ToolTip"] != "") then newItem:SetTooltip(v["ToolTip"]) end

				listView.OnRowSelected = function(panel, rowIndex, row) -- We need to update the editable list for the item we have selected
					local tblSnds = tbl[rowIndex]["Bind"] -- The table of sounds that is saved along with the config
					NewSelectedItem(listView, tblSnds)
				end

				listView:SetMultiSelect(false)
			end
		end
		AddContents(SndMenuMain, mainSnds)
		AddContents(SndMenuPowerUp, powerUpSnds)
		AddContents(SndMenuBox, boxSnds)
			
		mainSnds:SelectFirstItem() -- Since Main category is always expanded, let's make sure the first item is selected

		local function AddCollapseCB(this) -- New category expanded, collapse all others & deselect their items
			this.OnToggle = function()
				if (this:GetExpanded()) then 
					for k,v in pairs({mainCat, powerupCat, boxCat}) do
						if (v != this) then
							-- These categories are expanded, we cannot have more than 1 expanded so let's collapse these
							if (v:GetExpanded()) then
								v:Toggle()
							end
						else
							-- This category is expanded, let's select the first Event Item
							local listView = v:GetChild(1)
							if (ispanel(listView)) then
								listView:SelectFirstItem()
							end
						end
					end
				end
			end
		end
		AddCollapseCB(mainCat)
		AddCollapseCB(powerupCat)
		AddCollapseCB(boxCat)

		------------------------------------------------------------------------
		//Turned Names
		------------------------------------------------------------------------
		local turnlist = {}
		local numturnlist = 0

		local turnedpanel = vgui.Create("DPanel", sheet)
		sheet:AddSheet( "Turned Names", turnedpanel, "icon16/text_list_bullets.png", false, false, "Set custom names to be used for Turned zombies.")
		turnedpanel.Paint = function() return end

		local turnedlistpnl = vgui.Create("DScrollPanel", turnedpanel)
		turnedlistpnl:SetPos(0, 0)
		turnedlistpnl:SetSize(465, 300)
		turnedlistpnl:SetPaintBackground(true)
		turnedlistpnl:SetBackgroundColor(color_grey_200)

		local function InsertTurnedName(name)
			if IsValid(turnlist[name]) then return end
			turnlist[name] = vgui.Create("DPanel", turnedlistpnl)
			turnlist[name]:SetSize(440, 16)
			turnlist[name]:SetPos(5, 10 + (numturnlist*18))

			valz["TurnedNames"][name] = true

			local tname = vgui.Create("DLabel", turnlist[name])
			tname:SetText(name)
			tname:SetTextColor(color_grey_50)
			tname:SetPos(18, 0)
			tname:SetSize(250, 16)

			local tdelete = vgui.Create("DImageButton", turnlist[name])
			tdelete:SetImage("icon16/delete.png")
			tdelete:SetPos(0, 0)
			tdelete:SetSize(16, 16)
			tdelete.DoClick = function()
				valz["TurnedNames"][name] = nil

				turnlist[name]:Remove()
				turnlist[name] = nil

				local num = 0
				for k, v in pairs(turnlist) do
					v:SetPos(5, 10 + (num*18))
					num = num + 1
				end

				numturnlist = numturnlist - 1
			end

			numturnlist = numturnlist + 1
		end

		local turntext = vgui.Create("DTextEntry", turnedpanel)
		local turnadd = vgui.Create("DButton", turnedpanel)

		local turnreload = vgui.Create("DButton", turnedpanel)
		local turnreset = vgui.Create("DButton", turnedpanel)
		local turnclear = vgui.Create("DButton", turnedpanel)

		turnreload:SetText("Reload from server")
		turnreload:SetPos(5, 360)
		turnreload:SetSize(105, 30)
		turnreload.DoClick = function()
			for k, v in pairs(turnlist) do
				valz["TurnedNames"][k] = nil
				turnlist[k]:Remove()
				turnlist[k] = nil
				numturnlist = 0
			end
			local maplist = nzMapping.Settings.turnedlist
			if maplist then
				for k, v in pairs(maplist) do
					InsertTurnedName(k)
				end
			end
		end

		turnreset:SetText("Legacy names")
		turnreset:SetPos(120, 360)
		turnreset:SetSize(105, 30)
		turnreset.DoClick = function()
			for k, v in pairs(nzPerks.oldturnedlist) do
				InsertTurnedName(k)
			end
		end

		turnclear:SetText("Clear list")
		turnclear:SetPos(230, 360)
		turnclear:SetSize(105, 30)
		turnclear.DoClick = function()
			for k, v in pairs(turnlist) do
				valz["TurnedNames"][k] = nil

				turnlist[k]:Remove()
				turnlist[k] = nil

				local num = 0
				for k, v in pairs(turnlist) do
					v:SetPos(5, 10 + (num*18))
					num = num + 1
				end

				numturnlist = numturnlist - 1
			end
		end

		turntext:SetPos(5, 320)
		turntext:SetSize(220, 30)
		turntext:SetText("")
		turntext:SetEditable(true)

		turnadd:SetText("Add")
		turnadd:SetPos(230, 320)
		turnadd:SetSize(105, 30)
		turnadd.DoClick = function()
			local name = turntext:GetText()
			if name and name ~= "" then
				InsertTurnedName(name)
			end

			turntext:SetText("")
		end

		if nzMapping.Settings.turnedlist then
			for k, v in pairs(nzMapping.Settings.turnedlist) do
				InsertTurnedName(k)
			end
		end

		return sheet
	end,
	-- defaultdata = {}
})