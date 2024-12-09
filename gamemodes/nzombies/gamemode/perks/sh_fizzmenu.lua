if CLIENT then
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

	local menu_bg = Material("vgui/wf_bg.png", "unlitgeneric smooth")
	local menu_focus_pip = Material("vgui/uie_ui_menu_store_focus_pips.png", "unlitgeneric smooth")
	local menu_marker = Material("vgui/uie_ui_menu_common_equipped_marker_with_backing.png", "unlitgeneric smooth")
	local menu_backing = Material("vgui/uie_ui_menu_optionsmenu_hdr_backing.png", "unlitgeneric smooth")

	local function ReceiveWunderFizz( length )
		local perk = net.ReadString()
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

		local zmoney1 = vgui.Create("DImage", panel)
		zmoney1:SetSize(32*scale,32*scale)
		zmoney1:SetPos(842*scale,36*scale)
		zmoney1:SetImage("vgui/ui_coldwar_zombie_essense.png")

		local cost = vgui.Create("DLabel", panel)
		cost:SetSize(128*scale,32*scale)
		cost:SetPos(784*scale, 36*scale)
		cost:SetFont(ammo)
		cost:SetText("Cost:")
		cost:SetTextColor(color_black)

		local price = vgui.Create("DLabel", panel)
		price:SetSize(128*scale,32*scale)
		price:SetPos(876*scale, 36*scale)
		price:SetFont(ammo)
		price:SetText("")
		price:SetTextColor(color_black)

		local zmoney2 = vgui.Create("DImage", panel)
		zmoney2:SetSize(32*scale,32*scale)
		zmoney2:SetPos(820*scale,428*scale)
		zmoney2:SetImage("vgui/ui_coldwar_zombie_essense.png")

		local points = vgui.Create("DLabel", panel)
		points:SetSize(128*scale,32*scale)
		points:SetPos(860*scale, 428*scale)
		points:SetFont(ammo)
		points:SetText(ply:GetPoints())
		points.Think = function()
			points:SetText(ply:GetPoints())
		end

		local name = vgui.Create("DLabel", panel)
		name:SetSize(512*scale, 64*scale)
		name:SetPos(100*scale, 20*scale)
		name:SetTextColor(color_red)
		name:SetFont(font)
		name:SetText("Der Wunderfizz")

		local desc = vgui.Create("DLabel", panel)
		desc:SetSize(860*scale, 64*scale)
		desc:SetPos(100*scale, 72*scale)
		desc:SetFont(ammo)
		desc:SetText("Pick a perk!")

		local size = 52
		local num = 0
		local row = 0

		local perk_upgrades = tobool(nzMapping.Settings.perkupgrades)

		for perk, data in SortedPairs(nzPerks.Data) do
			if data.specialmachine then continue end
			local fizzlist = nzMapping.Settings.wunderfizzperklist
			if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then
				continue
			end

			local perkback = vgui.Create("DImage", panel)
			perkback:SetPos(100*scale + num*(size + 24)*scale, 148*scale + (72*row)*scale)
			perkback:SetSize(64*scale,64*scale)
			perkback:SetMaterial(menu_backing)
			perkback:SetImageColor(color_backing)

			if (perk_upgrades and ply:HasPerk(perk)) or ply:HasUpgrade(perk) then
				local perkframe = vgui.Create("DImage", panel)
				perkframe:SetPos(106*scale + num*(size + 24)*scale, 156*scale + (72*row)*scale)
				perkframe:SetDrawOnTop(true)
				perkframe:SetSize(size*scale,size*scale)
				perkframe:SetMaterial(GetPerkFrameMaterial())
				perkframe:SetImageColor(color_gold)
			end

			local sticker = vgui.Create("DImage", panel)
			sticker:SetPos(148*scale + num*(size + 24)*scale, 148*scale + (72*row)*scale)
			sticker:SetDrawOnTop(true)
			sticker:SetSize(16*scale, 16*scale)
			sticker:SetImage("vgui/uie_ui_menu_common_equipped_marker_with_backing.png")
			sticker:SetImageColor(color_invis)
			sticker.Think = function()
				if ply:HasPerk(perk) then
					sticker:SetImageColor(color_gold)
				end
			end

			local hover = vgui.Create("DImage", panel)
			hover:SetPos(91*scale + num*(size + 24)*scale, 139*scale + (72*row)*scale)
			hover:SetSize(80*scale,80*scale)
			hover:SetMaterial(menu_focus_pip)
			hover:SetImageColor(color_invis)
			hover:SetDrawOnTop(true)

			local perkdata = vgui.Create("DImageButton", panel)
			perkdata:SetPos(106*scale + num*(size + 24)*scale, 157*scale + (72*row)*scale)
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
				local buyprice = ((perk_upgrades and ply:HasPerk(perk)) and data.upgradeprice or data.price) + (nzMapping.Settings.cwfizzprice or 1000)

				local can_buy = true
				if can_buy and !ply:CanAfford(buyprice) and (!perk_upgrades or perk_upgrades and !ply:HasUpgrade(perk)) then
					can_buy = false
				end
				if can_buy and #ply:GetPerks() >= ply:GetMaxPerks() and (!perk_upgrades or perk_upgrades and !ply:HasPerk(perk)) then
					can_buy = false
				end

				if !can_buy then
					perkdata:SetColor(color_unavailable)
				end

				if perkdata:IsHovered() then
					if ply:HasPerk(perk) then
						if perk_upgrades and !ply:HasUpgrade(perk) then
							price:SetText(tostring(data.upgradeprice + (nzMapping.Settings.cwfizzprice or 1000)))
							name:SetText(data.name)
							if data.desc2 then
								desc:SetText(data.desc2)
							end
						else
							price:SetText("")
							name:SetText(data.name)
							desc:SetText("Perk already owned!")
						end
					else
						price:SetText(tostring(data.price + (nzMapping.Settings.cwfizzprice or 1000)))
						name:SetText(data.name)
						if data.desc then
							desc:SetText(data.desc)
						end
					end
				end
			end

			perkdata.DoClick = function()
				if ply.NextPerkBuy and ply.NextPerkBuy > CurTime() then return end

				local buyprice = ((perk_upgrades and ply:HasPerk(perk)) and data.upgradeprice or data.price) + (nzMapping.Settings.cwfizzprice or 1000)

				local can_buy = true
				if can_buy and ply:HasUpgrade(perk) then
					can_buy = false
				end
				if can_buy and (!perk_upgrades and ply:HasPerk(perk)) then
					can_buy = false
				end
				if can_buy and perk_upgrades and !ply:HasPerk(perk) and #ply:GetPerks() >= ply:GetMaxPerks() then
					can_buy = false
				end
				if can_buy and !perk_upgrades and #ply:GetPerks() >= ply:GetMaxPerks() then
					can_buy = false
				end

				if ply:CanAfford(buyprice) and can_buy then
					net.Start("nzColdWarFizzBuy")
						net.WriteString(perk)
						net.WriteBool(perk_upgrades and ply:HasPerk(perk) or false) //upgrade
					net.SendToServer()

					surface.PlaySound("nzr/2023/trials/uin_perkmachine_purchase_plr.wav")
					surface.PlaySound("nzr/2023/trials/mus_wunderfizz_sting.wav")

					ply.NextPerkBuy = CurTime() + 2.5
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

		if nzMapping.Settings.cwfizzperkslot and (ply:GetMaxPerks() < (nzMapping.Settings.maxperkslots or 8)) and (nzRound:GetNumber() >= (nzMapping.Settings.cwfizzslotround or 20) or ply:IsInCreative()) then
			local perkslot_price = (nzMapping.Settings.cwfizzslotprice or 10000)

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

			local perkdata = vgui.Create("DImageButton", panel)
			perkdata:SetPos(106*scale + num*(size + 24)*scale, 156*scale + (72*row)*scale)
			perkdata:SetSize(size*scale,size*scale)
			perkdata:SetColor(color_white)
			perkdata:SetMaterial(GetPerkFrameMaterial())
			perkdata:SetMouseInputEnabled(true)

			perkdata.OnCursorEntered = function()
				hover:SetImageColor(color_white)
				surface.PlaySound("nzr/2023/trials/cac_main_nav.wav")
			end

			perkdata.OnCursorExited = function()
				hover:SetImageColor(color_invis)
			end

			perkdata.Think = function()
				if !ply:CanAfford(perkslot_price) then
					perkdata:SetColor(color_unavailable)
				end

				if perkdata:IsHovered() then
					price:SetText(tostring(perkslot_price))
					name:SetText("Perk Slot")
					desc:SetText("Gain an additional perk slot.")
				end
			end

			perkdata.DoClick = function()
				if ply.NextPerkBuy and ply.NextPerkBuy > CurTime() then return end

				if ply:CanAfford(perkslot_price) then
					net.Start("nzColdWarFizzBuy")
						net.WriteString("perk_slot")
						net.WriteBool(false)
					net.SendToServer()

					surface.PlaySound("nzr/2023/trials/uin_perkmachine_purchase_plr.wav")
					surface.PlaySound("nzr/2023/trials/mus_wunderfizz_sting.wav")

					ply.NextPerkBuy = CurTime() + 1
					KillPanel()
				else
					surface.PlaySound("nzr/2023/trials/deny.wav")
				end
			end
		end
	end

	net.Receive( "nzColdWarFizzMenu", ReceiveWunderFizz )
