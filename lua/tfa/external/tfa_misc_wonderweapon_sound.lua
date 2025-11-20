-- Paralyzer --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_PARALYZER.FireIn", "weapons/tfa_bo3/paralyzer/fire.wav", true, ")")
TFA.AddFireSound("TFA_BO3_PARALYZER.FireLoop", "weapons/tfa_bo3/paralyzer/loop.wav", false, ")")
TFA.AddFireSound("TFA_BO3_PARALYZER.FireOut", "weapons/tfa_bo3/paralyzer/stop.wav", false, ")")

TFA.AddWeaponSound("TFA_BO3_PARALYZER.Pullout", "weapons/tfa_bo3/paralyzer/pullout_696.wav")
TFA.AddWeaponSound("TFA_BO3_PARALYZER.Putaway", "weapons/tfa_bo3/paralyzer/putaway_885.wav")
TFA.AddWeaponSound("TFA_BO3_PARALYZER.Deploy", "weapons/tfa_bo3/paralyzer/fly_minigun_up.wav")

TFA.AddSound("TFA_BO3_PARALYZER.HitWall", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/paralyzer/invis_barrier_hit.wav",")")

TFA.AddSound("TFA_BO3_PARALYZER.Spin", CHAN_STATIC, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/paralyzer/spin.wav",")")
TFA.AddSound("TFA_BO3_PARALYZER.TubeUp", CHAN_STATIC, 0.15, SNDLVL_IDLE, 100, "weapons/tfa_bo3/paralyzer/tube_up.wav",")")
TFA.AddSound("TFA_BO3_PARALYZER.TubeDown", CHAN_STATIC, 0.15, SNDLVL_IDLE, 100, "weapons/tfa_bo3/paralyzer/tube_down.wav",")")
TFA.AddSound("TFA_BO3_PARALYZER.Loop", CHAN_ITEM, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/paralyzer/loop_idle.wav",")")
TFA.AddSound("TFA_BO3_PARALYZER.Tick", CHAN_STATIC, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/paralyzer/tick_v2.wav",")")

TFA.AddSound("TFA_BO3_PARALYZER.Explode", CHAN_STATIC, 1, SNDLVL_NORM, {90,110}, "weapons/tfa_bo3/paralyzer/phase_in.wav",")")
TFA.AddSound("TFA_BO3_PARALYZER.Slow", CHAN_AUTO, 0.2, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/paralyzer/rune_glow.wav",")")

-- V-R11 --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_VR11.Shoot", "weapons/tfa_bo3/vr11/hg_shot.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_VR11.Spinner", "weapons/tfa_bo3/vr11/hg_spinner.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.ArmOpen", "weapons/tfa_bo3/vr11/hg_arm_open.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.ArmClose", "weapons/tfa_bo3/vr11/hg_arm_close.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.Open", "weapons/tfa_bo3/vr11/hg_battery_open.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.Close", "weapons/tfa_bo3/vr11/hg_battery_close.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.Eject", "weapons/tfa_bo3/vr11/hg_battery_eject.wav")
TFA.AddWeaponSound("TFA_BO3_VR11.Insert", "weapons/tfa_bo3/vr11/hg_battery_insert.wav")

TFA.AddSound("TFA_BO3_VR11.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/vr11/impact_00.wav", "weapons/tfa_bo3/vr11/impact_01.wav"},")")

TFA.AddSound("TFA_BO3_VR11.Effect.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/vr11/effects/explode/explode_00.wav", "weapons/tfa_bo3/vr11/effects/explode/explode_01.wav", "weapons/tfa_bo3/vr11/effects/explode/explode_02.wav"},")")
TFA.AddSound("TFA_BO3_VR11.Effect.OneShot", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, {"weapons/tfa_bo3/vr11/effects/oneshot/oneshot_00.wav", "weapons/tfa_bo3/vr11/effects/oneshot/oneshot_01.wav", "weapons/tfa_bo3/vr11/effects/oneshot/oneshot_02.wav"},")")
TFA.AddSound("TFA_BO3_VR11.Effect.Timer", CHAN_WEAPON, 0.5, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/vr11/effects/timer.wav",")")

TFA.AddSound("TFA_BO3_VR11.NBot.Scream", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_00.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_01.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_02.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_03.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_04.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_05.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_06.wav", "weapons/tfa_bo3/vr11/nextbot/vox_fire_scream_07.wav"},")")
TFA.AddSound("TFA_BO3_VR11.NBot.Echo", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/vr11/nextbot/screams_04.wav",")")

-- Vaporizer-11 --------------------------------------------------------------------------------------------------------
TFA.AddSound("TFA_BO1_VAPOR.Shoot", CHAN_WEAPON, 0.65, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo1/vapor/weap_vapor_fire2.wav",")")

TFA.AddSound("TFA_BO1_VAPOR.Vaporize", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo1/vapor/target_disappear_00.wav", "weapons/tfa_bo1/vapor/target_disappear_01.wav"},")")

-- Sliquifier --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_SLIPGUN.Shoot", {"weapons/tfa_bo3/sliquifier/slipgun_shot_00.wav", "weapons/tfa_bo3/sliquifier/slipgun_shot_01.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_SLIPGUN.Last", {"weapons/tfa_bo3/sliquifier/slipgun_lastshot.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_SLIPGUN.Raise", "weapons/tfa_bo3/sliquifier/raise_913.wav")
TFA.AddWeaponSound("TFA_BO3_SLIPGUN.Open", "weapons/tfa_bo3/sliquifier/reload_514.wav")
TFA.AddWeaponSound("TFA_BO3_SLIPGUN.Insert", "weapons/tfa_bo3/sliquifier/reload_563.wav")
TFA.AddWeaponSound("TFA_BO3_SLIPGUN.Chamber", "weapons/tfa_bo3/sliquifier/reload_598.wav")

TFA.AddSound("TFA_BO3_SLIPGUN.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo3/sliquifier/explo_00.wav", "weapons/tfa_bo3/sliquifier/explo_01.wav", "weapons/tfa_bo3/sliquifier/explo_02.wav", "weapons/tfa_bo3/sliquifier/explo_03.wav"},")")

TFA.AddSound("TFA_BO3_SLIPGUN.Splash", CHAN_VOICE2, 0.5, SNDLVL_IDLE, {95,105}, {"weapons/tfa_bo3/sliquifier/slipgun_splash_00.wav", "weapons/tfa_bo3/sliquifier/slipgun_splash_01.wav"},")")
TFA.AddSound("TFA_BO3_SLIPGUN.Impact", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/sliquifier/zmb_slip_imp_00.wav", "weapons/tfa_bo3/sliquifier/zmb_slip_imp_01.wav"},")")

