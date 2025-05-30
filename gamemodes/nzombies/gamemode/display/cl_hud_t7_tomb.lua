-------------------------
-- Localize
local pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale =
	pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale

local math, surface, table, input, string, draw, killicon, file =
	math, surface, table, input, string, draw, killicon, file

local file_exists, input_getkeyname, input_isbuttondown, input_lookupbinding, table_insert, table_remove, table_isempty, table_count, table_copy =
	file.Exists, input.GetKeyName, input.IsButtonDown, input.LookupBinding, table.insert, table.remove, table.IsEmpty, table.Count, table.Copy

local string_len, string_sub, string_gsub, string_upper, string_rep, string_match, string_split =
	string.len, string.sub, string.gsub, string.upper, string.rep, string.match, string.Split

local TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM =
	TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM

local voiceloopback = GetConVar("voice_loopback")
local cl_drawhud = GetConVar("cl_drawhud")
local sv_clientpoints = GetConVar("nz_point_notification_clientside")
local nz_clientpoints = GetConVar("nz_hud_clientside_points")
local nz_perkmax = GetConVar("nz_difficulty_perks_max")

local nz_showhealth = GetConVar("nz_hud_show_health")
local nz_showhealthmp = GetConVar("nz_hud_show_health_mp")
local nz_showstamina = GetConVar("nz_hud_show_stamina")

local nz_showmmostats = GetConVar("nz_hud_show_perkstats")
local nz_showcompass = GetConVar("nz_hud_show_compass")
local nz_shownames = GetConVar("nz_hud_show_names")
local nz_showgun = GetConVar("nz_hud_show_wepicon")
local nz_showperkframe = GetConVar("nz_hud_show_perk_frames")
local nz_showzcounter = GetConVar("nz_hud_show_alive_counter")
local nz_showpoweruptimer = GetConVar("nz_hud_show_powerup_time")
local nz_showportrait = GetConVar("nz_hud_show_player_portrait")
local nz_showgamebegintext = GetConVar("nz_hud_show_game_start_text")

local nz_indicators = GetConVar("nz_hud_player_indicators")
local nz_indicatorangle = GetConVar("nz_hud_player_indicator_angle")
local nz_healthplayercolor = GetConVar("nz_hud_health_playercolor")
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")
local nz_powerupstyle = GetConVar("nz_hud_powerup_style")

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
local color_black_180 = Color(0, 0, 0, 180)
local color_black_100 = Color(0, 0, 0, 100)
local color_black_50 = Color(0, 0, 0, 50)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_255 = Color(255, 0, 0, 255)
local color_red_10 = Color(255, 0, 0, 10)

