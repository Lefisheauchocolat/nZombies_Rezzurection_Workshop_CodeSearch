local nzombies = engine.ActiveGamemode() == "nzombies"

game.AddParticles("particles/perks_aat_radiation.pcf")

PrecacheParticleSystem("bo3_aat_fallout_start")
PrecacheParticleSystem("bo3_aat_fallout_loop")
PrecacheParticleSystem("bo3_aat_fallout_zomb")
PrecacheParticleSystem("bo3_aat_fallout_zomb_floor")
PrecacheParticleSystem("bo3_aat_fallout_eyes")
PrecacheParticleSystem("bo3_aat_fallout_kill")

TFA.AddSound("NZ.Cherry.Shock", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/cherry/zm_common.all.sabl.1796.wav", "nzr/2022/perks/cherry/zm_common.all.sabl.1797.wav", "nzr/2022/perks/cherry/zm_common.all.sabl.1798.wav", "nzr/2022/perks/cherry/zm_common.all.sabl.1799.wav", "nzr/2022/perks/cherry/zm_common.all.sabl.1800.wav", "nzr/2022/perks/cherry/zm_common.all.sabl.1801.wav"},")")
TFA.AddSound("NZ.Cherry.Sweet", CHAN_VOICE_BASE, 1, SNDLVL_NORM, 100, "nzr/2022/perks/cherry/zm_common.all.sabl.1789.wav",")")

TFA.AddSound("NZ.PHD.Wubz", CHAN_USER_BASE, 1, SNDLVL_GUNFIRE, 100, "nzr/2022/perks/phd/mori2_perk_phd_explode.wav",")")
TFA.AddSound("NZ.PHD.Explode", CHAN_AUTO, 1, SNDLVL_TALKING, 100, "nzr/2022/perks/phd/c4_det.wav",")")
TFA.AddSound("NZ.PHD.Impact", CHAN_VOICE_BASE, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/phd/impact_00.wav", "nzr/2022/perks/phd/impact_01.wav"},")")
TFA.AddSound("NZ.PHD.Jump", CHAN_AUTO, 1, SNDLVL_IDLE, 100, "nzr/2022/perks/phd/evt_jump_pad_land.wav",")")
TFA.AddSound("NZ.PHD.Funny", CHAN_AUTO, 1, SNDLVL_IDLE, 100, "nzr/2022/perks/phd/jumppad_fun.wav",")")

TFA.AddSound("NZ.ZombShell.Start", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "nzr/2022/perks/zombshell/zm_common.all.p.sabl.105.wav",")")
TFA.AddSound("NZ.ZombShell.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "nzr/2022/perks/zombshell/zm_common.all.p.sabl.104.wav",")")
TFA.AddSound("NZ.ZombShell.End", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"nzr/2022/perks/zombshell/zm_common.all.p.sabl.99.wav", "nzr/2022/perks/zombshell/zm_common.all.p.sabl.100.wav", "nzr/2022/perks/zombshell/zm_common.all.p.sabl.101.wav", "nzr/2022/perks/zombshell/zm_common.all.p.sabl.102.wav"},")")

TFA.AddSound("NZ.POP.BlastFurnace.Die", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/pop/blastfurnace/flame_burst_00.wav", "nzr/2022/perks/pop/blastfurnace/flame_burst_01.wav", "nzr/2022/perks/pop/blastfurnace/flame_burst_02.wav", "nzr/2022/perks/pop/blastfurnace/flame_burst_03.wav"},")")
TFA.AddSound("NZ.POP.BlastFurnace.Expl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/pop/blastfurnace/exp_incendiary_00.wav", "nzr/2022/perks/pop/blastfurnace/exp_incendiary_01.wav", "nzr/2022/perks/pop/blastfurnace/exp_incendiary_02.wav"},")")
TFA.AddSound("NZ.POP.BlastFurnace.Sweet", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "nzr/2022/perks/pop/blastfurnace/flame_burst_00.wav", "nzr/2022/perks/pop/blastfurnace/wpn_incindiary_core_start.wav",")")

