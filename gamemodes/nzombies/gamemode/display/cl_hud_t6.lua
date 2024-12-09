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
local color_grey = Color(200, 200, 200, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(135, 160, 255)
local color_health = Color(80, 0, 0, 160)

local color_blood = Color(100, 0, 0, 255)
local color_blood_score = Color(120, 0, 0, 255)

local color_points1 = Color(255, 200, 0, 255)
local color_points2 = Color(100, 255, 70, 255)
local color_points4 = Color(255, 0, 0, 255)

//--------------------------------------------------/GhostlyMoo and Fox's Tranzit HUD\------------------------------------------------\\

//t6 hud
local t6_hud_dpad_blood = Material("nz_moo/huds/t6/hud_dpad_blood.png", "unlitgeneric smooth")
local t6_hud_dpad_circle = Material("nz_moo/huds/t6/lui_dpad_circle.png", "unlitgeneric smooth")
local t6_hud_dpad_up = Material("nz_moo/huds/t6/hud_arrow_up.png", "unlitgeneric smooth")
local t6_hud_dpad_down = Material("nz_moo/huds/t6/hud_arrow_down.png", "unlitgeneric smooth")
local t6_hud_dpad_left = Material("nz_moo/huds/t6/hud_arrow_left.png", "unlitgeneric smooth")
local t6_hud_dpad_right = Material("nz_moo/huds/t6/hud_arrow_right.png", "unlitgeneric smooth")

local t6_hud_score = Material("nz_moo/huds/t6/scorebar_zom_5.png", "unlitgeneric smooth")

local t6_hud_healthbar = Material("nz_moo/icons/t5hud_healthbar.png", "unlitgeneric smooth")
local t6_hud_health = Material("nz_moo/icons/mori2_hud_health_logo.png", "unlitgeneric smooth")
local t6_hud_shield = Material("nz_moo/huds/t7/uie_t7_icon_inventory_dlc3_dragonshield_fill.png", "unlitgeneric smooth")

//t6 powerup
/*local t6_powerup_minigun = Material("nz_moo/icons/bo2/charred_powerup_deathmachine.png", "unlitgeneric")
local t6_powerup_blood = Material("nz_moo/icons/bo2/charred_powerup_blood_alt_alt.png", "unlitgeneric")
local t6_powerup_2x = Material("nz_moo/icons/bo2/charred_powerup_2x.png", "unlitgeneric")
local t6_powerup_killjoy = Material("nz_moo/icons/bo2/charred_powerup_instakill.png", "unlitgeneric")
local t6_powerup_firesale = Material("nz_moo/icons/bo2/charred_powerup_sale.png", "unlitgeneric")
local t6_powerup_bonfiresale = Material("nz_moo/icons/bo2/charred_powerup_bonfire.png", "unlitgeneric")
local t6_powerup_timewarp = Material("vgui/charred_powerup_slow.png", "unlitgeneric")
local t6_powerup_berzerk = Material("vgui/t6_bzk.png", "unlitgeneric")
local t6_powerup_infinite = Material("vgui/bo2_infinite.png", "unlitgeneric")
local t6_powerup_godmode = Material("vgui/bo2_greyson.png", "unlitgeneric")
local t6_powerup_quick = Material("vgui/bo2_quick.png", "unlitgeneric")*/

//t6 inventory
local t6_icon_shield = Material("nz_moo/icons/zm_riotshield_icon.png", "unlitgeneric smooth")
local t6_icon_special = Material("nz_moo/huds/t6/hud_minigun.png", "unlitgeneric smooth")
local t6_icon_grenade = Material("nz_moo/hud_grenade_bo2.png", "unlitgeneric smooth")
local t6_icon_semtex = Material("nz_moo/huds/t5/hud_sticky_grenade.png", "unlitgeneric smooth")
local t6_icon_trap = Material("nz_moo/icons/zm_turbine_icon.png", "unlitgeneric smooth")
local t6_icon_gl = Material("nz_moo/huds/t6/hud_gl_select_big.png", "unlitgeneric smooth")
local t6_icon_shovel = Material("nz_moo/huds/t6/zom_hud_craftable_tank_shovel.png", "unlitgeneric smooth")
local t6_icon_shovel_gold = Material("nz_moo/huds/t6/zom_hud_shovel_gold.png", "unlitgeneric smooth")

//universal
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_dpad_compass = Material("nz_moo/huds/t6/compass_white.png", "unlitgeneric smooth noclamp")
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

local function StatesHud_t6()
	if cl_drawhud:GetBool() and !nzRound:InProgress() then
		local text = ""
		local font = "nz.main.blackops2"
		if nz_mapfont:GetBool() then
			font = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		end

		local w, h = ScrW(), ScrH()
		local pscale = (w/1920 + 1) / 2

		if nzRound:InState(ROUND_WAITING) then
			text = "Waiting for players. Type /ready to ready up."
			font = "nz.small.blackops2"
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

net.Receive("nz_points_notification_bo2", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	local profit_id = net.ReadInt(9)
	PointsNotification(ply, amount, profit_id)
end)

//Equipment
local function InventoryHUD_t6()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if ply:IsNZMenuOpen() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local ammofont =  "nz.ammo.blackops2"
	local ammo2font =  "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local plyweptab = ply:GetWeapons()

	local nz_key_trap = GetConVar("nz_key_trap")
	local nz_key_shield = GetConVar("nz_key_shield")
	local nz_key_specialist = GetConVar("nz_key_specialist")
	local tfa_key_silence = GetConVar("cl_tfa_keys_silencer")

	// Special Weapon Categories
	for _, wep in pairs(plyweptab) do
		// Traps
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "trap" then
			local icon = t6_icon_trap
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 50*scale) - (24*scale), (h - 110*scale) - (24*scale), 48*scale, 48*scale)

			local ammo = wep:GetPrimaryAmmoType()
			if ammo > 0 and not wep.TrapCanBePlaced then
				local ammocount = ply:GetAmmoCount(ammo) + wep:Clip1()
				draw.SimpleTextOutlined(ammocount, ammo2font, w - 36*scale, h - 82*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
			end
		end

		// Specialists
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
			local icon = t6_icon_special
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 95*scale) - (24*scale), (h - 60*scale) - (24*scale), 48*scale, 48*scale)
		end

		// Shield Slot Occupier
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "shield" and wep.NZHudIcon and not wep.ShieldEnabled then
			local icon = t6_icon_shield
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 95*scale) - (24*scale), (h - 155*scale) - (24*scale), 48*scale, 48*scale)
		end
	end

	// Shield
	if ply.GetShield and IsValid(ply:GetShield()) then
		local shield = ply:GetShield()
		local wep = shield:GetWeapon()

		local icon = t6_icon_shield
		if IsValid(wep) and wep.NZHudIcon then
			icon = wep.NZHudIcon
		end
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((w - 95*scale) - (24*scale), (h - 155*scale) - (24*scale), 48*scale, 48*scale)
	
		if wep.Secondary and wep.Secondary.ClipSize > 0 then
			local clip2 = wep:Clip2()
			local clip2rate = wep.Secondary.AmmoConsumption
			local clip2i = math.floor(clip2/clip2rate)

			draw.SimpleTextOutlined(clip2i, ammo2font, w - 78*scale, h - 126*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
		end
	end

	if nz_key_trap then
		local trapkey = nz_key_trap:GetInt() > 0 and nz_key_trap:GetInt() or 1
		draw.SimpleTextOutlined("["..string_upper(input_getkeyname(trapkey)).."]", ammo2font, (w - 50*scale), (h - 110*scale), input_isbuttondown(trapkey) and color_used or color_white_100, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
	end

	if nz_key_specialist then
		local specialkey = nz_key_specialist:GetInt() > 0 and nz_key_specialist:GetInt() or 1
		draw.SimpleTextOutlined("["..string_upper(input_getkeyname(specialkey)).."]", ammo2font, (w - 95*scale), (h - 60*scale), input_isbuttondown(specialkey) and color_used or color_white_100, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
	end

	if nz_key_shield then
		local shieldkey = nz_key_shield:GetInt() > 0 and nz_key_shield:GetInt() or 1
		draw.SimpleTextOutlined("["..string_upper(input_getkeyname(shieldkey)).."]", ammo2font, (w - 95*scale), (h - 155*scale), input_isbuttondown(shieldkey) and color_used or color_white_100, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
	end

	if tfa_key_silence then
		local gunn = ply:GetActiveWeapon()
		if IsValid(gunn) and gunn.CanBeSilenced then return end
		local silencekey = tfa_key_silence:GetInt() > 0 and tfa_key_silence:GetInt() or 1
		draw.SimpleTextOutlined("["..string_upper(input_getkeyname(silencekey)).."]", ammo2font, (w - 140*scale), (h - 110*scale), input_isbuttondown(silencekey) and color_used or color_white_100, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
	end
end

local function ScoreHud_t6()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local smallfont = "nz.small.blackops2"
	local fontsmall = "nz.points.blackops2"
	local ammo2font =  "nz.ammo2.blackops2"
	local fontnade = "nz.grenade"
	if nz_mapfont:GetBool() then
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.ammofont)
		fontsmall = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local offset = 5
	local healthmodder = (not nz_healthbarstyle:GetBool() and nz_showhealth:GetBool())
	if nz_showcompass:GetBool() then
		offset = healthmodder and 35*scale or 40*scale
	end
	if healthmodder then
		offset = offset + 35*scale
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local index = ply:EntIndex()
	local pcolor = player.GetColorByIndex(index)
	if nz_useplayercolor:GetBool() then
		local pvcol = ply:GetPlayerColor()
		pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
	end

	//points
	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(t6_hud_score)
	surface.DrawTexturedRect(w - 235*scale, h - 230*scale - offset, 210*scale, 50*scale)

	draw.SimpleTextOutlined(ply:GetPoints(), smallfont, w - 220*scale, h - (205*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
	ply.PointsSpawnPosition = {x = w - 240*scale, y = h - (205*scale) - offset}

	//icon
	if nz_showportrait:GetBool() then
		local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")
		if not pmpath or pmpath:IsError() then
			pmpath = zmhud_icon_missing
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(w - 60*scale, h - 230*scale - offset, 48*scale, 48*scale)

		surface.SetDrawColor(pcolor)
		surface.DrawOutlinedRect(w - 60*scale, h - 230*scale - offset, 50*scale, 50*scale, 2)
	end

	//shovel
	if ply.GetShovel and IsValid(ply:GetShovel()) then
		local pshovel = ply:GetShovel()

		surface.SetMaterial(pshovel:IsGolden() and t6_icon_shovel_gold or t6_icon_shovel)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - (90*scale), h - (210*scale) - offset, 32, 32)
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
			surface.DrawTexturedRect((w - 215*scale) - 32, h - (248*scale) - offset - 16, 32, 32)
		end

		draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (248*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

		offset = offset + 25 //nickname offset buffer
	end

	offset = offset + 45*scale

	local plytab = player.GetAll()
	for k, v in ipairs(plytab) do
		if v == ply then continue end

		local index = v:EntIndex()
		local pcolor = player.GetColorByIndex(index)
		if nz_useplayercolor:GetBool() then
			local pvcol = v:GetPlayerColor()
			pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		end

		if nz_showhealthmp:GetBool() then
			offset = offset + 25*scale //health bar offset buffer
		end

		draw.SimpleTextOutlined(v:GetPoints(), smallfont, w - 210*scale, h - (215*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
		v.PointsSpawnPosition = {x = w - 240*scale, y = h - (205*scale) - offset}

		//icon
		if nz_showportrait:GetBool() then
			local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")
			if not pmpath or pmpath:IsError() then
				pmpath = zmhud_icon_missing
			end

			surface.SetDrawColor(color_white)
			surface.SetMaterial(pmpath)
			surface.DrawTexturedRect(w - 60*scale, h - 235*scale - offset, 40*scale, 40*scale)

			surface.SetDrawColor(pcolor)
			surface.DrawOutlinedRect(w - 60*scale, h - 235*scale - offset, 42*scale, 42*scale, 2)
		end

		//shovel
		if v.GetShovel and IsValid(v:GetShovel()) then
			local pshovel = v:GetShovel()

			surface.SetMaterial(pshovel:IsGolden() and t6_icon_shovel_gold or t6_icon_shovel)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - (90*scale), h - (225*scale) - offset, 32, 32)
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
			local phealth = v:Health()
			local pmaxhealth = v:GetMaxHealth()
			local phealthscale = math.Clamp(phealth / pmaxhealth, 0, 1)
			local lowres = scale < 0.96

			surface.SetMaterial(t6_hud_healthbar)
			surface.SetDrawColor(color_health)
			surface.DrawTexturedRectUV(w - 222*scale, h - 192*scale - offset, 264*0.8*scale, 32*0.6*scale, 0, 0, 1, 1)

			surface.SetMaterial(t6_hud_healthbar)
			surface.SetDrawColor(color_blood_score)
			surface.DrawTexturedRectUV(w - 218*scale, h - 190*scale - offset, 256*0.8*phealthscale*scale, 24*0.6*scale, 0, 0, 1*phealthscale, 1)

			if nz_showhealthmp:GetInt() > 1 then
				draw.SimpleTextOutlined(phealth, ammo2font, w - (lowres and 200 or 200)*scale, h - 183*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
			end

			local armor = v:Armor()
			if armor > 0 then
				local maxarmor = v:GetMaxArmor()
				local armorscale = math.Clamp(armor / maxarmor, 0, 1)

				surface.SetMaterial(t6_hud_shield)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w - 244*scale, h - 198*scale - offset, 32*scale, 32*scale)

				surface.SetMaterial(t6_hud_shield)
				surface.SetDrawColor(color_armor)
				surface.DrawTexturedRectUV(w - 244*scale, h - 198*scale - offset, 32*scale, 32*armorscale*scale, 0, 0, 1, 1*armorscale)

				if nz_showhealthmp:GetInt() > 1 then
					draw.SimpleTextOutlined(armor, ammo2font, w - (lowres and 229 or 228)*scale, h - 183*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
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
				surface.DrawTexturedRect((w - 215*scale) - 32, h - (248*scale) - offset - 16, 32, 32)
			end

			draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (248*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

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

local function GunHud_t6()
	if not cl_drawhud:GetBool() then return end

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
	local wep = ply:GetActiveWeapon()

	local ammofont = "nz.ammo.blackops2"
	local ammo2font = "nz.ammo2.blackops2"
	local smallfont = "nz.small.blackops2"
	local mainfont = "nz.main.blackops2"
	local fontsmall = "nz.points.blackops2"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
		mainfont = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		fontsmall = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
	end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor

	//keys
	local tfa_key_silence = GetConVar("cl_tfa_keys_silencer")
	local nz_key_trap = GetConVar("nz_key_trap")
	local nz_key_shield = GetConVar("nz_key_shield")
	local nz_key_specialist = GetConVar("nz_key_specialist")

	local trapkey = (nz_key_trap and nz_key_trap:GetInt() > 0) and nz_key_trap:GetInt() or 1
	local silencekey = (tfa_key_silence and tfa_key_silence:GetInt() > 0) and tfa_key_silence:GetInt() or 1
	local shieldkey = (nz_key_shield and nz_key_shield:GetInt() > 0) and nz_key_shield:GetInt() or 1
	local specialkey = (nz_key_specialist and nz_key_specialist:GetInt() > 0) and nz_key_specialist:GetInt() or 1

	//main hud
	surface.SetMaterial(t6_hud_dpad_blood)
	surface.SetDrawColor(color_blood)
	surface.DrawTexturedRect(w - 460*scale, h - 220*scale, 256*scale*1.8, 128*scale*1.8)

	surface.SetMaterial(t6_hud_dpad_circle)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(w - 200*scale, h - 210*scale, 128*scale*1.6, 128*scale*1.6)

	surface.SetMaterial(t6_hud_dpad_up)
	surface.SetDrawColor(input_isbuttondown(shieldkey) and color_used or color_white)
	surface.DrawTexturedRect(w - (105*scale), h - 115*scale-6, 18*scale, 18*scale)

	surface.SetMaterial(t6_hud_dpad_down)
	surface.SetDrawColor(input_isbuttondown(specialkey) and color_used or color_white)
	surface.DrawTexturedRect(w - (105*scale), h - 115*scale+6, 18*scale, 18*scale)

	surface.SetMaterial(t6_hud_dpad_left)
	surface.SetDrawColor(input_isbuttondown(silencekey) and color_used or color_white)
	surface.DrawTexturedRect(w - (105*scale)-6, h - 115*scale, 18*scale, 18*scale)

	surface.SetMaterial(t6_hud_dpad_right)
	surface.SetDrawColor(input_isbuttondown(trapkey) and color_used or color_white)
	surface.DrawTexturedRect(w - (105*scale)+6, h - 115*scale, 18*scale, 18*scale)

	//compass hud
	if nz_showcompass:GetBool() then
		local angle = -ply:EyeAngles().y/360 + 0.016

		surface.SetMaterial(zmhud_dpad_compass)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectUV(w - 256*scale, h - 225*scale, 256*scale, 64*scale, 0 + angle , 0, 0.5 + angle , 1)
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	//weapon hud
	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon then
			fontColor = Color(0, 255, 255, 255)
		end
		if wep.NZSpecialCategory == "specialist" then
			fontColor = Color(180, 0, 0, 255)
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, ammofont, w - 200*scale, h - 140*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", smallfont, w - 185*scale, h - 90*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
		elseif (illegalspecials[wep.NZSpecialCategory] and not wep.NZSpecialShowHUD) then
			local name = wep:GetPrintName()
			draw.SimpleTextOutlined(name, fontsmall, w - 200*scale, h - 135*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
		else
			local clipstring = ""
			if wep.Primary then
				local clip = wep.Primary.ClipSize
				local resclip = wep.Primary.DefaultClip
				local clip1 = wep:Clip1()

				local ammoType = wep:GetPrimaryAmmoType()
				local ammoTotal = ply:GetAmmoCount(ammoType)

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

				if clip and clip > 0 then
					if ammoType == -1 then
						draw.SimpleTextOutlined(clip1, mainfont, w - 185*scale, h - 80*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
						clipstring = clip1
					else
						draw.SimpleTextOutlined(clip1.."/"..ammoTotal, mainfont, w - 185*scale, h - 80*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
						clipstring = clip1.."/"..ammoTotal
					end
				else
					if ammoTotal and ammoTotal > 0 then
						draw.SimpleTextOutlined(ammoTotal, mainfont, w - 185*scale, h - 80*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
						clipstring = ammoTotal
					end
				end
			end

			if wep.Secondary and (not wep.CanBeSilenced or (wep.CanBeSilenced and not wep:GetSilenced() and wep.Clip3)) then
				local clip2 = wep.Secondary.ClipSize
				local resclip2 = wep.Secondary.DefaultClip

				local ammoType2 = wep:GetSecondaryAmmoType()
				local ammoTotal2 = ply:GetAmmoCount(ammoType2)

				surface.SetFont(mainfont)
				local tw, th = surface.GetTextSize(clipstring)

				if clip2 and clip2 > 0 then
					draw.SimpleTextOutlined(wep:Clip2().." | ", mainfont, w - 185*scale - tw, h - 80*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				else
					if ammoTotal2 and ammoTotal2 > 0 then
						draw.SimpleTextOutlined(ammoTotal2.." | ", mainfont, w - 185*scale, h - 80*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
					end
				end
			end

			//silencer/underbarrel/altattack hud
			if wep.CanBeSilenced then
				local icon = t6_icon_gl
				if wep.NZHudIcon then
					icon = wep.NZHudIcon
				end
				if not icon or icon:IsError() then
					icon = zmhud_icon_missing
				end

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect((w - 140*scale) - (24*scale), (h - 110*scale) - (24*scale), 48*scale, 48*scale)

				local ammoTotal2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType()) + (wep.Clip3 and wep:Clip3() or wep:Clip2())
				if ammoTotal2 > 0 then
					draw.SimpleTextOutlined(ammoTotal2, ammofont, w - 132*scale, h - 95*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
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

			draw.SimpleTextOutlined(name, fontsmall, w - 200*scale, h - 135*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)

			if nz_showgun:GetBool() and killicon.Exists(class) and aat == "" then
				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(name)

				killicon.Draw(w - 200*scale - (64*scale) - tw, h - 135*scale - (32*scale), class, 255)
			end

			if aat ~= "" and style == 0 then
				local fade = 255
				if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then
					fade = 90
				end

				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(name)
				surface.SetMaterial(nzAATs:Get(aat).icon)
				surface.SetDrawColor(ColorAlpha(color_white, fade))
				surface.DrawTexturedRect(w - 200*scale - (58*scale) - tw, h - 135*scale - (48*scale), 48*scale, 48*scale)
			end

			if ply:HasPerk("mulekick") then
				surface.SetDrawColor(color_white_50)
				if IsValid(wep) and wep:GetNWInt("SwitchSlot") == 3 then
					surface.SetDrawColor(color_white)
				end
				surface.SetMaterial(GetPerkIconMaterial("mulekick", true))
				surface.DrawTexturedRect(w - 220*scale, h - 80*scale, 35*scale, 35*scale)
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

	if num > 0 then
		local icon = t6_icon_grenade
		if grenade and IsValid(grenade) and grenade.NZHudIcon then
			icon = grenade.NZHudIcon
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(icon)

		for i = num, 1, -1 do
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - 5*scale - i*(35*scale), h - 35*scale, 35*scale, 35*scale)
		end
	end

	if numspecial > 0 then
		local icon = t6_icon_grenade
		if tacnade and IsValid(tacnade) and tacnade.NZHudIcon then
			icon = tacnade.NZHudIcon_t6 or tacnade.NZHudIcon
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		for i = numspecial, 1, -1 do
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - 165*scale - i*(35*scale), h - 35*scale, 35*scale, 35*scale)
		end
	end
end

local function PerksMMOHud_t6()
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

		surface.SetMaterial(GetPerkIconMaterial(v, true))
		surface.DrawTexturedRect(w - 220*scale - (40*traycount*scale), h - 80*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(GetPerkFrameMaterial(true))
			surface.DrawTexturedRect(w - 220*scale - (40*traycount*scale), h - 80*scale, 35*scale, 35*scale)
		end

		if mmohud.style == "toggle" then
		elseif mmohud.style == "count" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0), ChatFont, w - 185*scale - (40*traycount*scale), h - 45*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
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
				draw.SimpleTextOutlined(perkpercent.."%", ChatFont, w - 185*scale - (40*traycount*scale), h - 45*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
			end
		elseif mmohud.style == "chance" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0).."/"..mmohud.max, ChatFont, w - 185*scale - (40*traycount*scale), h - 45*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end

		traycount = traycount + 1
	end
end

local function DeathHud_t6()
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
				local dist = 1 - math.Clamp(pos:DistToSqr(ent:GetPos()) / 160000, 0, 1)

				surface.SetDrawColor(ColorAlpha(color_white, 300*dist))
				surface.SetMaterial(ent.NZThrowIcon or t6_icon_grenade)
				surface.DrawTexturedRect(data.x - screen*0.5, data.y - screen*0.5, screen, screen)
			else
				if ent.NZNadeRethrow and ply ~= ent:GetOwner() then continue end
				table_insert(nades, ent)
			end
		end
	end

	for _, ent in ipairs(nades) do
		local epos = ent:GetPos()

		local dist = 1 - math.Clamp(pos:DistToSqr(epos) / 160000, 0, 1)
		local dir = (epos - pos):Angle()
		dir = dir - EyeAngles()
		local angle = dir.y + 90

		local x = (math.cos(math.rad(angle)) * pscale) + ScrW() / 2
		local y = (math.sin(math.rad(angle)) * -pscale) + ScrH() / 2

		surface.SetDrawColor(ColorAlpha(color_white, 400*dist))

		surface.SetMaterial(ent.NZThrowIcon or t6_icon_grenade)
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

local function PowerUpsHud_t6()
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
	local font = "nz.points.blackops2"
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
local function PerksHud_t6()
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
	local w = ScrW()/1920 + 10
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
		for i=1, ply:GetMaxPerks() do
			if i == 4 and nzMapping.Settings.modifierslot and perk_borders < 2 then
				surface.SetDrawColor(color_gold)
				modded = true
			end
			if i > #perks then
				surface.DrawTexturedRect(w + num_b*(size + 15)*scale, h - 210*scale - (64*row_b)*scale, 52*scale, 52*scale)
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
		surface.DrawTexturedRect(w + num*(size + 15)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(color_gold)
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 15)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)
		end

		if perk == "vulture" then
			if ply:HasVultureStink() then
				stinkfade = 1
			end

			if stinkfade > 0 then
				surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))

				surface.SetMaterial(zmhud_vulture_glow)
				surface.DrawTexturedRect((w + num*(size + 15)*scale) - 24*scale, (h - 210*scale - (64*row)*scale) - 24*scale, 100*scale, 100*scale)

				local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
				surface.SetTexture(stink)
				surface.DrawTexturedRect((w + num*(size + 15)*scale), (h - 210*scale - (64*row)*scale) - 62*scale, 64*scale, 64*scale)

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

local function VultureVision_t6()
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
	Material("nz_moo/huds/oilrig/chalkmarks_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/oilrig/chalkmarks_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/oilrig/chalkmarks_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/oilrig/chalkmarks_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/oilrig/chalkmarks_5.png", "unlitgeneric smooth")
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
	[2] = 45,
	[3] = 55,
	[4] = 68,
	[5] = 68,
	[6] = 150,
	[7] = 150,
	[8] = 150,
	[9] = 150,
	[10] = 150,
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

local function RoundHud_t6()
	if not cl_drawhud:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_GO) or nzRound:InState(ROUND_CREATE)) then return end
	if nzRound:InState(ROUND_GO) and not LocalPlayer():Alive() then
		return
	end

	local font = "nz.rounds.blackops2"
	local font2 = "nz.main."..GetFontType(nzMapping.Settings.roundfont)
	if nz_mapfont:GetBool() then
		font = "nz.rounds."..GetFontType(nzMapping.Settings.roundfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

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
local function StartChangeRound_t6()
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

local function EndChangeRound_t6()
	roundchangeending = true
end

local function ResetRound_t6()
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

local function PlayerHealthHUD_t6()
	if not cl_drawhud:GetBool() then return end
	if not nz_showhealth:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = w - 260*scale
	local hr = h - 214*scale
	local lowres = scale < 0.96

	local armor = ply:Armor()
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()
	local healthscale = math.Clamp(health / maxhealth, 0, 1)

	if nz_healthbarstyle:GetBool() then
		wr = 34*scale
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
			wr = 64*scale
		end
	elseif nz_showcompass:GetBool() then
		hr = h - 244*scale
	end

	local smallfont = "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	surface.SetMaterial(t6_hud_health)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(wr - (34*scale), hr - 7*scale, 36*scale, 36*scale)

	surface.SetMaterial(t6_hud_healthbar)
	surface.SetDrawColor(color_health)
	surface.DrawTexturedRectUV(wr - (4*scale), hr - 4*scale, 264*scale, 32*scale, 0, 0, 1, 1)

	surface.SetMaterial(t6_hud_healthbar)
	surface.SetDrawColor(ColorAlpha(color_blood_score, 220))
	surface.DrawTexturedRectUV(wr, hr, 256*healthscale*scale, 24*scale, 0, 0, 1*healthscale, 1)

	if nz_showhealth:GetInt() > 1 then
		draw.SimpleTextOutlined(health, smallfont, wr - (lowres and 16 or 15)*scale, hr + 10*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
	end

	if armor > 0 then
		wr = wr - 32*scale
		local maxarmor = ply:GetMaxArmor()
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetMaterial(t6_hud_shield)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(wr - (38*scale), hr - 12*scale, 46*scale, 46*scale)

		surface.SetMaterial(t6_hud_shield)
		surface.SetDrawColor(color_armor)
		surface.DrawTexturedRectUV(wr - (38*scale), hr - 12*scale, 46*scale, 46*armorscale*scale, 0, 0, 1, 1*armorscale)

		if nz_showhealth:GetInt() > 1 then
			draw.SimpleTextOutlined(armor, smallfont, wr - (lowres and 16 or 15)*scale, hr + 10*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
		end
	end
end

local function PlayerStaminaHUD_t6()
end

local function ZedCounterHUD_t6()
	if not cl_drawhud:GetBool() then return end
	if not nz_showzcounter:GetBool() then return end
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = w - 340*scale
	local hr = h - 234*scale
	if nz_showcompass:GetBool() then
		hr = h - 262*scale
	end
	if nz_showhealth:GetBool() and LocalPlayer():Armor() > 0 and not nz_healthbarstyle:GetBool() then
		wr = w - 368*scale
	end

	surface.SetDrawColor(color_health)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr - (3*scale), hr - (2*scale), 52*scale, 52*scale)

	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr, hr, 49*scale, 49*scale)

	local smallfont = "nz.ammo2.bo1"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	draw.SimpleTextOutlined(GetGlobal2Int("AliveZombies", 0), smallfont, wr + 25*scale, hr + 24*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
end

-- Hooks
hook.Add("HUDPaint", "nzHUDswapping_t6", function()
	if nzMapping.Settings.hudtype == "Tranzit (Black Ops 2)" then
		hook.Add("HUDPaint", "roundHUD", StatesHud_t6 )
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD_t6 )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD_t6 )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud_t6 )
		hook.Add("HUDPaint", "powerupHUD", PowerUpsHud_t6 )
		hook.Add("HUDPaint", "perksHUD", PerksHud_t6 )
		hook.Add("HUDPaint", "vultureVision", VultureVision_t6 )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud_t6 )
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud_t6 )
		hook.Add("HUDPaint", "deathiconsHUD", DeathHud_t6 )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud_t6 )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD_t6 )
		hook.Add("HUDPaint", "zedcounterHUD", ZedCounterHUD_t6 )

		hook.Add("OnRoundPreparation", "BeginRoundHUDChange", StartChangeRound_t6 )
		hook.Add("OnRoundStart", "EndRoundHUDChange", EndChangeRound_t6 )
		hook.Add("OnRoundEnd", "GameEndHUDChange", ResetRound_t6 )
	end
end)

//--------------------------------------------------/GhostlyMoo and Fox's Tranzit HUD\------------------------------------------------\\
