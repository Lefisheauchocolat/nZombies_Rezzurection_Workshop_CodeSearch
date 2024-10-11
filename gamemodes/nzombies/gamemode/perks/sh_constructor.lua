-- Main Tables
nzPerks = nzPerks or AddNZModule("Perks")
nzPerks.Data = nzPerks.Data or {}

-- Variables
nzPerks.Players = nzPerks.Players or {}
nzPerks.PlayerUpgrades = nzPerks.PlayerUpgrades or {}

nzPerks.EPoPIcons = {
	[1] = Material("vgui/aat/t7_hud_cp_aat_blastfurnace.png", "smooth unlitgeneric"),
	[2] = Material("vgui/aat/t7_hud_cp_aat_deadwire.png", "smooth unlitgeneric"),
	[3] = Material("vgui/aat/t7_hud_cp_aat_fireworks.png", "smooth unlitgeneric"),
	[4] = Material("vgui/aat/t7_hud_cp_aat_thunderwall.png", "smooth unlitgeneric"),
	[5] = Material("vgui/aat/t7_hud_cp_aat_cryofreeze.png", "smooth unlitgeneric"),
	[6] = Material("vgui/aat/t7_hud_cp_aat_turned.png", "smooth unlitgeneric"),
	[7] = Material("vgui/aat/t7_hud_cp_aat_bhole.png", "smooth unlitgeneric"),
	[8] = Material("vgui/aat/t7_hud_cp_aat_wonder.png", "smooth unlitgeneric"),
}

nzPerks.VultureArray = nzPerks.VultureArray or {}

nzPerks.oldturnedlist = {
	["Odious Individual"] = true,
	["Laby after Taco Bell"] = true,
	["Fucker.lua"] = true,
	["Turned"] = true,
	["Shitass"] = true,
	["Miscellaneous Intent"] = true,
	["The Imposter"] = true,
	["Zobie"] = true,
	["Creeper, aww man"] = true,
	["Herbin"] = true,
	["Category Five"] = true,
	["TheRelaxingEnd"] = true,
	["Zet0r"] = true,
	["Dead By Daylight"] = true,
	["Cave Johnson"] = true,
	["Vinny Vincesauce"] = true,
	["Who's Who?"] = true,
	["MR ELECTRIC, KILL HIM!"] = true,
	["Jerma985"] = true,
	["Steve Jobs"] = true,
	["BRAAAINS..."] = true,
	["The False Shepherd"] = true,
	["Timer Failed!"] = true,
	["r_flushlod"] = true,
	["Doctor Robotnik"] = true,
	["Clown"] = true,
	["Left 4 Dead 2"] = true,
	["Squidward Tortellini"] = true,
	["Five Nights at FNAF"] = true,
	["Minecraft Steve"] = true,
	["Wowee Zowee"] = true,
	["Gorgeous Freeman"] = true,
	["fog rolling in"] = true,
	["Exotic Butters"] = true,
	["Brain Rot"] = true,
	["Team Fortress 2"] = true,
	["Roblox"] = true,
	["Cave1.ogg"] = true,
	["Fin Fin"] = true,
	["Jimmy Gibbs Jr."] = true,
	["Brain Blast"] = true,
	["Sheen"] = true
}

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

		if nzMapping.Settings.cwfizzperkslot and (nzRound:GetNumber() >= (nzMapping.Settings.cwfizzslotround or 20) or ply:IsInCreative()) then
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

	function nzPerks:UpdatePerkMachines()
		for k, v in pairs(ents.FindByClass("perk_machine")) do
			if v.Update then
				v:Update()
			end
		end
		for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
			if v.Update then
				v:Update()
			end
		end
	end
end

//class names for vulture vision entities
nzPerks.VultureClass = nzPerks.VultureClass or {}
function nzPerks:AddVultureClass(class)
	if class then
		nzPerks.VultureClass[class] = true
	end
end

nzPerks:AddVultureClass("nz_ammo_matic")
nzPerks:AddVultureClass("wunderfizz_machine")
nzPerks:AddVultureClass("wall_buys")
nzPerks:AddVultureClass("random_box")
nzPerks:AddVultureClass("perk_machine")
nzPerks:AddVultureClass("drop_powerup")
nzPerks:AddVultureClass("drop_widows")
nzPerks:AddVultureClass("drop_tombstone")

//vulture mini powerup effects table
nzPerks.VultureDropsTable = nzPerks.VultureDropsTable or {}
function nzPerks:AddVultureDropType(id, data)
	if data then
		nzPerks.VultureDropsTable[id] = data
	else
		nzPerks.VultureDropsTable[id] = nil
	end
end

nzPerks:AddVultureDropType("points", {
	id = "points",
	model = Model("models/powerups/w_vulture_points.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 3,
	effect = function(ply)
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:EmitSound("nz_moo/powerups/vulture/vulture_money.mp3") 
		ply:GivePoints(math.random(10, 20) * (ply:HasUpgrade("vulture") and 20 or 10))

		return true
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))

			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("ammo", {
	id = "ammo",
	model = Model("models/powerups/w_vulture_ammo.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 2,
	effect = function(ply)
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			local max = wep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(wep:GetClass(), wep:HasNZModifier("pap"))
			local give = math.Round(max/math.random(10, 20))
			local ammo = wep:GetPrimaryAmmoType()
			local cur = ply:GetAmmoCount(ammo)

			if (cur + give) > max then
				give = max - cur
			end

			if give <= 0 then
				return false
			end

			ply:GiveAmmo(give, ammo)
			ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3")

			return true
		end
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))
			
			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("gas",{
	id = "gas",
	model = Model("models/dav0r/hoverball.mdl"),
	blink = false,
	poof = false,
	timer = 12,
	chance = 1,
	effect = function(ply)
		ply:VulturesStink(0.5)

		return false
	end,
	draw = function(self)
		if !self.loopglow or !IsValid(self.loopglow) then
			self.loopglow = CreateParticleSystem(self, "nz_perks_vulture_stink", PATTACH_ABSORIGIN_FOLLOW)
		end
	end,
	initialize = function(self)
		self:DrawShadow(false)
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 

		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() - Vector(0,0,64),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
		})

		if tr.Hit then
			self:SetPos(tr.HitPos + vector_up*32)
		end

		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(240)
			lamp:SetFOV(60)

			lamp:SetPos(self:GetPos() + vector_up*64)
			lamp:SetAngles(Angle(90,0,0))

			lamp:SetColor(Color(60,255,0,255))
			lamp:Update()
		end
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetPos( self:GetPos() + vector_up*64 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("armor",{
	id = "armor",
	model = Model("models/items/battery.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 2,
	effect = function(ply)
		local plyarm = ply:Armor()
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:SetArmor(math.Clamp(plyarm + (math.random(1, 5) * (ply:HasUpgrade("vulture") and 20 or 10)), 0, 200))

		return true
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))

			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})