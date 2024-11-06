-- For temporary perk models use: "models/nzr/2022/misc/weaponlocker.mdl",

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

/*function nzPerks:GetBottleMaterials()
	local tbl = {}
	
	for k,v in pairs(nzPerks.Data) do
		tbl[k] = v.wfz
	end
	
	return tbl
end*/

function nzPerks:GetMachineType(id)
	if id == "Original" then
	return "OG"
	end
	if id == "Infinite Warfare" then
	return "IW"
	end
	if id == "Cold Snore" then
	return "CW"
	end
	if id == "Bo3" then
	return "VG"
	end
	if id == "Classic" or "Classic Four" then
    return "CLASSIC"
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
	if id == "Origins Red" then
	return "nz_tomb_red"
	end
	if id == "Tranzit" then
	return "bo2"
	end
	if id == "Original" then
	return "og"
	end
	if id == "Classic" then
	return "waw"
	end
	if id == "Halloween" then
	return "spooky"
	end
	if id == nil then
	return "og"
	end
end


nzPerks:NewPerk("dtap", {
	name 			= "Double Tap",
	name_skin 		= "Bang Bangs",
	name_holo 		= "Reaper's Delight",
	model 			= "models/nzr/2022/machines/dtap/vending_dtap.mdl",
	model_vg 		= "models/nzr/2022/machines/dtap/vending_dtap.mdl",
	skin 			= "models/iwperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 3000, 
	desc 			= "+30% Fire Rate.",
	desc2 			= "+60% Fire Rate.",
	color 			= Color(255, 125, 0),	
	material 		= 0,

	sting 			= "perkyworky/dtap_sting.mp3",
	jingle 			= "perkyworky/mus_doubletap_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,23,32), ang = Angle(0,28,-155),spread = 2},
		[2] = {pos = Vector(-2,-23,32), ang = Angle(0,-28,154),spread = 2},
		[3] = {pos = Vector(8,-10,57), ang = Angle(168,12,0),spread = 2},
	},
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("dtap")
			end
		end
	end,
	lostfunc = function(self, ply)
		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("dtap") then
				v:RevertNZModifier("dtap")
			end
		end
	end,
	upgradefunc  = function(self, ply)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
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
	name 			= "Double Tap II",
	name_skin 		= "Bang Bangs",
	name_holo 		="Seal Soda",
	model 			= "models/nzr/2022/machines/dtap2/vending_dtap2.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_doubletap2/moo_codz_p7_zm_vending_doubletap2.mdl",
	model_classic 	= "models/nzr/2022/machines/dtap2/vending_dtap2.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_doubletap2/moo_codz_p7_zm_vending_doubletap2.mdl",
	skin 			= "models/iwperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 5000, 
	desc 			= "+10% Fire Rate | x2 Bullets Per Shot.",
	desc2 			= "Projectile Functionality.",
	color 			= Color(255, 125, 0),
	material 		= 0,

	sting 			= "perkyworky/dtap_sting.mp3",
	jingle 			= "perkyworky/mus_doubletap_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,23,32), ang = Angle(0,28,-155),spread = 2},
		[2] = {pos = Vector(-2,-23,32), ang = Angle(0,-28,154),spread = 2},
		[3] = {pos = Vector(8,-10,57), ang = Angle(168,12,0),spread = 2},
	},
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("dtap2")
			end
		end
	end,
	lostfunc = function(self, ply)
		for k, v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("dtap2") then
				v:RevertNZModifier("dtap2")
			end
		end
	end,
	upgradefunc  = function(self, ply)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:RevertNZModifier("dtap2")
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(v) then return end
					v:ApplyNZModifier("dtap2")
				end)
			end
		end
	end,
})

nzPerks:NewPerk("speed", {
	name 			= "Speed Cola",
	name_skin 		= "Quickies",
	name_holo 		= "Kronii Cola",
	model 			= "models/nzr/2022/machines/sleight/vending_sleight.mdl",
	model_classic 	= "models/nzr/2022/machines/sleight/vending_sleight.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_speed_cola/moo_codz_jup_zm_machine_speed_cola.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_sleight/moo_codz_p7_zm_vending_sleight.mdl",
	skin 			= "models/iwperks/quickies/mc_mtl_p7_zm_vending_speedcola.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 5000,
	mmohud 			= {style = "count", count = "nz.SpeedCount", delay = "nz.SpeedDelay", upgradeonly = true},
	desc 			= "x2 Reload & Repair Speed.",
	desc2 			= "Holstered Reloading | Instant Shell Reload | Faster Perk Drinking.",
	color 			= Color(25, 255, 25),
	material 		= 15,

	sting 			= "perkyworky/speed_sting.mp3",
	jingle 			= "perkyworky/mus_speed_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(5,14,17), ang = Angle(108,12,-0),spread = 3},
		[2] = {pos = Vector(5,-14,17), ang = Angle(108,12,0),spread = 3},
		[3] = {pos = Vector(12,-10,67), ang = Angle(168,12,0),spread = 2},
		[4] = {pos = Vector(-3,6,73), ang = Angle(0,0,-19),spread = 3},
		[5] = {pos = Vector(-1,-6,73), ang = Angle(0,0,19),spread = 3},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("speed") then
				v:RevertNZModifier("speed")
			end
		end
	end,
	upgradefunc  = function(self, ply)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("speed")
			end
		end
	end,
})