-- Sun God
TFA.AddFireSound("TFA_BO3_SUNGOD.Shoot", {"weapons/tfa_bo3/sungod/wpn_sungod_fire01.wav", "weapons/tfa_bo3/sungod/wpn_sungod_fire02.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO3_SUNGOD.Foley", "weapons/tfa_bo3/sungod/fly_mosin_1st_handle_down.wav")

TFA.AddSound("TFA_BO3_SUNGOD.Charge.Down", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/sungod/barrier_down.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Charge.Fail", CHAN_WEAPON, 0.5, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo3/sungod/wpn_charge_sniper_fire_charge_down.wav",")")

TFA.AddSound("TFA_BO3_SUNGOD.Charge.Start", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/sungod/evt_extra_charge.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Charge.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/sungod/charged_lp.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Charge.Sweet", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/sungod/evt_casimir_charge.wav",")")

TFA.AddSound("TFA_BO3_SUNGOD.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, {60,90}, "weapons/tfa_bo3/sungod/prj_energypistol_loop.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Sweet", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/sungod/exp_emp_rocket_mid.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Explode", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/sungod/napalm_explosion.wav",")")

TFA.AddSound("TFA_BO3_SUNGOD.Ult.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/sungod/grenade_loop.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Ult.Sweet", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/sungod/charged_lp.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Ult.Flux", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/sungod/flux.wav",")")
TFA.AddSound("TFA_BO3_SUNGOD.Ult.End", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/sungod/upgraded_imp.wav",")")

-- NX1
TFA.AddFireSound("TFA.GHOSTS.NX1.Shoot", "weapons/tfa_ghosts/nx1/weap_cortex_fire_plr_lyr1.wav", true, ")")
TFA.AddFireSound("TFA.GHOSTS.NX1.Shoot.Sml", "weapons/tfa_ghosts/nx1/weap_cortex_fire_plr_lyr2.wav", true, ")")
TFA.AddFireSound("TFA.GHOSTS.NX1.Shoot.Big", "weapons/tfa_ghosts/nx1/weap_cortex_firebig_plr_lyr2.wav", true, ")")

TFA.AddFireSound("TFA.GHOSTS.NX1.Lfe.Sml", "weapons/tfa_ghosts/nx1/weap_cortex_fire_plr_lfe.wav", false, ")")
TFA.AddFireSound("TFA.GHOSTS.NX1.Lfe.Big", "weapons/tfa_ghosts/nx1/weap_cortex_firebig_plr_lfe.wav", false, ")")

TFA.AddWeaponSound("TFA.GHOSTS.NX1.Raise", "weapons/tfa_ghosts/nx1/weap_cortex_first_raise.wav")
TFA.AddWeaponSound("TFA.GHOSTS.NX1.Empty", "weapons/tfa_ghosts/nx1/weap_cortex_no_ammo.wav")
TFA.AddWeaponSound("TFA.GHOSTS.NX1.Spin", "weapons/tfa_ghosts/nx1/weap_cortex_fire_plr_spin.wav")

TFA.AddSound("TFA.GHOSTS.NX1.Charge", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "weapons/tfa_ghosts/nx1/weap_cortex_charge_plr.wav",")")
TFA.AddSound("TFA.GHOSTS.NX1.ChargeDown", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "weapons/tfa_ghosts/nx1/weap_cortex_charge_down_plr.wav",")")

TFA.AddSound("TFA.GHOSTS.NX1.Explode", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {90,110}, "weapons/tfa_ghosts/nx1/weap_cortex_imp_big.wav",")")
TFA.AddSound("TFA.GHOSTS.NX1.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_ghosts/nx1/weap_cortex_proj_big_lp.wav",")")

-- Icelazer
TFA.AddFireSound("TFA_BO1_ICELAZER.Charge", {"weapons/tfa_bo1/icelazer/icelazer_charge_0.wav", "weapons/tfa_bo1/icelazer/icelazer_charge_1.wav"}, false, ")")
TFA.AddFireSound("TFA_BO1_ICELAZER.Shoot", {"weapons/tfa_bo1/icelazer/icelazer_exp_0.wav", "weapons/tfa_bo1/icelazer/icelazer_exp_1.wav", "weapons/tfa_bo1/icelazer/icelazer_exp_2.wav"}, true, ")")

TFA.AddFireSound("TFA_BO1_ICELAZER.ChargePaP", "weapons/tfa_bo1/icelazer/special_beam_cannon_charge.wav", false, ")")
TFA.AddFireSound("TFA_BO1_ICELAZER.ShootPaP", "weapons/tfa_bo1/icelazer/special_beam_cannon_fire.wav", true, ")")

TFA.AddWeaponSound("TFA_BO1_ICELAZER.MagOut", "weapons/tfa_bo1/icelazer/icelazer_magout.wav")
TFA.AddWeaponSound("TFA_BO1_ICELAZER.MagIn", "weapons/tfa_bo1/icelazer/icelazer_magin.wav")
TFA.AddWeaponSound("TFA_BO1_ICELAZER.Putaway", "weapons/tfa_bo1/icelazer/icelazer_putaway.wav")
TFA.AddWeaponSound("TFA_BO1_ICELAZER.Raise", "weapons/tfa_bo1/icelazer/icelazer_raise.wav")
TFA.AddWeaponSound("TFA_BO1_ICELAZER.Ready", "weapons/tfa_bo1/icelazer/icelazer_ready.wav")
TFA.AddWeaponSound("TFA_BO1_ICELAZER.Cancel", {"weapons/tfa_bo1/icelazer/icelazer_firecancel_0.wav", "weapons/tfa_bo1/icelazer/icelazer_firecancel_1.wav"})

TFA.AddSound("TFA_BO1_ICELAZER.Loop", CHAN_AUTO, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo1/icelazer/icelazer_idle_loop.wav",")")

-- Venom-X
TFA.AddFireSound("TFA_IW7_VENOMX.Shoot", "weapons/tfa_iw7/venomx/wpn_iw7_venomx_shot.wav", true, ")")

TFA.AddWeaponSound("TFA_IW7_VENOMX.Raise", "weapons/tfa_iw7/venomx/wpn_iw7_venomx_first_raise.wav")
TFA.AddWeaponSound("TFA_IW7_VENOMX.Start", "weapons/tfa_iw7/venomx/wpn_iw7_venomx_start.wav")
TFA.AddWeaponSound("TFA_IW7_VENOMX.MagIn", "weapons/tfa_iw7/venomx/wpn_iw7_venomx_biolum_in.wav")
TFA.AddWeaponSound("TFA_IW7_VENOMX.End", "weapons/tfa_iw7/venomx/wpn_iw7_venomx_end.wav")

TFA.AddSound("TFA_IW7_VENOMX.Explode", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_iw7/venomx/wpn_iw7_venomx_explosion.wav",")")
TFA.AddSound("TFA_IW7_VENOMX.Bounce.Earth", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_iw7/venomx/grenade_bounce_earth07.wav",")")
TFA.AddSound("TFA_IW7_VENOMX.Bounce.Stone", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_iw7/venomx/grenade_bounce_stone01.wav", "weapons/tfa_iw7/venomx/grenade_bounce_stone02.wav", "weapons/tfa_iw7/venomx/grenade_bounce_stone03.wav", "weapons/tfa_iw7/venomx/grenade_bounce_stone04.wav", "weapons/tfa_iw7/venomx/grenade_bounce_stone05.wav"},")")
TFA.AddSound("TFA_IW7_VENOMX.Bounce.Wood", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_iw7/venomx/grenade_bounce_wood05.wav", "weapons/tfa_iw7/venomx/grenade_bounce_wood06.wav", "weapons/tfa_iw7/venomx/grenade_bounce_wood07.wav"},")")

-- Hells Retriever
TFA.AddFireSound("TFA_BO2_TOMAHAWK.Throw", {"weapons/tfa_bo2/tomahawk/tom_throw_00.wav", "weapons/tfa_bo2/tomahawk/tom_throw_01.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO2_TOMAHAWK.Raise", "weapons/tfa_bo2/tomahawk/zm_escape.all.sabl.887.wav")
TFA.AddWeaponSound("TFA_BO2_TOMAHAWK.Catch", "weapons/tfa_bo2/tomahawk/tom_catch.wav")

TFA.AddSound("TFA_BO2_TOMAHAWK.Charge", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/tomahawk/zm_escape.all.sabl.886.wav",")")
TFA.AddSound("TFA_BO2_TOMAHAWK.ChargeSweet", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/tomahawk/zm_escape.all.sabl.884.wav",")")

TFA.AddSound("TFA_BO2_TOMAHAWK.Cooldown", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/tomahawk/tomahawk_cooldown.wav",")")
TFA.AddSound("TFA_BO2_TOMAHAWK.Incoming", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/tomahawk/tom_incoming.wav",")")
TFA.AddSound("TFA_BO2_TOMAHAWK.Impact", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo2/tomahawk/tom_imp_00.wav", "weapons/tfa_bo2/tomahawk/tom_imp_01.wav", "weapons/tfa_bo2/tomahawk/tom_imp_02.wav", "weapons/tfa_bo2/tomahawk/tom_imp_03.wav"},")")

-- Crossbow --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_CROSSBOW.Shoot", {"weapons/tfa_bo3/crossbow/fire_00.wav", "weapons/tfa_bo3/crossbow/fire_01.wav", "weapons/tfa_bo3/crossbow/fire_02.wav"})

TFA.AddSound("TFA_BO3_CROSSBOW.Alert", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/crossbow/alert.wav",")")

TFA.AddSound("TFA_BO3_CROSSBOW.Impact.Flesh", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo3/crossbow/impacts/flesh_02.wav", "weapons/tfa_bo3/crossbow/flesh_03.wav"},")")
TFA.AddSound("TFA_BO3_CROSSBOW.Impact.Rock", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/crossbow/impacts/rock_00.wav",")")

TFA.AddWeaponSound("TFA_BO3_CROSSBOW.Draw", "weapons/tfa_bo3/crossbow/fly_crossbow_draw.wav")
TFA.AddWeaponSound("TFA_BO3_CROSSBOW.Futz", "weapons/tfa_bo3/crossbow/fly_crossbow_futz.wav")
TFA.AddWeaponSound("TFA_BO3_CROSSBOW.Latch", "weapons/tfa_bo3/crossbow/fly_crossbow_latch.wav")
TFA.AddWeaponSound("TFA_BO3_CROSSBOW.Bolt", "weapons/tfa_bo3/crossbow/fly_crossbow_lay_bolt.wav")

-- Minigun --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_M134.Loop", "weapons/tfa_bo3/deathmachine/wpn_minigun_shot_loop_plr.wav", false, ")")
TFA.AddFireSound("TFA_BO3_M134.Stop", "weapons/tfa_bo3/deathmachine/wpn_minigun_shot_stop_plr.wav", false, ")")

TFA.AddSound("TFA_BO3_M134.SpinStart", CHAN_STATIC, 0.3, SNDLVL_NORM, 100, "weapons/tfa_bo3/deathmachine/wpn_minigun_start_plr.wav",")")
TFA.AddSound("TFA_BO3_M134.SpinLoop", CHAN_ITEM, 0.25, SNDLVL_NORM, 100, "weapons/tfa_bo3/deathmachine/wpn_minigun_loop_nopitch_plr.wav",")")
TFA.AddSound("TFA_BO3_M134.SpinStop", CHAN_ITEM, 0.3, SNDLVL_NORM, 100, "weapons/tfa_bo3/deathmachine/wpn_minigun_stop_plr.wav",")")

TFA.AddWeaponSound("TFA_BO3_M134.Raise", "weapons/tfa_bo3/deathmachine/fly_minigun_up.wav")

-- Icelazer
TFA.AddFireSound("TFA_BO2_JETGUN.Start", "weapons/tfa_bo2/jetgun/jetgun_on.wav", true, ")")
TFA.AddFireSound("TFA_BO2_JETGUN.Loop", "weapons/tfa_bo2/jetgun/jetgun_loop.wav", false, "<")
TFA.AddFireSound("TFA_BO2_JETGUN.Stop", "weapons/tfa_bo2/jetgun/jetgun_off.wav", false, ")")

TFA.AddWeaponSound("TFA_BO2_JETGUN.Raise", "weapons/tfa_bo2/jetgun/fly_minigun_up.wav")
TFA.AddWeaponSound("TFA_BO2_JETGUN.Explode", "weapons/tfa_bo2/jetgun/jet_gun_explo_new.wav")

TFA.AddSound("TFA_BO2_JETGUN.Rattle.Start", CHAN_ITEM, 0.7, SNDLVL_NORM, 100, "weapons/tfa_bo2/jetgun/jetgun_rattle_start.wav",")")
TFA.AddSound("TFA_BO2_JETGUN.Rattle.Loop", CHAN_ITEM, 0.7, SNDLVL_NORM, 100, "weapons/tfa_bo2/jetgun/jetgun_rattle_loop.wav",")")
TFA.AddSound("TFA_BO2_JETGUN.Rattle.Stop", CHAN_ITEM, 0.6, SNDLVL_NORM, 100, "weapons/tfa_bo2/jetgun/jetgun_rattle_stop.wav",")")

TFA.AddSound("TFA_BO2_JETGUN.Suck", CHAN_STATIC, 0.5, SNDLVL_IDLE, {97,103}, {"weapons/tfa_bo2/jetgun/suck_00.wav", "weapons/tfa_bo2/jetgun/suck_01.wav"},")")
TFA.AddSound("TFA_BO2_JETGUN.Grind", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo2/jetgun/grind_00.wav", "weapons/tfa_bo2/jetgun/grind_01.wav"},")")
TFA.AddSound("TFA_BO2_JETGUN.Gib", CHAN_VOICE2, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo2/jetgun/fly_gib_00.wav", "weapons/tfa_bo2/jetgun/fly_gib_01.wav", "weapons/tfa_bo2/jetgun/fly_gib_02.wav", "weapons/tfa_bo2/jetgun/fly_gib_03.wav"},")")

-- Magnetron

TFA.AddSound("TFA_AW_MWAVE.Start", CHAN_STATIC, 0.4, SNDLVL_GUNFIRE, {95,103}, "weapons/tfa_aw/magnetron/wpn_mwave_beam_shoot_01.wav",")")
TFA.AddSound("TFA_AW_MWAVE.Loop", CHAN_WEAPON, 0.5, SNDLVL_TALKING, {95,103}, "weapons/tfa_aw/magnetron/wpn_mwave_beam_lo_npc_0.wav",")")
TFA.AddSound("TFA_AW_MWAVE.Stop", CHAN_WEAPON, 0.5, SNDLVL_TALKING, {95,103}, "weapons/tfa_aw/magnetron/wpn_mwave_beam_stop_01.wav",")")

/*TFA.AddFireSound("TFA_AW_MWAVE.Start", "weapons/tfa_aw/magnetron/wpn_mwave_beam_shoot_01.wav", true, ")")
TFA.AddFireSound("TFA_AW_MWAVE.Loop", "weapons/tfa_aw/magnetron/wpn_mwave_beam_lo_npc_0.wav", false, ")")
TFA.AddFireSound("TFA_AW_MWAVE.Stop", "weapons/tfa_aw/magnetron/wpn_mwave_beam_stop_01.wav", false, ")")*/

TFA.AddWeaponSound("TFA_AW_MWAVE.Overheat.Out", "weapons/tfa_aw/magnetron/wpn_mwave_overheat_out.wav")
TFA.AddWeaponSound("TFA_AW_MWAVE.Overheat.In", "weapons/tfa_aw/magnetron/wpn_mwave_overheat_in.wav")

TFA.AddSound("TFA_AW_MWAVE.Rise", CHAN_AUTO, 1, SNDLVL_NORM, 100, "weapons/tfa_aw/magnetron/wpn_mwave_beam_lo_npc_rise_0.wav",")")
TFA.AddSound("TFA_AW_MWAVE.Cook", CHAN_ITEM, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_aw/magnetron/npc_mwave_flesh_bubble_0.wav",")")
TFA.AddSound("TFA_AW_MWAVE.Pop", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_aw/magnetron/zmb_exploder_expl_01.wav", "weapons/tfa_aw/magnetron/zmb_exploder_expl_02.wav", "weapons/tfa_aw/magnetron/zmb_exploder_expl_03.wav"},")")
TFA.AddSound("TFA_AW_MWAVE.Pop.Lyr", CHAN_ITEM, 0.5, SNDLVL_NORM, {90,110}, {"weapons/tfa_aw/magnetron/zmb_exploder_expl_lyr2_01.wav", "weapons/tfa_aw/magnetron/zmb_exploder_expl_lyr2_02.wav", "weapons/tfa_aw/magnetron/zmb_exploder_expl_lyr2_03.wav"},")")

-- Raygun (BO2, with a twist)
TFA.AddFireSound("TFA_BO2_RAYGUN.Shoot", "weapons/tfa_bo2/raygun/ray_shot_f.wav", true, ")")
TFA.AddFireSound("TFA_BO2_RAYGUN.Act", "weapons/tfa_bo2/raygun/act_00.wav", true, ")")
TFA.AddSound("TFA_BO2_RAYGUN.Flux", CHAN_ITEM, 0.3, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/raygun/wpn_ray_flux.wav",")")

TFA.AddWeaponSound("TFA_BO2_RAYGUN.BatOut", "weapons/tfa_bo2/raygun/wpn_ray_reload_battery_out.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.BatIn", "weapons/tfa_bo2/raygun/wpn_ray_reload_battery.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.Open", "weapons/tfa_bo2/raygun/wpn_ray_reload_open.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.Close", "weapons/tfa_bo2/raygun/wpn_ray_reload_close.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.Hit", "weapons/tfa_bo2/raygun/hit.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.Activate", "weapons/tfa_bo2/raygun/activate.wav")
TFA.AddWeaponSound("TFA_BO2_RAYGUN.Deny", "weapons/tfa_bo2/raygun/deny.wav")

TFA.AddSound("TFA_BO2_RAYGUN.Shoot1", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo2/raygun/ray_shot_f.wav",")")
TFA.AddSound("TFA_BO2_RAYGUN.Act1", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 50, "weapons/tfa_bo2/raygun/act_00.wav",")")
TFA.AddSound("TFA_BO2_RAYGUN.Flux1", CHAN_ITEM, 0.3, SNDLVL_TALKING, 50, "weapons/tfa_bo2/raygun/wpn_ray_flux.wav",")")

-- Magnetron
TFA.AddFireSound("TFA_AW_CEL3.Shoot", "weapons/tfa_aw/cel3/wpn_cauterizer_body.wav", true, ")")
TFA.AddFireSound("TFA_AW_CEL3.Boom", {"weapons/tfa_aw/cel3/wpn_cauterizer_boom_01.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_boom_02.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_boom_03.wav"}, false, ")")
TFA.AddFireSound("TFA_AW_CEL3.Snap", "weapons/tfa_aw/cel3/wpn_cauterizer_snap.wav", true, ")")

TFA.AddWeaponSound("TFA_AW_CEL3.Pullout", "weapons/tfa_aw/cel3/wpn_caut_pullout.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Rechamber", "weapons/tfa_aw/cel3/wpn_caut_rechamber.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Rechamber.Fins", "weapons/tfa_aw/cel3/wpn_caut_rechamber_fins.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload1", "weapons/tfa_aw/cel3/wpn_caut_reload_01.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload1a", "weapons/tfa_aw/cel3/wpn_caut_reload_01a.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload2", "weapons/tfa_aw/cel3/wpn_caut_reload_02.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload3", "weapons/tfa_aw/cel3/wpn_caut_reload_03.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload4", "weapons/tfa_aw/cel3/wpn_caut_reload_04.wav")
TFA.AddWeaponSound("TFA_AW_CEL3.Reload5", "weapons/tfa_aw/cel3/wpn_caut_reload_05.wav")

TFA.AddSound("TFA_AW_CEL3.Zap", CHAN_ITEM, 1, SNDLVL_NORM, 100, {"weapons/tfa_aw/cel3/wpn_cauterizer_zap_01.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_zap_02.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_zap_03.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_zap_04.wav", "weapons/tfa_aw/cel3/wpn_cauterizer_zap_05.wav"},")")

-- Magnetron
TFA.AddFireSound("TFA_BO1_HELLFIRE.Shoot", "weapons/tfa_bo1/hellfire/hellfire_fire.wav", true, ")")
TFA.AddSound("TFA_BO1_HELLFIRE.Firey", CHAN_WEAPON, 0.4, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo1/hellfire/firey_00.wav", "weapons/tfa_bo1/hellfire/firey_01.wav", "weapons/tfa_bo1/hellfire/firey_02.wav", "weapons/tfa_bo1/hellfire/firey_03.wav"},")")

TFA.AddWeaponSound("TFA_BO1_HELLFIRE.Open", "weapons/tfa_bo1/hellfire/fly_freeze_open.wav")
TFA.AddWeaponSound("TFA_BO1_HELLFIRE.Close", "weapons/tfa_bo1/hellfire/fly_freeze_finish.wav")
TFA.AddWeaponSound("TFA_BO1_HELLFIRE.ClipOff", "weapons/tfa_bo1/hellfire/fly_freeze_off.wav")
TFA.AddWeaponSound("TFA_BO1_HELLFIRE.ClipOn", "weapons/tfa_bo1/hellfire/fly_freeze_backon.wav")
TFA.AddWeaponSound("TFA_BO1_HELLFIRE.Twist", "weapons/tfa_bo1/hellfire/fly_freeze_twist.wav")

TFA.AddSound("TFA_BO1_HELLFIRE.Idle", CHAN_ITEM, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo1/hellfire/hellfire_butane_idle.wav",")")

TFA.AddSound("TFA_BO1_HELLFIRE.Ignite", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo1/hellfire/ignite_00.wav",")")
TFA.AddSound("TFA_BO1_HELLFIRE.Burn", CHAN_VOICE, 1, SNDLVL_GUNFIRE, {95,105}, {"weapons/tfa_bo1/hellfire/zombie_burn_00.wav", "weapons/tfa_bo1/hellfire/zombie_burn_01.wav", "weapons/tfa_bo1/hellfire/zombie_burn_02.wav", "weapons/tfa_bo1/hellfire/zombie_burn_03.wav", "weapons/tfa_bo1/hellfire/zombie_burn_04.wav", "weapons/tfa_bo1/hellfire/zombie_burn_05.wav"},")")

-- Wunderwaffe Blast-X33
TFA.AddFireSound("TFA_WAW_BLASTX33.Shoot", {"weapons/tfa_waw/blastx33/shoot_00.wav", "weapons/tfa_waw/blastx33/shoot_01.wav", "weapons/tfa_waw/blastx33/shoot_02.wav", "weapons/tfa_waw/blastx33/shoot_03.wav", "weapons/tfa_waw/blastx33/shoot_04.wav"}, true, ")")

-- Hunter Killer
TFA.AddSound("TFA_BO2_HKDRONE.Launch", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo2/hunterkiller/hk_launch.LN65.pc.snd.wav",")")
TFA.AddSound("TFA_BO2_HKDRONE.Target", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo2/hunterkiller/hk_targeted.LN65.pc.snd.wav",")")
TFA.AddSound("TFA_BO2_HKDRONE.Loop", CHAN_ITEM, 0.5, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/hunterkiller/hk_loop.LL65.pc.snd.wav",")")
TFA.AddSound("TFA_BO2_HKDRONE.Switch", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/hunterkiller/hk_switch.LN65.pc.snd.wav",")")

TFA.AddWeaponSound("TFA_BO2_HKDRONE.Indentify", "weapons/tfa_bo2/hunterkiller/identified.LN65.pc.snd.wav")
TFA.AddWeaponSound("TFA_BO2_HKDRONE.Scanning", "weapons/tfa_bo2/hunterkiller/scanning.LN65.pc.snd.wav")

-- Xray
TFA.AddFireSound("TFA_WAW_XRAY.Shoot", "weapons/tfa_waw/xray/smallblast.wav", false, ")")
TFA.AddFireSound("TFA_WAW_XRAY.Blast", "weapons/tfa_waw/xray/bigblast.wav", true, ")")

TFA.AddSound("TFA_WAW_XRAY.Act", CHAN_ITEM, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_waw/xray/wpn_energy_sg_act.wav",")")
TFA.AddSound("TFA_WAW_XRAY.Blast.Act", CHAN_ITEM, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_waw/xray/wpn_lightning_decay_ext.wav",")")

TFA.AddWeaponSound("TFA_WAW_XRAY.MagOut", "weapons/tfa_waw/xray/fly_aug_mag_out.wav")
TFA.AddWeaponSound("TFA_WAW_XRAY.MagIn", "weapons/tfa_waw/xray/fly_aug_mag_in.wav")
TFA.AddWeaponSound("TFA_WAW_XRAY.Tap", "weapons/tfa_waw/xray/fly_g11_tap.wav")

-- Blundergat/Acidgat
TFA.AddFireSound("TFA_BO2_BLUNDERGAT.Shoot", "weapons/tfa_bo2/blundergat/wpn_blundergat_fire.wav", true, ")")
TFA.AddFireSound("TFA_BO2_ACIDGAT.Shoot", "weapons/tfa_bo2/blundergat/shot.wav", false, ")")

TFA.AddSound("TFA_BO2_ACIDGAT.Proj.Fweep", CHAN_STATIC, 0.6, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/blundergat/wpn_titus_dart.wav",")")
TFA.AddSound("TFA_BO2_ACIDGAT.Proj.Fuse", CHAN_WEAPON, 0.8, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/blundergat/fuse.wav",")")
TFA.AddSound("TFA_BO2_ACIDGAT.Proj.Explo", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo2/blundergat/explo_00.wav", "weapons/tfa_bo2/blundergat/explo_01.wav", "weapons/tfa_bo2/blundergat/explo_02.wav", "weapons/tfa_bo2/blundergat/explo_03.wav"},")")
TFA.AddSound("TFA_BO2_ACIDGAT.Proj.Sweet", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/blundergat/us_bomb_explo_2.wav",")")

TFA.AddWeaponSound("TFA_BO2_BLUNDERGAT.Open", "weapons/tfa_bo2/blundergat/blunder_reload_512.wav")
TFA.AddWeaponSound("TFA_BO2_BLUNDERGAT.Insert", "weapons/tfa_bo2/blundergat/blunder_reload_535.wav")
TFA.AddWeaponSound("TFA_BO2_BLUNDERGAT.Close", "weapons/tfa_bo2/blundergat/blunder_reload_572.wav")

-- Blunderhoff
TFA.AddSound("TFA_BO2_BLUNDERHOFF.Explo", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/blundergat/shot.wav",")")

-- Teslagat
TFA.AddFireSound("TFA_BO2_TESLAGAT.Act", "weapons/tfa_bo2/teslagat/wpn_elec_staff_fire.wav", false, ")")

TFA.AddSound("TFA_BO2_TESLAGAT.Proj.Charge", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/teslagat/lghtng_charge_03.wav",")")
TFA.AddSound("TFA_BO2_TESLAGAT.Proj.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/teslagat/lghtng_charge_loop.wav",")")
TFA.AddSound("TFA_BO2_TESLAGAT.Proj.Loop2", CHAN_ITEM, 0.4, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/teslagat/lghtng_charge_loop_2.wav",")")

-- Hellgat
TFA.AddFireSound("TFA_BO2_HELLGAT.Act", "weapons/tfa_bo2/hellgat/shot_front.wav", false, ")")

TFA.AddSound("TFA_BO2_HELLGAT.Proj", CHAN_WEAPON, 0.6, SNDLVL_NORM, {95,105}, "weapons/tfa_bo2/hellgat/shot_rear.wav",")")
TFA.AddSound("TFA_BO2_HELLGAT.Proj.Charge", CHAN_WEAPON, 0.6, SNDLVL_NORM, {95,105}, "weapons/tfa_bo2/hellgat/proj_loop.wav",")")
TFA.AddSound("TFA_BO2_HELLGAT.Proj.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/hellgat/grenade_loop.wav",")")
TFA.AddSound("TFA_BO2_HELLGAT.Proj.End", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/hellgat/upgraded_imp.wav",")")

TFA.AddSound("TFA_BO2_HELLGAT.Proj.Explo", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo2/hellgat/proj_explo_00.wav", "weapons/tfa_bo2/hellgat/proj_explo_01.wav", "weapons/tfa_bo2/hellgat/proj_explo_02.wav"},")")
TFA.AddSound("TFA_BO2_HELLGAT.Explo", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/blundergat/wpn_blundergat_fire.wav",")")

-- Molotov
TFA.AddWeaponSound("TFA_BO1_MOLOTOV.Light", "weapons/tfa_bo2/molotov/wpn_molotov_light_00.wav")
TFA.AddWeaponSound("TFA_BO1_MOLOTOV.Ignite", "weapons/tfa_bo2/molotov/molotov_light.wav")

TFA.AddSound ("TFA_BO1_MOLOTOV.Throw", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/molotov/molotov_throw_00.wav",")")
TFA.AddSound ("TFA_BO1_MOLOTOV.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo2/molotov/molotov_explode_00.wav", "weapons/tfa_bo2/molotov/molotov_explode_02.wav"},")")
TFA.AddSound ("TFA_BO2_GRENADE.Throw", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/grenade/gren_throw.wav",")")

