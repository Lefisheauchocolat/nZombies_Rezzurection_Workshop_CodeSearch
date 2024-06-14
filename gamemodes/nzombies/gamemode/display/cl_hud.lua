-------------------------
-- Localize
local pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale =
	pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale

local math, surface, table, input, string, draw, killicon, file =
	math, surface, table, input, string, draw, killicon, file

local file_exists, input_getkeyname, input_isbuttondown, input_lookupbinding, table_insert, table_remove, table_isempty, table_count, table_copy =
	file.Exists, input.GetKeyName, input.IsButtonDown, input.LookupBinding, table.insert, table.remove, table.IsEmpty, table.Count, table.Copy

local string_len, string_sub, string_gsub, string_upper, string_rep, string_match =
	string.len, string.sub, string.gsub, string.upper, string.rep, string.match

local TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM =
	TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM

if GetConVar("nz_hud_show_compass") == nil then
	CreateClientConVar("nz_hud_show_compass", 0, true, false, "Enable or disable drawing the compass if applicable to current HUD (reworked huds only). (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_health") == nil then
	CreateClientConVar("nz_hud_show_health", 1, true, false, "Enable or disable the Health Bar. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_show_health_mp") == nil then
	CreateClientConVar("nz_hud_show_health_mp", 0, true, false, "Enable or disable the Health Bar under other players Portraits. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_stamina") == nil then
	CreateClientConVar("nz_hud_show_stamina", 0, true, false, "Enable or disable the Stamina Bar. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_names") == nil then
	CreateClientConVar("nz_hud_show_names", 0, true, false, "Enable or disable displaying Names above other players Portraits. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_perkstats") == nil then
	CreateClientConVar("nz_hud_show_perkstats", 0, true, false, "Enable or disable perk stat indicators above active weapons name (only for applicable perks). (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_wepicon") == nil then
	CreateClientConVar("nz_hud_show_wepicon", 0, true, false, "Enable or disable displaying currently held weapons killicon next to its name. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_perk_frames") == nil then
	CreateClientConVar("nz_hud_show_perk_frames", 1, true, false, "Enable or disable displaying perk frames to represent max perk count. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_player_indicators") == nil then
	CreateClientConVar("nz_hud_player_indicators", 1, true, false, "Enable or disable player indicators appearing around the screen, ONLY WORKS IN PVS. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_player_indicator_angle") == nil then
	CreateClientConVar("nz_hud_player_indicator_angle", 0.45, true, false, "How 'behind' a player must be to draw the arrow indicator. 0 will always draw indicators, 0.5 will draw indicators within 180° behind you. its a percentage ratio, think 1 being 100% and 0 being 0%. Default is 0.45", 0, 1)
end

if GetConVar("nz_hud_use_playercolor") == nil then
	CreateClientConVar("nz_hud_use_playercolor", 0, true, false, "Enable or disable using Player Color instead of a random one assigned on game start. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_use_mapfont") == nil then
	CreateClientConVar("nz_hud_use_mapfont", 0, true, false, "Enable or disable using 'Map Settings Font' instead of enforcing the selected HUDs font type. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_better_scaling") == nil then
	CreateClientConVar("nz_hud_better_scaling", 1, true, false, "Enable or disable better HUD scaling for lower resolutions (recommended for 720p, does nothing at 1080p). (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_clientside_points") == nil then
	CreateClientConVar("nz_hud_clientside_points", 0, true, true, "Enable or disable calculating points within the hud instead of using net messages, if multiple points are earned in the same tick the total points earned will be displayed instead due to this. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_aat_style") == nil then
	CreateClientConVar("nz_hud_aat_style", 0, true, true, "Change the style of how AAT's display on certain HUDs. (0 for Icon, 1 for Text), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_aat_textcolor") == nil then
	CreateClientConVar("nz_hud_aat_textcolor", 1, true, true, "Enable or disable replacing Weapon Name text color with the assigned AAT's color on certain HUDs. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_perk_row_modulo") == nil then
	CreateClientConVar("nz_hud_perk_row_modulo", 8, true, true, "Amount of perks in the player's perk deck before creating a new row. Default is 8.", 1, 64)
end

if GetConVar("nz_bloodmeleeoverlay") == nil then
	CreateClientConVar("nz_bloodmeleeoverlay", 1, true, true, "Enable or disable drawing the blood splatter effect on the screen when damaging zombies with a melee weapon. (0 false, 1 true), Default is 1.", 0, 1)
end

cvars.AddChangeCallback("nz_hud_clientside_points", function(name, old, new)
	local b_clpoints = tonumber(new) == 1
	if timer.Exists(name) then timer.Remove(name) end
	timer.Create(name, 2, 1, function() //delay so you cant spam netmessages to the server, as that would be catastrophically bad
		net.Start("nz.CLPointsUpdate")
			net.WriteBool(b_clpoints)
		net.SendToServer()
	end)
end)

local voiceloopback = GetConVar("voice_loopback")
local cl_drawhud = GetConVar("cl_drawhud")
local sv_clientpoints = GetConVar("nz_point_notification_clientside")
local nz_clientpoints = GetConVar("nz_hud_clientside_points")
local nz_perkmax = GetConVar("nz_difficulty_perks_max")
local nz_meleeblood = GetConVar("nz_bloodmeleeoverlay")

local nz_showhealth = GetConVar("nz_hud_show_health")
local nz_showhealthmp = GetConVar("nz_hud_show_health_mp")
local nz_showstamina = GetConVar("nz_hud_show_stamina")
local nz_shownames = GetConVar("nz_hud_show_names")
local nz_showmmostats = GetConVar("nz_hud_show_perkstats")
local nz_showgun = GetConVar("nz_hud_show_wepicon")
local nz_showperkframe = GetConVar("nz_hud_show_perk_frames")

local nz_indicators = GetConVar("nz_hud_player_indicators")
local nz_indicatorangle = GetConVar("nz_hud_player_indicator_angle")
local nz_betterscaling = GetConVar("nz_hud_better_scaling")
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")

local nz_aatstyle = GetConVar("nz_hud_aat_style")
local nz_aatcolor = GetConVar("nz_hud_aat_textcolor")
local nz_perkrowmod = GetConVar("nz_hud_perk_row_modulo")
local nz_mapfont = GetConVar("nz_hud_use_mapfont")

local color_white_50 = Color(255, 255, 255, 50)
local color_white_100 = Color(255, 255, 255, 100)
local color_white_150 = Color(255, 255, 255, 150)
local color_white_200 = Color(255, 255, 255, 200)
local color_black_100 = Color(0, 0, 0, 100)
local color_black_180 = Color(0, 0, 0, 180)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_255 = Color(255, 0, 0, 255)

local color_t7 = Color(140, 255, 255, 255)
local color_t7_outline = Color(0, 220, 255, 10)
local color_t7zod = Color(255, 250, 100, 255)
local color_t7zod_outline = Color(255, 120, 10, 40)
local color_t7tomb = Color(255, 245, 245, 255)
local color_t7tomb_outline = Color(200, 40, 80, 10)

local color_grey = Color(200, 200, 200, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(135, 200, 255)
local color_yellow = Color(255, 178, 0, 255)

local color_points1 = Color(255, 200, 0, 255)
local color_points2 = Color(100, 255, 70, 255)
local color_points4 = Color(255, 0, 0, 255)

local classicmaxammo = {
	["Tranzit (Black Ops 2)"] = true,
	["Black Ops 1"] = true,
	["Buried"] = true,
	["Mob of the Dead"] = true,
	["Origins (Black Ops 2)"] = true,
	["Snowglobe"] = true,
	["Industrial Estate"] = true,
	["Encampment"] = true,
}
local t7maxammo = {
	["Black Ops 3"] = true,
}
local cthulhuammo = {
	["Shadows of Evil"] = true,
}
local tombammo = {
	["Origins (HD)"] = true,
}

roundcounters = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "i", "ii", "iii", "iiii", "iiiii"}
roundassets = {["burnt"] = {}, ["heat"] = {}, ["normal"] = {}}

for k, v in pairs(roundcounters) do
	for a, b in pairs(roundassets) do
		roundassets[a][tonumber(v) or v] = Material("round/_bo4/" .. a .. "/" .. v .. ".png", "unlitgeneric")
	end
end

roundassets["sparks"] = {}

for i = 0, 19 do
	roundassets["sparks"][i] = Material("round/sparks/" .. i .. ".png", "unlitgeneric")
end

/*local spark_center = {x = 33, y = -84}
local spark_size = {x = 168, y = 252}

local function DrawSpark(x, y, size)
end*/

local oldnum = 0
local usingtally = true

local tallysize = 150
local digitsize = {x = 84, y = 120}

local strokes = {
	[0] = {
		[1] = {
			{42, 10},
			{17, 28},
			{11, 65},
			{24, 96},
			{44, 108}
		},
		[2] = {
			{42, 10},
			{66, 29},
			{69, 64},
			{62, 93},
			{44, 108}
		}
	},
	[1] = {
		[1] = {
			{36, 9},
			{38, 51},
			{49, 107}
		}
	},
	[2] = {
		[1] = {
			{14, 45},
			{26, 24},
			{45, 11},
			{55, 27},
			{44, 57},
			{32, 100},
			{56, 89},
			{73, 70}
		}
	},
	[3] = {
		[1] = {
			{14, 36},
			{29, 17},
			{48, 10},
			{63, 22},
			{55, 44},
			{33, 62},
			{59, 67},
			{67, 84},
			{54, 99},
			{32, 106}
		}
	},
	[4] = {
		[1] = {
			{58, 18},
			{53, 49},
			{52, 113}
		},
		[2] = {
			{40, 8},
			{22, 63},
			{67, 40}
		}
	},
	[5] = {
		[1] = {
			{61, 7},
			{28, 18},
			{26, 55},
			{58, 41},
			{61, 76},
			{58, 102},
			{45, 112},
			{30, 102}
		}
	},
	[6] = {
		[1] = {
			{53, 9},
			{31, 35},
			{23, 65},
			{25, 97},
			{36, 109},
			{53, 92},
			{61, 51},
			{42, 61},
			{31, 74}
		}
	},
	[7] = {
		[1] = {
			{15, 37},
			{42, 24},
			{64, 8},
			{58, 56},
			{48, 111}
		}
	},
	[8] = {
		[1] = {
			{43, 7},
			{24, 29},
			{25, 55},
			{44, 58},
			{62, 70},
			{57, 95},
			{40, 114}
		},
		[2] = {
			{43, 7},
			{56, 23},
			{53, 45},
			{44, 58},
			{33, 77},
			{26, 102},
			{40, 114}
		}
	},
	[9] = {
		[1] = {
			{50, 44},
			{28, 63},
			{11, 56},
			{19, 34},
			{35, 18},
			{57, 18},
			{69, 18},
			{54, 62},
			{38, 114}
		}
	},
	["i"] = {
		[1] = {
			{35, 44},
			{59, 210}
		}
	},
	["ii"] = {
		[1] = {
			{83, 56},
			{104, 212}
		}
	},
	["iii"] = {
		[1] = {
			{138, 62},
			{148, 205}
		}
	},
	["iiii"] = {
		[1] = {
			{188, 62},
			{189, 195}
		}
	},
	["iiiii"] = {
		[1] = {
			{24, 61},
			{210, 201}
		}
	},
	["e"] = {
		[1] = {
			{62, 26},
			{43, 18},
			{22, 25},
			{17, 52},
			{34, 62},
			{48, 60},
			{28, 78},
			{30, 96},
			{49, 99},
			{64, 89}
		}
	},
	["slash"] = {
		[1] = {
			{69, 25},
			{19, 90}
		}
	}
}

local tallycoordmult = tallysize/256
local rounddata = {}
local sparkdata = {}
local roundbusy = false
local prev_round_special = false
local spacing = 70

-------------------------
//------------------------------------------------GHOSTLYMOO'S HUD------------------------------------------------\\

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
}

