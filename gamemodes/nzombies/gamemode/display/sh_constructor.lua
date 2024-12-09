if (CLIENT) then
	zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")

	function GetFontType(id)
		if id == "Classic NZ" 		then return "classic" 	end
		if id == "Old Treyarch" 	then return "waw" 		end
		if id == "BO2/3" 			then return "blackops2" end
		if id == "Comic Sans" 		then return "xd" 		end
		if id == "Warprint" 		then return "grit" 		end
		if id == "Road Rage" 		then return "rage" 		end
		if id == "Black Rose" 		then return "rose" 		end
		if id == "Reborn" 			then return "reborn" 	end
		if id == "Rio Grande" 		then return "rio" 		end
		if id == "Bad Signal" 		then return "signal" 	end
		if id == "Infection" 		then return "infected" 	end
		if id == "Brutal World" 	then return "brutal" 	end
		if id == "Generic Scifi" 	then return "ugly" 		end
		if id == "Tech" 			then return "tech" 		end
		if id == "Krabby" 			then return "krabs" 	end
		if id == "Default NZR" 		then return "default" 	end
		if id == "BO4" 				then return "blackops4" end
		if id == "Black Ops 1" 		then return "bo1"		end
		if id == "WW2" 				then return "ww2"		end
		if id == "IW" 				then return "iw7"		end
		return "classic"
	end

	function GetPerkIconMaterial(perk, usemmo)
		local style = usemmo and nzMapping.Settings.mmohudtype or nzMapping.Settings.icontype
		return nzPerks:GetPerkIcon(perk, style)
	end

	function GetPowerupIconMaterial(powerup)
		local pdata = nzPowerUps:Get(powerup)
		if not pdata then return end

		local dtype = nzDisplay.PowerupHudData[nzMapping.Settings.poweruptype]
		if dtype and pdata[dtype] then
			return pdata[dtype], pdata.noflashing
		end
	end

	function GetPerkFrameMaterial(usemmo)
		local style = usemmo and nzMapping.Settings.mmohudtype or nzMapping.Settings.icontype
		return nzPerks:GetPerkBorder(style)
	end
end

if (SERVER) then
	util.AddNetworkString("nz_game_end_notif")

	//every hud needs a unique netmessages
	util.AddNetworkString("nz_points_notification_bo1")
	util.AddNetworkString("nz_points_notification_bo2")
	util.AddNetworkString("nz_points_notification_bo2_dlc")
	util.AddNetworkString("nz_points_notification_bo3")
	util.AddNetworkString("nz_points_notification_bo3_zod")
	util.AddNetworkString("nz_points_notification_snowglobe")
	util.AddNetworkString("nz_points_notification_oilrig")
	util.AddNetworkString("nz_points_notification_tomb_hd")
	util.AddNetworkString("nz_points_notification_encampment")
	util.AddNetworkString("nz_points_notification_waw")
end

nzDisplay = nzDisplay or AddNZModule("Display")

nzDisplay.reworkedHUDs = {
	["Tranzit (Black Ops 2)"] = true,
	["Black Ops 1"] = true,
	["Buried"] = true,
	["Mob of the Dead"] = true,
	["Origins (Black Ops 2)"] = true,
	["Black Ops 3"] = true,
	["Shadows of Evil"] = true,
	["Snowglobe"] = true,
	["Industrial Estate"] = true,
	["Origins (HD)"] = true,
	["Encampment"] = true,
	["World at War"] = true,
}

//used for sending points notification
nzDisplay.HUDnetstrings = {
	["Shadows of Evil"] = "nz_points_notification_bo3_zod",
	["Black Ops 3"] = "nz_points_notification_bo3",
	["Black Ops 1"] = "nz_points_notification_bo1",
	["Tranzit (Black Ops 2)"] = "nz_points_notification_bo2",
	["Mob of the Dead"] = "nz_points_notification_bo2_dlc",
	["Buried"] = "nz_points_notification_bo2_dlc",
	["Origins (Black Ops 2)"] = "nz_points_notification_bo2_dlc",
	["Snowglobe"] = "nz_points_notification_snowglobe",
	["Industrial Estate"] = "nz_points_notification_oilrig",
	["Encampment"] = "nz_points_notification_encampment",
	["Origins (HD)"] = "nz_points_notification_tomb_hd",
	["World at War"] = "nz_points_notification_waw",
}

