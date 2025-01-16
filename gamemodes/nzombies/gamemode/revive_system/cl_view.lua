-------------------------
-- Localize
local pairs = pairs
local IsValid = IsValid
local LocalPlayer = LocalPlayer
local CurTime = CurTime
local Color = Color

local math = math
local surface = surface
local table = table
local draw = draw

local table_insert = table.insert

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM

CreateClientConVar("nz_bloodoverlay", 1, true, false, "Enable or disable drawing the blood overlay when low health. (0 false, 1 true), Default is 1.", 0, 1)

local cl_drawhud = GetConVar("cl_drawhud")
local nz_bleedouttime = GetConVar("nz_downtime")
local nz_betterscaling = GetConVar("nz_hud_better_scaling")
local nz_bloodoverlay = GetConVar("nz_bloodoverlay")

local zmhud_icon_revive = Material("nz_moo/huds/cod5/waypoint_revive.png", "unlitgeneric smooth")
local zmhud_blood_overlay = Material("nz_moo/huds/t7/i_blood_damage_c.png", "unlitgeneric smooth")
local zmhud_blood_highlight = Material("nz_moo/huds/t7/i_blood_highlights_c.png", "unlitgeneric smooth")
local CircleMaterial = Material("color")
local zmhud_perk_pointer = Material("nz_moo/huds/t6/hud_arrow_down.png", "unlitgeneric smooth")
local zmhud_perk_pointer_up = Material("nz_moo/huds/t6/hud_arrow_up.png", "unlitgeneric smooth")

local vector_up_35 = Vector(0,0,35)

local color_black_100 = Color(0, 0, 0, 100)
local color_black_180 = Color(0, 0, 0, 180)
local color_red_200 = Color(200, 0, 0, 255)
local color_revive = Color(150, 200, 255)

-- Useful ToScreen replacement for better directional
function XYCompassToScreen(pos, boundary)
	local boundary = boundary or 0
	local eyedir = EyeVector()
	local w = ScrW() - boundary
	local h = ScrH() - boundary
	local dir = (pos - EyePos()):GetNormalized()
	dir = Vector(dir.x, dir.y, 0)
	eyedir = Vector(eyedir.x, eyedir.y, 0)

	eyedir:Rotate(Angle(0,-90,0))
	local newdirx = eyedir:Dot(dir)

	return ScrW()/2 + (newdirx*w/2), math.Clamp(pos:ToScreen().y, boundary, h)
end

local fade = 1
local tab = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 0,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

function nzRevive:ResetColorFade()
	tab = {
		 [ "$pp_colour_addr" ] = 0,
		 [ "$pp_colour_addg" ] = 0,
		 [ "$pp_colour_addb" ] = 0,
		 [ "$pp_colour_brightness" ] = 0,
		 [ "$pp_colour_contrast" ] = 1,
		 [ "$pp_colour_colour" ] = 0,
		 [ "$pp_colour_mulr" ] = 0,
		 [ "$pp_colour_mulg" ] = 0,
		 [ "$pp_colour_mulb" ] = 0
	}
	fade = 1
end

function nzRevive:DownedHeadsUp(ply, text)
	nzRevive.Notify[ply] = {time = CurTime(), text = text}
end

function nzRevive:CustomNotify(text, time)
	if !text or !isstring(text) then return end
	if time then
		table.insert(nzRevive.Notify, {time = CurTime() + time, text = text})
	else
		table.insert(nzRevive.Notify, {time = CurTime() + 5, text = text})
	end
end

function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )
	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )

	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s

	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )
end

