local cvar_hud = GetConVar("cl_drawhud")

local Color = Color
local surface = surface
local draw = draw

local color_red_200 = Color(200,0,0,255)
local color_red = Color(220,60,50,255)
local color_gold = Color(255,230,0,255)
local color_backing = Color(180,180,180,255)
local color_unavailable = Color(150,150,150,200)
local color_invis = Color(255, 255, 255, 0)

local hud_stopwatch = Material("vgui/icon/zombie_stopwatch.png", "unlitgeneric smooth")
local hud_stopwatch_glass = Material("vgui/icon/zombie_stopwatch_glass.png", "unlitgeneric smooth")
local hud_stopwatch_needle = Material("vgui/icon/zombie_stopwatchneedle.png", "unlitgeneric smooth")

local menu_bg = Material("vgui/wf_bg.png", "unlitgeneric smooth")
local menu_focus_pip = Material("vgui/uie_ui_menu_store_focus_pips.png", "unlitgeneric smooth")
local menu_marker = Material("vgui/uie_ui_menu_common_equipped_marker_with_backing.png", "unlitgeneric smooth")
local menu_backing = Material("vgui/uie_ui_menu_optionsmenu_hdr_backing.png", "unlitgeneric smooth")

local lasttime = 0
local function DrawStopWatchHud()
	if not cvar_hud:GetBool() then return end
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply:GetNW2Float("nzStopWatch", 0) < CurTime() then
		if lasttime ~= 0 then
			lasttime = 0
		end
	return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1)/2

	surface.SetDrawColor(color_white)

	surface.SetMaterial(hud_stopwatch)
	surface.DrawTexturedRect(w - 320*scale, 64*scale, 256*scale, 256*scale)

	surface.SetMaterial(hud_stopwatch_glass)
	surface.DrawTexturedRect(w - 320*scale, 64*scale, 256*scale, 256*scale)

	local time = math.ceil(ply:GetNW2Float("nzStopWatch", 0) - CurTime())
	local ratio = math.Clamp(time/60, 0, 1)
	if lasttime ~= time and time <= 60 then
		if lasttime ~= 0 then
			surface.PlaySound("nzr/2023/trials/timer.wav")
		end
		lasttime = time
	end

	surface.SetMaterial(hud_stopwatch_needle)
	surface.DrawTexturedRectRotated(w - 192*scale, 192*scale, 256*scale, 256*scale, -360*ratio)
end

hook.Add("HUDPaint", "nzStopWatchHUD", DrawStopWatchHud)