TFA.AddSound ("TFA_BO1_MOLOTOV.Burn", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo2/molotov/fire_ember_burn_00.wav", "weapons/tfa_bo2/molotov/fire_ember_burn_01.wav", "weapons/tfa_bo2/molotov/fire_ember_burn_02.wav"},")")
TFA.AddSound ("TFA_BO1_MOLOTOV.Zomb.Burn", CHAN_WEAPON, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo2/molotov/on_fire.wav",")")
TFA.AddSound ("TFA_BO1_MOLOTOV.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/molotov/wood_fire_lrg.wav",")")

-- Beartrap
TFA.AddSound ("TFA_BO2_BEARTRAP.Snap", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo2/beartrap/beartrap_snap_00.wav", "weapons/tfa_bo2/beartrap/beartrap_snap_01.wav"},")")
TFA.AddSound ("TFA_BO2_BEARTRAP.Arm", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/beartrap/evt_bear_trap_arm.wav",")")
TFA.AddSound ("TFA_BO2_BEARTRAP.Plant", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/beartrap/evt_bear_trap_fire.wav",")")
TFA.AddSound ("TFA_BO2_BEARTRAP.Raise", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/beartrap/evt_bear_trap_raise.wav",")")
TFA.AddSound ("TFA_BO2_BEARTRAP.Mortar", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo2/beartrap/evt_bear_trap_mortar_plant_plr.wav",")")