nzDisplay.modernHUDs = {
	["Black Ops 3"] = true,
	["Black Ops 4"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
}

nzDisplay.HUDdowndata = {
	["Classic"] = { -- default/fallback
		loop = "nz_moo/player/t6/laststand_loop.wav",
		revive = "nz_moo/player/t6/plr_revived.wav",
		delay = 0,
		volume = 0.5,
	},
	["Black Ops 3"] = {
		down = "nz_moo/player/t7/player_downed.wav",
		loop = "nz_moo/player/t7/player_downed_loop.wav",
		revive = "nz_moo/player/t7/player_revived.wav",
		delay = 0.5,
		volume = 0.25,
	},
	["Shadows of Evil"] = {
		down = "nz_moo/player/t7/player_downed.wav",
		loop = "nz_moo/player/t7/player_downed_loop.wav",
		revive = "nz_moo/player/t7/player_revived.wav",
		delay = 0.5,
		volume = 0.25,
	},
}

nzDisplay.vultureHUDicons = {
	["nz_ammo_matic"] = Material("nz_moo/icons/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric"),
	["pap"] = Material("nz_moo/icons/vulture/fxt_zmb_perk_pap.png", "smooth unlitgeneric"),
	["wall_buys"] = Material("nz_moo/icons/vulture/fxt_zmb_perk_rifle.png", "smooth unlitgeneric"),
	["random_box"] = Material("nz_moo/icons/vulture/fxt_zmb_perk_magic_box.png", "smooth unlitgeneric"),
	["wunderfizz_machine"] = Material("nz_moo/icons/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric"),
}


//------Pre-Loading POWERUP Icons------\\
/*local t8_powerup_minigun = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_death_machine.png", "unlitgeneric")
local t8_powerup_blood = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_blood.png", "unlitgeneric")
local t8_powerup_2x = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_2x.png", "unlitgeneric")
local t8_powerup_killjoy = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_instakill.png", "unlitgeneric")
local t8_powerup_firesale = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_firesale.png", "unlitgeneric")
local t8_powerup_bonfiresale = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_campfire.png", "unlitgeneric")
local t8_powerup_timewarp = Material("vgui/t8_hud_robit_powerup_time_warp.png", "unlitgeneric")
local t8_powerup_berzerk = Material("vgui/bo4_bzk.png", "unlitgeneric")*/

local t8_powerup_minigun = Material("vgui/cw_death.png", "unlitgeneric")
local t8_powerup_blood = Material("vgui/cw_blood.png", "unlitgeneric")
local t8_powerup_2x = Material("vgui/robit_cw_powerup_double_points.png", "unlitgeneric")
local t8_powerup_killjoy = Material("vgui/robit_cw_powerup_instakill.png", "unlitgeneric")
local t8_powerup_firesale = Material("vgui/robit_cw_powerup_firesale.png", "unlitgeneric")
local t8_powerup_bonfiresale = Material("vgui/cw_bonfire.png", "unlitgeneric")
local t8_powerup_timewarp = Material("vgui/cw_time_alt.png", "unlitgeneric")
local t8_powerup_berzerk = Material("vgui/cw_bzk.png", "unlitgeneric")
local t8_powerup_infinite = Material("vgui/cw_infinite.png", "unlitgeneric")
local t8_powerup_godmode = Material("vgui/cw_greyson.png", "unlitgeneric")
local t8_powerup_quick = Material("vgui/cw_fast.png", "unlitgeneric")

//------Pre-Loading Max Ammo Elements------\\
local t8_powerup_kaboomtext = Material("nz_moo/huds/bo4/pow_notifs/t8_zmhud_nuke_text.png", "unlitgeneric smooth")
local t8_powerup_perkslottext = Material("nz_moo/huds/bo4/pow_notifs/t8_zmhud_perkslot_text.png", "unlitgeneric smooth")
local t8_powerup_maxammotext = Material("nz_moo/huds/bo4/pow_notifs/t8_zmhud_maxammo_text.png", "unlitgeneric smooth")
local t8_powerup_maxammotray = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_tray.png", "unlitgeneric smooth")
local t8_powerup_maxammobg = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_bg.png", "unlitgeneric smooth")
local t8_powerup_maxammocircle = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_circle.png", "unlitgeneric smooth")
local t8_powerup_maxammoglow = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_glow.png", "unlitgeneric smooth")
local t8_powerup_maxammospikes = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_spikes.png", "unlitgeneric smooth")
local t8_powerup_maxammostar = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_star.png", "unlitgeneric smooth")
local t8_powerup_maxammoswish = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_swish.png", "unlitgeneric smooth")

local t7_powerup_maxammobg = Material("nz_moo/huds/bo3/uie_t7_zm_hud_notif_backdesign_factory.png", "unlitgeneric smooth")
local t7_powerup_maxammofg = Material("nz_moo/huds/bo3/uie_t7_zm_hud_notif_factory.png", "unlitgeneric smooth")

local tomb_powerup_maxammobg = Material("nz_moo/huds/t7_tomb/uie_t7_zm_hud_notif_backdesign_factory.png", "unlitgeneric smooth")
local tomb_powerup_maxammofg = Material("nz_moo/huds/t7_tomb/uie_t7_zm_hud_notif_factory.png", "unlitgeneric smooth")

local t7zod_powerup_maxammobg = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_backdesign.png", "unlitgeneric smooth")
local t7zod_powerup_maxammofg = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_cthuluph.png", "unlitgeneric smooth")
local t7zod_powerup_maxammotext = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtbacking.png", "unlitgeneric smooth")
local t7zod_powerup_maxammoctnr = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtcontainer.png", "unlitgeneric smooth")

//------Pre-Loading MISC HUD Elements------\\
local zmhud_vfx_blood = Material("nz_moo/huds/oilrig/vfx_blood_screen_splatter.png", "unlitgeneric smooth")
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_icon_holygrenade = Material("nz_moo/hud_holygrenade.png", "unlitgeneric smooth")
local zmhud_icon_frame = Material("nz_moo/icons/perk_frame.png", "unlitgeneric smooth")
local zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
local zmhud_icon_player = Material("nz_moo/icons/offscreenobjectivepointer.png", "unlitgeneric smooth")
local zmhud_icon_death = Material("nz_moo/icons/hud_status_dead.png", "unlitgeneric smooth")
local zmhud_icon_mule = Material("nz_moo/icons/bo1/mulekick.png", "unlitgeneric smooth")
local zmhud_icon_talk = Material("nz_moo/icons/talkballoon.png", "unlitgeneric smooth")
local zmhud_icon_voiceon = Material("nz_moo/icons/voice_on.png", "unlitgeneric smooth")
local zmhud_icon_voicedim = Material("nz_moo/icons/voice_on_dim.png", "unlitgeneric smooth")
local zmhud_icon_voiceoff = Material("nz_moo/icons/voice_off.png", "unlitgeneric smooth")
local zmhud_icon_offscreen = Material("nz_moo/icons/offscreen_arrow.png", "unlitgeneric smooth")
local zmhud_icon_camera = Material("nz_moo/icons/menu_mp_lobby_views.png", "unlitgeneric smooth")
local zmhud_icon_headshot = Material("nz_moo/icons/uie_death_headshot.png", "smooth unlitgeneric")

//------Pre-Loading SPECIAL HUD Icons------\\
local zmhud_icon_shield = Material("nz_moo/huds/bo4/t8_rocket_shield.png", "unlitgeneric smooth")
local zmhud_icon_special = Material("nz_moo/huds/bo4/t8_specialweapon.png", "unlitgeneric smooth")
local zmhud_icon_grenade = Material("nz_moo/icons/hud_us_grenade.png", "unlitgeneric smooth")
local zmhud_icon_sticky = Material("nz_moo/hud_sticky_grenade_32.png", "unlitgeneric smooth")
local zmhud_icon_trap = Material("nz_moo/icons/zm_turbine_icon.png", "unlitgeneric smooth")

local illegalspecials = {
	["specialgrenade"] = true,
	["grenade"] = true,
	["knife"] = true,
	["display"] = true,
}

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
	return "classic"
end

function GetPerkIconMaterial(perk)
	if not perk then return zmhud_icon_missing end

	local style = nzMapping.Settings.icontype
	if style == "Rezzurrection" then return nzPerks:Get(perk).icon end
	if style == "Infinite Warfare" then return nzPerks:Get(perk).icon_iw end
	if style == "No Background" then return nzPerks:Get(perk).icon_glow end
	if style == "World at War/ Black Ops 1" then return nzPerks:Get(perk).icon_waw end
	if style == "Black Ops 2" then return nzPerks:Get(perk).icon_bo2 end
	if style == "Black Ops 3" then return nzPerks:Get(perk).icon_bo3 end
	if style == "Black Ops 4" then return nzPerks:Get(perk).icon_bo4 end
	if style == "MW3 Zombies" then return nzPerks:Get(perk).icon_mwz end
	if style == "Frosted Flakes" then return nzPerks:Get(perk).icon_cotd end
	if style == "Modern Warfare" then return nzPerks:Get(perk).icon_mw end
	if style == "Hololive" then return nzPerks:Get(perk).icon_holo end
	if style == "Cold War" then return nzPerks:Get(perk).icon_cw end
	if style == "April Fools" then return nzPerks:Get(perk).icon_dumb end
	if style == "WW2" then return nzPerks:Get(perk).icon_ww2 end
	if style == "Shadows of Evil" then return nzPerks:Get(perk).icon_soe end
	if style == "Halloween" then return nzPerks:Get(perk).icon_halloween end
	if style == "Christmas" then return nzPerks:Get(perk).icon_xmas end
	if style == "Vanguard" then return nzPerks:Get(perk).icon_griddy end
	if style == "Neon" then return nzPerks:Get(perk).icon_neon end
	if style == "Overgrown" then return nzPerks:Get(perk).icon_grown end
	if style == "Pickle Glow" then return nzPerks:Get(perk).icon_pickle end
	if style == "Herrenhaus" then return nzPerks:Get(perk).icon_coggers end
	if style == "Paper" then return nzPerks:Get(perk).icon_paper end
	if style == "Cheese Cube" then return nzPerks:Get(perk).icon_cheese end
	if style == "Charred" then return nzPerks:Get(perk).icon_charred end
	
	return nzPerks:Get(perk).icon
end

local zmhud_icon_frame_mw3 = Material("nz_moo/icons/mw3_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_mw = Material("nz_moo/icons/mw_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_cheese = Material("nz_moo/icons/cheddar_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_coggers = Material("nz_moo/icons/herren_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_vanguard = Material("nz_moo/icons/griddy_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_pickle = Material("nz_moo/icons/pickle_frame.png", "unlitgeneric smooth")
local zmhud_icon_frame_atoms = Material("nz_moo/icons/iw_frame.png", "unlitgeneric smooth")

function GetPerkFrameMaterial()
	local style = nzMapping.Settings.icontype
	if style == "Vanguard" then return zmhud_icon_frame_vanguard end
	if style == "Pickle Glow" then return zmhud_icon_frame_pickle end
	if style == "Cheese Cube" then return zmhud_icon_frame_cheese end
	if style == "Herrenhaus" then return zmhud_icon_frame_coggers end
	if style == "Infinite Warfare" then return zmhud_icon_frame_atoms end
	if style == "MW3 Zombies" then return zmhud_icon_frame_mw3 end
	if style == "Modern Warfare" then return zmhud_icon_frame_mw end

	return zmhud_icon_frame
end

-- Fuck
--[[local function MusicHUD()
	if spectating then return end
	if not ply.ambiences then ply.ambiences = {} end
	if not ply.refstrings then ply.refstrings = {} end

	if nzRound:InState(ROUND_PROG) and nzRound:GetStartMusic() == true and !nzRound:IsSpecial() then
		for k, v in pairs(nzMapping.Settings.underscoresong) do
			if v then
				if nzRound:InProgress() and !nzRound:IsSpecial() then
					if not ply.refstrings[k] then --Haven't cached yet
						ply.refstrings[k] = v
						ply.ambiences[k] = CreateSound(ply, v)
					elseif ply.refstrings[k] ~= v then --Cached but the sound was changed, requires re-cache
						if ply.ambiences[k] then ply.ambiences[k]:Stop() end --stop the existing sound if it's still playing

						ply.refstrings[k] = v
						ply.ambiences[k] = CreateSound(ply, v)
					end

					if ply.ambiences[k] then
						ply.ambiences[k]:Play()
					end
				elseif ply.ambiences[k] then
					ply.ambiences[k]:Stop()
				end
			end
		end
	elseif nzRound:InState(ROUND_PROG) and nzRound:GetStartMusic() == true and nzRound:IsSpecial() then
		for k, v in pairs(nzMapping.Settings.specunderscoresong) do
			if v then
				if nzRound:InProgress() and nzRound:IsSpecial() then
					if not ply.refstrings[k] then --Haven't cached yet
						ply.refstrings[k] = v
						ply.ambiences[k] = CreateSound(ply, v)
					elseif ply.refstrings[k] ~= v then --Cached but the sound was changed, requires re-cache
						if ply.ambiences[k] then ply.ambiences[k]:Stop() end --stop the existing sound if it's still playing

						ply.refstrings[k] = v
						ply.ambiences[k] = CreateSound(ply, v)
					end

					if ply.ambiences[k] then
						ply.ambiences[k]:Play()
					end
				elseif ply.ambiences[k] then
					ply.ambiences[k]:Stop()
				end
			end
		end
	end
end]]

local function StatesHud()
	if cl_drawhud:GetBool() then
		local text = ""
		local font = ("nz.main."..GetFontType(nzMapping.Settings.mainfont))
		local w, h = ScrW(), ScrH()
		local pscale = 1
		if nz_betterscaling:GetBool() then
			pscale = (w/1920 + 1) / 2
		end

		if nzRound:InState( ROUND_WAITING ) then
			text = "Waiting for players. Type /ready to ready up."
			font = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))
		elseif nzRound:InState( ROUND_CREATE ) then
			text = "Creative Mode"
		elseif nzRound:InState( ROUND_GO ) then
			text = "Game Over"
		end

		local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor
		draw.SimpleTextOutlined(text, font, w/2, 60*pscale, fontColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
	end
end

local PointsNotifications = {}
local function PointsNotification(ply, amount)
	if not IsValid(ply) then return end
	local data = {ply = ply, amount = amount, diry = math.random(-25, 25), time = CurTime()}
	table_insert(PointsNotifications, data)
end

net.Receive("nz_points_notification", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	PointsNotification(ply, amount)
end)

//Equipment
local function InventoryHUD()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local ammofont =  ("nz.ammo."..GetFontType(nzMapping.Settings.ammofont))
	local ammo2font =  ("nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font))

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920)+1)/2
	local plyweptab = ply:GetWeapons()

	// Special Weapon Categories
	for _, wep in pairs(plyweptab) do
		// Traps
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "trap" then
			local icon = zmhud_icon_trap
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end

			local traphp = wep:Clip1()
			local trapmax = wep.Primary_TFA.ClipSize

			local trapscale = math.Clamp(traphp / trapmax, 0, 1)
			local traphealthcolor = Color(255, 300*trapscale, 300*trapscale, 255)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 20*scale) - 32, (h - 280*scale) - 32, 48, 48)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect((w - 22*scale) - 32, (h - 230*scale) - 32*scale, 48, 10)
			surface.SetDrawColor(traphealthcolor)
			surface.DrawRect((w - 20*scale) - 32, (h - 228*scale) - 32*scale, 44 * trapscale, 6)

			local ammo = wep:GetPrimaryAmmoType()
			if ammo > 0 and not wep.TrapCanBePlaced then
				local ammocount = ply:GetAmmoCount(ammo) + wep:Clip1()
				if ammocount > 0 then
					draw.SimpleTextOutlined(ammocount, ammo2font, w - 18*scale, h - 264*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
				end
			end

			local nz_key_trap = GetConVar("nz_key_trap")
			if nz_key_trap then
				local key = nz_key_trap:GetInt() > 0 and nz_key_trap:GetInt() or 1
				draw.SimpleTextOutlined("["..string_upper(input_getkeyname(key)).."]", ammofont, (w - 40*scale) - 32*scale, (h - 240*scale) - 32*scale, input_isbuttondown(key) and color_gold or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
			end
		end

		// Specialists
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
			local icon = zmhud_icon_special
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end

			local specialhp = wep:Clip1()
			local specialmax = wep.Primary_TFA.ClipSize

			local specialscale = math.Clamp(specialhp / specialmax, 0, 1)
			local specialchargecolor = Color(255, 300*specialscale, 300*specialscale, 255)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 20*scale) - 32, (h - 360*scale) - 32, 48, 48)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect((w - 22*scale) - 32, (h - 310*scale) - 32*scale, 48, 10)
			surface.SetDrawColor(specialchargecolor)
			surface.DrawRect((w - 20*scale) - 32, (h - 308*scale) - 32*scale, 44 * specialscale, 6)

			local nz_key_specialist = GetConVar("nz_key_specialist")
			if nz_key_specialist then
				local key = nz_key_specialist:GetInt() > 0 and nz_key_specialist:GetInt() or 1
				draw.SimpleTextOutlined("["..string_upper(input_getkeyname(key)).."]", ammofont, (w - 40*scale) - 32*scale, (h - 320*scale) - 32*scale, input_isbuttondown(key) and color_gold or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
			end
		end

		// Shield Slot Occupier
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "shield" and wep.NZHudIcon and not wep.ShieldEnabled then
			local icon = zmhud_icon_shield
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end

			local clipsize = wep.Primary_TFA.ClipSize
			if clipsize > 0 then //Shield slot weapon with clipsize
				local shieldwephp = wep:Clip1()
				local shieldwepmax = clipsize

				local shieldwepscale = math.Clamp(shieldwephp / shieldwepmax, 0, 1)
				local shieldwepchargecolor = Color(255, 300*shieldwepscale, 300*shieldwepscale, 255)

				surface.SetDrawColor(color_black_180)
				surface.DrawRect((w - 22*scale) - 32, (h - 390*scale) - 32*scale, 48, 10)
				surface.SetDrawColor(shieldwepchargecolor)
				surface.DrawRect((w - 20*scale) - 32, (h - 388*scale) - 32*scale, 44 * shieldwepscale, 6)
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 20*scale) - 32, (h - 440*scale) - 32, 48, 48)

			local nz_key_shield = GetConVar("nz_key_shield")
			if nz_key_shield then
				local key = nz_key_shield:GetInt() > 0 and nz_key_shield:GetInt() or 1
				draw.SimpleTextOutlined("["..string_upper(input_getkeyname(key)).."]", ammofont, (w - 40*scale) - 32*scale, (h - 400*scale) - 32*scale, input_isbuttondown(key) and color_gold or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
			end
		end
	end

	// Shield
	if ply.GetShield and IsValid(ply:GetShield()) then
		local shield = ply:GetShield()
		local wep = shield:GetWeapon()

		local icon = zmhud_icon_shield
		if IsValid(wep) and wep.NZHudIcon then
			icon = wep.NZHudIcon
		end

		local shieldhp = shield:Health()
		local shieldmax = shield:GetMaxHealth()

		local shieldscale = math.Clamp(shieldhp / shieldmax, 0, 1)
		local shieldhealthcolor = Color(255, 300*shieldscale, 300*shieldscale, 255)

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((w - 20*scale) - 32, (h - 440*scale) - 32, 48, 48)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect((w - 22*scale) - 32, (h - 390*scale) - 32*scale, 48, 10)
		surface.SetDrawColor(shieldhealthcolor)
		surface.DrawRect((w - 20*scale) - 32, (h - 388*scale) - 32*scale, 44 * shieldscale, 6)

		local nz_key_shield = GetConVar("nz_key_shield")
		if nz_key_shield then
			local key = nz_key_shield:GetInt() > 0 and nz_key_shield:GetInt() or 1
			draw.SimpleTextOutlined("["..string_upper(input_getkeyname(key)).."]", ammofont, (w - 40*scale) - 32*scale, (h - 400*scale) - 32*scale, input_isbuttondown(key) and color_gold or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
		end
	end

	// Shovel
	if ply.GetShovel and IsValid(ply:GetShovel()) then
		local shovel = ply:GetShovel()
		local usecount = shovel:GetUseCount()

		surface.SetMaterial(shovel:IsGolden() and shovel.NZHudIcon2 or shovel.NZHudIcon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((w - 20*scale) - 32, (h - 200*scale) - 32, 48, 48)

		draw.SimpleTextOutlined("["..usecount.."]", ammofont, (w - 40*scale) - 32*scale, (h - 160*scale) - 32*scale, turbinehealthcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
	end
end

local function ScoreHud()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local fontmain = ("nz.pointsmain."..GetFontType(nzMapping.Settings.mediumfont))
	local fontsmall = ("nz.points."..GetFontType(nzMapping.Settings.mediumfont))
	local fontnade = "nz.grenade"

	local w, h = ScrW(), ScrH()
	local wf = w/1920
	local scale = (w/1920 + 1) / 2
	local offset = 0
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = scale
	end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local plyindex = ply:EntIndex()
	local plytab = player.GetAll()

	//nickname
	if nz_shownames:GetBool() then
		local nick = ply:Nick()
		if #nick > 20 then
			nick = string.sub(nick, 1, 20) //limit name to 20 chars
		end

		if ply:IsSpeaking() then
			local icon = zmhud_icon_voicedim
			if ply:VoiceVolume() > 0 then
				icon = zmhud_icon_voiceon
			end
			if not voiceloopback:GetBool() then
				icon = zmhud_icon_voiceon
			end

			surface.SetFont(fontsmall)
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(wf + 24*scale + tw, h - (290*scale) - offset - 16, 32, 32)
		end

		draw.SimpleTextOutlined(nick, fontsmall, wf + 24*pscale, h - (290*scale) - offset, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black)
	end

	local color = player.GetColorByIndex(plyindex)
	local blood = player:GetHUDPointsType(nzMapping.Settings.hudtype)
	if not blood then
		blood = zmhud_icon_missing
	else
		blood = Hudmat(blood)
	end

	if nz_useplayercolor:GetBool() then
		local pcol = ply:GetPlayerColor()
		color = Color(255*pcol.x, 255*pcol.y, 255*pcol.z, 255)
	end
	if not blood or blood:IsError() then
		blood = zmhud_icon_missing
	end

	//points
	surface.SetDrawColor(color_grey)
	surface.SetMaterial(blood)
	surface.DrawTexturedRectRotated(wf + 128*pscale, h - (250*scale) - offset, 215*pscale, 50*pscale, 180)

	draw.SimpleTextOutlined(ply:GetPoints(), fontmain, wf + 85*pscale, h - (249*scale) - offset, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black)
	ply.PointsSpawnPosition = {x = wf + 205*pscale, y = h - 245 * scale - offset}

	//icon
	local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")

	surface.SetDrawColor(color_white)
	surface.SetMaterial(pmpath)
	surface.DrawTexturedRect(wf + 25*pscale, h - 275 * scale - offset, 48*pscale, 48*pscale)

	surface.SetDrawColor(color)
	surface.DrawOutlinedRect(wf + 25*pscale, h - 275 * scale - offset, 50*pscale, 50*pscale, 3*pscale)

	//players
	for k, v in ipairs(plytab) do
		local index = v:EntIndex()
		if index == plyindex then continue end

		local pcolor = player.GetColorByIndex(index)
		local blood = player:GetHUDPointsType(nzMapping.Settings.hudtype)
		if not blood then
			blood = zmhud_icon_missing
		else
			blood = Hudmat(blood)
		end

		if nz_useplayercolor:GetBool() then
			local pvcol = v:GetPlayerColor()
			pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		end

		if ply == v then
			offset = offset + 55 -- change this if you change the size of nz.display.hud.medium
		else
			offset = offset + 55*pscale
		end

		if nz_showhealthmp:GetBool() then
			offset = offset + 5 //health bar offset buffer
		end
		if nz_shownames:GetBool() then
			offset = offset + 25 //nickname offset buffer

			local nick = v:Nick()
			if #nick > 20 then
				nick = string.sub(nick, 1, 20) //limit name to 20 chars
			end

			if v:IsSpeaking() then
				local icon = zmhud_icon_voicedim
				if v:VoiceVolume() > 0 then
					icon = zmhud_icon_voiceon
				end
				if v:IsMuted() then
					icon = zmhud_icon_voiceoff
				end

				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(nick)

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(wf + 24*scale + tw, h - (290*scale) - offset - 16, 32, 32)
			end

			draw.SimpleTextOutlined(nick, fontsmall, wf + 24*pscale, h - (290*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black)
		end

		//points
		surface.SetFont(fontsmall)
		surface.SetDrawColor(color_grey)
		surface.SetMaterial(blood)
		surface.DrawTexturedRectRotated(wf + 115*pscale, h - 253 * scale - offset, 200*pscale, 45*pscale, 180)

		draw.SimpleTextOutlined(v:GetPoints(), fontsmall, wf + 75*pscale, h - 253 * scale - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black)
		v.PointsSpawnPosition = {x = wf + 190*pscale, y = h - 253 * scale - offset}

		//icon
		local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(wf + 25*pscale, h - 275 * scale - offset, 40*pscale, 40*pscale)

		surface.SetDrawColor(pcolor)
		surface.DrawOutlinedRect(wf + 25*pscale, h - 275 * scale - offset, 43*pscale, 43*pscale, 3*pscale)

		//shovel
		if v.GetShovel and IsValid(v:GetShovel()) then
			local pshovel = v:GetShovel()

			surface.SetMaterial(pshovel:IsGolden() and pshovel.NZHudIcon2 or pshovel.NZHudIcon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(wf + 0, h - 270 * scale - offset, 32, 32)
		end

		//indicator
		if nz_indicators:GetBool() and v:GetNotDowned() then
			local pos = ply:GetPos()
			local epos = v:GetPos()

			local ang = nz_indicatorangle:GetFloat()
			local dir = ply:EyeAngles():Forward()
			local facing = (pos - epos):GetNormalized()

			if (facing:Dot(dir) + 1) / 2 > ang then
				local screen = ScreenScale(8)
				local xscale = ScreenScale(260)
				local yscale = ScreenScale(160)

				local dist = math.Clamp(pos:Distance(epos) / 200, 0, 1)
				local dir = (epos - pos):Angle()
				dir = dir - EyeAngles()
				local angle = dir.y + 90

				local x = (math.cos(math.rad(angle)) * xscale) + w / 2
				local y = (math.sin(math.rad(angle)) * -yscale) + h / 2

				surface.SetMaterial(zmhud_icon_player)
				surface.SetDrawColor(pcolor)
				if v:IsDormant() then
					surface.SetDrawColor(ColorAlpha(pcolor, 40))
				end
				if v:GetNW2Float("nz.LastHit", 0) + 0.35 > CurTime() then
					surface.SetDrawColor(color_used)
				end

				surface.DrawTexturedRectRotated(x, y, screen*2, screen, angle - 90)
			end
		end

		//health
		if nz_showhealthmp:GetBool() then
			local phealth = v:Health()
			local pmaxhealth = v:GetMaxHealth()
			local poffset = 40*pscale + 5 //player portrait dimensions + 5 for a bit of room

			local phealthscale = math.Clamp(phealth / pmaxhealth, 0, 1)
			local phealthcolor = Color(255, 300*phealthscale, 300*phealthscale, 255)

			surface.SetDrawColor(phealthcolor)
			surface.DrawRect(wf + 25*pscale, h - (275*scale) - offset + poffset, 142 * phealthscale, 4)
		end
	end

	if nz_clientpoints:GetBool() or sv_clientpoints:GetBool() then
		for k, v in ipairs(plytab) do
			if not v.LastPoints then v.LastPoints = v:GetPoints() end

			if v:GetPoints() ~= v.LastPoints then
				PointsNotification(v, v:GetPoints() - v.LastPoints)
				v.LastPoints = v:GetPoints()
			end
		end
	end

	for k, v in pairs(PointsNotifications) do
		local fade = math.Clamp((CurTime()-v.time), 0, 1)
		local fadeinvert = 1 - fade
		local points1 = ColorAlpha(color_points1, 255*fadeinvert)
		local points2 = ColorAlpha(color_points2, 255*fadeinvert)
		local points4 = ColorAlpha(color_points4, 255*fadeinvert)

		if not v.ply.PointsSpawnPosition then return end

		if v.amount >= 0 then
			if v.amount >= 100 then --If you're earning 100 points or more, the notif will be green!
				draw.SimpleText("+"..v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			if v.amount < 100 then --If you're earning less than 100 points, the notif will be gold!
				draw.SimpleText("+"..v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		else -- If you're doing something that subtracts points, the notif will be red!
			draw.SimpleText(v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points4, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		if fade >= 1 then
			table_remove(PointsNotifications, k)
		end
	end
end

local function GunHud()
	if not cl_drawhud:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local wep = ply:GetActiveWeapon()

	local ammofont = ("nz.ammo."..GetFontType(nzMapping.Settings.ammofont))
	local ammo2font = ("nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font))
	local smallfont = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))
	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor

	//------MAIN HUD BG------\\
	local mainbg = nzRound:GetHUDType(nzMapping.Settings.hudtype)
	if not mainbg then
		mainbg = zmhud_icon_missing
	else
		mainbg = Hudmat(mainbg)
	end

	surface.SetMaterial(mainbg)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(w - 540*scale, h - 205*scale, 550*scale, 200*scale)
	//------MAIN HUD BG------\\

	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon then
			fontColor = Color(0, 255, 255, 255)
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, smallfont, w - 200*scale, h - 130*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", ammofont, w - 220*scale, h - 112*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, color_black)
		elseif illegalspecials[wep.NZSpecialCategory] then
			local name = wep:GetPrintName()
			draw.SimpleTextOutlined(name, smallfont, w - 200*scale, h - 130*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
		elseif not illegalspecials[wep.NZSpecialCategory] then
			local clipstring = ""
			if wep.Primary then
				local clip = wep.Primary.ClipSize
				local resclip = wep.Primary.DefaultClip
				local clip1 = wep:Clip1()

				local ammoType = wep:GetPrimaryAmmoType()
				local ammoTotal = ply:GetAmmoCount(ammoType)
				local ammoCol = color_white
				local reserveCol = color_white

				if wep.CanBeSilenced and wep:GetSilenced() then
					if wep.Clip3 then
						clip = wep.Tertiary.ClipSize
						resclip = wep.Tertiary.DefaultClip
						clip1 = wep:Clip3()
					else
						clip = wep.Secondary.ClipSize
						resclip = wep.Secondary.DefaultClip
						clip1 = wep:Clip2()
					end
					ammoTotal = ply:GetAmmoCount(wep:GetSecondaryAmmoType())
				end

				if clip and clip > 0 and clip1 <= math.ceil(clip/3) then
					ammoCol = color_red_255
				end
				if resclip and resclip > 0 and ammoTotal <= math.ceil(resclip/3) then
					reserveCol = color_red_255
				end

				if clip and clip > 0 then
					if ammoType == -1 then
						draw.SimpleTextOutlined(clip1, ammofont, w - 270*scale, h - 82*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
						clipstring = clip1
					else
						draw.SimpleTextOutlined(clip1, ammofont, w - 270*scale, h - 82*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
						if resclip and resclip > 0 then
							draw.SimpleTextOutlined("/", ammofont, w - 265*scale, h - 82*scale, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, color_black)
							draw.SimpleTextOutlined(ammoTotal, ammofont, w - 250*scale, h - 82*scale, reserveCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, color_black)
						end
						clipstring = clip1
					end
				else
					if ammoTotal and ammoTotal > 0 then
						draw.SimpleTextOutlined(ammoTotal, ammofont, w - 270*scale, h - 82*scale, reserveCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
						clipstring = ammoTotal
					end
				end
			end

			if wep.Secondary and (not wep.CanBeSilenced or (wep.CanBeSilenced and not wep:GetSilenced() and wep.Clip3)) then
				local clip2 = wep.Secondary.ClipSize
				local resclip2 = wep.Secondary.DefaultClip

				local ammoType2 = wep:GetSecondaryAmmoType()
				local ammoTotal2 = ply:GetAmmoCount(ammoType2)
				local ammoCol = color_white
				local reserveCol = color_white

				if clip2 and clip2 > 0 and wep:Clip2() <= math.ceil(clip2/3) then
					ammoCol = color_red_255
				end
				if resclip2 and resclip2 > 0 and ammoTotal2 <= math.ceil(resclip2/3) then
					reserveCol = color_red_255
				end

				surface.SetFont(ammofont)
				local tw, th = surface.GetTextSize(clipstring)

				if clip2 and clip2 > 0 then
					draw.SimpleTextOutlined(wep:Clip2().." | ", ammofont, w - 270*scale - tw, h - 82*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
				else
					if ammoTotal2 and ammoTotal2 > 0 then
						draw.SimpleTextOutlined(ammoTotal2.." | ", ammofont, w - 270*scale - tw, h - 82*scale, reserveCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
					end
				end

				if wep.CanBeSilenced and wep.NZHudIcon then
					local icon = wep.NZHudIcon

					surface.SetMaterial(icon)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect((w - 160*scale) - 32, (h - 90*scale) - 32, 48, 48)

					local ammoTotal3 = ply:GetAmmoCount(wep:GetSecondaryAmmoType()) + (wep.Clip3 and wep:Clip3() or wep:Clip2())
					if ammoTotal3 > 0 then
						draw.SimpleTextOutlined(ammoTotal3, ammo2font, w - 165*scale, h - 90*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
					end
				end
			end

			local aat = wep:GetNW2String("nzAATType", "")
			local style = nz_aatstyle:GetInt()
			local name = wep:GetPrintName()

			if aat ~= "" and style > 0 then
				name = name.." ("..nzAATs:Get(aat).name..")"
			end
			if aat ~= "" and nz_aatcolor:GetBool() then
				fontColor = nzAATs:Get(aat).color
			end

			draw.SimpleTextOutlined(name, smallfont, w - 200*scale, h - 130*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)

			if nz_showgun:GetBool() and killicon.Exists(class) and aat == "" then
				surface.SetFont(smallfont)
				local tw, th = surface.GetTextSize(name)

				killicon.Draw(w - 200*scale - (64*scale) - tw, h - 130*scale - (32*scale), class, 255)
			end

			if aat ~= "" and style == 0 then
				local fade = 255
				if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then
					fade = 90
				end

				surface.SetFont(smallfont)
				local tw, th = surface.GetTextSize(name)
				surface.SetMaterial(nzAATs:Get(aat).icon)
				surface.SetDrawColor(ColorAlpha(color_white, fade))
				surface.DrawTexturedRect(w - 200*scale - (58*scale) - tw, h - 130*scale - (48*scale), 48*scale, 48*scale)
			end

			if ply:HasPerk("mulekick") then
				surface.SetDrawColor(color_white_50)
				if IsValid(wep) and wep:GetNWInt("SwitchSlot") == 3 then
					surface.SetDrawColor(color_white)
				end
				surface.SetMaterial(zmhud_icon_mule)
				surface.DrawTexturedRect(w - 235*scale, h - 220*scale, 35, 35)
			end
		end
	end

	local specialweps = ply.NZSpecialWeapons or {}
	local tacnade = specialweps["specialgrenade"]
	local grenade = specialweps["grenade"]
	local num = ply:GetAmmoCount(GetNZAmmoID("grenade") or -1)
	local numspecial = ply:GetAmmoCount(GetNZAmmoID("specialgrenade") or -1)
	local scale = (w/1920 + 1) / 2

	if num > 0 then
		local icon = zmhud_icon_grenade
		local icon2 = zmhud_icon_sticky
		if grenade and IsValid(grenade) and grenade.NZHudIcon then
			icon = grenade.NZHudIcon
			if grenade.NZWidowIcon then
				icon2 = grenade.NZWidowIcon
			end
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(icon)
		if ply:HasPerk("widowswine") then
			surface.SetMaterial(icon2)
		end

		for i = num, 1, -1 do
			surface.SetDrawColor(ColorAlpha(color_grey, 200/i*2))
			surface.DrawTexturedRect(w - 350*scale + i * 30, h - 60*scale, 40*scale, 40*scale)
		end
	end

	if numspecial > 0 then
		local icon = zmhud_icon_grenade
		if tacnade and IsValid(tacnade) and tacnade.NZHudIcon then
			icon = tacnade.NZHudIcon
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		for i = numspecial, 1, -1 do
			surface.SetDrawColor(ColorAlpha(color_white, 255/i))
			surface.DrawTexturedRect(w - 470*scale + i * 30, h - 60*scale, 40*scale, 40*scale)
		end
	end
end

local function PerksMMOHud()
	if not cl_drawhud:GetBool() then return end
	if not nz_showmmostats:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and (illegalspecials[wep.NZSpecialCategory] or wep:GetClass() == "nz_multi_tool") then return end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor
	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local curtime = CurTime()

	local traycount = 0
	if ply:HasPerk("mulekick") then
		traycount = traycount + 1
	end

	for k, v in pairs(ply:GetPerks()) do
		local data = nzPerks:Get(v)
		if not data or not data.mmohud then continue end

		local mmohud = data.mmohud
		if not mmohud.style then continue end
		if mmohud.upgradeonly and not ply:HasUpgrade(v) then continue end

		surface.SetDrawColor(color_white)
		if (mmohud.countup and mmohud.max and ply:GetNW2Int(tostring(mmohud.count), 0) >= mmohud.max) or (mmohud.countdown and ply:GetNW2Int(tostring(mmohud.count), 0) == 0) or (mmohud.delay and ply:GetNW2Float(tostring(mmohud.delay), 0) > curtime) then
			surface.SetDrawColor(color_white_50)
		end

		surface.SetMaterial(data.icon_waw)
		surface.DrawTexturedRect(w - 235*scale - (40*traycount*scale), h - 220*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(zmhud_icon_frame)
			surface.DrawTexturedRect(w - 235*scale - (40*traycount*scale), h - 220*scale, 35*scale, 35*scale)
		end

		if mmohud.style == "toggle" then
		elseif mmohud.style == "count" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0), ChatFont, w - 200*scale - (40*traycount*scale), h - 180*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		elseif mmohud.style == "%" then
			local perkpercent = 100
			if mmohud.time then
				local perktime = ply:GetNW2Float(tostring(mmohud.delay), 0)
				local time = math.max(perktime - curtime, 0)
				perkpercent = math.Round(100 * (1 - math.Clamp(time / mmohud.max, 0, 1)))
			else
				perkpercent = 100 * (1 - math.Clamp(ply:GetNW2Int(tostring(mmohud.count), 0) / mmohud.max, 0, 1))
			end

			if (not mmohud.hide) or (mmohud.hide and perkpercent < 100) then
				draw.SimpleTextOutlined(perkpercent.."%", ChatFont, w - 200*scale - (40*traycount*scale), h - 180*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
			end
		elseif mmohud.style == "chance" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0).."/"..mmohud.max, ChatFont, w - 200*scale - (40*traycount*scale), h - 180*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end

		traycount = traycount + 1
	end
end

local function DeathHud()
	if not cl_drawhud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	local screen = ScreenScale(16)
	local pscale = ScreenScale(128)
	local screen2 = ScreenScale(24)

	local pos = ply:GetPos()
	local range = 160000
	local ang = 0.65
	local zeds = {}
	local nades = {}

	for i, ent in nzLevel.GetHudEntityArray() do
		if not IsValid(ent) then continue end
		if (ent.NZThrowIcon or ent.NZNadeRethrow) and (ent:GetCreationTime() + 0.3 < CurTime()) then
			local epos = ent:WorldSpaceCenter() + vector_up*10
			local data = epos:ToScreen()
			if data.visible then
				if ent.GetActivated and ent:GetActivated() then continue end
				//if ent.Range and isnumber(ent.Range) then range = (ent.Range*2)^2 end

				local dist = 1 - math.Clamp(pos:DistToSqr(ent:GetPos()) / range, 0, 1)

				surface.SetDrawColor(ColorAlpha(color_white, 300*dist))
				surface.SetMaterial(ent.NZThrowIcon or zmhud_icon_grenade)
				surface.DrawTexturedRect(data.x - screen*0.5, data.y - screen*0.5, screen, screen)
			else
				if ent.NZNadeRethrow and ply ~= ent:GetOwner() then continue end
				table_insert(nades, ent)
			end
		end
	end

	for _, ent in ipairs(nades) do
		local epos = ent:GetPos()

		local dist = 1 - math.Clamp(pos:DistToSqr(epos) / range, 0, 1)
		local dir = (epos - pos):Angle()
		dir = dir - EyeAngles()
		local angle = dir.y + 90

		local x = (math.cos(math.rad(angle)) * pscale) + ScrW() / 2
		local y = (math.sin(math.rad(angle)) * -pscale) + ScrH() / 2

		surface.SetDrawColor(ColorAlpha(color_white, 400*dist))

		surface.SetMaterial(ent.NZThrowIcon or zmhud_icon_grenade)
		surface.DrawTexturedRect(x - (screen*0.5), y - (screen*0.5), screen, screen)

		if nz_useplayercolor:GetBool() then
			local owner = ent:GetOwner()
			if IsValid(owner) and owner:IsPlayer() then
				local pcol = owner:GetPlayerColor()
				surface.SetDrawColor(Color(255*pcol.x, 255*pcol.y, 255*pcol.z, math.min(400*dist, 200)))
			end
		end

		surface.SetMaterial(zmhud_icon_offscreen)
		surface.DrawTexturedRectRotated(x, y, screen2, screen2, angle - 90)
	end

	if ply:HasPerk("death") then
		for i, ent in nzLevel.GetZombieArray() do
			if not IsValid(ent) then continue end
			if ent:IsValidZombie() and ent:Alive() then
				if pos:DistToSqr(ent:GetPos()) > range then continue end
				local dir = ply:EyeAngles():Forward()
				local facing = (pos - ent:GetPos()):GetNormalized()

				if (facing:Dot(dir) + 1) / 2 > ang then
					table_insert(zeds, ent)
				end
			end
		end

		for i, ent in nzLevel.GetZombieBossArray() do
			if not IsValid(ent) then continue end
			if ent:IsValidZombie() and ent:Alive() then
				local dir = ply:EyeAngles():Forward()
				local facing = (pos - ent:GetPos()):GetNormalized()

				if (facing:Dot(dir) + 1) / 2 > ang then
					table_insert(zeds, ent)
				end
			end
		end

		for _, ent in ipairs(zeds) do
			local epos = ent:GetPos()

			local dist = math.Clamp(pos:DistToSqr(epos) / range, 0, 1)
			local dir = (epos - pos):Angle()
			dir = dir - EyeAngles()
			local angle = dir.y + 90

			local mod = math.Remap(1 - dist, 0, 1, 0.5, 1)

			local x = (math.cos(math.rad(angle)) * pscale) + ScrW() / 2
			local y = (math.sin(math.rad(angle)) * -pscale) + ScrH() / 2

			surface.SetMaterial(zmhud_icon_death)
			surface.SetDrawColor(Color(255, 500*dist, 500*dist, 400*(1 - dist)))
			surface.DrawTexturedRect(x - (screen*mod)/2, y - (screen*mod)/2, screen*mod, screen*mod)
		end
	end
end

local function PowerupNotification(text)
	local ply = LocalPlayer()
	local hudtype = nzMapping.Settings.hudtype
	if not text then
		text = "Max Ammo!"
	end

	if classicmaxammo[hudtype] then //classic style maxammo
		local alpha = 0
		local decaytime = nil
		local smallfont = ("nz.small.bo1")

		//variables
		local lifetime = 2.4
		local duration = 2

		//more is faster, less is slower
		local faderatein = 0.5
		local faderateout = 0.2
		local riserate = 0.2
		local traveldist = 200 //in pixels

		local timername = "t5_PowerupDraw"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t5_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local white_fade = ColorAlpha(color_white, alpha)
			local black_fade = ColorAlpha(color_black_180, math.Clamp(alpha, 0, 180))
			local time = math.Clamp((decaytime - ctime) / duration, 0, 1)

			draw.SimpleTextOutlined(text, smallfont, w/2, h + ((750*scale) + (traveldist*(time*riserate)) * scale), white_fade, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, black_fade)
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t5_PowerupDraw")
		end)
	elseif tombammo[hudtype] then //origins hd
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "tomb_PowerupDraw"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "tomb_PowerupDraw", function()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			local ctime = CurTime()

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			//---------SPIKES---------\\
			surface.SetMaterial(tomb_powerup_maxammobg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.55))	
			surface.DrawTexturedRectRotated(w/2, 185*scale, 200*scale, 200*scale, ctime * 10 % 360)

			//---------BACKROUND---------\\	
			surface.SetMaterial(tomb_powerup_maxammofg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha))	
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.ammo.bo3.main", w/2, 280*scale, ColorAlpha(color_t7tomb, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7tomb_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "tomb_PowerupDraw")
		end)
	elseif t7maxammo[hudtype] then //black ops 3 style
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7_PowerupDraw"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7_PowerupDraw", function()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			local ctime = CurTime()

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			//---------SPIKES---------\\
			surface.SetMaterial(t7_powerup_maxammobg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.55))	
			surface.DrawTexturedRectRotated(w/2, 185*scale, 200*scale, 200*scale, ctime * 10 % 360)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7_powerup_maxammofg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha))	
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.ammo.bo3.main", w/2, 280*scale, ColorAlpha(color_t7, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7_PowerupDraw")
		end)
	elseif cthulhuammo[hudtype] then
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7zod_PowerupDraw"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7zod_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local powerupcol = ColorAlpha(color_white, alpha)

			//---------SPIKES---------\\
			surface.SetMaterial(t7zod_powerup_maxammobg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7zod_powerup_maxammofg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			surface.SetMaterial(t7zod_powerup_maxammotext) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.1))
			surface.DrawTexturedRect(w/2 - 114*scale, 220*scale, 228*scale, 60*scale)

			surface.SetMaterial(t7zod_powerup_maxammoctnr) 
			surface.SetDrawColor(ColorAlpha(color_t7zod_outline, alpha))	
			surface.DrawTexturedRect(w/2 - 144*scale, 220*scale, 288*scale, 48*scale)

			local notiffilm = surface.GetTextureID("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_glowfilm")
			surface.SetTexture(notiffilm)
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 290*scale, 10*scale, 624*scale, 360*scale)

			draw.SimpleTextOutlined(text, "nz.ammo.bo3zod.main", w/2, 280*scale, ColorAlpha(color_t7zod, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7zod_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7zod_PowerupDraw")
		end)
	else //black ops 4 style
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.5
		local faderateout = 0.3

		local timername = "t8_PowerupDraw"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t8_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local powerupcol = ColorAlpha(color_white, alpha)
			local powerupcol2 = ColorAlpha(color_white, alpha*0.15)

			//--------------------------------MAXAMMO--------------------------------\\
			//---------BACKROUND---------\\	
			surface.SetMaterial(t8_powerup_maxammobg) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 125, 60, 250, 250)
			//---------BACKROUND---------\\

			//---------CIRCLE---------\\
			surface.SetMaterial(t8_powerup_maxammocircle) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * 10 % 360)
			//---------CIRCLE---------\\

			//---------SPIKES---------\\
			surface.SetMaterial(t8_powerup_maxammospikes) 
			surface.SetDrawColor(powerupcol2)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -3 % 360)
			//---------SPIKES---------\\

			//---------STAR---------\\
			surface.SetMaterial(t8_powerup_maxammostar) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -10 % 360)
			//---------STAR---------\\

			//---------GLOW---------\\
			surface.SetMaterial(t8_powerup_maxammoglow) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 125, 60, 250, 250)
			//---------GLOW---------\\

			//---------SWISH---------\\
			surface.SetMaterial(t8_powerup_maxammoswish) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -500 % 360)
			//---------SWISH---------\\

			//---------TRAY---------\\
			surface.SetMaterial(t8_powerup_maxammotray) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 130, 210, 260, 30)
			//---------TRAY---------\\

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.pointsmain.blackops4", w/2, 230, ColorAlpha(color_yellow, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_black_180, 180*timescale))
			//---------TEXT---------\\
			//--------------------------------MAXAMMO--------------------------------\\	
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t8_PowerupDraw")
		end)
	end
