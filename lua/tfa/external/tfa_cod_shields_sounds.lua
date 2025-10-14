-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

TFA.AddSound("NZ.Misc.Stinger", CHAN_VOICE2, 1, SNDLVL_NORM, {95,105}, "zmb/stinger/afterlife_end.wav",")")
TFA.AddSound("NZ.Tomb.Perk.Stinger", CHAN_ITEM, 1, SNDLVL_TALKING, 100, {"nzr/2023/ammomatic/tomb_perk_sting_01.wav", "nzr/2023/ammomatic/tomb_perk_sting_03.wav", "nzr/2023/ammomatic/tomb_perk_sting_04.wav", "nzr/2023/ammomatic/tomb_perk_sting_05.wav", "nzr/2023/ammomatic/tomb_perk_sting_06.wav"},")")

TFA.AddSound("NZ.Buildable.Foley", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/collect/fly_ammo_pickup_01.wav",")")
TFA.AddSound("NZ.Buildable.Stinger", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/collect/crystal_00.wav",")")

TFA.AddSound("NZ.Buildable.Craft.Loop", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/zm_common.all.sabl.1475.wav",")")
TFA.AddSound("NZ.Buildable.Craft.LoopSweet", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, {"nzr/2023/buildables/zm_common.all.sabl.1469.wav", "nzr/2023/buildables/zm_common.all.sabl.1470.wav"},")")
TFA.AddSound("NZ.Buildable.Craft.Finish", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/zm_common.all.sabl.1473.wav",")")
TFA.AddSound("NZ.Buildable.Craft.FinishSweet", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/buildables/zm_common.all.sabl.1471.wav",")")
TFA.AddSound("NZ.Buildable.Deny", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2023/buildables/zm_common.all.sabl.1487.wav",")")
TFA.AddSound("NZ.Buildable.PickUp", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/buildables/zm_common.all.sabl.1477.wav",")")

TFA.AddSound("NZ.BO2.Buildable.Craft.Loop", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/bo2/zmb_building_lp.wav",")")
TFA.AddSound("NZ.BO2.Buildable.Craft.Finish", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/buildables/bo2/zmb_build_completed.wav",")")
TFA.AddSound("NZ.BO2.Buildable.Deny", CHAN_STATIC, 1, SNDLVL_NORM, 100, "nzr/2023/buildables/bo2/deny_00.wav",")")
TFA.AddSound("NZ.BO2.Buildable.PickUp", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/buildables/bo2/zmb_build_add_piece.wav",")")

TFA.AddSound("NZ.Buildable.Select", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "nzr/2023/buildables/slider_f.wav",")")
TFA.AddSound("NZ.Buildable.Loop", CHAN_WEAPON, 0.5, SNDLVL_NORM, 100, "nzr/2023/buildables/collectable_loop.wav",")")

TFA.AddSound("NZ.BO2.SoulBox.Open", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/soulbox/challenge_box_open.wav",")")
TFA.AddSound("NZ.BO2.SoulBox.Close", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/soulbox/challenge_box_close_r3.wav",")")
TFA.AddSound("NZ.BO2.SoulBox.Dissapear", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "nzr/2023/soulbox/disappear.wav",")")
TFA.AddSound("NZ.BO2.SoulBox.Fill", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/soulbox/evt_souls_flush.wav",")")
TFA.AddSound("NZ.BO2.SoulBox.Finish", CHAN_STATIC, 1, 511, 100, "nzr/2023/soulbox/evt_souls_full.wav",")")

TFA.AddSound("NZ.BO2.DigSite.Dig", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "nzr/2023/digsite/dig_00.wav",")")
TFA.AddSound("NZ.BO2.DigSite.Grenade", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {97,103}, "nzr/2023/digsite/grenade_pull.wav",")")
TFA.AddSound("NZ.BO2.DigSite.SpecialLoop", CHAN_WEAPON, 0.5, SNDLVL_NORM, 100, "nzr/2023/digsite/staff_loop.wav",")")
TFA.AddSound("NZ.BO2.DigSite.Special", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "nzr/2023/digsite/staff_spawn.wav",")")
TFA.AddSound("NZ.BO2.DigSite.Part", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "nzr/2023/digsite/chalk_finish.wav",")")
TFA.AddSound("NZ.BO2.Shovel.Upgrade", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/digsite/fill.wav",")")