-- H.Y.P.E.
TFA.AddFireSound("TFA_BO3_HYPE.FireIn", "weapons/tfa_bo3/hypecannon/hype_shot.wav", true, ")")
TFA.AddFireSound("TFA_BO3_HYPE.FireInUpg", "weapons/tfa_bo3/hypecannon/hype_shot_upg.wav", true, ")")
TFA.AddFireSound("TFA_BO3_HYPE.FireLoop", "weapons/tfa_bo3/hypecannon/hype_loop.wav", false, ")")
TFA.AddFireSound("TFA_BO3_HYPE.FireOut", "weapons/tfa_bo3/hypecannon/hype_power_down.wav", false, ")")

TFA.AddSound("TFA_BO3_HYPE.Imp.Loop", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/hypecannon/hype_imp_loop.wav",")")
TFA.AddSound("TFA_BO3_HYPE.Overheat", CHAN_STATIC, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/hypecannon/hype_overheat_steam.wav",")")

TFA.AddWeaponSound("TFA_BO3_HYPE.Raise", "weapons/tfa_bo3/hypecannon/fly_blackcell_first_raise.wav")
TFA.AddWeaponSound("TFA_BO3_HYPE.MagOut", "weapons/tfa_bo3/hypecannon/fly_blackcell_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_HYPE.MagIn", "weapons/tfa_bo3/hypecannon/fly_blackcell_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_HYPE.SlideOut", "weapons/tfa_bo3/hypecannon/fly_blackcell_slide_out.wav")
TFA.AddWeaponSound("TFA_BO3_HYPE.SlideIn", "weapons/tfa_bo3/hypecannon/fly_blackcell_slide_in.wav")
//TFA.AddWeaponSound("TFA_BO3_HYPE.Overheat", "weapons/tfa_bo3/hypecannon/hype_overheat_steam.wav")

