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

local voiceloopback = GetConVar("voice_loopback")
local cl_drawhud = GetConVar("cl_drawhud")
local sv_clientpoints = GetConVar("nz_point_notification_clientside")
local nz_clientpoints = GetConVar("nz_hud_clientside_points")

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
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")
local nz_powerupstyle = GetConVar("nz_hud_powerup_style")

local nz_aatstyle = GetConVar("nz_hud_aat_style")
local nz_aatcolor = GetConVar("nz_hud_aat_textcolor")
local nz_perkrowmod = GetConVar("nz_hud_perk_row_modulo")
local nz_mapfont = GetConVar("nz_hud_use_mapfont")
local nz_healthbarstyle = GetConVar("nz_hud_health_style")
local nz_bleedoutstyle = GetConVar("nz_hud_bleedout_style")
local nz_bleedouttime = GetConVar("nz_downtime")

local color_white_50 = Color(255, 255, 255, 50)
local color_white_100 = Color(255, 255, 255, 100)
local color_white_150 = Color(255, 255, 255, 150)
local color_white_200 = Color(255, 255, 255, 200)
local color_black_180 = Color(0, 0, 0, 180)
local color_black_100 = Color(0, 0, 0, 100)
local color_black_50 = Color(0, 0, 0, 50)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_255 = Color(255, 0, 0, 255)

