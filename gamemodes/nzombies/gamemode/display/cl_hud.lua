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
	CreateClientConVar("nz_hud_show_health", 1, true, false, "Enable or disable the Health Bar. (0 false, 1 true, 2 show numbers), Default is 1.", 0, 2)
end

if GetConVar("nz_hud_show_health_mp") == nil then
	CreateClientConVar("nz_hud_show_health_mp", 0, true, false, "Enable or disable the Health Bar under other players Portraits. (0 false, 1 true, 2 show numbers), Default is 0.", 0, 2)
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
	CreateClientConVar("nz_hud_show_perk_frames", 1, true, false, "Enable or disable displaying perk frames to represent max perk count. (0 false, 1 true, 2 disable modifier highlight), Default is 1.", 0, 2)
end

if GetConVar("nz_hud_show_alive_counter") == nil then
	CreateClientConVar("nz_hud_show_alive_counter", 0, true, false, "Enable or disable displaying a currently alive zombie counter. (0 false, 1 true), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_show_powerup_time") == nil then
	CreateClientConVar("nz_hud_show_powerup_time", 1, true, false, "Enable or disable displaying how much time is remaining for active powerups. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_show_player_portrait") == nil then
	CreateClientConVar("nz_hud_show_player_portrait", 1, true, false, "Enable or disable displaying the players portrait next to their score. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_show_game_start_text") == nil then
	CreateClientConVar("nz_hud_show_game_start_text", 1, true, false, "Enable or disable showing the text that appears on game begin, usually 'Round'. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_show_clan_tags") == nil then
	CreateClientConVar("nz_hud_show_clan_tags", 1, true, true, "Enable or disable showing clan tags. (0 Disabled, 1 Friends Only, 2 All Players), Default is 1.", 0, 2)
end

if GetConVar("nz_hud_show_clan_icons") == nil then
	CreateClientConVar("nz_hud_show_clan_icons", 1, true, true, "Enable or disable showing clan icons. (0 Disabled, 1 Friends Only, 2 All Players), Default is 1.", 0, 2)
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

if GetConVar("nz_hud_health_style") == nil then
	CreateClientConVar("nz_hud_health_style", 0, true, false, "Changes placement of the healthbar on certain HUDs. (0 Disabled, 1 Enabled), Default is 0.", 0, 1)
end

if GetConVar("nz_hud_powerup_style") == nil then
	CreateClientConVar("nz_hud_powerup_style", 1, true, false, "Changes style of Power-Up tray. (0 Static, 1 Animated, 2 Animated (No Fade)), Default is 1.", 0, 2)
end

if GetConVar("nz_hud_bleedout_style") == nil then
	CreateClientConVar("nz_hud_bleedout_style", 1, true, false, "Changes the look of the perk bleedout meter. (0 Deck, 1 Line, 2 Circle), Default is 1.", 0, 2)
end

if GetConVar("nz_bloodmeleeoverlay") == nil then
	CreateClientConVar("nz_bloodmeleeoverlay", 1, true, true, "Enable or disable drawing the blood splatter effect on the screen when damaging zombies with a melee weapon. (0 false, 1 true), Default is 1.", 0, 1)
end

if GetConVar("nz_hud_use_powerup_blacklist") == nil then
	CreateClientConVar("nz_hud_use_powerup_blacklist", 0, true, false, "Enable or disable blacklisting certain Power-Ups from showing on the players Power-Ups tray, Default is 0.", 0, 1)
end

if GetConVar("nz_hud_powerup_blacklist") == nil then
	CreateClientConVar("nz_hud_powerup_blacklist", "nuke;carpenter", true, false, "What Power-Ups to not show on the HUD, uses internal name and is seperated by an ';'. Default is 'nuke;carpenter'")
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
local nz_meleeblood = GetConVar("nz_bloodmeleeoverlay")

local nz_showhealth = GetConVar("nz_hud_show_health")
local nz_showhealthmp = GetConVar("nz_hud_show_health_mp")
local nz_showstamina = GetConVar("nz_hud_show_stamina")
local nz_shownames = GetConVar("nz_hud_show_names")
local nz_showmmostats = GetConVar("nz_hud_show_perkstats")
local nz_showgun = GetConVar("nz_hud_show_wepicon")
local nz_showperkframe = GetConVar("nz_hud_show_perk_frames")
local nz_showzcounter = GetConVar("nz_hud_show_alive_counter")
local nz_showpoweruptimer = GetConVar("nz_hud_show_powerup_time")
local nz_showportrait = GetConVar("nz_hud_show_player_portrait")
local nz_showgamebegintext = GetConVar("nz_hud_show_game_start_text")
local nz_showclanicons = GetConVar("nz_hud_show_clan_icons")

local nz_indicators = GetConVar("nz_hud_player_indicators")
local nz_indicatorangle = GetConVar("nz_hud_player_indicator_angle")
local nz_betterscaling = GetConVar("nz_hud_better_scaling")
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")
local nz_powerupstyle = GetConVar("nz_hud_powerup_style")
local nz_usepowerupblacklist = GetConVar("nz_hud_use_powerup_blacklist")
local nz_powerupblacklist = GetConVar("nz_hud_powerup_blacklist")

local nz_aatstyle = GetConVar("nz_hud_aat_style")
local nz_aatcolor = GetConVar("nz_hud_aat_textcolor")
local nz_perkrowmod = GetConVar("nz_hud_perk_row_modulo")
local nz_mapfont = GetConVar("nz_hud_use_mapfont")
local nz_bleedoutstyle = GetConVar("nz_hud_bleedout_style")
local nz_bleedouttime = GetConVar("nz_downtime")

local function GetPerkColor(perk)
	local perkData = nzPerks:Get(perk)
	return perkData and perkData.color or color_white
end

local color_white_50 = Color(255, 255, 255, 50)
local color_white_100 = Color(255, 255, 255, 100)
local color_white_150 = Color(255, 255, 255, 150)
local color_white_200 = Color(255, 255, 255, 200)
local color_black_100 = Color(0, 0, 0, 100)
local color_black_180 = Color(0, 0, 0, 180)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_255 = Color(255, 0, 0, 255)

