local storedwep, storedknife, storedgrenade, storedsyrette, storedpaparms, storedminigun, storedbottle, storedaat = nil, nil, nil, nil, nil, nil, 2
local oldturnedlist = {
	["Odious Individual"] = true,
	["Laby after Taco Bell"] = true,
	["Fucker.lua"] = true,
	["Turned"] = true,
	["Shitass"] = true,
	["Miscellaneous Intent"] = true,
	["The Imposter"] = true,
	["Zobie"] = true,
	["Creeper, aww man"] = true,
	["Herbin"] = true,
	["Category Five"] = true,
	["TheRelaxingEnd"] = true,
	["Zet0r"] = true,
	["Dead By Daylight"] = true,
	["Cave Johnson"] = true,
	["Vinny Vincesauce"] = true,
	["Who's Who?"] = true,
	["MR ELECTRIC, KILL HIM!"] = true,
	["Jerma985"] = true,
	["Steve Jobs"] = true,
	["BRAAAINS..."] = true,
	["The False Shepherd"] = true,
	["Timer Failed!"] = true,
	["r_flushlod"] = true,
	["Doctor Robotnik"] = true,
	["Clown"] = true,
	["Left 4 Dead 2"] = true,
	["Squidward Tortellini"] = true,
	["Five Nights at FNAF"] = true,
	["Minecraft Steve"] = true,
	["Wowee Zowee"] = true,
	["Gorgeous Freeman"] = true,
	["fog rolling in"] = true,
	["Exotic Butters"] = true,
	["Brain Rot"] = true,
	["Team Fortress 2"] = true,
	["Roblox"] = true,
	["Cave1.ogg"] = true,
	["Fin Fin"] = true,
	["Jimmy Gibbs Jr."] = true,
	["Brain Blast"] = true,
	["Sheen"] = true
}

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
	interface = function(frame, data)
		local data = table.Copy(nzMapping.Settings)
		local valz = {}
		valz["Row1"] = data.startwep or "Select ..."
		valz["Knife"] = data.knife or "Select ..."
		valz["Grenade"] = data.grenade or "Select ..."
		valz["Bottle"] = data.bottle or "Select ..."
		valz["Revive Syrette"] = data.syrette or "Select ..."
		valz["PaP Arms"] = data.paparms or "Select ..."
		valz["Death Machine"] = data.deathmachine or "Select ..."
		valz["Row2"] = data.startpoints or 500
		valz["Row3"] = data.eeurl or ""
		valz["Row4"] = data.script or false
		valz["Row5"] = data.scriptinfo or ""
		valz["Row6"] = data.gamemodeentities or false
		valz["Row7"] = data.specialroundtype or "Hellhounds"
		valz["Row8"] = data.bosstype or "Panzer"
		valz["Row9"] = data.startingspawns == nil and 4 or data.startingspawns
		valz["Row10"] = data.spawnperround == nil and 1 or data.spawnperround
		valz["Row11"] = data.maxspawns == nil and 24 or data.maxspawns
		valz["Row13"] = data.zombiesperplayer == nil and 0 or data.zombiesperplayer
		valz["Row14"] = data.spawnsperplayer == nil and 0 or data.spawnsperplayer
		valz["SpawnDelay"] = data.spawndelay == nil and 2 or data.spawndelay
		valz["Row15"] = data.zombietype or "Kino der Toten"
		valz["Row16"] = data.hudtype or "Black Ops 1"
		valz["Row17"] = data.zombieeyecolor == nil and Color(0, 255, 255, 255) or data.zombieeyecolor
		valz["Row18"] = data.perkmachinetype or "Original"
		valz["Row19"] = data.boxtype or "Original"
		valz["Row20"] = data.boxlightcolor == nil and Color(0,150,200,255) or data.boxlightcolor
		valz["Row21"] = data.newwave1 or 20
		valz["Row22"] = data.newtype1 or "Hellhounds"
		valz["Row23"] = data.newratio1 or 0.5
		valz["Row24"] = data.newwave2 or 0
		valz["Row25"] = data.newtype2 or "None"
		valz["Row26"] = data.newratio2 or 0
		valz["Row27"] = data.newwave3 or 0
		valz["Row28"] = data.newtype3 or "None"
		valz["Row29"] = data.newratio3 or 0
		valz["Row30"] = data.newwave4 or 0
		valz["Row31"] = data.newtype4 or "None"
		valz["Row32"] = data.newratio4 or 0
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
		valz["Row47"] = data.sharing or false
		valz["Row48"] = data.eemdl or "Hula Doll"
		valz["Row49"] = data.speedmulti or 4
		valz["Row50"] = data.amountcap or 240
		valz["HealthStart"] = data.healthstart or 75
		valz["HealthIncrement"] = data.healthinc or 50
		valz["HealthMultiplier"] = data.healthmult or 0.1
		valz["HealthCap"] = data.healthcap or 666000
		valz["Row51"] = data.navgroupbased or false
		valz["Row52"] = data.sidestepping or false
		valz["Row54"] = data.badattacks or false
		valz["Row55"] = data.negative or false
		valz["Row56"] = data.zct or false
		valz["Row57"] = data.mutated or false
		valz["Row58"] = data.aats or 2
		valz["TurnedNames"] = data.turnedlist or oldturnedlist
		valz["RBoxWeps"] = data.RBoxWeps or {}
		valz["ACRow1"] = data.ac == nil and false or data.ac
		valz["ACRow2"] = data.acwarn == nil and true or data.acwarn
		valz["ACRow3"] = data.acsavespot == nil and true or tobool(data.acsavespot)
		valz["ACRow4"] = data.actptime == nil and 5 or data.actptime
		valz["ACRow5"] = data.acpreventboost == nil and true or tobool(data.acpreventboost)
		valz["ACRow6"] = data.acpreventcjump == nil and false or tobool(data.acpreventcjump)

		-- Catalyst/ZCT/Burning
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

		valz["PowerUps"] = data.poweruplist == nil and poweruplist or data.poweruplist

		-- More compact and less messy:
		for k,v in pairs(nzSounds.struct) do
			valz["SndRow" .. k] = data[v] or {}
		end

		//store selected combobox settings
		if nzMapping.Settings.startwep and storedwep ~= nzMapping.Settings.startwep then
			storedwep = nzMapping.Settings.startwep
		end
		if nzMapping.Settings.knife and storedknife ~= nzMapping.Settings.knife then
			storedknife = nzMapping.Settings.knife
		end
		if nzMapping.Settings.grenade and storedgrenade ~= nzMapping.Settings.grenade then
			storedgrenade = nzMapping.Settings.grenade
		end
		if nzMapping.Settings.deathmachine and storedminigun ~= nzMapping.Settings.deathmachine then
			storedminigun = nzMapping.Settings.deathmachine
		end
		if nzMapping.Settings.syrette and storedsyrette ~= nzMapping.Settings.syrette then
			storedsyrette = nzMapping.Settings.syrette
		end
		if nzMapping.Settings.bottle and storedbottle ~= nzMapping.Settings.bottle then
			storedbottle = nzMapping.Settings.bottle
		end
		if nzMapping.Settings.aats and storedaat ~= nzMapping.Settings.aats then
			storedaat = nzMapping.Settings.aats
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
						Row1:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedwep == v.ClassName)
					else
						Row1:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, storedwep == v.ClassName)
					end
				end
			end
			if data.startwep then
				local wep = weapons.Get(data.startwep)
				if !wep and weapons.Get(nzConfig.BaseStartingWeapons) and #weapons.Get(nzConfig.BaseStartingWeapons) >= 1 then wep = weapons.Get("robotnik_bo1_1911") end
				if wep != nil then  
					if wep.Category and wep.Category != "" then
						Row1:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedwep == wep.ClassName)
					else
						Row1:AddChoice(wep.PrintName and wep.PrintName != "" and wep.PrintName or wep.ClassName, wep.ClassName, storedwep == wep.ClassName)
					end
				end
			end

			Row1.DataChanged = function( _, val ) valz["Row1"] = val storedwep = val end
			local kniferow = DProperties:CreateRow( "Player Settings", "Knife" )
			kniferow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Knives" then
					kniferow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedknife == v.ClassName)
				end
			end
			if data.knife then
				local wep = weapons.Get(data.knife)
				if !wep then wep = weapons.Get("tfa_bo1_knife") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Knives" then
						kniferow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedknife == wep.ClassName)
					end
				end
			end
			kniferow.DataChanged = function( _, val ) valz["Knife"] = val storedknife = val end
			
			local grenaderow = DProperties:CreateRow( "Player Settings", "Grenade" )
			grenaderow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Grenades" then
					grenaderow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedgrenade == v.ClassName)
				end
			end
			if data.grenade then
				local wep = weapons.Get(data.grenade)
				if !wep  then wep = weapons.Get("tfa_bo1_m67") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Grenades" then
						grenaderow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedgrenade == wep.ClassName)
					end
				end
			end
			grenaderow.DataChanged = function( _, val ) valz["Grenade"] = val storedgrenade = val end
			
			local syretterow = DProperties:CreateRow( "Player Settings", "Revive Syrette" )
			syretterow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Syrettes" then
					syretterow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedsyrette == v.ClassName)
				end
			end
			if data.syrette then
				local wep = weapons.Get(data.syrette)
				if !wep  then wep = weapons.Get("tfa_bo2_syrette") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Syrettes" then
						syretterow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedsyrette == wep.ClassName)
					end
				end
			end
			syretterow.DataChanged = function( _, val ) valz["Revive Syrette"] = val storedsyrette = val end
			
			local paparmsrow = DProperties:CreateRow( "Player Settings", "PaP Arms" )
			paparmsrow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Knuckles" then
					paparmsrow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedpaparms == v.ClassName)
				end
			end
			if data.paparmsrow then
				local wep = weapons.Get(data.paparmsrow)
				if !wep  then wep = weapons.Get("tfa_paparms") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Knuckles" then
						paparmsrow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedpaparms == wep.ClassName)
					end
				end
			end
			paparmsrow.DataChanged = function( _, val ) valz["PaP Arms"] = val storedpaparms = val end
			
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
				
			local bottlerow = DProperties:CreateRow( "Map Cosmetics", "Bottle" )
			bottlerow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
					if v.Category and v.Category == "nZombies Bottles" then
						bottlerow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedbottle == v.ClassName)
					end
			end
			if data.bottle then
				local wep = weapons.Get(data.bottle)
				if !wep  then wep = weapons.Get("tfa_perk_bottle") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Bottles" then
						bottlerow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedbottle == wep.ClassName)
					end
				end
			end
			bottlerow.DataChanged = function( _, val ) valz["Bottle"] = val storedbottle = val end
			
			local Row43 = DProperties:CreateRow("Map Cosmetics", "Pack-A-Punch Skins")
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

			local Row48 = DProperties:CreateRow("Map Cosmetics", "Easter egg song Model")
			Row48:Setup( "Combo" )
			local found = false
			for k,v in pairs(nzRound.eemodel) do
				if k == valz["Row48"] then
					Row48:AddChoice(k, k, true)
					found = true
				else
					Row48:AddChoice(k, k, false)
				end
			end
			Row48.DataChanged = function( _, val ) valz["Row48"] = val end
			Row48:SetTooltip("Sets the model for the easteregg song")
		--[[-------------------------------------------------------------------------
		Map Cosmetics
		---------------------------------------------------------------------------]]


		--[[-------------------------------------------------------------------------
		Map Functionality
		---------------------------------------------------------------------------]]
			local Row42 = DProperties:CreateRow( "Map Functionality", "Perk Upgrades" )
			Row42:Setup( "Boolean" )
			Row42:SetValue( valz["Row42"] )
			Row42.DataChanged = function( _, val ) valz["Row42"] = val end
			Row42:SetTooltip("Enable upgradeable perks on this config")
				
			local Row47 = DProperties:CreateRow( "Map Functionality", "Mystery Box Sharing" )
			Row47:Setup( "Boolean" )
			Row47:SetValue( valz["Row47"] )
			Row47.DataChanged = function( _, val ) valz["Row47"] = val end
			Row47:SetTooltip("To be a box communist or not to be a box communist")

			local Row55 = DProperties:CreateRow( "Map Functionality", "Laby Anti Powerups" )
			Row55:Setup( "Boolean" )
			Row55:SetValue( valz["Row55"] )
			Row55.DataChanged = function( _, val ) valz["Row55"] = val end
			Row55:SetTooltip("Enable this for comedy.")

			local Row58 = DProperties:CreateRow( "Map Functionality", "Double PaP AATs" )
			Row58:Setup("Combo")
			Row58:AddChoice("Disabled", 0, storedaat == 0)
			Row58:AddChoice("Only when no OnRePaP", 1, storedaat == 1)
			Row58:AddChoice("Always on (Default)", 2, storedaat == 2)
			Row58.DataChanged = function( _, val ) valz["Row58"] = val storedaat = val end
			Row58:SetTooltip("Enable for weapons to gain BO3 esque ammo mods on repaping.")

			local deathmachinerow = DProperties:CreateRow( "Map Functionality", "Death Machine" )
			deathmachinerow:Setup( "Combo" )
			for k,v in pairs(weapons.GetList()) do
				if v.Category and v.Category == "nZombies Powerups" then
					deathmachinerow:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, storedminigun == v.ClassName)
				end
			end
			if data.deathmachine then
				local wep = weapons.Get(data.deathmachine)
				if !wep  then wep = weapons.Get("tfa_nz_bo3_minigun") end
				if wep != nil then  
					if wep.Category and wep.Category == "nZombies Powerups" then
						deathmachinerow:AddChoice(wep.PrintName and wep.PrintName != "" and wep.Category.. " - "..wep.PrintName or wep.ClassName, wep.ClassName, storedminigun == wep.ClassName)
					end
				end
			end
			deathmachinerow.DataChanged = function( _, val ) valz["Death Machine"] = val storedminigun = val end
		--[[-------------------------------------------------------------------------
		Map Functionality
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
			if !valz["Row16"] then data.hudtype = "Origins (Black Ops 2)" else data.hudtype = valz["Row16"] end
			if !istable(valz["Row17"]) then data.zombieeyecolor = Color(0, 255, 255, 255) else data.zombieeyecolor = valz["Row17"] end
			if !valz["Row18"] then data.perkmachinetype = "Original" else data.perkmachinetype = valz["Row18"] end
			if !valz["Row19"] then data.boxtype = "Original" else data.boxtype= valz["Row19"] end
			if !istable(valz["Row20"]) then data.boxlightcolor = Color(0, 150,200,255) else data.boxlightcolor = valz["Row20"] end
			if !tonumber(valz["Row21"]) then data.newwave1 = 20 else data.newwave1 = tonumber(valz["Row21"]) end
			if !valz["Row22"] then data.newtype1 = "Hellhounds" else data.newtype1 = valz["Row22"] end
			if !tonumber(valz["Row23"]) then data.newratio1 = 0.5 else data.newratio1 = tonumber(valz["Row23"]) end
			if !tonumber(valz["Row24"]) then data.newwave2 = 0 else data.newwave2 = tonumber(valz["Row24"]) end
			if !valz["Row25"] then data.newtype2 = "None" else data.newtype2 = valz["Row25"] end
			if !tonumber(valz["Row26"]) then data.newratio2 = 0 else data.newratio2 = tonumber(valz["Row26"]) end
			if !tonumber(valz["Row27"]) then data.newwave3 = 0 else data.newwave3 = tonumber(valz["Row27"]) end
			if !valz["Row28"] then data.newtype3 = "None" else data.newtype3 = valz["Row28"] end
			if !tonumber(valz["Row29"]) then data.newratio3 = 0 else data.newratio3 = tonumber(valz["Row29"]) end
			if !tonumber(valz["Row30"]) then data.newwave4 = 0 else data.newwave4 = tonumber(valz["Row30"]) end
			if !valz["Row31"] then data.newtype4 = "None" else data.newtype4 = valz["Row31"] end
			if !tonumber(valz["Row32"]) then data.newratio4 = 0 else data.newratio4 = tonumber(valz["Row32"]) end
			if !valz["Row33"] then data.mainfont = "Default NZR" else data.mainfont = valz["Row33"] end
			if !valz["Row34"] then data.smallfont = "Default NZR" else data.smallfont = valz["Row34"] end
			if !valz["Row35"] then data.mediumfont = "Default NZR" else data.mediumfont = valz["Row35"] end
			if !valz["Row36"] then data.roundfont = "Classic NZ" else data.roundfont = valz["Row36"] end
			if !valz["Row37"] then data.ammofont = "Default NZR" else data.ammofont = valz["Row37"] end
			if !valz["Row38"] then data.ammo2font = "Default NZR" else data.ammo2font = valz["Row38"] end
			if !istable(valz["Row39"]) then data.textcolor = Color(0, 255, 255, 255) else data.textcolor = valz["Row39"] end
			if !tonumber(valz["Row40"]) then data.fontthicc  = 2 else data.fontthicc  = tonumber(valz["Row40"]) end
			if !valz["Row41"] then data.icontype = "Rezzurrection" else data.icontype = valz["Row41"] end
			if !valz["Row42"] then data.perkupgrades = nil else data.perkupgrades = valz["Row42"] end
			if !valz["Row43"] then data.PAPtype = "Original" else data.PAPtype = valz["Row43"] end
			if !valz["Row44"] then data.PAPcamo = "nz_classic" else data.PAPcamo = valz["Row44"] end
			if !tonumber(valz["Row45"]) then data.hp = 100 else data.hp = tonumber(valz["Row45"]) end
			if !tonumber(valz["Row46"]) then data.range = 0 else data.range = tonumber(valz["Row46"]) end
			if !valz["Row47"] then data.sharing = nil else data.sharing = valz["Row47"] end
			if !valz["Row48"] then data.eemdl = "Hula Doll" else data.eemdl = valz["Row48"] end
			if !valz["Row49"] then data.speedmulti = 4 else data.speedmulti = tonumber(valz["Row49"]) end
			if !valz["Row50"] then data.amountcap = 240 else data.amountcap = tonumber(valz["Row50"]) end -- world the change, my good evening message. final. :jack_o_lantern:
			if !valz["HealthStart"] then data.healthstart = 75 else data.healthstart = tonumber(valz["HealthStart"]) end
			if !valz["HealthIncrement"] then data.healthinc = 50 else data.healthinc = tonumber(valz["HealthIncrement"]) end
			if !valz["HealthMultiplier"] then data.healthmult = 0.1 else data.healthmult = tonumber(valz["HealthMultiplier"]) end
			if !valz["HealthCap"] then data.healthcap = 60000 else data.healthcap = tonumber(valz["HealthCap"]) end
			if !valz["Row51"] then data.navgroupbased = nil else data.navgroupbased = valz["Row51"] end
			if !valz["Row52"] then data.sidestepping = nil else data.sidestepping = valz["Row52"] end
			if !valz["Row54"] then data.badattacks = nil else data.badattacks = valz["Row54"] end
			if !valz["Row55"] then data.negative = nil else data.negative = valz["Row55"] end
			if !valz["Row56"] then data.zct = nil else data.zct = valz["Row56"] end
			if !valz["Row57"] then data.mutated = nil else data.mutated = valz["Row57"] end
			if !valz["Row58"] then data.aats = 2 else data.aats = tonumber(valz["Row58"]) end
			if !valz["TurnedNames"] then data.turnedlist = oldturnedlist else data.turnedlist = valz["TurnedNames"] end
			if !valz["RBoxWeps"] or table.Count(valz["RBoxWeps"]) < 1 then data.rboxweps = nil else data.rboxweps = valz["RBoxWeps"] end
			if valz["Wunderfizz"] == nil then data.wunderfizzperklist = wunderfizzlist else data.wunderfizzperklist = valz["Wunderfizz"] end
			if valz["PowerUps"] == nil then data.poweruplist = poweruplist else data.poweruplist = valz["PowerUps"] print("ass")end
			if valz["ACRow1"] == nil then data.ac = false else data.ac = tobool(valz["ACRow1"]) end
			if valz["ACRow2"] == nil then data.acwarn = nil else data.acwarn = tobool(valz["ACRow2"]) end
			if valz["ACRow3"] == nil then data.acsavespot = nil else data.acsavespot = tobool(valz["ACRow3"]) end
			if valz["ACRow4"] == nil then data.actptime = 5 else data.actptime = valz["ACRow4"] end
			if valz["ACRow5"] == nil then data.acpreventboost = true else data.acpreventboost = tobool(valz["ACRow5"]) end
			if valz["ACRow6"] == nil then data.acpreventcjump = false else data.acpreventcjump = tobool(valz["ACRow6"]) end

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

			--PrintTable(data)

			nzMapping:SendMapData( data )
		end

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
			colorChoose2:SetSize(150, 150)
			
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
			presets:AddChoice("PANK")
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
				elseif (value == "PANK") then
					colorChoose2:SetColor(Color(246, 255, 0))	
				end
				colorChoose2:ValueChanged(nil)
			end

			colorChoose2.ValueChanged = function(col)
				valz["Row20"] = colorChoose2:GetColor()
				print(valz["Row20"])
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
			fontColorChoice:SetSize(150, 150)
			
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
				print(valz["Row39"])
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
			rbweplist:SetBackgroundColor( Color(200, 200, 200) )

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

			AddEyeStuff()
			AddBoxStuff()
			AddFontColor()
			
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
			------------------------------------------------------------------------
			local perklist = {}

			local perkpanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Wunderfizz Perks", perkpanel, "icon16/drink.png", false, false, "Set which perks appears in Der Wunderfizz.")
			perkpanel.Paint = function() return end

			local perklistpnl = vgui.Create("DScrollPanel", perkpanel)
			perklistpnl:SetPos(0, 0)
			perklistpnl:SetSize(465, 450)
			perklistpnl:SetPaintBackground(true)
			perklistpnl:SetBackgroundColor( Color(200, 200, 200) )
			
			local perkchecklist = vgui.Create( "DIconLayout", perklistpnl )
			perkchecklist:SetSize( 465, 450 )
			perkchecklist:SetPos( 35, 10 )
			perkchecklist:SetSpaceY( 5 )
			perkchecklist:SetSpaceX( 5 )
			
			--for k,v in pairs(nzPerks:GetList()) do
			--	if k != "wunderfizz" and k != "pap" then
				for k,v in pairs(wunderfizzlist) do
				--if (!valz["Wunderfizz"] || !valz["Wunderfizz"][k]) then return end

				local perkitem = perkchecklist:Add( "DPanel" )
				perkitem:SetSize( 130, 20 )
				
				local check = perkitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.wunderfizzperklist and istable(nzMapping.Settings.wunderfizzperklist[k]) and isbool(nzMapping.Settings.wunderfizzperklist[k][1])) then
					check:SetValue(nzMapping.Settings.wunderfizzperklist[k][1])
				else
					check:SetValue(true)
				end

				--if has then perklist[k] = true else perklist[k] = nil end
				check.OnChange = function(self, val)
					--if val then perklist[k] = true else perklist[k] = nil end
					valz["Wunderfizz"][k][1] = val
					--nzMapping:SendMapData( {wunderfizzperks = perklist} )
				end
				
				local name = perkitem:Add("DLabel")
				name:SetTextColor(Color(50,50,50))
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(v[2])
			end

--------------------------------------------------------------------------------------------------------------------------------------
			
			--local poweruplist = {}

			local poweruppanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet( "Powerups", poweruppanel, "icon16/asterisk_orange.png", false, false, "Set which powerups can be dropped from zombies.")
			poweruppanel.Paint = function() return end

			local poweruplistpnl = vgui.Create("DScrollPanel", poweruppanel)
			poweruplistpnl:SetPos(0, 0)
			poweruplistpnl:SetSize(465, 450)
			poweruplistpnl:SetPaintBackground(true)
			poweruplistpnl:SetBackgroundColor( Color(200, 200, 200) )

			local powerupchecklist = vgui.Create( "DIconLayout", poweruplistpnl )
			powerupchecklist:SetSize( 465, 450 )
			powerupchecklist:SetPos( 35, 10 )
			powerupchecklist:SetSpaceY( 5 )
			powerupchecklist:SetSpaceX( 5 )

			for k,v in pairs(poweruplist) do
				if (!valz["PowerUps"] || !valz["PowerUps"][k]) then return end

				local powerupitem = powerupchecklist:Add( "DPanel" )
				powerupitem:SetSize( 130, 20 )

				local check = powerupitem:Add("DCheckBox")
				check:SetPos(2,2)

				if (nzMapping.Settings.poweruplist and istable(nzMapping.Settings.poweruplist[k]) and isbool(nzMapping.Settings.poweruplist[k][1])) then
					check:SetValue(nzMapping.Settings.poweruplist[k][1])
				else
					check:SetValue(true)
				end

				--if has then perklist[k] = true else perklist[k] = nil end
				check.OnChange = function(self, val)
					valz["PowerUps"][k][1] = val
				end

				local name = powerupitem:Add("DLabel")
				name:SetTextColor(Color(50,50,50))
				name:SetSize(105, 20)
				name:SetPos(20,1)
				name:SetText(v[2])
			end

				--end
			--end
			--local text = vgui.Create("DLabel", DProperties)
			--text:SetText("Enable this mode for broken stuff")
			--text:SetFont("Trebuchet18")
			--text:SetTextColor( Color(50, 50, 50) )
			--text:SizeToContents()
			--text:SetPos(0, 140)
			--text:CenterHorizontal()

			------------------------------------------------------------------------
			//Turned Names
			------------------------------------------------------------------------

			local color_grey_50 = Color(50, 50, 50)
			local color_grey_200 = Color(200, 200, 200)
			local color_red = Color(150, 50, 50)
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
				for k, v in pairs(oldturnedlist) do
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