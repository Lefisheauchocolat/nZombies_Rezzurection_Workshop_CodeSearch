-- Made by Hari exclusive for nZombies Onslaught. Copying this code is prohibited!

nzTools:CreateTool("harimapsettings", {
	displayname = "Extra Map Settings",
	desc = "Just set settings in tool menu",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)

	end,
	SecondaryAttack = function(wep, ply, tr, data)

	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Extra Map Settings",
	desc = "Just set settings in tool menu",
	icon = "icon16/computer_add.png",
	weight = 5.95,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		--GAME OVER SCREEN SETTINGS-------------------------------------------------------------------

		local Row1 = DProperties:CreateRow("Game Over Screen Settings", "Enable Black Ops 6 Game Over Screen?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("BO6_GO", false))
		nzSettings:SyncValueToElement("BO6_GO", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_GO", tobool(val))
		end

		local Row2 = DProperties:CreateRow("Game Over Screen Settings", "Lose Title")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("BO6_GO_LoseTitle", "ELIMINATED"))
		nzSettings:SyncValueToElement("BO6_GO_LoseTitle", Row2)
		Row2.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("BO6_GO_LoseTitle", val)
		end

		local Row3 = DProperties:CreateRow("Game Over Screen Settings", "Win Title")
		Row3:Setup("Generic")
		Row3:SetValue(nzSettings:GetSimpleSetting("BO6_GO_WinTitle", "SUCCESSFUL EXFIL"))
		nzSettings:SyncValueToElement("BO6_GO_WinTitle", Row3)
		Row3.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("BO6_GO_WinTitle", val)
		end

		local Row4 = DProperties:CreateRow("Game Over Screen Settings", "Round Text")
		Row4:Setup("Generic")
		Row4:SetValue(nzSettings:GetSimpleSetting("BO6_GO_RoundText", "You Survived %s Rounds"))
		nzSettings:SyncValueToElement("BO6_GO_RoundText", Row4)
		Row4.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("BO6_GO_RoundText", val)
		end

		local Row5 = DProperties:CreateRow("Game Over Screen Settings", "Enable Camera on Background?")
		Row5:Setup("Boolean")
		Row5:SetValue(nzSettings:GetSimpleSetting("BO6_GO_Alpha", false))
		nzSettings:SyncValueToElement("BO6_GO_Alpha", Row5)
		Row5.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_GO_Alpha", tobool(val))
		end

		--ARMOR SETTINGS-------------------------------------------------------------------

		local Row1 = DProperties:CreateRow("Armor Settings", "Enable Black Ops 6 Armor System?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("BO6_Armor", false))
		nzSettings:SyncValueToElement("BO6_Armor", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor", tobool(val))
		end

		local Row1_1 = DProperties:CreateRow("Armor Settings", "Enable Universal Armor HUD?")
		Row1_1:Setup("Boolean")
		Row1_1:SetValue(nzSettings:GetSimpleSetting("BO6_ArmorHUD", true))
		nzSettings:SyncValueToElement("BO6_ArmorHUD", Row1_1)
		Row1_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_ArmorHUD", tobool(val))
		end

		local Row2_0 = DProperties:CreateRow("Armor Settings", "Health Damage Percent with Armor")
		Row2_0:Setup("Generic")
		Row2_0:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_Percent", 30))
		nzSettings:SyncValueToElement("BO6_Armor_Percent", Row2_0)
		Row2_0.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_Percent", tonumber(val) or 30)
		end

		local Row2 = DProperties:CreateRow("Armor Settings", "Armor Plate Drop Zombie Chance")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_Drop", 5))
		nzSettings:SyncValueToElement("BO6_Armor_Drop", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_Drop", tonumber(val) or 5)
		end

		local Row2_1 = DProperties:CreateRow("Armor Settings", "Armor Plate Drop Special Chance")
		Row2_1:Setup("Generic")
		Row2_1:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_DropSpecial", 25))
		nzSettings:SyncValueToElement("BO6_Armor_DropSpecial", Row2_1)
		Row2_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_DropSpecial", tonumber(val) or 25)
		end

		local Row2_2 = DProperties:CreateRow("Armor Settings", "Armor Plate Drop Boss Chance")
		Row2_2:Setup("Generic")
		Row2_2:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_DropBoss", 100))
		nzSettings:SyncValueToElement("BO6_Armor_DropBoss", Row2_2)
		Row2_2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_DropBoss", tonumber(val) or 100)
		end

		local Row2_3 = DProperties:CreateRow("Armor Settings", "Armor Strength per Plate")
		Row2_3:Setup("Generic")
		Row2_3:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_PerPlate", 150))
		nzSettings:SyncValueToElement("BO6_Armor_PerPlate", Row2_3)
		Row2_3.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_PerPlate", tonumber(val) or 150)
		end

		local Row2_4 = DProperties:CreateRow("Armor Settings", "Max Plates in Inventory")
		Row2_4:Setup("Generic")
		Row2_4:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3))
		nzSettings:SyncValueToElement("BO6_Armor_MaxPlates", Row2_4)
		Row2_4.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_MaxPlates", tonumber(val) or 3)
		end

		local Row3 = DProperties:CreateRow("Armor Settings", "Armor Tier 1 Strength")
		Row3:Setup("Generic")
		Row3:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_Tier1HP", 150))
		nzSettings:SyncValueToElement("BO6_Armor_Tier1HP", Row3)
		Row3.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_Tier1HP", tonumber(val) or 150)
		end

		local Row4 = DProperties:CreateRow("Armor Settings", "Armor Tier 2 Strength")
		Row4:Setup("Generic")
		Row4:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_Tier2HP", 300))
		nzSettings:SyncValueToElement("BO6_Armor_Tier2HP", Row4)
		Row4.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_Tier2HP", tonumber(val) or 300)
		end

		local Row5 = DProperties:CreateRow("Armor Settings", "Armor Tier 3 Strength")
		Row5:Setup("Generic")
		Row5:SetValue(nzSettings:GetSimpleSetting("BO6_Armor_Tier3HP", 450))
		nzSettings:SyncValueToElement("BO6_Armor_Tier3HP", Row5)
		Row5.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Armor_Tier3HP", tonumber(val) or 450)
		end

		--SALVAGE SETTINGS-------------------------------------------------------------------

		local Row1 = DProperties:CreateRow("Salvage Settings", "Enable Black Ops 6 Salvage System?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("BO6_Salvage", false))
		nzSettings:SyncValueToElement("BO6_Salvage", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Salvage", tobool(val))
		end

		local Row1_1 = DProperties:CreateRow("Salvage Settings", "Enable Universal Salvage HUD?")
		Row1_1:Setup("Boolean")
		Row1_1:SetValue(nzSettings:GetSimpleSetting("BO6_SalvageHUD", true))
		nzSettings:SyncValueToElement("BO6_SalvageHUD", Row1_1)
		Row1_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_SalvageHUD", tobool(val))
		end

		local Row2 = DProperties:CreateRow("Salvage Settings", "Salvage Drop Zombie Chance")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("BO6_Salvage_Drop", 20))
		nzSettings:SyncValueToElement("BO6_Salvage_Drop", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Salvage_Drop", tonumber(val) or 20)
		end

		local Row2_1 = DProperties:CreateRow("Salvage Settings", "Salvage Drop Special Chance")
		Row2_1:Setup("Generic")
		Row2_1:SetValue(nzSettings:GetSimpleSetting("BO6_Salvage_DropSpecial", 50))
		nzSettings:SyncValueToElement("BO6_Salvage_DropSpecial", Row2_1)
		Row2_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Salvage_DropSpecial", tonumber(val) or 50)
		end

		local Row2_2 = DProperties:CreateRow("Salvage Settings", "Salvage Drop Boss Chance")
		Row2_2:Setup("Generic")
		Row2_2:SetValue(nzSettings:GetSimpleSetting("BO6_Salvage_DropBoss", 100))
		nzSettings:SyncValueToElement("BO6_Salvage_DropBoss", Row2_2)
		Row2_2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Salvage_DropBoss", tonumber(val) or 100)
		end

		--KILLSTREAK SETTINGS-------------------------------------------------------------------

		local Row2 = DProperties:CreateRow("Craft Settings", "Enable Universal Killstreak HUD?")
		Row2:Setup("Boolean")
		Row2:SetValue(nzSettings:GetSimpleSetting("BO6_KillstreakHUD", true))
		nzSettings:SyncValueToElement("BO6_KillstreakHUD", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_KillstreakHUD", tobool(val))
		end

		local Row2_1 = DProperties:CreateRow("Craft Settings", "Enable Killstreak Drops from Bosses?")
		Row2_1:Setup("Boolean")
		Row2_1:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_Drops", true))
		nzSettings:SyncValueToElement("BO6_Killstreak_Drops", Row2_1)
		Row2_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Killstreak_Drops", tobool(val))
		end
		
		local Row3 = DProperties:CreateRow("Craft Settings", "Chopper Gunner Fly Time")
		Row3:Setup("Generic")
		Row3:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_ChopperTime", 30))
		nzSettings:SyncValueToElement("BO6_Killstreak_ChopperTime", Row3)
		Row3.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Killstreak_ChopperTime", tonumber(val) or 30)
		end

		local Row3_1 = DProperties:CreateRow("Craft Settings", "VTOL Jet Fly Height")
		Row3_1:Setup("Generic")
		Row3_1:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500))
		nzSettings:SyncValueToElement("BO6_Killstreak_VTOLHeight", Row3_1)
		Row3_1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Killstreak_VTOLHeight", tonumber(val) or 1500)
		end

		local Row4 = DProperties:CreateRow("Craft Settings", "Mangler Injection Morph Time")
		Row4:Setup("Generic")
		Row4:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45))
		nzSettings:SyncValueToElement("BO6_Killstreak_ManglerTime", Row4)
		Row4.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Killstreak_ManglerTime", tonumber(val) or 45)
		end

		local Row5 = DProperties:CreateRow("Craft Settings", "Hellstorm Speed")
		Row5:Setup("Generic")
		Row5:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_HellstormSpeed", 1000))
		nzSettings:SyncValueToElement("BO6_Killstreak_HellstormSpeed", Row5)
		Row5.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("BO6_Killstreak_HellstormSpeed", tonumber(val) or 1000)
		end

		for name, tab in pairs(nzKillstreak.List) do
			local Row = DProperties:CreateRow("Craft Settings", "Enable "..name.." Killstreak?")
			Row:Setup("Boolean")
			Row:SetValue(nzSettings:GetSimpleSetting("BO6_Killstreak_"..name, true))
			nzSettings:SyncValueToElement("BO6_Killstreak_"..name, Row)
			Row.DataChanged = function( _, val ) 
				nzSettings:SetSimpleSetting("BO6_Killstreak_"..name, tobool(val))
			end
		end

		return DProperties
	end,
	--defaultdata = {}
})