local color_grey_100 = Color(100,100,100,255)
local color_grey = Color(200, 200, 200, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(135, 160, 255)
local color_health = Color(255, 120, 120, 255)

local color_t7_sparks = Color(255, 80, 80, 200)
local color_t7 = Color(220, 40, 40, 255)
local color_t7_tomb = Color(255, 120, 160, 255)
local color_t7_outline = Color(200, 40, 80, 10)

local color_t7_ammo = Color(255, 245, 245, 255)
local color_t7_ammo_outline = Color(200, 40, 80, 10)

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

//--------------------------------------------------/Rudy, GhostlyMoo and Fox's Origins HUD\------------------------------------------------\\

//t7 hud
local t7_hud_dpad_base = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_dpadbase.png", "unlitgeneric smooth")

local t7_hud_ammo_glow = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_number_glow_empty.png", "unlitgeneric smooth")
local t7_hud_ammo_projection_lrg = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_projection_lrg.png", "unlitgeneric smooth")
local t7_hud_ammo_panelglow = Material("nz_moo/huds/t7/uie_t7_zm_hud_panel_ammo.png", "unlitgeneric smooth")

local t7_hud_ammo_p1 = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_projection_p1.png", "unlitgeneric smooth noclamp")
local t7_hud_ammo_p2 = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_projection_p2.png", "unlitgeneric smooth noclamp")
local t7_hud_ammo_p3 = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_projection_p3.png", "unlitgeneric smooth noclamp")

local t7_hud_ammo = {
	[0] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number0.png", "unlitgeneric smooth"),
	[1] = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_number1.png", "unlitgeneric smooth"),
	[2] = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_number2.png", "unlitgeneric smooth"),
	[3] = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_number3.png", "unlitgeneric smooth"),
	[4] = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_number4.png", "unlitgeneric smooth"),
	[5] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number5.png", "unlitgeneric smooth"),
	[6] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number6.png", "unlitgeneric smooth"),
	[7] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number7.png", "unlitgeneric smooth"),
	[8] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number8.png", "unlitgeneric smooth"),
	[9] = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_noglow_number9.png", "unlitgeneric smooth"),
}

local t7_hud_score = Material("nz_moo/huds/bo3/uie_score_feed_glow.png", "unlitgeneric smooth")
local t7_hud_player_vignette = Material("nz_moo/huds/t7/vignette.png", "unlitgeneric smooth")
local t7_hud_player_glow = Material("nz_moo/huds/t7/uie_t7_zm_hud_panel_rnd.png", "unlitgeneric smooth")

//t7 inventory
local t7_icon_shield_fill = Material("nz_moo/huds/t7/uie_t7_icon_inventory_dlc3_dragonshield_fill.png", "unlitgeneric smooth")
local t7_icon_shield = Material("nz_moo/huds/t7/uie_t7_icon_inventory_dlc3_dragonshield_outline.png", "unlitgeneric smooth")
local t7_icon_special_swirl = Material("nz_moo/huds/t7/uie_t7_core_hud_ammowidget_abilityswirl.png", "unlitgeneric smooth")
local t7_icon_special_flash = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_icon_gun_readyflash.png", "unlitgeneric smooth")
local t7_icon_special = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_icon_gun.png", "unlitgeneric smooth")
local t7_icon_grenade = Material("nz_moo/huds/t7/uie_t7_zm_hud_inv_icnlthl.png", "unlitgeneric smooth")
local t7_icon_sticky = Material("nz_moo/huds/t7/uie_t7_zm_hud_inv_widowswine.png", "unlitgeneric smooth")
local t7_icon_trap_fill = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_icon_mine.png", "unlitgeneric smooth")
local t7_icon_trap = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_icon_mine_inactive.png", "unlitgeneric smooth")
local t7_icon_underbarrel = Material("nz_moo/huds/t5/uie_t5hud_icon_grenade_launcher.png", "unlitgeneric smooth")
local t7_icon_zmoney = Material("nz_moo/huds/t7/uie_t7_zm_derriese_hud_ammo_z_blue.png", "unlitgeneric smooth")
local t7_icon_grenade_hud = Material("nz_moo/huds/t7/hud_grenadeicon.png", "unlitgeneric smooth")
local t7_icon_gum = Material("nz_moo/huds/t7_tomb/uie_t7_zm_derriese_hud_ammo_icon_ggb.png", "unlitgeneric smooth")

//universal
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_dpad_compass = Material("nz_moo/huds/t7/compass_mp_hud.png", "unlitgeneric smooth noclamp")
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
local zmhud_icon_zedcounter = Material("nz_moo/icons/ugx_talkballoon.png", "unlitgeneric smooth")
local zmhud_player_teleporting = Material("effects/tp_eyefx/tpeye.vmt")

local illegalspecials = {
	["specialgrenade"] = true,
	["grenade"] = true,
	["knife"] = true,
	["display"] = true,
}

local PointsNotifications = {}
local function PointsNotification(ply, amount, profit_id)
	if not IsValid(ply) then return end
	local data = {ply = ply, amount = amount, diry = math.random(-25, 25), time = CurTime(), profit = profit_id}
	table_insert(PointsNotifications, data)
end

local function DrawRotatedText( text, x, y, font, color, ang)
	render.PushFilterMag( TEXFILTER.ANISOTROPIC )
	render.PushFilterMin( TEXFILTER.ANISOTROPIC )

	local m = Matrix()
	m:Translate( Vector( x, y, 0 ) )
	m:Rotate( Angle( 0, ang, 0 ) )

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	m:Translate( -Vector( w / 2, h / 2, 0 ) )

	cam.PushModelMatrix( m )
		draw.DrawText( text, font, 0, 0, color )
	cam.PopModelMatrix()

	render.PopFilterMag()
	render.PopFilterMin()
end

net.Receive("nz_points_notification_tomb_hd", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	local profit_id = net.ReadInt(9)
	PointsNotification(ply, amount, profit_id)
end)

//Equipment
local fade_down = 0
local fade_down_acc = 0
local fade_right = 0
local fade_right_acc = 0
local fade_special = 0
local fade_special_acc = 0
local fade_ammo = 0
local fade_ammo_acc = 0

local Circles = {
	[1] = {r = -1, col = Color(200,0,0,120), colb = Color(200,20,20,120), cole = Color(60,0,0,120)},
	[2] = {r = 0, col = Color(200,40,80,220), colb = Color(200,50,50,220), cole = Color(100,20,20,255)},
	[3] = {r = 1, col = Color(255,120,120,255), colb = Color(255,100,100,255), cole = Color(150,50,50,255)},
	[4] = {r = 2, col = Color(200,40,80,220), colb = Color(200,50,50,220), cole = Color(100,20,20,255)},
	[5] = {r = 3, col = Color(200,0,0,120), colb = Color(200,20,20,120), cole = Color(60,0,0,120)},
}

local function DrawSpecialistCircle( X, Y, target_radius, value, active, empty )
	local endang = 360 * value
	if endang == 0 then return end

	for i = 1, #Circles do
		local data = Circles[ i ]
		local radius = target_radius + data.r
		local segmentdist = endang / ( math.pi * radius / 3 )

		for a = 0, endang, segmentdist do
			surface.SetDrawColor( empty and data.cole or (active and data.colb or data.col) )
			surface.DrawLine( X - math.sin( math.rad( a ) ) * radius * 0.9, Y + math.cos( math.rad( a ) ) * radius, X - math.sin( math.rad( a + segmentdist ) ) * radius * 0.9, Y + math.cos( math.rad( a + segmentdist ) ) * radius )
		end
	end
end

local function InventoryHUD_t7()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawInventoryHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local ammofont = "nz.ammo.blackops2"
	local ammo2font = "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammofont = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local plyweptab = ply:GetWeapons()

	local gumdata = nzGum:GetActiveGumData(ply)
	if gumdata and (nzGum:IsUseBaseGum(ply) or nzGum:IsRoundBaseGum(ply)) then
		surface.SetMaterial(t7_icon_gum)
		surface.SetDrawColor(color_t7)
		surface.DrawTexturedRect(w - 159*scale, h - 232*scale, 52*scale, 52*scale)

		surface.SetMaterial(t7_icon_gum)
		surface.SetDrawColor(color_t7_tomb)
		surface.DrawTexturedRect(w - 157*scale, h - 230*scale, 50*scale, 50*scale)

		local uses = ply:GetNWInt("nzCurrentGum_UsesRemain", 0)
		local rounds = nzGum:RoundsRemain(ply)
		if rounds > 0 then
			uses = rounds
		end
		if uses > 0 then
			if uses > 9 then
				draw.SimpleTextOutlined(uses, ammofont, w - 134*scale, h - 252*scale, color_t7, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_t7_outline)
			else
				surface.SetMaterial(t7_hud_ammo[uses] or zmhud_icon_missing)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w - 163*scale, h - 262*scale, 60*scale, 60*scale)
			end
		end
	end

	// Special Weapon Categories
	for _, wep in pairs(plyweptab) do
		// Traps
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "trap" then
			if wep.NZPickedUpTime and (wep.NZPickedUpTime + 5 > CurTime() or fade_right > 0) then
				fade_right_acc = fade_right_acc + FrameTime()*2
				fade_right = math.abs(math.sin(fade_right_acc))
				if wep.NZPickedUpTime + 5 < CurTime() and fade_right < 0.1 then
					fade_right = 0
					fade_right_acc = 0
				end

				surface.SetMaterial(t7_hud_score)
				surface.SetDrawColor(ColorAlpha(color_t7, 255*fade_right))
				surface.DrawTexturedRect(w - 119*scale, h - 188*scale, 72*scale, 72*scale)
			end

			surface.SetMaterial(t7_icon_trap)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - 108*scale, h - 168*scale, 55*scale, 55*scale)

			local ammo = wep:GetPrimaryAmmoType()
			if ammo > 0 and not wep.TrapCanBePlaced then
				local ammocount = math.min(ply:GetAmmoCount(ammo) + wep:Clip1(), 9)
				if ammocount > 0 then
					surface.SetMaterial(t7_icon_trap_fill)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(w - 108*scale, h - 168*scale, 55*scale, 55*scale)

					surface.SetMaterial(t7_hud_ammo[ammocount])
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRect(w - 88*scale, h - 170*scale, 60*scale, 60*scale)
				end
			else
				surface.SetMaterial(t7_icon_trap_fill)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w - 108*scale, h - 168*scale, 55*scale, 55*scale)
			end
		end

		// Specialists
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
			local icon = t7_icon_special
			local custom = false
			if IsValid(wep) and wep.NZHudIcon_t7zod then
				icon = wep.NZHudIcon_t7zod
				custom = true
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_t7)
			surface.DrawTexturedRect(w - 194*scale, h - 202*scale, 116*scale, 116*scale)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white_200)
			surface.DrawTexturedRect(w - 190*scale, h - 198*scale, 108*scale, 108*scale)

			local specialhp = wep:Clip1()
			local specialmax = wep.Primary_TFA.ClipSize
			local specialscale = math.Clamp(specialhp / specialmax, 0, 1)
			local active = ply:GetActiveWeapon() == wep

			DrawSpecialistCircle(w - 135*scale, h - 146*scale, 32*scale, 1*specialscale, active, not active and specialhp < specialmax)

			if wep.NZPickedUpTime and (wep.NZPickedUpTime + 5 > CurTime() or fade_special > 0) then
				fade_special_acc = fade_special_acc + FrameTime()*2
				fade_special = math.abs(math.sin(fade_special_acc))
				if wep.NZPickedUpTime + 5 < CurTime() and fade_special < 0.1 then
					fade_special = 0
					fade_special_acc = 0
				end

				if wep.NZPickedUpTime + 1 > CurTime() then
					local fucker = 1 - math.Clamp(((wep.NZPickedUpTime + 1) - CurTime()) / 1, 0, 1)
					local dafade = 1
					if fucker < 0.5 then
						dafade = 1 - math.Clamp(((wep.NZPickedUpTime + 0.5) - CurTime()) / 0.5, 0, 1)
					else
						dafade = math.Clamp(((wep.NZPickedUpTime + 1) - CurTime()) / 1, 0, 1)
					end

					cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", w - 105*scale, h - 242*scale, 168*scale, 252*scale, ColorAlpha(color_t7, 200*dafade))

					surface.SetMaterial(t7_icon_special_swirl)
					surface.SetDrawColor(ColorAlpha(color_t7, 255*dafade))
					surface.DrawTexturedRectRotated(w - 135*scale, h - 146*scale, 140*fucker*scale, 140*fucker*scale, (fade_special_acc*900)%360)
				end

				if wep.NZPickedUpTime + 0.6 > CurTime() then
					surface.SetMaterial(t7_icon_special_swirl)
					surface.SetDrawColor(color_white)
					surface.DrawTexturedRectRotated(w - 135*scale, h - 146*scale, 90*scale, 90*scale, (fade_special_acc*900)%360)
				end
			end
		end

		// Shield Slot Occupier
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "shield" and wep.NZHudIcon and not wep.ShieldEnabled then
			if wep.NZPickedUpTime and (wep.NZPickedUpTime + 5 > CurTime() or fade_down > 0) then
				fade_down_acc = fade_down_acc + FrameTime()*2
				fade_down = math.abs(math.sin(fade_down_acc))
				if wep.NZPickedUpTime + 5 < CurTime() and fade_down < 0.1 then
					fade_down = 0
					fade_down_acc = 0
				end

				surface.SetMaterial(t7_hud_score)
				surface.SetDrawColor(ColorAlpha(color_t7, 255*fade_down))
				surface.DrawTexturedRect(w - 172*scale, h - 134*scale, 72*scale, 72*scale)
			end

			local icon = t7_icon_shield
			if IsValid(wep) and wep.NZHudIcon then
				icon = wep.NZHudIcon_t7tomb or wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_t7)
			surface.DrawTexturedRect(w - 159*scale, h - 115*scale, 48*scale, 48*scale)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_t7_tomb)
			surface.DrawTexturedRect(w - 156*scale, h - 112*scale, 42*scale, 42*scale)
		end
	end

	// Shield
	if ply.GetShield and IsValid(ply:GetShield()) then
		local shield = ply:GetShield()
		local wep = shield:GetWeapon()

		if wep.NZPickedUpTime and (wep.NZPickedUpTime + 5 > CurTime() or fade_down > 0) then
			fade_down_acc = fade_down_acc + FrameTime()*2
			fade_down = math.abs(math.sin(fade_down_acc))
			if wep.NZPickedUpTime + 5 < CurTime() and fade_down < 0.1 then
				fade_down = 0
				fade_down_acc = 0
			end

			surface.SetMaterial(t7_hud_score)
			surface.SetDrawColor(ColorAlpha(color_t7, 255*fade_down))
			surface.DrawTexturedRect(w - 172*scale, h - 134*scale, 72*scale, 72*scale)
		end

		local shieldhp = shield:Health()
		local shieldmax = shield:GetMaxHealth()
		local shieldscale = math.Clamp(shieldhp / shieldmax, 0, 1)

		if wep.Secondary and wep.Secondary.ClipSize > 0 then
			local clip2 = wep:Clip2()
			local clip2rate = wep.Secondary.AmmoConsumption
			local clip2i = math.floor(clip2/clip2rate)

			surface.SetMaterial(t7_hud_ammo[clip2i])
			surface.SetDrawColor(color_t7_tomb)
			surface.DrawTexturedRect(w - 165*scale, h - 96*scale, 60*scale, 60*scale)
		end

		surface.SetMaterial(t7_icon_shield_fill)
		surface.SetDrawColor(color_t7)
		surface.DrawTexturedRectUV(w - 153*scale, h - 108*scale, 36*scale, (36*shieldscale)*scale, 0, 0, 1, (1*shieldscale))

		surface.SetMaterial(t7_icon_shield)
		surface.SetDrawColor(color_t7_tomb)
		surface.DrawTexturedRect(w - 152*scale, h - 107*scale, 34*scale, 34*scale)
	end