-- Hand Cannon
TFA.AddFireSound("TFA_WAW_HANDCANNON.Shoot", "weapons/tfa_waw/handcannon/hand_fire.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_HANDCANNON.Short", {"weapons/tfa_waw/handcannon/cloth_00.wav", "weapons/tfa_waw/handcannon/cloth_01.wav", "weapons/tfa_waw/handcannon/cloth_02.wav", "weapons/tfa_waw/handcannon/cloth_03.wav"})
TFA.AddWeaponSound("TFA_WAW_HANDCANNON.Cloth", {"weapons/tfa_waw/handcannon/fly_cloth_00.wav", "weapons/tfa_waw/handcannon/fly_cloth_01.wav", "weapons/tfa_waw/handcannon/fly_cloth_02.wav", "weapons/tfa_waw/handcannon/fly_cloth_03.wav"})

-- Levitator
TFA.AddFireSound("TFA_WAW_LEVITATOR.Shoot", "weapons/tfa_waw/panther/nsz_ww_fire.wav", true, ")")
TFA.AddFireSound("TFA_WAW_LEVITATOR.Flux", "weapons/tfa_waw/panther/nsz_pap_shot.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_LEVITATOR.MagOut", "weapons/tfa_waw/panther/fly_pistol_mag_out.wav")
TFA.AddWeaponSound("TFA_WAW_LEVITATOR.MagIn", "weapons/tfa_waw/panther/fly_pistol_mag_in.wav")
TFA.AddWeaponSound("TFA_WAW_LEVITATOR.SlideBack", "weapons/tfa_waw/panther/fly_pistol_sb.wav")
TFA.AddWeaponSound("TFA_WAW_LEVITATOR.SlideFwd", "weapons/tfa_waw/panther/fly_pistol_sf.wav")

TFA.AddSound("TFA_WAW_LEVITATOR.Wait", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/panther/nsz_ww_wait.wav",")")

TFA.AddSound("TFA_WAW_LEVITATOR.Orb.Start", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/panther/camo_suit_on.wav",")")
TFA.AddSound("TFA_WAW_LEVITATOR.Orb.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/panther/camo_suit_loop.wav",")")
TFA.AddSound("TFA_WAW_LEVITATOR.Orb.End", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/panther/camo_suit_off.wav",")")

-- Teslanade
TFA.AddFireSound("TFA_WAW_QUIZZTESLA.Flux", "weapons/tfa_waw/teslanade/beam_fx_fl.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_QUIZZTESLA.Bounce", "weapons/tfa_waw/teslanade/bb_plant.wav")
TFA.AddWeaponSound("TFA_WAW_QUIZZTESLA.SwitchOff", "weapons/tfa_waw/teslanade/tesla_switch_flip_off.wav")
TFA.AddWeaponSound("TFA_WAW_QUIZZTESLA.SwitchOn", "weapons/tfa_waw/teslanade/tesla_switch_flip_on.wav")
TFA.AddWeaponSound("TFA_WAW_QUIZZTESLA.Raise", "weapons/tfa_waw/teslanade/raise.wav")
TFA.AddWeaponSound("TFA_WAW_QUIZZTESLA.Flip", "weapons/tfa_waw/teslanade/flipdown.wav")

TFA.AddSound("TFA_WAW_QUIZZTESLA.Loop", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/teslanade/beam_fx_home_loop.wav",")")
TFA.AddSound("TFA_WAW_QUIZZTESLA.Start", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/teslanade/beam_fx_home_start.wav",")")
TFA.AddSound("TFA_WAW_QUIZZTESLA.End", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/teslanade/beam_fx_home_end.wav",")")
TFA.AddSound("TFA_WAW_QUIZZTESLA.Teleport", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/teslanade/teleport_out.wav",")")
TFA.AddSound("TFA_WAW_QUIZZTESLA.Warmup", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_waw/teslanade/warmup.wav",")")