TFA.AddSound("NZ.POP.Deadwire.Die", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_00.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_01.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_02.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_03.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_04.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_05.wav", "nzr/2022/perks/pop/deadwire/zmb_dg2_death_soul_06.wav"},")")
TFA.AddSound("NZ.POP.Deadwire.Shock", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/pop/deadwire/shock_effect_01.wav", "nzr/2022/perks/pop/deadwire/shock_effect_02.wav"},")")

TFA.AddSound("NZ.POP.Fireworks.Whistle", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/pop/fireworks/whistle_00.wav", "nzr/2022/perks/pop/fireworks/whistle_01.wav", "nzr/2022/perks/pop/fireworks/whistle_02.wav", "nzr/2022/perks/pop/fireworks/whistle_03.wav", "nzr/2022/perks/pop/fireworks/whistle_04.wav"},")")
TFA.AddSound("NZ.POP.Fireworks.Expl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/pop/fireworks/explo_small_00.wav", "nzr/2022/perks/pop/fireworks/explo_small_01.wav", "nzr/2022/perks/pop/fireworks/explo_small_02.wav", "nzr/2022/perks/pop/perks/fireworks/explo_small_03.wav", "nzr/2022/perks/pop/fireworks/explo_small_04.wav"},")")
TFA.AddSound("NZ.POP.Fireworks.Shoot", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/perks/pop/fireworks/wpn_pap_first.wav",")")

TFA.AddSound("NZ.POP.Turned.Impact", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/pop/turned/turned_impact_00.wav", "nzr/2022/perks/pop/turned/turned_impact_01.wav", "nzr/2022/perks/pop/turned/turned_impact_02.wav"},")")
TFA.AddSound("NZ.POP.Turned.Loop", CHAN_WEAPON, 0.3, SNDLVL_IDLE, 100, "nzr/2022/perks/pop/turned/turned_loop.wav",")")

TFA.AddSound("NZ.POP.Thunderwall.Shoot", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 90, "nzr/2022/perks/pop/thunderwall/wpn_pap_launcher.wav",")")

TFA.AddSound("NZ.POP.Cryofreeze.Freeze", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/pop/cryofreeze/bo4_winters_zombfreeze01.wav", "nzr/2022/perks/pop/cryofreeze/bo4_winters_zombfreeze02.wav", "nzr/2022/perks/pop/cryofreeze/bo4_winters_zombfreeze03.wav"},")")
TFA.AddSound("NZ.POP.Cryofreeze.Shatter", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"nzr/2022/perks/pop/cryofreeze/bo4_winters_zombshatter01.wav", "nzr/2022/perks/pop/cryofreeze/bo4_winters_zombshatter02.wav", "nzr/2022/perks/pop/cryofreeze/bo4_winters_zombshatter03.wav"},")")
TFA.AddSound("NZ.POP.Cryofreeze.Wind", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"nzr/2022/perks/pop/cryofreeze/fly_freezegun_proj_wind01.wav", "nzr/2022/perks/pop/cryofreeze/fly_freezegun_proj_wind02.wav"},")")

TFA.AddSound("NZ.Vulture.Stink.Start", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "nzr/2022/perks/vultures/stink/start.wav",")")
TFA.AddSound("NZ.Vulture.Stink.Loop", CHAN_VOICE2, 0.3, SNDLVL_IDLE, 100, "nzr/2022/perks/vultures/stink/loop.wav",")")
TFA.AddSound("NZ.Vulture.Stink.Stop", CHAN_VOICE2, 1, SNDLVL_IDLE, 100, "nzr/2022/perks/vultures/stink/stop.wav",")")