end

local function ScoreHud_t7()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local fontsmall = "nz.ammo.bo3.wepname"
	local fontmain = "nz.small.blackops2"
	local fontnade = "nz.grenade"
	if nz_mapfont:GetBool() then
		fontsmall = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		fontmain = "nz.pointsmain."..GetFontType(nzMapping.Settings.ammofont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local offset = 0
	local wr = w/1920

	local plyindex = ply:EntIndex()
	local plytab = player.GetAll()

	local color = player.GetColorByIndex(plyindex)
	if nz_useplayercolor:GetBool() then
		local pcol = ply:GetPlayerColor()
		color = Color(255*pcol.x, 255*pcol.y, 255*pcol.z, 255)
	end

	//name
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
			surface.DrawTexturedRect(wr + 45*scale + tw, h - (275*scale) - offset - 16, 32, 32)
		end

		draw.SimpleTextOutlined(nick, fontsmall, wr + 45*scale, h - (278*scale) - offset, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)
	end

	//points
	surface.SetDrawColor(ColorAlpha(color, 20))
	surface.SetMaterial(t7_hud_score)
	surface.DrawTexturedRect(wr + 40*scale, h - (270*scale) - offset, 215*scale, 60*scale)

	draw.SimpleTextOutlined(ply:GetPoints(), fontmain, wr + (115*scale), h - (240*scale) - offset, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, ColorAlpha(color, 10))
	ply.PointsSpawnPosition = {x = wr + 220*scale, y = h - 240 * scale - offset}

	//icon
	local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")
	if not pmpath or pmpath:IsError() then
		pmpath = zmhud_icon_missing
	end

	surface.SetDrawColor(color_t7_outline)
	surface.SetMaterial(t7_hud_player_glow)
	surface.DrawTexturedRect(wr + 46*scale, h - 260 * scale - offset, 64*scale, 64*scale)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(pmpath)
	surface.DrawTexturedRect(wr + 46*scale, h - 260 * scale - offset, 64*scale, 64*scale)

	surface.SetDrawColor(color_white)
	surface.SetMaterial(t7_hud_player_vignette)
	surface.DrawTexturedRect(wr + 44*scale, h - (262*scale) - offset, 68*scale, 68*scale)

	surface.SetDrawColor(color_black_100)
	surface.DrawOutlinedRect(wr + 44*scale, h - (262*scale) - offset, 68*scale, 68*scale, 2*scale)

	//shovel
	if ply.GetShovel and IsValid(ply:GetShovel()) then
		local pshovel = ply:GetShovel()

		surface.SetMaterial(pshovel:IsGolden() and pshovel.NZHudIcon2 or pshovel.NZHudIcon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(wr + 5*scale, h - 235*scale - offset, 42*scale, 42*scale)
	end

	for k, v in ipairs(plytab) do
		local index = v:EntIndex()
		if index == plyindex then continue end

		local pcolor = player.GetColorByIndex(index)
		if nz_useplayercolor:GetBool() then
			local pvcol = v:GetPlayerColor()
			pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		end

		offset = offset + 50*scale
		if nz_showhealthmp:GetBool() then
			offset = offset + 16*scale //health bar offset buffer
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
				surface.DrawTexturedRect(wr + 69*scale + tw, h - (275*scale) - offset - 16, 32, 32)
			end

			draw.SimpleTextOutlined(nick, fontsmall, wr + 69*scale, h - (277*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)
		end

		//points
		surface.SetDrawColor(ColorAlpha(pcolor, 20))
		surface.SetMaterial(t7_hud_score)
		surface.DrawTexturedRect(wr + 80*scale, h - (275*scale) - offset, 140*scale*0.8, 60*scale*0.8)

		draw.SimpleTextOutlined(v:GetPoints(), fontsmall, wr + (118*scale), h - (248*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, ColorAlpha(pcolor, 10))
		v.PointsSpawnPosition = {x = wr + 190*scale, y = h - 253 * scale - offset}

		//icon
		local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")
		if not pmpath or pmpath:IsError() then
			pmpath = zmhud_icon_missing
		end

		surface.SetDrawColor(color_t7_outline)
		surface.SetMaterial(t7_hud_player_glow)
		surface.DrawTexturedRect(wr + 70*scale, h - (260*scale) - offset, 40*scale, 40*scale)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(wr + 70*scale, h - (260*scale) - offset, 40*scale, 40*scale)

		surface.SetMaterial(t7_hud_player_vignette)
		surface.DrawTexturedRect(wr + 68*scale, h - (262*scale) - offset, 44*scale, 44*scale)

		if v.GetTeleporterEntity and IsValid(v:GetTeleporterEntity()) then
			surface.SetMaterial(zmhud_player_teleporting)
			surface.DrawTexturedRect(wr + 70*scale, h - 260 * scale - offset, 40*scale, 40*scale)
		end

		if v.IsOnFire and v:IsOnFire() or v:GetNW2Float("nzLastBurn", 0) + 1.5 > CurTime() then
			surface.SetMaterial(zmhud_player_onfire)
			surface.DrawTexturedRect(wr + 70*scale, h - 260 * scale - offset, 40*scale, 40*scale)
		end

		if v:GetNW2Float("nzLastShock", 0) + 1.5 > CurTime() then
			surface.SetMaterial(zmhud_player_shocked)
			surface.DrawTexturedRect(wr + 70*scale, h - 260 * scale - offset, 40*scale, 40*scale)
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
					surface.DrawTexturedRect(wr + 70*scale + (16*scale), h - 260*scale + (16*scale) - offset, 24*scale, 48*scale)
				end
			end
		end

		if v.HasVultureStink and v:HasVultureStink() then
			surface.SetMaterial(zmhud_player_stink)
			surface.DrawTexturedRect(wr + 70*scale, h - 260 * scale - offset, 40*scale, 40*scale)

			surface.SetMaterial(Material("color"))
			surface.SetDrawColor(160, 255, 0, math.max(24 * math.abs(math.sin(CurTime())), 14))
			surface.DrawTexturedRect(wr + 70*scale, h - 260 * scale - offset, 40*scale, 40*scale)
		end

		surface.SetDrawColor(color_black_100)
		surface.DrawOutlinedRect(wr + 68*scale, h - (262*scale) - offset, 44*scale, 44*scale, 2*scale)

		//shovel
		if v.GetShovel and IsValid(v:GetShovel()) then
			local pshovel = v:GetShovel()

			surface.SetMaterial(pshovel:IsGolden() and pshovel.NZHudIcon2 or pshovel.NZHudIcon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(wr + 40*scale, h - 245*scale - offset, 32*scale, 32*scale)
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
			surface.DrawRect(wr + (68*scale), h - 216*scale - offset, 136*scale, 8*scale)

			surface.SetDrawColor(color_white)
			surface.DrawRect(wr + (70*scale), h - 214*scale - offset, 132*scale, 4*scale)

			surface.SetDrawColor(color_health)
			surface.DrawRect(wr + (70*scale), h - 214*scale - offset, 132*phealthscale*scale, 4*scale)
		
			local armor = v:Armor()
			if armor > 0 then
				local maxarmor = v:GetMaxArmor()
				local armorscale = math.Clamp(armor / maxarmor, 0, 1)

				surface.SetDrawColor(color_black_180)
				surface.DrawRect(wr + (68*scale), h - 208*scale - offset, 136*scale, 8*scale)

				surface.SetDrawColor(color_white)
				surface.DrawRect(wr + (70*scale), h - 206*scale - offset, 132*scale, 4*scale)

				surface.SetDrawColor(color_armor)
				surface.DrawRect(wr + (70*scale), h - 206*scale - offset, 132*armorscale*scale, 4*scale)
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

local dotpos = 0
local p1pos = 0
local p2pos = 0
local p3pos = 0

local lerpcol_white = Color(255, 200, 200, 255)
local lerpcol_red = Color(200, 0, 0, 255)
local emptyclipdie = false
local emptycliptime = 0

local emptyclip2die = false
local emptyclip2time = 0

local function DoAnimatedHudBits()
	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2

	//glow background
	surface.SetMaterial(t7_hud_score)
	surface.SetDrawColor(ColorAlpha(color_t7, math.random(60, 90)))
	surface.DrawTexturedRect(w - 234*scale, h - 270*scale, 128*scale*1.8, 128*scale*1.8)

	surface.SetMaterial(t7_hud_ammo_projection_lrg)
	surface.SetDrawColor(ColorAlpha(color_t7_tomb, math.random(100, 140)))
	surface.DrawTexturedRect(w - 419*scale, h - 318*scale, 468*scale*0.85, 360*scale*0.86)

	surface.SetMaterial(t7_hud_ammo_panelglow)
	surface.SetDrawColor(color_t7_outline)
	surface.DrawTexturedRect(w - 260*scale - (52*scale), h - 145*scale - (52*scale), 429*scale*0.25, 288*scale*0.25)

	//animated bits
	p1pos = p1pos + FrameTime()*0.2
	if p1pos > 1 then p1pos = 0 end

	surface.SetMaterial(t7_hud_ammo_p1)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRectUV(w - 320*scale, h - 230*scale, 100*scale, 120*scale, 0 + p1pos*scale, 0, 0.33*scale + p1pos*scale, 1*scale)

	p2pos = p2pos + FrameTime()*0.1
	if p2pos > 1 then p2pos = 0 end

	surface.SetMaterial(t7_hud_ammo_p2)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRectUV(w - 320*scale, h - 230*scale, 100*scale, 120*scale, 0 + p2pos*scale, 0, 0.33*scale + p2pos*scale, 1*scale)

	p3pos = p3pos + FrameTime()*0.25
	if p3pos > 1 then p3pos = 0 end

	surface.SetMaterial(t7_hud_ammo_p3)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRectUV(w - 420*scale, h - 240*scale, 200, 156, 0 + p3pos, 0, 0.66 + p3pos, 1)

	//base
	surface.SetMaterial(t7_hud_dpad_base)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(w - 220*scale, h - 260*scale, 128*scale*1.5, 128*scale*1.6)
end

local function GunHud_t7()
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

	local dafont = "nz.ammo.bo3.big"
	local ammofont = "nz.ammo.bo3.main"
	local smallfont = "nz.ammo.bo3.wepname"
	local fontsmall = "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		dafont = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		ammofont = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
	end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor

	DoAnimatedHudBits()

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	//compass
	if nz_showcompass:GetBool() and (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then
		local angle = -ply:EyeAngles().y/360

		local hight = 195
		if nz_showhealth:GetBool() then
			hight = hight - 10
		end

		surface.SetMaterial(zmhud_dpad_compass)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectUV(45*scale, h - hight*scale, 256*scale*0.6, 64*scale*0.6, 0 + angle , 0, 0.5 + angle , 1)
	end

	//grenade hud
	if ply:ShouldDrawInventoryHUD() then
		local specialweps = ply.NZSpecialWeapons or {}
		local tacnade = specialweps["specialgrenade"]
		local grenade = specialweps["grenade"]
		local num = ply:GetAmmoCount(GetNZAmmoID("grenade") or -1)
		local numspecial = ply:GetAmmoCount(GetNZAmmoID("specialgrenade") or -1)

		if numspecial > 0 then
			local icon = t7_icon_grenade
			if tacnade and IsValid(tacnade) and tacnade.NZHudIcon then
				icon = tacnade.NZHudIcon_t7tomb or tacnade.NZHudIcon
			end

			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			for i = numspecial, 1, -1 do
				surface.SetDrawColor(ColorAlpha(color_t7_outline, 100/i*1.5))
				surface.DrawTexturedRect(w - 310*scale + (i*9*scale) - 4, h - 215*scale - (i*2*scale) - 4, 44*scale, 44*scale)

				surface.SetDrawColor(ColorAlpha(color_white, 200/i*1.5))
				surface.DrawTexturedRect(w - 310*scale + (i*9*scale), h - 215*scale - (i*2*scale), 36*scale, 36*scale)
			end
		end

		if num > 0 then
			local icon = t7_icon_grenade
			if grenade and IsValid(grenade) and grenade.NZHudIcon_t7 then
				icon = grenade.NZHudIcon_t7
			end

			surface.SetDrawColor(color_t7)
			surface.SetMaterial(icon)

			for i = num, 1, -1 do
				surface.SetDrawColor(ColorAlpha(color_t7_outline, 100/i*1.5))
				surface.DrawTexturedRect(w - 270*scale + (i*9*scale) - 4, h - 215*scale - (i*2*scale) - 4, 44*scale, 44*scale)

				surface.SetDrawColor(ColorAlpha(color_white, 200/i*1.5))
				surface.DrawTexturedRect(w - 270*scale + (i*9*scale), h - 215*scale - (i*2*scale), 36*scale, 36*scale)
			end
		end
	end

	//weapon hud
	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon or wep.NZSpecialCategory == "specialgrenade" then
			fontColor = Color(0, 255, 255, 255)
		end
		if wep.NZSpecialCategory == "specialist" then
			fontColor = Color(180, 0, 0, 255)
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, smallfont, w - 230*scale, h - 80*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", ammofont, w - 220*scale, h - 180*scale, color_t7, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 4, color_t7_outline)
		elseif (illegalspecials[wep.NZSpecialCategory] and not wep.NZSpecialShowHUD) then
			draw.SimpleTextOutlined(wep:GetPrintName(), smallfont, w - 230*scale, h - 80*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
		else
			if wep.Primary then
				local clip = wep.Primary.ClipSize
				local resclip = wep.Primary.DefaultClip
				local clip1 = wep:Clip1()

				local flashing_sin = math.abs(math.sin(CurTime()*4))
				local ammoType = wep:GetPrimaryAmmoType()
				local ammoTotal = ply:GetAmmoCount(ammoType)

				local outlineCol = Color(200, 40, 80, 10)
				local reserveoutCol = color_t7_ammo_outline
				local ammoCol = Color(255, 245, 245, 255)
				local reserveCol = color_t7_ammo
				local lowclip = false
				local lowammo = false

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

				if emptyclipdie and clip1 > 0 then
					emptycliptime = CurTime() + 1
					emptyclipdie = false
				end

				if clip and (clip > 1 or clip1 == 0) and clip1 <= math.ceil(clip/4) then
					lowclip = true

					if clip1 > 0 then
						ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
						ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
						ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
					else
						emptyclipdie = true
						ammoCol = color_red_200
					end

					outlineCol = color_red_10
				end
				if resclip and resclip > 0 and ammoTotal <= math.ceil(resclip/3) then
					lowammo = true
					reserveCol = color_red_255
					reserveoutCol = color_red_10
				end

				local ammolen = string.len(ammoTotal)
				local cliplen = string.len(clip1)

				flashing_sin = math.max(flashing_sin, 0.2)
				if clip and clip > 0 then
					surface.SetMaterial(t7_hud_ammo_glow)
					surface.SetDrawColor(lowclip and (ColorAlpha(color_white, 100*flashing_sin)) or color_white_150)
					surface.DrawTexturedRect(w - 390*scale, h - 240*scale, 140*scale, 140*scale)

					if ammoType == -1 then
						local xlipoffset = 0
						if cliplen >= 3 then xlipoffset = 10 end
						draw.SimpleTextOutlined(clip1, dafont, w - (300 - xlipoffset)*scale, h - 130*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, outlineCol)
					else
						draw.SimpleTextOutlined(clip1, dafont, w - 300*scale, h - 130*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, outlineCol)
						if resclip and resclip > 0 then
							draw.SimpleTextOutlined(ammoTotal, ammofont, w - 220*scale, h - 120*scale, color_t7_ammo, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, color_t7_outline)
						end
					end
				else
					//weapons that dont have a clip1 and use the ammo pool
					if resclip and resclip > 0 then
						surface.SetMaterial(t7_hud_ammo_glow)
						surface.SetDrawColor(lowammo and (ColorAlpha(color_white, 100*flashing_sin)) or color_white_150)
						surface.DrawTexturedRect(w - 385*scale, h - 240*scale, 140*scale, 140*scale)

						local ammooffset = 0
						if ammolen >= 3 then ammooffset = 10 end
						draw.SimpleTextOutlined(ammoTotal, dafont, w - (295 - ammooffset)*scale, h - 130*scale, reserveCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, reserveoutCol)
					end
				end
			end

			if wep.Secondary and (not wep.CanBeSilenced or (wep.CanBeSilenced and not wep:GetSilenced() and wep.Clip3)) then
				local clip2 = wep.Secondary.ClipSize
				local resclip2 = wep.Secondary.DefaultClip

				local flashing_sin = math.abs(math.sin(CurTime()*4))
				local ammoTotal2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType())
				local outlineCol = Color(200, 40, 80, 10)
				local reserveoutCol = color_t7_ammo_outline
				local ammoCol = Color(255, 245, 245, 255)
				local reserveCol = color_t7_ammo
				local lowclip = false
				local lowammo = false

				if emptyclip2die and wep:Clip2() > 0 then
					emptyclip2time = CurTime() + 1
					emptyclip2die = false
				end

				if clip2 and clip2 > 0 and wep:Clip2() <= math.ceil(clip2/4) then
					lowclip = true

					if wep:Clip2() > 0 then
						ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
						ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
						ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
						ammoCol.a = Lerp(flashing_sin, lerpcol_red.a, lerpcol_white.a)
					else
						emptyclip2die = true
						ammoCol = color_red_200
					end

					outlineCol = color_red_10
				end
				if resclip2 and resclip2 > 0 and ammoTotal2 <= math.ceil(resclip2/3) then
					lowammo = true
					reserveCol = color_red_255
					reserveoutCol = color_red_10
				end

				flashing_sin = math.max(flashing_sin, 0.2)
				if clip2 and clip2 > 0 then
					surface.SetMaterial(t7_hud_ammo_glow)
					surface.SetDrawColor(lowclip and (ColorAlpha(color_white, 100*flashing_sin)) or color_white_150)
					surface.DrawTexturedRect(w - 475*scale, h - 240*scale, 140*scale, 140*scale)

					draw.SimpleTextOutlined(wep:Clip2(), dafont, w - 385*scale, h - 130*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, outlineCol)
				else
					if ammoTotal2 and ammoTotal2 > 0 then
						surface.SetMaterial(t7_hud_ammo_glow)
						surface.SetDrawColor(lowammo and color_white_100 or color_white_150)
						surface.DrawTexturedRect(w - 475*scale, h - 240*scale, 140*scale, 140*scale)

						draw.SimpleTextOutlined(ammoTotal2, dafont, w - 385*scale, h - 130*scale, reserveCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 4, reserveoutCol)
					end
				end
			end

			if emptycliptime > CurTime() then
				local alphascale = 1 - math.Clamp((emptycliptime - CurTime()) / 1, 0, 1)
				if alphascale > 0.5 then
					alphascale = math.Clamp((emptycliptime - CurTime()) / 1, 0, 1)
				end

				surface.SetMaterial(t7_hud_ammo_panelglow)
				surface.SetDrawColor(ColorAlpha(color_t7, 150*alphascale))
				surface.DrawTexturedRect(w - 335*scale - (52*scale), h - 180*scale - (52*scale), 104*scale, 104*scale)

				cwimage("nz_moo/huds/t7/sparks_bw/" .. (math.ceil(CurTime()*30) % 28) .. ".png", w - 324*scale, h - 200*scale, 108*scale*1.4, 168*scale*1.4, ColorAlpha(color_t7, 450*alphascale))
			end
			if emptyclip2time > CurTime() then
				local alphascale = 1 - math.Clamp((emptyclip2time - CurTime()) / 1, 0, 1)
				if alphascale > 0.5 then
					alphascale = math.Clamp((emptyclip2time - CurTime()) / 1, 0, 1)
				end

				surface.SetMaterial(t7_hud_ammo_panelglow)
				surface.SetDrawColor(ColorAlpha(color_t7, 150*alphascale))
				surface.DrawTexturedRect(w - 420*scale - (52*scale), h - 180*scale - (52*scale), 104*scale, 104*scale)

				cwimage("nz_moo/huds/t7/sparks_bw/" .. (math.ceil(CurTime()*30) % 28) .. ".png", w - 409*scale, h - 200*scale, 108*scale*1.4, 168*scale*1.4, ColorAlpha(color_t7, 450*alphascale))
			end

			//silencer/underbarrel/altattack hud
			if wep.CanBeSilenced then
				local icon = t7_icon_underbarrel
				if wep.NZHudIcon_t7tomb or wep.NZHudIcon then
					icon = wep.NZHudIcon_t7tomb or wep.NZHudIcon
				end
				if not icon or icon:IsError() then
					icon = zmhud_icon_missing
				end

				if wep.NZPickedUpTime and (wep.NZPickedUpTime + 5 > CurTime() or fade_ammo > 0) then
					fade_ammo_acc = fade_ammo_acc + FrameTime()*2
					fade_ammo = math.abs(math.sin(fade_ammo_acc))
					if wep.NZPickedUpTime + 5 < CurTime() and fade_ammo < 0.1 then
						fade_ammo = 0
						fade_ammo_acc = 0
					end

					surface.SetMaterial(t7_hud_score)
					surface.SetDrawColor(ColorAlpha(color_t7, 255*fade_ammo))
					surface.DrawTexturedRect(w - 224*scale, h - 198*scale, 72*scale, 72*scale)
				end

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_t7_tomb)
				surface.DrawTexturedRect(w - 211*scale, h - 181*scale, 48*scale, 48*scale)

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_white_150)
				surface.DrawTexturedRect(w - 208*scale, h - 178*scale, 42*scale, 42*scale)

				local ammoTotal2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType()) + (wep.Clip3 and wep:Clip3() or wep:Clip2())
				if ammoTotal2 > 0 then
					draw.SimpleTextOutlined(ammoTotal2, (fontsmall), w - 180*scale, h - 120*scale, color_t7, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_t7_outline)
				end
			end

			draw.SimpleTextOutlined(wep:GetPrintName(), (smallfont), w - 230*scale, h - 80*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)

			local aat = wep:GetNW2String("nzAATType", "")
			if aat ~= "" then
				local fade = 255
				if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then
					fade = 90
				end

				surface.SetMaterial(nzAATs:Get(aat).icon)
				surface.SetDrawColor(ColorAlpha(color_white, fade))
				surface.DrawTexturedRect(w - 148*scale - (72*scale), h - 72*scale, 48*scale, 48*scale)

				local aatcol = nzAATs:Get(aat).color
				draw.SimpleTextOutlined(nzAATs:Get(aat).name, (smallfont), w - 230*scale, h - 36*scale, aatcol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, ColorAlpha(aatcol, 10))
			end

			/*if nz_showgun:GetBool() and killicon.Exists(class) then
				surface.SetFont(smallfont)
				local tw, th = surface.GetTextSize(wep:GetPrintName())
				killicon.Draw(w - 230*scale - (64*scale) - tw, h - 80*scale - (32*scale), class, 255)
			end*/

			if ply:HasPerk("mulekick") then
				surface.SetDrawColor(color_white_50)
				if IsValid(wep) and wep:GetNWInt("SwitchSlot") == 3 then
					surface.SetDrawColor(color_white)
				end
				surface.SetMaterial(GetPerkIconMaterial("mulekick", true))
				surface.DrawTexturedRect(w - 240*scale, h - 265*scale, 35*scale, 35*scale)
			end
		end
	end
end

local function PerksMMOHud_t7()
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
		surface.DrawTexturedRect(w - 240*scale - (40*traycount*scale), h - 265*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial(true))
			surface.DrawTexturedRect(w - 240*scale - (40*traycount*scale), h - 265*scale, 35*scale, 35*scale)
		end

		if mmohud.style == "toggle" then
		elseif mmohud.style == "count" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0), ChatFont, w - 205*scale - (40*traycount*scale), h - 225*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
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
				draw.SimpleTextOutlined(perkpercent.."%", ChatFont, w - 205*scale - (40*traycount*scale), h - 225*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
			end
		elseif mmohud.style == "chance" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0).."/"..mmohud.max, ChatFont, w - 205*scale - (40*traycount*scale), h - 225*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end

		traycount = traycount + 1
	end
end

local perkcount = 0
local perkflashtime = 0
local stinkfade = 0
local function PerksHud_t7()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPerksHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local scale = (ScrW()/1920 + 1)/2
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
	local w = ScrW()/1920 + (206*scale)
	local h = ScrH()
	local size = 50

	if nz_showhealth:GetBool() then
		w = w + (64*scale)
		if nz_showcompass:GetBool() and nz_showzcounter:GetBool() then
			w = w + (6*scale)
		end
	elseif nz_showcompass:GetBool() and nz_showzcounter:GetBool() then
		w = w + (70*scale)
	end

	local num = 0
	local row = 0
	local num_b = 0
	local row_b = 0
	local rowmod = nz_perkrowmod:GetInt()

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
				surface.DrawTexturedRect(w + num_b*(size + 6)*scale, h - 100*scale - (64*row_b)*scale, 54*scale, 54*scale)
			end

			if modded then
				modded = false
				surface.SetDrawColor(color_white_100)
			end

			num_b = num_b + 1
			if num_b%(rowmod) == 0 then
				row_b = row_b + 1
				num_b = 0
			end
		end
	end

	if perkcount < #perks and perkflashtime < CurTime() then
		perkflashtime = CurTime() + 1
		perkcount = math.Approach(perkcount, #perks, 1)
	end

	if !ply:Alive() and perkcount ~= 0 then
		perkcount = 0
		perkflashtime = 0
	end

	if perkflashtime > CurTime() then
		local alpha = 1 - math.Clamp((perkflashtime - CurTime()) / 1, 0, 1)
		if alpha > 0.5 then
			alpha = math.Clamp((perkflashtime - CurTime()) / 1, 0, 1)
		end
		local flashrow = perkcount > rowmod and math.floor(perkcount/rowmod) or 0
		local flashcount = perkcount > rowmod and perkcount%(rowmod) or perkcount

		cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", (w + 46*scale) + ((flashcount-1)*(size + 6))*scale, h - 154*scale - 64*flashrow, 168*scale*0.8, 252*scale*0.8, ColorAlpha(color_t7_sparks, 255*alpha))

		surface.SetMaterial(t7_hud_score)
		surface.SetDrawColor(ColorAlpha(color_t7, 200*alpha))
		surface.DrawTexturedRect((w - 40*scale) + ((flashcount-1)*(size + 6))*scale, h - 148*scale - 64*flashrow, 128*scale, 128*scale)
	end

	for i, perk in pairs(perks) do
		local icon = GetPerkIconMaterial(perk)
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		local alpha = 1
		if perks[perkcount] == perk and perkflashtime > CurTime() then
			alpha = 1 - math.Clamp((perkflashtime - CurTime()) / 1, 0, 1)
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
					fuckset = 5.4*math.Remap(wave, 0, 1, 0, 1)
				end
			end
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(alpha < 1 and ColorAlpha(perkcolor, 800*alpha) or perkcolor)
		surface.DrawTexturedRect(w + num*(size + 6)*scale - fuckset*scale, h - (100 + fuckset)*scale - (64*row)*scale, 54*pulse*scale, 54*pulse*scale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 6)*scale - fuckset*scale, h - (100 + fuckset)*scale - (64*row)*scale, 54*pulse*scale, 54*pulse*scale)
		end

		if perk == "vulture" then
			if ply:HasVultureStink() then
				stinkfade = 1
			end

			if stinkfade > 0 then
				surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))

				surface.SetMaterial(zmhud_vulture_glow)
				surface.DrawTexturedRect((w + num*(size + 6)*scale) - 24*scale, (h - 100*scale - (64*row)*scale) - 24*scale, 102*scale, 102*scale)
				
				local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
				surface.SetTexture(stink)
				surface.DrawTexturedRect((w + num*(size + 6)*scale), (h - 100*scale - (64*row)*scale) - 62*scale, 64*scale, 64*scale)
			
				stinkfade = math.max(stinkfade - FrameTime()*3, 0)
			end
		end

		num = num + 1
		if num%(rowmod) == 0 then
			row = row + 1
			num = 0
		end
	end