local function DrawColorModulation()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if nzRevive.Players[ply:EntIndex()] and !nzRound:InState(ROUND_GO) then
		local fadeadd = ((1/(ply.GetBleedoutTime and ply:GetBleedoutTime() or nz_bleedouttime:GetFloat())) * FrameTime()) * -1
		tab[ "$pp_colour_addr" ] = math.Approach(tab[ "$pp_colour_addr" ], 0.28, fadeadd *-0.28)
		tab[ "$pp_colour_mulr" ] = math.Approach(tab[ "$pp_colour_mulr" ], 1, -fadeadd)
		tab[ "$pp_colour_contrast" ] = math.Approach(tab[ "$pp_colour_contrast" ], 0.5, fadeadd *-0.5)
		DrawColorModify(tab)
	end
end

local function DrawDownedPlayers()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawReviveHUD() then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2
	local bleedtime = nz_bleedouttime:GetFloat()
	local pply = LocalPlayer()
	if IsValid(pply:GetObserverTarget()) then
		pply = pply:GetObserverTarget()
	end

	for id, data in pairs(nzRevive.Players) do
		local ply = Entity(id)
		if not IsValid(ply) then continue end

		if ply == pply then continue end
		if not data.DownTime then continue end
		
		local revivor = data.RevivePlayer
		//if IsValid(revivor) and revivor == pply then continue end

		local ppos = ply:GetPos()
		local posxy = (ppos + vector_up_35):ToScreen()

		if posxy.x - 35 < 60 or posxy.x - 35 > w-130 or posxy.y - 50 < 60 or posxy.y - 50 > h-110 then
			posxy.x, posxy.y = XYCompassToScreen((ppos + vector_up_35), 60)
		end

		if ply.GetBleedoutTime then
			bleedtime = ply:GetBleedoutTime()
		end

		local downscale = 1 - math.Clamp((CurTime() - data.DownTime) / bleedtime, 0, 1)
		surface.SetDrawColor(255, 180*downscale, 0)
		surface.SetMaterial(zmhud_icon_revive)
		surface.DrawTexturedRect(posxy.x - 32*scale, posxy.y - 32*scale, 64*scale, 64*scale)

		if IsValid(revivor) and data.ReviveTime then
			local hasrevive = revivor:HasPerk("revive")
			local revtime = revivor:GetReviveTime()
			local revivescale = math.Clamp((CurTime() - data.ReviveTime) / revtime, 0, 1)

			surface.SetDrawColor(color_white)
			if hasrevive then
				surface.SetDrawColor(color_revive)
			end
			surface.SetMaterial(zmhud_icon_revive)
			surface.DrawTexturedRectUV(posxy.x - 32*scale, posxy.y - 32*scale, 64*scale, 64*revivescale*scale, 0, 0, 1, 1*revivescale)
		end
	end
end

local function DrawRevivalProgress()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawReviveHUD() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local reviving = ply:GetPlayerReviving()
	if not IsValid(reviving) then return end
	local id = reviving:EntIndex()

	local hasrevive = ply:HasPerk("revive")
	local revtime = ply:GetReviveTime()
	local bleedtime = nz_bleedouttime:GetFloat()
	local w, h = ScrW(), ScrH()
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = (w/1920 + 1)/2
	end

	local data = nzRevive.Players[id]
	if data and data.RevivePlayer == ply and ply ~= reviving then
		local revivescale = math.Clamp((CurTime() - data.ReviveTime) / revtime, 0, 1)

		if data.DownTime then
			if reviving.GetBleedoutTime then
				bleedtime = reviving:GetBleedoutTime()
			end
			local downscale = 1 - math.Clamp((CurTime() - data.DownTime) / bleedtime, 0, 1)
			surface.SetDrawColor(255, 180*downscale, 0)
			surface.SetMaterial(zmhud_icon_revive)
			surface.DrawTexturedRect(w/2 - 40*pscale, h/2 - 46*pscale, 80*pscale, 80*pscale)
		end

		surface.SetDrawColor(color_white)
		if hasrevive then
			surface.SetDrawColor(color_revive)
		end
		surface.SetMaterial(zmhud_icon_revive)
		surface.DrawTexturedRectUV(w/2 - 40*pscale, h/2 - 46*pscale, 80*pscale, 80*revivescale*pscale, 0, 0, 1, 1*revivescale)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/2 - 150, h - 400*pscale, 300, 20)

		surface.SetDrawColor(color_white)
		if hasrevive then
			surface.SetDrawColor(color_revive)
		end
		surface.DrawRect(w/2 - 145, h - 395*pscale, 290*revivescale, 10)
	end