TFA.AddSound("NZ.Tomb.Torch.Ignite", CHAN_STATIC, 0.5, SNDLVL_TALKING, {97,103}, "zmb/tomb/torch/ignite.wav",")")
TFA.AddSound("NZ.Tomb.Torch.Loop", CHAN_WEAPON, 1, SNDLVL_IDLE, {97,103}, "zmb/tomb/torch/loop.wav",")")
TFA.AddSound("NZ.Tomb.Torch.Putout", CHAN_WEAPON, 0.5, SNDLVL_TALKING, {97,103}, "zmb/tomb/torch/putout.wav",")")

TFA.AddSound("NZ.Trials.Start", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "nzr/2023/trials/evt_timerestart.wav",")")
TFA.AddSound("NZ.Trials.StartLfe", CHAN_STATIC, 1, SNDLVL_IDLE, 100, "nzr/2023/trials/evt_timerestart_lfe.wav",")")

TFA.AddSound("NZ.Jumppad.Charge", CHAN_WEAPON, 1, SNDLVL_NORM, {95,105}, "zmb/moon/jump_pad/evt_jump_pad_charge.wav",")")
TFA.AddSound("NZ.Jumppad.ChargeShort", CHAN_WEAPON, 1, SNDLVL_NORM, {95,105}, "zmb/moon/jump_pad/evt_jump_pad_charge_short.wav",")")
TFA.AddSound("NZ.Jumppad.Land", CHAN_WEAPON, 1, SNDLVL_NORM, {95,105}, "zmb/moon/jump_pad/evt_jump_pad_land.wav",")")
TFA.AddSound("NZ.Jumppad.Launch", CHAN_WEAPON, 1, SNDLVL_NORM, {95,105}, "zmb/moon/jump_pad/evt_jump_pad_launch.wav",")")
TFA.AddSound("NZ.Jumppad.Fun", CHAN_STATIC, 0.5, SNDLVL_IDLE, {95,105}, "zmb/moon/jump_pad/jumppad_fun.wav",")")

TFA.AddSound("NZ.Telepad.Start", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "zmb/pentagon/teleporter/zm_office.all.sabl.338.wav",")")
TFA.AddSound("NZ.Telepad.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "zmb/pentagon/teleporter/zm_office.all.sabl.336.wav",")")
TFA.AddSound("NZ.Telepad.Teleport.Out", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "zmb/pentagon/teleporter/zm_office.all.sabl.334.wav",")")
TFA.AddSound("NZ.Telepad.Teleport", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "zmb/pentagon/teleporter/zm_office.all.sabl.333.wav",")")

TFA.AddSound("NZ.Chalks.Pickup", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "zmb/buried/chalk/chalk_pickup.wav",")")
TFA.AddSound("NZ.Chalks.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "zmb/buried/chalk/chalk_loop.wav",")")
TFA.AddSound("NZ.Chalks.Finish", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "zmb/buried/chalk/chalk_finish.wav",")")

-- Misc
TFA.AddWeaponSound("TFA_WAW_GEAR.Rattle", {"weapons/tfa_waw/gear/3p_gear_rattle_00.wav", "weapons/tfa_waw/gear/3p_gear_rattle_01.wav", "weapons/tfa_waw/gear/3p_gear_rattle_02.wav", "weapons/tfa_waw/gear/3p_gear_rattle_03.wav", "weapons/tfa_waw/gear/3p_gear_rattle_04.wav", "weapons/tfa_waw/gear/3p_gear_rattle_05.wav"})
TFA.AddWeaponSound("TFA_WAW_GEAR.Cloth", {"weapons/tfa_waw/gear/cloth_00.wav", "weapons/tfa_waw/gear/cloth_01.wav", "weapons/tfa_waw/gear/cloth_02.wav", "weapons/tfa_waw/gear/cloth_03.wav", "weapons/tfa_waw/gear/cloth_04.wav", "weapons/tfa_waw/gear/cloth_05.wav"})

