--[[Example
nzAATs:RegisterAAT("unique_id", {
	name = "Effect Name", //name that displays next to AAT icon on some HUDs
	chance = 0.10, //0.10 would be 10% proc chance on every shot
	cooldown = 15, //cooldown in seconds
	color = Color(255, 80, 0), //color of AAT text on some HUDs
	ent = "entity_class", //***REQUIRES*** a NetworkVar Entity 'Attacker' and 'Inflictor', Entity is parented to zombie on proc
	flash = Material("path/to/icon.png", "smooth unlitgeneric"),
	icon = Material("path/to/icon.png", "smooth unlitgeneric"),
})]]--

nzAATs:RegisterAAT("blastfurnace", {
	name = "Blast Furnace",
	chance = 0.15,
	cooldown = 15,
	color = Color(255, 80, 0),
	flash = Material("vgui/aat/t7_hud_cp_aat_blastfurnace.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_blastfurance.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_1",
	desc = "Proc to ignite and kill any zombies within a small area."
})

nzAATs:RegisterAAT("deadwire", {
	name = "Dead Wire",
	chance = 0.20,
	cooldown = 10,
	color = Color(200, 20, 20),
	flash = Material("vgui/aat/t7_hud_cp_aat_deadwire.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_deadwire.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_2",
	desc = "Proc to chain a shock that stuns and kills multiple zombies."
})

nzAATs:RegisterAAT("fireworks", {
	name = "Fire Works",
	chance = 0.10,
	cooldown = 20,
	color = Color(255, 120, 255),
	flash = Material("vgui/aat/t7_hud_cp_aat_fireworks.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_fireworks.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_3",
	desc = "Proc to kill multiple zombies in a very wacky and colorful way."
})

nzAATs:RegisterAAT("thunderwall", {
	name = "Thunderwall",
	chance = 0.25,
	cooldown = 15,
	color = Color(80, 160, 200),
	flash = Material("vgui/aat/t7_hud_cp_aat_thunderwall.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_thunderwall.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_4",
	desc = "Proc to launch a thunderwall that kill any zombies in its wake."
})

nzAATs:RegisterAAT("cryofreeze", {
	name = "Cryofreeze",
	chance = 0.15,
	cooldown = 15,
	color = Color(160, 240, 255),
	flash = Material("vgui/aat/t7_hud_cp_aat_cryofreeze.png", "smooth unlitgeneric"),
	icon = Material("vgui/hud_wpn_aat_cryofreeze_alt.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_5",
	desc = "Proc to freeze any zombies within a small radius."
})

nzAATs:RegisterAAT("turned", {
	name = "Turned",
	chance = 0.15,
	cooldown = 20,
	color = Color(100, 220, 60),
	flash = Material("vgui/aat/t7_hud_cp_aat_turned.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_turned.png", "smooth unlitgeneric"),
	ent = "elemental_pop_effect_6",
	desc = "Proc to turn a zombie against its fellow infected friends."
})

nzAATs:RegisterAAT("blackhole", {
	name = "Void Caster",
	chance = 0.10,
	cooldown = 25,
	color = Color(180, 60, 255),
	flash = Material("vgui/aat/t7_hud_cp_aat_bhole.png", "smooth unlitgeneric"),
	icon = Material("vgui/aat/t7_hud_wp_aat_bhole.png", "smooth unlitgeneric"),
	ent = "voidcaster_effect_new", --no more gersch device......
	desc = "Proc to create a black hole stunning and killing any zombies within its radius."
})

nzAATs:RegisterAAT("radiation", {
	name = "Radioactive Decay",
	chance = 0.15,
	cooldown = 30,
	color = Color(120, 255, 0),
	flash = Material("vgui/hud_cp_aat_radiation.png", "smooth unlitgeneric"),
	icon = Material("vgui/hud_wpn_aat_radiation.png", "smooth unlitgeneric"),
	ent = "radiation_aat_effect",
	desc = "Proc to create a pit of toxic goop that slows and kills any zombies within it."
})