local color_grey_100 = Color(100,100,100,255)
local color_grey = Color(200, 200, 200, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(135, 160, 255)
local color_health = Color(255, 120, 120, 255)
local color_yellow = Color(255, 178, 0, 255)

local color_blood = Color(60, 0, 0, 255)
local color_blood_score = Color(120, 0, 0, 255)

local color_points1 = Color(255, 200, 0, 255)
local color_points2 = Color(100, 255, 70, 255)
local color_points4 = Color(255, 0, 0, 255)

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

sound.Add({
	name = "nz.typewriter",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 75,
	pitch = {97, 103},
	sound = {"nz_moo/effects/typewriter/type_00.wav", "nz_moo/effects/typewriter/type_01.wav", "nz_moo/effects/typewriter/type_02.wav", "nz_moo/effects/typewriter/type_03.wav", "nz_moo/effects/typewriter/type_04.wav", "nz_moo/effects/typewriter/type_05.wav"}
})

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

//------Pre-Loading MISC HUD Elements------\\
local zmhud_vfx_blood = Material("nz_moo/huds/oilrig/vfx_blood_screen_splatter.png", "unlitgeneric smooth")
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_icon_holygrenade = Material("nz_moo/hud_holygrenade.png", "unlitgeneric smooth")
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
local zmhud_icon_headshot = Material("nz_moo/icons/hud_headshoticon.png", "smooth unlitgeneric")
local zmhud_icon_zedcounter = Material("nz_moo/icons/ugx_talkballoon.png", "unlitgeneric smooth")
local zmhud_icon_connection = Material("nz_moo/icons/hud_status_connecting.png", "unlitgeneric smooth")
local zmhud_icon_localhost = Material("nz_moo/icons/ui_host.png", "unlitgeneric smooth")
local zmhud_icon_useable = Material("nz_moo/icons/hint_usable.png", "unlitgeneric smooth")

zmhud_player_teleporting = Material("effects/tp_eyefx/tpeye.vmt")
zmhud_player_stink = Material("nz_moo/overlay/i_vulture_hud_glow_stink.png", "smooth unlitgeneric")
zmhud_player_onfire = CreateMaterial("nz_overlay_onfire", "UnlitGeneric", {
	["$basetexture"] = "nz_moo/overlay/fullscreen_fire.vtf",
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$additive"] = 1,
	["Proxies"] = {
		["AnimatedOffsetTexture"] = {
			["animatedtexturevar"] = "$basetexture",
			["animatedtextureframenumvar"] = "$frame",
			["animatedtextureframerate"] = 30
		}
	}
})
zmhud_player_shocked = CreateMaterial("nz_overlay_shocked", "UnlitGeneric", {
	["$basetexture"] = "nz_moo/overlay/img_fullscreen_electric_shock.vtf",
	["$vertexcolor"] = 1,
	["$vertexalpha"] = 1,
	["$additive"] = 1,
	["Proxies"] = {
		["AnimatedOffsetTexture"] = {
			["animatedtexturevar"] = "$basetexture",
			["animatedtextureframenumvar"] = "$frame",
			["animatedtextureframerate"] = 10
		}
	}
})

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

local PointsNotifications = {}
local function PointsNotification(ply, amount, profit_id)
	if not IsValid(ply) then return end
	local data = {ply = ply, amount = amount, diry = math.random(-25, 25), time = CurTime(), profit = profit_id}
	table_insert(PointsNotifications, data)
end

net.Receive("nz_points_notification", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	local profit_id = net.ReadInt(9)
	PointsNotification(ply, amount, profit_id)
end)

//Equipment
local function InventoryHUD()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawInventoryHUD() then return end
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

		if wep.Secondary and wep.Secondary.ClipSize > 0 then
			local clip2 = wep:Clip2()
			local clip2rate = wep.Secondary.AmmoConsumption
			local clip2i = math.floor(clip2/clip2rate)

			if clip2 > 0 then
				draw.SimpleTextOutlined(clip2i, ammo2font, w - 18*scale, h - 424*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_180)
			end
		end

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
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

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
	if nz_showportrait:GetBool() then
		local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")
		if not pmpath or pmpath:IsError() then
			pmpath = zmhud_icon_missing
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(wf + 25*pscale, h - 275 * scale - offset, 48*pscale, 48*pscale)

		surface.SetDrawColor(color)
		surface.DrawOutlinedRect(wf + 25*pscale, h - 275 * scale - offset, 50*pscale, 50*pscale, 3*pscale)
	end

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
			pcolor = v:GetPlayerColor():ToColor()
		end

		offset = offset + 55*pscale

		if nz_showhealthmp:GetBool() then
			offset = offset + 10*pscale //health bar offset buffer
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
		surface.DrawTexturedRectRotated(wf + 120*pscale, h - 253 * scale - offset, 200*pscale, 45*pscale, 180)

		draw.SimpleTextOutlined(v:GetPoints(), fontsmall, wf + 75*pscale, h - 253 * scale - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black)
		v.PointsSpawnPosition = {x = wf + 190*pscale, y = h - 253 * scale - offset}

		//icon
		if nz_showportrait:GetBool() then
			local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")

			surface.SetDrawColor(color_white)
			surface.SetMaterial(pmpath)
			surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)

			if v.GetTeleporterEntity and IsValid(v:GetTeleporterEntity()) then
				surface.SetMaterial(zmhud_player_teleporting)
				surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)
			end

			if v.IsOnFire and v:IsOnFire() or v:GetNW2Float("nzLastBurn", 0) + 1.5 > CurTime() then
				surface.SetMaterial(zmhud_player_onfire)
				surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)
			end

			if v:GetNW2Float("nzLastShock", 0) + 1.5 > CurTime() then
				surface.SetMaterial(zmhud_player_shocked)
				surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)
			end

			if v:HasPerk("pop") then
				local delay = v:GetNW2Float("nz.EPopDecay", 0)
				if delay > CurTime() then
					local effect = v:GetNW2Int("nz.EPopEffect", 1)
					local fadefac = 0

					if delay > CurTime() then
						fadefac = delay - CurTime()
						fadefac = math.Clamp(fadefac / 1, 0, 1)
					end

					if fadefac > 0 then
						surface.SetMaterial(nzPerks.EPoPIcons[effect])
						surface.SetDrawColor(ColorAlpha(color_white, 255*fadefac))
						surface.DrawTexturedRect(wf + 25*pscale + (16*pscale), h - 275*scale + (16*pscale) - offset, 24*pscale, 48*pscale)
					end
				end
			end

			if v.HasVultureStink and v:HasVultureStink() then
				surface.SetMaterial(zmhud_player_stink)
				surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)

				surface.SetMaterial(Material("color"))
				surface.SetDrawColor(160, 255, 0, math.max(24 * math.abs(math.sin(CurTime())), 14))
				surface.DrawTexturedRect(wf + 25*pscale, h - 275*scale - offset, 40*pscale, 40*pscale)
			end

			surface.SetDrawColor(pcolor)
			surface.DrawOutlinedRect(wf + 25*pscale, h - 275*scale - offset, 43*pscale, 43*pscale, 3*pscale)
		end

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
			local phealthscale = math.Clamp(phealth / pmaxhealth, 0, 1)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect(wf + 25*pscale, h - 230*pscale - offset, 136*pscale, 8*pscale)

			surface.SetDrawColor(color_white)
			surface.DrawRect(wf + 27*pscale, h - 228*pscale - offset, 132*pscale, 4*pscale)

			surface.SetDrawColor(color_health)
			surface.DrawRect(wf + 27*pscale, h - 228*pscale - offset, 132*phealthscale*pscale, 4*pscale)

			local armor = v:Armor()
			if armor > 0 then
				local maxarmor = v:GetMaxArmor()
				local armorscale = math.Clamp(armor / maxarmor, 0, 1)

				surface.SetDrawColor(color_black_180)
				surface.DrawRect(wf + 25*pscale, h - 222*pscale - offset, 136*pscale, 8*pscale)

				surface.SetDrawColor(color_white)
				surface.DrawRect(wf + 27*pscale, h - 220*pscale - offset, 132*pscale, 4*pscale)

				surface.SetDrawColor(color_armor)
				surface.DrawRect(wf + 27*pscale, h - 220*pscale - offset, 132*armorscale*pscale, 4*pscale)
			end
		end
	end

	if nz_clientpoints:GetBool() or sv_clientpoints:GetBool() then
		for k, v in ipairs(plytab) do
			if not v.LastPoints then v.LastPoints = v:GetPoints() end

			if v:GetPoints() ~= v.LastPoints then
				PointsNotification(v, v:GetPoints() - v.LastPoints, 0)
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
			if v.profit and v.profit > 0 then
				local pvcol = Entity(v.profit):GetPlayerColor()
				pvcol = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)

				draw.SimpleText("+"..v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, pvcol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				if v.amount >= 100 then --If you're earning 100 points or more, the notif will be green!
					draw.SimpleText("+"..v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
				if v.amount < 100 then --If you're earning less than 100 points, the notif will be gold!
					draw.SimpleText("+"..v.amount, fontnade, v.ply.PointsSpawnPosition.x + 35*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
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
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawGunHUD() then return end
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

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon then
			fontColor = Color(0, 255, 255, 255)
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, smallfont, w - 200*scale, h - 130*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", ammofont, w - 220*scale, h - 112*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, color_black)
		elseif (illegalspecials[wep.NZSpecialCategory] and not wep.NZSpecialShowHUD) then
			local name = wep:GetPrintName()
			draw.SimpleTextOutlined(name, smallfont, w - 200*scale, h - 130*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
		else
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
				surface.SetMaterial(GetPerkIconMaterial("mulekick", true))
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
	if not nz_showmmostats:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPerksHUD() then return end
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

		surface.SetMaterial(GetPerkIconMaterial(v, true))
		surface.DrawTexturedRect(w - 235*scale - (40*traycount*scale), h - 220*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial(true))
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
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

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
			local epos = ent:WorldSpaceCenter() + vector_up*12
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
				local pcol = owner:GetPlayerColor():ToColor()
				surface.SetDrawColor(ColorAlpha(pcol, math.min(400*dist, 200)))
			end
		end

		surface.SetMaterial(zmhud_icon_offscreen)
		surface.DrawTexturedRectRotated(x, y, screen2, screen2, angle - 90)
	end

	if ply:HasPerk("death") then
		for i, ent in nzLevel.GetZombieArray() do
			if not IsValid(ent) then continue end
			if ent:IsValidZombie() and ent:IsAlive() then
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
			if ent:IsValidZombie() and ent:IsAlive() then
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

local powerup_data = {}
local antipowerup_data = {}

local function PowerUpsHud()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPowerupsHUD() then return end
	if ply:IsNZMenuOpen() then return end

	local spectating = false
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
		spectating = true
	end

	local ctime = CurTime()
	local scw, sch = ScrW(), ScrH()

	local fontbyhud = nzDisplay.fonttypebyHUDs[nzMapping.Settings.hudtype]

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_white or nzMapping.Settings.textcolor
	local font = fontbyhud and "nz.points."..fontbyhud or "nz.powerup"
	if nz_mapfont:GetBool() then
		font = "nz.points."..GetFontType(nzMapping.Settings.mediumfont)
	end

	local b_useblacklist = nz_usepowerupblacklist:GetBool()
	local tPowerupBlacklist = {}
	if b_useblacklist then
		local t_powerupblacklist = string.Split(nz_powerupblacklist:GetString(), ";")
		for _, name in ipairs(t_powerupblacklist) do
			tPowerupBlacklist[name] = true
		end
	end

	local scale = (scw/1920 + 1)/2
	local height = sch - 170*scale
	local size = 72*scale

	local powerupsActive = 0
	local powerupsTotal = 0

	local tActivePowerUps = nzPowerUps.ActivePowerUps
	for k, v in pairs(tActivePowerUps) do
		if tPowerupBlacklist[k] then continue end

		if (v - CurTime()) < engine.TickInterval() then continue end
		powerupsTotal = powerupsTotal + 1
	end

	local tActiveAntiPowerUps = nzPowerUps.ActiveAntiPowerUps
	for k, v in pairs(tActiveAntiPowerUps) do
		powerupsTotal = powerupsTotal + 1
	end

	local tPlayerPowerUps = ply:AllActivePowerUps()
	for k, v in pairs(tPlayerPowerUps) do
		if tPowerupBlacklist[k] then continue end

		powerupsTotal = powerupsTotal + 1
	end

	local tPlayerAntiPowerUps = ply:AllActiveAntiPowerUps()
	for k, v in pairs(tPlayerAntiPowerUps) do
		powerupsTotal = powerupsTotal + 1
	end

	local function AddPowerup(powerup, icon, time, anti, noflash) -- Display another powerup on the player's screen
		local timeleft = time - ctime
		if timeleft < engine.TickInterval() then return end

		if icon:IsError() then
			icon = zmhud_icon_missing
		end

		if !anti and !powerup_data[powerup] then
			powerup_data[powerup] = {[1] = (scw/2), [2] = 1}
		end
		if anti and !antipowerup_data[powerup] then
			antipowerup_data[powerup] = {[1] = (scw/2), [2] = 1}
		end

		local width = (scw/2) + (size/2 + (-(size/2) * powerupsTotal + (powerupsActive * size)))
		local convarstyle = nz_powerupstyle:GetInt()
		if convarstyle > 0 then
			if anti then
				antipowerup_data[powerup][1] = math.Approach(antipowerup_data[powerup][1], width, FrameTime()*160)
				antipowerup_data[powerup][2] = convarstyle > 1 and 0 or math.Approach(antipowerup_data[powerup][2], 0, FrameTime()*3)
			else
				powerup_data[powerup][1] = math.Approach(powerup_data[powerup][1], width, FrameTime()*160)
				powerup_data[powerup][2] = convarstyle > 1 and 0 or math.Approach(powerup_data[powerup][2], 0, FrameTime()*3)
			end
		else
			if anti then
				antipowerup_data[powerup][1] = width
				antipowerup_data[powerup][2] = 0
			else
				powerup_data[powerup][1] = width
				powerup_data[powerup][2] = 0
			end
		end

		local warningthreshold = anti and 5 or 10 --at what time does the icon start blinking?
		local frequency1 = 0.1 --how long in seconds it takes for the icon to toggle visibility
		local urgencythreshold = anti and 2 or 5 --at what time does the blinking get faster/slower?
		local frequency2 = 0.1 --how long in seconds it takes for the icon to toggle visibility in urgency mode

		if noflash then
			warningthreshold = 0
			urgencythreshold = 0
		end

		if timeleft > warningthreshold or (timeleft > urgencythreshold and timeleft % (frequency1 * 4) > frequency1) or (timeleft <= urgencythreshold and timeleft % (frequency2*2) > frequency2) then
			local finalwidth = anti and antipowerup_data[powerup][1] or powerup_data[powerup][1]
			local cuntas = anti and antipowerup_data[powerup][2] or powerup_data[powerup][2]
			local finalfade = math.Clamp(1 - cuntas, 0, 1)
			local bonus = (32*cuntas)

			surface.SetMaterial(icon)
			surface.SetDrawColor(ColorAlpha(anti and color_red_255 or color_white, 300*finalfade))
			surface.DrawTexturedRect(finalwidth - (32*scale) - (bonus/2), sch - 160*scale - (bonus/2), 64*scale + bonus, 64*scale + bonus)

			if nz_showpoweruptimer:GetBool() then
				draw.SimpleTextOutlined(math.Round(timeleft), font, finalwidth, sch - 175*scale - (bonus/2), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_100)
			end
		end

		powerupsActive = powerupsActive + 1
	end

	for powerup, time in pairs(tActivePowerUps) do
		if tPowerupBlacklist[powerup] then continue end

		local icon, noflash = GetPowerupIconMaterial(powerup)
		if icon then
			AddPowerup(powerup, icon, time, false, noflash)
		end
	end

	for powerup, time in pairs(tActiveAntiPowerUps) do	
		local icon = GetPowerupIconMaterial(powerup)
		if icon then
			AddPowerup(powerup, icon, time, true)
		end
	end

	for powerup, time in pairs(tPlayerPowerUps) do
		if tPowerupBlacklist[powerup] then continue end

		local icon, noflash = GetPowerupIconMaterial(powerup)
		if icon then
			AddPowerup(powerup, icon, time, false, noflash)
		end
	end

	for powerup, time in pairs(tPlayerAntiPowerUps) do
		local icon = GetPowerupIconMaterial(powerup)
		if icon then
			AddPowerup(powerup, icon, time, true)
		end
	end

	for k, v in pairs(nzPowerUps.Data) do
		if v.global then
			local active = nzPowerUps:IsPowerupActive(k)
			local antiactive = nzPowerUps:IsAntiPowerupActive(k)
			if !active and powerup_data[k] then
				powerup_data[k] = nil
			end
			if !antiactive and antipowerup_data[k] then
				antipowerup_data[k] = nil
			end
		else
			local pactive = nzPowerUps:IsPlayerPowerupActive(ply, k)
			local pantiactive = nzPowerUps:IsPlayerAntiPowerupActive(ply, k)

			if !pactive and powerup_data[k] then
				powerup_data[k] = nil
			end
			if !pantiactive and antipowerup_data[k] then
				antipowerup_data[k] = nil
			end
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

local stinkfade = 0
local function PerksHud()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPerksHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = (ScrW()/1920 + 1)/2
	end

	local perks = ply:GetPerks()

	local bleedtime = ply.GetBleedoutTime and ply:GetBleedoutTime() or nz_bleedouttime:GetFloat()
	local data = nzRevive.Players[ply:EntIndex()]
	if nz_bleedoutstyle:GetInt() == 0 and data then
		local pdata = data.PerksToKeep
		if pdata and next(pdata) ~= nil then
			perks = {}
			for k, v in ipairs(pdata) do
				perks[k] = v.id
			end
		end
	end

	local maxperks = ply:GetMaxPerks()
	local w = ScrW()/1920 + 220
	local h = ScrH()
	local size = 45

	local num = 0
	local row = 0
	local num_b = 0
	local row_b = 0

	local perk_borders = nz_showperkframe:GetInt()
	if perk_borders > 0 and maxperks > 0 then
		local modded = false
		surface.SetMaterial(GetPerkFrameMaterial())
		surface.SetDrawColor(color_white_100)
		for i=1, ply:GetMaxPerks() do
			if i == 4 and nzMapping.Settings.modifierslot and perk_borders < 2 then
				surface.SetDrawColor(color_gold)
				modded = true
			end
			if i > #perks then
				surface.DrawTexturedRect(w + num_b*(size + 6)*pscale, h - 75*pscale - (64*row_b)*pscale, 50*pscale, 50*pscale)
			end

			if modded then
				modded = false
				surface.SetDrawColor(color_white_100)
			end

			num_b = num_b + 1
			if num_b%(nz_perkrowmod:GetInt()) == 0 then
				row_b = row_b + 1
				num_b = 0
			end
		end
	end

	for i, perk in pairs(perks) do
		local icon = GetPerkIconMaterial(perk)
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		local fuckset = 0
		local pulse = 1
		local perkcolor = color_white
		if data and data.DownTime and data.PerksToKeep and data.PerksToKeep[i] then
			local pdata = data.PerksToKeep[i]
			if pdata.lost then
				perkcolor = color_grey_100
			elseif !data.ReviveTime then
				local timetodeath = data.DownTime + bleedtime - CurTime()
				if (timetodeath / bleedtime) < (pdata.prc + (1/(#data.PerksToKeep + 1))) then
					local wave = math.Clamp(math.sin(CurTime()*6), 0, 1)
					pulse = math.Remap(wave, 0, 1, 1, 1.2)
					fuckset = 5*math.Remap(wave, 0, 1, 0, 1)
				end
			end
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(perkcolor)
		surface.DrawTexturedRect(w + num*(size + 6)*pscale - fuckset*pscale, h - (75 + fuckset)*pscale - (64*row)*pscale, 50*pulse*pscale, 50*pulse*pscale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 6)*pscale - fuckset*pscale, h - (75 + fuckset)*pscale - (64*row)*pscale, 50*pulse*pscale, 50*pulse*pscale)
		end

		if perk == "vulture" then
			if ply:HasVultureStink() then
				stinkfade = 1
			end

			if stinkfade > 0 then
				surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))

				surface.SetMaterial(zmhud_vulture_glow)
				surface.DrawTexturedRect((w + num*(size + 6)*pscale) - 24*pscale, (h - 75*pscale - (64*row)*pscale) - 24*pscale, 98*pscale, 96*pscale)
				
				local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
				surface.SetTexture(stink)
				surface.DrawTexturedRect((w + num*(size + 6)*pscale), (h - 75*pscale - (64*row)*pscale) - 62*pscale, 64*pscale, 64*pscale)
			
				stinkfade = math.max(stinkfade - FrameTime()*3, 0)
			end
		end

		num = num + 1
		if num%(nz_perkrowmod:GetInt()) == 0 then
			row = row + 1
			num = 0
		end
	end
end

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

local round_posdata = {
	["alpha"] = 255,
	["white"] = 255,
	["time"] = 0,
	["kys_time"] = 0,
	["intro"] = false,
}

local function ResetRoundPos()
	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	round_posdata[1] = 10
	round_posdata[2] = 140
end

local function GameBeginRound(round)
	round_posdata["intro"] = true
	round_posdata["time"] = CurTime() + 6.5
	round_posdata["alpha"] = 0
	nzDisplay.HUDIntroDuration = round_posdata["time"]

	if !round then
		round = nzRound:GetNumber()
	end

	local w, h = ScrW(), ScrH()
	local scale = 1
	if nz_betterscaling:GetBool() then
		scale = (w/1920 + 1)/2
	end

	local wscale = w/1920*scale

	round_posdata[1] = w/2 - 18*scale
	round_posdata[2] = h/2

	hook.Add("HUDPaint", "nz_fuckoffshitt", function()
		if round_posdata["time"] > CurTime() then return end

		if round_posdata["kys_time"] == 0 then
			round_posdata["kys_time"] = CurTime() + 2
		end

		local kysratio = math.Clamp(((round_posdata["kys_time"] - 1) - CurTime())/1, 0, 1)
		round_posdata["alpha"] = Lerp(kysratio, 0, 255)

		if round_posdata["kys_time"] < CurTime() then
			hook.Remove("HUDPaint", "nz_fuckoffshitt")

			round_posdata["intro"] = false
			round_posdata["alpha"] = 255
			round_posdata["white"] = 255
			round_posdata["kys_time"] = 0

			ResetRoundPos()
		end
	end)
end

local function RoundHud()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawRoundHUD() then return end
	if ply:IsNZMenuOpen() then return end

	local w, h = ScrW(), ScrH()
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = (w/1920 + 1)/2
	end

	if round_posdata["intro"] then
		if round_posdata["time"] - 4.5 < CurTime() then
			round_posdata["white"] = math.Approach(round_posdata["white"], 0, FrameTime()*160)
		end

		local font2 = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		if nz_showgamebegintext:GetBool() then
			surface.SetFont(font2)
			local tw, th = surface.GetTextSize(nzMapping.Settings.gamebegintext)

			local fuck_alpha = math.Clamp(255 - round_posdata["white"], 0, 255)
			if round_posdata["time"] < CurTime() then
				fuck_alpha = round_posdata["alpha"]
			end

			local personalhell = round_posdata["white"] > round_posdata["alpha"] and round_posdata["white"] or math.max(round_posdata["alpha"] - 40, round_posdata["white"] )
			draw.SimpleTextOutlined(nzMapping.Settings.gamebegintext, font2, ScrW()/2, h/2 - 2, ColorAlpha(Color(personalhell, round_posdata["white"], round_posdata["white"]*0.5), round_posdata["alpha"]), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, ColorAlpha(color_black, fuck_alpha))
		end

		if round_posdata["time"] > CurTime() and round_posdata["alpha"] < 255 then
			local iwandieratio = 1 - math.Clamp(((round_posdata["time"] - 4.5) - CurTime())/2, 0, 1)
			round_posdata["alpha"] = Lerp(iwandieratio, 0, 255)
		end
	elseif round_posdata[1] ~= 10 then
		ResetRoundPos()
	end

	if table.IsEmpty(round_posdata) then
		ResetRoundPos()
	end

	if round_posdata["time"] < CurTime() and round_posdata["kys_time"] > CurTime() then
		local kysratio = math.Clamp((round_posdata["kys_time"] - CurTime())/2, 0, 1)

		round_posdata[1] = Lerp(kysratio, 10, w/2 - 18*pscale)
		round_posdata[2] = Lerp(kysratio, 140, h/2)
	end

	if (!roundbusy or table_isempty(rounddata)) and !(nzRound:InState(ROUND_WAITING) or nzRound:InState(ROUND_PREP) or nzRound:InState(ROUND_CREATE)) then
		local R = nzRound:GetNumber() or 0
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
		local hi = T and (round_posdata[2] + 5) or round_posdata[2]

		if timer > 3 then
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectUV(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, (T and tallysize or digitsize.y) * (4-timer), 0, 0, 1, 4-timer)
		elseif timer > 2 then
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,255,99,255*(3-timer)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif timer > 1 and !v.fade then
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(Color(255,255,255,255*(2-timer)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(Color(255,255,255,1024*(timer-1)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,80 + (175*(timer-1)),99*(timer-1)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif timer > 0 and !v.fade then
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,80,0,255*timer))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif v.fade then
			local fade_colora = ColorAlpha(color_white, 255*timer)
			local fade_colorb = ColorAlpha(color_white, 255*(1-timer))

			if timer > 1 then
				surface.SetMaterial(roundassets["normal"][v.image])
				surface.SetDrawColor(fade_colora)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(fade_colorb)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			else
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(fade_colora)
				surface.DrawTexturedRectUV(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y, 0, 0, 1, 1 - math.sin(math.pi*(0.5 + timer/2)))
				--surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			end
		else
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			if nzRound:InState(ROUND_PREP) then
				local prep_color = ColorAlpha(color_white, 127.5 + (127.5*math.sin(CurTime()*8)))

				surface.SetMaterial(roundassets["heat"][v.image])
				surface.SetDrawColor(prep_color)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi*pscale, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
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
					local X = round_posdata[1] + (T and 0 or v.offset)
					local Y = v.offsetheight or (T and (round_posdata[2] + 5) or round_posdata[2])
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

local prevroundspecial = false

local function StartChangeRound()
	local SND = "RoundEnd"
	if prev_round_special then
		SND = "SpecialRoundEnd"
	end
	nzSounds:Play(SND)

	if !nzDisplay.HasPlayedRoundIntro then
		nzDisplay.HasPlayedRoundIntro = true
		timer.Simple((nzMapping.Settings.firstroundwaittime or 1) - engine.TickInterval(), function()
			GameBeginRound(nzRound:GetNumber() + 1)
		end)
	end
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
	timer.Create("round_reseter", 0, 0, function()
		local ply = LocalPlayer()
		if not IsValid(ply) or not ply:Alive() then
			timer.Remove("round_reseter")
			WipeRound()
		end
	end)

	nzDisplay.HasPlayedRoundIntro = nil
end

--[[ JEN WALTER'S ROUND COUNTER ]]--

local function PlayerStaminaHUD()
	if not nz_showstamina:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not ply.GetStamina then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

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
		surface.DrawRect(w/1920 + (75*pscale) + 4, h - (285*scale) + (offset), 130*staminascale, 4)
	end
end

local function PlayerHealthHUD()
	if not nz_showhealth:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = (w - 115*scale)

	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()

	local healthscale = math.Clamp(health / maxhealth, 0, 1)

	surface.SetDrawColor(color_black_180)
	surface.DrawRect(w/1920 + (24*scale), h - 223*scale, 157*scale, 9*scale)

	surface.SetDrawColor(color_white)
	surface.DrawRect(w/1920 + (26*scale), h - 221*scale, 152*scale, 5*scale)

	surface.SetDrawColor(color_health)
	surface.DrawRect(w/1920 + (26*scale), h - 221*scale, 152*healthscale*scale, 5*scale)

	local armor = ply:Armor()
	if armor > 0 then
		local maxarmor = ply:GetMaxArmor()
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/1920 + (24*scale), h - 213*scale, 157*scale, 9*scale)

		surface.SetDrawColor(color_white)
		surface.DrawRect(w/1920 + (26*scale), h - 211*scale, 152*scale, 5*scale)

		surface.SetDrawColor(color_armor)
		surface.DrawRect(w/1920 + (26*scale), h - 211*scale, 152*armorscale*scale, 5*scale)
	end
end

local function ZedCounterHUD()
	if not nz_showzcounter:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = 178*scale
	local hr = h - 222*scale

	surface.SetDrawColor(color_blood)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr - (3*scale), hr - (2*scale), 52*scale, 52*scale)

	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr, hr, 49*scale, 49*scale)

	local smallfont = "nz.ammo2.bo1"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	draw.SimpleTextOutlined(GetGlobal2Int("AliveZombies", 0), smallfont, wr + 25*scale, hr + 24*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
end

//Below are global HUD elements that do not change per hud
//---------------------------------------------------------

local talksize = 64
local voicesize = 32
local namesize = 24
local _sp = game.SinglePlayer()

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
local namefull_enabled = CreateConVar(namefull_cvarname, 0, FCVAR_ARCHIVE, "Enable or disable displaying full player names above their head instead of the first 24 characters. (1 is Enabled, 0 is Disabled),  Default is 0.", 0, 1):GetBool()
cvars.AddChangeCallback(namefull_cvarname, function(name, old, new)
	namefull_enabled = tonumber(new) == 1
end)

local namefade_cvarname = "nz_hud_player_name_fade"
local namefade_time = CreateConVar(namefade_cvarname, 0, FCVAR_ARCHIVE, "How long before player names fade away when not looking at them. (0 to Disable), Default is 0.", 0, 600):GetFloat()
cvars.AddChangeCallback(namefade_cvarname, function(name, old, new)
	namefade_time = tonumber(new)
end)

local namefont_cvarname = "nz_hud_player_name_font"
local namefont_type = CreateConVar(namefont_cvarname, 0, FCVAR_ARCHIVE, "What font style/size to use for player name plates, font type used is always 'points' font in map setting. (0 is Points, 1 is Ammo, 2 is Small, 3 is Main, 4 is Ammo2), Default is 0.", 0, 4):GetInt()
cvars.AddChangeCallback(namefont_cvarname, function(name, old, new)
	namefont_type = tonumber(new)
end)

local status_cvarname = "nz_hud_player_statuses"
local statuses_enabled = CreateConVar(status_cvarname, 1, FCVAR_ARCHIVE, "Enable or disable drawing a status indicator on players name plates for specific actions the player could be taking. (1 Enabled, 0 Disabled), Default is 1.", 0, 1):GetBool()
cvars.AddChangeCallback(status_cvarname, function(name, old, new)
	statuses_enabled = tonumber(new) == 1
end)

local status_cvarname = "nz_hud_player_status_icon_size"
local statusicon_size = CreateConVar(status_cvarname, 32, FCVAR_ARCHIVE, "Size of the player status icon next to their name plate in 3d space. Default is 32.", 0, 128):GetInt()
cvars.AddChangeCallback(status_cvarname, function(name, old, new)
	statusicon_size = tonumber(new)
end)

local clanicon_cvarname = "nz_hud_player_clan_icon_size"
local clanicon_size = CreateConVar(clanicon_cvarname, 32, FCVAR_ARCHIVE, "Size of player's clan icon next to their name plate in 3d space. Default is 32.", 0, 128):GetInt()
cvars.AddChangeCallback(clanicon_cvarname, function(name, old, new)
	clanicon_size = tonumber(new)
end)

local iconpos_cvarname = "nz_hud_player_clan_icon_pos"
local clanicon_pos = CreateConVar(iconpos_cvarname, 0, FCVAR_ARCHIVE, "Position of the players clan icon (0 left side of name, 1 right side of name, 2 above name). Default is 0.", 0, 2):GetInt()
cvars.AddChangeCallback(iconpos_cvarname, function(name, old, new)
	clanicon_pos = tonumber(new)
end)

local function DrawPlayerInfo(ply, pos, ang, ratio, font)
	local localply = LocalPlayer()
	local myindex = localply:EntIndex()
	local index = ply:EntIndex()

	if !name_enabled or (ply.HideMyNameplate and index == myindex) then return end

	local name_pos = pos + vector_up*14

	local nick = ply:Nick()
	if not namefull_enabled and #nick > namesize then
		nick = string.sub(nick, 1, namesize).."..."
	end

	local pcolor = player.GetColorByIndex(index)
	if nz_useplayercolor:GetBool() then
		pcolor = ply:GetPlayerColor():ToColor()
	end

	local n_clanicons = nz_showclanicons:GetInt()

	cam.Start3D2D(name_pos, ang, 0.24)
		cam.IgnoreZ(true)

		surface.SetFont(font)

		if ply:GetNW2Bool("nzLagProtection", false) and statuses_enabled then //lagging or timing out
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(zmhud_icon_connection)
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - statusicon_size, -(statusicon_size*0.75)/2, (statusicon_size*0.75), (statusicon_size*0.75))
		elseif ply:IsSpeaking() then //using voicechat
			local icon = zmhud_icon_voicedim
			if ply:VoiceVolume() > 0 then
				icon = zmhud_icon_voiceon
			end
			if ply:IsMuted() then
				icon = zmhud_icon_voiceoff
			end

			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(icon)
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - statusicon_size, -statusicon_size/2, statusicon_size, statusicon_size)
		elseif localply:IsScoreboardOpen() and ply:IsListenServerHost() and !_sp and statuses_enabled then //p2p lobby host if scoreboard is showing
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(zmhud_icon_localhost)
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - statusicon_size, -statusicon_size/2, statusicon_size, statusicon_size)
		elseif ply:GetNW2Bool("nzInteracting", false) and statuses_enabled then //interacting with something important
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(zmhud_icon_useable)
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - statusicon_size, -statusicon_size/2, statusicon_size, statusicon_size)
		elseif ply:GetNW2Bool("ThirtOTS", false) and index ~= myindex and statuses_enabled then //in thirdperson
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(zmhud_icon_camera)
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - statusicon_size, -statusicon_size/2, statusicon_size, statusicon_size)
		elseif nzDisplay.PlayerClanIcon[ply:EntIndex()] and (ply:GetFriendStatus() == "friend" or n_clanicons > 1 or index == myindex) and n_clanicons > 0 and !ply:IsMuted() and (!clanicon_pos or (clanicon_pos == 0 or (ply:IsTyping() and clanicon_pos == 2))) then
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(nzDisplay.PlayerClanIcon[ply:EntIndex()])
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect(-tw/2 - clanicon_size, -clanicon_size/2, clanicon_size, clanicon_size)
		end

		if clanicon_pos and (clanicon_pos == 1 or (ply:IsSpeaking() and clanicon_pos == 0)) and nzDisplay.PlayerClanIcon[ply:EntIndex()] and (ply:GetFriendStatus() == "friend" or n_clanicons > 1 or index == myindex) and n_clanicons > 0 and !ply:IsMuted() then
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(nzDisplay.PlayerClanIcon[ply:EntIndex()])
			surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
			surface.DrawTexturedRect((tw/2) + 2, -clanicon_size/2, clanicon_size, clanicon_size)
		end

		draw.SimpleTextOutlined(nick, font, 0, 0, ColorAlpha(pcolor, 255*ratio), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, ColorAlpha(color_black, 180*ratio))
		cam.IgnoreZ(false)
	cam.End3D2D()
end

local fontsbytype = {
	[0] = "nz.points.",
	[1] = "nz.ammo.",
	[2] = "nz.small.",
	[3] = "nz.main.",
	[4] = "nz.ammo2."
}

local playerstofade = {}
local function PlayerInfoHUD(bdepth, bskybox) //credit to Player Status Icons by Haaax
	if bskybox then return end

	local localply = LocalPlayer()
	if not IsValid(localply) then return end
	if !localply:ShouldDrawHUD() then return end
	if IsValid(localply:GetObserverTarget()) then
		localply = localply:GetObserverTarget()
	end

	local render_ang = EyeAngles()
	render_ang:RotateAroundAxis(render_ang:Right(), 90)
	render_ang:RotateAroundAxis(-render_ang:Up(), 90)

	local myindex = localply:EntIndex()
	local font = (fontsbytype[namefont_type] or "nz.points.")..GetFontType(nzMapping.Settings.mediumfont)
	local namefade = max_namedist*0.8
	local plytab = player.GetAll()
	local fade_enabled = namefade_time and namefade_time > 0
	local n_clanicons = nz_showclanicons:GetInt()

	if fade_enabled then
		local ent = localply:GetEyeTrace().Entity
		if IsValid(ent) and ent:IsPlayer() then
			playerstofade[ent] = CurTime()
		end

		if localply:ShouldDrawLocalPlayer() then
			playerstofade[localply] = CurTime()
		elseif playerstofade[localply] then
			playerstofade[localply] = nil
		end

		for ply, start in pairs(playerstofade) do
			if not IsValid(ply) or ply:IsDormant() or not ply:Alive() then
				playerstofade[ply] = nil
				continue
			end

			local id = ply:LookupAttachment("anim_attachment_head") or 0
			local att = ply:GetAttachment(id)

			local pos = (att and att.Pos) and att.Pos or ply:WorldSpaceCenter() + ply:GetUp()*26
			local distfac = pos:DistToSqr(EyePos())
			if distfac >= max_namedist then continue end

			local ratio = math.Clamp(((start + math.max(namefade_time, 1)) - CurTime()) / 1, 0, 1)
			if ratio <= 0 then
				playerstofade[ply] = nil
				continue
			end

			DrawPlayerInfo(ply, pos, render_ang, ratio, font)
		end
	else
		for i, ply in ipairs(plytab) do
			if not IsValid(ply) or ply:IsDormant() or not ply:Alive() then continue end
			local index = ply:EntIndex()
			if index == myindex and not localply:ShouldDrawLocalPlayer() then continue end

			local id = ply:LookupAttachment("anim_attachment_head") or 0
			local att = ply:GetAttachment(id)

			local pos = (att and att.Pos) and att.Pos or ply:WorldSpaceCenter() + ply:GetUp()*26
			local distfac = pos:DistToSqr(EyePos())
			local ratio = 1 - math.Clamp((distfac - max_namedist + namefade) / namefade, 0, 1)
			if ratio <= 0 then continue end

			DrawPlayerInfo(ply, pos, render_ang, ratio, font)
		end
	end

	for i, ply in ipairs(plytab) do
		if not IsValid(ply) or ply:IsDormant() or not ply:Alive() then continue end
		local index = ply:EntIndex()
		if index == myindex and not localply:ShouldDrawLocalPlayer() then continue end

		local id = ply:LookupAttachment("anim_attachment_head") or 0
		local att = ply:GetAttachment(id)

		local pos = (att and att.Pos) and att.Pos or ply:WorldSpaceCenter() + ply:GetUp()*26
		local distfac = pos:DistToSqr(EyePos())
		local ratio = 1 - math.Clamp((distfac - max_namedist + namefade) / namefade, 0, 1)
		if ratio <= 0 then continue end

		if fade_enabled and ply:IsSpeaking() and index ~= myindex then
			local talk_pos = pos + vector_up*(fade_enabled and !playerstofade[ply] and 16 or 24)

			local icon = zmhud_icon_voicedim
			if ply:VoiceVolume() > 0 then
				icon = zmhud_icon_voiceon
			end
			if ply:IsMuted() then
				icon = zmhud_icon_voiceoff
			end

			cam.Start3D2D(talk_pos, render_ang, 0.24)
				cam.IgnoreZ(true)
				surface.SetMaterial(icon)
				surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
				surface.DrawTexturedRect(-talksize/2, -talksize/2, talksize, talksize)
				cam.IgnoreZ(false)
			cam.End3D2D()

			continue
		end

		if ply:IsTyping() then
			local talk_pos = pos + vector_up*(fade_enabled and !playerstofade[ply] and 16 or 24)

			cam.Start3D2D(talk_pos, render_ang, 0.24)
				cam.IgnoreZ(true)
				surface.SetMaterial(zmhud_icon_talk)
				surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
				surface.DrawTexturedRect(-talksize/2, -talksize/2, talksize, talksize)
				cam.IgnoreZ(false)
			cam.End3D2D()

			continue
		end

		if clanicon_pos and clanicon_pos == 2 and nzDisplay.PlayerClanIcon[ply:EntIndex()] and (ply:GetFriendStatus() == "friend" or n_clanicons > 1 or index == myindex) and n_clanicons > 0 and !ply:IsMuted() then
			local talk_pos = pos + vector_up*(10 + (clanicon_size/2))

			cam.Start3D2D(talk_pos, render_ang, 0.24)
				surface.SetFont(font)
				local tw, th = surface.GetTextSize("I")

				surface.SetMaterial(nzDisplay.PlayerClanIcon[ply:EntIndex()])
				surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
				surface.DrawTexturedRect(-clanicon_size/2, (fade_enabled and !playerstofade[ply] and 0 or -th) + clanicon_size, clanicon_size, clanicon_size)
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
			pcolor = ply:GetPlayerColor():ToColor()
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

local next_letter = 0
local function YaPh1lTypeWriter()
	if nzDisplay.HasPlayedTypeWriter then return end
	if !nzMapping.Settings.typewriterintro then return end
	if !nzMapping.Settings.typewritertext then return end

	nzDisplay.HasPlayedTypeWriter = true

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale
	local ply = LocalPlayer()

	local b_alldone = false

	local mapstring = tostring(nzMapping.Settings.typewritertext)
	local mapoffset = nzMapping.Settings.typewriteroffset or 420
	local mapdelay = nzMapping.Settings.typewriterdelay or 0.15
	local maplinedelay = nzMapping.Settings.typewriterlinedelay or 1.5
	local hudtype = nzMapping.Settings.hudtype

	local leftsided = false
	if nzDisplay.leftsidedHUDs and nzDisplay.leftsidedHUDs[hudtype] or !nzDisplay.reworkedHUDs[hudtype] then
		leftsided = true
	end

	local intro_strings = string.Split(mapstring, ";")
	local intro_hud = {}
	for k, v in pairs(intro_strings) do
		intro_hud[v] = {[1] = 0, [2] = 0, [3] = 0} //1 is alpha, 2 is letter count, 3 is start fadeout time
	end

	local current_line = 1
	next_letter = CurTime() + 1

	hook.Add("HUDPaint", "phil_typewriter_intro", function()
		local ply = LocalPlayer()
		if nzMapping.Settings.skyintro and IsValid(ply) and ply.GetLastSpawnTime then 
			if ply:GetLastSpawnTime() + (nzMapping.Settings.skyintrotime or 1.4) + 0.15 > CurTime() then
				return
			end
		end
		local font = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_white or nzMapping.Settings.textcolor

		surface.SetFont(font)
		local tw, th = surface.GetTextSize("I")

		if leftsided then
			mapoffset = (h - th - (5*scale))
		end

		local b_newline = false
		for i=1, #intro_strings do
			local ourstring = intro_strings[i]

			if next_letter < CurTime() and intro_hud[ourstring][2] < #ourstring then
				intro_hud[ourstring][2] = math.Clamp(intro_hud[ourstring][2] + 1, 0, #ourstring)

				if i <= current_line and intro_hud[ourstring][1] == 0 then
					intro_hud[ourstring][1] = 1
				end
				if intro_hud[ourstring][2] == #ourstring then
					current_line = math.Clamp(current_line + 1, 0, #intro_strings)
					b_newline = true

					if current_line == #intro_strings then
						for i=1, #intro_strings do
							intro_hud[intro_strings[i]][3] = CurTime() + (2.5 + i)
						end
					end
				end

				next_letter = CurTime() + (b_newline and maplinedelay or mapdelay)

				if ourstring ~= " " then
					surface.PlaySound("nz.typewriter")
				end
			end

			if intro_hud[ourstring][3] > 0 and intro_hud[ourstring][3] < CurTime() and intro_hud[ourstring][1] > 0 then
				intro_hud[ourstring][1] = math.Approach(intro_hud[ourstring][1], 0, FrameTime())
			end

			if current_line >= #intro_strings then
				local finalist = intro_hud[intro_strings[#intro_strings]]
				if finalist[2] >= #intro_strings[#intro_strings] and finalist[1] == 0 then
					b_alldone = true
				end
			end

			draw.SimpleTextOutlined(string.sub(ourstring, 0, intro_hud[ourstring][2]), font, 5, h - (mapoffset*scale) + (i*th), ColorAlpha(fontColor, 255*intro_hud[ourstring][1]), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, (nzMapping.Settings.fontthicc or 2), ColorAlpha(color_black, 100*intro_hud[ourstring][1]))
		end

		if b_alldone then
			hook.Remove("HUDPaint", "phil_typewriter_intro")
		end
	end)
end

net.Receive("nz_game_end_notif", function()
	local gameovertext = net.ReadString()
	local survivedtext = net.ReadString()

	timer.Simple(nzRound:GameOverDuration() - engine.TickInterval(), function()
		hook.Remove("HUDPaint", "game_over_notif")
	end)

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	local font = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
	local font2 = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_white or nzMapping.Settings.textcolor

	local n_starttime = CurTime()
	hook.Add("HUDPaint", "game_over_notif", function()
		local fade = 1 - math.Clamp(((n_starttime + 1) - CurTime())/1, 0, 1)

		surface.SetFont(font)

		local tw, th = surface.GetTextSize(gameovertext)

		draw.SimpleTextOutlined(gameovertext, font, w/2, 285*scale, ColorAlpha(fontColor, 255*fade), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, (nzMapping.Settings.fontthicc or 2), ColorAlpha(color_black, 100*fade))

		surface.SetFont(font2)

		draw.SimpleTextOutlined(survivedtext, font2, w/2, 285*scale + th, ColorAlpha(fontColor, 255*fade), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, (nzMapping.Settings.fontthicc or 2), ColorAlpha(color_black, 100*fade))
	end)
end)

local function VultureVision()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if !ply:ShouldDrawHUD() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not ply:HasPerk("vulture") then return end
	local scale = (ScrW()/1920 + 1)/2
	local icon = nzDisplay.vultureHUDicons["wunderfizz_machine"] //? if unknown

	for k, v in nzLevel.GetVultureArray() do
		if not IsValid(v) then continue end
		if v:GetNoDraw() then continue end
		local data = v:WorldSpaceCenter():ToScreen()
		if not data.visible then continue end

		local dist = ply:GetPos():DistToSqr(v:GetPos())
		if (dist > 1000000) then continue end //1000hu^2

		local distfac = 1 - math.Clamp((dist - 1000000 + 160000)/160000, 0, 1) //fade of 400hu^2
		local class = v:GetClass()
		local ourcolor = ColorAlpha(color_white, 120*distfac)

		if nzDisplay.vultureHUDicons[class] then
			icon = nzDisplay.vultureHUDicons[class]
		elseif v.GetPerkID then
			local perk = v:GetPerkID()
			if perk == "pap" then
				icon = nzDisplay.vultureHUDicons["pap"]
			else
				icon = GetPerkIconMaterial(perk)
			end
		elseif nzPowerUps.EntityClasses[class] then
			data = class == "drop_tombstone" and v:GetAttachment(1).Pos:ToScreen() or  v:GetPos():ToScreen()
			if v.GetPowerUp then
				icon = GetPowerupIconMaterial(v:GetPowerUp())
			end
			if v.GetAnti and v:GetAnti() then
				ourcolor = ColorAlpha(color_red_255, 200*distfac)
			else
				if v.GetActivated and not v:GetActivated() then
					continue
				end
				ourcolor = ColorAlpha(color_white, 200*distfac)
			end
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(ourcolor)
		surface.DrawTexturedRect(data.x - 21*scale, data.y - 21*scale, 42*scale, 42*scale)
	end
end

local function StatesHUD()
	if nzRound:InProgress() then return end
	if !LocalPlayer():ShouldDrawHUD() then return end

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
	end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor
	draw.SimpleTextOutlined(text, font, w/2, 60*pscale, fontColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
end

hook.Add("TFA_DrawCrosshair", "GameIntroBlockCrosshair", function(wep)
	if LocalPlayer():GetNW2Float("FirstSpawnedTime", 0) + 2 > CurTime() then
		return true
	end
	if nzDisplay and nzDisplay.HUDIntroDuration and (nzDisplay.HUDIntroDuration - 0.5) > CurTime() then
		return true
	end
end)

hook.Add("HUDPaint", "playersvoiceHUD", PlayerVoiceHUD )
hook.Add("PostDrawTranslucentRenderables", "nzplayerinfoHUD", PlayerInfoHUD )
hook.Add("OnRoundPreparation", "typewriteintroHUD", YaPh1lTypeWriter )
hook.Add("OnRoundEnd", "typewriteintroHUD", function()
	nzDisplay.HasPlayedTypeWriter = nil
	hook.Remove("HUDPaint", "phil_typewriter_intro")
end)
hook.Add("HUDPaint", "bloodspatterHUD", BloodSpatterHUD )
hook.Add("HUDPaint", "vultureVision", VultureVision )
hook.Add("HUDPaint", "deathiconsHUD", DeathHud )
hook.Add("HUDPaint", "powerupHUD", PowerUpsHud )
hook.Add("HUDPaint", "roundHUD", StatesHUD )

//End of global HUD elements
//---------------------------------------------------------

//individual per HUD elements
hook.Add("HUDPaint", "nzHUDswapping_default", function()
	if not nzDisplay.reworkedHUDs[nzMapping.Settings.hudtype] then
		--hook.Add("HUDPaint", "musicHUD", MusicHUD )
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud )
		hook.Add("HUDPaint", "powerupHUD", PowerUpsHud ) //huds in the future might require their own
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud )
		hook.Add("HUDPaint", "perksHUD", PerksHud )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD )
		hook.Add("HUDPaint", "zedcounterHUD", ZedCounterHUD )

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

	/*local id = wep.NZSpecialCategory
	if !ply.NZSpecialWeapons then ply.NZSpecialWeapons = {} end
	if id and !IsValid(ply.NZSpecialWeapons[id]) then
		if ply:HasUpgrade("mulekick") and !wep.NZNoMaxAmmo and wep.NZSpecialWeaponData and wep.NZSpecialWeaponData.MaxAmmo then
			wep.NZSpecialWeaponData.MaxAmmo = wep.NZSpecialWeaponData.MaxAmmo + 1
		end
		ply.NZSpecialWeapons[id] = wep
	end*/

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