nzPerks:NewPerk("jugg", {
	name 			= "Juggernog",
	name_skin 		= "Tuff 'Nuff",
	name_holo 		= "Dragon's Blood",
	model 			= "models/nzr/2022/machines/jugg/vending_jugg.mdl",
	model_classic 	= "models/nzr/2022/machines/jugg/vending_jugg.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_juggernog/moo_codz_jup_zm_machine_juggernog.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_jugg/moo_codz_p7_zm_vending_jugg.mdl",
	skin 			= "models/iwperks/tuff/mc_mtl_p7_zm_vending_jugg.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2500,
	upgradeprice 	= 3000, 
	desc 			= "+100 Health.",
	desc2 			= "+200 Armor Every Round | +10 For Critical Kills.",
	color 			= Color(255, 25, 25),
	material 		= 7,

	sting 			= "perkyworky/jugg_sting.mp3",
	jingle 			= "perkyworky/mus_jugganog_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,3,16), ang = Angle(0,0,-133),spread = 2},
		[2] = {pos = Vector(-2,-3,16), ang = Angle(0,0,133),spread = 2},
		[3] = {pos = Vector(-14,8,80), ang = Angle(0,0,-146),spread = 7},
		[4] = {pos = Vector(-14,-8,80), ang = Angle(0,0,146),spread = 7},
	},
	func = function(self, ply, machine)
		ply:SetMaxHealth((nzMapping.Settings.hp) + 100)
		ply:SetHealth((nzMapping.Settings.hp) + 100)
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

nzPerks:NewPerk("amish", {
	name 			= "Amish Ale",
	name_skin 		= "Hippie Hops",
	name_holo 		= "Board-Pounding Beer",
	model 			= "models/perks/Cperks/amish/amish_off.mdl",
	model_off 		= "models/perks/Cperks/amish/amish_off.mdl",
	skin 			=  "models/perks/Cperks/amish/amish_off.mdl",
	off_skin 		= 1,
	on_skin 		= 0,
	price 			= 1500,
	upgradeprice 	= 3000, 
	desc 			= "Sturdy Barricades | Board to Death | Bonus Repairal Points.",
	desc2 			= "Increased BtD chance | Auto Repairal | Improved Range | 25% Faster Repair.",
	color 			= Color(255, 255, 100),
	material 		= 23,

	sting 			= "nz/machines/jingle/amish_get.ogg",
	jingle 			= "nz/machines/jingle/amish_get.ogg",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,23,32), ang = Angle(0,28,-155),spread = 2},
		[2] = {pos = Vector(-2,-23,32), ang = Angle(0,-28,154),spread = 2},
		[3] = {pos = Vector(8,-10,57), ang = Angle(168,12,0),spread = 2},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("revive", {
	name 			= "Quick Revive",
	name_skin 		= "Up N' Atoms",
	name_holo 		= "Gorilla Revive",
	model 			= "models/nzr/2022/machines/revive/vending_revive.mdl",
	model_classic = "models/nzr/2022/machines/revive/vending_revive.mdl",
	model_cw = "models/moo/_codz_ports_props/t10/jup_zm_machine_quick_revive/moo_codz_jup_zm_machine_quick_revive.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_revive/moo_codz_p7_zm_vending_revive.mdl",
	skin 			= "models/moo/_codz_ports_props/iw7/zmb/perks/moo_codz_iw7_zmb_upnatoms.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 1500,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "count", count = "nz.SoloReviveCount", countdown = true, solo = true},
	desc 			= "Faster Health Regen | SOLO: Self Revival | CO-OP: x2 Faster Revive.",
	desc2 			= "Revive Whilst Moving | 10s Invulnerablity On Revive.",
	color 			= Color(35, 35, 255),
	material 		= 13,

	sting 			= "perkyworky/revive_sting.mp3",
	jingle 			= "perkyworky/mus_revive_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(1,19,27), ang = Angle(0,0,-148),spread = 3},
		[2] = {pos = Vector(1,-19,27), ang = Angle(0,0,148),spread = 3},
	},

	func = function(self, ply, machine)
		if #player.GetAllPlaying() <= 1 then
			local maxrevives = (nzMapping.Settings.solorevive or 3)
			if maxrevives > 0 then
				if !ply.SoloRevive or ply.SoloRevive < maxrevives then
					ply:ChatPrint("[NZ] You got Quick Revive (Solo)!")
				else
					ply:ChatPrint("[NZ] Out of Solo Revives")
				end
			else
				ply:ChatPrint("[NZ] Solo Revive is disabled")
				return
			end
		end
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("vigor", {
	name 			= "Vigor Rush",
	name_skin 		= "Vigorous Violets",
	name_holo 		= "Horny Highballer",
	model 			= "models/nzr/2022/machines/vigor/vending_vigor.mdl",
	model_classic = "models/wavy_ports/waw/vigor_rush.mdl",
	model_vg 		= "models/nzr/2022/machines/vigor/vending_vigor.mdl",
	skin 			= "models/nzr/2022/machines/vigor/vending_vigor.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 6500, 
	desc 			= "x2 Bullet Damage | Explosive Ammunition.",
	desc2 			= "x3 Bullet Damage | Bullets Provide Bonus Points.",
	color 			= Color(128, 128, 64),
	material 		= 17,

	sting 			= "perkyworky/stingers/vigorush_sting.mp3",
	jingle 			= "perkyworky/vigor_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,3,16), ang = Angle(0,0,-123),spread = 2},
		[2] = {pos = Vector(-2,-3,16), ang = Angle(0,0,123),spread = 2},
	},
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("vigor")
			end
		end
	end,
	lostfunc = function(self, ply)
		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("vigor") then
				v:RevertNZModifier("vigor")
			end
		end
	end,
	upgradefunc  = function(self, ply)
	
	end,
})

nzPerks:NewPerk("fire", {
	name 			= "Napalm Nectar",
	name_skin 		= "Firestarter Fizzy",
	name_holo 		= "Pheonix Elixir",
	model 			= "models/perks/Cperks/napalm/napalm.mdl",
	model_classic 	= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_stopping_power/moo_codz_p7_zm_vending_stopping_power.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_stopping_power/moo_codz_p7_zm_vending_stopping_power.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_stopping_power/moo_codz_p7_zm_vending_stopping_power.mdl",
	skin 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_stopping_power/moo_codz_p7_zm_vending_stopping_power.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 4000, 
	mmohud 			= {style = "count", count = "nz.BurnCount", delay = "nz.BurnDelay"},
	desc 			= "Burnout When Hit | Fire Immunity | x2 Fire Damage.",
	desc2 			= "Cooldown Reduced | Incendiary Ammunition | x4 Fire Damage.",
	color 			= Color(222, 69, 2),
	material 		= 5,

	sting 			= "nz_moo/perkycolas/stingers/fire_sting.mp3",
	jingle 			= "perkyworky/fire_sting.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-2,3,16), ang = Angle(0,0,-123),spread = 2},
		[2] = {pos = Vector(-2,-3,16), ang = Angle(0,0,123),spread = 2},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	
	end,
})

nzPerks:NewPerk("mask", {
	name 			= "Mask Moscatto",
	name_skin 		= "Mask Moscato",
	name_holo 		= "Orca Old Fashioned",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_mask/kate_codz_p7_zm_vending_mask.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 1500,
	upgradeprice 	= 2500, 
	desc 			= "Nova / Map Hazard Immunity | Grenades Leave A Foul Odor...",
	desc2 			= "Stun Immunity",
	color 			= Color(92, 165, 30),
	material 		= 8,

	sting 			= "perkyworky/mask_sting.mp3",
	jingle 			= "perkyworky/mask_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(0,8,15), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-8,15), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(0,0,35), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("staminup", {
	name 			= "Stamin-Up",
	name_skin 		= "Racin' Stripes",
	name_holo 		= "GOD Speed Gatorade",
	model 			= "models/nzr/2022/machines/marathon/vending_marathon.mdl",
	model_cw = "models/moo/_codz_ports_props/t10/jup_zm_machine_staminup/moo_codz_jup_zm_machine_staminup.mdl",
	skin 			= "models/iwperks/stripes/mc_mtl_p7_zm_vending_marathon.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 4000, 
	desc 			= "x2 Stamina | +10% Movement Speed | Reduced Weight.",
	desc2 			= "Unlimited Stamina.",
	color 			= Color(255, 200, 50),
	material 		= 16,

	sting 			= "perkyworky/staminup_sting.mp3",
	jingle 			= "perkyworky/mus_stamin_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-8,14,14), ang = Angle(110,24,-8),spread = 3},
		[2] = {pos = Vector(-8,-14,14), ang = Angle(110,-24,8),spread = 3},
		[3] = {pos = Vector(-2,7,71), ang = Angle(0,0,-146),spread = 4},
		[4] = {pos = Vector(-2,-7,71), ang = Angle(0,0,146),spread = 4},
	},
	func = function(self, ply, machine)
		ply:SetWalkSpeed( 210 )
		ply:SetRunSpeed( 341 )
		ply:SetMaxRunSpeed( 341 )

		ply:SetStamina( nzMapping.Settings.stamina*2 )
		ply:SetMaxStamina( nzMapping.Settings.stamina*2 )

		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("staminup")
			end
		end
	end,
	lostfunc = function(self, ply)
		ply:SetWalkSpeed( 190 )
		ply:SetRunSpeed( 310 )
		ply:SetMaxRunSpeed( 310 )

		ply:SetStamina( nzMapping.Settings.stamina )
		ply:SetMaxStamina( nzMapping.Settings.stamina )

		ply:SetStaminaLossAmount( 0.9 )
		ply:SetStaminaRecoverAmount( nzMapping.Settings.staminaregenamount )

		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("staminup") then
				v:RevertNZModifier("staminup")
			end
		end
	end,
	upgradefunc  = function(self, ply)
		ply:SetWalkSpeed( 210 )
		ply:SetRunSpeed( 341 )
		ply:SetMaxRunSpeed( 341 )

		ply:SetStamina( math.max(nzMapping.Settings.stamina, 15) )
		ply:SetMaxStamina( math.max(nzMapping.Settings.stamina, 15) )

		ply:SetStaminaLossAmount( 0.05 )
		ply:SetStaminaRecoverAmount( math.max(nzMapping.Settings.staminaregenamount, 15) )
	end,
})