end

--[[ JEN WALTER'S ROUND COUNTER ]]--

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
	local scale = (ScrW()/1920 + 1)/2
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

local function RoundHud_t7()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawRoundHUD() then return end
	if ply:IsNZMenuOpen() then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2

	if round_posdata["intro"] then
		if round_posdata["time"] - 4 < CurTime() then
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

		round_posdata[1] = Lerp(kysratio, 10, w/2 - 18*scale)
		round_posdata[2] = Lerp(kysratio, 140, h/2)
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
		local hi = T and (round_posdata[2] + 5) or round_posdata[2]
		if nz_showcompass:GetBool() and !round_posdata["intro"] then
			hi = hi - 10
		end

		if timer > 3 then
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectUV(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, (T and tallysize or digitsize.y) * (4-timer), 0, 0, 1, 4-timer)
		elseif timer > 2 then
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,255,99,255*(3-timer)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif timer > 1 and !v.fade then
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(Color(255,255,255,255*(2-timer)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["burnt"][v.image])
			surface.SetDrawColor(Color(255,255,255,1024*(timer-1)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,80 + (175*(timer-1)),99*(timer-1)))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif timer > 0 and !v.fade then
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			surface.SetMaterial(roundassets["heat"][v.image])
			surface.SetDrawColor(Color(255,80,0,255*timer))
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
		elseif v.fade then
			local fade_colora = ColorAlpha(color_white, 255*timer)
			local fade_colorb = ColorAlpha(color_white, 255*(1-timer))

			if timer > 1 then
				surface.SetMaterial(roundassets["normal"][v.image])
				surface.SetDrawColor(fade_colora)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(fade_colorb)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			else
				surface.SetMaterial(roundassets["burnt"][v.image])
				surface.SetDrawColor(fade_colora)
				surface.DrawTexturedRectUV(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y, 0, 0, 1, 1 - math.sin(math.pi*(0.5 + timer/2)))
			end
		else
			surface.SetMaterial(roundassets["normal"][v.image])
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
			if nzRound:InState(ROUND_PREP) then
				local prep_color = ColorAlpha(color_white, 127.5 + (127.5*math.sin(CurTime()*8)))

				surface.SetMaterial(roundassets["heat"][v.image])
				surface.SetDrawColor(prep_color)
				surface.DrawTexturedRect(round_posdata[1] + (T and 0 or offset), h - hi, T and tallysize or digitsize.x, T and tallysize or digitsize.y)
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
						cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", X + (x1*(1-mod3)) + (x2*mod3) + (33*SIZE), h - Y*scale + (y1*(1-mod3)) + (y2*mod3) - (84*SIZE), 168 * SIZE, 252 * SIZE, spark_color)
					elseif b[mod1] then
						cwimage("rf/round/sparks/" .. (math.ceil(CurTime()*30) % 20) .. ".png", X + (b[mod1][1] * (T and tallycoordmult or 1)) + (33*SIZE), h - Y*scale + (b[mod1][2] * (T and tallycoordmult or 1)) - (84*SIZE), 168 * SIZE, 252 * SIZE, spark_color)
					end
				end
			end
		end
	end

	if !busysparks then sparkdata = {} end
end

local prevroundspecial = false

local function StartChangeRound_t7()
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

local function EndChangeRound_t7()
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

local function ResetRound_t7()
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

local function PlayerHealthHUD_t7()
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

	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()

	local healthscale = math.Clamp(health / maxhealth, 0, 1)

	surface.SetDrawColor(color_black_180)
	surface.DrawRect(w/1920 + (113*scale), h - 213*scale, 157*scale, 9*scale)

	surface.SetDrawColor(color_white)
	surface.DrawRect(w/1920 + (115*scale), h - 211*scale, 152*scale, 5*scale)

	surface.SetDrawColor(color_health)
	surface.DrawRect(w/1920 + (115*scale), h - 211*scale, 152*healthscale*scale, 5*scale)

	local armor = ply:Armor()
	if armor > 0 then
		local maxarmor = ply:GetMaxArmor()
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/1920 + (113*scale), h - 203*scale, 157*scale, 9*scale)

		surface.SetDrawColor(color_white)
		surface.DrawRect(w/1920 + (115*scale), h - 201*scale, 152*scale, 5*scale)

		surface.SetDrawColor(color_armor)
		surface.DrawRect(w/1920 + (115*scale), h - 201*scale, 152*armorscale*scale, 5*scale)
	end
end

local function PlayerStaminaHUD_t7()
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

	local stamina = ply:GetStamina()
	local maxstamina = ply:GetMaxStamina()
	local fade = maxstamina*0.12 //lower the number, faster the fade in

	local staminascale = math.Clamp(stamina / maxstamina, 0, 1)
	local stamalpha = 1 - math.Clamp((stamina - maxstamina + fade) / fade, 0, 1)
	local staminacolor = ColorAlpha(color_white, 255*stamalpha)

	if stamina < maxstamina then
		surface.SetDrawColor(staminacolor)
		if ply:Armor() > 0 then
			surface.DrawRect(w/1920 + (46*scale), h - 191*scale, 152*staminascale*scale, 4*scale)
		else
			surface.DrawRect(w/1920 + (115*scale), h - 201*scale, 152*staminascale*scale, 5*scale)
		end
	end
end

local function ZedCounterHUD_t7()
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
	local wr = 64*scale
	if nz_showcompass:GetBool() then
		wr = wr + 152*scale
	end

	surface.SetDrawColor(ColorAlpha(color_t7_outline, 20))
	surface.SetMaterial(t7_hud_score)
	surface.DrawTexturedRect(wr - 36*scale, h - 202 * scale, 142*scale, 64*scale)

	surface.SetDrawColor(ColorAlpha(color_t7_outline, 80))
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr - 2*scale, h - 186*scale, 36*scale, 36*scale)

	surface.SetDrawColor(color_t7)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr, h - 184*scale, 33*scale, 33*scale)

	local smallfont = "nz.ammo.bo3.wepname"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo."..GetFontType(nzMapping.Settings.smallfont)
	end

	draw.SimpleTextOutlined(GetGlobal2Int("AliveZombies", 0), smallfont, wr + 36, h - (170*scale), color_t7, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_t7_outline)
end

-- Hooks
hook.Add("HUDPaint", "nzHUDswapping_t7_tomb", function()
	if nzMapping.Settings.hudtype == "Origins (HD)" then
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD_t7 )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD_t7 )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud_t7 )
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud_t7 )
		hook.Add("HUDPaint", "perksHUD", PerksHud_t7 )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud_t7 )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud_t7 )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD_t7 )
		hook.Add("HUDPaint", "zedcounterHUD", ZedCounterHUD_t7 )

		hook.Add("OnRoundPreparation", "BeginRoundHUDChange", StartChangeRound_t7 )
		hook.Add("OnRoundStart", "EndRoundHUDChange", EndChangeRound_t7 )
		hook.Add("OnRoundEnd", "GameEndHUDChange", ResetRound_t7 )
	end
end)

//--------------------------------------------------/Rudy, GhostlyMoo and Fox's Origins HUD\------------------------------------------------\\
