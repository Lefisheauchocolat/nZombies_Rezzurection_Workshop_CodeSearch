local nzombies = engine.ActiveGamemode() == "nzombies"

--CW Can

sound.Add({
	name = 			"Perks_CW.Grab",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"cold_war/can_grab.mp3"
})

sound.Add({
	name = 			"Perks_CW.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"cold_war/can_open.mp3"
})

sound.Add({
	name = 			"Perks_CW.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"cold_war/can_drink.mp3"
})

sound.Add({
	name = 			"Perks_CW.Toss",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"cold_war/can_land.mp3"
})

--Gum

sound.Add({
	name = 			"Perks_BO3.Flick",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"gobble/bgb_snap.mp3"
})

sound.Add({
	name = 			"Perks_BO3.Catch",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"gobble/bgb_catch.mp3"
})

sound.Add({
	name = 			"Perks_BO3.Chew",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"gobble/bgb_chew.mp3"
})

-- Bo1 Perk Bottle

sound.Add({
	name = 			"Perks_BO1.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"classic/open.wav"
})

sound.Add({
	name = 			"Perks_BO1.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"classic/swallow.wav"
})

sound.Add({
	name = 			"Perks_BO1.Burp",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"classic/belch.wav"
})

sound.Add({
	name = 			"Perks_BO1.Break",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"classic/break.wav"
})

-- BO4

sound.Add({
	name = 			"Perks_BO4.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"t8/open_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.Drink",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"t8/drink_t8.mp3"
})

sound.Add({
	name = 			"Perks_BO4.Break",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"t8/smash_t8.mp3"
})

-- NANA

sound.Add({
	name = 			"Perks_NANA.Chomp",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"nana/banana_eat.mp3"
})

sound.Add({
	name = 			"Perks_NANA.Toss",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"nana/banana_toss.mp3"
})

sound.Add({
	name = 			"Perks_NANA.Raise",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"nana/banana_pickup.mp3"
})


if nzombies then
    --local wep = ply:GetActiveWeapon()
    hook.Add("InitPostEntity", "latte_perks", function()
	nzSpecialWeapons:AddDisplay("tfa_perk_can", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_perk_gum", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo1_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo2_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo4_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.65 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_aae_bottle", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.6 or 3.2)) < CurTime()
        end)
	nzSpecialWeapons:AddDisplay("tfa_bo3_nana", false, function(wep)
            return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 1.6 or 3.2)) < CurTime()
        end)
    end)
end