-- BO3 Shield
TFA.AddWeaponSound("TFA_BO3_SHIELD.Swing", {"weapons/tfa_bo3/rocketshield/riot_shield_swing_00.wav", "weapons/tfa_bo3/rocketshield/riot_shield_swing_01.wav"})
TFA.AddWeaponSound("TFA_BO3_SHIELD.SwingCloth", {"weapons/tfa_bo3/rocketshield/riot_shield_swing_cloth_00.wav", "weapons/tfa_bo3/rocketshield/riot_shield_swing_cloth_01.wav"})
TFA.AddWeaponSound("TFA_BO3_SHIELD.Hit", {"weapons/tfa_bo3/rocketshield/riot_shield_impact01.wav", "weapons/tfa_bo3/rocketshield/riot_shield_impact02.wav", "weapons/tfa_bo3/rocketshield/riot_shield_impact03.wav", "weapons/tfa_bo3/rocketshield/riot_shield_impact04.wav"})
TFA.AddSound("TFA_BO3_SHIELD.Break", CHAN_ITEM, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/rocketshield/riot_shield_disable_fall.wav",")")

-- Rocket Shield
TFA.AddFireSound("TFA_BO3_ROCKETSHIELD.Start", "weapons/tfa_bo3/rocketshield/rocketshield_start.wav", false, ")")
TFA.AddFireSound("TFA_BO3_ROCKETSHIELD.End", "weapons/tfa_bo3/rocketshield/rocketshield_end.wav", false, ")")

TFA.AddWeaponSound("TFA_BO3_ROCKETSHIELD.Strike", "weapons/tfa_bo3/rocketshield/bowling_strike.wav")
TFA.AddWeaponSound("TFA_BO3_ROCKETSHIELD.Cheer", "weapons/tfa_bo3/rocketshield/bowling_cheer.wav")

-- Dragon Shield
TFA.AddFireSound("TFA_BO3_DRAGONSHIELD.Shoot", "weapons/tfa_bo3/dragonshield/shot_front.wav", true, ")")
TFA.AddFireSound("TFA_BO3_DRAGONSHIELD.Explode", {"weapons/tfa_bo3/dragonshield/exp_firey_00.wav", "weapons/tfa_bo3/dragonshield/exp_firey_01.wav", "weapons/tfa_bo3/dragonshield/exp_firey_02.wav", "weapons/tfa_bo3/dragonshield/exp_firey_03.wav"}, true, ")")
TFA.AddSound("TFA_BO3_DRAGONSHIELD.Flux", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/dragonshield/flux.wav",")")

-- BO2 Sounds
TFA.AddWeaponSound("TFA_BO2_SHIELD.Plant", "weapons/tfa_bo2/shield/wpn_shield_plant.wav")
TFA.AddWeaponSound("TFA_BO2_SHIELD.Pickup", "weapons/tfa_bo2/shield/wpn_shield_destroy.wav")
TFA.AddWeaponSound("TFA_BO2_SHIELD.Press", "weapons/tfa_bo2/shield/door_close_00.wav")
TFA.AddWeaponSound("TFA_BO2_SHIELD.Key", "weapons/tfa_bo2/shield/wpn_cell_shield_raise.wav")

TFA.AddWeaponSound("TFA_BO2_SHIELD.ZMPlant", "weapons/tfa_bo2/shield/zm_riotshield_plant.wav")

TFA.AddWeaponSound("TFA_BO2_SHIELD.Recover", {"weapons/tfa_bo2/shield/recover_00.wav", "weapons/tfa_bo2/shield/recover_01.wav"})
TFA.AddWeaponSound("TFA_BO2_SHIELD.Swing", {"weapons/tfa_bo2/shield/riot_shield_swing_00.wav", "weapons/tfa_bo2/shield/riot_shield_swing_01.wav"})
TFA.AddWeaponSound("TFA_BO2_SHIELD.Cloth", {"weapons/tfa_bo2/shield/riot_shield_swing_cloth_00.wav", "weapons/tfa_bo2/shield/riot_shield_swing_cloth_01.wav"})
TFA.AddWeaponSound("TFA_BO2_SHIELD.Hit", {"weapons/tfa_bo2/shield/riot_shield_impact01.wav", "weapons/tfa_bo2/shield/riot_shield_impact02.wav", "weapons/tfa_bo2/shield/riot_shield_impact03.wav", "weapons/tfa_bo2/shield/riot_shield_impact04.wav"})
TFA.AddSound("TFA_BO2_SHIELD.Break", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/shield/riot_shield_disable_fall.wav",")")

