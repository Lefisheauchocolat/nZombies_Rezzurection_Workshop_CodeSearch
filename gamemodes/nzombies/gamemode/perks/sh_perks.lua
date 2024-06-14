
function nzPerks:NewPerk(id, data)
	if SERVER then 
		//Sanitise any client data.
	else
		data.Func = nil
	end
	nzPerks.Data[id] = data
end

function nzPerks:Get(id)
	return nzPerks.Data[id]
end

function nzPerks:GetByName(name)
	for _, perk in pairs(nzPerks.Data) do
		if perk.name == name then
			return perk
		end
	end

	return nil
end


function nzPerks:GetList()
	local tbl = {}

	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.name
	end

	return tbl
end

function nzPerks:GetIcons()
	local tbl = {}
	
	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.icon
	end
	
	return tbl
end

function nzPerks:GetBottleMaterials()
	local tbl = {}
	
	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.wfz
	end
	
	return tbl
end

function nzPerks:GetMachineType(id)
	if id == "Original" then
	return "OG"
	end
	if id == "Infinite Warfare" then
	return "IW"
	end
	if id == nil then
	return "OG"
	end
end

function nzPerks:GetPAPType(id)
	if id == "Black Ops Cold War" then
	return "bocw"
	end
	if id == "World War II" then
	return "ww2"
	end
	if id == "Origins" then
	return "nz_tomb"
	end
	if id == "Tranzit" then
	return "bo2"
	end
	if id == "Original" then
	return "og"
	end
	if id == nil then
	return "og"
	end
end

nzPerks:NewPerk("dtap", {
	name = "Double Tap",
	name_skin = "Bang Bangs",
	name_holo ="Reaper's Delight",
	model = "models/nzr/2022/machines/dtap/vending_dtap.mdl",
	skin = "models/perks/IWperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin = 0,
	on_skin = 0,
	price = 2000,
	price_skin = 2000,
	desc = "Gain 30% increased firerate",
	desc2 = "Gain an additional 30% increased firerate. Rip and tear.",
	material = 0,
	wfz = "models/perk_bottle/c_perk_bottle_dtap",
	icon = Material("nz_moo/icons/bo1/dtap.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/bangs.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/dtap.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/dtap1.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/dtap.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/dtap.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/dtap.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/dtap.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/dtap.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/dtap.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/dtap.png", "smooth unlitgeneric"),
	icon_cw = Material("perk_icons/bocw/dtap.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/dtap.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/dtap.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/dtap.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/dtap.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/dtap.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/dtap.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/dtap.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/dtap.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/dtap.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/dtap.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/dtap.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/dtap.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/dtap.png", "smooth unlitgeneric"),
	color = Color(255, 125, 0),
	sting = "perkyworky/dtap_sting.mp3",
	jingle = "perkyworky/mus_doubletap_jingle.mp3",
	func = function(self, ply, machine)
        local tbl = {}
        for k, v in pairs(ply:GetWeapons()) do
            if not v:IsSpecial() then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:ApplyNZModifier("dtap")
            end
        end
    end,
    lostfunc = function(self, ply)
        local tbl = {}
        for k,v in pairs(ply:GetWeapons()) do
            if v.IsTFAWeapon and v:HasNZModifier("dtap") then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:RevertNZModifier("dtap")
            end
        end
    end,
	upgradefunc  = function(self, ply)
		local tbl = {}
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				table.insert(tbl, v)
			end
		end
		if tbl[1] != nil then
			for k, v in pairs(tbl) do
				v:RevertNZModifier("dtap")
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(v) then return end
					v:ApplyNZModifier("dtap")
				end)
			end
		end
	end,
})

