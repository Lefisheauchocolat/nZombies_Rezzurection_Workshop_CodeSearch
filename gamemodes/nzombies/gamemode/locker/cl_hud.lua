local cvar_hud = GetConVar("cl_drawhud")

local Color = Color
local surface = surface
local draw = draw

local color_grey_120 = Color(120, 120, 120, 255)
local color_grey_80 = Color(80, 80, 80, 255)

local scoreboard = false
local fade_acc = 0
local fade = 0
local dofade = true

hook.Add("ScoreboardShow", "NZ.Locker.HUD", function()
	scoreboard = true
end)

hook.Add("ScoreboardHide", "NZ.Locker.HUD", function()
	scoreboard = false
end)

local function ReceiveKeyHudSync( length )
	local icon = net.ReadString()
	nzLocker.KeyIcon = Material(icon, "unlitgeneric smooth")

	dofade = true
	fade = 0
	fade_acc = 0
end

net.Receive("nzLocker.HudUpdate", ReceiveKeyHudSync)

local function DrawKeyHud()
	if not cvar_hud:GetBool() then return end
	if not nzLocker.HasKey then return end
	if !scoreboard and !dofade then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2

	fade_acc = fade_acc + FrameTime()
	fade = math.abs(math.sin(fade_acc))

	if fade_acc >= 1 and math.Round(fade,2) <= 0 then
		fade = 0
		fade_acc = 0
		dofade = false
	end
	if scoreboard then
		fade = 1
	end

	surface.SetDrawColor(ColorAlpha(color_black, 60*fade))
	surface.DrawRect(w - 76*scale, 12*scale, 64, 64)

	surface.SetDrawColor(ColorAlpha(color_grey_120, 220*fade))
	surface.DrawOutlinedRect(w - 80*scale, 8*scale, 72, 72, 2)
	surface.SetDrawColor(ColorAlpha(color_grey_80, 220*fade))
	surface.DrawOutlinedRect(w - 78*scale, 10*scale, 68, 68, 2)

	local icon = nzLocker.KeyIcon
	if icon and not icon:IsError() then
		surface.SetDrawColor(ColorAlpha(color_white, 300*fade))
		surface.SetMaterial(icon)
		surface.DrawTexturedRect(w - 76*scale, 12*scale, 64, 64)
	end
end

hook.Add("HUDPaint", "NZ.Locker.HUD", DrawKeyHud)

local color_red = Color(220, 0, 0, 255)
hook.Add("PreDrawHalos", "NZ.Locker.KeyHalo", function()
	local ply = LocalPlayer()
	local tr = ply:GetEyeTrace()
	local ent = tr.Entity
	if IsValid(ent) and ent:GetClass() == "nz_keyspawn" and tr.StartPos:DistToSqr(tr.HitPos) < 10000 and ent.GetCustomGlow and !ent:GetUsed() then
		local color = ent:GetCustomGlow()
		if color == vector_origin then return end
		halo.Add({[1] = ent}, Color(color[1]*255, color[2]*255, color[3]*255, 255), 2, 2, 1, true, false) //bad
	end
end)