end

net.Receive("nzPowerUps.PickupHud", function( length )
	local text = net.ReadString()
	local dosound = net.ReadBool()

	if dosound then
		if classicmaxammo[nzMapping.Settings.hudtype] then
			surface.PlaySound("nz_moo/powerups/maxammo_flux.mp3")
		else
			surface.PlaySound("nz_moo/powerups/maxammo_flux_alt.mp3")
		end
	end

	PowerupNotification(text)
end)

local fadeouttime = nil
local fadeout = 0
local totalWidth = 0

local function PowerUpsHud()
	if not cl_drawhud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	local spectating = false
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
		spectating = true
	end

	local ctime = CurTime()
	local scw, sch = ScrW(), ScrH()

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_white or nzMapping.Settings.textcolor
	local font = "nz.powerup"
	local scale = (scw/1920 + 1)/2
	local width = (scw / 2) 
	local powerupsActive = 0
	local c = 0

	local function ReturnPosition(id, seconds, subtractBy) -- When the powerup disappears we need to align everything back again
		if timer.Exists(id) then return end -- We already did this, we need to wait..
		timer.Create(id, seconds, 1, function()
			totalWidth = totalWidth - (70*scale)
		end)
	end

	local function AddPowerup(material, time) -- Display another powerup on the player's screen
		local width = scw / 2 + (70*scale) * powerupsActive - totalWidth / 2
			
		if width - scw / 2 > totalWidth then 
			prevWidth = totalWidth
			totalWidth = width - scw / 2 
		end

		local timeleft = time - ctime
		local warningthreshold = 10 --at what time does the icon start blinking?
		local frequency1 = 0.25 --how long in seconds it takes for the icon to toggle visibility
		local urgencythreshold = 5 --at what time does the blinking get faster/slower?
		local frequency2 = 0.1 --how long in seconds it takes for the icon to toggle visibility in urgency mode
		if timeleft > warningthreshold or (timeleft > urgencythreshold and timeleft % (frequency1 * 2) > frequency1) or (timeleft <= urgencythreshold and timeleft % (frequency2*2) > frequency2) then
			surface.SetMaterial(material)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(width - 32*scale, ScrH() - 155*scale, 64*scale, 64*scale)
			draw.SimpleTextOutlined(math.Round(timeleft), font, width, sch - 170*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		end
		powerupsActive = powerupsActive + 1
	end

	for k,v in pairs(nzPowerUps.ActivePowerUps) do	
		if nzPowerUps:IsPowerupActive(k) then
			if k == "dp" then
				AddPowerup(t8_powerup_2x, v)
				ReturnPosition("Returning" .. "dp", math.Round(v - ctime))	
			end

			if k == "insta" then
				AddPowerup(t8_powerup_killjoy, v)
				ReturnPosition("Returning" .. "insta", math.Round(v - ctime))	
			end

			if k == "firesale" then
				AddPowerup(t8_powerup_firesale, v)
				ReturnPosition("Returning" .. "firesale", math.Round(v - ctime))	
			end

			if k == "bonfiresale" then
				AddPowerup(t8_powerup_bonfiresale, v)
				ReturnPosition("Returning" .. "bonfiresale", math.Round(v - ctime))	
			end
			
			if k == "timewarp" then
				AddPowerup(t8_powerup_timewarp, v)
				ReturnPosition("Returning" .. "timewarp", math.Round(v - ctime))	
			end

			if k == "infinite" then
				AddPowerup(t8_powerup_infinite, v)
				ReturnPosition("Returning" .. "infinite", math.Round(v - ctime))	
			end

			local powerupData = nzPowerUps:Get(k)
			--draw.SimpleText(powerupData.name .. " - " .. math.Round(v - ctime), font, w, ScrH() * 0.85 + offset * c, Color(255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			c = c + 1
		end
	end

	if not nzPowerUps.ActivePlayerPowerUps[ply] then nzPowerUps.ActivePlayerPowerUps[ply] = {} end
	for k,v in pairs(nzPowerUps.ActivePlayerPowerUps[ply]) do
		if nzPowerUps:IsPlayerPowerupActive(ply, k) then
			if k == "zombieblood" then
				AddPowerup(t8_powerup_blood, v)
				ReturnPosition("Returning" .. "zombieblood", math.Round(v - ctime))	
			end

			if k == "deathmachine" then
				AddPowerup(t8_powerup_minigun, v)
				ReturnPosition("Returning" .. "deathmachine", math.Round(v - ctime))	
			end
			
			if k == "berzerk" then
				AddPowerup(t8_powerup_berzerk, v)
				ReturnPosition("Returning" .. "berzerk", math.Round(v - ctime))	
			end

			if k == "godmode" then
				AddPowerup(t8_powerup_godmode, v)
				ReturnPosition("Returning" .. "godmode", math.Round(v - ctime))	
			end
			
			if k == "quickfoot" then
				AddPowerup(t8_powerup_quick, v)
				ReturnPosition("Returning" .. "quickfoot", math.Round(v - ctime))	
			end

			local powerupData = nzPowerUps:Get(k)
			--draw.SimpleText(powerupData.name .. " - " .. math.Round(v - ctime), font, w, ScrH() * 0.85 + offset * c, Color(255, 255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			c = c + 1
		end
	end

	if spectating then return end
	if not ply.ambiences then ply.ambiences = {} end
	if not ply.refstrings then ply.refstrings = {} end
	if not ply.picons then ply.picons = {} end

	for powerup, data in pairs(nzPowerUps.Data) do
		local active = false

		if data.global then
			active = nzPowerUps:IsPowerupActive(powerup)
		else
			if nzPowerUps.ActivePlayerPowerUps[ply] then
				active = nzPowerUps:IsPlayerPowerupActive(ply, powerup)
			end
		end

		if data.loopsound then
			if active then
				if not ply.refstrings[powerup] then --Haven't cached yet
					ply.refstrings[powerup] = data.loopsound
					ply.ambiences[powerup] = CreateSound(ply, data.loopsound)
				elseif ply.refstrings[powerup] ~= data.loopsound then --Cached but the sound was changed, requires re-cache
					if ply.ambiences[powerup] then ply.ambiences[powerup]:Stop() end --stop the existing sound if it's still playing

					ply.refstrings[powerup] = data.loopsound
					ply.ambiences[powerup] = CreateSound(ply, data.loopsound)
				end

				if ply.ambiences[powerup] then
					ply.ambiences[powerup]:Play()
					if ply.picons[powerup] then
						local timer = ply.picons[powerup].time - CurTime()
						ply.ambiences[powerup]:ChangePitch(100 + (data.nopitchshift and 0 or math.max(0, (10-timer)*5)) + (data.addpitch or 0))
					end
				end
			elseif ply.ambiences[powerup] then
				if data.stopsound and ply.ambiences[powerup]:IsPlaying() then
					ply:EmitSound(data.stopsound, 95, 100)
				end

				ply.ambiences[powerup]:Stop()
			end
		end
	end
end

local function PerksHud()
	if not cl_drawhud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = (ScrW()/1920 + 1)/2
	end

	local perks = ply:GetPerks()
	local w = ScrW()/1920 + 220
	local h = ScrH()
	local size = 45

	local num = 0
	local row = 0
	local num_b = 0
	local row_b = 0

	if nz_showperkframe:GetBool() then
		if nzRound:InProgress() or (#perks > 0) then
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.SetDrawColor(color_white_100)
			for i=1, nz_perkmax:GetInt() do
				if not ply:HasUpgrade(perks[i]) then
					surface.DrawTexturedRect(w + num_b*(size + 6)*pscale, h - 75*pscale - 64*row_b, 50*pscale, 50*pscale)
				end

				num_b = num_b + 1
				if num_b%(nz_perkrowmod:GetInt()) == 0 then
					row_b = row_b + 1
					num_b = 0
				end
			end
		end
	end

	for _, perk in pairs(perks) do
		local icon = GetPerkIconMaterial(perk)
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w + num*(size + 6)*pscale, h - 75*pscale - 64*row, 50*pscale, 50*pscale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 6)*pscale, h - 75*pscale - 64*row, 50*pscale, 50*pscale)
		end

		if perk == "vulture" and ply:HasVultureStink() then
			surface.SetMaterial(zmhud_vulture_glow)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w + num*(size + 6)*pscale) - 24*pscale, (h - 75*pscale - 64*row) - 24*pscale, 98*pscale, 96*pscale)
			
			local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
			surface.SetTexture(stink)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w + num*(size + 6)*pscale), (h - 75*pscale - 64*row) - 62*pscale, 64*pscale, 64*pscale)
		end

		num = num + 1
		if num%(nz_perkrowmod:GetInt()) == 0 then
			row = row + 1
			num = 0
		end
	end