nzPerks:NewPerk("dtap2", {
	name = "Double Tap II",
	name_skin = "Bang Bangs",
	name_holo ="Seal Soda",
	model = "models/nzr/2022/machines/dtap2/vending_dtap2.mdl",
	skin = "models/perks/IWperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2000,
	price_skin = 2000,
	desc = "Shoot 2 bullets for every 1 ammo. Firerate increased by 10%",
	desc2 ="Works with projectile weapons.",
	material = 0,
	wfz = "models/perk_bottle/c_perk_bottle_dtap2",
	icon = Material("nz_moo/icons/bo1/dtap2.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/bangs2.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/dtap2.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/dtap2.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/dtap2.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/dtap2.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/dtap 2.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/dtap2.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/dtap2.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/dtap2.png", "smooth unlitgeneric"),
	icon_mw = Material("nz_moo/icons/mw/dtap2.png", "smooth unlitgeneric"),
	icon_cw = Material("perk_icons/bocw/dtap22.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/dtap2.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/dtap2.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/dtap2.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/dtap2.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/dtap2.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/dtap2.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/dtap2.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/dtap2.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/dtap2.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/dtap2.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/dtap2.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/dtap2.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/dtap 2.png", "smooth unlitgeneric"),
	color = Color(255, 125, 0),
	sting = "perkyworky/dtap_sting.mp3",
	jingle = "perkyworky/mus_doubletap_jingle.mp3",
	func = function(self, ply, machine)
        local tbl = {}
        for k, v in pairs(ply:GetWeapons()) do
            if not v:IsSpecial() then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:ApplyNZModifier("dtap2")
            end
        end
    end,
    lostfunc = function(self, ply)
        local tbl = {}
        for k,v in pairs(ply:GetWeapons()) do
            if v.IsTFAWeapon and v:HasNZModifier("dtap2") then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:RevertNZModifier("dtap2")
            end
        end
    end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("speed", {
	name = "Speed Cola",
	name_skin = "Quickies",
	name_holo = "Kronii Cola",
	model = "models/nzr/2022/machines/sleight/vending_sleight.mdl",
	skin = "models/perks/IWperks/quickies/mc_mtl_p7_zm_vending_speedcola.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 3000,
	price_skin = 3000,
	mmohud = {style = "count", count = "nz.SpeedRefund", max = 100, countup = true, upgradeonly = true},																									 
	desc = "Gain doubled reload speed. Repair barricades faster.",
	desc2 = "Weapons will slowly reload over time when not firing and magazine isnt empty. Refunded some ammo at start of round.",
	material = 15,
	wfz = "models/perk_bottle/c_perk_bottle_speed",
	icon = Material("nz_moo/icons/bo1/speed.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/quickies.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/speed.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/speed.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/speed.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/speed.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/speed.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/speed.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/speed.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/speed.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/speed.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/speed.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/speed.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/speed.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/speed.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/speed.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/speed.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/speed.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/speed.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/speed.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/speed.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/speed.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/speed.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/speed.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/speed.png", "smooth unlitgeneric"),
	color = Color(25, 255, 25),
	sting = "perkyworky/speed_sting.mp3",
	jingle = "perkyworky/mus_speed_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("jugg", {
	name = "Juggernog",
	name_skin = "Tuff 'Nuff",
	name_holo = "Dragon's Blood",
	model = "models/nzr/2022/machines/jugg/vending_jugg.mdl",
	skin = "models/perks/IWperks/tuff/mc_mtl_p7_zm_vending_jugg.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2500,
	price_skin = 2500,
	desc = "Gain increased health.",
	desc2 = "Start every round with 200 armor.",
	material = 7,
	wfz = "models/perk_bottle/c_perk_bottle_jugg",
	icon = Material("nz_moo/icons/bo1/jugg.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/tuff.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/jugg.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/jugg.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/jugg.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/jugg.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/jugg.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/jugg.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/jugg.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/jugg.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/jugg.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/jugg.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/jugg.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/jugg.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/jugg.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/jugg.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/jugg.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/jugg.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/jugg.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/jugg.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/jugg.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/jugg.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/jugg.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/jugg.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/jugg.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/jugg.png", "smooth unlitgeneric"),
	color = Color(255, 25, 25),
	sting = "perkyworky/jugg_sting.mp3",
	jingle = "perkyworky/mus_jugganog_jingle.mp3",
	func = function(self, ply, machine)
		ply:SetMaxHealth((nzMapping.Settings.hp) + 125)
		ply:SetHealth((nzMapping.Settings.hp) + 125)
	end,
	lostfunc = function(self, ply)
		ply:SetMaxHealth(nzMapping.Settings.hp)
		if ply:Health() > nzMapping.Settings.hp then ply:SetHealth(nzMapping.Settings.hp) end
	end,
	upgradefunc = function(self, ply, machine)
		//ply:SetMaxHealth((nzMapping.Settings.hp) + 250)
		//ply:SetHealth((nzMapping.Settings.hp) + 250)
	end,
})

nzPerks:NewPerk("gum", {
	name = "Gobbledumb(April Fools)",
	name_skin = "Gobbledumb(April Fools)",
	name_holo = "Masochism Generator",
	model = "models/perks/Cperks/bestthingever/gobble.mdl",
	skin = "models/perks/Cperks/bestthingever/gobble.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 500,
	price_skin = 500,
	specialmachine = true,
	material = 69,
	wfz = "models/perk_bottle/gum",
	icon = Material("perk_icons/chron/gum.png", "smooth unlitgeneric"),
	color = Color(255, 100, 100),
	sting = "nz_moo/effects/trollbox.mp3",
	jingle = "nz_moo/effects/trollbox.mp3",
	func = function(self, ply, machine)
		local rand = math.random(17)

		if rand == 1 then
			PrintMessage(HUD_PRINTTALK, "Jugger-not")
			ply:SetMaxHealth(50)
			ply:SetHealth(50)
		end

		if rand == 2 then
			PrintMessage(HUD_PRINTTALK, "Always Done Slowly")
			ply:SetRunSpeed(100)
			ply:SetMaxRunSpeed(100)
			ply:SetStamina(100)
			ply:SetMaxStamina(100)
		end

		if rand == 3 then
			PrintMessage(HUD_PRINTTALK, "Very Quenchable")
			GetConVar("nz_difficulty_perks_max"):SetInt(1)
		end

		if rand == 4 then
			PrintMessage(HUD_PRINTTALK, "Insta-death")
			ply:Kill()
		end

		if rand == 5 then
			PrintMessage(HUD_PRINTTALK, "No Stock Options")
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then
				ply:GivePoints(ply:GetAmmoCount(wep:GetPrimaryAmmoType()))
			end
			ply:RemoveAllAmmo()
		end

		if rand == 6 then
			PrintMessage(HUD_PRINTTALK, "Anklebreaker")
			ply:SetJumpPower(40)
		end

		if rand == 7 then
			PrintMessage(HUD_PRINTTALK, "Alchemical Antichrist")
			ply:TakePoints(ply:GetPoints())
			ply:GiveMaxAmmo()
		end

		if rand == 8 then
			PrintMessage(HUD_PRINTTALK, "Dropsies")
			for k, v in pairs(ply:GetWeapons()) do
				if v:GetNWInt("SwitchSlot") == 1 then
					ply:StripWeapon(v:GetClass())
				end
			end
		end

		if rand == 9 then
			PrintMessage(HUD_PRINTTALK, "Always in sight")
			ply:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
		end

		if rand == 10 then
			PrintMessage(HUD_PRINTTALK, "Chicken Down")
			for k, v in pairs(player.GetAllPlaying()) do
				if v ~= ply then
					v:Kill()
				end
			end
		end

		if rand == 11 then
			PrintMessage(HUD_PRINTTALK, "This is fine, everything is fine")
			nzPowerUps:Nuke(ply:GetPos())
			local specint = GetConVar("nz_round_special_interval"):GetInt() or 6
			nzRound:SetNumber(99)
			nzRound:SetNextSpecialRound(math.ceil(100/specint) * specint)
			nzRound:Prepare()
		end

		if rand == 12 then
			PrintMessage(HUD_PRINTTALK, "Ice Sale")
			local box = ents.FindByClass("random_box")[1]
			if IsValid(box) then
				box:Remove()
			end
		end

		if rand == 13 then
			PrintMessage(HUD_PRINTTALK, "Gas Zap Attack")
			local boss = ents.Create("nz_zombie_special_nova_electric")
			boss:SetPos(ents.FindByClass("player_spawns")[1]:GetPos())
			boss:SetHealth(math.huge)
			boss:Spawn()
		end

		if rand == 14 then
			PrintMessage(HUD_PRINTTALK, "Crawling in my Crawl")
			local pspawns = ents.FindByClass("player_spawns")
			local pos = pspawns[math.random(#pspawns)]:GetPos()
			local boss = ents.Create("nz_zombie_special_spooder")
			boss:SetPos(pos)
			boss:SetHealth(math.huge)
			boss:Spawn()
		end

		if rand == 15 then
			PrintMessage(HUD_PRINTTALK, "Housefire")
			local pspawns = ents.FindByClass("player_spawns")
			local pos = pspawns[math.random(#pspawns)]:GetPos()
			local boss = ents.Create("nz_zombie_boss_Napalm")
			boss:SetPos(pos)
			boss:SetHealth(math.huge)
			boss:Spawn()
		end

		if rand == 16 then
			PrintMessage(HUD_PRINTTALK, "Octagonal Robber")
			local pspawns = ents.FindByClass("player_spawns")
			local pos = pspawns[math.random(#pspawns)]:GetPos()
			local boss = ents.Create("nz_zombie_boss_aprilfools")
			boss:SetPos(pos)
			boss:SetHealth(math.huge)
			boss:Spawn()
		end

		if rand == 17 then
			PrintMessage(HUD_PRINTTALK, "Perkaholic")
			for perk, data in pairs(nzPerks.Data) do
				if not perk.specialmachine and perk ~= "gum" then
					ply:GivePerk(perk)
				end
			end
			timer.Simple(5, function()
				if not IsValid(ply) then return end
				ply:RemovePerks()
			end)
		end
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("amish", {
	name = "Amish Ale",
	name_skin = "Hippie Hops",
	name_holo ="Board-Pounding Beer",
	model = "models/perks/Cperks/amish/amish_off.mdl",
	model_off = "models/perks/Cperks/amish/amish_off.mdl",
	skin =  "models/perks/Cperks/amish/amish_off.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 1000,
	price_skin = 1000,
	desc = "Repair barricades around you in a radius. Repairing barricades grants more points. Buildables take 50% less damage.",
	desc2 = "Stonecold stronghold (NOT IMPLEMENTED).",
	material = 23,
	wfz = "models/perk_bottle/c_perk_bottle_amish",
	icon = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_iw =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_waw =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_bo2 =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_bo3 =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_bo4 =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_mwz =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_cotd =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_xmas =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_griddy =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_mw =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_cw =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_halloween =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_xmas =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_neon =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_dumb =  Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/amish.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_soe = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_pickle = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_coggers = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_cheese = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_paper = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	icon_charred = Material("perk_icons/chron/amish.png", "smooth unlitgeneric"),
	color = Color(255, 255, 100),
	sting = "nz/machines/jingle/amish_get.ogg",
	jingle = "nz/machines/jingle/amish_get.ogg",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("revive", {
	name = "Quick Revive",
	name_skin = "Up N' Atoms",
	name_holo = "Gorilla Revive",
	model = "models/nzr/2022/machines/revive/vending_revive.mdl",
	skin = "models/moo/_codz_ports_props/iw7/zmb/perks/moo_codz_iw7_zmb_upnatoms.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 1500,
	price_skin = 1500,
	desc = "Revive yourself in solo, revive teammates faster, and regen health faster.",
	desc2 ="Revived players keep all their perks.",
	material = 13,
	wfz = "models/perk_bottle/c_perk_bottle_revive",
	icon = Material("nz_moo/icons/bo1/revive.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/atoms.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/revive.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/revive.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/revive.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/revive.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/revive.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/revive.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/revive.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/revive.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/revive.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/revive.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/revive.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/revive.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/revive.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/revive.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/revive.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/revive.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/revive.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/revive.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/revive.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/revive.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/revive.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/revive.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/revive.png", "smooth unlitgeneric"),
	color = Color(35, 35, 255),
	sting = "perkyworky/revive_sting.mp3",
	jingle = "perkyworky/mus_revive_jingle.mp3",
	func = function(self, ply, machine)
		if #player.GetAllPlaying() <= 1 then
			if !ply.SoloRevive or ply.SoloRevive < 3 or !IsValid(machine) then
				ply:ChatPrint("You got Quick Revive (Solo)!")
			else
				ply:ChatPrint("You can only get Quick Revive Solo 3 times.")
				return false
			end
		end
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("pap", {
	name = "Pack-a-Punch",
	name_skin = "Pack-a-Punch",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_packapunch/moo_codz_p7_zm_vending_packapunch.mdl",
	model_bo2 = "models/nzr/2022/machines/pap/vending_pap.mdl",
	model_bocw = "models/codmw2023/other/pack-a-punch.mdl",
	model_ww2 = "models/perks/SHperks/ww2.mdl",
	model_origins = "models/perks/Tperks/packapunch/mc_mtl_p7_packapunch.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 0,
	price_skin = 0,
	specialmachine = true,
	nobuy = true,
	icon = Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	icon_skin = Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	color = Color(20, 235, 255),
	sting = "perkyworky/pap_sting.mp3",
	jingle = "perkyworky/mus_packapunch_jingle.mp3",
	condition = function(self, ply, machine)
		local wep = ply:GetActiveWeapon()
		if (!wep:HasNZModifier("pap") or wep:CanRerollPaP()) and !machine:GetBeingUsed() then
			local reroll = false
			if wep:HasNZModifier("pap") and wep:CanRerollPaP() then
				reroll = true
			end
			local cost = reroll and nzPowerUps:IsPowerupActive("bonfiresale") and 500 or reroll and 2500 or nzPowerUps:IsPowerupActive("bonfiresale") and 1000 or 5000
			return ply:GetPoints() >= cost
		else
			if !machine:GetBeingUsed() then
				ply:PrintMessage(HUD_PRINTTALK, "This weapon is already Pack-a-Punched")
			end
			return false
		end
	end,
	func = function(self, ply, machine)
		
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("vigor", {
	name = "Vigor Rush",
	name_skin = "Vigorous Violets",
	name_holo = "Horny Highballer",
	model = "models/nzr/2022/machines/vigor/vending_vigor.mdl",
	skin = "models/perks/IWperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 3000,
	price_skin = 3000,
	desc = "Gain doubled bullet weapon damage. Explosive bullets. Does not stack with Danger.",
	desc2 ="Gain tripled bullet weapon damage. Additional points from bullet kills.",
	material = 17,
	wfz = "models/perk_bottle/c_perk_bottle_vigor",
	icon = Material("nz_moo/icons/bo1/vigor.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/vigor.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/vigor.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/vigor.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/vigor.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/vigor.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/vigor.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/vigor.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/vigor.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/vigor.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/vigor.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/vigor.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/vigor.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/vigor.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/vigor.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/vigor.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/vigor.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/vigor.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/vigor.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/vigor.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/vigor.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/vigor.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/vigor.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/vigor.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/vigor.png", "smooth unlitgeneric"),
	color = Color(128, 128, 64),
	sting = "perkyworky/stingers/vigorush_sting.mp3",
	jingle = "perkyworky/vigor_jingle.mp3",
	func = function(self, ply, machine)
        local tbl = {}
        for k, v in pairs(ply:GetWeapons()) do
            if not v:IsSpecial() then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:ApplyNZModifier("vigor")
            end
        end
    end,
    lostfunc = function(self, ply)
        local tbl = {}
        for k,v in pairs(ply:GetWeapons()) do
            if v.IsTFAWeapon and v:HasNZModifier("vigor") then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:RevertNZModifier("vigor")
            end
        end
    end,
	upgradefunc  = function(self, ply)
	
	end,
})

nzPerks:NewPerk("fire", {
	name = "Napalm Nectar",
	name_skin = "Firestarter Fizzy",
	name_holo = "Pheonix Elixir",
	model = "models/perks/Cperks/napalm/napalm.mdl",
	model_off = "models/perks/Cperks/napalm/napalm_off.mdl",
	price = 3000,
	price_skin = 3000,
	mmohud = {style = "count", count = "nz.BurnCount", delay = "nz.BurnDelay"},
	desc = "Gain immunity to fire damage. Gain Burnout effect with a 20 second cooldown. Delay increases after every use. Doubled fire weapon damage.",
	desc2 ="Burnout cooldown reduced. Bullets randomly ignite enemies. Quadrupled fire weapon damage.",
	material = 5,
	wfz = "models/perk_bottle/c_perk_bottle_fire",
	icon = Material("nz_moo/icons/bo1/fire.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/fire.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/fire.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/fire.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/fire.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/fire.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/fire.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/fire.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/fire.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/fire.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/fire.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/fire.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/fire.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/fire.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/napalm.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/fire.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/fire.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/fire.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/fire.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/fire.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/fire.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/fire.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/fire.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/fire.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/fire.png", "smooth unlitgeneric"),
	color = Color(222, 69, 2),
	sting = "perkyworky/stingers/napalm_sting.mp3",
	jingle = "perkyworky/napalm_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	
	end,
})

nzPerks:NewPerk("mask", {
	name = "Mask Moscatto",
	name_skin = "Maloderous Watermelons",
	name_holo = "Orca Old Fashioned",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_mask/kate_codz_p7_zm_vending_mask.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 1500,
	price_skin = 1500,
	desc = "Gain immunity to Novagas damage. Removes Novagas disorientation. Take greatly reduced damage from map hazards.",
	desc2 = "need ideas.",
	material = 8,
	wfz = "models/perk_bottle/c_perk_bottle_speed",
	icon = Material("nz_moo/icons/bo1/mask.png", "smooth unlitgeneric"),
	icon_iw = Material("nz_moo/icons/cw/mask.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/mask.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/mask.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/mask.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/mask.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/mask.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/mask.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/mask.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/mask.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/mask.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/mask.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/mask.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/mask.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/masked.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/mask.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/mask.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/mask.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/mask.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/mask.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/mask.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/mask.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/mask.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/mask.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/mask.png", "smooth unlitgeneric"),
	color = Color(92, 165, 30),
	sting = "perkyworky/stingers/mask_sting.mp3",
	jingle = "perkyworky/mask_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("staminup", {
	name = "Stamin-Up",
	name_skin = "Racin' Stripes",
	name_holo ="GOD Speed Gatorade",
	model = "models/nzr/2022/machines/marathon/vending_marathon.mdl",
	skin = "models/perks/IWperks/stripes/mc_mtl_p7_zm_vending_marathon.mdl",
	off_skin = 0,
	on_skin = 2,
	price = 2000,
	price_skin = 2000,
	desc = "Gain increased stamina and Move faster. Removes weapon weight.",
	desc2 = "Gain unlimited stamina.",
	material = 16,
	wfz = "models/perk_bottle/c_perk_bottle_stamin",
	icon = Material("nz_moo/icons/bo1/staminup.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/stripes.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/staminup.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/staminup.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/staminup.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/staminup.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/staminup.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/staminup.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/staminup.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/staminup.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/staminup.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/staminup.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/staminup.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/staminup.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/staminup.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/staminup.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/staminup.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/staminup.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/staminup.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/staminup.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/staminup.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/staminup.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/staminup.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/staminup.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/staminup.png", "smooth unlitgeneric"),
	color = Color(255, 200, 50),
	sting = "perkyworky/staminup_sting.mp3",
	jingle = "perkyworky/mus_stamin_jingle.mp3",
	func = function(self, ply, machine)
		ply:SetWalkSpeed(210)					   
		ply:SetRunSpeed(320)
		ply:SetMaxRunSpeed( 320 )
		ply:SetStamina( 200 )
		ply:SetMaxStamina( 200 )
		local tbl = {}
        for k, v in pairs(ply:GetWeapons()) do
            if not v:IsSpecial() then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:ApplyNZModifier("staminup")
            end
        end
	end,
	lostfunc = function(self, ply)
		ply:SetWalkSpeed(190)
		ply:SetRunSpeed(310)
		ply:SetMaxRunSpeed( 310 )
		ply:SetStamina( 100 )
		ply:SetMaxStamina( 100 )
		ply:SetStaminaLossAmount( 0.9 )
		ply:SetStaminaRecoverAmount( 4.5 )						 								
		local tbl = {}
        for k,v in pairs(ply:GetWeapons()) do
            if v.IsTFAWeapon and v:HasNZModifier("staminup") then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:RevertNZModifier("staminup")
            end
        end
	end,
	upgradefunc  = function(self, ply)
		ply:SetWalkSpeed(210)
		ply:SetRunSpeed(341)
		ply:SetMaxRunSpeed( 341 )
		ply:SetStamina( 1000 )
		ply:SetMaxStamina( 1000 )
		ply:SetStaminaLossAmount( 0.05 )
		ply:SetStaminaRecoverAmount( 15 )
	end,
})

nzPerks:NewPerk("politan", {
	name = "Random-o-Politan",
	name_skin = "Random-o-Pastilles",
	name_holo = "Kureiji Cola",
	model = "models/perks/Cperks/random/random.mdl",
	model_off = "models/perks/Cperks/random/random.mdl",
	price = 5000,
	price_skin = 5000,
	desc = "Replace your current weapon with a random one on empty reload.",
	desc2 = "Weapon given is Pack a' Punched. (VERY WORK IN PROGRESS).",
	material = 12,
	wfz = "models/perk_bottle/c_perk_bottle_random",
	icon = Material("nz_moo/icons/bo1/random.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/random.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/random.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/random.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/random.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/random.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/random.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/random.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/random.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/random.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/random.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/random.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/random.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/random.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/random.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/random.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/random.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/random.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/random.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/random.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/random.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/random.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/random.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/random.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/random.png", "smooth unlitgeneric"),
	color = Color(255, 172, 224),
	sting = "perkyworky/stingers/politan_sting.ogg",
	jingle = "perkyworky/randomo_jingle.ogg",
	func = function(self, ply, machine)
		local tbl = {}
		for k, v in pairs(ply:GetWeapons()) do
			table.insert(tbl, v)
		end

		for k, v in pairs(tbl) do
			if !v:IsSpecial() then
				v:ApplyNZModifier("rando")
			end
		end
	end,
	lostfunc = function(self, ply)
		local tbl = {}
		for k, v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("rando") then
				v:RevertNZModifier("rando")
			end
		end
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("sake", {
	name = "Slasher's Sake",
	name_skin = "Slappy Taffy",
	name_holo ="Shogun Sake",
	skin = "models/perks/IWperks/taffy/sake.mdl",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_slash/kate_codz_p7_zm_vending_slash.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 6000,
	price_skin = 6000,
	mmohud = {style = "%", delay = "nz.SakeDelay", hide = true, time = true, max = 7, upgradeonly = true},
	desc = "Permanently one shot zombies with your melee.",
	desc2 = "Zombies slain via melee occasionally proc PopShocks. 7 Second cooldown",
	material = 14,
	wfz = "models/perk_bottle/c_perk_bottle_sake",
	icon = Material("nz_moo/icons/bo1/sake.png", "smooth unlitgeneric"),
	icon_iw =  Material("perk_icons/chron/taffy.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/sake.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/sake.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/sake.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/sake.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/sake.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/sake.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/sake.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/sake.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/sake.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/sake.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/sake.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/sake.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/sake.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/sake.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/sake.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/sake.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/sake.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/sake.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/sake.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/sake.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/sake.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/sake.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/sake.png", "smooth unlitgeneric"),
	color = Color(185, 214, 0),
	sting = "perkyworky/stingers/slasher_sting.ogg",
	jingle = "perkyworky/sake_jingle.ogg",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("wall", {
	name = "Wall Power Whiskey Sour",
	name_skin = "Wall Power Whiskey Sour",
	name_holo = "Aloe Ale",
	model_off = "models/perks/Cperks/wall/wall.mdl",
	model = "models/perks/Cperks/wall/wall.mdl",
	price = 10000,
	price_skin = 10000,
	desc = "Every new weapon obtained is Pack-A-Punched.",
	desc2 = "Nothing.",
	material = 19,
	wfz =  "models/perk_bottle/c_perk_bottle_wall",
	icon = Material("nz_moo/icons/bo1/wall.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/wall.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/wall.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/wall.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/wall.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/wall.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/wall.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/wall.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/wall.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/wall.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/wall.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/wall.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/wall.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/wall.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/wall.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/wall.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/wall.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/wall.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/wall.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/wall.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/wall.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/wall.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/wall.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/wall.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/wall.png", "smooth unlitgeneric"),
	color = Color(230, 104, 167),
	sting = "perkyworky/pap_sting.mp3",
	jingle = "perkyworky/mus_packapunch_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("danger", {
	name = "Danger Costa-Rican",
	name_skin = "Hi-Splosion Chews",
	name_holo = "Elvish Explosive Expresso",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_fighters_fizz/moo_codz_p7_zm_vending_fighters_fizz.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2500,
	price_skin = 2500,
	desc = "Gain doubled explosive weapon damage.",
	desc2 = "Gain tripled explosive weapon damage. Additional points gained from Nukes.",
	material = 2,
	wfz = "models/perk_bottle/c_perk_bottle_danger",
	icon = Material("nz_moo/icons/bo1/danger.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/danger.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/danger.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/danger.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/danger.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/danger.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/danger.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/danger.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/danger.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/danger.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/danger.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/danger.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/danger.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/danger.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/costa.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/danger.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/danger.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/danger.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/danger.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/danger.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/danger.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/danger.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/danger.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/danger.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/danger.png", "smooth unlitgeneric"),
	color = Color(232, 116, 116),
	sting = "perkyworky/stingers/danger_sting.mp3",
	jingle = "perkyworky/danger_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("everclear", {
	name = "Explosive Everclear",
	name_skin = "Trail Blazers",
	name_holo = "FAQ Flavorade",
	skin = "models/perks/IWperks/trailblazer/everclear.mdl",
	off_skin = 0,
	on_skin = 1,
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_zombshell/moo_codz_p7_zm_vending_zombshell.mdl",
	price = 3000,
	price_skin = 3000,
	mmohud = {style = "count", count = "nz.ZombShellCount", delay = "nz.ZombShellDelay"},
	desc = "Slain zombies have a chance to proc a ZombShell/Napalm Pit.",
	desc2 = "Proc chance and duration *greatly* increased for both.",
	material = 4,
	wfz = "models/perk_bottle/c_perk_bottle_everclear",
	icon = Material("nz_moo/icons/bo1/everclear.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/blazers.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/everclear.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/everclear.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/everclear.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/everclear.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/everclear.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/everclear.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/everclear.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/everclear.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/everclear.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/everclear.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/everclear.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/everclear.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/everclear.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/everclear.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/everclear.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/everclear.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/everclear.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/everclear.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/everclear.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/everclear.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/everclear.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/everclear.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/everclear.png", "smooth unlitgeneric"),
	color = Color(221, 66, 57),
	sting = "perkyworky/stingers/everclear_sting.mp3",
	jingle = "perkyworky/everclear_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("gin", {
	name = "Juicer's Gin",
	name_skin = "Juicer's Gin",
	name_holo = "Lamy's Long Island Iced Tea",
	model = "models/nzr/2022/machines/jizz/vending_jizz.mdl",
	model_off = "models/perks/Cperks/gin/gin.mdl",
	price = 5000,
	price_skin = 5000,
	desc = "Every player gains an additional perk slot. Grants two slots in solo.",
	desc2 = "Keep all perks except Juicer's Gin after being revived.",
	material = 6,
	wfz =  "models/perk_bottle/c_perk_bottle_gin",
	icon = Material("nz_moo/icons/bo1/gin.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/gin.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/gin.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/gin.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/gin.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/gin.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/gin.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/gin.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/gin.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/gin.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/gin.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/gin.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/gin.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/gin.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/jucie.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/gin.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/gin.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/gin.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/gin.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/gin.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/gin.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/gin.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/gin.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/gin.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/gin.png", "smooth unlitgeneric"),
	color = Color(40, 240, 220),
	sting = "perkyworky/stingers/gin_sting.mp3",
	jingle = "perkyworky/gin_jingle.mp3",
	func = function(self, ply, machine)
		if #player.GetAllPlaying() <= 1 then
			local perks = GetConVar("nz_difficulty_perks_max"):GetInt()
			GetConVar("nz_difficulty_perks_max"):SetInt(perks + 3)
		else
			local perks = GetConVar("nz_difficulty_perks_max"):GetInt()
			GetConVar("nz_difficulty_perks_max"):SetInt(perks + 2)
		end
	end,
	lostfunc = function(self, ply)
		if #player.GetAllPlaying() <= 1 then
			local perks = GetConVar("nz_difficulty_perks_max"):GetInt()
			GetConVar("nz_difficulty_perks_max"):SetInt(perks - 3)
		else
			local perks = GetConVar("nz_difficulty_perks_max"):GetInt()
			GetConVar("nz_difficulty_perks_max"):SetInt(perks - 2)
		end
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("phd", {
	name = "PhD Flopper",
	name_skin = "Bombstoppers",
	name_holo ="Desk Slam Daquiri",
	model = "models/nzr/2022/machines/nuke/vending_nuke.mdl",
	skin = "models/perks/IWperks/bomb/phdflopper.mdl", 
	off_skin = 0,
	on_skin = 1,
	price = 2000,
	price_skin = 2000,
	mmohud = {style = "toggle", delay = "nz.PHDDelay", upgradeonly = true},
	desc = "Gain immunity to explosives and fall damage. Explode after hitting the ground.",
	desc2 = "Gain the ability to double jump. Tap and release crouch after double jumping to fast fall.",
	material = 10,
	wfz = "models/perk_bottle/c_perk_bottle_phd",
	icon = Material("nz_moo/icons/bo1/phd.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/bomb.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/phd.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/phd.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/phd.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/phd.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/phd.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/phd.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/phd.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/phd.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/phd.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/phd.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/phd.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/phd.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/phd.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/phd.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/phd.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/phd.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/phd.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/phd.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/phd.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/phd.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/phd.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/phd.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/phd.png", "smooth unlitgeneric"),
	color = Color(200, 0, 200),
	sting = "perkyworky/phd_sting.mp3",
	jingle = "perkyworky/mus_phd_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("deadshot", {
	name = "Deadshot Daiquiri",
	name_skin = "Deadeye Dewdrops",
	name_holo = "Laplus Latte",
	model = "models/nzr/2022/machines/ads/vending_ads.mdl",
	model_cw = "models/codmw2023/other/perkmachine_deadshotdaiquiri.mdl",
	skin = "models/perks/IWperks/deadeye/mc_mtl_p7_zm_vending_deadshot.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2000,
	price_skin = 2000,
	mmohud = {style = "chance", count = "nz.DeadshotChance", max = 15},
	desc = "Gain greatly improved weapon handling. Headshot kills occasionally explode.",
	desc2 = "Snap to zombie heads on ADS. You are now playing a point and click.",
	material = 3,
	wfz = "models/perk_bottle/c_perk_bottle_deadshot",
	icon = Material("nz_moo/icons/bo1/deadshot.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/deadeye.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/deadshot.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/deadshot.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/deadshot.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/deadshot.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/deadshot.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/deadshot.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/deadshot.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/deadshot.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/deadshot.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/deadshot.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/deadshot.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/deadshot.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/deadshot.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/deadshot.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/deadshot.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/deadshot.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/deadshot.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/deadshot.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/deadshot.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/deadshot.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/deadshot.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/deadshot.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/deadshot.png", "smooth unlitgeneric"),
	color = Color(50, 95, 50),
	sting = "perkyworky/deadshot_sting.mp3",
	jingle = "perkyworky/mus_deadshot_jingle.mp3",
	func = function(self, ply, machine)
        local tbl = {}
        for k, v in pairs(ply:GetWeapons()) do
            if not v:IsSpecial() then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:ApplyNZModifier("deadshot")
            end
        end
    end,
    lostfunc = function(self, ply)
        local tbl = {}
        for k,v in pairs(ply:GetWeapons()) do
            if v.IsTFAWeapon and v:HasNZModifier("deadshot") then
                table.insert(tbl, v)
            end
        end
        if tbl[1] != nil then
            for k, v in pairs(tbl) do
                v:RevertNZModifier("deadshot")
            end
        end
    end,
    upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("mulekick", {
	name = "Mule Kick",
	name_skin = "Mule Munchies",
	name_holo ="Lion's Lemonade",
	model = "models/nzr/2022/machines/three/vending_three.mdl",
	skin = "models/perks/IWperks/munchies/mc_mtl_p7_zm_vending_mulekick.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 4000,
	price_skin = 4000,
	desc = "Gain an additional weapon slot.",
	desc2 = "Hold an additional tactical grenade. Tactical grenades regenerate on round start.",
	material = 9,
	wfz = "models/perk_bottle/c_perk_bottle_mulekick",
	icon = Material("nz_moo/icons/bo1/mulekick.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/munchies.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/mulekick.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/mulekick.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/mulekick.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/mulekick.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/mulekick.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/mulekick.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/mulekick.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/mulekick.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/mule.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/mulekick.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/mulekick.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/mulekick.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/mulekick.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/mulekick.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/mule.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/mulekick.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/mulekick.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/mulekick.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/mulekick.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/mulekick.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/mulekick.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/mulekick.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/mulekick.png", "smooth unlitgeneric"),
	color = Color(0, 100, 0),
	sting = "perkyworky/mulekick_sting.mp3",
	jingle = "perkyworky/mus_mulekick_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
		local wep = ply:GetSpecialWeaponFromCategory("specialgrenade")
		if IsValid(wep) and wep.NZMuleModRestore then
			wep.NZSpecialWeaponData.MaxAmmo = wep.NZMuleModRestore
		end
	end,
	upgradefunc  = function(self, ply)
		local wep = ply:GetSpecialWeaponFromCategory("specialgrenade")
		if IsValid(wep) and !wep.NZNoMaxAmmo then
			wep.NZMuleModRestore = wep.NZSpecialWeaponData.MaxAmmo
			wep.NZSpecialWeaponData.MaxAmmo = wep.NZSpecialWeaponData.MaxAmmo + 1
		end
	end,
})

nzPerks:NewPerk("tombstone", {
	name = "Tombstone Soda",
	name_skin = "Tomb Toffees",
	name_holo = "Don't disgrace me by buying this perk",
	model = "models/codmw2023/other/perkmachine_tombstone.mdl",
	off_skin = 0,
	on_skin = 2,
	price = 2000,
	price_skin = 2000,
	desc = "Drop a Tombstone on down that you can retrieve to get everything back.",
	desc2 = "Kill a zombie while down to revive yourself and keep all perks.",
	material = 22,
	wfz = "models/perk_bottle/c_perk_bottle_tombstone",
	icon = Material("nz_moo/icons/bo1/tombstone.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/tombstone.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/tombstone.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/tombstone.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/tombstone.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/tombstone.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/tombstone.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/tombstone.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/tombstone.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/tombstone.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/tombstone.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/tombstone.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/tombstone.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/tombstone.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/tombstone.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/tombstone.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/tombstone.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/tombstone.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/tombstone.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/tombstone.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/tombstone.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/tombstone.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/tombstone.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/tombstone.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/tombstone.png", "smooth unlitgeneric"),
	color = Color(145, 255, 80),
	sting = "perkyworky/tombstone_sting.mp3",
	jingle = "perkyworky/mus_tombstone_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("whoswho", {
	name = "Who's Who",
	name_skin = "Who's Whoberry Fizz",
	name_holo = "Bao Beer",
	model = "models/nzr/2022/machines/chugabud/vending_chugabud.mdl",
	price = 2000,
	price_skin = 2000,
	mmohud = {style = "%", delay = "nz.ChuggaDelay", upgrade = "nz.ChuggaTeleDelay", hide = true, time = true, max = 180, border = true},
	desc = "Randomly teleport away after taking fatal damage from a zombie. Damage is ignored. 3 minute cooldown.",
	desc2 = "Press & Hold [USE + Reload] to randomly teleport with a 10 second cooldown.",
	material = 20,
	wfz = "models/perk_bottle/c_perk_bottle_whoswho",
	icon = Material("nz_moo/icons/bo1/whoswho.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/whoswho.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/whoswho.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/whoswho.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/whoswho.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/whoswho.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/whoswho.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/whoswho.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/whoswho.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/whoswho.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/whoswho.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/whoswho.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/whoswho.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/whoswho.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/whoswho.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/whoswho.jpg", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/whoswho.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/whoswho.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/whoswho.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/whoswho.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/whoswho.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/whoswho.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/whoswho.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/whoswho.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/whoswho.png", "smooth unlitgeneric"),
	color = Color(90, 255, 90),
	sting = "perkyworky/whoswho_sting.mp3",
	jingle = "perkyworky/whoswho_jingle.mp3",
	func = function(self, ply, machine)
		if ply:HasUpgrade('whoswho') then
			ply:PrintMessage(HUD_PRINTCENTER, "PRESS AND HOLD [USE + Reload] TO RANDOMLY TELEPORT")
		end
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("pop", {
	name = "Elemental Pop",
	name_skin = "Change Chews",
	name_holo = "Chaos Rat Cola",
	model = "models/codmw2023/other/perkmachine_elementalpop.mdl",
	off_skin = 0,
	on_skin = 2,
	price = 5000,
	price_skin = 5000,
	mmohud = {style = "chance", count = "nz.EPopChance", delay = "nz.EPopDelay", max = 15},
	desc = "Slain zombies have a chance to proc an AAT on death.",
	desc2 = "Random Wonder Weapon effects added to AAT list. Decreased cooldown time.",
	material = 11,
	wfz = "models/perk_bottle/c_perk_bottle_wall",
	icon = Material("nz_moo/icons/bo1/epop.png", "smooth unlitgeneric"),
	icon_iw = Material("nz_moo/icons/cw/epop_alt.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/epop.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/epop.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/epop.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/epop_alt.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/epop_alt.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/epop_alt.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/epop_alt.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/epop_alt.png", "smooth unlitgeneric"),
	icon_mw = Material("nz_moo/icons/mw/epop.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/epop_alt.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/epop.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/epop.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/pop.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/pop.png", "smooth unlitgeneric"),
	icon_glow = Material("nz_moo/icons/no background/epop_alt.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/epop_alt.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/epop.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/epop_alt.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/epop_alt.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/epop_alt.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/epop.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/epop.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/epop.png", "smooth unlitgeneric"),
	color = Color(255, 50, 250),
	sting = "nz/machines/jingle/pop_get.ogg",
	jingle = "perkyworky/mus_elemental_pop_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("cherry", {
	name = "Electric Cherry",
	name_skin = "Blue Bolts",
	name_holo = "Sharknado Scotch",
	model = "models/nzr/2022/machines/cherry/vending_cherry.mdl",
	skin = "models/perks/IWperks/bolts/cherry.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 2000,
	price_skin = 2000,
	mmohud = {style = "%", count = "nz.CherryCount", upgrade = "nz.CherryWaffe", max = 10, border = true},
	desc = "Reloading creates a burst of electricity around you.",
	desc2 = "Electricity always kills. Shoot a bolt of lightning on last shot.",
	material = 1,
	wfz = "models/perk_bottle/c_perk_bottle_cherry",
	icon = Material("nz_moo/icons/bo1/cherry.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/bolts.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/cherry.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/cherry.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/cherry.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/cherry.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/cherry.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/cherry.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/cherry.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/cherry.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/cherry.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/cherry.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/cherry.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/cherry.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/cherry.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/cherry.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/cherry.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/cherry.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/cherry.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/cherry.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/cherry.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/cherry.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/cherry.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/cherry.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/cherry.png", "smooth unlitgeneric"),
	color = Color(20, 20, 255),
	sting = "perkyworky/cherry_sting.mp3",
	jingle = "perkyworky/cherry_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("vulture", {
	name = "Vulture Aid Elixir",
	name_skin = "Dr Vulture's Weight Suppressent Candy",
	name_holo = "Duck Hunter",
	model = "models/nzr/2022/machines/vulture/vending_vulture.mdl",
	price = 3000,
	price_skin = 3000,
	desc = "Slain zombies can drop points, ammo, and armor.",
	desc2 = "All players can pickup Vulture's drops. Increased drop rate.",
	material = 18,
	wfz = "models/perk_bottle/c_perk_bottle_vulture",
	icon = Material("nz_moo/icons/bo1/vulture.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/vulture.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/vulture.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/vulture.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/vulture.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/vulture.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/vulture.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/vulture.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/vulture.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/vulture.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/vulture.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/vulture.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/vulture.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/vulture.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/vulture.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/vulture.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/vulture.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/vulture.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/vulture.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/vulture.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/vulture.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/vulture.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/vulture.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/vulture.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/vulture.png", "smooth unlitgeneric"),
	color = Color(255, 20, 20),
	sting = "perkyworky/vulture_sting.mp3",
	jingle = "perkyworky/vulture_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("wunderfizz", {
	name = "Der Wunderfizz", -- Nothing more is needed, it is specially handled
	specialmachine = true,
})

nzPerks:NewPerk("widowswine", {
	name = "Widow's Wine",
	name_skin = "Widow's Wine",
	name_holo = "Big Web Heart",
	model = "models/perks/Tperks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	skin = "models/perks/Tperks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	off_skin = 1,
	on_skin = 0,
	price = 4000,
	price_skin = 4000,
	desc = "When attacked, ensnare every zombie around you in webs and nullify the damage.",
	desc2 = "Increased web explosion radius. Regain two grenades per widows drop. need better ideas.",
	material = 21,
	wfz = "models/perk_bottle/c_perk_bottle_widowswine",
	icon = Material("nz_moo/icons/bo1/widows_wine.png", "smooth unlitgeneric"),
	icon_iw = Material("perk_icons/chron/widows_wine.png", "smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/widows_wine.png", "smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/widows_wine.png", "smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/widows_wine.png", "smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/widows_wine.png", "smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/widows_wine.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/widows_wine.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/widows_wine.png", "smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/widows_wine.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/widows_wine.png", "smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/widows_wine.png", "smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/widows_wine.png", "smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/widows_wine.png", "smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/widows.png", "smooth unlitgeneric"),
	icon_holo = Material("perk_icons/holo/widows.png", "smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/widowswine.png", "smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/widows_wine.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/widows_wine.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/widows_wine.png", "smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/widows_wine.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/widows_wine.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/widows_wine.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/widows_wine.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/widows_wine.png", "smooth unlitgeneric"),
	color = Color(255, 20, 75),
	sting = "perkyworky/widowswine_sting.mp3",
	jingle = "perkyworky/mus_widows_wine_jingle.mp3",
	func = function(self, ply, machine)
		if IsValid(ply) then
			ply:Give("nz_bo3_semtex")
			ply:SetAmmo(4, GetNZAmmoID("grenade"))
		end
	end,
	lostfunc = function(self, ply)
		timer.Simple(0, function()
			if not IsValid(ply) then return end
			ply:StripWeapon("nz_bo3_semtex")
		end)
		ply:Give(nzMapping.Settings.grenade or 'tfa_bo1_m67')
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("death", {
	name = "Death Perception",
	name_skin = "Killshot Kola",
	name_holo = "Head Hunter Elixir",
	model = "models/codmw2023/other/perkmachine_deathperception.mdl",
	skin = "models/codmw2023/other/perkmachine_deathperception.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2500,
	price_skin = 2500,
	desc = "Gain 25% increased critical damage. Enemies give danger indicators when behind the Player.",
	desc2 = "Gain an additional 25% increased critical damage. Gain insanely increased damage against bosses.",
	material = 26,
	wfz = "models/perk_bottle/c_perk_bottle_danger",
	icon = Material("nz_moo/icons/bo1/death.png",		"smooth unlitgeneric"),
	icon_iw = Material("perk_icons/death.png",		"smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/death.png",		"smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/death.png",		"smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/death.png",		"smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/death.png",		"smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/death.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/death.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/death.png",		"smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/death.png", "smooth unlitgeneric"),
	icon_mw = Material("perk_icons/mw/death.png",		"smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/death.png",		"smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/death.png",		"smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/death.png",		"smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/deathperception.png",	"smooth unlitgeneric"),
	icon_holo = Material("perk_icons/death.png",	"smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/death.png",	"smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/death.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/death.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/death.png",		"smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/death.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/death.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/death.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/death.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/death.png", "smooth unlitgeneric"),
	color = Color(220, 45, 5),
	sting = "perkyworky/death_sting.mp3",
	jingle = "perkyworky/mus_death_perception_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("tortoise", {
	name = "Victorious Tortoise",
	name_skin = "Iron Skin Shake",
	name_holo = "SteelSkin Smoothie",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_victor/models/kate_codz_p7_zm_vending_victor.mdl",
	-- skin = "models/nzr/2022/misc/weaponlocker.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 4000,
	price_skin = 4000,
	mmohud = {style = "%", count = "nz.TortCount", delay = "nz.TortDelay", max = 10},
	desc = "Take 50% reduced damage from behind. Create an explosion upon downing.",
	desc2 = "Gain a shield at the start of each round if shield slot is not occupied.",
	material = 25,
	wfz = "models/perk_bottle/c_perk_bottle_speed",
	icon = Material("nz_moo/icons/bo1/victor.png",	"smooth unlitgeneric"),
	icon_iw = Material("perk_icons/tort.png",	"smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/victor.png",	"smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/victor.png",	"smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/victor.png",	"smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/victor.png",	"smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/victor.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/victor.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/victor.png",	"smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/victor.png", "smooth unlitgeneric"),
	icon_mw = Material("nz_moo/icons/mw/victor.png",	"smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/victor.png",	"smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/victor.png",	"smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/victor.png",	"smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/tortise.png",	"smooth unlitgeneric"),
	icon_holo = Material("perk_icons/tort.png",	"smooth unlitgeneric"),
	icon_glow = Material("perk_icons/nobg/tortoise.png",	"smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/tortoise.png", "smooth unlitgeneric"),
	icon_ww2 = Material("perk_icons/ww2/tortoise.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/victor.png",	"smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/victor.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/victor.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/victor.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/victor.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/victor.png", "smooth unlitgeneric"),
	color = Color(70, 185, 30),
	sting = "perkyworky/stingers/tortoise_stinger.mp3",
	jingle = "perkyworky/tortoise_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})


nzPerks:NewPerk("time", {
	name = "Timeslip Tonic",
	name_skin = "Timer Tant-Rum",
	name_holo = "Timeslip Soda",
	model = "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_timeslip/moo_codz_p7_zm_vending_timeslip.mdl",
	off_skin = 0,
	on_skin = 1,
	price = 2000,
	price_skin = 2000,
	desc = "Spin the box, Pack a Punch, reset Traps, and generate Specialist faster.",
	desc2 = "Powerups that you pickup last twice as long.",
	material = 27,
	wfz = "models/perk_bottle/c_perk_bottle_phd",
	icon = Material("nz_moo/icons/bo1/time.png",	"smooth unlitgeneric"),
	icon_iw = Material("perk_icons/time.png",	"smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/time.png",	"smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/time.png",	"smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/time.png",	"smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/time.png",	"smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/time.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/time.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/time.png",	"smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/time.png", "smooth unlitgeneric"),
	icon_mw = Material("nz_moo/icons/mw/time.png",	"smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/time.png",	"smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/time.png",	"smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/time.png",	"smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/time.png",	"smooth unlitgeneric"),
	icon_holo = Material("perk_icons/time.png",	"smooth unlitgeneric"),
	icon_glow = Material("nz_moo/icons/no background/time.png",	"smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/time.png", "smooth unlitgeneric"),
	icon_ww2 = Material("nz_moo/icons/ww2/time.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/time.png",	"smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/time.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/time.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/time.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/time.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/time.png", "smooth unlitgeneric"),
	color = Color(130, 10, 200),
	sting = "perkyworky/stingers/time_sting_alt.mp3",
	jingle = "perkyworky/timeslip_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("winters", {
	name = "Winter's Wail",
	name_skin = "Backshot Brew",
	name_holo = "Frost Bitters",
	model = "models/perks/winterswail.mdl",
	skin =  "models/perks/winterswail2.mdl",
	--off_skin = 0,
	--on_skin = 1,
	price = 3000,
	price_skin = 3000,
	mmohud = {style = "count", count = "nz.WailCount", delay = "nz.WailDelay", countdown = true},
	desc = "When taking damage with less than max health create a frost explosion freezing nearby enemies.",
	desc2 = "Unleash an ice storm slowing nearby enemies after the frost explosion. Hold an additional charge.",
	material = 28,
	wfz = "models/perk_bottle/c_perk_bottle_phd",
	icon = Material("nz_moo/icons/bo1/winter.png",	"smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/winter.png",	"smooth unlitgeneric"),
	icon_iw = Material("perk_icons/winter.png",	"smooth unlitgeneric"),
	icon_waw = Material("nz_moo/icons/bo1/winter.png",	"smooth unlitgeneric"),
	icon_bo2 = Material("nz_moo/icons/charred/winter.png",	"smooth unlitgeneric"),
	icon_bo3 = Material("nz_moo/icons/bo3/winter.png",	"smooth unlitgeneric"),
	icon_bo4 = Material("nz_moo/icons/bo4/winter.png",	"smooth unlitgeneric"),
	icon_mwz = Material("nz_moo/icons/mw3z/winter.png", "smooth unlitgeneric"),
	icon_cotd = Material("nz_moo/icons/frosted/winter.png", "smooth unlitgeneric"),
	icon_griddy = Material("nz_moo/icons/griddy/winter.png",	"smooth unlitgeneric"),
	icon_grown = Material("nz_moo/icons/overgrown/winter.png", "smooth unlitgeneric"),
	icon_mw = Material("nz_moo/icons/mw/winter.png",	"smooth unlitgeneric"),
	icon_cw = Material("nz_moo/icons/cw/winter.png",	"smooth unlitgeneric"),
	icon_halloween = Material("nz_moo/icons/halloween/winter.png",	"smooth unlitgeneric"),
	icon_xmas = Material("nz_moo/icons/xmas/winter.png",	"smooth unlitgeneric"),
	icon_dumb = Material("nz_moo/icons/aprilfools/wail.png",	"smooth unlitgeneric"),
	icon_holo = Material("perk_icons/winter.png",	"smooth unlitgeneric"),
	icon_glow = Material("nz_moo/icons/no background/winter.png",	"smooth unlitgeneric"),
	icon_soe = Material("nz_moo/icons/soe/winter.png", "smooth unlitgeneric"),
	icon_ww2 = Material("nz_moo/icons/ww2/winter.png", "smooth unlitgeneric"),
	icon_neon = Material("nz_moo/icons/neon/winter.png",	"smooth unlitgeneric"),
	icon_pickle = Material("nz_moo/icons/pickle/winter.png", "smooth unlitgeneric"),
	icon_coggers = Material("nz_moo/icons/herren/winter.png", "smooth unlitgeneric"),
	icon_cheese = Material("nz_moo/icons/cheese/winter.png", "smooth unlitgeneric"),
	icon_paper = Material("nz_moo/icons/paper/winter.png", "smooth unlitgeneric"),
	icon_charred = Material("nz_moo/icons/bo2/winter.png", "smooth unlitgeneric"),
	color = Color(50, 200, 250),
	sting = "perkyworky/stingers/winters_sting.mp3",
	jingle = "perkyworky/winter_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})
