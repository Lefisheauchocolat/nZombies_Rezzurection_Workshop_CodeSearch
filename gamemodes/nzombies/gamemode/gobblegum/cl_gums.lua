
local nz_showhealth = GetConVar("nz_hud_show_health")
local nz_healthbarstyle = GetConVar("nz_hud_health_style")
local nz_showcompass = GetConVar("nz_hud_show_compass")
local nz_showzcounter = GetConVar("nz_hud_show_alive_counter")
local nz_showmmostats = GetConVar("nz_hud_show_perkstats")

local CircleMaterial = Material("gum_circle/4.png")
local visual_prgr = 1
local last_prgr_changetime = 0
local last_prgr = 1
local last_gum

local last_deny = 0

local newgum_showing = false
local newgum_sting = true
local newgum_start = 0

function nzGum:GetHowActivatesText(gumid)
	local gum = nzGum.Gums[gumid]
	if gum.type == nzGum.Types.USABLE then
		return "Has " .. gum.uses .. " uses"
	elseif gum.type == nzGum.Types.SPECIAL then
		return gum.desc_howactivates or ""
	elseif gum.type == nzGum.Types.USABLE_WITH_TIMER then
		return "Lasts " .. gum.time .. " seconds and has " .. gum.uses .. " uses"
	elseif gum.type == nzGum.Types.ROUNDS then
		return "Lasts " .. gum.rounds .. " rounds"
	elseif gum.type == nzGum.Types.TIME then
		return "Lasts " .. gum.time .. " seconds"
	end
	return ""
end

net.Receive("nz_GumDenyNotif", function(len, _)
	nzGum:DenyNotifcation()
end)

function nzGum:DenyNotifcation()
	if last_deny > CurTime() then return end

	last_deny = CurTime() + 0.5
end

net.Receive("nzGum_SyncGumsCount", function(len)
	local ply = LocalPlayer()
	ply.nzGum_GumsCount = net.ReadTable()
end)

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