nzPerks:NewPerk("politan", {
	name 			= "Random-o-Politan",
	name_skin 		= "Random-o-Politan",
	name_holo 		= "Kureiji Cola",
	model 			= "models/perks/Cperks/random/random.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model_off 		= "models/perks/Cperks/random/random.mdl",
	price 			= 5000,
	upgradeprice 	= 7000, 
	desc 			= "Random Weapon on Empty Reload.",
	desc2 			= "Packed Weapons.",
	color 			= Color(255, 172, 224),
	material 		= 12,

	sting 			= "nz_moo/perkycolas/stingers/politan_sting.ogg",
	jingle 			= "nz_moo/perkycolas/jingles/randomo_jingle.ogg",
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("rando")
			end
		end
	end,
	lostfunc = function(self, ply)
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
	name 			= "Slasher's Sake",
	name_skin 		= "Slappy Taffy",
	name_holo 		="Shogun Sake",
	skin 			= "models/iwperks/taffy/sake.mdl",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_slash/kate_codz_p7_zm_vending_slash.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 5000,
	upgradeprice 	= 4000, 
	mmohud 			= {style = "%", delay = "nz.SakeDelay", hide = true, time = true, max = 7, upgradeonly = true},
	desc 			= "666% Melee Damage.",
	desc2 			= "Electrostatic Melee.",
	color 			= Color(185, 214, 0),
	material 		= 14,

	sting 			= "nz_moo/perkycolas/stingers/slasher_sting.ogg",
	jingle 			= "nz_moo/perkycolas/jingles/sake_jingle.ogg",
	
	smokeparticles == {
		[1] = {pos = Vector(2,8,16), ang = Angle(0,0,-123),spread = 2},
		[2] = {pos = Vector(2,-8,16), ang = Angle(0,0,123),spread = 2},
		[3] = {pos = Vector(25,12,36), ang = Angle(0,90,123),spread = 2},
		[4] = {pos = Vector(25,-10,36), ang = Angle(0,90,123),spread = 2},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("danger", {
	name 			= "Danger Costa-Rican",
	name_skin 		= "Danger Costa-Rican",
	name_holo 		= "Elvish Explosive Expresso",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_fighters_fizz/moo_codz_p7_zm_vending_fighters_fizz.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2500,
	upgradeprice 	= 3000, 
	desc 			= "x2 Explosive Damage.",
	desc2 			= "x3 Explosive Damage | Nuke on Down.",
	color 			= Color(232, 116, 116),
	material 		= 2,

	sting 			= "nz_moo/perkycolas/stingers/dangercosta_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/danger_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-4,8,80), ang = Angle(0,0,-146),spread = 5},
		[2] = {pos = Vector(-4,-8,80), ang = Angle(0,0,146),spread = 5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("everclear", {
	name 			= "Explosive Everclear",
	name_skin 		= "Trail Blazers",
	name_holo 		= "FAQ Flavorade",
	skin 			= "models/iwperks/trailblazer/everclear.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_zombshell/moo_codz_p7_zm_vending_zombshell.mdl",
	price 			= 4500,
	upgradeprice 	= 5000, 
	desc 			= "Zombies Drop Slowing Orbs / Inferno Pits On Death.",
	desc2 			= "+40% Inferno Chance | +33% Orb Chance | +33% Reduced Cooldown.",
	color 			= Color(221, 66, 57),
	material 		= 4,
	mmohud 			= {style = "count", count = "nz.ZombShellCount", delay = "nz.ZombShellDelay"},

	sting 			= "nz_moo/perkycolas/stingers/everclear_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/everclear_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-3,14,17), ang = Angle(0,0,-158),spread = 3},
		[2] = {pos = Vector(-3,-14,17), ang = Angle(0,0,158),spread = 3},
		[3] = {pos = Vector(-5,8,76), ang = Angle(0,0,-146),spread = 7},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("gin", {
	name 			= "Juicer's Gin",
	name_skin 		= "Juicer's Gin",
	name_holo 		= "Lamy's Long Island Iced Tea",
	model 			= "models/nzr/2022/machines/jizz/vending_jizz.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model_off 		= "models/perks/Cperks/gin/gin.mdl",
	price 			= 3000,
	upgradeprice 	= 3000, 
	desc 			= "SOLO: +2 Perk Slots | CO-OP: +1 Shared Perk Slot.",
	desc2 			= "+1 Shared Perk Slot.",
	color 			= Color(40, 240, 220),
	material 		= 6,

	sting 			= "nz_moo/perkycolas/stingers/juicergin_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/gin_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-6,18,26), ang = Angle(0,0,-163),spread = 2},
		[2] = {pos = Vector(-6,-18,26), ang = Angle(0,0,163),spread = 2},
		[3] = {pos = Vector(-14,8,80), ang = Angle(0,0,-146),spread = 7},
		[4] = {pos = Vector(-14,-8,80), ang = Angle(0,0,146),spread = 7},
		[5] = {pos = Vector(8,-8,67), ang = Angle(168,12,0),spread = 2},
	},
	func = function(self, ply, machine)
		if ply:IsListenServerHost() and #player.GetAllPlaying() <= 1 then
			ply:SetMaxPerks(ply:GetMaxPerks() + 2)
		else
			local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
			cvar_maxperks:SetInt(cvar_maxperks:GetInt() + 1)

			nzPerks:IncreaseAllPlayersMaxPerks(1, ply) //see 154 of perks/sh_meta
		end
	end,
	lostfunc = function(self, ply)
		if ply:IsListenServerHost() and #player.GetAllPlaying() <= 1 then
			ply:SetMaxPerks(ply:GetMaxPerks() - 2)
		else
			local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
			cvar_maxperks:SetInt(cvar_maxperks:GetInt() - 1)

			nzPerks:DecreaseAllPlayersMaxPerks(1, ply)
		end
	end,
	upgradefunc = function(self, ply)
		if ply:IsListenServerHost() and #player.GetAllPlaying() <= 1 then
			ply:SetMaxPerks(ply:GetMaxPerks() + 1)
		else
			local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
			cvar_maxperks:SetInt(cvar_maxperks:GetInt() + 1)

			nzPerks:IncreaseAllPlayersMaxPerks(1, ply) //see 154 of perks/sh_meta
		end
	end,
	lostupgradefunc = function(self, ply)
		if ply:IsListenServerHost() and #player.GetAllPlaying() <= 1 then
			ply:SetMaxPerks(ply:GetMaxPerks() - 1)
		else
			local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
			cvar_maxperks:SetInt(cvar_maxperks:GetInt() - 1)

			nzPerks:DecreaseAllPlayersMaxPerks(1, ply)
		end
	end,
})

nzPerks:NewPerk("phd", {
	name 			= "PhD Flopper",
	name_skin 		= "Bombstoppers",
	name_holo 		="Desk Slam Daquiri",
	model 			= "models/nzr/2022/machines/nuke/vending_nuke.mdl",
	model_classic 	= "models/nzr/2022/machines/nuke/vending_nuke.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_phd_flopper/moo_codz_jup_zm_machine_phd_flopper.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_flopper/moo_codz_p7_zm_vending_flopper.mdl",
	skin 			= "models/iwperks/bomb/phdflopper.mdl", 
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "toggle", delay = "nz.PHDDelay"},
	desc 			= "Explosive / Fall Immunity | Explode on Impact When Falling / Sliding.",
	desc2 			= "Double Jump | Tap & Release Crouch After Double Jumping To Fast Fall.",
	color 			= Color(200, 0, 200),
	color_classic 	= Color(255, 235, 100), -- PHD is yellow. i was gonna make it only yellow on the classic 4 set but i'm really lazy so if you wanna revert this go ahead
	material 		= 10,

	sting 			= "perkyworky/phd_sting.mp3",
	jingle 			= "perkyworky/mus_phd_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-8,3,23), ang = Angle(0,28,-135),spread = 3},
		[2] = {pos = Vector(-8,-3,23), ang = Angle(0,-28,134),spread = 3},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("deadshot", {
	name 			= "Deadshot Daiquiri",
	name_skin 		= "Deadeye Dewdrops",
	name_holo 		= "Laplus Latte",
	model 			= "models/nzr/2022/machines/ads/vending_ads.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_deadshot/moo_codz_jup_zm_machine_deadshot.mdl",
	skin 			= "models/iwperks/deadeye/mc_mtl_p7_zm_vending_deadshot.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 1000, 
	mmohud 			= {style = "chance", count = "nz.DeadshotChance", max = 25},
	desc 			= "Improved Weapon Handling | Hipfire Laser | Headshots Occasionally Explode.",
	desc2 			= "Headshot Explosion Enduced Fear | Explosion Range & Damage Increased.",
	color 			= Color(50, 95, 50),
	color_cw 		= Color(255, 100, 0),
	material 		= 3,
	sting 			= "perkyworky/deadshot_sting.mp3",
	jingle 			= "perkyworky/mus_deadshot_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-1,10,26), ang = Angle(0,28,-155),spread = 2},
		[2] = {pos = Vector(-1,-10,26), ang = Angle(0,-28,154),spread = 2},
		[3] = {pos = Vector(-7,5,71), ang = Angle(0,37,72),spread = 5},
	},
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("deadshot")
			end
		end
	end,
	lostfunc = function(self, ply)
		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("deadshot") then
				v:RevertNZModifier("deadshot")
			end
		end
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("mulekick", {
	name 			= "Mule Kick",
	name_skin 		= "Mule Munchies",
	name_holo 		="Lion's Lemonade",
	model 			= "models/nzr/2022/machines/three/vending_three.mdl",
	skin 			= "models/iwperks/munchies/mc_mtl_p7_zm_vending_mulekick.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 4000,
	upgradeprice 	= 8000, 
	desc 			= "3rd Weapon Slot (Tied To Perk, Can Be Reaquired).",
	desc2 			= "+1 Tactical | Tactical Refill Every Round.",
	color 			= Color(0, 100, 0),
	material 		= 9,

	sting 			= "perkyworky/mulekick_sting.mp3",
	jingle 			= "perkyworky/mus_mulekick_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(5,14,17), ang = Angle(108,12,-0),spread = 3},
		[2] = {pos = Vector(5,-14,17), ang = Angle(108,12,0),spread = 3},
		[3] = {pos = Vector(-3,6,73), ang = Angle(0,0,-19),spread = 3},
		[4] = {pos = Vector(-1,-6,73), ang = Angle(0,0,19),spread = 3},
	},
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
	name 			= "Tombstone Soda",
	name_skin 		= "Tombstone Soda",
	name_holo 		= "Don't disgrace me by buying this perk",
	model 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_tombstone/moo_codz_jup_zm_machine_tombstone.mdl",
	model_classic 	= "models/nzr/2022/machines/tombstone/vending_tombstone.mdl",	
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_tombstone/moo_codz_jup_zm_machine_tombstone.mdl",
	model_vg 		= "models/nzr/2022/machines/tombstone/vending_tombstone.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 4000, 
	desc 			= "Tombstone Dropped On Death, Pickup To Reaquire Lost Items.",
	desc2 			= "When Downed Kill A Zombie To Revive Self (CO-OP only)",
	color 			= Color(145, 255, 80),
	color_cw 		= Color(255, 225, 0),
	material 		= 22,

	sting 			= "perkyworky/tombstone_sting.mp3",
	jingle 			= "perkyworky/mus_tombstone_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(20,15,20), ang = Angle(0,90,123),spread = 2},
		[2] = {pos = Vector(20,-13,20), ang = Angle(0,90,123),spread = 2},
		[3] = {pos = Vector(20,0,20), ang = Angle(0,90,123),spread = 2},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("whoswho", {
	name 			= "Who's Who",
	name_skin 		= "Who's Who",
	name_holo 		= "Bao Beer",
	model 			= "models/nzr/2022/machines/chugabud/vending_chugabud.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 1000, 
	mmohud 			= {style = "%", delay = "nz.ChuggaDelay", upgrade = "nz.ChuggaTeleDelay", hide = true, time = true, max = 180, border = true},
	desc 			= "Random Teleportation Upon Taking Fatal Damage.",
	desc2 			= "Press & Hold [USE + Reload] To Randomly Teleport.",
	color 			= Color(90, 255, 90),
	material 		= 20,

	sting 			= "perkyworky/whoswho_sting.mp3",
	jingle 			= "perkyworky/whoswho_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(0,18,20), ang = Angle(0,0,-123),spread = 2},
		[2] = {pos = Vector(0,-18,20), ang = Angle(0,0,123),spread = 2},
	},
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
	name 			= "Elemental Pop",
	name_skin 		= "Change Chews",
	name_holo 		= "Chaos Rat Cola",
	model 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_elemental_pop/moo_codz_jup_zm_machine_elemental_pop.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 5000,
	upgradeprice 	= 6000,
	mmohud 			= {style = "chance", count = "nz.EPopChance", delay = "nz.EPopDelay", max = 15},
	desc 			= "Bullets Have A Chance To Activate Random AATs.",
	desc2 			= "Wonder Weapon AATs | Decreased Cooldown.",
	color 			= Color(255, 50, 250),
	material 		= 11,

	sting 			= "nz_moo/perkacolas/pop_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/mus_elemental_pop_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(0,28,36), ang = Angle(0,0,-180),spread = 1},
		[2] = {pos = Vector(0,-28,36), ang = Angle(0,0,180),spread = 1},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("cherry", {
	name 			= "Electric Cherry",
	name_skin 		= "Blue Bolts",
	name_holo 		= "Sharknado Scotch",
	model 			= "models/nzr/2022/machines/cherry/vending_cherry.mdl",
	skin 			= "models/iwperks/bolts/cherry.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "%", count = "nz.CherryCount", upgrade = "nz.CherryWaffe", max = 10, border = true},
	desc 			= "Electric Burst That Damages & Stuns Upon Reload.",
	desc2 			= "Increased Damage | Wunderwaffe Bolt On Emptying Mag.",
	color 			= Color(20, 20, 255),
	material 		= 1,

	sting 			= "perkyworky/cherry_sting.mp3",
	jingle 			= "perkyworky/cherry_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(-5,16,14), ang = Angle(110,24,-8),spread = 3},
		[2] = {pos = Vector(-5,-16,14), ang = Angle(110,-24,8),spread = 3},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("vulture", {
	name 			= "Vulture Aid Elixir",
	name_skin 		= "Vulture Aid Elixir",
	name_holo 		= "Duck Hunter",
	model 			= "models/nzr/2022/machines/vulture/vending_vulture.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 3000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "count", count = "nz.VultureCount", max = 4, countup = true},
	desc 			= "Personal Ammo, Points & Mist Drops (Mist Provides Invisibility).",
	desc2 			= "Increased Drop Rates | Shared Drops.",
	color 			= Color(255, 20, 20),
	material 		= 18,

	sting 			= "perkyworky/vulture_sting.mp3",
	jingle 			= "perkyworky/vulture_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(0,10,20), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-10,20), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(-4,0,45), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("widowswine", {
	name 			= "Widow's Wine",
	name_skin 		= "Widow's Wine",
	name_holo 		= "Big Web Heart",
	model 			= "models/perks/Tperks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	skin 			= "models/perks/Tperks/widows_wine/mc_mtl_p7_zm_vending_widows_wine.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 4000,
	upgradeprice 	= 2000, 
	desc 			= "Ensnare Zombies Upon Damage, Melee Or Semtex Explosion. | Spawns Drops That Refill Semtexes.",
	desc2 			= "Increased Radius | +2 Semtexes From Drops",
	color 			= Color(255, 20, 75),
	material 		= 21,

	sting 			= "perkyworky/widowswine_sting.mp3",
	jingle 			= "perkyworky/mus_widows_wine_jingle.mp3",
	
	smokeparticles == {
		[1] = {pos = Vector(5,-1,15), ang = Angle(108,12,-0),spread = 2},
		[2] = {pos = Vector(14,12,80), ang = Angle(0,0,-146),spread = 8},
		[3] = {pos = Vector(14,-12,80), ang = Angle(0,0,146),spread = 8},
	},
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
	name 			= "Death Perception",
	name_skin 		= "Killshot Kola",
	name_holo 		= "Head Hunter Elixir",
	model 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_death_perception/moo_codz_jup_zm_machine_death_perception.mdl",
	skin 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_death_perception/moo_codz_jup_zm_machine_death_perception.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2500,
	upgradeprice 	= 5000,
	desc 			= "+25% Critical Damage | Zombies Outlined Behind Walls | Danger Indicators.",
	desc2 			= "+50% Critical Damage | Boss Damage Increased.",
	color 			= Color(220, 45, 5),
	material 		= 26,
	wfz 			= "models/perk_bottle/c_perk_bottle_danger",

	sting 			= "perkyworky/death_sting.mp3",
	jingle 			= "perkyworky/mus_death_perception_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(0,5,20), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-5,20), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(-2,0,20), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("tortoise", {
	name 			= "Victorious Tortoise",
	name_skin 		= "Iron Skin Shake",
	name_holo 		= "SteelSkin Smoothie",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_victor/models/kate_codz_p7_zm_vending_victor.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2500,
	upgradeprice 	= 1000, 
	mmohud 			= {style = "%", count = "nz.TortCount", delay = "nz.TortDelay", max = 10},
	desc 			= "Halved Damage From Behind & Toward Buildables | Explode On Shield Break / Down.",
	desc2 			= "Shield Provided Every Round.",
	color 			= Color(70, 185, 30),
	material 		= 25,

	sting 			= "nz_moo/perkycolas/stingers/tortoise_stinger.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/tortoise_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(-3,19,80), ang = Angle(0,0,-146),spread = 5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("time", {
	name 			= "Timeslip Tonic",
	name_skin 		= "Timer Tant-Rum",
	name_holo 		= "Timeslip Soda",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_timeslip/moo_codz_p7_zm_vending_timeslip.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 1500,
	upgradeprice 	= 3000, 
	desc 			= "Faster Box Spin, PaP Speed, Trap Reset & Specialist Regeneration",
	desc2 			= "Doubled Powerup Duration.",
	color 			= Color(130, 10, 200),
	material 		= 27,

	sting 			= "nz_moo/perkycolas/stingers/time_sting_alt.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/timeslip_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(0,3,50), ang = Angle(0,0,-123),spread = 2},
		[2] = {pos = Vector(0,-3,50), ang = Angle(0,0,123),spread = 2},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("winters", {
	name 			= "Winter's Wail",
	name_skin 		= "Backshot Brew",
	name_holo 		= "Frost Bitters",
	model = "models/perks/winterswail.mdl",
	skin =  "models/perks/winterswail2.mdl",
	model_classic 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_winters/moo_codz_p7_zm_vending_winters.mdl",
	model_cw 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_winters/moo_codz_p7_zm_vending_winters.mdl",
	model_vg 		= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_winters/moo_codz_p7_zm_vending_winters.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 		 	= 3500,
	upgradeprice 	= 3000,
	mmohud 			= {style = "count", count = "nz.WailCount", delay = "nz.WailDelay", countdown = true},
	desc 			= "Produces A Frosty Blast When Hit Under Max Health.",
	desc2 			= "Frost Blast Is Now An Ice Storm | +1 Charge.",
	color 			= Color(50, 200, 250),
	material 		= 28,

	sting 			= "nz_moo/perkycolas/stingers/winter_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/winter_jingle.mp3",

	smokeparticles = {
		[1] = {pos = Vector(7,-1,57), ang = Angle(168,12,0),spread = 2},
		[2] = {pos = Vector(3,12,80), ang = Angle(0,0,-146),spread = 8},
		[3] = {pos = Vector(3,-12,80), ang = Angle(0,0,146),spread = 8},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("cosmo", {
	name 			= "Cosmonaut Colada",
	name_skin 		= "Cosmonaut Colada",
	name_holo 		= "Sana Smoothie",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_banana_colada/moo_codz_p7_zm_vending_banana_cosmo.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 3000,
	desc 			= "Low Gravity Dive | Weapons Usable On Dive | Better Handling",
	desc2 			= "Astronaut Pop On Dive.",
	color 			= Color(255, 200, 0),
	material 		= 29,

	sting 			= "perkyworky/cosmo_sting.mp3",
	jingle 			= "perkyworky/cosmo_jingle.mp3",

	smokeparticles == {
		[1] = {pos = Vector(0,8,15), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-8,15), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(0,0,35), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
		if ply:GetGravity() ~= 1 then
			ply:SetGravity(1)
		end
	end,
	upgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("banana", {
	name 			= "Banana Colada",
	name_skin 		= "Banana Colada",
	name_holo 		= "Banana Smoothie",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_banana_colada/moo_codz_p7_zm_vending_banana_colada.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 3000,
	upgradeprice 	= 3000, 
	mmohud 			= {style = "count", count = "nz.BananaCount", delay = "nz.BananDelay", countdown = true},
	desc 			= "Slippery Trail On Slide.",
	desc2 			= "Acidic Trail | Unlimited Ammo On Slide.",
	color 			= Color(255, 200, 0),
	material 		= 30,

	sting 			= "nz_moo/perkacolas/banana_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/banana_jingle.mp3",

	smokeparticles == {
		[1] = {pos = Vector(0,8,15), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-8,15), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(0,0,35), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
		ply:SetNW2Int("nz.BananaCount", 7)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc = function(self, ply)
		ply:SetNW2Int("nz.BananaCount", 9)
	end,
	lostupgradefunc = function(self, ply)
		if ply:GetNW2Int("nz.BananaCount", 0) > 7 then
			ply:SetNW2Int("nz.BananaCount", 7)
		end
	end,
})

nzPerks:NewPerk("candolier", {
	name 			= "Reserve Soda",
	name_skin 		= "Reserve Soda",
	name_holo 		= "Candolier Soda",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_reserve/_codz_p7_zm_vending_reserve.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3500,
	upgradeprice 	= 5000,
	mmohud 			= {style = "count", count = "nz.CandolierRefund", max = 100, countup = true, upgradeonly = true},
	desc 			= "+2 Reserve Ammo Mags",
	desc2 			= "Magazine Slowly Refills When Inactive | Damage Occasionally Refunds Ammo.",
	color 			= Color(255, 180, 10),
	material 		= 19,

	sting 			= "nz_moo/perkacolas/ammo_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/ammo_jingle.mp3",

	smokeparticles == {
		[1] = {pos = Vector(0,8,15), ang = Angle(0,0,-123),spread = 1},
		[2] = {pos = Vector(0,-8,15), ang = Angle(0,0,123),spread = 1},
		[3] = {pos = Vector(0,0,35), ang = Angle(130,0,0),spread = 0.5},
	},
	func = function(self, ply, machine)
		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("candolier")
			end
		end
	end,
	lostfunc = function(self, ply)
		local invalid_ammo = {
			["nil"] = true,
			["none"] = true,
			["null"] = true,
			[""] = true
		}

		for k,v in pairs(ply:GetWeapons()) do
			if v:HasNZModifier("candolier") then
				v:RevertNZModifier("candolier")

				if v.IsTFAWeapon then
					local ammo = v:GetStatL("Primary.MaxAmmo") or v.Primary_TFA.MaxAmmo or v.Primary.MaxAmmo

					local clipsize = v:GetStatL("Primary.ClipSize") or v.Primary_TFA.ClipSize
					if !clipsize or clipsize <= 0 then
						clipsize = v:GetStatL("Primary.DefaultClip") or v.Primary_TFA.DefaultClip
						if ammo and ammo > clipsize then
							clipsize = ammo
						end

						if v:Clip1() > clipsize then
							v:SetClip1(clipsize)
						end
					else
						local ammotype = v:GetStatL("Primary.Ammo") or v.Primary_TFA.Ammo
						if (!ammotype or invalid_ammo[ammotype] or game.GetAmmoID(ammotype) < 0) then
							if clipsize and clipsize > 0 and v:Clip1() > clipsize then
								v:SetClip1(clipsize)
							end
						else
							if ply:GetAmmoCount(ammotype) > ammo then
								ply:SetAmmo(ammo, ammotype)
							end
						end
					end
				end
			end
		end
	end,
	upgradefunc = function(self, ply)
	end,
	lostupgradefunc = function(self, ply)
	end,
})

nzPerks:NewPerk("wunderfizz", {
	name 			= "Der Wunderfizz", -- Nothing more is needed, it is specially handled
	specialmachine	= true,

	func = function(self, ply, machine)
		timer.Simple(0, function()
			if not IsValid(ply) then return end
			ply:RemovePerk("wunderfizz")
		end)
	end,
	lostfunc = function(self, ply)
	end,
})

nzPerks:NewPerk("pap", {
	name 			= "Pack-a-Punch",
	name_skin 		= "Pack-a-Punch",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_packapunch/moo_codz_p7_zm_vending_packapunch.mdl",
	model_bo2 		= "models/nzr/2022/machines/pap/vending_pap.mdl",
	model_bocw 		= "models/moo/_codz_ports_props/t10/jup_zm_pap_fxanim/moo_codz_jup_zm_vending_packapunch.mdl",
	model_ww2 		= "models/perks/SHperks/ww2.mdl",
	model_origins 	= "models/moo/_codz_ports_props/t6/zm/p6_zm_tm_packapunch/moo_codz_p6_zm_tm_packapunch.mdl",
	model_origins_red = "models/moo/_codz_ports_props/t6/zm/p6_zm_tm_packapunch_red/moo_codz_p6_zm_tm_packapunch_red.mdl",
	model_waw 		= "models/wavy_ports/waw/packapunch_machine.mdl",
	model_spooky 	= "models/wavy_ports/waw/packapunch_machine_halloween.mdl",

	off_skin 		= 0,
	on_skin 		= 1,
	price 			= 0,
	upgradeprice 	= 0, 
	specialmachine 	= true,
	nobuy 			= true,
	icon 			= Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	icon_skin 		= Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	color 			= Color(20, 235, 255),
	color_spooky 	= Color(255, 106, 0),
	color_redtomb 	= Color(255, 10, 10),

	sting 			= "nz_moo/perkacolas/pap_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/mus_packapunch_jingle.mp3",

	sting_tomb = "nz_moo/perkacolas/tomb_pap/tomb_perk_sting_pap.mp3",
	jingle_tomb = "nz_moo/perkacolas/tomb_pap/tomb_perk_machine_pap.mp3",

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
		timer.Simple(0, function()
			if not IsValid(ply) then return end
			ply:RemovePerk("pap")
		end)
	end,

	lostfunc = function(self, ply)
	end,
})