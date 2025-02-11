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

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM

local cl_drawhud = GetConVar("cl_drawhud")
local nz_bleedouttime = GetConVar("nz_downtime")
local t5_hud_revive = Material("nz_moo/huds/t5/uie_t5hud_waypoint_revive.png", "unlitgeneric smooth")

local vector_up_35 = Vector(0,0,35)

local color_white_100 = Color(255, 255, 255, 100)
local color_black_180 = Color(0, 0, 0, 180)
local color_black_100 = Color(0, 0, 0, 100)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_50 = Color(255, 0, 0, 50)
local color_green_50 = Color(0, 255, 0, 50)
local color_revive = Color(150, 200, 255)

local function DrawDownedPlayers_t5()
	local pply = LocalPlayer()
	if !pply:ShouldDrawHUD() then return end
	if !pply:ShouldDrawReviveHUD() then return end
	if IsValid(pply:GetObserverTarget()) then
		pply = pply:GetObserverTarget()
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2
	local bleedtime = nz_bleedouttime:GetFloat()

	for id, data in pairs(nzRevive.Players) do
		local ply = Entity(id)
		if not IsValid(ply) then continue end
		
		if ply == pply then continue end
		if not data.DownTime then continue end

		local revivor = data.RevivePlayer
		if IsValid(revivor) and revivor == pply then continue end

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
		surface.SetMaterial(t5_hud_revive)
		surface.DrawTexturedRect(posxy.x - 32*scale, posxy.y - 32*scale, 64*scale, 64*scale)

		if IsValid(revivor) and data.ReviveTime then
			local hasrevive = revivor:HasPerk("revive")
			local revtime = ply:GetReviveTime(revivor)
			local revivescale = math.Clamp((CurTime() - data.ReviveTime) / revtime, 0, 1)

			surface.SetDrawColor(color_white)
			if hasrevive then
				surface.SetDrawColor(color_revive)
			end
			surface.SetMaterial(t5_hud_revive)
			surface.DrawTexturedRectUV(posxy.x - 32*scale, posxy.y - 32*scale, 64*scale, 64*revivescale*scale, 0, 0, 1, 1*revivescale)
		end
	end
end

local function DrawRevivalProgress_t5()
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
	local revtime = reviving:GetReviveTime(ply)
	local bleedtime = nz_bleedouttime:GetFloat()
	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2

	local data = nzRevive.Players[id]
	if data and data.RevivePlayer == ply and ply ~= reviving then
		local revivescale = math.Clamp((CurTime() - data.ReviveTime) / revtime, 0, 1)

		if data.DownTime then
			if reviving.GetBleedoutTime then
				bleedtime = reviving:GetBleedoutTime()
			end
			local downscale = 1 - math.Clamp((CurTime() - data.DownTime) / bleedtime, 0, 1)
			surface.SetDrawColor(255, 180*downscale, 0)
			surface.SetMaterial(t5_hud_revive)
			surface.DrawTexturedRect(w/2 - 40*scale, h/2 - 46*scale, 80*scale, 80*scale)
		end

		surface.SetDrawColor(color_white)
		if hasrevive then
			surface.SetDrawColor(color_revive)
		end
		surface.SetMaterial(t5_hud_revive)
		surface.DrawTexturedRectUV(w/2 - 40*scale, h/2 - 46*scale, 80*scale, 80*revivescale*scale, 0, 0, 1, 1*revivescale)

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/2 - 150*scale, h - 400*scale, 300*scale, 20*scale)

		surface.SetDrawColor(color_white)
		if hasrevive then
			surface.SetDrawColor(color_revive)
		end
		surface.DrawRect(w/2 - 145*scale, h - 395*scale, 290*revivescale*scale, 10*scale)
	end
end

-- Hooks
hook.Add("HUDPaint", "nzHUDreviveswap_t5", function()
	if nzDisplay and nzDisplay.t5revive and nzDisplay.t5revive[nzMapping.Settings.hudtype] then
		hook.Add("HUDPaint", "DrawDownedPlayers", DrawDownedPlayers_t5 )
		hook.Add("HUDPaint", "DrawRevivalProgress", DrawRevivalProgress_t5 )
	end
end)
