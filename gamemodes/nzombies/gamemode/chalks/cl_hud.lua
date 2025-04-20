local cvar_hud = GetConVar("cl_drawhud")

local Color = Color
local surface = surface
local draw = draw

local color_grey_120 = Color(120, 120, 120, 255)
local color_grey_80 = Color(80, 80, 80, 255)
local color_black_60 = Color(0, 0, 0, 60)

local iconoverride
local scoreboard = false
local fade_acc = 0
local fade = 0
local dofade = true

hook.Add("ScoreboardShow", "NZ.Chalks.HUD", function()
	scoreboard = true
end)

hook.Add("ScoreboardHide", "NZ.Chalks.HUD", function()
	scoreboard = false
end)

function nzChalks:ChalkHudUpdate(icon)
	iconoverride = icon
	dofade = true
	fade = 0
	fade_acc = 0
end

local function DrawChalkWeaponsHUD()
	if not cvar_hud:GetBool() then return end
	if scoreboard then
		local w, h = ScrW(), ScrH()
		local scale = (w/1920 + 1)/2
		local hscale = h/1080

		local num = nzLocker.HasKey and 1 or 0
		local row = 0
		local size = 72

		for id, data in pairs(nzChalks.Players) do
			local ply = Entity(data.player)
			if not IsValid(ply) or not ply:IsPlayer() then continue end

			surface.SetDrawColor(color_black_60)
			surface.DrawRect(w - 76*scale - num*(size + 6), 12*scale + (76*row), 64, 64)

			if data.icon and not data.icon:IsError() then
				surface.SetDrawColor(color_white)
				surface.SetMaterial(data.icon)
				surface.DrawTexturedRect(w - 76*scale - num*(size + 6), 12*scale + (76*row), 64*scale, 64*scale)
			end

			surface.SetDrawColor(color_grey_120)
			surface.DrawOutlinedRect(w - 80*scale - num*(size + 6), 8*scale + (76*row), 72, 72, 2)

			local pmpath = Hudmat("spawnicons/"..string.gsub(ply:GetModel(),".mdl",".png"))
			if pmpath and not pmpath:IsError() then
				surface.SetDrawColor(color_white)
				surface.SetMaterial(pmpath)
				surface.DrawTexturedRect(w - 78*scale - num*(size + 6), 52*scale + (76*row), 24*scale, 24*scale)
			end

			local pcol = ply:GetPlayerColor()
			pcolor = Color(255*pcol.x, 255*pcol.y, 255*pcol.z, 255)
			surface.SetDrawColor(ColorAlpha(pcolor, 200))
			surface.DrawOutlinedRect(w - 78*scale - num*(size + 6), 10*scale + (76*row), 68, 68, 2)

			num = num + 1
			if num%8 == 0 then
				row = row + 1
				num = 0
			end
		end
	elseif dofade and iconoverride then
		local w, h = ScrW(), ScrH()
		local scale = (w/1920 + 1)/2

		fade_acc = fade_acc + FrameTime()
		fade = math.abs(math.sin(fade_acc))

		if fade_acc >= 1 and math.Round(fade,2) <= 0 then
			fade = 0
			fade_acc = 0
			dofade = false
			iconoverride = nil
		end

		surface.SetDrawColor(ColorAlpha(color_black, 60*fade))
		surface.DrawRect(w - 76*scale, 12*scale, 64, 64)

		surface.SetDrawColor(ColorAlpha(color_grey_120, 220*fade))
		surface.DrawOutlinedRect(w - 80*scale, 8*scale, 72, 72, 2)
		surface.SetDrawColor(ColorAlpha(color_grey_80, 220*fade))
		surface.DrawOutlinedRect(w - 78*scale, 10*scale, 68, 68, 2)

		if iconoverride and not iconoverride:IsError() then
			surface.SetDrawColor(ColorAlpha(color_white, 300*fade))
			surface.SetMaterial(iconoverride)
			surface.DrawTexturedRect(w - 76*scale, 12*scale, 64*scale, 64*scale)
		end
	end
end

hook.Add("HUDPaint", "NZ.Chalks.HUD", DrawChalkWeaponsHUD)