hook.Add("HUDPaint", "nzGum", function()
	local ply = LocalPlayer()
	local scrh = ScrH()
	local scrw = ScrW()
	local scale = (scrw/1920 + 1) / 2

	local gumid = nzGum:GetActiveGum(ply) or last_gum
	local ct = CurTime()

	if newgum_showing then
		local gum = nzGum.Gums[last_gum]

		if newgum_sting then 
			newgum_sting = false 
			surface.PlaySound("bo3/gobblegum/default/bgb_powerup_base.mp3")
		end

		if newgum_start + 5 < ct then
			newgum_showing = false
			newgum_sting = true
		end

		if newgum_showing and gum then
			local size = 96
			local max_size = 110
			local size_gum = size
			local smallfont = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
			local fontcolor = Color(255, 255, 255, 255)

			local icon = gum.icon
			local icon_x = scrw / 2 - size / 2
			local icon_y = 150

			surface.SetMaterial(icon)
			if newgum_start + .5 > ct then
				surface.SetDrawColor(color_white)
				size_gum = Lerp(math.ease.OutSine((ct - newgum_start) / .5), 0, max_size)
			elseif newgum_start + .7 > ct then
				surface.SetDrawColor(color_white)
				size_gum = Lerp(math.ease.OutSine((ct - newgum_start - .5) / .2), max_size, size)
			elseif newgum_start + 4 < ct then
				local alpha = Lerp(math.ease.InCirc(ct - 4 - newgum_start), 255, 0)
				surface.SetDrawColor(ColorAlpha(color_white, alpha))
				fontcolor.a = alpha
			else
				surface.SetDrawColor(color_white)
			end
			surface.DrawTexturedRect(scrw / 2 - size_gum / 2, icon_y, size_gum, size_gum)

			local text_y_maxoffset = icon_y + size
			if gum.desc then
				for _, desc in pairs(string.Split(gum.desc, "\n")) do
					draw.SimpleTextOutlined(string.Trim(desc), smallfont, icon_x + size / 2, text_y_maxoffset, fontcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
					text_y_maxoffset = text_y_maxoffset + 35
				end
			end

			local how_activates = nzGum:GetHowActivatesText(last_gum)
			draw.SimpleTextOutlined(how_activates, smallfont, icon_x + size / 2, text_y_maxoffset + 50, fontcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, color_black)
		end
	end

	local huddata = nzDisplay.GumPosition[nzMapping.Settings.hudtype]
	local size = 72*scale
	if huddata and huddata.icon_size then
		size = huddata.icon_size*scale
	end

	if gumid and gumid != "" then
		local gum = nzGum.Gums[gumid]

		local icon = gum.icon
		local icon_x = scrw - (180)*scale
		local icon_y = scrh - (272)*scale
		surface.SetMaterial(icon)
		if huddata then
			icon_x = scrw - huddata.x*scale
			icon_y = scrh - huddata.y*scale
		end

		if huddata and nz_showzcounter:GetBool() then
			if huddata.zcounter_x then
				icon_x = icon_x - (huddata.zcounter_x)*scale
			end
			if huddata.zcounter_y then
				icon_y = icon_y - (huddata.zcounter_y)*scale
			end
		end
		if huddata and nz_showhealth:GetBool() and ply:Armor() > 0 and not nz_healthbarstyle:GetBool() then
			if huddata.armor_x then
				icon_x = icon_x - (huddata.armor_x)*scale
			end
			if huddata.armor_y then
				icon_y = icon_y - (huddata.armor_y)*scale
			end
		end

		local gumcol = color_white
		if last_deny > CurTime() then
			local ratio = 1 - ((last_deny - CurTime())/0.5)
			gumcol = Color(255, 255*ratio, 255*ratio, 255)
		end

		surface.SetDrawColor(gumcol)
		surface.DrawTexturedRect(icon_x, icon_y, size, size)

		local progress = 1

		local progress_x = icon_x + size / 2
		local progress_y = icon_y + size / 2

		local ringsize = 32
		local ringwidth = 6
		if huddata and huddata.ring_size then
			ringsize = huddata.ring_size
		end
		if hudata and huddata.width then
			ringwidth = huddata.width
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
				progress = (usesremain - 1) / gum.uses

				local time_pgrs_left = 1 - (CurTime() - timeleft) / gum.time
				if time_pgrs_left > 0 then
					local one_bar_angle = (360 / gum.uses)
					local angle = one_bar_angle * time_pgrs_left
					local offset = 360 * progress
					surface.SetDrawColor(255, 255, 255, 140)
					surface.SetMaterial(CircleMaterial)
					surface.DrawArc(progress_x, progress_y, ringsize*scale, ringwidth*scale, 270 - angle - offset, 270 - offset, 50)
				end
			else
				progress = usesremain / gum.uses
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

		local angle = 360 * progress
		local offset = 0
		if progress > 0 then
			surface.SetDrawColor(255, 255, 255, 140)
			surface.SetMaterial(CircleMaterial)
			surface.DrawArc(progress_x, progress_y, ringsize*scale, ringwidth*scale, 270 - angle - offset, 270 - offset, 50)

			if last_gum != gumid then
				last_gum = gumid

				newgum_start = CurTime()
				newgum_showing = true
			end
		else
			last_gum = ""
		end
	end
end)

local vertCache = {}
for i = 1, 256 do
	vertCache[i] = { x = 0, y = 0, u = 0, v = 0, }
end
local math_rad = math.rad
local math_cos = math.cos
local math_sin = math.sin
local math_max = math.max
local surface_DrawPoly = surface.DrawPoly

function surface.DrawArc(centerX,centerY,radius,thickness,startAngle,endAngle,numSegments)

	numSegments = math_max(numSegments or 50, 1)

	local temp = nil

	-- Setup angles and rotation
	local angle = math_rad(startAngle or 0)
	local sweep = math_rad(endAngle or 360) - angle
	local increment = sweep / numSegments
	local cos = math_cos(increment)
	local sin = math_sin(increment)
	local x = math_cos(angle)
	local y = math_sin(angle)
	local invSegments = 1 / numSegments

	-- Gather vertices from cache
	local v0 = vertCache[1]
	local v1 = vertCache[2]
	local v2 = vertCache[3]
	local v3 = vertCache[4]

	-- Negative thickness pushes the radius inward
	if thickness < 0 then
		radius = radius + thickness
		thickness = -thickness
	end

	local outer = radius + (thickness or 10)

	-- Put a 'notch' in the cache so only these vertices are drawn
	local prevCache = vertCache[5]
	vertCache[5] = nil

	-- Each segment is 4 vertices
	for i=1, numSegments do

		-- Set vertices for this segment
		v0.x = centerX + x * outer
		v0.y = centerY + y * outer
		v0.u = (i-1) * invSegments
		v0.v = 0
		v3.x = centerX + x * radius
		v3.y = centerY + y * radius
		v3.u = (i-1) * invSegments
		v3.v = 1

		-- Rotate the current frame by increment
		temp = x * cos - y * sin
		y = x * sin + y * cos
		x = temp

		-- Set vertices for the next segment
		v1.x = centerX + x * outer
		v1.y = centerY + y * outer
		v1.u = i * invSegments
		v1.v = 0
		v2.x = centerX + x * radius
		v2.y = centerY + y * radius
		v2.u = i * invSegments
		v2.v = 1

		surface_DrawPoly( vertCache )

	end

	-- Restore vertex cache
	vertCache[5] = prevCache
end