end

local function VultureVision()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	if not ply:HasPerk("vulture") then return end
	local scale = (ScrW()/1920 + 1)/2
	local icon = nzDisplay.vultureHUDicons["wunderfizz_machine"] //? if unknown

	for k, v in nzLevel.GetVultureArray() do
		if not IsValid(v) then continue end

		local data = v:WorldSpaceCenter():ToScreen()
		if not data.visible then continue end

		if ply:GetPos():DistToSqr(v:GetPos()) > 562500 then continue end //750^2

		local class = v:GetClass()

		if nzDisplay.vultureHUDicons[class] then
			icon = nzDisplay.vultureHUDicons[class]
		elseif class == "perk_machine" then
			local perk = v:GetPerkID()
			if perk == "pap" then
				icon = nzDisplay.vultureHUDicons["pap"]
			else
				icon = GetPerkIconMaterial(perk)
			end
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white_150)
		surface.DrawTexturedRect(data.x - 21*scale, data.y - 21*scale, 42*scale, 42*scale)
	end
end

--[[This is a modified Classic nZ Round Counter... If you want a Counter thats styled after the classic era of Zombies, use this one.
local round_white = 0
local round_alpha = 255
local round_num = 0
local infmat = Material("materials/nz_moo/round_tallies/chalk_infinity.png", "smooth")
local tallymats = {
	Material("nz_moo/round_tallies/bo1_tallies/chalkmarks_bo1_1.png", "unlitgeneric smooth"),
	Material("nz_moo/round_tallies/bo1_tallies/chalkmarks_bo1_2.png", "unlitgeneric smooth"),
	Material("nz_moo/round_tallies/bo1_tallies/chalkmarks_bo1_3.png", "unlitgeneric smooth"),
	Material("nz_moo/round_tallies/bo1_tallies/chalkmarks_bo1_4.png", "unlitgeneric smooth"),
	Material("nz_moo/round_tallies/bo1_tallies/chalkmarks_bo1_5.png", "unlitgeneric smooth")
}
local function RoundHud()

    local text = ""
    local font = ("nz.rounds."..GetFontType(nzMapping.Settings.roundfont))
    local w = 35
    local h = ScrH() - 15
    local round = round_num
    local col = Color(200 + round_white, round_white, round_white,round_alpha)
    surface.SetDrawColor(col.r,round_white,round_white,round_alpha)
    if round == -1 then
        	surface.SetMaterial(infmat)
        	--surface.SetDrawColor(col.r,round_white,round_white,round_alpha)
        	surface.DrawTexturedRect(w - 25, h - 100, 200, 100)
        return
    elseif round < 11 then
    	if round < 6 then -- Instead of using text for the tallies, We're now using the actual tally textures instead.
    		for i = 1, round do
        		--surface.SetDrawColor(col.r,round_white,round_white,round_alpha)
        		surface.SetMaterial(tallymats[round])
        		surface.DrawTexturedRect(w, h - 125, 125, 125)
    		end
    	end
        if round <= 10 and round > 5 then
        		--surface.SetDrawColor(col.r,round_white,round_white,round_alpha)
        		surface.SetMaterial(tallymats[5]) -- Always display five.
        		surface.DrawTexturedRect(w, h - 125, 125, 125)
    		for i = 1, round do
        		surface.SetMaterial(tallymats[round - 5])
        		surface.DrawTexturedRect(w + 120, h - 125, 125, 125)
    		end
        end
    else
        text = round
    	draw.SimpleText(text, font, w + 15, h - 5, col, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end
end

local roundchangeending = false
local prevroundspecial = false
local function StartChangeRound()

	print(nzRound:GetNumber(), nzRound:IsSpecial())
	
	local lastround = nzRound:GetNumber()

	if lastround >= 1 then
		if prevroundspecial then
			nzSounds:Play("SpecialRoundEnd")
		else
			nzSounds:Play("RoundEnd")
		end
	elseif lastround == -2 then
		surface.PlaySound("nz/round/round_-1_prepare.mp3")
	else
		round_num = 0
	end

	roundchangeending = false
	round_white = 0
	local round_charger = 0.25
	local alphafading = false
	local haschanged = false
	hook.Add("HUDPaint", "nz_roundnumWhiteFade", function()
		if not alphafading then
			round_white = math.Approach(round_white, round_charger > 0 and 255 or 0, round_charger*350*FrameTime())
			if round_white >= 255 and not roundchangeending then
				alphafading = true
				round_charger = -1
			elseif round_white <= 0 and roundchangeending then
				hook.Remove("HUDPaint", "nz_roundnumWhiteFade")
			end
		else
			round_alpha = math.Approach(round_alpha, round_charger > 0 and 255 or 0, round_charger*350*FrameTime())
			if round_alpha >= 255 then
				if haschanged then
					round_charger = -0.25
					alphafading = false
				else
					round_charger = -1
				end
			elseif round_alpha <= 0 then
				if roundchangeending then
					round_num = nzRound:GetNumber()
					round_charger = 0.5
					if round_num == -1 then
					elseif nzRound:IsSpecial() then
						nzSounds:Play("SpecialRoundStart")
						prevroundspecial = true
					else
						nzSounds:Play("RoundStart")
						prevroundspecial = false
					end
					haschanged = true
				else
					round_charger = 1
				end
			end
		end
	end)
end

local function EndChangeRound()
	roundchangeending = true
end]]

--[[ JEN WALTER'S ROUND COUNTER ]]--

local hudmats = {}

function Hudmat(mat)
	local asset = "materials/" .. mat
	if hudmats[mat] then return hudmats[mat] end
	if file_exists(asset, "GAME") then
		if !hudmats[mat] then
			hudmats[mat] = Material(asset, "unlitgeneric smooth")
		end
		return hudmats[mat]
	else
		return zmhud_icon_missing
	end
end

function cwimage(image, x, y, w, h, col, ang)
	surface.SetMaterial(Hudmat(image))
	surface.SetDrawColor(col or color_white)
	surface.DrawTexturedRectRotated(x, y, w, h, ang or 0)
end

local function AddStroke(number, entry, tally)
	local str = tally and string_rep("i", math.Clamp(tonumber(number), 1, 5)) or (isstring(number) and number or tonumber(number))
	table_insert(rounddata, entry, {
		image = str,
		state = CurTime() + 4,
		istally = tally,
		fade = false
	})
	table_insert(sparkdata, entry, {
		move = table_copy(strokes[str]),
		state = CurTime() + 1,
		istally = tally,
		offset = !tally and ((entry-1)*spacing) or 0
	})
end

local wiping = false

local function WipeRound()
	if !wiping then
		roundbusy = true
		wiping = true
		for k, v in pairs(rounddata) do
			v.state = CurTime() + 2
			v.fade = true
		end
		timer.Simple(1, function()
			table_insert(sparkdata, 999, {
				move = {[1] = {{12, 90}, {12 + (usingtally and tallysize or (spacing*table_count(rounddata))), 90}}},
				state = CurTime() + 1,
				overridesize = 2,
				istally = false,
				offset = 0
			})
		end)
		timer.Simple(1.99, function()
			rounddata = {}
			sparkdata = {}
			wiping = false
			roundbusy = false
		end)
	end
end

local function AddStrokeBulk(number)
	if !table_isempty(rounddata) then
		WipeRound()
	else
		usingtally = false
		number = tostring(number)
		for i = 1, string_len(tostring(number)) do
			local str = string_sub(number, i, i)
			if i == 1 then
				AddStroke(tonumber(str), i)
			else
				timer.Simple((i-1)/3, function() AddStroke(tonumber(str), i) end)
			end
		end
	end
end

local function RoundHud()
	if !nzRound then return end

	if cl_drawhud:GetBool() then
		local w, h = ScrW(), ScrH()
		local pscale = 1
		if nz_betterscaling:GetBool() then
			pscale = (w/1920 + 1)/2
		end

		if (!roundbusy or table_isempty(rounddata)) and !(nzRound:InState(ROUND_WAITING) or nzRound:InState(ROUND_PREP) or nzRound:InState(ROUND_CREATE)) then
			local R = nzRound and nzRound:GetNumber() or 0
			if R != oldnum then
				roundbusy = true
				if R < 6 then
					if !usingtally or table_count(rounddata) > R then
						WipeRound()
						usingtally = true
					else
						for i = 1, 5 do
							if R >= i and not rounddata[i] then
								AddStroke(i, i, true)
							end
						end
					end
				else
					AddStrokeBulk(R)
				end
			end
		elseif !table_isempty(rounddata) and (nzRound:InState(ROUND_WAITING) or nzRound:InState(ROUND_CREATE)) then
			WipeRound()
		end

		for k, v in pairs(rounddata) do
			local timer = v.state - CurTime()
			local T = v.istally
			local offset = ((k-1)*spacing)
			local hi = T and 175 or 160
			if timer > 3 then
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRectUV(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, (T and tallysize or digitsize.y) * (4-timer), 0, 0, 1, 4-timer)
			elseif timer > 2 then
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["heat"][v.image])
				surface.SetDrawColor(Color(255,255,99,255*(3-timer)))
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			elseif timer > 1 and !v.fade then
				surface.SetMaterial(roundassets["normal"][v.image])
				surface.SetDrawColor(Color(255,255,255,255*(2-timer)))
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(Color(255,255,255,1024*(timer-1)))
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["heat"][v.image])
				surface.SetDrawColor(Color(255,80 + (175*(timer-1)),99*(timer-1)))
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			elseif timer > 0 and !v.fade then
				surface.SetMaterial(roundassets["normal"][v.image])
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["heat"][v.image])
				surface.SetDrawColor(Color(255,80,0,255*timer))
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			elseif v.fade then
				local fade_colora = ColorAlpha(color_white, 255*timer)
				local fade_colorb = ColorAlpha(color_white, 255*(1-timer))

				if timer > 1 then
					surface.SetMaterial(roundassets["normal"][v.image])
					surface.SetDrawColor(fade_colora)
					surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
					surface.SetMaterial(roundassets["burnt"][v.image])
					surface.SetDrawColor(fade_colorb)
					surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				else
					surface.SetMaterial(roundassets["burnt"][v.image])
					surface.SetDrawColor(fade_colora)
					surface.DrawTexturedRectUV(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y, 0, 0, 1, 1 - math.sin(math.pi*(0.5 + timer/2)))
					--surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				end
			else
				surface.SetMaterial(roundassets["normal"][v.image])
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				if nzRound:InState(ROUND_PREP) then
					local prep_color = ColorAlpha(color_white, 127.5 + (127.5*math.sin(CurTime()*8)))

					surface.SetMaterial(roundassets["heat"][v.image])
					surface.SetDrawColor(prep_color)
					surface.DrawTexturedRect(10 + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				end
			end
		end

		local busysparks = false
		if !table_isempty(sparkdata) then
			for k, v in pairs(sparkdata) do
				if CurTime() < v.state then
					busysparks = true
					local T = v.istally
					local timer = 1 - (v.state - CurTime())
					local spark_color = ColorAlpha(color_white, 512*(1-timer))
					for a, b in pairs(v.move) do
						local movement = (table_count(b) * timer) + 0.6
						local mod1 = math.floor(movement)
						local mod2 = math.ceil(movement)
						local mod3 = mod1 == mod2 and 1 or (movement % 1)
						local X = 10 + (T and 0 or v.offset)
						local Y = v.offsetheight or (T and 175 or 160)
						local SIZE = v.overridesize or 1
						if b[mod1] and b[mod2] then
							local x1 = b[mod1][1] * (T and tallycoordmult or 1)
							local y1 = b[mod1][2] * (T and tallycoordmult or 1)
							local x2 = b[mod2][1] * (T and tallycoordmult or 1)
							local y2 = b[mod2][2] * (T and tallycoordmult or 1)
							cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", X + (x1*(1-mod3)) + (x2*mod3) + (33*SIZE), h - Y*pscale + (y1*(1-mod3)) + (y2*mod3) - (84*SIZE), 168 * SIZE, 252 * SIZE, spark_color)
						elseif b[mod1] then
							cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", X + (b[mod1][1] * (T and tallycoordmult or 1)) + (33*SIZE), h - Y*pscale + (b[mod1][2] * (T and tallycoordmult or 1)) - (84*SIZE), 168 * SIZE, 252 * SIZE, spark_color)
						end
					end
				end
			end
		end

		if !busysparks then sparkdata = {} end
	end
end

local prevroundspecial = false

local function StartChangeRound()
	local SND = "RoundEnd"
	if prev_round_special then
		SND = "SpecialRoundEnd"
	end
	nzSounds:Play(SND)
end

local function EndChangeRound()
	local SND = "RoundStart"
	roundbusy = false
	prev_round_special = false
	if nzRound:IsSpecial() then
		SND = "SpecialRoundStart"
		prev_round_special = true
	end
	if nzRound:GetNumber() == 1 then
		SND = "FirstRoundStart" -- Music for the first round.
	end
	nzSounds:Play(SND)
end

local function ResetRound()
end

--[[ JEN WALTER'S ROUND COUNTER ]]--

local function PlayerStaminaHUD()
	if not cl_drawhud:GetBool() then return end
	if not nz_showstamina:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not ply.GetStamina then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = scale
	end

	local stamina = ply:GetStamina()
	local maxstamina = ply:GetMaxStamina()
	local fade = maxstamina*0.15 //lower the number, faster the fade in
	local offset = 56*pscale

	local staminascale = math.Clamp(stamina / maxstamina, 0, 1)
	local stamalpha = 1 - math.Clamp((stamina - maxstamina + fade) / fade, 0, 1)
	local staminacolor = ColorAlpha(color_white, 255*stamalpha)

	if stamina < maxstamina then
		surface.SetDrawColor(staminacolor)
		surface.DrawRect(w/1920 + (75*pscale) + 4, h - (285*scale) + (offset), 110 * staminascale, 4)
	end
end

local function PlayerHealthHUD()
	if not cl_drawhud:GetBool() then return end
	if not nz_showhealth:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = scale
	end

	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()
	local offset = 48*pscale + 5 //player portrait dimensions + 5 for a bit of room

	local healthscale = math.Clamp(health / maxhealth, 0, 1)
	local healthcolor = Color(255, 300*healthscale, 300*healthscale, 255)

	surface.SetDrawColor(healthcolor)
	surface.DrawRect(w/1920 + (25*pscale), h - (275*scale) + offset, 164 * healthscale, 6)

	local armor = ply:Armor()
	if armor > 0 then //there is no 'max armor' value, the hardcoded limit is 255, citadel armor chargers max out at 200, and the max thru armor pickups is 100
		local maxarmor = (armor <= 100) and 100 or (armor <= 200) and 200 or 255
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/1920 + 25*pscale, h - 260 * scale + offset, 164, 12)

		surface.SetDrawColor(color_armor)
		surface.DrawRect(w/1920 + (25*pscale) + 4, h - 260 * scale + (offset + 3), 156 * armorscale, 6)
	end
end

local talksize = 64
local voicesize = 32
local namesize = 16

local name_cvarname = "nz_hud_player_names"
local name_enabled = CreateConVar(name_cvarname, 1, FCVAR_ARCHIVE, "Enable or Disable drawing player names above their head in 3d space. (1 Enabled, 0 Disabled), Default is 1.", 0, 1):GetBool()
cvars.AddChangeCallback(name_cvarname, function(name, old, new)
	name_enabled = tonumber(new) == 1
end)

local namedist_cvarname = "nz_hud_player_name_distance"
local max_namedist = CreateConVar(namedist_cvarname, 400, FCVAR_ARCHIVE, "Distance to draw player names from. Default is 400.", 0, 2048):GetInt()^2
cvars.AddChangeCallback(namedist_cvarname, function(name, old, new)
	max_namedist = tonumber(new)^2
end)

local namefull_cvarname = "nz_hud_player_name_showfull"
local namefull_enabled = CreateConVar(namefull_cvarname, 0, FCVAR_ARCHIVE, "Enable or Disable displaying full player names above their head instead of the first 16 characters. (1 is Enabled, 0 is Disabled),  Default is 0.", 0, 1):GetBool()
cvars.AddChangeCallback(namefull_cvarname, function(name, old, new)
	namefull_enabled = tonumber(new) == 1
end)

local function PlayerInfoHUD(bdepth, bskybox) //credit to Player Status Icons by Haaax
	if not cl_drawhud:GetBool() then return end
	if bskybox then return end

	local localply = LocalPlayer()

	local render_ang = EyeAngles()
	render_ang:RotateAroundAxis(render_ang:Right(), 90)
	render_ang:RotateAroundAxis(-render_ang:Up(), 90)

	local fontsmall = "nz.points."..GetFontType(nzMapping.Settings.smallfont)
	local namefade = max_namedist*0.8

	local plytab = player.GetAll()
	for i, ply in ipairs(plytab) do
		if not IsValid(ply) or ply:IsDormant() or not ply:Alive() then continue end
		local index = ply:EntIndex()
		if index == localply:EntIndex() and not localply:ShouldDrawLocalPlayer() then continue end

		local id = ply:LookupAttachment("anim_attachment_head") or 0
		local att = ply:GetAttachment(id)

		local pos = (att and att.Pos) and att.Pos or ply:WorldSpaceCenter() + ply:GetUp()*26
		local distfac = pos:DistToSqr(EyePos())
		local ratio = 1 - math.Clamp((distfac - max_namedist + namefade) / namefade, 0, 1)
		if ratio <= 0 then continue end

		if ply:IsTyping() then
			local talk_pos = pos + vector_up*24

			cam.Start3D2D(talk_pos, render_ang, 0.24)
				cam.IgnoreZ(true)
				surface.SetMaterial(zmhud_icon_talk)
				surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
				surface.DrawTexturedRect(-talksize/2, -talksize/2, talksize, talksize)
				cam.IgnoreZ(false)
			cam.End3D2D()
		end

		if name_enabled then
			local name_pos = pos + vector_up*14

			local nick = ply:Nick()
			if not namefull_enabled and #nick > namesize then
				nick = string.sub(nick, 1, namesize).."..."
			end

			local pcolor = player.GetColorByIndex(index)
			if nz_useplayercolor:GetBool() then
				local pvcol = ply:GetPlayerColor()
				pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
			end

			cam.Start3D2D(name_pos, render_ang, 0.24)
				cam.IgnoreZ(true)

				if ply:IsSpeaking() then //voicechat icon
					local icon = zmhud_icon_voicedim
					if ply:VoiceVolume() > 0 then
						icon = zmhud_icon_voiceon
					end
					if ply:IsMuted() then
						icon = zmhud_icon_voiceoff
					end

					surface.SetFont(fontsmall)
					local tw, th = surface.GetTextSize(nick)

					surface.SetMaterial(icon)
					surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
					surface.DrawTexturedRect(-tw/2 - voicesize, -voicesize/2, voicesize, voicesize)
				elseif ply:GetNW2Bool("ThirtOTS", false) and ply ~= localply then //thirdperson icon
					local icon = zmhud_icon_camera

					surface.SetFont(fontsmall)
					local tw, th = surface.GetTextSize(nick)

					surface.SetMaterial(icon)
					surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
					surface.DrawTexturedRect(-tw/2 - voicesize, -voicesize/2, voicesize, voicesize)
				end

				draw.SimpleTextOutlined(nick, fontsmall, 0, 0, ColorAlpha(pcolor, 255*ratio), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, ColorAlpha(color_black, 180*ratio))
				cam.IgnoreZ(false)
			cam.End3D2D()
		end
	end
end

local function PlayerVoiceHUD()
	if not cl_drawhud:GetBool() then return end
	if nz_shownames:GetBool() then return end

	local pply = LocalPlayer()
	local fontsmall = "nz.points."..GetFontType(nzMapping.Settings.smallfont)
	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local count = 0

	for _, ply in ipairs(player.GetAll()) do
		if not ply:IsSpeaking() then continue end

		local istheplayer = pply:EntIndex() == ply:EntIndex()

		local pcolor = player.GetColorByIndex(ply:EntIndex())
		if nz_useplayercolor:GetBool() then
			local pvcol = ply:GetPlayerColor()
			pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		end

		local nick = ply:Nick()
		if not namefull_enabled and #nick > 24 then
			nick = string.sub(nick, 1, 24)..".." //limit name to 24 chars
		end

		local icon = zmhud_icon_voicedim
		if ply:VoiceVolume() > 0 then
			icon = zmhud_icon_voiceon
		end
		if not istheplayer and ply:IsMuted() then
			icon = zmhud_icon_voiceoff
		end
		if istheplayer and not voiceloopback:GetBool() then
			icon = zmhud_icon_voiceon
		end

		surface.SetFont(fontsmall)
		local tw, th = surface.GetTextSize(nick)

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - 140*scale, (90*scale) + (th+6)*count - 21, 42, 42)

		draw.SimpleText(nick, fontsmall, w - 140*scale, (90*scale) + (th+6)*count, pcolor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		count = count + 1
	end
end

local bloodfade = 1
net.Receive("nzBloodSpatter", function()
	if not nz_meleeblood:GetBool() then return end

	local dmg = net.ReadUInt(8) / 255
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	ply.lastbloodspatter = CurTime() + (1 + 2*dmg)
	bloodfade = (1 + 2*dmg)*0.5
end)

local function BloodSpatterHUD()
	if not cl_drawhud:GetBool() then return end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply.lastbloodspatter and ply.lastbloodspatter > CurTime() then
		local ratio = 1 - math.Clamp((CurTime() - ply.lastbloodspatter + bloodfade) / bloodfade, 0, 1)
		local w, h = ScrW(), ScrH()

		surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
		surface.SetMaterial(zmhud_vfx_blood)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, 1, 1)
	end
end

-- Hooks
hook.Add("HUDPaint", "playersvoiceHUD", PlayerVoiceHUD )
hook.Add("PostDrawTranslucentRenderables", "nzplayerinfoHUD", PlayerInfoHUD )
hook.Add("HUDPaint", "bloodspatterHUD", BloodSpatterHUD )

hook.Add("HUDPaint", "nzHUDswapping_default", function()
	if not nzDisplay.reworkedHUDs[nzMapping.Settings.hudtype] then
		--hook.Add("HUDPaint", "musicHUD", MusicHUD )
		hook.Add("HUDPaint", "roundHUD", StatesHud )
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud )
		hook.Add("HUDPaint", "powerupHUD", PowerUpsHud )
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud )
		hook.Add("HUDPaint", "perksHUD", PerksHud )
		hook.Add("HUDPaint", "vultureVision", VultureVision )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud )
		hook.Add("HUDPaint", "deathiconsHUD", DeathHud )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD )

		hook.Add("OnRoundPreparation", "BeginRoundHUDChange", StartChangeRound)
		hook.Add("OnRoundStart", "EndRoundHUDChange", EndChangeRound)
		hook.Add("OnRoundEnd", "GameEndHUDChange", ResetRound)
	end