TFA.AddSound("NZ.ChuggaBud.Charge", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/perks/chuggabud/ww_deactivate.wav",")")
TFA.AddSound("NZ.ChuggaBud.Stinger", CHAN_VOICE2, 1, SNDLVL_TALKING, 100, "nzr/2022/perks/chuggabud/ww_looper.wav",")")
TFA.AddSound("NZ.ChuggaBud.Teleport", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/perks/chuggabud/mpl_flashback_reappear_plr.wav",")")
TFA.AddSound("NZ.ChuggaBud.Sweet", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"nzr/2022/perks/chuggabud/teleport_out_00.wav", "nzr/2022/perks/chuggabud/teleport_out_01.wav"},")")

TFA.AddSound("NZ.Winters.Start", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"nzr/2022/perks/winters/zm_common.all.sabl.1816.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1817.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1818.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1819.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1820.wav"},")")
TFA.AddSound("NZ.Winters.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"nzr/2022/perks/winters/zm_common.all.sabl.1824.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1825.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1826.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1827.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1828.wav", "nzr/2022/perks/winters/zm_common.all.sabl.1829.wav"},")")
TFA.AddSound("NZ.Winters.End", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "nzr/2022/perks/winters/zm_common.all.sabl.1048.wav",")")

TFA.AddSound("NZ.BO2.Box.Open", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/magicbox/bo2/open_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Close", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/magicbox/bo2/close_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Land", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/land_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Disappear", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/disappear_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Flux", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "nzr/2022/magicbox/bo2/flux_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Poof", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "nzr/2022/magicbox/bo2/poof_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Woosh", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/whoosh_00.wav",")")
TFA.AddSound("NZ.BO2.Box.Spin", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/zmb_box_spin.wav",")")
TFA.AddSound("NZ.BO2.Box.Music", CHAN_ITEM, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/music_box_00.wav",")")

TFA.AddSound("NZ.BO2.TombBox.Open", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/magicbox/bo2/tomb/magic_box_open.wav",")")
TFA.AddSound("NZ.BO2.TombBox.Close", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/magicbox/bo2/tomb/magic_box_close.wav",")")
TFA.AddSound("NZ.BO2.TombBox.Arrive", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/tomb/magicbox_arrive.wav",")")
TFA.AddSound("NZ.BO2.TombBox.Leave", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/tomb/magicbox_leave.wav",")")
TFA.AddSound("NZ.BO2.TombBox.Spin", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2022/magicbox/bo2/tomb/magicbox_gun_select.wav",")")

TFA.AddSound ("NZ.Misc.Achievment", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2022/effects/player/unlock.wav",")")

TFA.AddSound("NZ.AAT.Fallout.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "nzr/2024/aat/fallout/evt_vril_loop_lvl2.wav",")")
TFA.AddSound("NZ.AAT.Fallout.Start", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2024/aat/fallout/evt_vril_start.wav",")")

TFA.AddWeaponSound("NZ.Bottle.Belch", "nzr/2022/perks/bottle/belch.wav")
TFA.AddWeaponSound("NZ.Bottle.Break", "nzr/2022/perks/bottle/break.wav")
TFA.AddWeaponSound("NZ.Bottle.Dispense", "nzr/2022/perks/bottle/dispense.wav")
TFA.AddWeaponSound("NZ.Bottle.Open", "nzr/2022/perks/bottle/open.wav")
TFA.AddWeaponSound("NZ.Bottle.Drink", "nzr/2022/perks/bottle/swallow.wav")

TFA.AddWeaponSound("NZ.Hands.Knuckle0", "nzr/2022/pap/knuckle_00.wav")
TFA.AddWeaponSound("NZ.Hands.Knuckle1", "nzr/2022/pap/knuckle_01.wav")

TFA.AddWeaponSound("NZ.Syrette.Open", "nzr/2023/syrette/adrenaline_cap_off.wav")
TFA.AddWeaponSound("NZ.Syrette.Stab", "nzr/2023/syrette/adrenaline_needle_in.wav")
