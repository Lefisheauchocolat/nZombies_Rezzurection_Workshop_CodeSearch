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
		valz["Row8"] = data.bosstype or "Panzer"
		valz["Row9"] = data.startingspawns == nil and 35 or data.startingspawns
		valz["Row10"] = data.spawnperround == nil and 0 or data.spawnperround
		valz["Row11"] = data.maxspawns == nil and 35 or data.maxspawns
		valz["Row13"] = data.zombiesperplayer == nil and 0 or data.zombiesperplayer
		valz["Row14"] = data.spawnsperplayer == nil and 0 or data.spawnsperplayer
		valz["SpawnDelay"] = data.spawndelay == nil and 2 or data.spawndelay
		valz["Row15"] = data.zombietype or "Kino der Toten"
		valz["Row16"] = data.hudtype or "Black Ops 1"
		valz["Row17"] = data.zombieeyecolor == nil and Color(0, 255, 255, 255) or data.zombieeyecolor
		valz["Row18"] = data.perkmachinetype or "Original"
		valz["Row19"] = data.boxtype or "Original"
		valz["Row20"] = data.boxlightcolor == nil and Color(0,150,200,255) or data.boxlightcolor
		valz["Row33"] = data.mainfont or "Default NZR"
		valz["Row34"] = data.smallfont or "Default NZR"
		valz["Row35"] = data.mediumfont or "Default NZR"
		valz["Row36"] = data.roundfont or "Classic NZ"
		valz["Row37"] = data.ammofont or "Default NZR"
		valz["Row38"] = data.ammo2font or "Default NZR"
		valz["Row39"] = data.textcolor == nil and Color(255, 255, 255, 255) or data.textcolor
		valz["Row40"] = data.fontthicc or 2
		valz["Row41"] = data.icontype or "World at War/ Black Ops 1"
		valz["Row42"] = data.perkupgrades or false
		valz["Row43"] = data.PAPtype or "Original"
		valz["Row44"] = data.PAPcamo or "nz_classic"
		valz["Row45"] = data.hp or 100
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
		valz["Row54"] = data.badattacks or false
		valz["Row56"] = data.zct or false
		valz["Row57"] = data.mutated or false
		valz["Row58"] = data.aats or 2
		valz["Row59"] = data.poweruptype or "Black Ops 1"
		valz["Row60"] = data.mmohudtype or "World at War/ Black Ops 1"
		valz["Row61"] = data.downsoundtype or "Black Ops 3"
		valz["Row62"] = data.solorevive or 3
		valz["Row63"] = data.modifierslot == nil and true or data.modifierslot
		valz["Row64"] = data.dontkeepperks or false
		valz["Row65"] = data.powerupstyle or "style_classic"
		valz["Row66"] = data.antipowerups or false
		valz["Row67"] = data.antipowerupchance or 40
		valz["Row68"] = data.antipowerupstart or 2
		valz["Row69"] = data.antipowerupdelay or 4
		valz["Row70"] = data.powerupoutline or 0
		valz["Row71"] = data.roundperkbonus == nil and true or data.roundperkbonus
		valz["TurnedNames"] = data.turnedlist or {}
		valz["RBoxWeps"] = data.RBoxWeps or {}
		valz["PowerupColors"] = data.powerupcol or {
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
		valz["PAPMuzzle"] = data.papmuzzlecol or {
			[1] = Vector(0.470,0,1),
			[2] = Vector(0.431,0.156,1),
			[3] = Vector(0.647,0.549,1),
			[4] = Vector(0.196,0.078,0.431),
			[5] = Vector(0.235,0.078,0.705),
		}
		valz["WallbuyColors"] = data.wallbuydata or {
			["glow"] = (nzMapping.Settings.boxlightcolor or valz["Row20"] or Color(0,150,200,255)),
			["chalk"] = Color(255,255,255,255),
			["alpha"] = 30,
			["material"] = "sprites/wallbuy_light.vmt",
			["sizew"] = 128,
			["sizeh"] = 42,
		}
		valz["GumRoundPrices"] = data.gumpricelist or nzGum.RoundPrices
		valz["GumChanceMults"] = data.gummultipliers or nzGum.ChanceMultiplier
		valz["GumResetRounds"] = data.gumcountresetrounds or nzGum.RollCountResetRounds

		--[[
		valz["ACRow1"] = data.ac == nil and false or data.ac
		valz["ACRow2"] = data.acwarn == nil and true or data.acwarn
		valz["ACRow3"] = data.acsavespot == nil and true or tobool(data.acsavespot)
		valz["ACRow4"] = data.actptime == nil and 5 or data.actptime
		valz["ACRow5"] = data.acpreventboost == nil and true or tobool(data.acpreventboost)
		valz["ACRow6"] = data.acpreventcjump == nil and false or tobool(data.acpreventcjump)
		]]

		valz["ColdWarPoints"] = data.cwpointssystem or false

		valz["TimedGameplay"] = data.timedgame or false
		valz["TimedGameplayTime"] = data.timedgametime or 120
		valz["TimedGameplayMaxTime"] = data.timedgamemaxtime or 600

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
		-- Catalyst/ZCT/Burning --

		if (ispanel(sndFilePanel)) then sndFilePanel:Remove() end

		-- Cache all Wunderfizz perks for saving/loading allowed Wunderfizz perks:
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

		local gumlist = {}
		for k, v in pairs(nzGum.Gums) do
			gumlist[k] = {true, nzGum.RollCounts[v.rare or nzGum.RareTypes.DEFAULT]}
		end

		valz["GumsList"] = data.gumlist or gumlist

		-- More compact and less messy:
		for k,v in pairs(nzSounds.struct) do
			valz["SndRow" .. k] = data[v] or {}
		end

		local sheet = vgui.Create( "DPropertySheet", frame )
		sheet:SetSize( 480, 430 )
		sheet:SetPos( 10, 10 )

		local DProperties = vgui.Create( "DProperties", DProperySheet )
		DProperties:SetSize( 280, 220 )
		DProperties:SetPos( 0, 0 )
		sheet:AddSheet( "Map Properties", DProperties, "icon16/cog.png", false, false, "Set a list of general settings. The Easter Egg Song URL needs to be from Soundcloud.")

		--[[-------------------------------------------------------------------------
		Player Settings
		---------------------------------------------------------------------------]]
			local Row1 = DProperties:CreateRow( "Player Settings", "Starting Weapon" )
			Row1:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if !v.NZTotalBlacklist then
					if v.Category and v.Category != "" then
						Row1:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Row1"] == v.ClassName)
					else
						Row1:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Row1"] == v.ClassName)
					end
				end
			end

			Row1.DataChanged = function( _, val ) valz["Row1"] = val end
			local kniferow = DProperties:CreateRow( "Player Settings", "Knife" )
			kniferow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Knives" then
					kniferow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Knife"] == v.ClassName)
				end
			end
			kniferow.DataChanged = function( _, val ) valz["Knife"] = val valz["Knife"] = val end
			
			local grenaderow = DProperties:CreateRow( "Player Settings", "Grenade" )
			grenaderow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Grenades" then
					grenaderow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Grenade"] == v.ClassName)
				end
			end
			grenaderow.DataChanged = function( _, val ) valz["Grenade"] = val valz["Grenade"] = val end
			
			local syretterow = DProperties:CreateRow( "Player Settings", "Revive Syrette" )
			syretterow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Syrettes" then
					syretterow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Revive Syrette"] == v.ClassName)
				end
			end
			syretterow.DataChanged = function( _, val ) valz["Revive Syrette"] = val valz["Revive Syrette"] = val end

			local paparmsrow = DProperties:CreateRow( "Player Settings", "PaP Arms" )
			paparmsrow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Knuckles" then
					paparmsrow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["PaP Arms"] == v.ClassName)
				end
			end
			paparmsrow.DataChanged = function( _, val ) valz["PaP Arms"] = val valz["PaP Arms"] = val end

			local Row2 = DProperties:CreateRow( "Player Settings", "Starting Points" )
			Row2:Setup( "Integer" )
			Row2:SetValue( valz["Row2"] )
			Row2.DataChanged = function( _, val ) valz["Row2"] = val end

			local Row45 = DProperties:CreateRow( "Player Settings", "Player Base Health" )
			Row45:Setup( "Integer" )
			Row45:SetValue( valz["Row45"] )
			Row45.DataChanged = function( _, val ) valz["Row45"] = val end
		--[[-------------------------------------------------------------------------
		Player Settings
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Map Cosmetics
		---------------------------------------------------------------------------]]
			local Row16 = DProperties:CreateRow("Map Cosmetics", "HUD Select")
			Row16:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.HudSelectData) do
				if k == valz["Row16"] then
					Row16:AddChoice(k, k, true)
					found = true
				else
					Row16:AddChoice(k, k, false)
				end
			end
			Row16.DataChanged = function( _, val ) valz["Row16"] = val end
			Row16:SetTooltip("Sets the HUD players will see in your map")

			local Row41 = DProperties:CreateRow("Map Cosmetics", "Perk Icons")
			Row41:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.IconSelectData) do
				if k == valz["Row41"] then
					Row41:AddChoice(k, k, true)
					found = true
				else
					Row41:AddChoice(k, k, false)
				end
			end
			Row41.DataChanged = function( _, val ) valz["Row41"] = val end
			Row41:SetTooltip("Changes the style of the perk icons")

			local Row59 = DProperties:CreateRow("Map Cosmetics", "Powerup Icons")
			Row59:Setup( "Combo" )
			local found = false
			for k, v in pairs(nzDisplay.PowerupHudData) do
				if k == valz["Row59"] then
					Row59:AddChoice(k, k, true)
					found = true
				else
					Row59:AddChoice(k, k, false)
				end
			end
			Row59.DataChanged = function( _, val ) valz["Row59"] = val end
			Row59:SetTooltip("Changes the style of powerup icons")

			local Row60 = DProperties:CreateRow("Map Cosmetics", "Perk Stats Icons")
			Row60:Setup( "Combo" )
			local found = false
			for k, v in pairs(nzRound.IconSelectData) do
				if k == valz["Row60"] then
					Row60:AddChoice(k, k, true)
					found = true
				else
					Row60:AddChoice(k, k, false)
				end
			end
			Row60.DataChanged = function( _, val ) valz["Row60"] = val end
			Row60:SetTooltip("Changes the style of the mini perk icons that display active perk stats")

			local Row61 = DProperties:CreateRow("Map Cosmetics", "Downed Ambience")
			Row61:Setup( "Combo" )
			local found = false
			for k, v in pairs(nzDisplay.HUDdowndata) do
				if k == valz["Row61"] then
					Row61:AddChoice(k, k, true)
					found = true
				else
					Row61:AddChoice(k, k, false)
				end
			end
			Row61.DataChanged = function( _, val ) valz["Row61"] = val end
			Row61:SetTooltip("Changes downed sound, downed ambience, and revived sound")

			local Row18 = DProperties:CreateRow("Map Cosmetics", "Perk Machine Skins")
			Row18:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.PerkSelectData) do
				if k == valz["Row18"] then
					Row18:AddChoice(k, k, true)
					found = true
				else
					Row18:AddChoice(k, k, false)
				end
			end
			Row18.DataChanged = function( _, val ) valz["Row18"] = val end
			Row18:SetTooltip("Sets the Perk Machines Appearance")

			local Row19 = DProperties:CreateRow("Map Cosmetics", "Mystery Box Skin")
			Row19:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.BoxSkinData) do
				if k == valz["Row19"] then
					Row19:AddChoice(k, k, true)
					found = true
				else
					Row19:AddChoice(k, k, false)
				end
			end
			Row19.DataChanged = function( _, val ) valz["Row19"] = val end
			Row19:SetTooltip("Sets the Mystery Box Skin")

			if nzPowerUps.Styles then
				local powerupstylerow = DProperties:CreateRow("Map Cosmetics", "Powerup Style")
				powerupstylerow:Setup("Combo")
				for k,v in pairs(nzPowerUps.Styles) do
					powerupstylerow:AddChoice(v.name, k, k == valz["Row65"])
				end
				powerupstylerow.DataChanged = function( _, val ) valz["Row65"] = val valz["Row65"] = val end
			end

			local bottlerow = DProperties:CreateRow( "Map Cosmetics", "Bottle" )
			bottlerow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Bottles" then
					bottlerow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Bottle"] == v.ClassName)
				end
			end
			bottlerow.DataChanged = function( _, val ) valz["Bottle"] = val valz["Bottle"] = val end

			local Row43 = DProperties:CreateRow("Map Cosmetics", "Pack-A-Punch Skin")
			Row43:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.PAPSelectData) do
				if k == valz["Row43"] then
					Row43:AddChoice(k, k, true)
					found = true
				else
					Row43:AddChoice(k, k, false)
				end
			end
			Row43.DataChanged = function( _, val ) valz["Row43"] = val end
			Row43:SetTooltip("Sets the Pack-A-Punch skin")

			local Row44 = DProperties:CreateRow("Map Cosmetics", "Pack-A-Punch Camo")
			Row44:Setup( "Combo" )
			local found = false
			for k, v in pairs(nzCamos.Data) do
				if k == valz["Row44"] then
					Row44:AddChoice(nzCamos:Get(k).name, k, true)
					found = true
				else
					Row44:AddChoice(nzCamos:Get(k).name, k, false)
				end
			end
			Row44.DataChanged = function( _, val ) valz["Row44"] = val end
			Row44:SetTooltip("Sets the Global Pack-A-Punch Camo")

			local Row70 = DProperties:CreateRow("Map Cosmetics", "Powerup Outlines")
			Row70:Setup("Combo")
			Row70:AddChoice('Disabled', 0, valz["Row70"] == 0)
			Row70:AddChoice('Enabled', 1, valz["Row70"] == 1)
			Row70:AddChoice('Ignore Z', 2, valz["Row70"] == 2)
			Row70.DataChanged = function( _, val ) valz["Row70"] = val end
			Row70:SetTooltip("More of an accessibility option, enables a glowing halo around powerups, ignorez makes the outline show through walls.")
		--[[-------------------------------------------------------------------------
		Map Cosmetics
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Map Functionality
		---------------------------------------------------------------------------]]
			local Row62 = DProperties:CreateRow("Map Functionality", "Solo Revives Count")
			Row62:Setup("Integer")
			Row62:SetValue(valz["Row62"])
			Row62:SetTooltip("How many solo revives the player gets in singleplayer. (SET TO 0 TO DISABLE)")
			Row62.DataChanged = function( _, val ) valz["Row62"] = val end

			local Row42 = DProperties:CreateRow( "Map Functionality", "Perk Upgrades" )
			Row42:Setup("Boolean")
			Row42:SetValue(valz["Row42"])
			Row42.DataChanged = function( _, val ) valz["Row42"] = val end
			Row42:SetTooltip("Enable for perk upgrades to be purchasable on this config.")

			local Row71 = DProperties:CreateRow("Map Functionality", "Perk Slot Rewards")
			Row71:Setup("Boolean")
			Row71:SetValue(valz["Row71"])
			Row71.DataChanged = function( _, val) valz["Row71"] = val end
			Row71:SetTooltip("Enable for all players to gain an additional perk slot by completing round 15 and 25 (Default On).")

			local Row63 = DProperties:CreateRow("Map Functionality", "Perk Modifier Slot")
			Row63:Setup("Boolean")
			Row63:SetValue(valz["Row63"])
			Row63.DataChanged = function( _, val) valz["Row63"] = val end
			Row63:SetTooltip("Enable for all players fourth perk always being upgraded (Default On).")

			local Row64 = DProperties:CreateRow("Map Functionality", "Lose All Perks on Down")
			Row64:Setup("Boolean")
			Row64:SetValue(valz["Row64"])
			Row64.DataChanged = function( _, val) valz["Row64"] = val end
			Row64:SetTooltip("Enable for players to lose all perks on down, instead of only half.")

			local CWPoints = DProperties:CreateRow( "Map Functionality", "Cold War Points System" )
			CWPoints:Setup( "Boolean" )
			CWPoints:SetValue( valz["ColdWarPoints"] )
			CWPoints.DataChanged = function( _, val ) valz["ColdWarPoints"] = val end
			CWPoints:SetTooltip("Enable for CW styled points earning. (Only rewards points on kills)")

			local Row58 = DProperties:CreateRow( "Map Functionality", "Alternate Ammo Type System" )
			Row58:Setup("Combo")
			Row58:AddChoice("Disabled", 0, valz["Row58"] == 0)
			Row58:AddChoice("Only when no SWEP:OnRePaP()", 1, valz["Row58"] == 1)
			Row58:AddChoice("Always on (Default)", 2, valz["Row58"] == 2)
			Row58.DataChanged = function( _, val ) valz["Row58"] = val valz["Row58"] = val end
			Row58:SetTooltip("Enable for weapons to gain BO3-esque ammo mods when Pack-a-Punch'ed twice.")

			local deathmachinerow = DProperties:CreateRow( "Map Functionality", "Death Machine" )
			deathmachinerow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Powerups" then
					deathmachinerow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, valz["Death Machine"] == v.ClassName)
				end
			end
			deathmachinerow.DataChanged = function( _, val ) valz["Death Machine"] = val end

			local shieldrow = DProperties:CreateRow("Map Functionality", "Shield" )
			shieldrow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.ShieldEnabled and v.NZSpecialCategory == "shield" then
					shieldrow:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, valz["Shield"] == v.ClassName)
				end
			end
			shieldrow.DataChanged = function( _, val ) valz["Shield"] = val end
			shieldrow:SetTooltip("Sets a shield to be given to the player through means such as, Victorious Tortoise's upgrade ability, the 'Shield Up' Gobblegum, and potentially other addons.")
		--[[-------------------------------------------------------------------------
		Map Functionality
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Anti Powerups
		---------------------------------------------------------------------------]]
			local Row66 = DProperties:CreateRow("Anti Powerups", "Enable Anti Powerups")
			Row66:Setup("Boolean")
			Row66:SetValue(valz["Row66"])
			Row66.DataChanged = function( _, val ) valz["Row66"] = val end
			Row66:SetTooltip("Enable anti powerups spawning on this config")

			local Row67 = DProperties:CreateRow("Anti Powerups", "Max Anti Powerups Chance")
			Row67:Setup("Integer")
			Row67:SetValue(valz["Row67"])
			Row67.DataChanged = function( _, val ) valz["Row67"] = val end
			Row67:SetTooltip("How many Powerups to spawn before having a 100% chance of an Anti Powerup. (Default 40)")

			local Row68 = DProperties:CreateRow("Anti Powerups", "Powerup Count Before Anti Powerups")
			Row68:Setup("Integer")
			Row68:SetValue(valz["Row68"])
			Row68.DataChanged = function( _, val ) valz["Row68"] = val end
			Row68:SetTooltip("Amount of Powerups that must be picked up before Anti Powerups have a chance to start spawning. (Default is 2)")

			local Row69 = DProperties:CreateRow("Anti Powerups", "Anti Powerup Spawn Delay")
			Row69:Setup("Integer")
			Row69:SetValue(valz["Row69"])
			Row69.DataChanged = function( _, val ) valz["Row69"] = val end
			Row69:SetTooltip("Time (in seconds) it takes for Anti Powerups to activate after spawning. (Default is 4)")
		--[[-------------------------------------------------------------------------
		Anti Powerups
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Timed Gameplay
		---------------------------------------------------------------------------]]
			local TimedPlay = DProperties:CreateRow( "Timed Gameplay", "Enable Timed Gameplay" )
			TimedPlay:Setup( "Boolean" )
			TimedPlay:SetValue( valz["TimedGameplay"] )
			TimedPlay.DataChanged = function( _, val ) valz["TimedGameplay"] = val end
			TimedPlay:SetTooltip("Enable for Timed Gameplay.(Rounds will automatically advance overtime.)")
			
			local TimedPlayTime = DProperties:CreateRow("Timed Gameplay", "Wait Time")
			TimedPlayTime:Setup( "Integer" )
			TimedPlayTime:SetValue( valz["TimedGameplayTime"] )
			TimedPlayTime:SetTooltip("The amount time the Round will wait before transitioning to the next one.(Multiplied by the current round number.)")
			TimedPlayTime.DataChanged = function( _, val ) valz["TimedGameplayTime"] = val end

			local TimedPlayMaxTime = DProperties:CreateRow("Timed Gameplay", "Max Wait Time")
			TimedPlayMaxTime:Setup( "Integer" )
			TimedPlayMaxTime:SetValue( valz["TimedGameplayMaxTime"] )
			TimedPlayMaxTime:SetTooltip("The maximum amount time the Round will wait before transitioning to the next one.")
			TimedPlayMaxTime.DataChanged = function( _, val ) valz["TimedGameplayMaxTime"] = val end
		--[[-------------------------------------------------------------------------
		Timed Gameplay
		---------------------------------------------------------------------------]]	


		--[[-------------------------------------------------------------------------
		Scripting and Extensions
		---------------------------------------------------------------------------]]
			local Row4 = DProperties:CreateRow( "Scripting and Extensions", "Includes Map Script?" )
			Row4:Setup( "Boolean" )
			Row4:SetValue( valz["Row4"] )
			Row4.DataChanged = function( _, val ) valz["Row4"] = val end
			Row4:SetTooltip("Loads a .lua file with the same name as the config .txt from /lua/nzmapscripts - for advanced developers.")
			
			local Row5 = DProperties:CreateRow( "Scripting and Extensions", "Script Description" )
			Row5:Setup( "Generic" )
			Row5:SetValue( valz["Row5"] )
			Row5.DataChanged = function( _, val ) valz["Row5"] = val end
			Row5:SetTooltip("Sets the description displayed when attempting to load the script.")
				
			local Row6 = DProperties:CreateRow( "Scripting and Extensions", "GM Extensions" )
			Row6:Setup("Boolean")
			Row6:SetValue( valz["Row6"] )
			Row6.DataChanged = function( _, val ) valz["Row6"] = val end
			Row6:SetTooltip("Sets whether the gamemode should spawn in map entities from other gamemodes, such as ZS.")
		--[[-------------------------------------------------------------------------
		Scripting and Extensions
		---------------------------------------------------------------------------]]

		--[[-------------------------------------------------------------------------
		Font Settings
		---------------------------------------------------------------------------]]
			local Row33 = DProperties:CreateRow("Font Settings", "Main Menu Font")
			Row33:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row33"] then
					Row33:AddChoice(k, k, true)
					found = true
				else
					Row33:AddChoice(k, k, false)
				end
			end
			Row33.DataChanged = function( _, val ) valz["Row33"] = val end
			Row33:SetTooltip("Changes the font of the main font")
			
			local Row34 = DProperties:CreateRow("Font Settings", "Gun Name and Pickup Font")
			Row34:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row34"] then
					Row34:AddChoice(k, k, true)
					found = true
				else
					Row34:AddChoice(k, k, false)
				end
			end
			Row34.DataChanged = function( _, val ) valz["Row34"] = val end
			Row34:SetTooltip("Changes the font of the name of your gun and interactibles")
		
			local Row35 = DProperties:CreateRow("Font Settings", "Point Display Font")
			Row35:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row35"] then
					Row35:AddChoice(k, k, true)
					found = true
				else
					Row35:AddChoice(k, k, false)
				end
			end
			Row35.DataChanged = function( _, val ) valz["Row35"] = val end
			Row35:SetTooltip("Changes the font of the point displays")
		
			local Row36 = DProperties:CreateRow("Font Settings", "Round Font")
			Row36:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row36"] then
					Row36:AddChoice(k, k, true)
					found = true
				else
					Row36:AddChoice(k, k, false)
				end
			end
			Row36.DataChanged = function( _, val ) valz["Row36"] = val end
			Row36:SetTooltip("Changes the font of the round")
		
			local Row37 = DProperties:CreateRow("Font Settings", "Ammo Font")
			Row37:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row37"] then
					Row37:AddChoice(k, k, true)
					found = true
				else
					Row37:AddChoice(k, k, false)
				end
			end
			Row37.DataChanged = function( _, val ) valz["Row37"] = val end
			Row37:SetTooltip("Changes the font of points gained")
		
			local Row38 = DProperties:CreateRow("Font Settings", "Ammo 2 Font")
			Row38:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.FontSelection) do
				if k == valz["Row38"] then
					Row38:AddChoice(k, k, true)
					found = true
				else
					Row38:AddChoice(k, k, false)
				end
			end
			Row38.DataChanged = function( _, val ) valz["Row38"] = val end
			Row38:SetTooltip("Changes the font of points gained")
		
			local Row40 = DProperties:CreateRow( "Font Settings", "Font Thickness" )
			Row40:Setup( "Integer" )
			Row40:SetValue( valz["Row40"] )
			Row40.DataChanged = function( _, val ) valz["Row40"] = val end	
		--[[-------------------------------------------------------------------------
		Font Settinga
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Anti Cheat
		---------------------------------------------------------------------------]]
			--[[
			local ACRow1 = DProperties:CreateRow("Anti-Cheat Settings", "Enabled?")
			ACRow1:Setup("Boolean")
			ACRow1:SetValue(valz["ACRow1"])
			ACRow1.DataChanged = function( _, val ) valz["ACRow1"] = val end

			local ACRow2 = DProperties:CreateRow("Anti-Cheat Settings", "Warn players?")
			ACRow2:Setup("Boolean")
			ACRow2:SetValue(valz["ACRow2"])
			ACRow2:SetTooltip("Shows \"Return to map!\" with a countdown on player's screens")
			ACRow2.DataChanged = function(_, val) valz["ACRow2"] = val end

			local ACRow3 = DProperties:CreateRow("Anti-Cheat Settings", "Save Last Spots?")
			ACRow3:Setup("Boolean")
			ACRow3:SetValue(valz["ACRow3"])
			ACRow3:SetTooltip("Remembers the last spot a player was at before they were detected. (Uses more performance)")
			ACRow3.DataChanged = function(_, val) valz["ACRow3"] = val end

			local ACRow5 = DProperties:CreateRow("Anti-Cheat Settings", "Prevent boosting?")
			ACRow5:Setup("Boolean")
			ACRow5:SetValue(valz["ACRow5"])
			ACRow5:SetTooltip("Cancels out vertical velocity when players boost up faster than jump speed")
			ACRow5.DataChanged = function(_, val) valz["ACRow5"] = val end

			local ACRow6 = DProperties:CreateRow("Anti-Cheat Settings", "No Crouch Jump?")
			ACRow6:Setup("Boolean")
			ACRow6:SetValue(valz["ACRow6"])
			ACRow6:SetTooltip("Turns crouch jumps into normal jumps to make climbing on stuff harder")
			ACRow6.DataChanged = function(_, val) valz["ACRow6"] = val end

			local ACRow4 = DProperties:CreateRow("Anti-Cheat Settings", "Seconds for TP")
			ACRow4:Setup("Integer")
			ACRow4:SetValue(valz["ACRow4"])
			ACRow4:SetTooltip("Amount of seconds before a cheating player is teleported.")
			ACRow4.DataChanged = function(_, val) valz["ACRow4"] = val end
			]]
		--[[-------------------------------------------------------------------------
		Anti Cheat
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Zombie Settings Tab
		---------------------------------------------------------------------------]]
				local DProperties3 = vgui.Create( "DProperties", enemysheet )
				DProperties3:SetSize( 280, 220 )
				DProperties3:SetPos( 0, 0 )
				sheet:AddSheet( "Zombie Settings", DProperties3, "icon16/user_green.png", false, false, "Change zombie settings")
			
				local Row15 = DProperties3:CreateRow("Zombie Settings", "Zombie Type")
				Row15:Setup( "Combo" )
				local found = false
				for k,v in pairs(nzRound.ZombieSkinData) do
					if k == valz["Row15"] then
						Row15:AddChoice(k, k, true)
						found = true
					else
						Row15:AddChoice(k, k, false)
					end
				end
				Row15.DataChanged = function( _, val ) valz["Row15"] = val end
				Row15:SetTooltip("Sets the zombies that will appear in your map.")
				
				local Row7 = DProperties3:CreateRow("Zombie Settings", "Special Round")
				Row7:Setup( "Combo" )
				local found = false
				for k,v in pairs(nzRound.SpecialData) do
					if k == valz["Row7"] then
						Row7:AddChoice(k, k, true)
						found = true
					else
						Row7:AddChoice(k, k, false)
					end
				end
				Row7:AddChoice(" None", "None", !found)
				Row7.DataChanged = function( _, val ) valz["Row7"] = val end
				Row7:SetTooltip("Sets what type of special round will appear.")
				
				local Row8 = DProperties3:CreateRow( "Zombie Settings", "Boss" )
				Row8:Setup( "Combo" )
				local found = false
				for k,v in pairs(nzRound.BossData) do
					if k == valz["Row8"] then
						Row8:AddChoice(k, k, true)
						found = true
					else
						Row8:AddChoice(k, k, false)
					end
				end
				Row8:AddChoice(" None", "None", !found)
				Row8.DataChanged = function( _, val ) valz["Row8"] = val end
				Row8:SetTooltip("Sets what type of boss will appear.")
				
				local Row46 = DProperties3:CreateRow( "Zombie Settings", "Zombie Search Range" )
				Row46:Setup( "Integer" )
				Row46:SetValue( valz["Row46"] )
				Row46.DataChanged = function( _, val ) valz["Row46"] = val end
				Row46:SetTooltip("Sets zombie search range. 0 is infinite search range and not recommended. Must be positive")

				local Row51 = DProperties3:CreateRow( "Zombie Settings", "Nav-Zone Based Zombie Spawning" )
				Row51:Setup( "Boolean" )
				Row51:SetValue( valz["Row51"] )
				Row51.DataChanged = function( _, val ) valz["Row51"] = val end
				Row51:SetTooltip("Makes use of the nav-zone system to determine where to spawn zombies. Ideally use it so zombies always spawn in areas near the player.")
			
				local Row50 = DProperties3:CreateRow("Zombie Progression", "Round Amount Cap")
				Row50:Setup( "Integer" )
				Row50:SetValue( valz["Row50"] )
				Row50:SetTooltip("The point at which the amount of zombies per round stops increasing.")
				Row50.DataChanged = function( _, val ) valz["Row50"] = val end
				
				local Row9 = DProperties3:CreateRow("Zombie Progression", "Starting Spawns")
				Row9:Setup( "Integer" )
				Row9:SetValue( valz["Row9"] )
				Row9:SetTooltip("Allowed zombies alive at once, can be increased per round with Spawns Per Round")
				Row9.DataChanged = function( _, val ) valz["Row9"] = val end

				local Row11 = DProperties3:CreateRow("Zombie Progression", "Max Spawns")
				Row11:Setup( "Integer" )
				Row11:SetValue( valz["Row11"] )
				Row11:SetTooltip("The max allowed zombies alive at any given time, it will NEVER go above this.")
				Row11.DataChanged = function( _, val ) valz["Row11"] = val end

				local Row10 = DProperties3:CreateRow("Zombie Progression", "Spawns Per Round")
				Row10:Setup( "Integer" )
				Row10:SetValue( valz["Row10"] )
				Row10:SetTooltip("Amount to increase spawns by each round (Cannot increase past Max Spawns)")
				Row10.DataChanged = function( _, val ) valz["Row10"] = val end

				local Row13 = DProperties3:CreateRow("Zombie Progression", "Zombies Per Player")
				Row13:Setup( "Integer" )
				Row13:SetValue( valz["Row13"] )
				Row13:SetTooltip("Extra zombies to kill per player (Ignores first player)")
				Row13.DataChanged = function( _, val ) valz["Row13"] = val end

				local Row14 = DProperties3:CreateRow("Zombie Progression", "Spawns Per Player")
				Row14:Setup( "Integer" )
				Row14:SetValue( valz["Row14"] )
				Row14:SetTooltip("Extra zombies allowed to spawn per player (Ignores first player and Max Spawns option)")
				Row14.DataChanged = function( _, val ) valz["Row14"] = val end
				
				local SpawnDelay = DProperties3:CreateRow("Zombie Progression", "Spawn Delay")
				SpawnDelay:Setup( "Integer" )
				SpawnDelay:SetValue( valz["SpawnDelay"] )
				SpawnDelay:SetTooltip("Interval in seconds that zombies spawn. Continually decreases per round. CANNOT GO BELOW 0.05!")
				SpawnDelay.DataChanged = function( _, val ) valz["SpawnDelay"] = val end
				
				local HealthStart = DProperties3:CreateRow("Zombie Progression", "Zombie Start Health")
				HealthStart:Setup( "Integer" )
				HealthStart:SetValue( valz["HealthStart"] )
				HealthStart:SetTooltip("The amount of health zombies have at the start of the game.")
				HealthStart.DataChanged = function( _, val ) valz["HealthStart"] = val end
				
				local HealthIncrement = DProperties3:CreateRow("Zombie Progression", "Zombie Health Increment")
				HealthIncrement:Setup( "Integer" )
				HealthIncrement:SetValue( valz["HealthIncrement"] )
				HealthIncrement:SetTooltip("The amount of health zombies gain each round before Round 10.")
				HealthIncrement.DataChanged = function( _, val ) valz["HealthIncrement"] = val end
				
				local HealthMultiplier = DProperties3:CreateRow("Zombie Progression", "Zombie Health Multiplier")
				HealthMultiplier:Setup( "Integer" )
				HealthMultiplier:SetValue( valz["HealthMultiplier"] )
				HealthMultiplier:SetTooltip("Multiply zombies health by this every round after Round 10.")
				HealthMultiplier.DataChanged = function( _, val ) valz["HealthMultiplier"] = val end
				
				local HealthCap = DProperties3:CreateRow("Zombie Progression", "Zombie Health Cap")
				HealthCap:Setup( "Integer" )
				HealthCap:SetValue( valz["HealthCap"] )
				HealthCap:SetTooltip("Maximum health that zombies can have.")
				HealthCap.DataChanged = function( _, val ) valz["HealthCap"] = val end

				local Row49 = DProperties3:CreateRow("Zombie Progression", "Zombie Speed Multiplier")
				Row49:Setup( "Integer" )
				Row49:SetValue( valz["Row49"] )
				Row49:SetTooltip("Controls the Rate at how fast the Zombies increase in speed.")
				Row49.DataChanged = function( _, val ) valz["Row49"] = val end
				
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
					BurningChance:Setup( "Integer" )
					BurningChance:SetValue( valz["BurningChance"] )
					BurningChance:SetTooltip("Chance of Burning Zombies appearing. (0 to disable)")
					BurningChance.DataChanged = function( _, val ) valz["BurningChance"] = val end

					local BurningRnd = DProperties3:CreateRow("Burning Zombies", "Burning Round")
					BurningRnd:Setup( "Integer" )
					BurningRnd:SetValue( valz["BurningRnd"] )
					BurningRnd:SetTooltip("Round when Burning Zombies can start appearing. (-1 for on Power)")
					BurningRnd.DataChanged = function( _, val ) valz["BurningRnd"] = val end
				
				
					------ ZCTaco ------
					local Row56 = DProperties3:CreateRow( "ZCT Zombies", "Zombie Chicken Taco(ZCT)" )
					Row56:Setup( "Boolean" )
					Row56:SetValue( valz["Row56"] )
					Row56.DataChanged = function( _, val ) valz["Row56"] = val end
					Row56:SetTooltip("Enable for ZCT zombies to appear in your config.")
					
					-- Red --
					local RedChance = DProperties3:CreateRow("ZCT Zombies", "Red Chance")
					RedChance:Setup( "Integer" )
					RedChance:SetValue( valz["RedChance"] )
					RedChance:SetTooltip("Chance of Zombies appearing as Red. (0 to disable)")
					RedChance.DataChanged = function( _, val ) valz["RedChance"] = val end
				
					local RedRnd = DProperties3:CreateRow("ZCT Zombies", "Red Round")
					RedRnd:Setup( "Integer" )
					RedRnd:SetValue( valz["RedRnd"] )
					RedRnd:SetTooltip("Round when Red Zombies can start appearing. (-1 for on Power)")
					RedRnd.DataChanged = function( _, val ) valz["RedRnd"] = val end
				
					-- Blue --
					local BlueChance = DProperties3:CreateRow("ZCT Zombies", "Blue Chance")
					BlueChance:Setup( "Integer" )
					BlueChance:SetValue( valz["BlueChance"] )
					BlueChance:SetTooltip("Chance of Zombies appearing as Blue. (0 to disable)")
					BlueChance.DataChanged = function( _, val ) valz["BlueChance"] = val end
				
					local BlueRnd = DProperties3:CreateRow("ZCT Zombies", "Blue Round")
					BlueRnd:Setup( "Integer" )
					BlueRnd:SetValue( valz["BlueRnd"] )
					BlueRnd:SetTooltip("Round when Blue Zombies can start appearing. (-1 for on Power)")
					BlueRnd.DataChanged = function( _, val ) valz["BlueRnd"] = val end
				
					-- Green --
					local GreenChance = DProperties3:CreateRow("ZCT Zombies", "Green Chance")
					GreenChance:Setup( "Integer" )
					GreenChance:SetValue( valz["GreenChance"] )
					GreenChance:SetTooltip("Chance of Zombies appearing as Green. (0 to disable)")
					GreenChance.DataChanged = function( _, val ) valz["GreenChance"] = val end
				
					local GreenRnd = DProperties3:CreateRow("ZCT Zombies", "Green Round")
					GreenRnd:Setup( "Integer" )
					GreenRnd:SetValue( valz["GreenRnd"] )
					GreenRnd:SetTooltip("Round when Green Zombies can start appearing. (-1 for on Power)")
					GreenRnd.DataChanged = function( _, val ) valz["GreenRnd"] = val end
				
					-- Yellow --
					local YellowChance = DProperties3:CreateRow("ZCT Zombies", "Yellow Chance")
					YellowChance:Setup( "Integer" )
					YellowChance:SetValue( valz["YellowChance"] )
					YellowChance:SetTooltip("Chance of Zombies appearing as Yellow. (0 to disable)")
					YellowChance.DataChanged = function( _, val ) valz["YellowChance"] = val end
				
					local YellowRnd = DProperties3:CreateRow("ZCT Zombies", "Yellow Round")
					YellowRnd:Setup( "Integer" )
					YellowRnd:SetValue( valz["YellowRnd"] )
					YellowRnd:SetTooltip("Round when Yellow Zombies can start appearing. (-1 for on Power)")
					YellowRnd.DataChanged = function( _, val ) valz["YellowRnd"] = val end
				
					-- Purple --
					local PurpleChance = DProperties3:CreateRow("ZCT Zombies", "Purple Chance")
					PurpleChance:Setup( "Integer" )
					PurpleChance:SetValue( valz["PurpleChance"] )
					PurpleChance:SetTooltip("Chance of Zombies appearing as Purple. (0 to disable)")
					PurpleChance.DataChanged = function( _, val ) valz["PurpleChance"] = val end
				
					local PurpleRnd = DProperties3:CreateRow("ZCT Zombies", "Purple Round")
					PurpleRnd:Setup( "Integer" )
					PurpleRnd:SetValue( valz["PurpleRnd"] )
					PurpleRnd:SetTooltip("Round when Purple Zombies can start appearing. (-1 for on Power)")
					PurpleRnd.DataChanged = function( _, val ) valz["PurpleRnd"] = val end
				
					-- Pink --
					local PinkChance = DProperties3:CreateRow("ZCT Zombies", "Pink Chance")
					PinkChance:Setup( "Integer" )
					PinkChance:SetValue( valz["PinkChance"] )
					PinkChance:SetTooltip("Chance of Zombies appearing as Pink. (0 to disable)")
					PinkChance.DataChanged = function( _, val ) valz["PinkChance"] = val end
				
					local PinkRnd = DProperties3:CreateRow("ZCT Zombies", "Pink Round")
					PinkRnd:Setup( "Integer" )
					PinkRnd:SetValue( valz["PinkRnd"] )
					PinkRnd:SetTooltip("Round when Pink Zombies can start appearing. (-1 for on Power)")
					PinkRnd.DataChanged = function( _, val ) valz["PinkRnd"] = val end
				
					----- Cataylsts -----
					local Row57 = DProperties3:CreateRow( "Catalyst Zombies", "Catalyst Zombies" )
					Row57:Setup( "Boolean" )
					Row57:SetValue( valz["Row57"] )
					Row57.DataChanged = function( _, val ) valz["Row57"] = val end
					Row57:SetTooltip("Enable for Catalyst zombies to appear in your config.")

					-- Poison --
					local PoisonChance = DProperties3:CreateRow("Catalyst Zombies", "Poison Chance")
					PoisonChance:Setup( "Integer" )
					PoisonChance:SetValue( valz["PoisonChance"] )
					PoisonChance:SetTooltip("Chance of Zombies turning into Poison Catalysts. (0 to disable)")
					PoisonChance.DataChanged = function( _, val ) valz["PoisonChance"] = val end
				
					local PoisonRnd = DProperties3:CreateRow("Catalyst Zombies", "Poison Round")
					PoisonRnd:Setup( "Integer" )
					PoisonRnd:SetValue( valz["PoisonRnd"] )
					PoisonRnd:SetTooltip("Round when Poison Cataylsts can start appearing. (-1 for on Power)")
					PoisonRnd.DataChanged = function( _, val ) valz["PoisonRnd"] = val end
				
					-- Water --
					local WaterChance = DProperties3:CreateRow("Catalyst Zombies", "Water Chance")
					WaterChance:Setup( "Integer" )
					WaterChance:SetValue( valz["WaterChance"] )
					WaterChance:SetTooltip("Chance of Zombies turning into Water Catalysts. (0 to disable)")
					WaterChance.DataChanged = function( _, val ) valz["WaterChance"] = val end
				
					local WaterRnd = DProperties3:CreateRow("Catalyst Zombies", "Water Round")
					WaterRnd:Setup( "Integer" )
					WaterRnd:SetValue( valz["WaterRnd"] )
					WaterRnd:SetTooltip("Round when Water Catalysts can start appearing. (-1 for on Power)")
					WaterRnd.DataChanged = function( _, val ) valz["WaterRnd"] = val end
				
					-- Fire --
					local FireChance = DProperties3:CreateRow("Catalyst Zombies", "Fire Chance")
					FireChance:Setup( "Integer" )
					FireChance:SetValue( valz["FireChance"] )
					FireChance:SetTooltip("Chance of Zombies turning into Fire Catalysts. (0 to disable)")
					FireChance.DataChanged = function( _, val ) valz["FireChance"] = val end
				
					local FireRnd = DProperties3:CreateRow("Catalyst Zombies", "Fire Round")
					FireRnd:Setup( "Integer" )
					FireRnd:SetValue( valz["FireRnd"] )
					FireRnd:SetTooltip("Round when Fire Catalysts can start appearing. (-1 for on Power)")
					FireRnd.DataChanged = function( _, val ) valz["FireRnd"] = val end
				
					-- Electric --
					local ElectricChance = DProperties3:CreateRow("Catalyst Zombies", "Electric Chance")
					ElectricChance:Setup( "Integer" )
					ElectricChance:SetValue( valz["ElectricChance"] )
					ElectricChance:SetTooltip("Chance of Zombies turning into Electric Catalysts. (0 to disable)")
					ElectricChance.DataChanged = function( _, val ) valz["ElectricChance"] = val end
				
					local ElectricRnd = DProperties3:CreateRow("Catalyst Zombies", "Electric Round")
					ElectricRnd:Setup( "Integer" )
					ElectricRnd:SetValue( valz["ElectricRnd"] )
					ElectricRnd:SetTooltip("Round when Electric Catalysts can start appearing. (-1 for on Power)")
					ElectricRnd.DataChanged = function( _, val ) valz["ElectricRnd"] = val end
				
				--[[-------------------------------------------------------------------------
				Catalysts and ZCT and Burning
				---------------------------------------------------------------------------]]
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
			if !valz["Row8"] then data.bosstype = "Panzer" else data.bosstype = valz["Row8"] end
			if !tonumber(valz["Row9"]) then data.startingspawns = 35 else data.startingspawns = tonumber(valz["Row9"]) end
			if !tonumber(valz["Row10"]) then data.spawnperround = 0 else data.spawnperround = tonumber(valz["Row10"]) end
			if !tonumber(valz["Row11"]) then data.maxspawns = 35 else data.maxspawns = tonumber(valz["Row11"]) end
			if !tonumber(valz["Row13"]) then data.zombiesperplayer = 0 else data.zombiesperplayer = tonumber(valz["Row13"]) end
			if !tonumber(valz["Row14"]) then data.spawnsperplayer = 0 else data.spawnsperplayer = tonumber(valz["Row14"]) end
			if !tonumber(valz["SpawnDelay"]) then data.spawndelay = 2 else data.spawndelay = tonumber(valz["SpawnDelay"]) end
			if !valz["Row15"] then data.zombietype = "Kino der Toten" else data.zombietype = valz["Row15"] end
			if !valz["Row16"] then data.hudtype = "Black Ops 1" else data.hudtype = valz["Row16"] end
			if !istable(valz["Row17"]) then data.zombieeyecolor = Color(0, 255, 255, 255) else data.zombieeyecolor = valz["Row17"] end
			if !valz["Row18"] then data.perkmachinetype = "Original" else data.perkmachinetype = valz["Row18"] end
			if !valz["Row19"] then data.boxtype = "Original" else data.boxtype= valz["Row19"] end
			if !istable(valz["Row20"]) then data.boxlightcolor = Color(0, 150,200,255) else data.boxlightcolor = valz["Row20"] end
			if !valz["Row33"] then data.mainfont = "Default NZR" else data.mainfont = valz["Row33"] end
			if !valz["Row34"] then data.smallfont = "Default NZR" else data.smallfont = valz["Row34"] end
			if !valz["Row35"] then data.mediumfont = "Default NZR" else data.mediumfont = valz["Row35"] end
			if !valz["Row36"] then data.roundfont = "Classic NZ" else data.roundfont = valz["Row36"] end
			if !valz["Row37"] then data.ammofont = "Default NZR" else data.ammofont = valz["Row37"] end
			if !valz["Row38"] then data.ammo2font = "Default NZR" else data.ammo2font = valz["Row38"] end
			if !istable(valz["Row39"]) then data.textcolor = Color(0, 255, 255, 255) else data.textcolor = valz["Row39"] end
			if !tonumber(valz["Row40"]) then data.fontthicc  = 2 else data.fontthicc  = tonumber(valz["Row40"]) end
			if !valz["Row41"] then data.icontype = "Rezzurrection" else data.icontype = valz["Row41"] end
			if !valz["Row42"] then data.perkupgrades = false else data.perkupgrades = tobool(valz["Row42"]) end
			if !valz["Row43"] then data.PAPtype = "Original" else data.PAPtype = valz["Row43"] end
			if !valz["Row44"] then data.PAPcamo = "nz_classic" else data.PAPcamo = valz["Row44"] end
			if !tonumber(valz["Row45"]) then data.hp = 100 else data.hp = tonumber(valz["Row45"]) end
			if !tonumber(valz["Row46"]) then data.range = 0 else data.range = tonumber(valz["Row46"]) end
			if !valz["Row49"] then data.speedmulti = 4 else data.speedmulti = tonumber(valz["Row49"]) end
			if !valz["Row50"] then data.amountcap = 240 else data.amountcap = tonumber(valz["Row50"]) end -- world the change, my good evening message. final. :jack_o_lantern:
			if !valz["HealthStart"] then data.healthstart = 75 else data.healthstart = tonumber(valz["HealthStart"]) end
			if !valz["HealthIncrement"] then data.healthinc = 50 else data.healthinc = tonumber(valz["HealthIncrement"]) end
			if !valz["HealthMultiplier"] then data.healthmult = 0.1 else data.healthmult = tonumber(valz["HealthMultiplier"]) end
			if !valz["HealthCap"] then data.healthcap = 60000 else data.healthcap = tonumber(valz["HealthCap"]) end
			if !valz["Row51"] then data.navgroupbased = nil else data.navgroupbased = valz["Row51"] end
			if !valz["Row52"] then data.sidestepping = nil else data.sidestepping = valz["Row52"] end
			if !valz["Row54"] then data.badattacks = nil else data.badattacks = valz["Row54"] end
			if !valz["Row56"] then data.zct = nil else data.zct = valz["Row56"] end
			if !valz["Row57"] then data.mutated = nil else data.mutated = valz["Row57"] end
			if !valz["Row58"] then data.aats = 2 else data.aats = tonumber(valz["Row58"]) end
			if !valz["Row59"] then data.poweruptype = "Black Ops 1" else data.poweruptype = tostring(valz["Row59"]) end
			if !valz["Row60"] then data.mmohudtype = "World at War/ Black Ops 1" else data.mmohudtype = tostring(valz["Row60"]) end
			if !valz["Row61"] then data.downsoundtype = "Black Ops 3" else data.downsoundtype = tostring(valz["Row61"]) end
			if !valz["Row62"] then data.solorevive = 3 else data.solorevive = tonumber(valz["Row62"]) end
			if valz["Row63"] == nil then data.modifierslot = true else data.modifierslot = tobool(valz["Row63"]) end
			if !valz["Row64"] then data.dontkeepperks = false else data.dontkeepperks = tobool(valz["Row64"]) end
			if !valz["Row65"] then data.powerupstyle = "style_classic" else data.powerupstyle = tostring(valz["Row65"]) end
			if !valz["Row66"] then data.antipowerups = false else data.antipowerups = tobool(valz["Row66"]) end
			if !valz["Row67"] then data.antipowerupchance = 40 else data.antipowerupchance = tonumber(valz["Row67"]) end
			if !valz["Row68"] then data.antipowerupstart = 2 else data.antipowerupstart = tonumber(valz["Row68"]) end
			if !valz["Row69"] then data.antipowerupdelay = 4 else data.antipowerupdelay = tonumber(valz["Row69"]) end
			if !valz["Row70"] then data.powerupoutline = 0 else data.powerupoutline = tonumber(valz["Row70"]) end
			if valz["Row71"] == nil then data.roundperkbonus = true else data.roundperkbonus = tobool(valz["Row71"]) end
			if !valz["TurnedNames"] then data.turnedlist = {} else data.turnedlist = valz["TurnedNames"] end
			if !valz["RBoxWeps"] or table.Count(valz["RBoxWeps"]) < 1 then data.rboxweps = nil else data.rboxweps = valz["RBoxWeps"] end
			if !valz["PowerupColors"] then
				data.powerupcol = {
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
			else
				data.powerupcol = valz["PowerupColors"]
			end
			if !valz["PAPMuzzle"] then
				data.papmuzzlecol = {
					[1] = Vector(0.470,0,1),
					[2] = Vector(0.431,0.156,1),
					[3] = Vector(0.647,0.549,1),
					[4] = Vector(0.196,0.078,0.431),
					[5] = Vector(0.235,0.078,0.705),
				}
			else
				data.papmuzzlecol = valz["PAPMuzzle"]
			end
			if !valz["WallbuyColors"] then
				data.wallbuydata = {
					["glow"] = (nzMapping.Settings.boxlightcolor or valz["Row20"] or Color(0,150,200,255)),
					["chalk"] = Color(255,255,255,255),
					["alpha"] = 30,
					["material"] = "sprites/wallbuy_light.vmt",
					["sizew"] = 128,
					["sizeh"] = 42,
				}
			else
				data.wallbuydata = valz["WallbuyColors"]
			end
			if valz["Wunderfizz"] == nil then data.wunderfizzperklist = wunderfizzlist else data.wunderfizzperklist = valz["Wunderfizz"] end
			if valz["PowerUps"] == nil then data.poweruplist = poweruplist else data.poweruplist = valz["PowerUps"] end
			if valz["GumsList"] == nil then data.gumlist = gumlist else data.gumlist = valz["GumsList"] end
			if valz["GumRoundPrices"] == nil then data.gumpricelist = nzGum.RoundPrices else data.gumpricelist = valz["GumRoundPrices"] end
			if valz["GumChanceMults"] == nil then data.gummultipliers = nzGum.ChanceMultiplier else data.gummultipliers = valz["GumChanceMults"] end
			if valz["GumResetRounds"] == nil then data.gumcountresetrounds = nzGum.RollCountResetRounds else data.gumcountresetrounds = valz["GumResetRounds"] end

			--[[
			if valz["ACRow1"] == nil then data.ac = false else data.ac = tobool(valz["ACRow1"]) end
			if valz["ACRow2"] == nil then data.acwarn = nil else data.acwarn = tobool(valz["ACRow2"]) end
			if valz["ACRow3"] == nil then data.acsavespot = nil else data.acsavespot = tobool(valz["ACRow3"]) end
			if valz["ACRow4"] == nil then data.actptime = 5 else data.actptime = valz["ACRow4"] end
			if valz["ACRow5"] == nil then data.acpreventboost = true else data.acpreventboost = tobool(valz["ACRow5"]) end
			if valz["ACRow6"] == nil then data.acpreventcjump = false else data.acpreventcjump = tobool(valz["ACRow6"]) end
			]]

			if !valz["TimedGameplay"] then data.timedgame 					= nil else data.timedgame 			= valz["TimedGameplay"] end
			if !valz["TimedGameplayTime"] then data.timedgametime 			= 120 else data.timedgametime 		= tonumber(valz["TimedGameplayTime"]) end
			if !valz["TimedGameplayMaxTime"] then data.timedgamemaxtime 	= 600 else data.timedgamemaxtime 	= tonumber(valz["TimedGameplayMaxTime"]) end

			if !valz["ColdWarPoints"] then data.cwpointssystem 				= nil else data.cwpointssystem 		= valz["ColdWarPoints"] end

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
		--MapSDermaButton:Dock(BOTTOM)
		MapSDermaButton:SetPos( 10, 430 )

		MapSDermaButton:SetSize( 480, 30 )
		MapSDermaButton.DoClick = UpdateData
		
		local function AddEyeStuff()
			local eyePanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Eye Color", eyePanel, "icon16/palette.png", false, false, "Set the eye glow color the zombies have.")
			eyePanel:DockPadding(5, 5, 5, 5)
			local colorChoose = vgui.Create("DColorMixer", eyePanel)
			colorChoose:SetColor(valz["Row17"])
			colorChoose:SetPalette(false)
			colorChoose:SetAlphaBar(false)
			colorChoose:Dock(TOP)
			colorChoose:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", eyePanel)
			presets:SetSize(335, 20)
			presets:SetPos(5, 225)
			presets:Dock(BOTTOM)
			presets:AddChoice("Richtofen")
			presets:AddChoice("Samantha")
			presets:AddChoice("Avogadro")
			presets:AddChoice("Warden")
			presets:AddChoice("Laby")
			presets:AddChoice("Ghostlymoo")
			presets:AddChoice("Meme Demon")
			presets:AddChoice("Rainbow Bot")
			presets:AddChoice("FlamingFox")
			presets:AddChoice("Afton")
			presets:AddChoice("Loonicity")
			presets.OnSelect = function(self, index, value)
				if (value == "Richtofen") then
					colorChoose:SetColor(Color(0, 255, 255))
				elseif (value == "Samantha") then
					colorChoose:SetColor(Color(255, 145, 0))
				elseif (value == "Avogadro") then
					colorChoose:SetColor(Color(255, 255, 255))
				elseif (value == "Laby") then
					colorChoose:SetColor(Color(34, 177, 76))
				elseif (value == "Ghostlymoo") then
					colorChoose:SetColor(Color(73, 20, 207))
				elseif (value == "Meme Demon") then
					colorChoose:SetColor(Color(241, 224, 75))
				elseif (value == "Rainbow Bot") then
					colorChoose:SetColor(Color(241, 75, 238))	
				elseif (value == "FlamingFox") then
					colorChoose:SetColor(Color(255, 102, 0))	
				elseif (value == "Afton") then
					colorChoose:SetColor(Color(182, 231, 35))	
				elseif (value == "Loonicity") then
					colorChoose:SetColor(Color(188, 21, 85))							
				elseif (value == "Warden") then
					colorChoose:SetColor(Color(255, 0, 0))	
				end

				colorChoose:ValueChanged(nil)
			end

			colorChoose.ValueChanged = function(col)
				valz["Row17"] = colorChoose:GetColor()
			end
		end
		
		local function AddBoxStuff()
			local boxlightPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Box Color", boxlightPanel, "icon16/palette.png", false, false, "Set the color of the Mystery Box light.")
			boxlightPanel:DockPadding(5, 5, 5, 5)
			local colorChoose2 = vgui.Create("DColorMixer", boxlightPanel)
			colorChoose2:SetColor(valz["Row20"])
			colorChoose2:SetPalette(false)
			colorChoose2:SetAlphaBar(false)
			colorChoose2:Dock(TOP)
			colorChoose2:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", boxlightPanel)
			presets:SetSize(60, 20)
			presets:Dock(BOTTOM)
			presets:AddChoice("Default")
			presets:AddChoice("Mob of the Dead")
			presets:AddChoice("Shi No Numa")
			presets:AddChoice("Revelations")
			presets:AddChoice("Halloween")
			presets:AddChoice("UGX 1.1")
			presets:AddChoice("Infinite Warfare")
			presets:AddChoice("WW2")
			presets:AddChoice("No Light")
			presets:AddChoice("Pink")			
			presets.OnSelect = function(self, index, value)
				if (value == "Default") then
					colorChoose2:SetColor(Color(150,200,255))
				elseif (value == "Shi No Numa") then
					colorChoose2:SetColor(Color(185, 255, 35))	
				elseif (value == "Revelations") then
					colorChoose2:SetColor(Color(42, 249, 31))	
				elseif (value == "Halloween") then
					colorChoose2:SetColor(Color(217, 37, 9))	
				elseif (value == "UGX 1.1") then
					colorChoose2:SetColor(Color(255, 0, 0))	
				elseif (value == "Infinite Warfare") then
					colorChoose2:SetColor(Color(54, 15, 132))	
				elseif (value == "WW2") then
					colorChoose2:SetColor(Color(59, 0, 0))	
				elseif (value == "Mob of the Dead") then
					colorChoose2:SetColor(Color(204, 102, 0))	
				elseif (value == "No Light") then
					colorChoose2:SetColor(Color(0, 0, 0))	
				elseif (value == "Pink") then
					colorChoose2:SetColor(Color(246, 0, 255))	
				end

				colorChoose2:ValueChanged(nil)
			end

			colorChoose2.ValueChanged = function(col)
				valz["Row20"] = colorChoose2:GetColor()
			end
		end
		
		local function AddFontColor()
			local fontPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Font Color", fontPanel, "icon16/palette.png", false, false, "Set the color of the various fonts.")
			fontPanel:DockPadding(5, 5, 5, 5)
			local fontColorChoice = vgui.Create("DColorMixer", fontPanel)
			fontColorChoice:SetColor(valz["Row39"])
			fontColorChoice:SetPalette(false)
			fontColorChoice:SetAlphaBar(false)
			fontColorChoice:Dock(TOP)
			fontColorChoice:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", fontPanel)
			presets:SetSize(60, 20)
			presets:Dock(BOTTOM)
			presets:AddChoice("Default")
			presets.OnSelect = function(self, index, value)
				if (value == "Default") then
					fontColorChoice:SetColor(Color(255,255,255))
				end

				fontColorChoice:ValueChanged(nil)
			end

			fontColorChoice.ValueChanged = function(col)
				valz["Row39"] = fontColorChoice:GetColor()
			end
		end

		local function AddWallbuyColors()
			local wallbuyPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Wallbuy Colors", wallbuyPanel, "icon16/palette.png", false, false, "Set the colors for wallbuy chalk outlines, and the wallbuy glow.")
			wallbuyPanel:DockPadding(5, 5, 5, 5)

			local textw1 = vgui.Create("DLabel", wallbuyPanel)
			local textw2 = vgui.Create("DLabel", wallbuyPanel)
			
			local wallbuyColorGlow = vgui.Create("DColorMixer", wallbuyPanel)
			local wallbuyColorChalk = vgui.Create("DColorMixer", wallbuyPanel)
			local wallbuyColorAlpha = vgui.Create("DNumSlider", wallbuyPanel)
			
			local wallbuybar1 = vgui.Create("DImage", wallbuyPanel)
			local wallbuyresetcol = vgui.Create("DButton", wallbuyPanel)
			local wallbuyresetmat = vgui.Create("DButton", wallbuyPanel)
			local wallbuybar2 = vgui.Create("DImage", wallbuyPanel)

			local textw3 = vgui.Create("DLabel", wallbuyPanel)

			local wallbuyColorSizeX = vgui.Create("DNumberWang", wallbuyPanel)
			local wallbuyColorSizeY = vgui.Create("DNumberWang", wallbuyPanel)
			local wallbuyColorMat = vgui.Create("DTextEntry", wallbuyPanel)

			local textw = vgui.Create("DLabel", wallbuyColorSizeX)
			local texth = vgui.Create("DLabel", wallbuyColorSizeY)

			local wallbuyBack = vgui.Create("DImage", wallbuyPanel)
			local wallbuyImage = vgui.Create("DImage", wallbuyPanel)
			local wallbuyDrag = vgui.Create("DImage", wallbuyPanel)
			local textw4 = vgui.Create("DLabel", wallbuyImage)

			textw1:SetText("Wallbuy Glow Color")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(15, 0)

			wallbuyColorGlow:SetColor(valz["WallbuyColors"]["glow"])
			wallbuyColorGlow:SetPalette(false)
			wallbuyColorGlow:SetAlphaBar(false)
			wallbuyColorGlow:SetPos(10, 15)
			wallbuyColorGlow:SetSize(200, 150)
			wallbuyColorGlow.ValueChanged = function(col)
				timer.Simple(0, function()
					valz["WallbuyColors"]["glow"] = wallbuyColorGlow:GetColor()
				end)
			end

			textw2:SetText("Wallbuy Chalk Color")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(260, 0)

			wallbuyColorChalk:SetColor(valz["WallbuyColors"]["chalk"])
			wallbuyColorChalk:SetPalette(false)
			wallbuyColorChalk:SetAlphaBar(false)
			wallbuyColorChalk:SetPos(255, 15)
			wallbuyColorChalk:SetSize(200, 150)
			wallbuyColorChalk.ValueChanged = function(col)
				timer.Simple(0, function()
					valz["WallbuyColors"]["chalk"] = wallbuyColorChalk:GetColor()
				end)
			end

			wallbuyColorAlpha:SetText("Glow Alpha")
			wallbuyColorAlpha:SetPos(10, 165)
			wallbuyColorAlpha:SetSize(460, 30)
			wallbuyColorAlpha.Label:SetTextColor(color_black)
			wallbuyColorAlpha:SetMin(0)
			wallbuyColorAlpha:SetMax(255)
			wallbuyColorAlpha:SetDecimals(0)
			wallbuyColorAlpha:SetValue(valz["WallbuyColors"]["alpha"])
			wallbuyColorAlpha.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["alpha"] = wallbuyColorAlpha:GetValue()
				end)
			end

			wallbuybar1:SetPos(0, 195)
			wallbuybar1:SetImage("color")
			wallbuybar1:SetImageColor(Color(200,200,200,255))
			wallbuybar1:SetSize(470, 5)
			
			wallbuybar2:SetPos(0, 240)
			wallbuybar2:SetImage("color")
			wallbuybar2:SetImageColor(Color(200,200,200,255))
			wallbuybar2:SetSize(470, 5)
			
			textw3:SetText("Wallbuy Glow Texture")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(150, 335)

			wallbuyBack:SetPos(10, 250)
			wallbuyBack:SetImage("color")
			wallbuyBack:SetImageColor(color_black)
			wallbuyBack:SetSize(96, 96)

			wallbuyImage:SetPos(10, 250)
			wallbuyImage:SetSize(96, 96)
			wallbuyImage:SetImage(string.StripExtension(valz["WallbuyColors"]["material"]))

			textw4:SetText("Previvew")
			textw4:SetFont("Trebuchet18")
			textw4:SetTextColor(color_red)
			textw4:SizeToContents()
			textw4:CenterHorizontal()

			wallbuyDrag:SetMouseInputEnabled(true)
			wallbuyDrag:Droppable("godhelpwhatfuck")
			wallbuyDrag:SetPos(10, 250)
			wallbuyDrag:SetImage("color")
			wallbuyDrag:SetImageColor(color_transparent)
			wallbuyDrag:SetSize(96, 96)
			wallbuyDrag.Think = function()
				if wallbuyDrag:IsDragging() then
					local x, y = DProperties:CursorPos()
					local maxx, maxy = sheet:GetSize()
					x = math.Clamp(x, 0, maxx)
					y = math.Clamp(y, 0, maxy-30)
					x = x - 48
					y = y - 48

					wallbuyDrag:SetPos(x, y)
					wallbuyImage:SetPos(x, y)
					wallbuyBack:SetPos(x, y)
					textw4:CenterHorizontal()
				end
			end

			wallbuyColorSizeX:SetPos(10, 350)
			wallbuyColorSizeX:SetSize(60, 30)
			wallbuyColorSizeX:SetMin(0)
			wallbuyColorSizeX:SetMax(512)
			wallbuyColorSizeX:SetDecimals(0)
			wallbuyColorSizeX:SetValue(valz["WallbuyColors"]["sizew"])
			wallbuyColorSizeX.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["sizew"] = wallbuyColorSizeX:GetValue()
				end)
			end

			wallbuyColorSizeY:SetPos(80, 350)
			wallbuyColorSizeY:SetSize(60, 30)
			wallbuyColorSizeY:SetMin(0)
			wallbuyColorSizeY:SetMax(512)
			wallbuyColorSizeY:SetDecimals(0)
			wallbuyColorSizeY:SetValue(valz["WallbuyColors"]["sizeh"])
			wallbuyColorSizeY.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["sizeh"] = wallbuyColorSizeY:GetValue()
				end)
			end

			textw:SetText("(W)")
			textw:SetFont("Trebuchet18")
			textw:SetTextColor(color_red)
			textw:SizeToContents()
			textw:AlignRight(20)

			texth:SetText("(H)")
			texth:SetFont("Trebuchet18")
			texth:SetTextColor(color_red)
			texth:SizeToContents()
			texth:AlignRight(20)

			wallbuyColorMat:SetPlaceholderText("Glow Texture (VMT ONLY!!!!)")
			wallbuyColorMat:SetPos(150, 350)
			wallbuyColorMat:SetSize(255, 30)
			wallbuyColorMat:SetValue(valz["WallbuyColors"]["material"])
			wallbuyColorMat.OnTextChanged = function(val)
				local cheatingtime = "nz-wallbuy_Colorer_"
				local ourval = wallbuyColorMat:GetValue()
				if ourval == "" then return end
				if timer.Exists(cheatingtime) then timer.Remove(cheatingtime) end
				timer.Create(cheatingtime, 0.65, 1, function()
					if file.Exists("materials/"..ourval, "GAME") then
						valz["WallbuyColors"]["material"] = ourval
						wallbuyImage:SetImage(string.StripExtension(ourval))
					end
				end)
			end

			wallbuyresetcol:SetText("Reset Colors to Default")
			wallbuyresetcol:SetPos(45, 205)
			wallbuyresetcol:SetSize(180, 30)
			wallbuyresetcol.DoClick = function()
				valz["WallbuyColors"]["glow"] = nzMapping.Settings.boxlightcolor or Color(0,150,200,255)
				valz["WallbuyColors"]["chalk"] = Color(255,255,255,255)
				valz["WallbuyColors"]["alpha"] = 30
				wallbuyColorGlow:SetColor(valz["WallbuyColors"]["glow"])
				wallbuyColorChalk:SetColor(valz["WallbuyColors"]["chalk"])
				wallbuyColorAlpha:SetValue(valz["WallbuyColors"]["alpha"])
			end

			wallbuyresetmat:SetText("Reset Material to Default")
			wallbuyresetmat:SetPos(240, 205)
			wallbuyresetmat:SetSize(180, 30)
			wallbuyresetmat.DoClick = function()
				valz["WallbuyColors"]["material"] = "sprites/wallbuy_light.vmt"
				valz["WallbuyColors"]["sizew"] = 128
				valz["WallbuyColors"]["sizeh"] = 42
				wallbuyColorMat:SetValue(valz["WallbuyColors"]["material"])
				wallbuyColorSizeX:SetValue(valz["WallbuyColors"]["sizew"])
				wallbuyColorSizeY:SetValue(valz["WallbuyColors"]["sizeh"])
			end
		end

		local function AddPowerupColors()
			local powColPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Powerup Colors", powColPanel, "icon16/palette.png", false, false, "Set the different glow colors for Powerups.")
			powColPanel:DockPadding(5, 5, 5, 5)

			local thefuckening = vgui.Create("DScrollPanel", powColPanel)
			thefuckening:SetPos(0, 15)
			thefuckening:SetSize(464, 376)
			thefuckening:SetPaintBackground(true)
			thefuckening:SetBackgroundColor(Color(225, 225, 225))

			local textw1 = vgui.Create("DLabel", powColPanel)
			textw1:SetText("Main")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(10, 0)

			local textw2 = vgui.Create("DLabel", powColPanel)
			textw2:SetText("Accent")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(165, 0)

			local textw3 = vgui.Create("DLabel", powColPanel)
			textw3:SetText("Extra")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(320, 0)

			local globalstored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][1] or valz["PowerupColors"]["global"][1]
			local colorChooseGlobal = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal:SetColor(Color(math.Round(globalstored[1]*255),math.Round(globalstored[2]*255),math.Round(globalstored[3]*255), 255))
			colorChooseGlobal:SetPalette(false)
			colorChooseGlobal:SetAlphaBar(false)
			colorChooseGlobal:SetWangs(true)
			colorChooseGlobal:SetPos(5, 30)
			colorChooseGlobal:SetSize(150, 120)

			colorChooseGlobal.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal:GetColor()
					valz["PowerupColors"]["global"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local globalstored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][2] or valz["PowerupColors"]["global"][2]
			local colorChooseGlobal2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal2:SetColor(Color(math.Round(globalstored2[1]*255),math.Round(globalstored2[2]*255),math.Round(globalstored2[3]*255), 255))
			colorChooseGlobal2:SetPalette(false)
			colorChooseGlobal2:SetAlphaBar(false)
			colorChooseGlobal2:SetWangs(true)
			colorChooseGlobal2:SetPos(160, 30)
			colorChooseGlobal2:SetSize(150, 120)

			colorChooseGlobal2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal2:GetColor()
					valz["PowerupColors"]["global"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local globalstored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][3] or valz["PowerupColors"]["global"][3]
			local colorChooseGlobal3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal3:SetColor(Color(math.Round(globalstored3[1]*255),math.Round(globalstored3[2]*255),math.Round(globalstored3[3]*255), 255))
			colorChooseGlobal3:SetPalette(false)
			colorChooseGlobal3:SetAlphaBar(false)
			colorChooseGlobal3:SetWangs(true)
			colorChooseGlobal3:SetPos(315, 30)
			colorChooseGlobal3:SetSize(150, 120)

			colorChooseGlobal3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal3:GetColor()
					valz["PowerupColors"]["global"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype1 = vgui.Create("DLabel", thefuckening)
			ptype1:SetText("Global Powerups")
			ptype1:SetFont("Trebuchet18")
			ptype1:SetTextColor(color_red)
			ptype1:SizeToContents()
			ptype1:SetPos(180, 15)

			local globalreset = vgui.Create("DButton", thefuckening)
			globalreset:SetText("Reset Global Colors")
			globalreset:SetPos(5, 10)
			globalreset:SizeToContents()
			globalreset.DoClick = function()
				colorChooseGlobal:SetColor(Color(math.Round(0.196*255),math.Round(1*255),0,255))
				colorChooseGlobal2:SetColor(Color(math.Round(0.568*255),math.Round(1*255),math.Round(0.29*255),255))
				colorChooseGlobal3:SetColor(Color(math.Round(0.262*255),math.Round(0.666*255),0,255))
				valz["PowerupColors"]["global"][1] = Vector(0.196,1,0)
				valz["PowerupColors"]["global"][2] = Vector(0.568,1,0.29)
				valz["PowerupColors"]["global"][3] = Vector(0.262,0.666,0)
			end

			local localstored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][1] or valz["PowerupColors"]["local"][1]
			local colorChooseLocal = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal:SetColor(Color(math.Round(localstored[1]*255),math.Round(localstored[2]*255),math.Round(localstored[3]*255), 255))
			colorChooseLocal:SetPalette(false)
			colorChooseLocal:SetAlphaBar(false)
			colorChooseLocal:SetPos(5, 180)
			colorChooseLocal:SetSize(150, 120)

			colorChooseLocal.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal:GetColor()
					valz["PowerupColors"]["local"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local localstored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][2] or valz["PowerupColors"]["local"][2]
			local colorChooseLocal2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal2:SetColor(Color(math.Round(localstored2[1]*255),math.Round(localstored2[2]*255),math.Round(localstored2[3]*255), 255))
			colorChooseLocal2:SetPalette(false)
			colorChooseLocal2:SetAlphaBar(false)
			colorChooseLocal2:SetPos(160, 180)
			colorChooseLocal2:SetSize(150, 120)

			colorChooseLocal2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal2:GetColor()
					valz["PowerupColors"]["local"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local localstored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][3] or valz["PowerupColors"]["local"][3]
			local colorChooseLocal3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal3:SetColor(Color(math.Round(localstored3[1]*255),math.Round(localstored3[2]*255),math.Round(localstored3[3]*255), 255))
			colorChooseLocal3:SetPalette(false)
			colorChooseLocal3:SetAlphaBar(false)
			colorChooseLocal3:SetPos(315, 180)
			colorChooseLocal3:SetSize(150, 120)

			colorChooseLocal3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal3:GetColor()
					valz["PowerupColors"]["local"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype2 = vgui.Create("DLabel", thefuckening)
			ptype2:SetText("Local Powerups")
			ptype2:SetFont("Trebuchet18")
			ptype2:SetTextColor(color_red)
			ptype2:SizeToContents()
			ptype2:SetPos(180, 165)

			local localreset = vgui.Create("DButton", thefuckening)
			localreset:SetText("Reset Local Colors")
			localreset:SetPos(5, 160)
			localreset:SizeToContents()
			localreset.DoClick = function()
				colorChooseLocal:SetColor(Color(math.Round(0.372*255),math.Round(1*255),math.Round(0.951*255),255))
				colorChooseLocal2:SetColor(Color(math.Round(0.556*255),math.Round(1*255),math.Round(0.99*255),255))
				colorChooseLocal3:SetColor(Color(math.Round(0*255),math.Round(0.64*255),math.Round(0.666*255),255))
				valz["PowerupColors"]["local"][1] = Vector(0.372,1,0.951)
				valz["PowerupColors"]["local"][2] = Vector(0.556,1,0.99)
				valz["PowerupColors"]["local"][3] = Vector(0,0.64,0.666)
			end

			local ministored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][1] or valz["PowerupColors"]["mini"][1]
			local colorChooseMini = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini:SetColor(Color(math.Round(ministored[1]*255),math.Round(ministored[2]*255),math.Round(ministored[3]*255), 255))
			colorChooseMini:SetPalette(false)
			colorChooseMini:SetAlphaBar(false)
			colorChooseMini:SetPos(5, 330)
			colorChooseMini:SetSize(150, 120)

			colorChooseMini.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini:GetColor()
					valz["PowerupColors"]["mini"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ministored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][2] or valz["PowerupColors"]["mini"][2]
			local colorChooseMini2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini2:SetColor(Color(math.Round(ministored2[1]*255),math.Round(ministored2[2]*255),math.Round(ministored2[3]*255), 255))
			colorChooseMini2:SetPalette(false)
			colorChooseMini2:SetAlphaBar(false)
			colorChooseMini2:SetPos(160, 330)
			colorChooseMini2:SetSize(150, 120)

			colorChooseMini2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini2:GetColor()
					valz["PowerupColors"]["mini"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ministored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][3] or valz["PowerupColors"]["mini"][3]
			local colorChooseMini3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini3:SetColor(Color(math.Round(ministored3[1]*255),math.Round(ministored3[2]*255),math.Round(ministored3[3]*255), 255))
			colorChooseMini3:SetPalette(false)
			colorChooseMini3:SetAlphaBar(false)
			colorChooseMini3:SetPos(315, 330)
			colorChooseMini3:SetSize(150, 120)

			colorChooseMini3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini3:GetColor()
					valz["PowerupColors"]["mini"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype3 = vgui.Create("DLabel", thefuckening)
			ptype3:SetText("Mini Powerups")
			ptype3:SetFont("Trebuchet18")
			ptype3:SetTextColor(color_red)
			ptype3:SizeToContents()
			ptype3:SetPos(180, 315)

			local minireset = vgui.Create("DButton", thefuckening)
			minireset:SetText("Reset Mini Colors")
			minireset:SetPos(5, 310)
			minireset:SizeToContents()
			minireset.DoClick = function()
				colorChooseMini:SetColor(Color(math.Round(1*255),math.Round(0.823*255),math.Round(0*255),255))
				colorChooseMini2:SetColor(Color(math.Round(1*255),math.Round(0.854*255),math.Round(0.549*255),255))
				colorChooseMini3:SetColor(Color(math.Round(0.627*255),math.Round(0.431*255),math.Round(0*255),255))
				valz["PowerupColors"]["mini"][1] = Vector(1,0.823,0)
				valz["PowerupColors"]["mini"][2] = Vector(1,0.854,0.549)
				valz["PowerupColors"]["mini"][3] = Vector(0.627,0.431,0)
			end

			local antistored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][1] or valz["PowerupColors"]["anti"][1]
			local colorChooseAnti = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti:SetColor(Color(math.Round(antistored[1]*255),math.Round(antistored[2]*255),math.Round(antistored[3]*255), 255))
			colorChooseAnti:SetPalette(false)
			colorChooseAnti:SetAlphaBar(false)
			colorChooseAnti:SetPos(5, 480)
			colorChooseAnti:SetSize(150, 120)

			colorChooseAnti.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti:GetColor()
					valz["PowerupColors"]["anti"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local antistored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][2] or valz["PowerupColors"]["anti"][2]
			local colorChooseAnti2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti2:SetColor(Color(math.Round(antistored2[1]*255),math.Round(antistored2[2]*255),math.Round(antistored2[3]*255), 255))
			colorChooseAnti2:SetPalette(false)
			colorChooseAnti2:SetAlphaBar(false)
			colorChooseAnti2:SetPos(160, 480)
			colorChooseAnti2:SetSize(150, 120)

			colorChooseAnti2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti2:GetColor()
					valz["PowerupColors"]["anti"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local antistored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][3] or valz["PowerupColors"]["anti"][3]
			local colorChooseAnti3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti3:SetColor(Color(math.Round(antistored3[1]*255),math.Round(antistored3[2]*255),math.Round(antistored3[3]*255), 255))
			colorChooseAnti3:SetPalette(false)
			colorChooseAnti3:SetAlphaBar(false)
			colorChooseAnti3:SetPos(315, 480)
			colorChooseAnti3:SetSize(150, 120)

			colorChooseAnti3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti3:GetColor()
					valz["PowerupColors"]["anti"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype4 = vgui.Create("DLabel", thefuckening)
			ptype4:SetText("Anti Powerups")
			ptype4:SetFont("Trebuchet18")
			ptype4:SetTextColor(color_red)
			ptype4:SizeToContents()
			ptype4:SetPos(180, 465)

			local antireset = vgui.Create("DButton", thefuckening)
			antireset:SetText("Reset Anti Colors")
			antireset:SetPos(5, 460)
			antireset:SizeToContents()
			antireset.DoClick = function()
				colorChooseAnti:SetColor(Color(math.Round(1*255),math.Round(0.156*255),math.Round(0.156*255), 255))
				colorChooseAnti2:SetColor(Color(math.Round(1*255),math.Round(0.392*255),math.Round(0.392*255), 255))
				colorChooseAnti3:SetColor(Color(math.Round(0.705*255),math.Round(0*255),math.Round(0*255), 255))
				valz["PowerupColors"]["anti"][1] = Vector(1,0.156,0.156)
				valz["PowerupColors"]["anti"][2] = Vector(1,0.392,0.392)
				valz["PowerupColors"]["anti"][3] = Vector(0.705,0,0)
			end

			local tombstonestored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][1] or valz["PowerupColors"]["tombstone"][1]
			local colorChooseTomb = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb:SetColor(Color(math.Round(tombstonestored[1]*255),math.Round(tombstonestored[2]*255),math.Round(tombstonestored[3]*255), 255))
			colorChooseTomb:SetPalette(false)
			colorChooseTomb:SetAlphaBar(false)
			colorChooseTomb:SetPos(5, 630)
			colorChooseTomb:SetSize(150, 120)

			colorChooseTomb.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTomb:GetColor()
					valz["PowerupColors"]["tombstone"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local tombstonestored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][2] or valz["PowerupColors"]["tombstone"][2]
			local colorChooseTomb2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb2:SetColor(Color(math.Round(tombstonestored2[1]*255),math.Round(tombstonestored2[2]*255),math.Round(tombstonestored2[3]*255), 255))
			colorChooseTomb2:SetPalette(false)
			colorChooseTomb2:SetAlphaBar(false)
			colorChooseTomb2:SetPos(160, 630)
			colorChooseTomb2:SetSize(150, 120)

			colorChooseTomb2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTomb2:GetColor()
					valz["PowerupColors"]["tombstone"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local tombstonestored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][3] or valz["PowerupColors"]["tombstone"][3]
			local colorChooseTomb3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb3:SetColor(Color(math.Round(tombstonestored3[1]*255),math.Round(tombstonestored3[2]*255),math.Round(tombstonestored3[3]*255), 255))
			colorChooseTomb3:SetPalette(false)
			colorChooseTomb3:SetAlphaBar(false)
			colorChooseTomb3:SetPos(315, 630)
			colorChooseTomb3:SetSize(150, 120)

			colorChooseTomb3.ValueChanged = function(col)
				timer.Simple(0, function()	
					local cum = colorChooseTomb3:GetColor()
					valz["PowerupColors"]["tombstone"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype5 = vgui.Create("DLabel", thefuckening)
			ptype5:SetText("Tombstone")
			ptype5:SetFont("Trebuchet18")
			ptype5:SetTextColor(color_red)
			ptype5:SizeToContents()
			ptype5:SetPos(180, 615)

			local tombreset = vgui.Create("DButton", thefuckening)
			tombreset:SetText("Reset Tombstone Colors")
			tombreset:SetPos(5, 610)
			tombreset:SizeToContents()
			tombreset.DoClick = function()
				colorChooseTomb:SetColor(Color(math.Round(0.568*255),math.Round(0*255),math.Round(1*255), 255))
				colorChooseTomb2:SetColor(Color(math.Round(0.705*255),math.Round(0.392*255),math.Round(1*255), 255))
				colorChooseTomb3:SetColor(Color(math.Round(0.431*255),math.Round(0*255),math.Round(0.784*255), 255))
				valz["PowerupColors"]["tombstone"][1] = Vector(0.568,0,1)
				valz["PowerupColors"]["tombstone"][2] = Vector(0.705,0.392,1)
				valz["PowerupColors"]["tombstone"][3] = Vector(0.431,0,0.784)
			end
		end

		local function AddMuzzleflashColors()
			local papflashColPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("PaP Muzzleflash Colors", papflashColPanel, "icon16/palette.png", false, false, "Sets the muzzleflash colors for weapons that use the 'muz_pap' effect.")
			papflashColPanel:DockPadding(5, 5, 5, 5)

			local textw1 = vgui.Create("DLabel", papflashColPanel)
			textw1:SetText("Core")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(10, 0)

			local textw2 = vgui.Create("DLabel", papflashColPanel)
			textw2:SetText("Cross")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(165, 0)

			local textw3 = vgui.Create("DLabel", papflashColPanel)
			textw3:SetText("Sparks")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(320, 0)

			local textw4 = vgui.Create("DLabel", papflashColPanel)
			textw4:SetText("Glow A")
			textw4:SetFont("Trebuchet18")
			textw4:SetTextColor(color_red)
			textw4:SizeToContents()
			textw4:SetPos(95, 145)

			local textw5 = vgui.Create("DLabel", papflashColPanel)
			textw5:SetText("Glow B")
			textw5:SetFont("Trebuchet18")
			textw5:SetTextColor(color_red)
			textw5:SizeToContents()
			textw5:SetPos(250, 145)

			local papcolstored = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[1] or valz["PAPMuzzle"][1]
			local colorChoosePAP1 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP1:SetColor(Color(math.Round(papcolstored[1]*255),math.Round(papcolstored[2]*255),math.Round(papcolstored[3]*255), 255))
			colorChoosePAP1:SetPalette(false)
			colorChoosePAP1:SetAlphaBar(false)
			colorChoosePAP1:SetWangs(true)
			colorChoosePAP1:SetPos(5, 15)
			colorChoosePAP1:SetSize(150, 120)

			colorChoosePAP1.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP1:GetColor()
					valz["PAPMuzzle"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored2 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[2] or valz["PAPMuzzle"][2]
			local colorChoosePAP2 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP2:SetColor(Color(math.Round(papcolstored2[1]*255),math.Round(papcolstored2[2]*255),math.Round(papcolstored2[3]*255), 255))
			colorChoosePAP2:SetPalette(false)
			colorChoosePAP2:SetAlphaBar(false)
			colorChoosePAP2:SetWangs(true)
			colorChoosePAP2:SetPos(160, 15)
			colorChoosePAP2:SetSize(150, 120)

			colorChoosePAP2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP2:GetColor()
					valz["PAPMuzzle"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored3 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[3] or valz["PAPMuzzle"][3]
			local colorChoosePAP3 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP3:SetColor(Color(math.Round(papcolstored3[1]*255),math.Round(papcolstored3[2]*255),math.Round(papcolstored3[3]*255), 255))
			colorChoosePAP3:SetPalette(false)
			colorChoosePAP3:SetAlphaBar(false)
			colorChoosePAP3:SetWangs(true)
			colorChoosePAP3:SetPos(315, 15)
			colorChoosePAP3:SetSize(150, 120)

			colorChoosePAP3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP3:GetColor()
					valz["PAPMuzzle"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored4 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[4] or valz["PAPMuzzle"][4]
			local colorChoosePAP4 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP4:SetColor(Color(math.Round(papcolstored4[1]*255),math.Round(papcolstored4[2]*255),math.Round(papcolstored4[3]*255), 255))
			colorChoosePAP4:SetPalette(false)
			colorChoosePAP4:SetAlphaBar(false)
			colorChoosePAP4:SetWangs(true)
			colorChoosePAP4:SetPos(90, 160)
			colorChoosePAP4:SetSize(150, 120)

			colorChoosePAP4.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP4:GetColor()
					valz["PAPMuzzle"][4] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored5 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[5] or valz["PAPMuzzle"][5]
			local colorChoosePAP5 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP5:SetColor(Color(math.Round(papcolstored5[1]*255),math.Round(papcolstored5[2]*255),math.Round(papcolstored5[3]*255), 255))
			colorChoosePAP5:SetPalette(false)
			colorChoosePAP5:SetAlphaBar(false)
			colorChoosePAP5:SetWangs(true)
			colorChoosePAP5:SetPos(245, 160)
			colorChoosePAP5:SetSize(150, 120)

			colorChoosePAP5.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP5:GetColor()
					valz["PAPMuzzle"][5] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papreset = vgui.Create("DButton", papflashColPanel)
			papreset:SetText("Reset Colors to Default")
			papreset:SetPos(160, 290)
			papreset:SizeToContents()
			papreset.DoClick = function()
				colorChoosePAP1:SetColor(Color(math.Round(0.470*255), 0, 255, 255))
				colorChoosePAP2:SetColor(Color(math.Round(0.431*255), math.Round(0.156*255), 255, 255))
				colorChoosePAP3:SetColor(Color(math.Round(0.647*255), math.Round(0.549*255), 255, 255))
				colorChoosePAP4:SetColor(Color(math.Round(0.196*255), math.Round(0.078*255), math.Round(0.431*255), 255))
				colorChoosePAP5:SetColor(Color(math.Round(0.235*255), math.Round(0.078*255), math.Round(0.705*255), 255))
				valz["PAPMuzzle"][1] = Vector(0.470,0,1)
				valz["PAPMuzzle"][2] = Vector(0.431,0.156,1)
				valz["PAPMuzzle"][3] = Vector(0.647,0.549,1)
				valz["PAPMuzzle"][4] = Vector(0.196,0.078,0.431)
				valz["PAPMuzzle"][5] = Vector(0.235,0.078,0.705)
			end
		end

			local weplist = {}
			local numweplist = 0

			local rboxpanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Random Box Weapons", rboxpanel, "icon16/box.png", false, false, "Set which weapons appear in the Random Box.")
			rboxpanel.Paint = function() return end

			local rbweplist = vgui.Create("DScrollPanel", rboxpanel)
			rbweplist:SetPos(0, 0)
			rbweplist:SetSize(365, 350)
			rbweplist:SetPaintBackground(true)
			rbweplist:SetBackgroundColor( color_grey_200 )

			local function InsertWeaponToList(name, class, weight, tooltip)
				weight = weight or 10
				if IsValid(weplist[class]) then return end
				weplist[class] = vgui.Create("DPanel", rbweplist)
				weplist[class]:SetSize(365, 16)
				weplist[class]:SetPos(0, numweplist*16)
				valz["RBoxWeps"][class] = weight

				local dname = vgui.Create("DLabel", weplist[class])
				dname:SetText(name)
				dname:SetTextColor(Color(50, 50, 50))
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
				for k,v in pairs(weapons.GetList()) do
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

			local wepentry = vgui.Create( "DComboBox", rboxpanel )
			wepentry:SetPos( 0, 355 )
			wepentry:SetSize( 146, 20 )
			wepentry:SetValue( "Weapon ..." )
			for k,v in pairs(weapons.GetList()) do
				if !v.NZTotalBlacklist and !v.NZPreventBox then
					if v.Category and v.Category != "" then
						local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
						wepentry:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName..special or v.ClassName, v.ClassName, false)
					else
						wepentry:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, false)
					end
				end
			end
			wepentry.OnSelect = function( panel, index, value )
			end

			local wepadd = vgui.Create( "DButton", rboxpanel )
			wepadd:SetText( "Add" )
			wepadd:SetPos( 150, 355 )
			wepadd:SetSize( 53, 20 )
			wepadd.DoClick = function()
				local v = weapons.Get(wepentry:GetOptionData(wepentry:GetSelectedID()))
				if v then
					if v.Category and v.Category != "" then
						local special = v.NZSpecialCategory and " ("..v.NZSpecialCategory..")" or ""
						InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." ["..v.Category.."]"..special)
					else
						InsertWeaponToList(v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, 10, v.ClassName.." [No Category]")
					end
				end
				wepentry:SetValue( "Weapon..." )
			end
			
			local wepmore = vgui.Create( "DButton", rboxpanel )
			wepmore:SetText( "More ..." )
			wepmore:SetPos( 207, 355 )
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
				for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
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
						for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
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
				for k,v in pairs(weapons.GetList()) do
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
						for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
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
					for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
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
					["ToolTip"] = "Sound that plays on all clients when a nuke powerup is picked up.",
					["Bind"] = valz["SndRow44"]
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
					["ToolTip"] = "Played on the powerup itself when it spawns",
					["Bind"] = valz["SndRow7"]
				},
				[2] = {
					["Title"] = "Loop",
					["ToolTip"] = "",
					["Bind"] = valz["SndRow29"]
				},
				[3] = {
					["Title"] = "Grab",
					["ToolTip"] = "When players get the powerup",
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
			local powerupCat = catList:Add("Powerups")
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
			//Gums
			------------------------------------------------------------------------
			local function AddGumStuff()
				local gumspanel = vgui.Create("DPanel", sheet)
				sheet:AddSheet("Gobble Gums", gumspanel, "icon16/sport_8ball.png", false, false, "Set which powerups can be dropped from zombies.")
				gumspanel.Paint = function() return end

				local gumslistpanel = vgui.Create("DScrollPanel", gumspanel)
				gumslistpanel:SetPos(0, 200)
				gumslistpanel:SetSize(465, 195)
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

					local gumdesc = "("..id..") "..data.desc or "No Description Available"
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
						nzMapping.Settings.gumlist[id] = {true, nzGum.RollCounts[rarity]}
						check:SetValue(true)
					end

					check.OnChange = function(self, val)
						if !valz["GumsList"][id] then
							valz["GumsList"][id] = {true, nzGum.RollCounts[rarity]}
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
					wang:SetValue(nzMapping.Settings.gumlist[id][2])
					wang.OnValueChanged = function(val)
						timer.Simple(0, function()
							valz["GumsList"][id][2] = wang:GetValue()
						end)
					end
				end

				local gumproperties = vgui.Create( "DProperties", gumspanel )
				gumproperties:SetSize(465, 200)
				gumproperties:SetPos(0, 0)

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
			local perklist = {}

			local perkpanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Wunderfizz Perks", perkpanel, "icon16/drink.png", false, false, "Set which perks appears in Der Wunderfizz.")
			perkpanel.Paint = function() return end

			local perklistpnl = vgui.Create("DScrollPanel", perkpanel)
			perklistpnl:SetPos(0, 0)
			perklistpnl:SetSize(465, 450)
			perklistpnl:SetPaintBackground(true)
			perklistpnl:SetBackgroundColor( color_grey_200 )
			
			local perkchecklist = vgui.Create( "DIconLayout", perklistpnl )
			perkchecklist:SetSize( 465, 450 )
			perkchecklist:SetPos( 35, 10 )
			perkchecklist:SetSpaceY( 5 )
			perkchecklist:SetSpaceX( 5 )

			for k,v in pairs(wunderfizzlist) do
				local perkitem = perkchecklist:Add("DPanel")
				perkitem:SetSize( 130, 20 )

				local check = perkitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.wunderfizzperklist and istable(nzMapping.Settings.wunderfizzperklist[k]) and isbool(nzMapping.Settings.wunderfizzperklist[k][1])) then
					check:SetValue(nzMapping.Settings.wunderfizzperklist[k][1])
				else
					check:SetValue(true)
				end

				check.OnChange = function(self, val)
					if !valz["Wunderfizz"][k] then
						valz["Wunderfizz"][k] = {true, nzPerks:Get(k).name}
					end
					valz["Wunderfizz"][k][1] = val
				end

				local name = perkitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(v[2])
			end

			------------------------------------------------------------------------
			//PowerUps
			------------------------------------------------------------------------
			local poweruppanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Powerups", poweruppanel, "icon16/asterisk_orange.png", false, false, "Set which powerups can be dropped from zombies.")
			poweruppanel.Paint = function() return end

			local poweruplistpnl = vgui.Create("DScrollPanel", poweruppanel)
			poweruplistpnl:SetPos(0, 0)
			poweruplistpnl:SetSize(465, 450)
			poweruplistpnl:SetPaintBackground(true)
			poweruplistpnl:SetBackgroundColor( color_grey_200 )

			local powerupchecklist = vgui.Create( "DIconLayout", poweruplistpnl )
			powerupchecklist:SetSize( 465, 450 )
			powerupchecklist:SetPos( 35, 10 )
			powerupchecklist:SetSpaceY( 5 )
			powerupchecklist:SetSpaceX( 5 )

			for k,v in pairs(poweruplist) do
				local powerupitem = powerupchecklist:Add("DPanel")
				powerupitem:SetSize( 130, 20 )

				local check = powerupitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.poweruplist and istable(nzMapping.Settings.poweruplist[k]) and isbool(nzMapping.Settings.poweruplist[k][1])) then
					check:SetValue(nzMapping.Settings.poweruplist[k][1])
				else
					check:SetValue(true)
				end

				check.OnChange = function(self, val)
					if !valz["PowerUps"][k] then
						valz["PowerUps"][k] = {true, nzPowerUps:Get(k).name}
					end
					valz["PowerUps"][k][1] = val
				end

				local name = powerupitem:Add("DLabel")
				name:SetTextColor(color_grey_50)
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(v[2])
			end

			AddGumStuff()
			AddEyeStuff()
			AddBoxStuff()
			AddPowerupColors()
			AddMuzzleflashColors()
			AddWallbuyColors()
			AddFontColor()

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