local function ReceiveWunderFizz( length )
	local trialid = net.ReadString()
	local usefizzlist = net.ReadBool()
	local ply = LocalPlayer()
	local starttime = CurTime()
	local music = false

	local scale = (ScrW()/1920 + 1)/2
	local lowres = scale < 0.96

	local font = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
	local font2 = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
	local ammo = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
	if lowres then
		font = "nz.points."..GetFontType(nzMapping.Settings.smallfont)
		font2 = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammo = "nz.ammo2."..GetFontType(nzMapping.Settings.ammofont)
	end

	local panel = vgui.Create("DPanel")

	local function KillPanel()
		if ply.fizzmusic then
			ply.fizzmusic:Stop()
			ply.fizzmusic = nil
		end
		surface.PlaySound("nzr/2023/trials/ui_toggle.wav")
		panel:Remove()
	end

	panel:SetSize(1024*scale,512*scale)
	panel:Center()
	panel:SetPaintBackground(false)
	panel:MakePopup(true)
	panel.Think = function()
		if starttime + 30 < CurTime() and not music then
			music = true
			ply.fizzmusic = CreateSound(ply, "nzr/2023/trials/fizz_mus_0"..math.random(4)..".ogg")
		end

		//after 2.5 minutes kill the menu, incase i fucked something up...

		if starttime + 150 < CurTime() then
			KillPanel()
		end

		if ply.fizzmusic then
			ply.fizzmusic:Play()
			ply.fizzmusic:ChangeVolume(0.5,0)
		end
	end

	local close = vgui.Create("DButton", panel)
	close:SetColor(color_white)
	close:SetFont("DermaDefaultBold")
	close:SetText("CLOSE")
	close:SetPos(108*scale, 428*scale)
	close:SetSize(128*scale, 32*scale)
	close:SetDrawOnTop(true)
	close.DoClick = function()
		KillPanel()
	end

	local background = vgui.Create("DImage", panel)
	background:SetSize(panel:GetSize())
	background:SetMaterial(menu_bg)

	local name = vgui.Create("DLabel", panel)
	name:SetSize(512*scale, 64*scale)
	name:SetPos(100*scale, 20*scale)
	name:SetTextColor(color_red)
	name:SetFont(font)
	name:SetText("Buy or Upgrade any Perk")

	local desc = vgui.Create("DLabel", panel)
	desc:SetSize(860*scale, 64*scale)
	desc:SetPos(100*scale, 72*scale)
	desc:SetFont(ammo)
	desc:SetText("Pick a perk!")

	if ply:GetTrialRewardUsed(trialid) then
		local warning = vgui.Create("DLabel", panel)
		warning:SetSize(240*scale, 64*scale)
		warning:SetPos(720*scale, 20*scale)
		warning:SetTextColor(color_red_200)
		warning:SetFont(font2)
		warning:SetText("Reward Claimed!")
	end

	local size = 52
	local num = 0
	local row = 0

	for perk, data in SortedPairs(nzPerks.Data) do
		if data.specialmachine then continue end
		if usefizzlist then
			local fizzlist = nzMapping.Settings.wunderfizzperklist
			if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then
				continue
			end
		end

		local perkback = vgui.Create("DImage", panel)
		perkback:SetPos(100*scale + num*(size + 24)*scale, 148*scale + (72*row)*scale)
		perkback:SetSize(64*scale,64*scale)
		perkback:SetMaterial(menu_backing)
		perkback:SetImageColor(color_backing)

		local perkframe = vgui.Create("DImage", panel)
		perkframe:SetPos(106*scale + num*(size + 24)*scale, 156*scale + (72*row)*scale)
		perkframe:SetDrawOnTop(true)
		perkframe:SetSize(size*scale,size*scale)
		perkframe:SetMaterial(GetPerkFrameMaterial())
		perkframe:SetImageColor(color_invis)
		perkframe.Think = function()
			if ply:HasPerk(perk) then
				perkframe:SetImageColor(color_gold)
			end
		end

		local hover = vgui.Create("DImage", panel)
		hover:SetPos(91*scale + num*(size + 24)*scale, 139*scale + (72*row)*scale)
		hover:SetSize(80*scale,80*scale)
		hover:SetMaterial(menu_focus_pip)
		hover:SetImageColor(color_invis)
		hover:SetDrawOnTop(true)

		local perkdata = vgui.Create("DImageButton", panel)
		perkdata:SetPos(106*scale + num*(size + 24)*scale, 156*scale + (72*row)*scale)
		perkdata:SetSize(size*scale,size*scale)
		perkdata:SetColor(color_white)
		perkdata:SetMaterial(GetPerkIconMaterial(perk))
		perkdata:SetMouseInputEnabled(true)

		perkdata.OnCursorEntered = function()
			hover:SetImageColor(color_white)
			surface.PlaySound("nzr/2023/trials/cac_main_nav.wav")
		end

		perkdata.OnCursorExited = function()
			hover:SetImageColor(color_invis)
		end

		perkdata.Think = function()
			if ply:HasPerk(perk) and ply:HasUpgrade(perk) then
				perkdata:SetColor(color_unavailable)
			end

			if perkdata:IsHovered() then
				if ply:HasPerk(perk) then
					name:SetText("[Upgrade] "..data.name)
					if data.desc2 then
						desc:SetText(data.desc2)
					end
				else
					name:SetText("[Buy] "..data.name)
					if data.desc then
						desc:SetText(data.desc)
					end
				end
			end
		end

		perkdata.DoClick = function()
			if ply.NextPerkBuy and ply.NextPerkBuy > CurTime() then return end
			if ply:GetTrialCompleted(trialid) and !ply:GetTrialRewardUsed(trialid) and !ply:HasUpgrade(perk) then
				net.Start("nzTrialsBuyPerk")
					net.WriteString(trialid)
					net.WriteString(perk)
					net.WriteBool(ply:HasPerk(perk)) //upgrade
				net.SendToServer()

				surface.PlaySound("nzr/2023/trials/uin_perkmachine_purchase_plr.wav")
				surface.PlaySound("nzr/2023/trials/mus_wunderfizz_sting.wav")

				ply.NextPerkBuy = CurTime() + 4
				KillPanel()
			else
				surface.PlaySound("nzr/2023/trials/deny.wav")
			end
		end

		num = num + 1
		if num%11 == 0 then
			row = row + 1
			num = 0
		end
	end

	local perkback = vgui.Create("DImage", panel)
	perkback:SetPos(100*scale + num*(size + 24)*scale, 148*scale + (72*row)*scale)
	perkback:SetSize(64*scale,64*scale)
	perkback:SetMaterial(menu_backing)
	perkback:SetImageColor(color_backing)

	local hover = vgui.Create("DImage", panel)
	hover:SetPos(91*scale + num*(size + 24)*scale, 139*scale + (72*row)*scale)
	hover:SetSize(80*scale,80*scale)
	hover:SetMaterial(menu_focus_pip)
	hover:SetImageColor(color_invis)
	hover:SetDrawOnTop(true)

	local perkframe = vgui.Create("DImageButton", panel)
	perkframe:SetPos(106*scale + num*(size + 24)*scale, 156*scale + (72*row)*scale)
	perkframe:SetDrawOnTop(true)
	perkframe:SetSize(size*scale,size*scale)
	perkframe:SetMaterial(GetPerkFrameMaterial())

	perkframe.OnCursorEntered = function()
		hover:SetImageColor(color_white)
		surface.PlaySound("nzr/2023/trials/cac_main_nav.wav")
	end

	perkframe.OnCursorExited = function()
		hover:SetImageColor(color_invis)
	end

	perkframe.Think = function()
		if perkframe:IsHovered() then
			name:SetText("[Buy] Perk Slot")
			desc:SetText("Gain an additional Perk Slot.")
		end
	end

	perkframe.DoClick = function()
		if ply.NextPerkBuy and ply.NextPerkBuy > CurTime() then return end
		if ply:GetTrialCompleted(trialid) and !ply:GetTrialRewardUsed(trialid) and !ply:HasUpgrade(perk) then
			net.Start("nzTrialsBuyPerk")
				net.WriteString(trialid)
				net.WriteString("perk_slot")
				net.WriteBool(false) //upgrade
			net.SendToServer()

			surface.PlaySound("nzr/2023/trials/uin_perkmachine_purchase_plr.wav")
			surface.PlaySound("nzr/2023/trials/mus_wunderfizz_sting.wav")

			ply.NextPerkBuy = CurTime() + 4
			KillPanel()
		else
			surface.PlaySound("nzr/2023/trials/deny.wav")
		end
	end
end

net.Receive( "nzTrialsMenu", ReceiveWunderFizz )