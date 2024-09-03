local nzombies = engine.ActiveGamemode() == "nzombies"

util.PrecacheModel("vm_aae_bottle.mdl")
util.PrecacheModel("vm_bo4_bottle.mdl")
util.PrecacheModel("vm_t7c_bottle.mdl")
util.PrecacheModel("vm_perk_nana.mdl")
util.PrecacheModel("vm_iw8_candy")
util.PrecacheModel("vm_s4_goblet.mdl")
util.PrecacheModel("vm_t5_perk_bottle.mdl")
util.PrecacheModel("vm_t6_perk_bottle.mdl")
util.PrecacheModel("wpn_t7_zmb_bubblegum_view_lod4.mdl")
util.PrecacheModel("vm_t9_can.mdl")
util.PrecacheModel("wm_aae_bottle.mdl")
util.PrecacheModel("wm_bo4_bottle.mdl")
util.PrecacheModel("wm_perk_nana.mdl")
util.PrecacheModel("wm_iw8_candy")
util.PrecacheModel("wm_s4_goblet.mdl")
util.PrecacheModel("wm_t5_perk_bottle.mdl")
util.PrecacheModel("wm_t6_perk_bottle.mdl")
util.PrecacheModel("wm_t9_can.mdl")
util.PrecacheModel("w_wpn_t7_zmb_bubblegum_view_lod4.mdl")

--CW Can

sound.Add({
	name = 			"Perks_CW.Grab",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/can_grab.mp3"
})

sound.Add({
	name = 			"Perks_CW.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/can_open.mp3"
})

sound.Add({
	name = 			"Perks_CW.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/can_drink.mp3"
})

sound.Add({
	name = 			"Perks_CW.Toss",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/can_land.mp3"
})

-- Roblox Can

sound.Add({
	name = 			"Perks_RB.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/funny/can_open.mp3"
})

sound.Add({
	name = 			"Perks_RB.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/cold_war/funny/can_drink.mp3"
})

--Gum

sound.Add({
	name = 			"Perks_BO3.Flick",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/gobble/bgb_snap.mp3"
})

sound.Add({
	name = 			"Perks_BO3.Catch",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/gobble/bgb_catch.mp3"
})

sound.Add({
	name = 			"Perks_BO3.Chew",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/gobble/bgb_chew.mp3"
})

--Goblet

sound.Add({
	name = 			"Perks_VG.Lift",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/vangriddy/lift.mp3"
})

sound.Add({
	name = 			"Perks_VG.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/vangriddy/drink.mp3"
})

sound.Add({
	name = 			"Perks_VG.Toss",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/vangriddy/toss.mp3"
})

-- Bo1 Perk Bottle

sound.Add({
	name = 			"Perks_BO1.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/classic/open.wav"
})

sound.Add({
	name = 			"Perks_BO1.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/classic/swallow.wav"
})

sound.Add({
	name = 			"Perks_BO1.Burp",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/classic/belch.wav"
})

sound.Add({
	name = 			"Perks_BO1.Break",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/classic/break.wav"
})

-- BO4

sound.Add({
	name = 			"Perks_BO4.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/t8/open_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/t8/drink_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.Break",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/t8/smash_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.BreakAAE",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/t8/smashaae_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.Flick",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/t8/flick_t8.mp3"
})

-- NANA

sound.Add({
	name = 			"Perks_NANA.Chomp",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/nana/banana_eat.mp3"
})

sound.Add({
	name = 			"Perks_NANA.Toss",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/nana/banana_toss.mp3"
})

sound.Add({
	name = 			"Perks_NANA.Raise",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/nana/banana_pickup.mp3"
})

-- CANDY

sound.Add({
	name = 			"Perks_CANDY.Eat",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/perkcandy/candyeat.mp3"
})

sound.Add({
	name = 			"Perks_CANDY.Chew",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 		{ "perkcandy/candychew.mp3", "perkcandy/candychew2.mp3", "perkcandy/candychew3.mp3", "perkcandy/candychew4.mp3", "perkcandy/candychew5.mp3", "perkcandy/candychew6.mp3", "perkcandy/candychew7.mp3", "perkcandy/candychew8.mp3", "perkcandy/candychew9.mp3" }
})

sound.Add({
	name = 			"Perks_CANDY.Pour",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/perkcandy/candypour.mp3"
})

sound.Add({
	name = 			"Perks_CANDY.Raise",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/perkcandy/candyraise.mp3"
})

-- Rainy Death (FUCK THIS BOTTLE)

-- BO4

sound.Add({
	name = 			"Perks_RD.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/rd/open.mp3"
})

sound.Add({
	name = 			"Perks_RD.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/rd/drink.mp3"
})

sound.Add({
	name = 			"Perks_RD.Break",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/rd/break.mp3"
})

sound.Add({
	name = 			"Perks_RD.Raise",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/rd/raise.mp3"
})


if nzombies then
    --local wep = ply:GetActiveWeapon()
    hook.Add("InitPostEntity", "latte_perks", function()
	nzSpecialWeapons:AddDisplay("tfa_perk_can", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_perk_candy", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_perk_gum", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_perk_goblet", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo1_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo2_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo4_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.6 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo3_nana", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.6 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_aae_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.6 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_rd_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.8 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_t7c_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.8 or 3.2)) < CurTime()
        end)
    end)
end