-- UGX Axe
TFA.AddWeaponSound("TFA_WAW_AXE.Swing", "weapons/tfa_waw/ugxaxe/axe_swing_plr.wav")

-- UGX Electrip
TFA.AddSound("TFA_WAW_ELECTRIP.Start", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_waw/electrip/trap_start.wav",")")
TFA.AddSound("TFA_WAW_ELECTRIP.Loop", CHAN_WEAPON, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_waw/electrip/trap_loop.wav",")")

-- Teslanade
TFA.AddFireSound("TFA_WAW_BBETTY.Trigger", "weapons/tfa_waw/bbetty/bbtrigger.wav", false, ")")
TFA.AddWeaponSound("TFA_WAW_BBETTY.Pin", "weapons/tfa_waw/bbetty/pin_00.wav")

TFA.AddSound("TFA_WAW_BBETTY.Plant", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/bbetty/bb_plant.wav",")")

-- Plasmanade
TFA.AddFireSound("TFA_WAW_PLASMANADE.Expl", "weapons/tfa_waw/plasmanade/us_bomb_flux.wav", false, ")")
TFA.AddSound("TFA_WAW_PLASMANADE.Expl.Sweet", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/plasmanade/wpn_emp_explode.wav",")")

TFA.AddSound("TFA_WAW_PLASMANADE.ZombExpl", CHAN_AUTO, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_waw/plasmanade/explode_00.wav", "weapons/tfa_waw/plasmanade/explode_01.wav", "weapons/tfa_waw/plasmanade/explode_02.wav", "weapons/tfa_waw/plasmanade/explode_03.wav", "weapons/tfa_waw/plasmanade/explode_04.wav", "weapons/tfa_waw/plasmanade/explode_05.wav"},")")
TFA.AddSound("TFA_WAW_PLASMANADE.Charge", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/plasmanade/emp_charge_mn.wav",")")

TFA.AddSound("TFA_WAW_PLASMANADE.Player.Start", CHAN_STATIC, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/plasmanade/emp_static_start.wav",")")
TFA.AddSound("TFA_WAW_PLASMANADE.Player.Loop", CHAN_WEAPON, 0.5, SNDLVL_IDLE, {97,103}, "weapons/tfa_waw/plasmanade/emp_static_loop.wav",")")
TFA.AddSound("TFA_WAW_PLASMANADE.Player.End", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/plasmanade/emp_static_stop.wav",")")
TFA.AddSound("TFA_WAW_PLASMANADE.Player.EMP", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_waw/plasmanade/zm_bus_shut_down_emp.wav",")")

TFA.AddWeaponSound("TFA_WAW_PLASMANADE.Bounce.Wood", {"weapons/tfa_waw/plasmanade/bounce/emp_bounce_wood_00.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_wood_01.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_wood_02.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_wood_03.wav"})
TFA.AddWeaponSound("TFA_WAW_PLASMANADE.Bounce.Earth", {"weapons/tfa_waw/plasmanade/bounce/emp_bounce_earth_00.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_earth_01.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_earth_02.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_earth_03.wav"})
TFA.AddWeaponSound("TFA_WAW_PLASMANADE.Bounce.Metal", {"weapons/tfa_waw/plasmanade/bounce/emp_bounce_metal_00.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_metal_01.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_metal_02.wav", "weapons/tfa_waw/plasmanade/bounce/emp_bounce_metal_03.wav"})

TFA.AddSound("TFA_WAW_PLASMANADE.Bounce", CHAN_ITEM, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/plasmanade/bounce/emp_bounce_sweet_00.wav",")")

-- Ubernade
TFA.AddFireSound("TFA_WAW_UBERNADE.Expl", {"weapons/tfa_waw/ubernade/grenade_explo01.wav", "weapons/tfa_waw/ubernade/grenade_explo02.wav", "weapons/tfa_waw/ubernade/grenade_explo03.wav"}, true, ")")
TFA.AddFireSound("TFA_WAW_UBERNADE.Expl.Sweet", {"weapons/tfa_waw/ubernade/exp_9_bang_01.wav", "weapons/tfa_waw/ubernade/exp_9_bang_02.wav", "weapons/tfa_waw/ubernade/exp_9_bang_03.wav"}, true, ")")

TFA.AddWeaponSound("TFA_WAW_UBERNADE.Throw", {"weapons/tfa_waw/ubernade/grenade_throw_1.wav", "weapons/tfa_waw/ubernade/grenade_throw_2.wav"})

TFA.AddSound("TFA_WAW_UBERNADE.Loop.Sweet", CHAN_WEAPON, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_waw/ubernade/road_flare_lp.wav",")")
TFA.AddSound("TFA_WAW_UBERNADE.Loop", CHAN_ITEM, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_waw/ubernade/emt_spark_fountain_loop1.wav",")")
TFA.AddSound("TFA_WAW_UBERNADE.Click", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/ubernade/mine_betty_click1.wav",")")

-- Airburstnade
TFA.AddFireSound("TFA_WAW_ABNADE.Expl", {"weapons/tfa_waw/abnade/weap_expl_flash_bang1.wav", "weapons/tfa_waw/abnade/weap_expl_flash_bang2.wav", "weapons/tfa_waw/abnade/weap_expl_flash_bang3.wav"}, false, ")")

TFA.AddWeaponSound("TFA_WAW_ABNADE.Pin", "weapons/tfa_waw/abnade/grenade_pin_flash.wav")

TFA.AddSound("TFA_WAW_ABNADE.Charge", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_waw/abnade/firework_1.wav", "weapons/tfa_waw/abnade/firework_3.wav"},")")

-- Spikemore
TFA.AddFireSound("TFA_BO1_SPIKEMORE.Blast", "weapons/tfa_bo1/spikemore/wpn_spikemore_blast.wav", true, ")")
TFA.AddFireSound("TFA_BO1_SPIKEMORE.Flux", "weapons/tfa_bo1/spikemore/wpn_spikemore_flux_l.wav", false, ")")

TFA.AddWeaponSound("TFA_BO1_SPIKEMORE.Plant", "weapons/tfa_bo1/spikemore/claymore_plant_00.wav")
TFA.AddWeaponSound("TFA_BO1_SPIKEMORE.Alert", "weapons/tfa_bo1/spikemore/alert_00.wav")

TFA.AddSound("TFA_BO1_SPIKEMORE.Hit", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo1/spikemore/wpn_spikemore_imp01.wav", "weapons/tfa_bo1/spikemore/wpn_spikemore_imp02.wav", "weapons/tfa_bo1/spikemore/wpn_spikemore_imp03.wav"},")")

-- Laser Colt
TFA.AddFireSound("TFA_WAW_LASER45.Shoot", "weapons/tfa_waw/laser/colt45_01.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_LASER45.Trigger", "weapons/tfa_waw/laser/wpn_colt1911_st_act.wav")
TFA.AddWeaponSound("TFA_WAW_LASER45.Slide", "weapons/tfa_waw/laser/1911_slide_forward.wav")

-- C4
TFA.AddSound("TFA_BO1_C4.Expl", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo1/c4/c4_det.wav",")")

TFA.AddWeaponSound("TFA_BO1_C4.Trigger", "weapons/tfa_bo1/c4/c4_det_click.wav")
TFA.AddWeaponSound("TFA_BO1_C4.Plant", "weapons/tfa_bo1/c4/satchel_plant.wav")

TFA.AddSound("TFA_BO2_C4.RampUp", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/c4/mus_f_alarm.wav",")")
TFA.AddSound("TFA_BO2_C4.Expl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo2/c4/mus_sfx_rainbowbeam_1.wav",")")
TFA.AddSound("TFA_BO2_C4.Flux", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo2/c4/mus_sfx_segapower2.wav",")")

-- W@W Explosions
TFA.AddSound("TFA_WAW_EXPLOSION.Main", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_waw/explosion/explosion_main_00.wav", "weapons/tfa_waw/explosion/explosion_main_02.wav", "weapons/tfa_waw/explosion/explosion_main_03.wav", },")")
TFA.AddSound("TFA_WAW_EXPLOSION.Dist", CHAN_WEAPON, 1, 511, {97,103}, {"weapons/tfa_waw/explosion/explosion_dist_00.wav", "weapons/tfa_waw/explosion/explosion_dist_01.wav", "weapons/tfa_waw/explosion/explosion_dist_02.wav", "weapons/tfa_waw/explosion/explosion_dist_03.wav", "weapons/tfa_waw/explosion/explosion_dist_04.wav", "weapons/tfa_waw/explosion/explosion_dist_05.wav", "weapons/tfa_waw/explosion/explosion_dist_06.wav"},")")