-- Rake Trap
TFA.AddFireSound("TFA_BO2_RAKETRAP.Hit", {"weapons/tfa_bo2/raketrap/rake_hit_00.wav", "weapons/tfa_bo2/raketrap/rake_hit_00.wav", "weapons/tfa_bo2/raketrap/rake_hit_00.wav", "weapons/tfa_bo2/raketrap/rake_hit_01.wav", "weapons/tfa_bo2/raketrap/rake_hit_01.wav", "weapons/tfa_bo2/raketrap/rake_hit_01.wav", "weapons/tfa_bo2/raketrap/rake_hit_02.wav", "weapons/tfa_bo2/raketrap/rake_hit_02.wav", "weapons/tfa_bo2/raketrap/bonk.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO2_RAKETRAP.Slice", {"weapons/tfa_bo2/raketrap/bowie_swing_00.wav", "weapons/tfa_bo2/raketrap/bowie_swing_01.wav", "weapons/tfa_bo2/raketrap/bowie_swing_02.wav"})
TFA.AddWeaponSound("TFA_BO2_RAKETRAP.Fall", "weapons/tfa_bo2/raketrap/rake_fall.wav")

TFA.AddSound("TFA_BO2_RAKETRAP.Swing", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/raketrap/axe_swing_plr.wav",")")

-- Head Chopper
TFA.AddWeaponSound("TFA_BO2_HEADCHOP.Swing", {"weapons/tfa_bo2/headchopper/swing_00.wav", "weapons/tfa_bo2/headchopper/swing_01.wav", "weapons/tfa_bo2/headchopper/swing_02.wav", "weapons/tfa_bo2/headchopper/swing_03.wav", "weapons/tfa_bo2/headchopper/swing_04.wav"})
TFA.AddWeaponSound("TFA_BO2_HEADCHOP.Start", "weapons/tfa_bo2/headchopper/start.wav")

TFA.AddSound("TFA_BO2_HEADCHOP.Reset", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/headchopper/reset_short.wav",")")
TFA.AddSound("TFA_BO2_HEADCHOP.ResetFast", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/headchopper/reset.wav",")")
TFA.AddSound("TFA_BO2_HEADCHOP.ResetLong", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/headchopper/reset_superlong.wav",")")

-- Turbine
TFA.AddWeaponSound("TFA_BO2_TURBINE.Wind", "weapons/tfa_bo2/turbine/zmb_turbine_wind.wav")
TFA.AddSound("TFA_BO2_TURBINE.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/turbine/zmb_turbine_stg3.wav",")")
TFA.AddSound("TFA_BO2_TURBINE.Pulse", CHAN_ITEM, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo2/turbine/turbine_pulse.wav",")")

-- Electric Trap
TFA.AddSound("TFA_BO2_ETRAP.Start", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/etrap/electrap_start.wav",")")
TFA.AddSound("TFA_BO2_ETRAP.Loop", CHAN_WEAPON, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/etrap/electrap_loop.wav",")")
TFA.AddSound("TFA_BO2_ETRAP.Stop", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/etrap/electrap_stop.wav",")")

TFA.AddSound("TFA_BO2_ETRAP.Zap", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo2/etrap/electrap_zap_00.wav", "weapons/tfa_bo2/etrap/electrap_zap_01.wav", "weapons/tfa_bo2/etrap/electrap_zap_02.wav", "weapons/tfa_bo2/etrap/electrap_zap_03.wav"},")")

-- Subwoofer
TFA.AddSound("TFA_BO2_WOOFER.Explo", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/subwoofer/us_bomb_explo_2.wav",")")
TFA.AddSound("TFA_BO2_WOOFER.Sweet", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo2/subwoofer/us_bomb_explo_sweet_2.wav",")")

-- Turret
TFA.AddFireSound("TFA_BO2_MOWER.Shoot", "weapons/tfa_bo2/turret/wpn_lsat_shot_plr.wav", true, ")")
TFA.AddFireSound("TFA_BO2_MOWER.Decay", "weapons/tfa_bo2/turret/wpn_lmg_decay.wav", false, ")")

TFA.AddSound("TFA_BO2_MOWER.Start", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo2/turret/turret_start.wav",")")
TFA.AddSound("TFA_BO2_MOWER.Loop", CHAN_ITEM, 0.5, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/turret/turret_loop.wav",")")
TFA.AddSound("TFA_BO2_MOWER.Stop", CHAN_ITEM, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo2/turret/turret_stop.wav",")")

-- Flinger
TFA.AddFireSound("TFA_BO2_FLINGER.Shoot", "weapons/tfa_bo2/flinger/launch.wav", false, ")")

TFA.AddSound("TFA_BO2_FLINGER.Reset", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo2/flinger/reset_start.wav",")")
TFA.AddSound("TFA_BO2_FLINGER.Ready", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/flinger/reset_stop_358.wav",")")

-- Maxis Drone
TFA.AddFireSound("TFA_BO2_ZMDRONE.Shoot", "weapons/tfa_bo2/drone/wpn_qr_turret_dcy_pap.wav", true, ")")

TFA.AddWeaponSound("TFA_BO2_ZMDRONE.Takeoff", "weapons/tfa_bo2/drone/zm_qr_takeoff.wav")

TFA.AddSound("TFA_BO2_ZMDRONE.Idle", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/drone/drone_loop.wav",")")
TFA.AddSound("TFA_BO2_ZMDRONE.Hum", CHAN_WEAPON, 0.2, SNDLVL_NORM, {97,103}, "weapons/tfa_bo2/drone/idle_01.wav",")")

TFA.AddSound("TFA_BO2_ZMDRONE.Teleport", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo2/drone/teleport_out_00.wav", "weapons/tfa_bo2/drone/teleport_out_01.wav"},")")
TFA.AddSound("TFA_BO2_ZMDRONE.Recharging", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo2/drone/maxis_folly.wav",")")

-- Teslatrap
TFA.AddFireSound("TFA_GHOSTS_TESLA.Zap", "weapons/tfa_ghosts/teslatrap/tele_spark_hit.wav", false, ")")

TFA.AddSound("TFA_GHOSTS_TESLA.Loop", CHAN_AUTO, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_ghosts/teslatrap/loop_00.wav",")")
TFA.AddSound("TFA_GHOSTS_TESLA.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_ghosts/teslatrap/exp_electrical_00.wav", "weapons/tfa_ghosts/teslatrap/exp_electrical_01.wav"},")")
TFA.AddSound("TFA_GHOSTS_TESLA.Arc", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_ghosts/teslatrap/arc_00.wav", "weapons/tfa_ghosts/teslatrap/arc_01.wav", "weapons/tfa_ghosts/teslatrap/arc_02.wav", "weapons/tfa_ghosts/teslatrap/arc_03.wav", "weapons/tfa_ghosts/teslatrap/arc_04.wav", "weapons/tfa_ghosts/teslatrap/arc_05.wav"},")")