end)

local blockedweps = {
	["nz_revive_morphine"] = true,
	["nz_packapunch_arms"] = true,
	["nz_perk_bottle"] = true,
}

function GM:HUDWeaponPickedUp( wep )
	local ply = LocalPlayer()
	if ( !IsValid( ply ) || !ply:Alive() ) then return end
	if ( !IsValid( wep ) ) then return end
	if ( !isfunction( wep.GetPrintName ) ) then return end
	if blockedweps[wep:GetClass()] then return end

	wep.NZPickedUpTime = CurTime()
	/*local pickup = {}
	pickup.time			= CurTime()
	pickup.name			= wep:GetPrintName()
	pickup.holdtime		= 5
	pickup.font			= "DermaDefaultBold"
	pickup.fadein		= 0.04
	pickup.fadeout		= 0.3
	pickup.color		= Color( 255, 200, 50, 255 )

	surface.SetFont( pickup.font )
	local w, h = surface.GetTextSize( pickup.name )
	pickup.height		= h
	pickup.width		= w

	if ( self.PickupHistoryLast >= pickup.time ) then
		pickup.time = self.PickupHistoryLast + 0.05
	end

	table_insert( self.PickupHistory, pickup )
	self.PickupHistoryLast = pickup.time*/

	if wep.NearWallEnabled then wep.NearWallEnabled = false end
	if wep:IsFAS2() then wep.NoNearWall = true end
	return false