end

local downed = false
local downdelay = 0

local function DrawDownedNotify()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then
		if ply.downambience and ply.downambience:IsPlaying() then
			ply.downambience:Pause()
		end
		return
	end

	local hudtype = nzMapping.Settings.downsoundtype

	local downdata = {}
	if nzDisplay and nzDisplay.HUDdowndata and nzDisplay.HUDdowndata[hudtype] then
		downdata = nzDisplay.HUDdowndata[hudtype]
	else
		downdata = { -- default/fallback
			loop = "nz_moo/player/t6/laststand_loop.wav",
			revive = "nz_moo/player/t6/plr_revived.wav",
			delay = 0,
			volume = 0.5,
		}
	end

	if downdata and ply.Alive and ply.IsInCreative and (ply:Alive() or ply:IsInCreative()) then
		if not ply.downambience then
			ply.downstring = downdata.loop
			ply.downambience = CreateSound(ply, downdata.loop)
		elseif ply.downstring ~= downdata.loop then
			if ply.downambience:IsPlaying() then ply.downambience:Stop() end

			ply.downstring = downdata.loop
			ply.downambience = CreateSound(ply, downdata.loop)
		end

		if !ply:GetNotDowned() and not downed and !nzRound:InState(ROUND_GO) then
			downed = true
			downdelay = CurTime() + downdata.delay
			if downdata.down then
				surface.PlaySound(downdata.down)
			end
		end
		if (not ply:Alive() or ply:GetNotDowned() or nzRound:InState(ROUND_GO)) and downed then
			downed = false
		end

		if downed and !nzRound:InState(ROUND_GO) then
			if downdelay < CurTime() then
				ply.downambience:Play()
				ply.downambience:ChangeVolume(downdata.volume, 0)
			end
		else
			if downdata.revive and ply.downambience:IsPlaying() and !nzRound:InState(ROUND_GO) then
				surface.PlaySound(downdata.revive)
			end
			ply.downambience:Stop()
		end
	end

	if !ply:ShouldDrawNotificationHUD() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local fakerevivor = ply:GetNW2Int("nzFakeRevivor", 0)
	if (nzRevive.Players and nzRevive.Players[ply:EntIndex()]) or fakerevivor > 0 then
		local rply = fakerevivor > 0 and Entity(fakerevivor) or nzRevive.Players[ply:EntIndex()].RevivePlayer
		if (!ply:GetNotDowned() or fakerevivor > 0) and IsValid(rply) and rply:IsPlayer() then
			local font = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))
			local w, h = ScrW(), ScrH()
			local scale = (w/1920 + 1)/2
			local pscale = 1
			if nz_betterscaling:GetBool() then
				pscale = scale
			end
			if scale < 0.96 then
				font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
			end

			surface.SetFont(font)
			local wt, ht = surface.GetTextSize("I")

			draw.SimpleTextOutlined(rply:Nick().." is reviving you!", font, w/2, h - 220*pscale - ht - 5*pscale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_180)
		end
	end
end