-- Mortar
TFA.AddSound("TFA_WAW_MORTAR.Prime", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_waw/mortar/wpn_mortar_prime.wav",")")

TFA.AddWeaponSound("TFA_BO2_MORTAR.Arm", "weapons/tfa_bo2/mortar/evt_mortar_arm_plr.wav")

TFA.AddSound("TFA_BO2_MORTAR.Expl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo2/mortar/exp_mortar_close_00.wav", "weapons/tfa_bo2/mortar/exp_mortar_close_01.wav"},")")
TFA.AddSound("TFA_BO2_MORTAR.Dist", CHAN_WEAPON, 1, 511, {97,103}, {"weapons/tfa_bo2/mortar/exp_large_decay_00.wav", "weapons/tfa_bo2/mortar/exp_large_decay_01.wav"},")")
TFA.AddSound("TFA_BO2_MORTAR.Flux", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo2/mortar/exp_mortar_00.wav", "weapons/tfa_bo2/mortar/exp_mortar_01.wav", "weapons/tfa_bo2/mortar/exp_mortar_02.wav", "weapons/tfa_bo2/mortar/exp_mortar_03.wav"},")")

-- Zapgun
TFA.AddFireSound("TFA_BO1_MICROWAVE.Shoot", "weapons/tfa_bo1/microwavegun/microwave_shot.wav", true, ")")
TFA.AddFireSound("TFA_BO1_MICROWAVE.Shoot.Rear", "weapons/tfa_bo1/microwavegun/microwave_shot_rear.wav", false, ")")
TFA.AddFireSound("TFA_BO1_MICROWAVE.Rifle.Shoot", "weapons/tfa_bo1/microwavegun/microwave_rifle_shot.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_ZAPGUN.Front.Button", "weapons/tfa_waw/zapgun/zap_button.wav")
TFA.AddWeaponSound("TFA_WAW_ZAPGUN.Front.Start", "weapons/tfa_waw/zapgun/zap_vapor.wav")
TFA.AddWeaponSound("TFA_WAW_ZAPGUN.Front.End", "weapons/tfa_waw/zapgun/zap_end.wav")
TFA.AddWeaponSound("TFA_WAW_ZAPGUN.Front.Out", "weapons/tfa_waw/zapgun/zap_out.wav")
TFA.AddWeaponSound("TFA_WAW_ZAPGUN.Front.In", "weapons/tfa_waw/zapgun/zap_in.wav")

TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rear.Start", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_right_start.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rear.In", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_right_mag_in.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rear.End", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_right_end.wav")

TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Front.Start", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_left_start.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Front.In", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_left_mag_in.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Front.End", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_left_end.wav")

TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rifle.Futz", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_rifle_futz.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rifle.MagIn", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_rifle_mag_in.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rifle.MagOut", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_rifle_mag_out.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rifle.Start", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_rifle_start.wav")
TFA.AddWeaponSound("TFA_BO1_MICROWAVE.Rifle.End", "weapons/tfa_bo1/microwavegun/wpn_micro_rld_rifle_power_up.wav")

-- Thunderpistol
TFA.AddFireSound("TFA_WAW_TPISTOL.Shoot", "weapons/tfa_waw/thunderpistol/wpn_thundergun_fire_plr.wav", false, ")")
TFA.AddFireSound("TFA_WAW_TPISTOL.Dist", "weapons/tfa_waw/thunderpistol/wpn_rpg_fire_dist.wav", true, ")")
TFA.AddFireSound("TFA_WAW_TPISTOL.Rear", "weapons/tfa_waw/thunderpistol/wpn_kard_shot_plr.wav", true, ")")

TFA.AddWeaponSound("TFA_WAW_TPISTOL.Whizby", {"weapons/tfa_waw/thunderpistol/prj_whizby_00.wav", "weapons/tfa_waw/thunderpistol/prj_whizby_01.wav", "weapons/tfa_waw/thunderpistol/prj_whizby_02.wav", "weapons/tfa_waw/thunderpistol/prj_whizby_03.wav"})
TFA.AddWeaponSound("TFA_WAW_TPISTOL.MagOut", "weapons/tfa_waw/thunderpistol/fly_pistol_mag_out.wav")
TFA.AddWeaponSound("TFA_WAW_TPISTOL.MagIn", "weapons/tfa_waw/thunderpistol/fly_pistol_mag_in.wav")
TFA.AddWeaponSound("TFA_WAW_TPISTOL.SlideBack", "weapons/tfa_waw/thunderpistol/fly_pistol_sb.wav")
TFA.AddWeaponSound("TFA_WAW_TPISTOL.SlideFwd", "weapons/tfa_waw/thunderpistol/fly_pistol_sf.wav")

TFA.AddWeaponSound("TFA_WAW_TPISTOL.CellOut", "weapons/tfa_waw/thunderpistol/fly_thundergun_cell_slide_lock.wav")
TFA.AddWeaponSound("TFA_WAW_TPISTOL.CellIn", "weapons/tfa_waw/thunderpistol/fly_thundergun_cell_replace.wav")
TFA.AddWeaponSound("TFA_WAW_TPISTOL.CellOn", "weapons/tfa_waw/thunderpistol/fly_thundergun_cell_on.wav")

TFA.AddSound("TFA_BO1_THUNDERGUN.Disintegrate", CHAN_ITEM, 1, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo1/thundergun/zmb_disintegrate_00.wav", "weapons/tfa_bo1/thundergun/zmb_disintegrate_01.wav"},")")

-- Pumpkingun
TFA.AddFireSound("TFA_WAW_PUMPKINGUN.Explode", {"weapons/tfa_waw/pumpkingun/pumpkin_explode1.wav", "weapons/tfa_waw/pumpkingun/pumpkin_explode2.wav", "weapons/tfa_waw/pumpkingun/pumpkin_explode3.wav"}, false, ")")

TFA.AddSound("TFA_WAW_PUMPKINGUN.Chatter", CHAN_ITEM, 1, SNDLVL_TALKING, 100, {"weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_02.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_03.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_04.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_05.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_06.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_08.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_09.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_10.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_11.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_12.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_14.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbomb_15.wav"},")")
TFA.AddSound("TFA_WAW_PUMPKINGUN.Kaboom", CHAN_ITEM, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_01.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_02.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_03.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_04.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_05.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_06.wav", "weapons/tfa_waw/pumpkingun/hall2015_pumpbombboom_07.wav"},")")
TFA.AddSound("TFA_WAW_PUMPKINGUN.Shot", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/pumpkingun/wpn_rpg_shot_plr.wav",")")

-- Freezegun
TFA.AddFireSound("TFA_BO1_FREEZEGUN.Shoot", "weapons/tfa_bo1/freezegun/shot_plr_fnt.wav", true, ")")
TFA.AddSound("TFA_BO1_FREEZEGUN.Flux", CHAN_ITEM, 0.1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo1/freezegun/flux.wav",")")

TFA.AddWeaponSound("TFA_BO1_FREEZEGUN.Open", "weapons/tfa_bo1/freezegun/fly_freeze_open.wav")
TFA.AddWeaponSound("TFA_BO1_FREEZEGUN.Close", "weapons/tfa_bo1/freezegun/fly_freeze_finish.wav")

TFA.AddSound("TFA_BO1_FREEZEGUN.Impact", CHAN_AUTO, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo1/freezegun/impact_00.wav", "weapons/tfa_bo1/freezegun/impact_01.wav", "weapons/tfa_bo1/freezegun/impact_02.wav", "weapons/tfa_bo1/freezegun/impact_03.wav"},")")

-- Rayzorback-118
TFA.AddFireSound("TFA_WAW_RAYZOR.Shoot", "weapons/tfa_bo3/razorback/wpn_smg_lr_start.wav", false, ")")

TFA.AddWeaponSound("TFA_WAW_RAYZOR.MagIn", "weapons/tfa_bo3/razorback/fly_razor_mag_in.wav")
TFA.AddWeaponSound("TFA_WAW_RAYZOR.MagOut", "weapons/tfa_bo3/razorback/fly_razor_mag_out.wav")
TFA.AddWeaponSound("TFA_WAW_RAYZOR.Twist", "weapons/tfa_bo3/razorback/fly_dsr50_sight_twist_00.wav")
TFA.AddWeaponSound("TFA_WAW_RAYZOR.Start", "weapons/tfa_bo3/razorback/start_00.wav")
TFA.AddWeaponSound("TFA_WAW_RAYZOR.Stop", "weapons/tfa_bo3/razorback/stop_00.wav")

