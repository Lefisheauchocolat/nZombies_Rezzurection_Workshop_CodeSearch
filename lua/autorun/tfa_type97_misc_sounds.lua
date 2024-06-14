sound.Add(
{
    name = "TFA_WW2_TYPE97.Bounce",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = {	"weapons/tfa_ww2_type97/mk2_bounce_01.wav",
				"weapons/mk2/mk2_bounce_02.wav",
				"weapons/mk2/mk2_bounce_03.wav",
				"weapons/mk2/mk2_bounce_04.wav",
			}
})

sound.Add(
{
    name = "TFA_WW2_TYPE97.Explode",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/tfa_ww2_type97/mk2_detonate_01.wav"
})

sound.Add(
{
    name = "lasersword.swing5",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = {	"weapons/lasersword/swing2.wav",
				"weapons/lasersword/swing3.wav",
				"weapons/lasersword/swing4.wav",
				"weapons/lasersword/swing5.wav",
			}
})


sound.Add(
{
    name = "lasersword.swing1",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/lasersword/swing1.wav"
})

sound.Add(
{
    name = "lasersword.ignite",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/lasersword/draw.mp3"
})
sound.Add(
{
    name = "lasersword.putaway",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = "weapons/lasersword/putaway.wav"
})
sound.Add(

{
    name = "lasersword.hit",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 75,
    sound = {	"weapons/lasersword/hit1.mp3",
				"weapons/lasersword/hit2.mp3",
				"weapons/lasersword/hit3.wav",
			}
})

--MMOD GRENADE

TFA.AddWeaponSound("MMOD_Weapon_Grenade.Draw", "weapons/mmod/draw_grenade.wav")
TFA.AddWeaponSound("MMOD_Weapon_Grenade.Pull", "weapons/mmod/pin_pull.wav")
TFA.AddWeaponSound("MMOD_Weapon_Grenade.Ready", "weapons/mmod/grenade_ready.wav")
TFA.AddWeaponSound("MMOD_Weapon_Grenade.Throw", "weapons/mmod/grenade_throw.wav")

--ONE INCH PUNCH

TFA.AddWeaponSound("TFA.BO2.1INCH.HIT", {"weapons/bo2/1inch/hit_1.mp3", "weapons/bo2/1inch/hit_2.mp3"})
TFA.AddWeaponSound("TFA.BO2.1INCH.DRAW", "weapons/bo2/1inch/first_draw1.mp3")
TFA.AddWeaponSound("TFA.BO2.1INCH.SWING", "weapons/bo2/1inch/swing.mp3")

--NZ GALVAKNUCKLES

TFA.AddWeaponSound("TFA.BO2.GALVIES.SWING", {"weapons/tfa_bo2/tazer/fly_taser_swing_00.wav","weapons/tfa_bo2/tazer/fly_taser_swing_01.wav","weapons/tfa_bo2/tazer/fly_taser_swing_02.wav"})
TFA.AddWeaponSound("TFA.BO2.GALVIES.HIT", {"weapons/tfa_bo2/tazer/fly_taser_imp_00.wav","weapons/tfa_bo2/tazer/fly_taser_imp_01.wav","weapons/tfa_bo2/tazer/fly_taser_imp_02.wav","weapons/tfa_bo2/tazer/fly_taser_imp_03.wav"})
TFA.AddWeaponSound("TFA.BO2.GALVIES.HITWORLD", {"weapons/tfa_bo2/tazer/fly_taser_gen_00.wav","weapons/tfa_bo2/tazer/fly_taser_gen_01.wav"})
TFA.AddWeaponSound("TFA.BO2.GALVIES.DRAW", "weapons/tfa_bo2/tazer/taser_zap_purchase.wav")

--BO1 CLAYMORE

TFA.AddWeaponSound("TFA_BO1.CLAYMORE.PLANT", "weapons/bo1/claymore/claymore_plant_00.wav")
TFA.AddWeaponSound("TFA_BO1.CLAYMORE.PULLOUT", {"weapons/bo1/claymore/weapon_00.wav", "weapons/bo1/claymore/weapon_01.wav", "weapons/bo1/claymore/weapon_02.wav", "weapons/bo1/claymore/weapon_03.wav", "weapons/bo1/claymore/weapon_04.wav", "weapons/bo1/claymore/weapon_05.wav"})
TFA.AddWeaponSound("TFA_BO1.CLAYMORE.DETONATE", "weapons/bo1/claymore/alert_00.wav")

--WAW BOWIE KNIFE

TFA.AddWeaponSound("TFA_WAW.BOWIE.START", "weapons/waw/bowie/bowie_start.wav")
TFA.AddWeaponSound("TFA_WAW.BOWIE.TURN", "weapons/waw/bowie/bowie_turn.wav")
TFA.AddWeaponSound("TFA_WAW.BOWIE.TOSS", "weapons/waw/bowie/bowie_toss.wav")
TFA.AddWeaponSound("TFA_WAW.BOWIE.CATCH", "weapons/waw/bowie/bowie_catch.wav")
TFA.AddWeaponSound("TFA_WAW.BOWIE.STAB", {"weapons/waw/bowie/bowie_stab/bowie_stab_00.wav", "weapons/waw/bowie/bowie_stab/bowie_stab_01.wav", "weapons/waw/bowie/bowie_stab/bowie_stab_02.wav"} )
TFA.AddWeaponSound("TFA_WAW.BOWIE.SWING", {"weapons/waw/bowie/bowie_swing/bowie_swing_00.wav", "weapons/waw/bowie/bowie_swing/bowie_swing_01.wav", "weapons/waw/bowie/bowie_swing/bowie_swing_02.wav"} )

--BO1 SEMTEX

TFA.AddSound ("TFA.BO1.SEMTEX.AlertUpgrade", CHAN_STATIC, 1, SNDLVL_NORM, {100,115}, "weapons/bo1/semtex/bolt_forward_sweet.wav",")")

--BO2 EMP GRENADE

TFA.AddSound("TFA_BO2.EMP.EXPLODE", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/bo2/emp/emp_grenade_explode.mp3",")")
TFA.AddSound("TFA_BO2.EMP.EXPLODEFLUX", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/bo2/emp/wpn_emp_explode.mp3",")")
