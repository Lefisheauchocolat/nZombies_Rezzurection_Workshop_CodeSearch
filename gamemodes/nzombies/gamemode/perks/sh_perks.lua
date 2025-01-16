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
	local tbl = {
		["Original"] 			= "OG",
		["Black Ops 3"] 		= "OG",
		["Infinite Warfare"] 	= "IW",
		["Cold Snore"] 			= "CW",
		["Vangriddy"] 			= "VG",
		["Classic"] 			= "CLASSIC",
		["Classic Four"] 		= "CLASSIC",
		["Rezzurrection"] 		= "RZ",
	}
	if id == nil then
		return "OG"
	else
		return tbl[id]
	end
end

function nzPerks:GetPAPType(id)
	local tbl = {
		["Classic"] 				= "waw",
		["Halloween"] 				= "spooky",
		["Christmas"] 				= "xmas",
		["Original"] 				= "og",
		["Tranzit"] 				= "bo2",
		["Origins"] 				= "nz_tomb",
		["Origins Red"] 			= "nz_tomb_red",
		["World War II"] 			= "ww2",
		["Black Ops Cold War"] 		= "bocw",
	}
	
	if id == nil then
		return "og"
	else
		return tbl[id]
	end
end

nzPerks:NewPerk("dtap", {
	name 			= "Double Tap",
	name_skin 		= "Bang Bangs",
	name_vg 		= "Rhythmic Hellfire",
	model 			= "models/nzr/2022/machines/dtap/vending_dtap.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/dtap1/moo_codz_s4_zm_demonic_fountain_dtap1.mdl",
	skin 			= "models/iwperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 3000, 
	desc 			= "Increase rate of fire of all weapons.",
	desc2 			= "Greatly increase rate of fire of all weapons.",
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
	name_vg 		= "Twin-Fanged Fury",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_doubletap2/moo_codz_p7_zm_vending_doubletap2.mdl", -- i shitted
	model_classic 	= "models/nzr/2022/machines/dtap2/vending_dtap2.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/dtap2/moo_codz_s4_zm_demonic_fountain_dtap2.mdl",
	skin 			= "models/iwperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	model_rz 		= "models/nzr/2022/machines/dtap2/vending_dtap2.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 5000, 
	desc 			= "Increase rate of fire of all weapons. Firearms fire twice the bullets.",
	desc2 			= "Non-Firearms fire twice the projectiles.",
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
	name_vg 		= "Kronii Cola",
	name_vg 		= "Demonic Frenzy",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_sleight/moo_codz_p7_zm_vending_sleight.mdl",
	model_classic 	= "models/nzr/2022/machines/sleight/vending_sleight.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_speed_cola/moo_codz_jup_zm_machine_speed_cola.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/speed/moo_codz_s4_zm_demonic_fountain_speed.mdl",
	model_rz 		= "models/nzr/2022/machines/sleight/vending_sleight.mdl",
	skin 			= "models/iwperks/quickies/mc_mtl_p7_zm_vending_speedcola.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 5000,
	mmohud 			= {style = "count", count = "nz.SpeedCount", delay = "nz.SpeedDelay", upgradeonly = true},
	desc 			= "Increased reload speed and barricade repair speed.",
	desc2 			= "Holstered guns reload automatically. Reload shotguns and drink perks faster.",
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
	name_vg 		= "Fiendish Fortitude",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_jugg/moo_codz_p7_zm_vending_jugg.mdl",
	model_classic 	= "models/nzr/2022/machines/jugg/vending_jugg.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_juggernog/moo_codz_jup_zm_machine_juggernog.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/jugg/moo_codz_s4_zm_demonic_fountain_jugg.mdl",
	model_rz 		= "models/nzr/2022/machines/jugg/vending_jugg.mdl",
	skin 			= "models/iwperks/tuff/mc_mtl_p7_zm_vending_jugg.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2500,
	upgradeprice 	= 3000, 
	desc 			= "Gain Extra Health.",
	desc2 			= "Start each round with armor. Refill armor by landing headshots.",
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
		ply:SetMaxHealth((nzMapping.Settings.hp) + (nzMapping.Settings.juggbonus or 100))
		ply:SetHealth((nzMapping.Settings.hp) + (nzMapping.Settings.juggbonus or 100))
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
	name_vg 		= "Weird Woodworker",
	model 			= "models/perks/Cperks/amish/amish_off.mdl",
	model_off 		= "models/perks/Cperks/amish/amish_off.mdl",
	skin 			=  "models/perks/Cperks/amish/amish_off.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/amish/moo_codz_s4_zm_demonic_fountain_amish.mdl",
	off_skin 		= 0,
	on_skin 		= 1,
	price 			= 1500,
	upgradeprice 	= 3000, 
	desc 			= "Bonus points for repairing barricades. Repairing barricades can kill zombies.",
	desc2 			= "Repair barricades automatically when near them. Increased chance to kill zombies.",
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
	name_vg 		= "Venomous Vigor",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_revive/moo_codz_p7_zm_vending_revive.mdl",
	model_classic 	= "models/nzr/2022/machines/revive/vending_revive.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_quick_revive/moo_codz_jup_zm_machine_quick_revive.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/revive/moo_codz_s4_zm_demonic_fountain_revive.mdl",
	model_rz 		= "models/nzr/2022/machines/revive/vending_revive.mdl",
	skin 			= "models/moo/_codz_ports_props/iw7/zmb/perks/moo_codz_iw7_zmb_upnatoms.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 1500,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "count", count = "nz.SoloReviveCount", countdown = true, solo = true},
	desc 			= "Revive yourself in solo. Revive others faster in CO-OP. Faster health faster.",
	desc2 			= "Become invincibile on successful revive. Revive on the move.",
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
	name_skin 		= "Bang Bangs (Big Damage)",
	name_vg 		= "Horny Hellraiser",
	model 			= "models/nzr/2022/machines/vigor/vending_vigor.mdl",
	model_classic 	= "models/wavy_ports/waw/vigor_rush.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/vigor/moo_codz_s4_zm_demonic_fountain_vigor.mdl",
	skin 			= "models/iwperks/bang/mc_mtl_p7_zm_vending_doubletap2.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 6500, 
	desc 			= "Double bullet damage.",
	desc2 			= "Further increase bullet damage. Bullets give bonus points.",
	color 			= Color(128, 128, 64),
	material 		= 17,

	sting 			= "perkyworky/stingers/vigorush_sting.mp3",
	jingle 			= "perkyworky/vigor_jingle.mp3",
	old_sting	 	= "nz_moo/perkacolas/vigor_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/vigor_sting.mp3",
	
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
	name_vg 		= "Balrog Blast",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_stopping_power/moo_codz_p7_zm_vending_stopping_power.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/napalm/moo_codz_s4_zm_demonic_fountain_napalm.mdl",
	model_rz		= "models/perks/Cperks/napalm/napalm_rotated.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3000,
	upgradeprice 	= 4000, 
	mmohud 			= {style = "count", count = "nz.BurnCount", delay = "nz.BurnDelay"},
	desc 			= "Become immune to fire. Release a blaze when damaged. Increased fire damage.",
	desc2 			= "Incendiary rounds. Increased fire damage and reduced blaze cooldown.",
	color 			= Color(222, 69, 2),
	material 		= 5,

	sting 			= "nz_moo/perkycolas/stingers/fire_sting.mp3",
	jingle 			= "perkyworky/fire_sting.mp3",
	old_sting 		= "nz_moo/perkacolas/fire_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/fire_sting.mp3",
	
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
	name_skin 		= "Mask Moscatto",
	name_vg 		= "Nefarious Neurotoxin",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_mask/kate_codz_p7_zm_vending_mask.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/mask/moo_codz_s4_zm_demonic_fountain_mask.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 1500,
	upgradeprice 	= 2500, 
	desc 			= "Become immune to most hazards and nova gas.Grenades become noisome.",
	desc2 			= "Become immune to stun effects.",
	color 			= Color(92, 165, 30),
	material 		= 8,

	sting 			= "perkyworky/mask_sting.mp3",
	jingle 			= "perkyworky/mask_jingle.mp3",
	old_sting 		= "nz_moo/perkacolas/mask_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/mask_sting.mp3",
	
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
	name_vg 		= "Aethereal Haste",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_marathon/moo_codz_p7_zm_vending_marathon.mdl",
	model_classic 	= "models/nzr/2022/machines/marathon/vending_marathon.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_staminup/moo_codz_jup_zm_machine_staminup.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/stam/moo_codz_s4_zm_demonic_fountain_stam.mdl",
	model_rz		= "models/nzr/2022/machines/marathon/vending_marathon.mdl",
	skin 			= "models/iwperks/stripes/mc_mtl_p7_zm_vending_marathon.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 4000, 
	desc 			= "Move faster and sprint for longer.",
	desc2 			= "Unlimited Stamina.",
	color 			= Color(255, 200, 50),
	material 		= 16,

	sting 			= "perkyworky/staminup_sting.mp3",
	jingle 			= "perkyworky/mus_stamin_jingle.mp3",
	
	smokeparticles = {
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
	name_vg 		= "Aetheric Roulette",
	model 			= "models/perks/Cperks/random/random.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/random/moo_codz_s4_zm_demonic_fountain_random.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model_off 		= "models/perks/Cperks/random/random.mdl",
	price 			= 5000,
	upgradeprice 	= 7000, 
	desc 			= "Random Weapon on Empty Reload.",
	desc2 			= "Obtained weapons are upgraded.",
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
	name_vg 		= "Malevolent Worldcutter",
	skin 			= "models/iwperks/taffy/sake.mdl",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_slash/kate_codz_p7_zm_vending_slash.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/slashers/moo_codz_s4_zm_demonic_fountain_slashers.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 5000,
	upgradeprice 	= 4000, 
	mmohud 			= {style = "%", delay = "nz.SakeDelay", hide = true, time = true, max = 7, upgradeonly = true},
	desc 			= "Knife becomes instakill on non-boss enemies.",
	desc2 			= "Lightning Chain on knife.",
	color 			= Color(185, 214, 0),
	material 		= 14,

	sting 			= "nz_moo/perkycolas/stingers/slasher_sting.ogg",
	jingle 			= "nz_moo/perkycolas/jingles/sake_jingle.ogg",
	old_sting	 	= "nz_moo/perkacolas/sake_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/sake_sting.mp3",
	
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
	name_vg 		= "Diabolic Destroyer",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_fighters_fizz/moo_codz_p7_zm_vending_fighters_fizz.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/danger/moo_codz_s4_zm_demonic_fountain_danger.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2500,
	upgradeprice 	= 3000, 
	desc 			= "Double explosive damage.",
	desc2 			= "Triple explosive damage, blow yourself up when downed.",
	color 			= Color(232, 116, 116),
	material 		= 2,

	sting 			= "nz_moo/perkycolas/stingers/dangercosta_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/danger_jingle.mp3",
	old_sting 		= "nz_moo/perkacolas/danger_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/danger_sting.mp3",
	
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
	name_vg 		= "Blightflare Bloom",
	skin 			= "models/iwperks/trailblazer/everclear.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_zombshell/moo_codz_p7_zm_vending_zombshell.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/everclear/moo_codz_s4_zm_demonic_fountain_everclear.mdl",
	price 			= 4500,
	upgradeprice 	= 5000, 
	desc 			= "Zombies can create slowing pits and napalm pits.",
	desc2 			= "Increased chance to create a pit.",
	color 			= Color(221, 66, 57),
	material 		= 4,
	mmohud 			= {style = "count", count = "nz.ZombShellCount", delay = "nz.ZombShellDelay"},

	sting 			= "nz_moo/perkycolas/stingers/everclear_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/everclear_jingle.mp3",
	old_sting 		= "nz_moo/perkacolas/everclear_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/everclear_sting.mp3",
	
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
	name_vg 		= "Forbidden Flavor",
	model 			= "models/nzr/2022/machines/jizz/vending_jizz.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/gin/moo_codz_s4_zm_demonic_fountain_gin.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	model_off 		= "models/perks/Cperks/gin/gin.mdl",
	price 			= 3000,
	upgradeprice 	= 3000, 
	desc 			= "Obtain more perk slots.",
	desc2 			= "Everyone gains 1 perk slot.",
	color 			= Color(40, 240, 220),
	material 		= 6,

	sting 			= "nz_moo/perkycolas/stingers/juicergin_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/gin_jingle.mp3",
	old_sting		= "nz_moo/perkacolas/gin_sting.mp3",
	old_jingle		= "nz_moo/perkacolas/gin_sting.mp3",

	smokeparticles == {
		[1] = {pos = Vector(-6,18,26), ang = Angle(0,0,-163),spread = 2},
		[2] = {pos = Vector(-6,-18,26), ang = Angle(0,0,163),spread = 2},
		[3] = {pos = Vector(-14,8,80), ang = Angle(0,0,-146),spread = 7},
		[4] = {pos = Vector(-14,-8,80), ang = Angle(0,0,146),spread = 7},
		[5] = {pos = Vector(8,-8,67), ang = Angle(168,12,0),spread = 2},
	},
	func = function(self, ply, machine)
		ply:SetMaxPerks(ply:GetMaxPerks() + 2)
	end,
	lostfunc = function(self, ply)
		ply:SetMaxPerks(ply:GetMaxPerks() - 2)
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
	name_vg 		= "Oblivion’s Embrace",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_flopper/moo_codz_p7_zm_vending_flopper.mdl",
	model_classic 	= "models/nzr/2022/machines/nuke/vending_nuke.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_phd_flopper/moo_codz_jup_zm_machine_phd_flopper.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/phd/moo_codz_s4_zm_demonic_fountain_phd.mdl",
	model_rz 		= "models/nzr/2022/machines/nuke/vending_nuke.mdl",
	skin 			= "models/iwperks/bomb/phdflopper.mdl", 
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "toggle", delay = "nz.PHDDelay"},
	desc 			= "Become immune to explosions. Explode when flopping or sliding.",
	desc2 			= "Gain the ability to double jump. Fastfall with crouch.",
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
	name_vg 		= "Diabolical Damage",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_deadshot/moo_codz_p7_zm_vending_deadshot.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_deadshot/moo_codz_jup_zm_machine_deadshot.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/deadshot/moo_codz_s4_zm_demonic_fountain_deadshot.mdl",
	model_classic 	= "models/nzr/2022/machines/ads/vending_ads.mdl",
	model_rz 		= "models/nzr/2022/machines/ads/vending_ads.mdl",
	skin 			= "models/iwperks/deadeye/mc_mtl_p7_zm_vending_deadshot.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 2000,
	upgradeprice 	= 1000, 
	mmohud 			= {style = "chance", count = "nz.DeadshotChance", max = 25},
	desc 			= "Improved weapon handling. Headshots can explode, damaging nearby zombies.",
	desc2 			= "Headshot Explosion improved. Can cause zombies to flee.",
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
	name_vg 		= "Unholy Arsenal",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_three_gun/moo_codz_p7_zm_vending_three_gun.mdl",
	model_classic 	= "models/nzr/2022/machines/three/vending_three.mdl", 
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/mule/moo_codz_s4_zm_demonic_fountain_mule.mdl",
	skin 			= "models/iwperks/munchies/mc_mtl_p7_zm_vending_mulekick.mdl",
	model_rz 		= "models/nzr/2022/machines/three/vending_three.mdl", 
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 4000,
	upgradeprice 	= 8000, 
	desc 			= "3rd Weapon Slot (Tied To Perk, Can Be Reaquired).",
	desc2 			= "Hold an extra tactical and refill them every round.",
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
	name_vg 		= "Ghoulish Graverobber",
	model 			= "models/nzr/2022/machines/tombstone/vending_tombstone.mdl",
	model_cw 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_tombstone/moo_codz_jup_zm_machine_tombstone.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/tomb/moo_codz_s4_zm_demonic_fountain_tomb.mdl",
	model_rz 		= "models/moo/_codz_ports_props/t10/jup_zm_machine_tombstone/moo_codz_jup_zm_machine_tombstone.mdl",
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
	name_vg 		= "Mischief Multiplier",
	model 			= "models/nzr/2022/machines/chugabud/vending_chugabud.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/who/moo_codz_s4_zm_demonic_fountain_who.mdl",
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
	name_vg 		= "Hexbound Havocker",
	model 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_elemental_pop/moo_codz_jup_zm_machine_elemental_pop.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/epop/moo_codz_s4_zm_demonic_fountain_epop.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 5000,
	upgradeprice 	= 6000,
	mmohud 			= {style = "chance", count = "nz.EPopChance", delay = "nz.EPopDelay", max = 15},
	desc 			= "Bullets Have A Chance To Activate Random AATs.",
	desc2 			= "Decreases cooldown and adds Wonderweapon effects.",
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
	name_vg 		= "Voltaic Tempest",
	model 			= "models/kate/_codz_ports_props/t7/zm/p7_zm_vending_cherry/p7_zm_vending_electric_cherry.mdl",
	model_classic 	= "models/nzr/2022/machines/cherry/vending_cherry.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/cherry/moo_codz_s4_zm_demonic_fountain_cherry.mdl",
	skin 			= "models/iwperks/bolts/cherry.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "%", count = "nz.CherryCount", upgrade = "nz.CherryWaffe", max = 10, border = true},
	desc 			= "Electric Burst That Damages & Stuns Upon Reload.",
	desc2 			= "Increases burst damage. Fire a Waffe shot when performing an empty reload.",
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
	name_vg 		= "Carrion Collector",
	model 			= "models/nzr/2022/machines/vulture/vending_vulture.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/vulture/moo_codz_s4_zm_demonic_fountain_vulture.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 3000,
	upgradeprice 	= 4500, 
	mmohud 			= {style = "count", count = "nz.VultureCount", max = 4, countup = true},
	desc 			= "Enemies drop loot containing ammo, points, and GAS",
	desc2 			= "Increased drop rate. Share your loot.",
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
	name_vg 		= "Webweaver’s Wrath",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_widows_wine/moo_codz_p7_zm_vending_widows_wine.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/widows/moo_codz_s4_zm_demonic_fountain_widows.mdl",
	skin 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_widows_wine/moo_codz_p7_zm_vending_widows_wine.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 4000,
	upgradeprice 	= 2000, 
	desc 			= "Snares zombie when damaged and replaces grenades with Semtex.",
	desc2 			= "Increases radius and charge count",
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
		local nade = ply:Give("nz_bo3_semtex")
		nade.NoSpawnAmmo = true
	end,
	lostfunc = function(self, ply)
		ply:StripWeapon("nz_bo3_semtex")
		timer.Simple(0, function()
			local nade = ply:Give(nzMapping.Settings.grenade or 'tfa_bo1_m67')
			nade.NoSpawnAmmo = true
		end)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("death", {
	name 			= "Death Perception",
	name_skin 		= "Killshot Kola",
	name_vg 		= "Omniscient Dread",
	model 			= "models/moo/_codz_ports_props/t10/jup_zm_machine_death_perception/moo_codz_jup_zm_machine_death_perception.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/death/moo_codz_s4_zm_demonic_fountain_death.mdl",
	skin 			= "models/codmw2023/other/perkmachine_deathperception.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2500,
	upgradeprice 	= 5000,
	desc 			= "Deal increased headshot damage. Sixth sense for zombies behind you and through walls.",
	desc2 			= "Further increase headshot damage, deal increased damage to bosses.",
	color 			= Color(220, 45, 5),
	material 		= 26,

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
	name_vg 		= "Infernal Rampart",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_victor/models/kate_codz_p7_zm_vending_victor.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/victor/moo_codz_s4_zm_demonic_fountain_victor.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2500,
	upgradeprice 	= 1000, 
	mmohud 			= {style = "%", count = "nz.TortCount", delay = "nz.TortDelay", max = 10},
	desc 			= "Take less damage from backshots and explode when your shield gets broken.",
	desc2 			= "Shield Provided Every Round.",
	color 			= Color(70, 185, 30),
	material 		= 25,

	sting 			= "nz_moo/perkycolas/stingers/tortoise_stinger.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/tortoise_jingle.mp3",
	old_sting 		= "nz_moo/perkacolas/tortoise_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/tortoise_sting.mp3",

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
	name_vg 		= "Timestream Tantrum",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_timeslip/moo_codz_p7_zm_vending_timeslip.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/time/moo_codz_s4_zm_demonic_fountain_time.mdl",
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
	old_sting 		= "nz_moo/perkacolas/time_sting.mp3",
	old_jingle		= "nz_moo/perkacolas/time_sting.mp3",

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
	name_vg 		= "Frenzied Frostblast",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_winters/moo_codz_p7_zm_vending_winters.mdl", -- Mine is better
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/winter/moo_codz_s4_zm_demonic_fountain_winter.mdl",
	model_rz 		= "models/perks/winterswail_edit.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 		 	= 3500,
	upgradeprice 	= 3000,
	mmohud 			= {style = "count", count = "nz.WailCount", delay = "nz.WailDelay", countdown = true},
	desc 			= "Blast zombies with ice when damaged under max health",
	desc2 			= "Gain additional charge, Ice Blast upgraded into an Ice Storm.",
	color 			= Color(50, 200, 250),
	material 		= 28,

	sting 			= "nz_moo/perkycolas/stingers/winter_sting.mp3",
	jingle 			= "nz_moo/perkycolas/jingles/winter_jingle.mp3",
	old_sting 		= "nz_moo/perkacolas/winters_sting.mp3",
	old_jingle 		= "nz_moo/perkacolas/winters_sting.mp3",

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
	name_vg 		= "Voidwalker Vitae",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_banana_colada/moo_codz_p7_zm_vending_banana_cosmo.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/cosmo/moo_codz_s4_zm_demonic_fountain_cosmo.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 2000,
	upgradeprice 	= 3000,
	desc 			= "Use weapons effectively while diving and stay airborne longer.",
	desc2 			= "Astronaut Pop On Dive.",
	color 			= Color(255, 200, 0),
	color_vg 		= Color(35, 35, 255),
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
	name_vg 		= "Slaughterous Slide",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_banana_colada/moo_codz_p7_zm_vending_banana_colada.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/banana/moo_codz_s4_zm_demonic_fountain_banana.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 3000,
	upgradeprice 	= 3000, 
	mmohud 			= {style = "count", count = "nz.BananaCount", delay = "nz.BananDelay", countdown = true},
	desc 			= "Slippery Trail On Slide.",
	desc2 			= "Slime trail deals damage and you have unlimited ammo while sliding.",
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
	name_vg 		= "Avarice Ammunition",
	model 			= "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_reserve/_codz_p7_zm_vending_reserve.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/reserve/moo_codz_s4_zm_demonic_fountain_reserve.mdl",
	off_skin 		= 0,
	on_skin  		= 1,
	price 			= 3500,
	upgradeprice 	= 5000,
	mmohud 			= {style = "count", count = "nz.CandolierRefund", max = 100, countup = true, upgradeonly = true},
	desc 			= "2 Additional Reserve Magazines",
	desc2 			= "Magazines slowly refill when not in use. Dealing damage can refund ammunition.",
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
		local invalid_ammo = {
			["nil"] = true,
			["none"] = true,
			["null"] = true,
			[""] = true
		}

		for k, v in pairs(ply:GetWeapons()) do
			if not v:IsSpecial() then
				v:ApplyNZModifier("candolier")

				if v.IsTFAWeapon then
					local ammo = v:GetStatL("Primary.MaxAmmo") or v.Primary_TFA.MaxAmmo or v.Primary.MaxAmmo

					local clipsize = v:GetStatL("Primary.ClipSize") or v.Primary_TFA.ClipSize
					if !clipsize or clipsize <= 0 then
						clipsize = v:GetStatL("Primary.DefaultClip") or v.Primary_TFA.DefaultClip
						if v:Clip1() < clipsize then
							v:TakePrimaryAmmo((clipsize/2) * -1)
						end
					else
						local ammotype = v:GetStatL("Primary.Ammo") or v.Primary_TFA.Ammo
						if (!ammotype or invalid_ammo[ammotype] or game.GetAmmoID(ammotype) < 0) then
							if clipsize and clipsize > 0 and v:Clip1() < clipsize then
								v:TakePrimaryAmmo((clipsize/2) * -1)
							end
						else
							if ply:GetAmmoCount(ammotype) < ammo then
								ply:GiveAmmo(clipsize*2, ammotype, true)
							end
						end
					end
				end
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

nzPerks:NewPerk("melee", {
	name 			= "Melee Macchiato",
	name_skin 		= "Melee Macchiato",
	name_vg 		= "Bloodlust Bulldozer",
	model 			= "models/moo/_codz_ports_props/t10/t10_zm_machine_melee/moo_codz_t10_zm_machine_melee.mdl",
	model_vg 		= "models/moo/_codz_ports_props/s4/zod/melee/moo_codz_s4_zm_demonic_fountain_melee.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 3000,
	upgradeprice 	= 4000,
	desc 			= "Melee attacks are stronger and launch enemies",
	desc2 			= "Melee attacks gain thunderwall and heal the user. Slain enemies can drop loot.",
	mmohud 			= {style = "%", delay = "nz.MMDelay", hide = true, time = true, max = 20, upgradeonly = true},
	color 			= Color(255,115,75),
	material 		= 31,

	sting 			= "nz_moo/perkacolas/melee_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/mus_melee_jingle.mp3",

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
	model_xmas 		= "models/wavy_ports/waw/packapunch_machine_xmas.mdl",

	off_skin 		= 0,
	on_skin 		= 1,
	price 			= 5000,
	upgradeprice 	= 2500, 
	specialmachine 	= true,
	nobuy 			= true,
	icon 			= Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	icon_skin 		= Material("vulture_icons/pap.png", "smooth unlitgeneric"),
	color 			= Color(20, 235, 255),
	color_spooky 	= Color(255, 106, 0),
	color_xmas 		= Color(255, 43, 57),
	color_redtomb 	= Color(255, 10, 10),

	sting 			= "nz_moo/perkacolas/pap_sting.mp3",
	jingle 			= "nz_moo/perkacolas/jingles/mus_packapunch_jingle.mp3",

	sting_tomb = "nz_moo/perkacolas/tomb_pap/tomb_perk_sting_pap.mp3",
	jingle_tomb = "nz_moo/perkacolas/tomb_pap/tomb_perk_machine_pap.mp3",

	condition = function(self, ply, machine)
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then
			return false
		end

		local n_aats = (nzMapping.Settings.aats or 2)
		if wep:HasNZModifier("pap") and n_aats == 0 and not wep.OnRePaP then
			return false
		elseif (!wep:HasNZModifier("pap") or wep:CanRerollPaP()) and !machine:GetBeingUsed() then
			local reroll = false
			if wep:HasNZModifier("pap") and wep:CanRerollPaP() then
				reroll = true
			end

			local cost = machine:GetPrice()
			if reroll then
			    cost = machine:GetUpgradePrice()
			end
			if nzPowerUps:IsPowerupActive("bonfiresale") then
			    cost = math.Round(cost / 5)
			end
			if nzRound:InState(ROUND_CREATE) and ply:IsInCreative() then
			    cost = 0
			end

			return ply:CanAfford(cost)
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

/*nzPerks:NewPerk("wall", {
	name 			= "Poopoo Peepee Potion",
	name_skin 		= "Wall Power Whiskey Sour",
	name_vg 		= "Aloe Ale",
	model_off 		= "models/nzr/2022/misc/weaponlocker.mdl",
	model 			= "models/nzr/2022/misc/weaponlocker.mdl",
	model_vg 		= "models/codvanguard/other/PerkFountainWall.mdl",
	off_skin = 0,
	on_skin  = 1,
	price 			= 10000,
	upgradeprice 	= 999999, 
	desc 			= "Every new weapon obtained is Pack-A-Punched.",
	desc2 			= "Nothing.",
	color 			= Color(230, 104, 167),
	material 		= 19,

	sting 			= "perkyworky/pap_sting.mp3",
	jingle 			= "perkyworky/mus_packapunch_jingle.mp3",
	func = function(self, ply, machine)
	end,
	lostfunc = function(self, ply)
	end,
	upgradefunc  = function(self, ply)
	end,
})

nzPerks:NewPerk("gum", {
	name 			= "Gobbledumb(April Fools)",
	name_skin 		= "Gobbledumb(April Fools)",
	name_vg 		= "Masochism Generator",
	model 			= "models/perks/Cperks/bestthingever/gobble.mdl",
	skin 			= "models/perks/Cperks/bestthingever/gobble.mdl",
	off_skin = 1,
	on_skin = 0,
	price 			= 500,
	upgradeprice 	= 5000, 
	specialmachine = true,
	material 		= 69,

	icon 			= Material("perk_icons/chron/gum.png", "smooth unlitgeneric"),
	color 			= Color(255, 100, 100),
	sting 			= "nz_moo/effects/trollbox.mp3",
	jingle 			= "nz_moo/effects/trollbox.mp3",
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

			for k, v in pairs(player.GetAll()) do
				if (v:IsPlaying() or v:IsInCreative()) then
					v:SetMaxPerks(1)
				end
			end
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
})*/