-- Compact Nuke Gun
TFA.AddFireSound("TFA_BO3_CNG.Shoot", "weapons/tfa_bo3/cng/wpn_cng_fire.wav", true, ")")

TFA.AddSound("TFA_BO3_CNG.Charge", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, {"weapons/tfa_bo2/molotov/fire_ember_burn_00.wav", "weapons/tfa_bo2/molotov/fire_ember_burn_01.wav", "weapons/tfa_bo2/molotov/fire_ember_burn_02.wav"},")")
TFA.AddSound("TFA_BO3_CNG.Launch", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/cng/evt_cng_launch.wav",")")
TFA.AddSound("TFA_BO3_CNG.Stormed", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/cng/evt_cng_stormed.wav",")")

-- Gravity Spikes
TFA.AddFireSound("TFA_WAW_SPIKE.Shockwave", "weapons/tfa_waw/grav_spike/wpn_gravity_shockwave.wav", false, ")")
TFA.AddFireSound("TFA_WAW_SPIKE.Explode", "weapons/tfa_waw/grav_spike/rm22_explosion.wav", true, ")")

TFA.AddWeaponSound("TFA_WAW_SPIKE.Activate", "weapons/tfa_waw/grav_spike/wpn_gravity_activate_00.wav")
TFA.AddWeaponSound("TFA_WAW_SPIKE.Melee", "weapons/tfa_waw/grav_spike/wpn_grav_melee.wav")
TFA.AddWeaponSound("TFA_WAW_SPIKE.Start", "weapons/tfa_waw/grav_spike/wpn_gravity_start_00.wav")

TFA.AddSound("TFA_WAW_SPIKE.Plant", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/grav_spike/wpn_grav_place.wav",")")
TFA.AddSound("TFA_WAW_SPIKE.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_waw/grav_spike/wpn_grav_lp.wav",")")
TFA.AddSound("TFA_WAW_SPIKE.End", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_waw/grav_spike/wpn_grav_end.wav",")")

-- LZ-52 Limbo
TFA.AddFireSound("TFA_AW_LIMBO.Arc", "weapons/tfa_aw/linegun/wpn_linegun_arc.wav", false, ")")
TFA.AddFireSound("TFA_AW_LIMBO.Glitch", "weapons/tfa_aw/linegun/wpn_linegun_glitch.wav", true, ")")
TFA.AddFireSound("TFA_AW_LIMBO.Burst", "weapons/tfa_aw/linegun/wpn_linegun_burst.wav", true, ")")

TFA.AddWeaponSound("TFA_AW_LIMBO.Rechamber", "weapons/tfa_aw/linegun/wpn_linegun_rechamber.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Charge", "weapons/tfa_aw/linegun/wpn_linegun_reload_charge.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Close", "weapons/tfa_aw/linegun/wpn_linegun_reload_close.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Eject", "weapons/tfa_aw/linegun/wpn_linegun_reload_discharge.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Lift", "weapons/tfa_aw/linegun/wpn_linegun_reload_lift.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Mag", "weapons/tfa_aw/linegun/wpn_linegun_reload_mag.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.MagIn", "weapons/tfa_aw/linegun/wpn_linegun_reload_magin.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Motor", "weapons/tfa_aw/linegun/wpn_linegun_reload_motor.wav")
TFA.AddWeaponSound("TFA_AW_LIMBO.Reload.Open", "weapons/tfa_aw/linegun/wpn_linegun_reload_open.wav")

TFA.AddSound("TFA_AW_LIMBO.Loop.Hi", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_aw/linegun/wpn_linegun_beam_hi.wav",")")
TFA.AddSound("TFA_AW_LIMBO.Loop.Lo", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_aw/linegun/wpn_linegun_beam_lo.wav",")")

-- LZ-52 Limbo
TFA.AddFireSound("TFA_AW_TRIDENT.Blast", "weapons/tfa_aw/trident/wpn_trident_blast.wav", false, ")")
TFA.AddFireSound("TFA_AW_TRIDENT.Sub", "weapons/tfa_aw/trident/wpn_trident_sub.wav", true, ")")
TFA.AddFireSound("TFA_AW_TRIDENT.Tail", "weapons/tfa_aw/trident/wpn_trident_tail.wav", true, ")")

TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.Start", "weapons/tfa_aw/trident/wpn_trident_reload_01.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.MagOut", "weapons/tfa_aw/trident/wpn_trident_reload_02.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.Eject", "weapons/tfa_aw/trident/wpn_trident_reload_03.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.Mag", "weapons/tfa_aw/trident/wpn_trident_reload_04.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.MagIn", "weapons/tfa_aw/trident/wpn_trident_reload_05.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.End", "weapons/tfa_aw/trident/wpn_trident_reload_06.wav")
TFA.AddWeaponSound("TFA_AW_TRIDENT.Reload.Chamber", "weapons/tfa_aw/trident/wpn_trident_reload_07.wav")

TFA.AddSound("TFA_AW_TRIDENT.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_aw/trident/wpn_trident_prj_loop.wav",")")
TFA.AddSound("TFA_AW_TRIDENT.Spark", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_aw/trident/wpn_trident_spark_01.wav", "weapons/tfa_aw/trident/wpn_trident_spark_02.wav", "weapons/tfa_aw/trident/wpn_trident_spark_03.wav"},")")

-- Exo Launcher
TFA.AddWeaponSound("TFA_AW_EXOLAUNCHER.Raise", {"weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_01.wav", "weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_02.wav"})
TFA.AddWeaponSound("TFA_AW_EXOLAUNCHER.Mech", {"weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_mech_01.wav", "weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_mech_02.wav", "weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_mech_03.wav", "weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_mech_04.wav", "weapons/tfa_aw/exo_launcher/wpn_exo_launcher_raise_mech_05.wav"})

-- Distraction Drone
TFA.AddSound("TFA_AW_DISTRACT.Alarm", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_aw/distraction_drone/dist_drone_alarm.wav",")")
TFA.AddSound("TFA_AW_DISTRACT.Deploy", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_aw/distraction_drone/dist_drone_deploy.wav",")")

TFA.AddFireSound("TFA_AW_TRANS.A", {"weapons/tfa_aw/trans/wpn_trans_a_01.wav", "weapons/tfa_aw/trans/wpn_trans_a_02.wav"}, false, ")")
TFA.AddFireSound("TFA_AW_TRANS.ACP", {"weapons/tfa_aw/trans/wpn_trans_cp_a_01.wav", "weapons/tfa_aw/trans/wpn_trans_cp_a_02.wav", "weapons/tfa_aw/trans/wpn_trans_cp_a_03.wav", "weapons/tfa_aw/trans/wpn_trans_cp_a_04.wav"}, true, ")")

-- Atlas Energy Sword
TFA.AddWeaponSound("TFA_AW_SWORD.Draw", {"weapons/tfa_aw/sword/wpn_knife_pullout_blade_01.wav", "weapons/tfa_aw/sword/wpn_knife_pullout_blade_02.wav", "weapons/tfa_aw/sword/wpn_knife_pullout_blade_03.wav", "weapons/tfa_aw/sword/wpn_knife_pullout_blade_04.wav"})

TFA.AddSound("TFA_AW_SWORD.Swing", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_aw/sword/sword_swing01.wav", "weapons/tfa_aw/sword/sword_swing02.wav"},")")
TFA.AddSound("TFA_AW_SWORD.Hit", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_aw/sword/sword_hit01.wav", "weapons/tfa_aw/sword/sword_hit02.wav", "weapons/tfa_aw/sword/sword_hit03.wav", "weapons/tfa_aw/sword/sword_hit04.wav"},")")
TFA.AddSound("TFA_AW_SWORD.HitFlesh", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_aw/sword/sword_hit_flesh01.wav", "weapons/tfa_aw/sword/sword_hit_flesh02.wav", "weapons/tfa_aw/sword/sword_hit_flesh03.wav"},")")

TFA.AddSound("TFA_AW_SWORD.Charge", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_aw/vulcan/vulcan_charge_start_npc.wav",")")

-- Nano Swarm
TFA.AddSound("TFA_AW_NANOSWARM.Explode", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_aw/grenade/dna/dna_grenade_expl_01.wav", ")")
TFA.AddSound("TFA_AW_NANOSWARM.Loop", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_aw/grenade/dna/dna_grenade_front_lp_0.wav", "weapons/tfa_aw/grenade/dna/dna_grenade_rear_lp_0.wav"}, ")")
TFA.AddSound("TFA_AW_NANOSWARM.End", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_aw/grenade/dna/dna_grenade_end_quad_frnt.wav", "weapons/tfa_aw/grenade/dna/dna_grenade_end_quad_rear.wav"}, ")")
