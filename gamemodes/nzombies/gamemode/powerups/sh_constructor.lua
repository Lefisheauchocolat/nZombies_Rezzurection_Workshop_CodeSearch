-- Main Tables
nzPowerUps = nzPowerUps or AddNZModule("PowerUps")
nzPowerUps.Data = nzPowerUps.Data or {}

-- Tables storing the active powerups and their expiration time
nzPowerUps.ActivePowerUps = nzPowerUps.ActivePowerUps or {}
nzPowerUps.ActivePlayerPowerUps = nzPowerUps.ActivePlayerPowerUps or {}
nzPowerUps.ActiveAntiPowerUps = nzPowerUps.ActiveAntiPowerUps or {}
nzPowerUps.ActivePlayerAntiPowerUps = nzPowerUps.ActivePlayerAntiPowerUps or {}

AccessorFunc(nzPowerUps, "fPowerUpChance", "PowerUpChance", FORCE_NUMBER)

-- Variables
nzPowerUps.BoxMoved = false
function nzPowerUps:GetBoxMoved()
	return nzPowerUps.BoxMoved
end

nzPowerUps.HasPaped = false
function nzPowerUps:GetHasPaped()
	return nzPowerUps.HasPaped
end

nzPowerUps.Styles = nzPowerUps.Styles or {}

nzPowerUps.PowerUpGlowTypes = {
	[1] = "global",
	[2] = "local",
	[3] = "mini",
	[4] = "anti",
	[5] = "tombstone"
}

nzPowerUps.EntityClasses = {
	["drop_powerup"] = true,
	["drop_vulture"] = true,
	["drop_tombstone"] = true,
	["drop_widows"] = true,
}

function nzPowerUps:NewStyle(id, data)
	nzPowerUps.Styles[id] = data
end

function nzPowerUps:GetStyle(id)
	return nzPowerUps.Styles[id]
end

function nzPowerUps:GetStyleList()
	local tbl = {}

	for k, v in pairs(nzPowerUps.Styles) do
		tbl[k] = v.name
	end

	return tbl
end

nzPowerUps:NewStyle("style_classic", {
	name = "Classic",
	loop = "nz_powerup_classic_loop",
	intro = "nz_powerup_classic_intro",
	poof = "nz_powerup_classic_poof",
})

nzPowerUps:NewStyle("style_flame", {
	name = "Flame",
	loop = "nz_powerup_flame_loop",
	intro = "nz_powerup_flame_intro",
	poof = "nz_powerup_flame_poof",
})

nzPowerUps:NewStyle("style_elec", {
	name = "Electric",
	loop = "nz_powerup_elec_loop",
	intro = "nz_powerup_elec_intro",
	poof = "nz_powerup_elec_poof",
})

nzPowerUps:NewStyle("style_simple", {
	name = "Simple",
	loop = "nz_powerup_simple_loop",
	intro = "nz_powerup_simple_intro",
	poof = "nz_powerup_simple_poof",
})

nzPowerUps:NewStyle("style_simple_alt", {
	name = "Simple (Alt)",
	loop = "nz_powerup_simple_loop_alt",
	intro = "nz_powerup_simple_intro",
	poof = "nz_powerup_simple_poof",
})

nzPowerUps:NewStyle("style_glowy", {
	name = "Waypoint + Orb",
	loop = "nz_powerup_glowy_loop",
	intro = "nz_powerup_glowy_intro",
	poof = "nz_powerup_glowy_poof",
})

nzPowerUps:NewStyle("style_orb", {
	name = "Orb",
	loop = "nz_powerup_glowy_loop_alt",
	intro = "nz_powerup_glowy_intro_alt",
	poof = "nz_powerup_glowy_poof_alt",
})

nzPowerUps:NewStyle("style_waypoint", {
	name = "Waypoint",
	loop = "nz_powerup_glowy_loop_alt_alt",
	intro = "nz_powerup_glowy_intro_alt_alt",
	poof = "nz_powerup_glowy_poof_alt_alt",
})

nzPowerUps:NewStyle("style_sparkler", {
	name = "Sparkler",
	loop = "nz_powerup_sparkler_loop",
	intro = "nz_powerup_sparkler_intro",
	poof = "nz_powerup_sparkler_poof",
})

function nzPowerUps:PowerupChanceIncrement()
	return (nzPowerUps.PowerupChanceOverride or GetConVar("nz_difficulty_powerup_chance"):GetFloat()) / 10
end

function nzPowerUps:ResetPowerUpChance()
	-- pseudo random so we start a bit lower than the actual chance
	self:SetPowerUpChance(nzPowerUps:PowerupChanceIncrement())
end

function nzPowerUps:IncreasePowerUpChance()
	-- function:
	-- 	f(0) = initialchance, f(n) = f(n-1) + initialchance

	-- % = chance of powerup spawning per zombie.
	-- for default 2% this would be 0.2% on reset
	-- after one kill it would be 0.04%
	-- after 10 kills 2.2%
	-- ...
	-- after 50 kills 10.2%
	-- ..
	-- after 100 kills 20.2%
	-- ...
	-- after 499 kills a powerup drop is guaranteed
	-- for default 2%: f(n) = n+1/5
	self:SetPowerUpChance(self:GetPowerUpChance() + nzPowerUps:PowerupChanceIncrement())
end