end

local function ParseAmmoName(str)
	local pattern = "nz_weapon_ammo_(%d)"
	local slot = tonumber(string_match(str, pattern))
	if slot then
		for k,v in pairs(LocalPlayer():GetWeapons()) do
			if v:GetNWInt("SwitchSlot", -1) == slot then
				if v.Primary and v.Primary.OldAmmo then
					return "#"..v.Primary.OldAmmo.."_ammo"
				end
				local wep = weapons.Get(v:GetClass())
				if wep and wep.Primary and wep.Primary.Ammo then
					return "#"..wep.Primary.Ammo.."_ammo"
				end
				return v:GetPrintName() .. " Ammo"
			end
		end
	end
	return str
end

function GM:HUDAmmoPickedUp( itemname, amount )
	return false
	/*if ( !IsValid( LocalPlayer() ) || !LocalPlayer():Alive() ) then return end
	
	itemname = ParseAmmoName(itemname)
	
	-- Try to tack it onto an exisiting ammo pickup
	if ( self.PickupHistory ) then
		for k, v in pairs( self.PickupHistory ) do
			if ( v.name == itemname ) then
				v.amount = tostring( tonumber( v.amount ) + amount )
				v.time = CurTime() - v.fadein
				return
			end
		end
	end
	
	local pickup = {}
	pickup.time			= CurTime()
	pickup.name			= itemname
	pickup.holdtime		= 5
	pickup.font			= "DermaDefaultBold"
	pickup.fadein		= 0.04
	pickup.fadeout		= 0.3
	pickup.color		= Color( 180, 200, 255, 255 )
	pickup.amount		= tostring( amount )
	
	surface.SetFont( pickup.font )
	local w, h = surface.GetTextSize( pickup.name )
	pickup.height	= h
	pickup.width	= w
	
	local w, h = surface.GetTextSize( pickup.amount )
	pickup.xwidth	= w
	pickup.width	= pickup.width + w + 16

	if ( self.PickupHistoryLast >= pickup.time ) then
		pickup.time = self.PickupHistoryLast + 0.05
	end
	
	table.insert( self.PickupHistory, pickup )
	self.PickupHistoryLast = pickup.time*/