local function DrawDownedHeadsUp()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawNotificationHUD() then return end

	if nzRound:InState(ROUND_GO) then
		if nzRevive.Notify and next(nzRevive.Notify) ~= nil then
			table.Empty(nzRevive.Notify)
		end
		return
	end

	local font = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2
	local count = 0
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = scale
	end
	if scale < 0.96 then
		font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
	end

	surface.SetFont(font)
	for k, v in pairs(nzRevive.Notify) do
		if type(k) == "Player" and IsValid(k) then
			local fade = math.Clamp(CurTime() - v.time - 5, 0, 1)
			local status = v.text or "needs to be revived!"
			local alpha = 255 - (255*fade)
			local wt, ht = surface.GetTextSize(status)
			local offset = ht + 5*pscale

			draw.SimpleTextOutlined(k:Nick().." "..status, font, w/2, h - (220*pscale) + (offset*count), ColorAlpha(color_white, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, ColorAlpha(color_black, 180*(1-fade)))

			if fade >= 1 then nzRevive.Notify[k] = nil end
			count = count + 1
		else
			local fade = math.Clamp(CurTime() - v.time, 0, 1)
			local status = v.text or ""
			local alpha = 255 - (255*fade)
			local wt, ht = surface.GetTextSize(status)
			local offset = ht + 5*pscale

			draw.SimpleTextOutlined(status, font, w/2, h - (220*pscale) + (offset*count), ColorAlpha(color_white, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, ColorAlpha(color_black, 180*(1-fade)))

			if fade >= 1 then nzRevive.Notify[k] = nil end
			count = count + 1
		end
	end
end

local firefade = 0
local lastburn = IsValid(LocalPlayer()) and LocalPlayer():GetNW2Float("nzLastBurn") or 0

local function DrawDamageOverlay()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawReviveHUD() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply.IsOnFire and ply:IsOnFire() or ply:GetNW2Float("nzLastBurn", 0) ~= lastburn then
		if ply:GetNW2Float("nzLastBurn") > lastburn then
			firefade = 3
		else
			firefade = 1
		end
		lastburn = ply:GetNW2Float("nzLastBurn")
	end

	if firefade > 0 then
		local w, h = ScrW(), ScrH()
		surface.SetDrawColor(ColorAlpha(color_white, 255*firefade))
		surface.SetMaterial(zmhud_player_onfire)
		surface.DrawTexturedRect(0, 0, w, h)

		firefade = math.max(firefade - math.min(FrameTime()*5, engine.TickInterval()*5), 0)
	end

	if ply:GetNW2Float("nzLastShock", 0) + 1.25 > CurTime() then
		local ratio = math.Clamp(((ply:GetNW2Float("nzLastShock", 0) + 1.25) - CurTime()) / 1, 0, 1)

		local w, h = ScrW(), ScrH()
		surface.SetDrawColor(ColorAlpha(color_white, 100*ratio))
		surface.SetMaterial(zmhud_player_shocked)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	if nz_bloodoverlay:GetBool() and (ply:Alive() or !ply:GetNotDowned()) then
		local health = ply:Health()
		local diff = ply:GetMaxHealth()*0.2
		local maxhealth = ply:GetMaxHealth() - diff

		if health < maxhealth or !ply:GetNotDowned() then
			local w, h = ScrW(), ScrH()
			local fade = 1 - math.Clamp(health/maxhealth, 0, 1)
			if !ply:GetNotDowned() then fade = 1 end
			local alpha = 255*fade

			surface.SetDrawColor(ColorAlpha(color_white, alpha))

			surface.SetMaterial(zmhud_blood_highlight)
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetMaterial(zmhud_blood_overlay)
			surface.DrawTexturedRect(0, 0, w, h)

			if fade > 0 then
				local pulse = math.abs(math.sin(CurTime()*4))
				surface.SetDrawColor(ColorAlpha(color_white, (255*pulse)*fade))
				surface.SetMaterial(zmhud_blood_overlay)
				surface.DrawTexturedRect(0, 0, w, h)
			end
		end
	end
end

local tombstonetime = nil
local senttombstonerequest = false

local function DrawTombstoneProgress()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then
		if tombstonetime then
			tombstonetime = nil
		end
		return
	end

	local b_spectating = false
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
		b_spectating = true
	end

	if ply:GetDownedWithTombstone() then
		local w, h = ScrW(), ScrH()
		local pscale = 1
		if nz_betterscaling:GetBool() then
			pscale = (w/1920 + 1)/2
		end

		local killtime = 1

		if (b_spectating and ply:HasButtonDown(IN_USE) or ply:KeyDown(IN_USE)) then
			if !tombstonetime then
				tombstonetime = CurTime()
			end

			local pct = math.Clamp((CurTime()-tombstonetime)/killtime, 0, 1)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect(w/2 - 150, h - 500*pscale, 300, 20)
			surface.SetDrawColor(color_white)
			surface.DrawRect(w/2 - 145, h - 495*pscale, 290 * pct, 10)

			if pct >= 1 and !senttombstonerequest then
				net.Start("nz_TombstoneSuicide")
				net.SendToServer()
				senttombstonerequest = true
			end
		else
			tombstonetime = nil
			senttombstonerequest = false
		end
	end
end

local whoswhotime = nil
local sentwhoswhorequest = false
local attacktime = 0

local function DrawWhosWhoProgress()
	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then
		if whoswhotime then
			whoswhotime = nil
		end
		return
	end

	local ply = LocalPlayer()
	local b_spectating = false
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
		if ply.GetDownButtons then
			b_spectating = true
		end
	end

	local curtime = CurTime()

	if ply:HasUpgrade("whoswho") and ply:GetNW2Float("nz.ChuggaTeleDelay",0) < CurTime() then
		local w, h = ScrW(), ScrH()
		local scale = (w/1920 + 1) / 2
		local usetime = 3
		local pscale = 1
		if nz_betterscaling:GetBool() then
			pscale = scale
		end
		local revive = ply:GetPlayerReviving()

		local fuck = true

		if (not ply:IsOnGround())
		or (ply:GetNW2Float("nz.LastHit", 0) + 5) > CurTime()
		or (IsValid(revive) and nzRevive.Players[revive:EntIndex()])
		or (b_spectating and ply:HasButtonDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK)) then
			fuck = false
			attacktime = curtime + 0.5
		end

		if attacktime > curtime then
			fuck = false
		end

		if (b_spectating and ply:HasButtonDown(IN_USE) or ply:KeyDown(IN_USE)) and (b_spectating and ply:HasButtonDown(IN_RELOAD) or ply:KeyDown(IN_RELOAD)) and fuck then
			if !whoswhotime then
				whoswhotime = CurTime()
			end

			local pct = math.Clamp((CurTime() - whoswhotime) / usetime, 0, 1)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect(w/2 - 150, h - 500*pscale, 300, 20)
			surface.SetDrawColor(color_white)
			surface.DrawRect(w/2 - 145, h - 495*pscale, 290 * pct, 10)

			if pct >= 1 and !sentwhoswhorequest then
				net.Start("nz_WhosWhoTeleRequest")
				net.SendToServer()
				sentwhoswhorequest = true
			end
		else
			whoswhotime = nil
			sentwhoswhorequest = false
		end
	end
end

local math_cos = math.cos
local math_sin = math.sin
local math_rad = math.rad
local color_grey_100 = Color(100,100,100,255)
local color_red_70 = Color(255, 70, 70, 255)
local color_yellow_70 = Color(255, 255, 70, 255)
local nz_bleedoutstyle = GetConVar("nz_hud_bleedout_style")
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")
local vector_yellow_70 = Vector(1, 1, 0.2745)

local function DrawBleedoutProgress()
	if nzRound:InState(ROUND_GO) then return end

	local ply = LocalPlayer()
	if !ply:ShouldDrawHUD() then return end
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local id = ply:EntIndex()
	local data = nzRevive.Players[id]
	if not data or not data.DownTime then return end
	if not data.PerksToKeep then return end
	
	local perks = data.PerksToKeep
	if next(perks) == nil then return end

	local CT = CurTime()

	local bleedtime = ply.GetBleedoutTime and ply:GetBleedoutTime() or nz_bleedouttime:GetFloat()
	local revtime = ply:GetReviveTime()
	local timetodeath = data.DownTime + bleedtime - CT
	local progress = 1 - math.Clamp((CT - data.DownTime) / bleedtime, 0, 1)
	local reviving = data.ReviveTime
	if reviving then
		progress = math.Clamp((CT - data.ReviveTime) / revtime, 0, 1)
	end

	local style = nz_bleedoutstyle:GetInt()
	if style == 0 then
		for k, perkdata in ipairs(perks) do
			if (timetodeath / bleedtime) <= perkdata.prc and !perkdata.lost and !reviving then
				perkdata.lost = true
			end
		end
		return
	end

	local w, h = ScrW(), ScrH()
	local pscale = 1
	if nz_betterscaling:GetBool() then
		pscale = (w/1920 + 1)/2
	end

	local icon_x = (w/2)
	local icon_y = (h/2 + 120*pscale)

	if progress > 0 then
		if style == 2 then
			local angle = 360 * progress
			local pipouter = 56*pscale + 6*pscale
			local perkouter = 88*pscale + 6*pscale

			surface.SetMaterial(CircleMaterial)

			surface.SetDrawColor(color_black_100)
			surface.DrawArc(icon_x, icon_y, 42*pscale, -40*pscale, 270 - 360, 270, 48)

			surface.SetDrawColor(color_black_180)
			surface.DrawArc(icon_x, icon_y, 42*pscale, 10*pscale, 270 - 360, 270, 48)

			surface.SetDrawColor(reviving and color_white or color_red_70)
			surface.DrawArc(icon_x, icon_y, 44*pscale, 6*pscale, 270 - angle, 270, 48)

			local pulse = math.abs(math.sin(CT*4))
			local finalpulse = math.Remap(pulse, 0, 1, 0.8, 1)

			local sizex = 50*finalpulse
			local sizey = 16*finalpulse
			local bigx = 54*finalpulse
			local bigy = 20*finalpulse

			local rate = (1/nzMapping.Settings.perkstokeep)/3
			local faderate = math.Remap(progress, 0, 1, -rate, 1) + rate
			local ourcolor = LerpVector(math.min(faderate, 1), Vector(0.8, 0, 0), vector_yellow_70):ToColor()

			surface.SetDrawColor(ColorAlpha(reviving and color_white or ourcolor, 60))
			surface.DrawRect(icon_x - (bigx/2)*pscale, icon_y - (bigy/2)*pscale, bigx*pscale, bigy*pscale)

			surface.SetDrawColor(reviving and color_white or ourcolor)
			surface.DrawRect(icon_x - (sizex/2)*pscale, icon_y - (sizey/2)*pscale, sizex*pscale, sizey*pscale)

			surface.SetDrawColor(ColorAlpha(reviving and color_white or ourcolor, 60))
			surface.DrawRect(icon_x - (bigy/2)*pscale, icon_y - (bigx/2)*pscale, bigy*pscale, bigx*pscale)

			surface.SetDrawColor(reviving and color_white or ourcolor)
			surface.DrawRect(icon_x - (sizey/2)*pscale, icon_y - (sizex/2)*pscale, sizey*pscale, sizex*pscale)

			surface.SetDrawColor(color_white)

			for k, perkdata in ipairs(perks) do
				if (timetodeath / bleedtime) <= perkdata.prc and !perkdata.lost and !reviving then
					perkdata.lost = true
				end

				local fuck = 270 - (360 * perkdata.prc)
				local ourang = math_rad(fuck)

				local pipx = icon_x + math_cos(ourang) * pipouter
				local pipy = icon_y + math_sin(ourang) * pipouter

				surface.SetMaterial(zmhud_perk_pointer)
				surface.DrawTexturedRectRotated(pipx, pipy, 32*pscale, 32*pscale, (360 * perkdata.prc))

				local perkx = icon_x + math_cos(ourang) * perkouter
				local perky = icon_y + math_sin(ourang) * perkouter

				surface.SetDrawColor(perkdata.lost and color_grey_100 or color_white)
				surface.SetMaterial(GetPerkIconMaterial(perkdata.id))
				surface.DrawTexturedRect(perkx - 26*pscale, perky - 26*pscale, 52*pscale, 52*pscale)

				surface.SetDrawColor(color_white)
				surface.SetMaterial(GetPerkFrameMaterial())
				surface.DrawTexturedRect(perkx - 26*pscale, perky - 26*pscale, 52*pscale, 52*pscale)
			end
		else
			local size = 500*pscale
			local bar_y = (h/2 + 120*pscale)
			surface.SetDrawColor(color_black_180)
			surface.DrawRect(w/2 - (size/2) - 3*pscale, bar_y, size + 6*pscale, 20*pscale)

			surface.SetDrawColor(reviving and color_white or color_red_70)
			surface.DrawRect(w/2 - (size/2), bar_y + 3*pscale, size*progress, 14*pscale)

			if not data.PerksToKeep then return end
			local perks = data.PerksToKeep

			surface.SetDrawColor(color_white)

			for k, perkdata in ipairs(perks) do
				if (timetodeath / bleedtime) <= perkdata.prc and !perkdata.lost and !reviving then
					perkdata.lost = true
				end

				local fuck = size*(1 - perkdata.prc)

				surface.SetMaterial(zmhud_perk_pointer_up)
				surface.DrawTexturedRect(w/2 + size/2 - fuck - 16*pscale, bar_y + 24*pscale, 32*pscale, 32*pscale)

				surface.SetDrawColor(perkdata.lost and color_grey_100 or color_white)
				surface.SetMaterial(GetPerkIconMaterial(perkdata.id))
				surface.DrawTexturedRect(w/2 + size/2 - fuck - 26*pscale, bar_y + 42*pscale, 52*pscale, 52*pscale)

				surface.SetDrawColor(color_white)
				surface.SetMaterial(GetPerkFrameMaterial())
				surface.DrawTexturedRect(w/2 + size/2 - fuck - 26*pscale, bar_y + 42*pscale, 52*pscale, 52*pscale)
			end
		end
	end
end

-- Hooks
hook.Add("RenderScreenspaceEffects", "DrawColorModulation", DrawColorModulation )
hook.Add("HUDPaint", "DrawBleedoutProgress", DrawBleedoutProgress )
hook.Add("HUDPaint", "DrawDamageOverlay", DrawDamageOverlay )
hook.Add("HUDPaint", "DrawDownedNotify", DrawDownedNotify )
hook.Add("HUDPaint", "DrawDownedPlayersNotify", DrawDownedHeadsUp )
hook.Add("HUDPaint", "DrawTombstoneProgress", DrawTombstoneProgress )
hook.Add("HUDPaint", "DrawWhosWhoProgress", DrawWhosWhoProgress )

hook.Add("TFA_DrawCrosshair", "ReviveBlockCrosshair", function(wep)
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not IsValid(wep) then return end
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

	local reviving = ply:GetPlayerReviving()
	if IsValid(reviving) and reviving:IsPlayer() and not reviving:GetNotDowned() and wep:GetClass() == nzMapping.Settings.syrette then
		return true
	end
end)

hook.Add("HUDPaint", "nzHUDreviveswap", function()
	local hudtype = nzMapping.Settings.hudtype
	if not nzDisplay or ((nzDisplay and nzDisplay.reworkedHUDs) and (!nzDisplay.reworkedHUDs[hudtype]) or nzDisplay.classicrevive[hudtype]) then
		hook.Add("HUDPaint", "DrawDownedPlayers", DrawDownedPlayers )
		hook.Add("HUDPaint", "DrawRevivalProgress", DrawRevivalProgress )
	end
end)