nzDisplay.leftsidedHUDs = {
	["Black Ops 3"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
	["Encampment"] = true,
}

//used in cl_target for the black background on hint strings
nzDisplay.modernHUDs = {
	["Black Ops 3"] = true,
	["Black Ops 4"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
}

//used for different max ammo styles
nzDisplay.classicmaxammo = {
	["Tranzit (Black Ops 2)"] = true,
	["Black Ops 1"] = true,
	["Buried"] = true,
	["Mob of the Dead"] = true,
	["Origins (Black Ops 2)"] = true,
	["Snowglobe"] = true,
	["Industrial Estate"] = true,
	["Encampment"] = true,
	["World at War"] = true,
}
nzDisplay.t7maxammo = {
	["Black Ops 3"] = true,
}
nzDisplay.cthulhuammo = {
	["Shadows of Evil"] = true,
}
nzDisplay.tombammo = {
	["Origins (HD)"] = true,
}

//used for different revive icon styles
nzDisplay.classicrevive = {
	["World at War"] = true,
}

nzDisplay.t5revive = {
	["Black Ops 1"] = true,
	["Industrial Estate"] = true,
	["Snowglobe"] = true
}

nzDisplay.t6revive = {
	["Buried"] = true,
	["Mob of the Dead"] = true,
	["Origins (Black Ops 2)"] = true,
	["Tranzit (Black Ops 2)"] = true,
	["Encampment"] = true
}

nzDisplay.t7revive = {
	["Black Ops 3"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
}

//to be used later
nzDisplay.hudstruct = {
	"missingicon",
	"bloodoverlay",
	"playerindicator",
	"deathindicator",
	"deadshotindicator",
	"talkballoonicon",
	"thirdpersonicon",
}

//for gumball
nzDisplay.GumPosition = {
	["Tranzit (Black Ops 2)"] = {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Black Ops 1"] = {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Buried"] = {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Mob of the Dead"] = {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Origins (Black Ops 2)"] = {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Black Ops 3"] = {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Shadows of Evil"] = {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Snowglobe"] = {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Industrial Estate"] = {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Origins (HD)"] = {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Encampment"] = {x = 132, y = 280, icon_size = 76, ring_size = 39, width = 6},
	["World at War"] = {x = 4000, y = 4000, icon_size = 0, ring_size = 0, width = 1},
	//["World at War"] = {x = 384, y = 234, icon_size = 72, ring_size = 32, width = 5, armor_x = 32},
}

//for use in adding custom powerup icon sets
//requires modifying sh_powerups to add entries for the icon material
nzDisplay.PowerupHudData = nzDisplay.PowerupHudData or {}
function nzDisplay:AddPowerupHUDType(id, dataname)
	if dataname then
		nzDisplay.PowerupHudData[id] = dataname
	else
		nzDisplay.PowerupHudData[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddPowerupHUDType("Name", "entry_name_in_powerup_data")*/

nzDisplay:AddPowerupHUDType("Black Ops 1", "icon_t5") 
nzDisplay:AddPowerupHUDType("Black Ops 2", "icon_t6")
nzDisplay:AddPowerupHUDType("Black Ops 3", "icon_t7")
nzDisplay:AddPowerupHUDType("Shadows of Evil (Incomplete)", "icon_t7zod")
nzDisplay:AddPowerupHUDType("Black Ops 4", "icon_t8")
nzDisplay:AddPowerupHUDType("Cold War", "icon_t9")

//for use in adding custom vulture icons to your own entities
nzDisplay.vultureHUDicons = nzDisplay.vultureHUDicons or {}
function nzDisplay:AddVultureIcon(id, material)
	if material then
		nzDisplay.vultureHUDicons[id] = material
	else
		nzDisplay.vultureHUDicons[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddVultureIcon("entity_class", Material("path/to/icon.png", "smooth unlitgeneric"))*/

nzDisplay:AddVultureIcon("nz_ammo_matic", Material("nz_moo/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric")) 
nzDisplay:AddVultureIcon("pap", Material("nz_moo/vulture/fxt_zmb_perk_pap.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("wall_buys", Material("nz_moo/vulture/fxt_zmb_perk_rifle.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("random_box", Material("nz_moo/vulture/fxt_zmb_perk_magic_box.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("wunderfizz_machine", Material("nz_moo/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("drop_widows", Material("nz_moo/vulture/t7_hud_mp_inventory_semtex.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("drop_tombstone", Material("nz_moo/vulture/specialty_tombstone_zombies.png", "smooth unlitgeneric"))

//used in revive_system for hud based down/revive sounds 
nzDisplay.HUDdowndata = nzDisplay.HUDdowndata or {}
function nzDisplay:AddDownSoundsType(id, data)
	if data then
		nzDisplay.HUDdowndata[id] = data
	else
		nzDisplay.HUDdowndata[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddDownSoundsType("Name", {
	down = "path/to/down_sound.wav", --not required
	loop = "path/to/down_loop_sound.wav",
	revive = "path/to/revived_sound.wav",
	delay = 0.5, --delay before playing downed loop after going down
	volume = 0.25, --downed loop sound level, you want this to be low
})*/

nzDisplay:AddDownSoundsType("Classic", {
	loop = "nz_moo/player/t6/laststand_loop.wav",
	revive = "nz_moo/player/t6/plr_revived.wav",
	delay = 0,
	volume = 0.5,
})

nzDisplay:AddDownSoundsType("Black Ops 3", {
	down = "nz_moo/player/t7/player_downed.wav",
	loop = "nz_moo/player/t7/player_downed_loop.wav",
	revive = "nz_moo/player/t7/player_revived.wav",
	delay = 0.5,
	volume = 0.25,
})