end

//------------------------------------------------GHOSTLYMOO'S HUD------------------------------------------------\\
/*Connection terminated.

I'm sorry to interrupt you, Elizabeth- if you still even remember that name.
You are not hеre to receivе a gift, nor have you been called here by the individual you assume.
Although, you have indeed been called.
You have all been called here, into a labyrinth of sounds and smells, misdirection, and misfortune.
A labyrinth with no exit.
A maze with no prize.

You don't even realize that you are trapped.
Your lust for blood has driven you in endless circles, chasing the cries of children in some unseen chamber, always seeming so near, and somehow out of reach.

But you will never find them.
None of you will.
This is where your story ends.

And to you, my brave volunteer, who somehow found this job listing not intended for you,
Although there was a way out planned for you, I have a feeling that's not what you want.

I have a feeling that you are right where you want to be.

I am remaining as well.
I am nearby.
This place will not be remembered and the memory of everything that started this can finally begin to fade away.

As every tragedy should.

And to you monsters trapped in the corridors, be still, and give up your spirits.
They don't belong to you.

For most of you, I believe there is peace, and perhaps more waiting for you after the smoke clears.
Although, for one of you, the darkest pit of Hell has opened up to swallow you whole,
So don't keep the devil waiting, old friend.
My daughter, if you can hear me, I knew you would return as well.
It's in your nature to protect the innocent.
I'm sorry that on that day, the day you were shut out and left to die, no one was there to lift you up into their arms the way you lifted others into yours.

And then what became of you.
I should've known you wouldn't be content to disappear.
It's time to rest, for you and for those you have carried in your arms.
This ends for all of us.

End communication.*/