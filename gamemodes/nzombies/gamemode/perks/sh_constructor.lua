-- Main Tables
nzPerks = nzPerks or AddNZModule("Perks")
nzPerks.Data = nzPerks.Data or {}

-- Variables
nzPerks.Players = nzPerks.Players or {}
nzPerks.PlayerUpgrades = nzPerks.PlayerUpgrades or {}

nzPerks.VultureArray = nzPerks.VultureArray or {}
nzPerks.VultureClass = {
	["nz_ammo_matic"] = true,
	["wall_buys"] = true,
	["random_box"] = true,
	["wunderfizz_machine"] = true,
	["perk_machine"] = true,
}

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