-- Lantern
TFA.AddSound("TFA_WAW_LANTERN.Burn", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_waw/lantern/lantern_loop_far.wav",")")

TFA.AddSound("TFA_WAW_LANTERN.Attack", CHAN_ITEM, 0.4, SNDLVL_NORM, 100, {"weapons/tfa_waw/lantern/attack_10.wav", "weapons/tfa_waw/lantern/attack_11.wav", "weapons/tfa_waw/lantern/attack_12.wav", "weapons/tfa_waw/lantern/attack_13.wav", "weapons/tfa_waw/lantern/attack_14.wav", "weapons/tfa_waw/lantern/attack_15.wav", "weapons/tfa_waw/lantern/attack_16.wav", "weapons/tfa_waw/lantern/attack_17.wav", "weapons/tfa_waw/lantern/attack_18.wav", "weapons/tfa_waw/lantern/attack_19.wav"},")")
TFA.AddSound("TFA_WAW_LANTERN.Slash", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_waw/lantern/knife_slash_00.wav", "weapons/tfa_waw/lantern/knife_slash_01.wav", "weapons/tfa_waw/lantern/knife_slash_02.wav"},")")
TFA.AddSound("TFA_WAW_LANTERN.Hit", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_waw/lantern/hit_other_00.wav", "weapons/tfa_waw/lantern/hit_other_01.wav", "weapons/tfa_waw/lantern/hit_other_02.wav", "weapons/tfa_waw/lantern/hit_other_03.wav"},")")

-- Lantern
TFA.AddSound("TFA_MW2_RIOTSHIELD.Swing", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_mw2009/riotshield/h2h_knife_swing1.wav", "weapons/tfa_mw2009/riotshield/h2h_knife_swing2.wav"},")")

TFA.AddSound("TFA_MW2_RIOTSHIELD.Impact", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_mw2009/riotshield/impact_riotshield_01.wav", "weapons/tfa_mw2009/riotshield/impact_riotshield_02.wav", "weapons/tfa_mw2009/riotshield/impact_riotshield_03.wav"},")")
