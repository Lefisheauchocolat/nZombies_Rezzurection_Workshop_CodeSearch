if GetConVar("nz_hud_inventory_style") == nil then
	CreateClientConVar("nz_hud_inventory_style", 0, true, true, "Changes the set look of the buildable inventory. (0 Config's, 1 Classic, 2 Modern), Default is 0.", 0, 2)
end

local nz_newinventory = GetConVar("nz_hud_inventory_style")

local cvar_hud = GetConVar("cl_drawhud")

local Color = Color
local surface = surface
local draw = draw

local color_white_150 = Color(255, 255, 255, 150)
local color_white_100 = Color(255, 255, 255, 150)
local color_black_180 = Color(0, 0, 0, 180)
local color_red_200 = Color(255, 0, 0, 200)
local color_grey_120 = Color(120, 120, 120, 255)
local color_grey_80 = Color(80, 80, 80, 255)
local color_black_60 = Color(0, 0, 0, 60)

local hud_icon_check = Material("vgui/icon/thumbsup.png", "unlitgeneric smooth")
local hud_icon_cross = Material("vgui/icon/thumbsdown.png", "unlitgeneric smooth")

local scoreboard = false
hook.Add("ScoreboardShow", "nzBuilds.HUD", function()
	scoreboard = true
end)
hook.Add("ScoreboardHide", "nzBuilds.HUD", function()
	scoreboard = false
end)

local function DrawBuildPartsCarryHud()
	if not cvar_hud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2
	local num = 0
	local row = 0

	if (nz_newinventory:GetInt() == 1) or (!nzBuilds.ModernInventory and (nz_newinventory:GetInt() ~= 2)) then
		surface.SetDrawColor(color_white)

		for key, data in pairs(nzBuilds:GetHeldParts()) do
			if not data or not data.build then continue end

			local tbl = nzBuilds:GetBuildParts(data.build)
			local icon = tbl[data.id].icon
			local size = 50

			if icon then
				surface.SetMaterial(icon)
				surface.DrawTexturedRect(w - (520*scale) - num*(size + 6)*scale, h - 70*scale - (row*64), size*scale, size*scale)

				num = num + 1
				if num%8 == 0 then
					row = row + 1
					num = 0
				end
			end
		end
	else
		if not scoreboard then return end

		size = 72
		if nzLocker.HasKey then
			num = 1
		end
		if nzChalks.Players then
			num = num + #nzChalks.Players
		end

		for key, data in pairs(nzBuilds:GetHeldParts()) do
			if not data or not data.build then continue end

			local tbl = nzBuilds:GetBuildParts(data.build)
			local icon = tbl[data.id].icon

			if icon and not icon:IsError() then
				surface.SetDrawColor(color_black_60)
				surface.DrawRect(w - 76*scale - num*(size + 6), 12*scale + (76*row), 64, 64)

				surface.SetDrawColor(color_white)
				surface.SetMaterial(icon)
				surface.DrawTexturedRect(w - 76*scale - num*(size + 6), 12*scale + (76*row), 64*scale, 64*scale)

				surface.SetDrawColor(color_grey_120)
				surface.DrawOutlinedRect(w - 80*scale - num*(size + 6), 8*scale + (76*row), 72, 72, 2)
				surface.SetDrawColor(color_grey_80)
				surface.DrawOutlinedRect(w - 78*scale - num*(size + 6), 10*scale + (76*row), 68, 68, 2)

				num = num + 1
				if num%8 == 0 then
					row = row + 1
					num = 0
				end
			end
		end
	end
end

local function DrawPlayerBuildablesHud()
	if not cvar_hud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	if not scoreboard then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2
	
	local row = 0
	local num = 0
	local size = 72
	local buildables = ply:GetBuildables()
	local ammo2font = ("nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font))
	local wscale = w/1920
	local hscale = h/1080

	if table.IsEmpty(buildables) then return end

	for _, ent in pairs(buildables) do
		if IsValid(ent) and ent:GetMaxHealth() > 0 then
			if ent:IsPlayer() then continue end

			surface.SetDrawColor(ColorAlpha(color_black, 60))
			surface.DrawRect(wscale + 11 + num*(size + 6), hscale + 36*scale + (76*row) - 24, 64, 64)

			surface.SetDrawColor(ColorAlpha(color_grey_120, 220))
			surface.DrawOutlinedRect(wscale + 7 + num*(size + 6), hscale + 32*scale + (76*row) - 24, 72, 72, 2)
			surface.SetDrawColor(ColorAlpha(color_grey_80, 220))
			surface.DrawOutlinedRect(wscale + 9 + num*(size + 6), hscale + 34*scale + (76*row) - 24, 68, 68, 2)

			local icon = ent.NZHudIcon or ent.NZThrowIcon
			if icon and not icon:IsError() then
				surface.SetDrawColor(color_white)
				surface.SetMaterial(icon)
				surface.DrawTexturedRect(wscale + 11 + num*(size + 6), hscale + 12*scale + (76*row), 64*scale, 64*scale)
			end

			if ent.GetActivated then
				local indicator = hud_icon_cross
				if ent:GetActivated() then
					indicator = hud_icon_check
				end
				surface.SetDrawColor(color_white)
				surface.SetMaterial(indicator)
				surface.DrawTexturedRect(wscale + 11 + num*(size + 6), hscale + 12*scale + (76*row), 24*scale, 24*scale)
			end

			local health = ent:Health()
			local maxhealth = ent:GetMaxHealth()

			local healthscale = math.Clamp(health / maxhealth, 0, 1)
			local healthcolor = Color(255, 300*healthscale, 300*healthscale, 255)

			surface.SetDrawColor(color_black_180)
			surface.DrawRect(wscale + 13 + num*(size + 6), (hscale + 44*scale) + (76*row) + 24, 60, 10)
			surface.SetDrawColor(healthcolor)
			surface.DrawRect(wscale + 15 + num*(size + 6), (hscale + 46*scale) + (76*row) + 24, 56 * healthscale, 6)

			if ent:IsDormant() then
				draw.SimpleTextOutlined("[PVS]", ammo2font, wscale + 43 + num*(size + 6), hscale + 48*scale + (76*row), color_red_200, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, color_black_180)
			end

			num = num + 1
			if num%8 == 0 then
				row = row + 1
				num = 0
			end
		end
	end
end

hook.Add("HUDPaint", "nzBuildsPartsHUD", DrawBuildPartsCarryHud)
hook.Add("HUDPaint", "nzBuildsPlayerHUD", DrawPlayerBuildablesHud)