end

if SERVER then
	util.AddNetworkString("nzColdWarFizzMenu")
	util.AddNetworkString("nzColdWarFizzBuy")

	net.Receive("nzColdWarFizzBuy", function(len, ply)
		if not IsValid(ply) then return end
		local perk = net.ReadString()
		local upgrade = net.ReadBool()

		if perk == "perk_slot" then
			ply:TakePoints(nzMapping.Settings.cwfizzslotprice or 10000, true)
			ply:SetMaxPerks(ply:GetMaxPerks() + 1)
			ply:PerkBlur(0.5)
			return
		end

		local perk_upgrades = tobool(nzMapping.Settings.perkupgrades)
		if #ply:GetPerks() >= ply:GetMaxPerks() and (!perk_upgrades or (perk_ugprades and !upgrade)) then return end

		local perkdata = nzPerks:Get(perk)
		local price = upgrade and perkdata.upgradeprice or perkdata.price

		ply:TakePoints(price + (nzMapping.Settings.cwfizzprice or 1000), true)

		local bottle = "tfa_perk_bottle"
		if nzMapping.Settings and nzMapping.Settings.bottle and weapons.Get(nzMapping.Settings.bottle) then
			bottle = tostring(nzMapping.Settings.bottle)
		end

		local wep = ply:Give(bottle)
		if IsValid(wep) and wep.SetPerk then
			wep:SetPerk(perk)
		end

		if upgrade then
			ply:GiveUpgrade(perk)
		else
			ply:GivePerk(perk)
		end
	end)
end