local color_grey_100 = Color(100,100,100,255)
local color_grey = Color(240, 240, 240, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(255, 190, 100, 255)
local color_health = Color(255, 120, 120, 255)
local color_empty = Color(255, 70, 70, 255)

local color_wonderweapon = Color(0, 255, 255, 255)
local color_specialist = Color(180, 0, 0, 255)
local color_trap = Color(255, 180, 20, 255)

local color_blood = Color(60, 0, 0, 255)
local color_blood_score = Color(120, 0, 0, 255)

local color_points1 = Color(255, 200, 0, 255)
local color_points2 = Color(100, 255, 70, 255)
local color_points4 = Color(255, 0, 0, 255)

//--------------------------------------------------/GhostlyMoo and Fox's W@W-ish HUD\------------------------------------------------\\
//waw hud
local cod5_hud_score_1 = Material("nz_moo/huds/cod5/scorebar_zom_1.png", "unlitgeneric smooth")
local cod5_hud_score_2 = Material("nz_moo/huds/cod5/scorebar_zom_2.png", "unlitgeneric smooth")
local cod5_hud_score_3 = Material("nz_moo/huds/cod5/scorebar_zom_3.png", "unlitgeneric smooth")
local cod5_hud_score_4 = Material("nz_moo/huds/cod5/scorebar_zom_4.png", "unlitgeneric smooth")

local cod5_hud_healthbar = Material("nz_moo/icons/t5hud_healthbar.png", "unlitgeneric smooth")
local cod5_hud_health = Material("nz_moo/huds/cod5/damage_feedback_extrahealth.png", "unlitgeneric smooth")
local cod5_hud_shield = Material("nz_moo/huds/cod5/damage_feedback_flak_jacket.png", "unlitgeneric smooth")

local cod5_hud_compass = Material("nz_moo/huds/cod5/hud_compass_face.png", "unlitgeneric smooth")
local cod5_hud_compass_ring = Material("nz_moo/huds/cod5/hud_compass_rim.png", "unlitgeneric smooth")
local cod5_hud_compass_back = Material("nz_moo/huds/cod5/hud_pby_compass_face.png", "unlitgeneric smooth")

//waw inventory
local cod5_icon_shield = Material("nz_moo/huds/t5/uie_t5hud_icon_shield.png", "unlitgeneric smooth")
local cod5_icon_special = Material("nz_moo/huds/t5/uie_t5hud_icon_grenade_launcher.png", "unlitgeneric smooth")
local cod5_icon_grenade = Material("nz_moo/huds/cod5/hud_fraggrenade.png", "unlitgeneric smooth")
local cod5_icon_semtex = Material("nz_moo/huds/t5/hud_sticky_grenade.png", "unlitgeneric smooth")
local cod5_icon_trap = Material("nz_moo/huds/t5/zom_icon_trap_switch_handle.png", "unlitgeneric smooth")
local cod5_icon_shovel = Material("nz_moo/huds/t6/zom_hud_craftable_tank_shovel.png", "unlitgeneric smooth")
local cod5_icon_shovel_gold = Material("nz_moo/huds/t6/zom_hud_shovel_gold.png", "unlitgeneric smooth")

//universal
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
local zmhud_icon_zedcounter = Material("nz_moo/icons/ugx_talkballoon.png", "unlitgeneric smooth")

local illegalspecials = {
	["specialgrenade"] = true,
	["grenade"] = true,
	["knife"] = true,
	["display"] = true,
}

local function StatesHud_cod5()
	if cl_drawhud:GetBool() and !nzRound:InProgress() then
		local text = ""
		local font = "nz.main.waw"
		if nz_mapfont:GetBool() then
			font = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		end

		local w, h = ScrW(), ScrH()
		local pscale = (w/1920 + 1) / 2

		if nzRound:InState(ROUND_WAITING) then
			text = "Waiting for players. Type /ready to ready up."
			font = "nz.small.waw"
			if nz_mapfont:GetBool() then
				font = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
			end
		elseif nzRound:InState(ROUND_CREATE) then
			text = "Creative Mode"
		end

		local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor
		draw.SimpleTextOutlined(text, font, w/2, 60*pscale, fontColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
	end
end

local PointsNotifications = {}
local function PointsNotification(ply, amount, profit_id)
	if not IsValid(ply) then return end
	local data = {ply = ply, amount = amount, diry = math.random(-25, 25), time = CurTime(), profit = profit_id}
	table_insert(PointsNotifications, data)
end

net.Receive("nz_points_notification_waw", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	local profit_id = net.ReadInt(9)
	PointsNotification(ply, amount, profit_id)
end)

local Circles = {
	[1] = {r = -1, col = Color(255,200,0,100)},
	[2] = {r = 0, col = Color(255,255,0,100)},
	[3] = {r = 1, col = Color(255,200,0,100)},
}

local function DrawGumCircle( X, Y, target_radius, value)
	local endang = 360 * value
	if endang == 0 then return end

	for i = 1, #Circles do
		local data = Circles[ i ]
		local radius = target_radius + data.r
		local segmentdist = endang / ( math.pi * radius / 3 )

		for a = 0, endang, segmentdist do
			surface.SetDrawColor(data.col)
			surface.DrawLine( X + math.sin( -math.rad( a ) ) * radius, Y - math.cos( math.rad( a ) ) * radius, X + math.sin( -math.rad( a + segmentdist ) ) * radius, Y - math.cos( math.rad( a + segmentdist ) ) * radius )
		end
	end
end

local visual_prgr = 1
local last_prgr_changetime = 0
local last_prgr = 1
local last_gum

local function SmoothProgress(progress)
	local ct = CurTime()
	if progress != last_prgr then
		last_prgr_changetime = ct
		last_prgr = progress
	end

	if progress > visual_prgr then
		visual_prgr = progress
	end

	if visual_prgr != progress and ct < last_prgr_changetime + 1 then
		local step = math.ease.OutSine(ct - last_prgr_changetime)
		if step >= 1 then
			visual_prgr = progress
		else
			progress = Lerp(step, visual_prgr, progress)
		end
	else
		visual_prgr = progress
	end

	return progress
end

//Equipment
local function InventoryHUD_cod5()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local smallfont =  "nz.points.waw"
	local ammo2font =  "nz.ammo2.waw"
	if nz_mapfont:GetBool() then
		smallfont = "nz.points."..GetFontType(nzMapping.Settings.mediumfont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.mediumfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local plyweptab = ply:GetWeapons()
	local lowres = scale < 0.86

	local nz_key_trap = GetConVar("nz_key_trap")
	local nz_key_shield = GetConVar("nz_key_shield")
	local nz_key_specialist = GetConVar("nz_key_specialist")
	local nz_key_gum = GetConVar("nz_key_gum")
	local tfa_key_silence = GetConVar("cl_tfa_keys_silencer")

	local gumid = nzGum:GetActiveGum(ply) or last_gum
	if gumid and gumid ~= "" then
		local gum = nzGum.Gums[gumid]

		local icon = gum.icon
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w/2 - 32*scale, h - 96*scale, 64*scale, 64*scale)

		local uses = nzGum:UsesRemain(ply)
		local progress = 1
		if gum.uses then
			progress = nzGum:UsesRemain(ply) / gum.uses
		end

		if gum.type == nzGum.Types.USABLE or gum.type == nzGum.Types.SPECIAL then
			if gum.uses then
				progress = nzGum:UsesRemain(ply) / gum.uses
			end

			progress = SmoothProgress(progress)
		elseif gum.type == nzGum.Types.USABLE_WITH_TIMER then
			local timeleft = nzGum:TimerTimeLeft(ply)
			local usesremain = nzGum:UsesRemain(ply)
			if timeleft and nzGum:IsWorking(ply) then
				local fuckery = (usesremain - 1) / gum.uses

				local time_pgrs_left = 1 - (CurTime() - timeleft) / gum.time
				if time_pgrs_left > 0 then
					progress = fuckery + math.Remap(time_pgrs_left, 0, 1, 0, (1 / gum.uses))
				end
			else
				progress = usesremain / gum.uses
				//progress = SmoothProgress(progress)
			end
		elseif gum.type == nzGum.Types.ROUNDS then
			progress = nzGum:RoundsRemain(ply) / gum.rounds

			progress = SmoothProgress(progress)
		elseif gum.type == nzGum.Types.TIME then
			local timeleft = nzGum:TimerTimeLeft(ply)
			if timeleft then
				progress = (1 - (CurTime() - timeleft) / gum.time)
			end
		end

		if progress > 0 or uses > 0 then
			DrawGumCircle(w/2, h - 64*scale, 34*scale, 1*progress)

			if (nzGum:IsUseBaseGum(ply) or nzGum:IsRoundBaseGum(ply)) then
				local rounds = nzGum:RoundsRemain(ply)
				if rounds > 0 then
					uses = rounds
				end
			end

			if gum.uses or gum.rounds then
				draw.SimpleTextOutlined(uses, lowres and ammo2font or smallfont, w/2 + 25, h - (lowres and 34 or 24)*scale, uses == 0 and color_empty or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, uses > 0 and color_black_50 or ColorAlpha(color_empty, 5))
			end

			if nz_key_gum then
				local gumkey = nz_key_gum:GetInt() > 0 and nz_key_gum:GetInt() or 1
				draw.SimpleTextOutlined("["..string_upper(input_getkeyname(gumkey)).."]", smallfont, (w/2), h, input_isbuttondown(gumkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
			end

			if last_gum != gumid then
				last_gum = gumid
			end
		else
			last_gum = ""
		end
	end

	// Special Weapon Categories
	for _, wep in pairs(plyweptab) do
		// Traps
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "trap" then
			local icon = cod5_icon_trap
			if wep.NZHudIcon then
				icon = wep.NZHudIcon_cod5 or wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w/2 + 160*scale, h - 96*scale, 64*scale, 64*scale)

			local ammo = wep:GetPrimaryAmmoType()
			if ammo > 0 and not wep.TrapCanBePlaced then
				local ammocount = ply:GetAmmoCount(ammo) + wep:Clip1()
				draw.SimpleTextOutlined(ammocount, lowres and ammo2font or smallfont, w/2 + 214*scale, h - (lowres and 34 or 24)*scale, ammocount == 0 and color_empty or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, ammocount > 0 and color_black_50 or ColorAlpha(color_empty, 5))

				if (ammocount > 0 or wep.NZTrapSwitchEmpty) and nz_key_trap then
					local trapkey = nz_key_trap:GetInt() > 0 and nz_key_trap:GetInt() or 1
					draw.SimpleTextOutlined("["..string_upper(input_getkeyname(trapkey)).."]", smallfont, (w/2 + 192*scale), h, input_isbuttondown(trapkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				end
			else
				if nz_key_trap then
					local trapkey = nz_key_trap:GetInt() > 0 and nz_key_trap:GetInt() or 1
					draw.SimpleTextOutlined("["..string_upper(input_getkeyname(trapkey)).."]", smallfont, (w/2 + 192*scale), h, input_isbuttondown(trapkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				end
			end
		end

		// Specialists
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
			local icon = cod5_icon_special
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w/2 + 64, h - 96*scale, 64*scale, 64*scale)

			local clip = wep:Clip1()
			local clip1 = wep.Primary_TFA.ClipSize
			if clip1 > 0 then
				local clipscale = math.Round(math.Clamp(clip / clip1, 0, 1)*100)
				draw.SimpleTextOutlined(clipscale, lowres and ammo2font or smallfont, w/2 + 96*scale, h - (lowres and 34 or 24)*scale, clip == 0 and color_empty or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, clip > 0 and color_black_50 or ColorAlpha(color_empty, 5))

				if clip >= clip1 and nz_key_specialist then
					local specialkey = nz_key_specialist:GetInt() > 0 and nz_key_specialist:GetInt() or 1
					draw.SimpleTextOutlined("["..string_upper(input_getkeyname(specialkey)).."]", smallfont, (w/2 + 96*scale), h, input_isbuttondown(specialkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				end
			else
				if nz_key_specialist then
					local specialkey = nz_key_specialist:GetInt() > 0 and nz_key_specialist:GetInt() or 1
					draw.SimpleTextOutlined("["..string_upper(input_getkeyname(specialkey)).."]", smallfont, (w/2 + 96*scale), h, input_isbuttondown(specialkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				end
			end
		end

		// Shield Slot Occupier
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "shield" and wep.NZHudIcon and not wep.ShieldEnabled then
			local icon = cod5_icon_shield
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w/2 - 128*scale), h - 96*scale, 64*scale, 64*scale)

			if nz_key_shield then
				local shieldkey = nz_key_shield:GetInt() > 0 and nz_key_shield:GetInt() or 1
				draw.SimpleTextOutlined("["..string_upper(input_getkeyname(shieldkey)).."]", smallfont, (w/2 - 96*scale), h, input_isbuttondown(shieldkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
			end
		end
	end

	// Shield
	if ply.GetShield and IsValid(ply:GetShield()) then
		local shield = ply:GetShield()
		local wep = shield:GetWeapon()

		local icon = cod5_icon_shield
		if IsValid(wep) and wep.NZHudIcon then
			icon = wep.NZHudIcon
		end
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((w/2 - 128*scale), h - 96*scale, 64*scale, 64*scale)

		if wep.Secondary and wep.Secondary.ClipSize > 0 then
			local clip2 = wep:Clip2()
			local clip2rate = wep.Secondary.AmmoConsumption
			local clip2i = math.floor(clip2/clip2rate)

			draw.SimpleTextOutlined(clip2i, lowres and ammo2font or smallfont, w/2 - 72*scale, h - (lowres and 34 or 24)*scale, clip2 > 0 and color_white or color_empty, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, clip2 > 0 and color_black_50 or ColorAlpha(color_empty, 5))
		end

		if nz_key_shield then
			local shieldkey = nz_key_shield:GetInt() > 0 and nz_key_shield:GetInt() or 1
			draw.SimpleTextOutlined("["..string_upper(input_getkeyname(shieldkey)).."]", smallfont, (w/2 - 96*scale), h, input_isbuttondown(shieldkey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
		end
	end
end

local scoreboardtypes = {
	cod5_hud_score_1,
	cod5_hud_score_2,
	cod5_hud_score_3,
	cod5_hud_score_4
}

local function GetScoreHudByIndex(index)
	return scoreboardtypes[((index - 1) % #scoreboardtypes) + 1]
end

local function ScoreHud_cod5()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local fontmain = "nz.pointsmain.waw"
	local fontsmall = "nz.points.waw"
	local ammo2font =  "nz.ammo2.waw"
	local fontnade = "nz.grenade"
	if nz_mapfont:GetBool() then
		fontmain = "nz.pointsmain."..GetFontType(nzMapping.Settings.ammofont)
		fontsmall = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local offset = -20
	if not nz_healthbarstyle:GetBool() and nz_showhealth:GetBool() then
		offset = 0*scale
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local index = ply:EntIndex()
	local pcolor = player.GetColorByIndex(index)
	local blood = GetScoreHudByIndex(index)
	if nz_useplayercolor:GetBool() then
		local pvcol = ply:GetPlayerColor()
		pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
	end

	//points
	surface.SetFont(fontsmall)
	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(blood)
	surface.DrawTexturedRect(w - 235*scale, h - 245*scale - offset, 220*scale, 50*scale)

	draw.SimpleTextOutlined(ply:GetPoints(), fontsmall, w - 220*scale, h - (214*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)
	ply.PointsSpawnPosition = {x = w - 245*scale, y = h - (214*scale) - offset}

	//icon
	if nz_showportrait:GetBool() then
		local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")
		if not pmpath or pmpath:IsError() then
			pmpath = zmhud_icon_missing
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(w - 60*scale, h - 245*scale - offset, 48*scale, 48*scale)

		surface.SetDrawColor(pcolor)
		surface.DrawOutlinedRect(w - 60*scale, h - 245*scale - offset, 50*scale, 50*scale, 2)
	end

	//shovel
	if ply.GetShovel and IsValid(ply:GetShovel()) then
		local pshovel = ply:GetShovel()

		surface.SetMaterial(pshovel:IsGolden() and cod5_icon_shovel_gold or cod5_icon_shovel)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - (90*scale), h - (226*scale) - offset, 32*scale, 32*scale)
	end

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
			if ply:IsMuted() then
				icon = zmhud_icon_voiceoff
			end
			if not voiceloopback:GetBool() then
				icon = zmhud_icon_voiceon
			end

			surface.SetFont(fontsmall)
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 215*scale) - 32, h - (260*scale) - offset - 16, 32, 32)
		end

		draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (255*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)

		offset = offset + 25 //nickname offset buffer
	end

	offset = offset + 45*scale

	local plytab = player.GetAll()
	for k, v in ipairs(plytab) do
		if v == ply then continue end
		local index = v:EntIndex()
		local pcolor = player.GetColorByIndex(index)
		local blood = GetScoreHudByIndex(index)
		if nz_useplayercolor:GetBool() then
			local pvcol = v:GetPlayerColor()
			pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		end

		if nz_showhealthmp:GetBool() then
			offset = offset + 25*scale //health bar offset buffer
		end

		//points
		surface.SetFont(fontsmall)
		surface.SetDrawColor(color_blood_score)
		surface.SetMaterial(blood)
		surface.DrawTexturedRect(w - 225*scale, h - 245*scale - offset, 210*scale, 40*scale)

		draw.SimpleTextOutlined(v:GetPoints(), fontsmall, w - 215*scale, h - (220*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)
		v.PointsSpawnPosition = {x = w - 240*scale, y = h - (220*scale) - offset}

		//icon
		if nz_showportrait:GetBool() then
			local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")
			if not pmpath or pmpath:IsError() then
				pmpath = zmhud_icon_missing
			end

			surface.SetDrawColor(color_white)
			surface.SetMaterial(pmpath)
			surface.DrawTexturedRect(w - 60*scale, h - 250*scale - offset, 40*scale, 40*scale)

			surface.SetDrawColor(pcolor)
			surface.DrawOutlinedRect(w - 60*scale, h - 250*scale - offset, 42*scale, 42*scale, 2)
		end

		//shovel
		if v.GetShovel and IsValid(v:GetShovel()) then
			local pshovel = v:GetShovel()

			surface.SetMaterial(pshovel:IsGolden() and cod5_icon_shovel_gold or cod5_icon_shovel)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - (90*scale), h - (240*scale) - offset, 32*scale, 32*scale)
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

		if nz_showhealthmp:GetBool() then
			local lowres = scale < 0.96
			local phealth = v:Health()
			local pmaxhealth = v:GetMaxHealth()
			local phealthscale = math.Clamp(phealth / pmaxhealth, 0, 1)

			surface.SetMaterial(cod5_hud_healthbar)
			surface.SetDrawColor(color_blood)
			surface.DrawTexturedRectUV(w - 222*scale, h - 204*scale - offset, 264*0.8*scale, 32*0.6*scale, 0, 0, 1, 1)

			surface.SetMaterial(cod5_hud_healthbar)
			surface.SetDrawColor(color_blood_score)
			surface.DrawTexturedRectUV(w - 218*scale, h - 202*scale - offset, 256*0.8*phealthscale*scale, 24*0.6*scale, 0, 0, 1*phealthscale, 1)

			if nz_showhealthmp:GetInt() > 1 then
				draw.SimpleTextOutlined(phealth, ammo2font, w - 200*scale, h - 194*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
			end

			local armor = v:Armor()
			if armor > 0 then
				local maxarmor = v:GetMaxArmor()
				local armorscale = math.Clamp(armor / maxarmor, 0, 1)

				surface.SetMaterial(cod5_hud_shield)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w - 248*scale, h - 210*scale - offset, 28*scale, 28*scale)

				surface.SetMaterial(cod5_hud_shield)
				surface.SetDrawColor(color_armor)
				surface.DrawTexturedRectUV(w - 248*scale, h - 210*scale - offset, 28*scale, 28*armorscale*scale, 0, 0, 1, 1*armorscale)

				if nz_showhealthmp:GetInt() > 1 then
					draw.SimpleTextOutlined(armor, ammo2font, w - (lowres and 236 or 234)*scale, h - 194*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
				end
			end
		end

		//nickname
		if nz_shownames:GetBool() then
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
				surface.DrawTexturedRect((w - 215*scale) - 32, h - (260*scale) - offset - 16, 32, 32)
			end

			draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (260*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, color_black_50)

			offset = offset + 25 //nickname offset buffer
		end

		offset = offset + 45*scale
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

				draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, pvcol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				if v.amount >= 100 then --If you're earning 100 points or more, the notif will be green!
					draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
				if v.amount < 100 then --If you're earning less than 100 points, the notif will be gold!
					draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end
		else --If you're doing something that subtracts points, the notif will be red!
			draw.SimpleText(v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points4, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		if fade >= 1 then
			table_remove(PointsNotifications, k)
		end
	end
end

local lerpcol_white = Color(240, 240, 240, 255)
local lerpcol_red = Color(255, 80, 80, 255)
local emptyclipdie = false
local emptycliptime = 0

local emptyclip2die = false
local emptyclip2time = 0

local scoreboard = false
hook.Add("ScoreboardShow", "nzCOD5HUD_scoretoggle", function()
	scoreboard = true
end)
hook.Add("ScoreboardHide", "nzCOD5HUD_scoretoggle", function()
	scoreboard = false
end)

local function GunHud_cod5()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if nzRound:InState(ROUND_GO) and not ply:Alive() then
		return
	end

	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local lowres = scale < 0.86
	local wep = ply:GetActiveWeapon()

	local ammofont = "nz.ammo.waw"
	local ammo2font = "nz.ammo2.waw"
	local smallfont = "nz.small.waw"
	local pointsfont = "nz.points.waw"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.ammofont)
		pointsfont = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
	end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor

	//compass hud
	if nz_showcompass:GetBool() and !scoreboard then
		local north = Angle(0,90,0)
		local dir = north - ply:EyeAngles()
		local angle = dir.y

		surface.SetMaterial(cod5_hud_compass_back)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectRotated(98*scale, 98*scale, 256*scale, 256*scale, 0)

		surface.SetMaterial(cod5_hud_compass)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectRotated(98*scale, 98*scale, 256*scale, 256*scale, angle)

		surface.SetMaterial(cod5_hud_compass_ring)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectRotated(98*scale, 98*scale, 256*scale, 256*scale, 0)
	end

	//weapon hud
	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon or wep.NZSpecialCategory == "specialgrenade" then
			fontColor = color_wonderweapon
		end
		if wep.NZSpecialCategory == "specialist" then
			fontColor = color_specialist
		end
		if wep.NZSpecialCategory == "trap" then
			fontColor = color_trap
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, smallfont, w - 140*scale, h - 120*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", pointsfont, w - 200*scale, h - 8*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
		elseif (illegalspecials[wep.NZSpecialCategory] and not wep.NZSpecialShowHUD) then
			local name = wep:GetPrintName()
			draw.SimpleTextOutlined(name, pointsfont, w - 140*scale, h - 120*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
		else
			local clipstring = ""
			local cliponly = false
			if wep.Primary then
				local clip = wep.Primary.ClipSize
				local resclip = wep.Primary.DefaultClip
				local clip1 = wep:Clip1()

				local flashing_sin = math.abs(math.sin(CurTime()*3))
				local ammoType = wep:GetPrimaryAmmoType()
				local ammoTotal = ply:GetAmmoCount(ammoType)
				local ammoCol = Color(240, 240, 240, 255)
				local reserveCol = color_grey

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

				if clip and (clip > 1 or clip1 == 0) and clip1 <= math.ceil(clip/3) then
					ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
					ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
					ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
				end
				if resclip and resclip > 0 and ammoTotal <= math.ceil(resclip/3) then
					reserveCol = color_empty
				end

				if clip and clip > 0 then
					clipstring = clip1
					if ammoType == -1 then
						draw.SimpleTextOutlined(clip1, smallfont, w - 205*scale, h - 2*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
						cliponly = true
					else
						draw.SimpleTextOutlined(clip1, smallfont, w - 220*scale, h - 2*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
						if resclip and resclip > 0 then
							draw.SimpleTextOutlined("/", smallfont, w - 215*scale, h - 2*scale, reserveCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
							draw.SimpleTextOutlined(ammoTotal, pointsfont, w - 200*scale, h - 2*scale, reserveCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
						end
					end
				else
					if ammoTotal and ammoTotal > 0 then
						draw.SimpleTextOutlined(ammoTotal, smallfont, w - 205*scale, h - 2*scale, reserveCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
						clipstring = ammoTotal
						cliponly = true
					end
				end
			end

			if wep.Secondary and (not wep.CanBeSilenced or (wep.CanBeSilenced and not wep:GetSilenced() and wep.Clip3)) then
				local clip2 = wep.Secondary.ClipSize
				local resclip2 = wep.Secondary.DefaultClip

				local flashing_sin = math.abs(math.sin(CurTime()*3))
				local ammoType2 = wep:GetSecondaryAmmoType()
				local ammoTotal2 = ply:GetAmmoCount(ammoType2)
				local ammoCol = Color(240, 240, 240, 255)
				local reserveCol = color_grey

				if clip2 and clip2 > 0 and wep:Clip2() <= math.ceil(clip2/3) then
					ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
					ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
					ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
					ammoCol.a = Lerp(flashing_sin, lerpcol_red.a, lerpcol_white.a)
				end
				if resclip2 and resclip2 > 0 and ammoTotal2 <= math.ceil(resclip2/3) then
					reserveCol = color_empty
				end

				surface.SetFont(smallfont)
				local tw, th = surface.GetTextSize(clipstring)

				if clip2 and clip2 > 0 then
					draw.SimpleTextOutlined(wep:Clip2().." | ", smallfont, w - (cliponly and 205 or 220)*scale - tw, h - 2*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
				else
					if ammoTotal2 and ammoTotal2 > 0 then
						draw.SimpleTextOutlined(ammoTotal2.." | ", smallfont, w - (cliponly and 205 or 220)*scale - tw, h - 2*scale, ammoCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
					end
				end
			end

			//silencer/underbarrel/altattack hud
			if wep.CanBeSilenced then
				local icon = cod5_icon_special
				if wep.NZHudIcon then
					icon = wep.NZHudIcon
				end
				if not icon or icon:IsError() then
					icon = zmhud_icon_missing
				end

				surface.SetMaterial(icon)
				surface.SetDrawColor(wep:GetSilenced() and color_used or color_white)
				surface.DrawTexturedRect((w/2 - 224*scale), h - 96*scale, 64*scale, 64*scale)

				local ammoTotal2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType()) + (wep.Clip3 and wep:Clip3() or wep:Clip2())
				if wep:GetSecondaryAmmoType() > 0 or ammoTotal2 > 0 then
					draw.SimpleTextOutlined(ammoTotal2, lowres and ammo2font or pointsfont, w/2 - 192*scale, h - (lowres and 34 or 24)*scale, ammoTotal2 > 0 and (wep:GetSilenced() and color_used or color_white) or color_empty, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, ammoTotal2 > 0 and color_black_50 or ColorAlpha(color_empty, 5))
				end

				local tfa_key_silence = GetConVar("cl_tfa_keys_silencer")
				if tfa_key_silence then
					local silencekey = tfa_key_silence:GetInt() > 0 and tfa_key_silence:GetInt() or 1
					draw.SimpleTextOutlined("["..string_upper(input_getkeyname(silencekey)).."]", pointsfont, (w/2 - 192*scale), h, input_isbuttondown(silencekey) and color_used or color_grey, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black_50)
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

			draw.SimpleTextOutlined(name, pointsfont, w - 140*scale, h - 116*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)

			if nz_showgun:GetBool() and killicon.Exists(class) and aat == "" then
				surface.SetFont(pointsfont)
				local tw, th = surface.GetTextSize(name)
	
				killicon.Draw(w - 140*scale - (64*scale) - tw, h - 116*scale - (32*scale), class, 255)
			end

			if aat ~= "" and style == 0 then
				local fade = 255
				if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then
					fade = 90
				end

				surface.SetFont(pointsfont)
				local tw, th = surface.GetTextSize(name)
				surface.SetMaterial(nzAATs:Get(aat).icon)
				surface.SetDrawColor(ColorAlpha(color_white, fade))
				surface.DrawTexturedRect(w - 140*scale - (58*scale) - tw, h - 116*scale - (48*scale), 48*scale, 48*scale)
			end

			if ply:HasPerk("mulekick") then
				surface.SetDrawColor(color_white_50)
				if IsValid(wep) and wep:GetNWInt("SwitchSlot") == 3 then
					surface.SetDrawColor(color_white)
				end
				surface.SetMaterial(GetPerkIconMaterial("mulekick", true))
				surface.DrawTexturedRect(w - 134*scale, h - 116*scale - 35*scale, 35*scale, 35*scale)
			end
		end
	end

	//grenade hud
	local specialweps = ply.NZSpecialWeapons or {}
	local tacnade = specialweps["specialgrenade"]
	local grenade = specialweps["grenade"]
	local num = ply:GetAmmoCount(GetNZAmmoID("grenade") or -1)
	local numspecial = ply:GetAmmoCount(GetNZAmmoID("specialgrenade") or -1)
	local scale = (w/1920 + 1) / 2

	if grenade then
		local icon = cod5_icon_grenade
		if grenade and IsValid(grenade) and grenade.NZHudIcon then
			icon = grenade.NZHudIcon
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - 228*scale, h - 108*scale, 52*scale, 52*scale)

		draw.SimpleTextOutlined(num, lowres and ammo2font or pointsfont, w - (lowres and 180 or 170)*scale, h - (lowres and 52 or 42)*scale, num > 0 and color_grey or color_empty, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, num > 0 and color_black_50 or ColorAlpha(color_empty, 5))
	end

	if tacnade then
		local icon = cod5_icon_grenade
		if tacnade and IsValid(tacnade) and tacnade.NZHudIcon then
			icon = tacnade.NZHudIcon_cod5 or tacnade.NZHudIcon
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - 300*scale, h - 108*scale, 52*scale, 52*scale)

		draw.SimpleTextOutlined(numspecial, lowres and ammo2font or pointsfont, w - (lowres and 250 or 240)*scale, h - (lowres and 52 or 42)*scale, numspecial > 0 and color_grey or color_empty, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, numspecial > 0 and color_black_50 or ColorAlpha(color_empty, 5))
	end
end

local function PerksMMOHud_cod5()
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
	local wr = w - 240*scale

	local curtime = CurTime()

	local traycount = 0
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
		surface.DrawTexturedRect(w - 355*scale - (40*traycount*scale), h - 94*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(GetPerkFrameMaterial(true))
			surface.DrawTexturedRect(w - 355*scale - (40*traycount*scale), h - 94*scale, 35*scale, 35*scale)
		end

		if mmohud.style == "toggle" then
		elseif mmohud.style == "count" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0), ChatFont, w - 320*scale - (40*traycount*scale), h - 56*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
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
				draw.SimpleTextOutlined(perkpercent.."%", ChatFont, w - 320*scale - (40*traycount*scale), h - 56*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
			end
		elseif mmohud.style == "chance" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0).."/"..mmohud.max, ChatFont, w - 320*scale - (40*traycount*scale), h - 56*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end

		traycount = traycount + 1
	end
end

local function DeathHud_cod5()
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
				local dist = 1 - math.Clamp(pos:DistToSqr(ent:GetPos()) / range, 0, 1)

				surface.SetDrawColor(ColorAlpha(color_white, 300*dist))
				surface.SetMaterial(ent.NZThrowIcon or cod5_icon_grenade)
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

		surface.SetMaterial(ent.NZThrowIcon or cod5_icon_grenade)
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

local powerup_data = {}
local antipowerup_data = {}

local function PowerUpsHud_cod5()
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
	local font = "nz.points.waw"
	if nz_mapfont:GetBool() then
		font = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
	end

	local scale = (scw/1920 + 1)/2
	local height = sch - 170*scale
	local size = 72*scale

	local powerupsActive = 0
	local powerupsTotal = 0

	local tActivePowerUps = nzPowerUps.ActivePowerUps
	for k, v in pairs(tActivePowerUps) do
		if (v - CurTime()) < engine.TickInterval() then continue end
		powerupsTotal = powerupsTotal + 1
	end

	local tActiveAntiPowerUps = nzPowerUps.ActiveAntiPowerUps
	for k, v in pairs(tActiveAntiPowerUps) do
		powerupsTotal = powerupsTotal + 1
	end

	local tPlayerPowerUps = ply:AllActivePowerUps()
	for k, v in pairs(tPlayerPowerUps) do
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

	for k, v in pairs(nzPowerUps.Data) do
		local active = false

		if v.global then
			active = nzPowerUps:IsPowerupActive(k)
		else
			if nzPowerUps.ActivePlayerPowerUps[ply] then
				active = nzPowerUps:IsPlayerPowerupActive(ply, k)
			end
		end

		if v.loopsound then
			if active then
				if not ply.refstrings[k] then --Haven't cached yet
					ply.refstrings[k] = v.loopsound
					ply.ambiences[k] = CreateSound(ply, v.loopsound)
				elseif ply.refstrings[k] ~= v.loopsound then --Cached but the sound was changed, requires re-cache
					if ply.ambiences[k] then ply.ambiences[k]:Stop() end --stop the existing sound if it's still playing

					ply.refstrings[k] = v.loopsound
					ply.ambiences[k] = CreateSound(ply, v.loopsound)
				end

				if ply.ambiences[k] then
					ply.ambiences[k]:Play()
					if ply.picons[k] then
						local timer = ply.picons[k].time - CurTime()
						ply.ambiences[k]:ChangePitch(100 + (v.nopitchshift and 0 or math.max(0, (10-timer)*5)) + (v.addpitch or 0))
					end
				end
			elseif ply.ambiences[k] then
				if v.stopsound and ply.ambiences[k]:IsPlaying() then
					ply:EmitSound(v.stopsound, 95, 100 + (v.addpitch or 0))
				end

				ply.ambiences[k]:Stop()
			end
		end
	end
end

local stinkfade = 0
local function PerksHud_cod5()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
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
	local w = ScrW()/1920 + 5
	local h = ScrH()
	local size = 45

	local num = 0
	local row = 0
	local num_b = 0
	local row_b = 0

	//perk borders
	local perk_borders = nz_showperkframe:GetInt()
	if perk_borders > 0 and maxperks > 0 then
		local modded = false
		surface.SetMaterial(GetPerkFrameMaterial())
		surface.SetDrawColor(color_white_100)
		for i=1, maxperks do
			if i == 4 and nzMapping.Settings.modifierslot and perk_borders < 2 then
				surface.SetDrawColor(color_gold)
				modded = true
			end
			if i > #perks then
				surface.DrawTexturedRect(w + num_b*(size + 12)*scale, h - 210*scale - (64*row_b)*scale, 52*scale, 52*scale)
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

	//perk icons
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
					fuckset = 5.2*math.Remap(wave, 0, 1, 0, 1)
				end
			end
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(perkcolor)
		surface.DrawTexturedRect(w + num*(size + 12)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 12)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)
		end

		if perk == "vulture" then
			if ply:HasVultureStink() then
				stinkfade = 1
			end

			if stinkfade > 0 then
				surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))

				surface.SetMaterial(zmhud_vulture_glow)
				surface.DrawTexturedRect((w + num*(size + 12)*scale) - 24*scale, (h - 210*scale - (64*row)*scale) - 24*scale, 100*scale, 100*scale)

				local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
				surface.SetTexture(stink)
				surface.DrawTexturedRect((w + num*(size + 12)*scale), (h - 210*scale - (64*row)*scale) - 62*scale, 64*scale, 64*scale)

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

local function VultureVision_cod5()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
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

//This is a modified Classic nZ Round Counter... If you want a Counter thats styled after the classic era of Zombies, use this one.
local round_white = 0
local round_alpha = 255
local round_num = 0

local infmat = Material("materials/nz_moo/round_tallies/chalk_infinity.png", "smooth")
local tallymats = {
	Material("nz_moo/huds/cod5/chalkmarks_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/cod5/chalkmarks_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/cod5/chalkmarks_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/cod5/chalkmarks_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/cod5/chalkmarks_5.png", "unlitgeneric smooth")
}

local round_posdata = {}
local round_intro = false
local intro_white = 255
local intro_alpha = 255
local intro_fade = 0
local intro_time = 0
local kys_time = 0

local tally_offset_killme = {
	[1] = 23,
	[2] = 35,
	[3] = 50,
	[4] = 65,
	[5] = 65,
	[6] = 145,
	[7] = 145,
	[8] = 145,
	[9] = 145,
	[10] = 145,
}

local function ResetRoundPos()
	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	round_posdata[1] = wscale + 10*scale
	round_posdata[2] = h - 115*scale

	round_posdata[3] = wscale
	round_posdata[4] = h - 150*scale

	round_posdata[5] = wscale + 150*scale
	round_posdata[6] = h - 150*scale

	round_posdata[7] = wscale + 15*scale
	round_posdata[8] = h + 15
end

local function GameBeginRound(round)
	round_intro = true
	intro_time = CurTime() + 6.5
	intro_fade = 0
	nzDisplay.HUDIntroDuration = intro_time

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	local font = "nz.rounds.bo1"
	if nz_mapfont:GetBool() then
		font = "nz.rounds."..GetFontType(nzMapping.Settings.roundfont)
	end

	surface.SetFont(font)
	local tw, th = surface.GetTextSize(round or nzRound:GetNumber())

	round_posdata[1] = w/2 - 100*scale
	round_posdata[2] = h/2 + 25*scale

	round_posdata[3] = w/2 - (tally_offset_killme[round] or 15)*scale
	round_posdata[4] = h/2 + 2*scale

	round_posdata[5] = w/2 + (150 - (tally_offset_killme[round] or 15))*scale
	round_posdata[6] = h/2 + 2*scale

	round_posdata[7] = w/2 - tw/2
	round_posdata[8] = h/2 + th

	hook.Add("HUDPaint", "nz_fuckoffshitt", function()
		if intro_time > CurTime() then return end

		if kys_time == 0 then
			kys_time = CurTime() + 2
		end

		local kysratio = math.Clamp(((kys_time - 1) - CurTime())/1, 0, 1)
		intro_alpha = Lerp(kysratio, 0, 255)

		if kys_time < CurTime() then
			hook.Remove("HUDPaint", "nz_fuckoffshitt")

			round_intro = false
			intro_white = 255
			intro_alpha = 255
			intro_fade = 0
			kys_time = 0

			ResetRoundPos()
		end
	end)
end

local function RoundHud_cod5()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_GO) or nzRound:InState(ROUND_CREATE)) then return end
	if nzRound:InState(ROUND_GO) and not LocalPlayer():Alive() then
		return
	end

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	local font = "nz.rounds.bo1"
	local font2 = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
	if nz_mapfont:GetBool() then
		font = "nz.rounds."..GetFontType(nzMapping.Settings.roundfont)
	end

	local ourwhite = round_intro and intro_white or round_white
	local ouralpha = (round_intro and (intro_time > CurTime() and intro_fade or intro_alpha) or round_alpha)

	local color = Color(math.min(color_blood.r + ourwhite, 255), ourwhite, ourwhite, ouralpha)
	surface.SetDrawColor(color)

	if round_intro then
		if intro_time - 4.5 < CurTime() then
			intro_white = math.Approach(intro_white, 0, FrameTime()*140)
		end

		if nz_showgamebegintext:GetBool() then
			surface.SetFont(font2)
			local tw, th = surface.GetTextSize(nzMapping.Settings.gamebegintext)

			local fuck_alpha = math.Clamp(255 - intro_white, 0, 255)
			if intro_time < CurTime() then
				fuck_alpha = intro_alpha
			end

			draw.SimpleTextOutlined(nzMapping.Settings.gamebegintext, font2, ScrW()/2, h/2 - 2, Color(math.min(90 + ourwhite, 255), ourwhite, ourwhite, ouralpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, ColorAlpha(color_black, fuck_alpha))
		end

		if intro_time < CurTime() then
			color = Color(math.min(color_blood.r + ourwhite, 255), ourwhite, ourwhite, 255)
			surface.SetDrawColor(color)
		elseif intro_time > CurTime() and intro_fade < 255 then
			local iwandieratio = 1 - math.Clamp(((intro_time - 5) - CurTime())/1, 0, 1)
			intro_fade = Lerp(iwandieratio, 0, 255)
		end
	elseif round_posdata[1] ~= (wscale + 10*scale) then
		ResetRoundPos()
	end

	surface.SetFont(font)

	if table.IsEmpty(round_posdata) then
		ResetRoundPos()
	end
	if intro_time < CurTime() and kys_time > CurTime() then
		local kysratio = math.Clamp((kys_time - CurTime())/2, 0, 1)
		local tw, th = surface.GetTextSize(round_num)

		round_posdata[1] = Lerp(kysratio, wscale + 10*scale, w/2 - 100*scale)
		round_posdata[2] = Lerp(kysratio, h - 115*scale, h/2 + 25*scale)

		round_posdata[3] = Lerp(kysratio, wscale, w/2 - (tally_offset_killme[round_num] or 15)*scale)
		round_posdata[4] = Lerp(kysratio, h - 150*scale, h/2 + 2*scale)

		round_posdata[5] = Lerp(kysratio, wscale + 150*scale, w/2 + (150 - (tally_offset_killme[round_num] or 15))*scale)
		round_posdata[6] = Lerp(kysratio, h - 150*scale, h/2 + 2*scale) 

		round_posdata[7] = Lerp(kysratio, wscale + 15*scale, w/2 - tw/2)
		round_posdata[8] = Lerp(kysratio, h + 15, h/2 + th)
	end

	if round_num == -1 then
		surface.SetMaterial(infmat)
		surface.DrawTexturedRect(round_posdata[1], round_posdata[2], 200*scale, 100*scale)
		return
	end
	if round_num <= 10 and round_num > 0 then
		if round_num <= 5 then -- Instead of using text for the tallies, We're now using the actual tally textures instead.
			surface.SetMaterial(tallymats[round_num])
			surface.DrawTexturedRect(round_posdata[3], round_posdata[4], 140*scale, 140*scale)
		end
		if round_num <= 10 and round_num > 5 then
			surface.SetMaterial(tallymats[5]) -- Always display five.
			surface.DrawTexturedRect(round_posdata[3], round_posdata[4], 140*scale, 140*scale)

			surface.SetMaterial(tallymats[round_num - 5])
			surface.DrawTexturedRect(round_posdata[5], round_posdata[6], 140*scale, 140*scale)
		end
	else
		draw.SimpleText(round_num, font, round_posdata[7], round_posdata[8], color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	end
end

local roundchangeending = false
local prevroundspecial = false
local function StartChangeRound_cod5()
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
		round_num = 1
	end

	if !nzDisplay.HasPlayedRoundIntro then
		nzDisplay.HasPlayedRoundIntro = true
		GameBeginRound(lastround + 1)
	end

	roundchangeending = false
	round_white = 255
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
					elseif nzRound:GetNumber() == 1 then
						nzSounds:Play("FirstRoundStart")
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

local function EndChangeRound_cod5()
	roundchangeending = true
end

local function ResetRound_cod5()
	timer.Create("round_reseter", 0, 0, function()
		local ply = LocalPlayer()
		if not IsValid(ply) or not ply:Alive() then
			timer.Remove("round_reseter")
			round_white = 0
			round_alpha = 255
			round_num = 0
		end
	end)

	nzDisplay.HasPlayedRoundIntro = nil
end

local function PlayerHealthHUD_cod5()
	if not cl_drawhud:GetBool() then return end
	if not nz_showhealth:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = w - 264*scale
	local hr = h - 192*scale

	local armor = ply:Armor()
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()
	local healthscale = math.Clamp(health / maxhealth, 0, 1)

	if nz_healthbarstyle:GetBool() then
		wr = 48*scale
		hr = h - 246*scale

		local row = 0
		local num = 0
		local perks = #ply:GetPerks()
		if ply:GetMaxPerks() > perks then
			perks = ply:GetMaxPerks()
		end
		perks = perks + #ply:GetPerks(true)

		for i=1, perks do
			if num%(nz_perkrowmod:GetInt()) == 0 then
				row = row + 1
				num = 0
			end
			num = num + 1
		end

		hr = hr - 64*(row - 1)

		if armor > 0 then
			wr = 84*scale
		end
	end

	local smallfont = "nz.ammo2.waw"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end
	local fucker = scale < 0.96

	surface.SetMaterial(cod5_hud_health)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(wr - 44*scale, hr - 7*scale, 42*scale, 42*scale)

	surface.SetMaterial(cod5_hud_healthbar)
	surface.SetDrawColor(color_blood)
	surface.DrawTexturedRectUV(wr - 4*scale, hr - 4*scale, 264*scale, 32*scale, 0, 0, 1, 1)

	surface.SetMaterial(cod5_hud_healthbar)
	surface.SetDrawColor(color_blood_score)
	surface.DrawTexturedRectUV(wr, hr, 256*healthscale*scale, 24*scale, 0, 0, 1*healthscale, 1)

	if nz_showhealth:GetInt() > 1 then
		draw.SimpleTextOutlined(health, smallfont, wr - (fucker and 24 or 23)*scale, hr + (fucker and 14 or 15)*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
	end

	if armor > 0 then
		wr = wr - 36*scale
		local maxarmor = ply:GetMaxArmor()
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetMaterial(cod5_hud_shield)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(wr - 44*scale, hr - 7*scale, 38*scale, 38*scale)

		surface.SetMaterial(cod5_hud_shield)
		surface.SetDrawColor(color_armor)
		surface.DrawTexturedRectUV(wr - 44*scale, hr - 7*scale, 38*scale, 38*armorscale*scale, 0, 0, 1, 1*armorscale)

		if nz_showhealth:GetInt() > 1 then
			draw.SimpleTextOutlined(armor, smallfont, wr - (fucker and 26 or 25)*scale, hr + (fucker and 14 or 15)*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
		end
	end
end

local function PlayerStaminaHUD_cod5()
	/*if not cl_drawhud:GetBool() then return end
	if not nz_showstamina:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not ply.GetStamina then return end
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2

	local stamina = ply:GetStamina()
	local maxstamina = ply:GetMaxStamina()
	local fade = maxstamina*0.15 //lower the number, faster the fade in

	local staminascale = math.Clamp(stamina / maxstamina, 0, 1)
	local stamalpha = 1 - math.Clamp((stamina - maxstamina + fade) / fade, 0, 1)
	local staminacolor = ColorAlpha(color_white, 255*stamalpha)

	if stamina < maxstamina then
		surface.SetDrawColor(staminacolor)
		surface.DrawRect(w - (185*scale), h - 246*scale, 122*staminascale*scale, 4*scale)
	end*/
end

local function ZedCounterHUD_cod5()
	if not cl_drawhud:GetBool() then return end
	if not nz_showzcounter:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local lowres = scale < 0.86
	local wr = w - 156*scale
	local hr = h - 106*scale

	surface.SetDrawColor(color_blood)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr - (2*scale), hr - (2*scale), 52*scale, 52*scale)

	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr, hr, 52*scale, 52*scale)

	local smallfont = "nz.points.waw"
	local ammo2font = "nz.ammo2.waw"
	if nz_mapfont:GetBool() then
		smallfont = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.ammofont)
	end

	draw.SimpleTextOutlined(GetGlobal2Int("AliveZombies", 0), lowres and ammo2font or smallfont, wr + (lowres and 42 or 52)*scale, hr + (lowres and 54 or 64)*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
end

-- Hooks
hook.Add("HUDPaint", "nzHUDswapping_cod5", function()
	if nzMapping.Settings.hudtype == "World at War" then
		hook.Add("HUDPaint", "roundHUD", StatesHud_cod5 )
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD_cod5 )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD_cod5 )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud_cod5 )
		hook.Add("HUDPaint", "powerupHUD", PowerUpsHud_cod5 )
		hook.Add("HUDPaint", "perksHUD", PerksHud_cod5 )
		hook.Add("HUDPaint", "vultureVision", VultureVision_cod5 )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud_cod5 )
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud_cod5 )
		hook.Add("HUDPaint", "deathiconsHUD", DeathHud_cod5 )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud_cod5 )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD_cod5 )
		hook.Add("HUDPaint", "zedcounterHUD", ZedCounterHUD_cod5 )

		hook.Add("OnRoundPreparation", "BeginRoundHUDChange", StartChangeRound_cod5 )
		hook.Add("OnRoundStart", "EndRoundHUDChange", EndChangeRound_cod5 )
		hook.Add("OnRoundEnd", "GameEndHUDChange", ResetRound_cod5 )
	end
end)

//--------------------------------------------------/GhostlyMoo and Fox's W@W-ish HUD\------------------------------------------------\\