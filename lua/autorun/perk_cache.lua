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

-- BO3 COMPLEX/T7COMPLEX

sound.Add({
	name = 			"Perks_T7C.Break",
	channel = 		CHAN_AUTO,
	volume = 		1.5,
	sound = 			"perks/complex/break.mp3"
})

sound.Add({
	name = 			"Perks_T7C.Open",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/complex/open.mp3"
})

sound.Add({
	name = 			"Perks_T7C.Fizz",
	channel = 		CHAN_AUTO,
	volume = 		0.5,
	sound = 			"perks/complex/fizz.mp3"
})

sound.Add({
	name = 			"Perks_T7C.Cap",
	channel = 		CHAN_AUTO,
	volume = 		0.4,
	sound = 			"perks/complex/cap.mp3"
})

--Now i KNOW its not a PERK but why create an entire new autorun for it?
-- Armor Plate

sound.Add({
	name = 			"Latte_Armor.Open",
	channel = 		CHAN_AUTO,
	volume = 		1,
	pitch = 		{90,110},
	sound = 			{ "plate/open.wav", "plate/open2.wav", "plate/open3.wav", "plate/open4.wav", "plate/open5.wav" }   
})

sound.Add({
	name = 			"Latte_Armor.Insert",
	channel = 		CHAN_AUTO,
	volume = 		1,
	pitch = 		{90,110},
	sound = 			{ "plate/insert.wav", "plate/insert2.wav", "plate/insert3.wav", "plate/insert4.wav", "plate/insert5.wav", "plate/insert6.wav"  }   
})

-- Bo1 Radio

sound.Add({
	name = 			"Latte_Radio.On",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"bo1_radio/fly_radio_on.wav"
})

sound.Add({
	name = 			"Latte_Radio.Off",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"bo1_radio/fly_radio_off.wav"
})

-- BO1 RCXD Controller

sound.Add({
	name = 			"Latte_RCXD.Extend",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"bo1_rcxd/controller/fly_antenna_extend.wav"
})

-- MW2 Laptop Control Unit Thing

sound.Add({
	name = 			"Latte_CU.Open",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"mw2_laptop/pullout.wav"
})

sound.Add({
	name = 			"Latte_CU.Close",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"mw2_laptop/putaway.wav"
})

if nzombies then
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
	-- nzSpecialWeapons:AddDisplay("bo6_armor_tier2", false, function(wep)
    --         return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 0.6 or 1)) < CurTime()
    --     end)
	-- nzSpecialWeapons:AddDisplay("bo6_armor_tier3", false, function(wep)
    --         return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 0.6 or 1)) < CurTime()
    --     end)
    -- nzSpecialWeapons:AddDisplay("bo6_armorplate_use", false, function(wep)
    --         return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 0.6 or 1)) < CurTime()
    --     end)
    end)


    hook.Add("PostGamemodeLoaded", "latte_perk_materials", function()
        nzPerks:RegisterBottle("tfa_perk_can", "ColdWarPerkCan", {
            [0] = "models/nz/perks/cold_war_can/can_",
            [1] = "models/nz/perks/cold_war_can/logo_",
            [2] = "models/nz/perks/cold_war_can/liquid_"
        }, "models/nzr/2024/perks/bocw/world/wm_t9_can.mdl", Vector(0,0,50), Angle(0,180,0))

        nzPerks:RegisterBottle("tfa_perk_candy", "IWCandy", {
            [0] = "models/nz/perks/candy/logo_"
        }, "models/nzr/2024/perks/infinite_warfare/world/wm_iw8_candy.mdl", Vector(0,0,50), Angle(0,0,0))
 
        nzPerks:RegisterBottle("tfa_perk_gum", "Bo3Gobblegum", {
            [0] = "models/nz/perks/gobblegum/t7_gum_",
            [1] = "models/nz/perks/gobblegum/logo_"
        }, "models/nzr/2024/perks/bo3/gum/world/wm_bo3_gum.mdl", Vector(0,0,55), Angle(0,180,0))

        nzPerks:RegisterBottle("tfa_perk_goblet", "VGGoblet", {
            [1] = "models/nz/perks/goblet/logo_",
            [2] = "models/nz/perks/goblet/blood_"
        }, "models/nzr/2024/perks/vangriddy/world/wm_s4_goblet.mdl", Vector(300,-100,55), Angle(0,180,0))
    
        nzPerks:RegisterBottle("tfa_bo1_bottle", "Bo1Bottle", {
            [0] = "models/nz/perks/bo1/logo_"
        }, "models/nzr/2024/perks/bo1/world/wm_t5_perk_bottle.mdl", Vector(0,0,50), Angle(0,90,0))

        nzPerks:RegisterBottle("tfa_bo3_nana", "Bo3Banana", {
            [0] = "models/nz/perks/banana/logo_"
        }, "models/nzr/2024/perks/bo3/banana/world/wm_perk_nana.mdl", Vector(0,0,50), Angle(0,90,0))

        nzPerks:RegisterBottle("tfa_bo2_bottle", "Bo2Bottle", {
            [0] = "models/nz/perks/bo2/logo_",
            [1] = "models/nz/perks/bo2/bottle_"
        }, "models/nzr/2024/perks/bo2/world/wm_t6_perk_bottle.mdl", Vector(0,0,50), Angle(0,90,0))

        nzPerks:RegisterBottle("tfa_bo4_bottle", "Bo4Bottle", {
        	[0] = "models/nz/perks/bo3/metal_",
    		[1] = "models/nz/perks/bo3/bottle_",
    		[2] = "models/nz/perks/bo3/logo_"
		}, "models/nzr/2022/perks/w_perk_bottle.mdl", Vector(0,0,50), Angle(0,140,0))

        nzPerks:RegisterBottle("tfa_aae_bottle", "AAEBottle", {
        	[0] = "models/nz/perks/bo3/metal_",
    		[1] = "models/nz/perks/bo3/bottle_",
    		[2] = "models/nz/perks/bo3/logo_"
		}, "models/nzr/2022/perks/w_perk_bottle.mdl", Vector(0,0,50), Angle(0,140,0))

        nzPerks:RegisterBottle("tfa_rd_bottle", "RDBottle", {
        	[0] = "models/nz/perks/bo3/metal_",
    		[1] = "models/nz/perks/bo3/bottle_",
    		[2] = "models/nz/perks/bo3/logo_"
		}, "models/nzr/2022/perks/w_perk_bottle.mdl", Vector(0,0,50), Angle(0,140,0))

        nzPerks:RegisterBottle("tfa_t7c_bottle", "T7ComplexBottle", {
        	[0] = "models/nz/perks/bo3/metal_",
    		[1] = "models/nz/perks/bo3/bottle_",
    		[2] = "models/nz/perks/bo3/logo_"
		}, "models/nzr/2022/perks/w_perk_bottle.mdl", Vector(0,0,50), Angle(0,140,0))

    end)
end