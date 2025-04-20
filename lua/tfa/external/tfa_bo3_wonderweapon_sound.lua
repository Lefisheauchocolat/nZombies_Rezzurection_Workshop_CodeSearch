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

-- Shared --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_PAP.Shoot", {"weapons/tfa_bo3/wpn_pap_first.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_SPECIALIST.Charged", {"weapons/tfa_bo3/dg4/sword_ready_3p.wav"}, true, ")")

TFA.AddWeaponSound("weapon_bo3_cloth.med", {"weapons/tfa_bo3/foley/cloth/fly_cloth_med_00.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_01.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_02.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_03.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_04.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_05.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_06.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_07.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_med_08.wav"})
TFA.AddWeaponSound("weapon_bo3_cloth.short", {"weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_00.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_01.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_02.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_03.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_04.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_05.wav", "weapons/tfa_bo3/foley/cloth/fly_cloth_shrt_06.wav"})
TFA.AddWeaponSound("weapon_bo3_gear.rattle", {"weapons/tfa_bo3/foley/gear/gear_rattle_13.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_15.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_16.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_17.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_18.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_19.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_20.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_21.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_22.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_23.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_24.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_25.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_27.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_28.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_29.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_30.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_31.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_32.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_45.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_46.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_47.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_48.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_49.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_50.wav", "weapons/tfa_bo3/foley/gear/gear_rattle_51.wav"})

TFA.AddSound ("TFA_BO3_GENERIC.Funny", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/unlock.wav",")")
TFA.AddSound ("TFA_BO3_GENERIC.Lfe", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/exp_grenade_lfe.wav",")")
TFA.AddSound ("TFA_BO3_GENERIC.Gore", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"zmb/ai/gore/firefly_kill_gore_00.wav", "zmb/ai/gore/firefly_kill_gore_01.wav", "zmb/ai/gore/firefly_kill_gore_02.wav", "zmb/ai/gore/firefly_kill_gore_03.wav"},")")
TFA.AddSound ("TFA_BO3_GENERIC.Gib", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"zmb/ai/gib/fly_gib_00.wav", "zmb/ai/gib/fly_gib_01.wav", "zmb/ai/gib/fly_gib_02.wav"},")")

TFA.AddSound ("TFA_BO3_GENERIC.Lightning.Close", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, {"amb/weather/lightning/amb_lightning_close_var_00.wav", "amb/weather/lightning/amb_lightning_close_var_01.wav", "amb/weather/lightning/amb_lightning_close_var_02.wav", "amb/weather/lightning/amb_lightning_close_var_03.wav"},")")
TFA.AddSound ("TFA_BO3_GENERIC.Lightning.Flash", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, {"amb/weather/lightning/lightning_flash_00.wav", "amb/weather/lightning/lightning_flash_01.wav", "amb/weather/lightning/lightning_flash_02.wav", "amb/weather/lightning/lightning_flash_03.wav"},")")
TFA.AddSound ("TFA_BO3_GENERIC.Lightning.Snap", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, {95,105}, "amb/weather/lightning/thunder_snap.wav",")")

-- Apothicon Servant --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_IDGUN.Shoot", {"weapons/tfa_bo3/idgun/shot_00.wav", "weapons/tfa_bo3/idgun/shot_01.wav", "weapons/tfa_bo3/idgun/shot_02.wav", "weapons/tfa_bo3/idgun/shot_03.wav", "weapons/tfa_bo3/idgun/shot_04.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_IDGUN.Reload", "weapons/tfa_bo3/idgun/fly_id_reload_01.wav")
TFA.AddWeaponSound("TFA_BO3_IDGUN.Draw", "weapons/tfa_bo3/idgun/fly_id_first_raise_01.wav")
TFA.AddWeaponSound("TFA_BO3_IDGUN.Grab", "weapons/tfa_bo3/idgun/tentacle_gun_grab.wav")

TFA.AddSound ("TFA_BO3_IDGUN.Idle", CHAN_STATIC, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/idgun/fly_id_idle.wav",")")

TFA.AddSound ("TFA_BO3_IDGUN.Portal.End", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/idgun/portal_end_v2.wav",")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.Expl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/idgun/portal_explode.wav",")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.Loop", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/idgun/portal_lp_v2.wav",")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.Start", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/idgun/portal_start.wav",")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.Wind", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/idgun/portal_wind_loop.wav",")")

TFA.AddSound ("TFA_BO3_IDGUN.Portal.Pull", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/idgun/portal_zombie_pull.wav",")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.CrushEnd", CHAN_AUTO, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/idgun/crush_start_00.wav", "weapons/tfa_bo3/idgun/crush_start_01.wav", "weapons/tfa_bo3/idgun/crush_start_02.wav", "weapons/tfa_bo3/idgun/crush_start_03.wav", "weapons/tfa_bo3/idgun/crush_start_04.wav"},")")
TFA.AddSound ("TFA_BO3_IDGUN.Portal.CrushStart", CHAN_STATIC, 1, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/idgun/crush_end_00.wav", "weapons/tfa_bo3/idgun/crush_end_01.wav", "weapons/tfa_bo3/idgun/crush_end_02.wav", "weapons/tfa_bo3/idgun/crush_end_03.wav", "weapons/tfa_bo3/idgun/crush_end_04.wav"},")")

-- Raygun --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_RAYGUN.Shoot", {"weapons/tfa_bo3/raygun/ray_shot_f.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_RAYGUN.Flux", {"weapons/tfa_bo3/raygun/wpn_ray_flux.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO3_RAYGUN.BatOut", "weapons/tfa_bo3/raygun/wpn_ray_reload_battery_out.wav")
TFA.AddWeaponSound("TFA_BO3_RAYGUN.BatIn", "weapons/tfa_bo3/raygun/wpn_ray_reload_battery.wav")
TFA.AddWeaponSound("TFA_BO3_RAYGUN.Open", "weapons/tfa_bo3/raygun/wpn_ray_reload_open.wav")
TFA.AddWeaponSound("TFA_BO3_RAYGUN.Close", "weapons/tfa_bo3/raygun/wpn_ray_reload_close.wav")
TFA.AddWeaponSound("TFA_BO3_RAYGUN.Draw", "weapons/tfa_bo3/raygun/wpn_ray_1straise.wav")
TFA.AddWeaponSound("TFA_BO3_RAYGUN.Hit", "weapons/tfa_bo3/raygun/wpn_ray_hit.wav")

TFA.AddSound ("TFA_BO3_RAYGUN.Loop", CHAN_WEAPON, 0.5, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/raygun/wpn_ray_loop.wav",")")

TFA.AddSound ("TFA_BO3_RAYGUN.Exp", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/raygun/wpn_ray_exp.wav",")")
TFA.AddSound ("TFA_BO3_RAYGUN.ExpCl", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo3/raygun/wpn_ray_exp_cl.wav",")")

-- Raygun MK2 --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_MK2.Shoot", {"weapons/tfa_bo3/raygun_mk2/shot_00.wav", "weapons/tfa_bo3/raygun_mk2/shot_01.wav", "weapons/tfa_bo3/raygun_mk2/shot_02.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_MK2.MagOut", "weapons/tfa_bo3/raygun_mk2/pullout.wav")
TFA.AddWeaponSound("TFA_BO3_MK2.MagIn", "weapons/tfa_bo3/raygun_mk2/putin.wav")
TFA.AddWeaponSound("TFA_BO3_MK2.Switch", "weapons/tfa_bo3/raygun_mk2/switch.wav")
TFA.AddWeaponSound("TFA_BO3_MK2.Draw", "weapons/tfa_bo3/raygun_mk2/raise.wav")

TFA.AddSound ("TFA_BO3_MK2.Impact", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/raygun_mk2/imp_00.wav", "weapons/tfa_bo3/raygun_mk2/imp_01.wav", "weapons/tfa_bo3/raygun_mk2/imp_02.wav",")")

-- Thundergun --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_THUNDERGUN.Shoot", {"weapons/tfa_bo3/thundergun/wpn_thundergun_fire_plr.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_THUNDERGUN.Ext", {"weapons/tfa_bo3/thundergun/wpn_thundergun_flux.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Eject", "weapons/tfa_bo3/thundergun/fly_thundergun_eject.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Replace", "weapons/tfa_bo3/thundergun/fly_thundergun_cell_replace.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Lock", "weapons/tfa_bo3/thundergun/fly_thundergun_cell_slide_lock.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.CellOn", "weapons/tfa_bo3/thundergun/fly_thundergun_cell_on.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Draw", "weapons/tfa_bo3/thundergun/fly_thunder_first_raise.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Idle", "weapons/tfa_bo3/thundergun/wpn_thunder_idle.wav")
TFA.AddWeaponSound("TFA_BO3_THUNDERGUN.Chatter", {"weapons/tfa_bo3/thundergun/imp_thundergun_flux_gen_00.wav", "weapons/tfa_bo3/thundergun/imp_thundergun_flux_gen_01.wav", "weapons/tfa_bo3/thundergun/imp_thundergun_flux_gen_02.wav", "weapons/tfa_bo3/thundergun/imp_thundergun_flux_gen_03.wav"})

TFA.AddSound ("TFA_BO3_THUNDERGUN.Impact", CHAN_STATIC, 0.2, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/thundergun/impact_00.wav",")")

-- Wunderwaffe --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_WAFFE.Shoot", {"weapons/tfa_bo3/wunderwaffe/wpn_dg2_fire_f.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_WAFFE.ShootLast", {"weapons/tfa_bo3/wunderwaffe/wpn_dg2_fire_last_f.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_WAFFE.Ext", {"weapons/tfa_bo3/wunderwaffe/wpn_tesla_flux_f.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_WAFFE.Start", "weapons/tfa_bo3/wunderwaffe/tesla_start_reload.wav")
TFA.AddWeaponSound("TFA_BO3_WAFFE.FlipOff", "weapons/tfa_bo3/wunderwaffe/tesla_switch_flip_off.wav")
TFA.AddWeaponSound("TFA_BO3_WAFFE.Pullback", "weapons/tfa_bo3/wunderwaffe/tesla_handle_pullback.wav")
TFA.AddWeaponSound("TFA_BO3_WAFFE.ClipIn", "weapons/tfa_bo3/wunderwaffe/tesla_clip_in.wav")
TFA.AddWeaponSound("TFA_BO3_WAFFE.Release", "weapons/tfa_bo3/wunderwaffe/tesla_handle_release.wav")
TFA.AddWeaponSound("TFA_BO3_WAFFE.FlipOn", "weapons/tfa_bo3/wunderwaffe/tesla_switch_flip_on.wav")

// the wunderwaffe is a cat in my headcannon
TFA.AddWeaponSound("TFA_BO3_WAFFE.Meow.Happy", {"weapons/tfa_bo3/wunderwaffe/happy/happy_00.wav", "weapons/tfa_bo3/wunderwaffe/happy/happy_01.wav", "weapons/tfa_bo3/wunderwaffe/happy/happy_02.wav", "weapons/tfa_bo3/wunderwaffe/happy/happy_03.wav"})
TFA.AddWeaponSound("TFA_BO3_WAFFE.Meow.Sweets", {"weapons/tfa_bo3/wunderwaffe/sweets/sweets_00.wav", "weapons/tfa_bo3/wunderwaffe/sweets/sweets_01.wav", "weapons/tfa_bo3/wunderwaffe/sweets/sweets_04.wav", "weapons/tfa_bo3/wunderwaffe/sweets/sweets_05.wav", "weapons/tfa_bo3/wunderwaffe/sweets/sweets_06.wav"})
TFA.AddWeaponSound("TFA_BO3_WAFFE.Meow.Calm", {"weapons/tfa_bo3/wunderwaffe/calm/calm_00.wav", "weapons/tfa_bo3/wunderwaffe/calm/calm_01.wav", "weapons/tfa_bo3/wunderwaffe/calm/calm_02.wav"})
TFA.AddSound ("TFA_BO3_WAFFE.Meow.Idle", CHAN_STATIC, 0.3, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/wunderwaffe/idle/idle_00.wav", "weapons/tfa_bo3/wunderwaffe/idle/idle_01.wav", "weapons/tfa_bo3/wunderwaffe/idle/idle_02.wav", "weapons/tfa_bo3/wunderwaffe/idle/idle_03.wav", "weapons/tfa_bo3/wunderwaffe/idle/idle_04.wav", "weapons/tfa_bo3/wunderwaffe/idle/idle_05.wav"},")")

TFA.AddSound ("TFA_BO3_WAFFE.Flux", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/wunderwaffe/projectile/wpn_tesla_flux.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.ImpactWater", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/wunderwaffe/projectile/imp_water.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.Impact", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/wunderwaffe/projectile/proj_impact.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/wunderwaffe/projectile/proj_loop.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.Jump", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo3/wunderwaffe/projectile/wpn_tesla_jump.wav",")")

TFA.AddSound ("TFA_BO3_WAFFE.Pop", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/wunderwaffe/death/pop.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.Sizzle", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/wunderwaffe/death/sizzle.wav",")")
TFA.AddSound ("TFA_BO3_WAFFE.Zap", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/wunderwaffe/death/big_00.wav", "weapons/tfa_bo3/wunderwaffe/death/big_01.wav"},")")
TFA.AddSound ("TFA_BO3_WAFFE.Bounce", CHAN_ITEM, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/wunderwaffe/bounce/bounce_00.wav", "weapons/tfa_bo3/wunderwaffe/bounce/bounce_01.wav"},")")
TFA.AddSound ("TFA_BO3_WAFFE.Death", CHAN_BODY, 0.5, SNDLVL_TALKING, {97,103}, {"zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_00.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_01.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_02.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_03.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_04.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_05.wav", "zmb/ai/standard/vox/death/dg2/zmb_dg2_death_soul_06.wav"},")")

-- Scavenger --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_SCAVENGER.Shoot", {"weapons/tfa_bo3/scavenger/scavenger_fire_loud.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_SCAVENGER.Flux", {"weapons/tfa_bo3/scavenger/scavenger_fire.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO3_SCAVENGER.Futz", "weapons/tfa_bo3/scavenger/fly_scavenger_futz.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.MagOut", "weapons/tfa_bo3/scavenger/fly_scavenger_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.MagIn", "weapons/tfa_bo3/scavenger/fly_scavenger_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BoltUp", "weapons/tfa_bo3/scavenger/fly_scavenger_bolt_up.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BoltBack", "weapons/tfa_bo3/scavenger/fly_scavenger_bolt_back.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BoltForward", "weapons/tfa_bo3/scavenger/fly_scavenger_bolt_forward.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BoltDown", "weapons/tfa_bo3/scavenger/fly_scavenger_bolt_down.wav")

TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BeepReload", "weapons/tfa_bo3/scavenger/fly_scavenger_beep_reload.wav")
TFA.AddWeaponSound("TFA_BO3_SCAVENGER.BeepBolt", "weapons/tfa_bo3/scavenger/fly_scavenger_beep_rechamber.wav")

TFA.AddFireSound("TFA_BO3_SCAVENGER.Explode", {"weapons/tfa_bo3/scavenger/scavenger_proj_explode.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_SCAVENGER.ExplodePAP", {"weapons/tfa_bo3/scavenger/scavenger_proj_explode_upg.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_SCAVENGER.RampUp", {"weapons/tfa_bo3/scavenger/scavenger_proj_rampup.wav"}, false, ")")

-- 31-79 JGb215 --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_JGB.Shoot", {"weapons/tfa_bo3/shrinkray/wpn_shrink_plr_f.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_JGB.Quad", {"weapons/tfa_bo3/shrinkray/wpn_shrink_plr_quad.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_JGB.Lfe", {"weapons/tfa_bo3/shrinkray/wpn_shrink_plr_lfe.wav"}, true, ")")

TFA.AddSound ("TFA_BO3_JGB.Flux", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/shrinkray/wpn_shrink_plr_flux.wav",")")
TFA.AddSound ("TFA_BO3_JGB.FluxUpg", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/shrinkray/wpn_shrink_plr_flux_upgr.wav",")")

TFA.AddWeaponSound("TFA_BO3_JGB.Futz", "weapons/tfa_bo3/shrinkray/wpn_shrink_futz.wav")
TFA.AddWeaponSound("TFA_BO3_JGB.MagOut", "weapons/tfa_bo3/shrinkray/wpn_shrink_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_JGB.MagIn", "weapons/tfa_bo3/shrinkray/wpn_shrink_mag_in.wav")

TFA.AddSound ("TFA_BO3_JGB.Fins", CHAN_ITEM, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/shrinkray/wpn_shrink_fins.wav",")")
TFA.AddSound ("TFA_BO3_JGB.Stop", CHAN_ITEM, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/shrinkray/empty.wav",")")

TFA.AddSound ("TFA_BO3_JGB.ZMB.Shrink", CHAN_STATIC, 0.5, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/shrinkray/evt_shrink.wav",")")
TFA.AddSound ("TFA_BO3_JGB.ZMB.UnShrink", CHAN_STATIC, 0.5, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/shrinkray/evt_unshrink.wav",")")
TFA.AddSound ("TFA_BO3_JGB.ZMB.Kick", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "zmb/mini/kicked/zmb_mini_kicked01.wav",")")
TFA.AddSound ("TFA_BO3_JGB.ZMB.Squish", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "zmb/mini/squashed/zmb_mini_squashed01.wav",")")

-- Skull Gun --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_SKULL.FireIn", {"weapons/tfa_bo3/skullgun/zmb_skullgun_start_plr.wav"}, true, ")")
sound.Add({name = "TFA_BO3_SKULL.FireLoop", channel = CHAN_WEAPON, volume = 0.5, level = SNDLVL_GUNFIRE, pitch = 100, sound = "weapons/tfa_bo3/skullgun/zmb_skullgun_loop_plr.wav"})
sound.Add({name = "TFA_BO3_SKULL.Flashlight", channel = CHAN_WEAPON, volume = 0.5, level = SNDLVL_GUNFIRE, pitch = 100, sound = "weapons/tfa_bo3/skullgun/zmb_skull_flashlight.wav"})
TFA.AddFireSound("TFA_BO3_SKULL.FireOut", {"weapons/tfa_bo3/skullgun/zmb_skullgun_stop_plr.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_SKULL.FirstDraw", "weapons/tfa_bo3/skullgun/fly_skull_first_raise_01.wav")
TFA.AddWeaponSound("TFA_BO3_SKULL.Raise", "weapons/tfa_bo3/skullgun/zmb_skullgun_raise.wav")

TFA.AddSound ("TFA_BO3_SKULL.Scream", CHAN_ITEM, 0.5, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/skullgun/skull_scream_00.wav", "weapons/tfa_bo3/skullgun/skull_scream_01.wav", "weapons/tfa_bo3/skullgun/skull_scream_02.wav", "weapons/tfa_bo3/skullgun/skull_scream_03.wav"},")")
TFA.AddSound ("TFA_BO3_SKULL.Breathe", CHAN_ITEM, 0.5, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/skullgun/skull_breathe_00.wav", "weapons/tfa_bo3/skullgun/skull_breathe_01.wav", "weapons/tfa_bo3/skullgun/skull_breathe_02.wav", "weapons/tfa_bo3/skullgun/skull_breathe_03.wav"},")")

-- KT-4 --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_MIRG.Shoot", {"weapons/tfa_bo3/mirg2000/wpn_gelgun_fire.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_MIRG.Shoot.Charge.1", {"weapons/tfa_bo3/mirg2000/mirg2k_01.wav", "weapons/tfa_bo3/mirg2000/mirg2k_02.wav", "weapons/tfa_bo3/mirg2000/mirg2k_03.wav", "weapons/tfa_bo3/mirg2000/mirg2k_04.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_MIRG.Shoot.Charge.2", {"weapons/tfa_bo3/mirg2000/mirg2k_chrg1_01.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg1_02.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg1_03.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg1_04.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_MIRG.Shoot.Charge.3", {"weapons/tfa_bo3/mirg2000/mirg2k_chrg2_01.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg2_02.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg2_03.wav", "weapons/tfa_bo3/mirg2000/mirg2k_chrg2_04.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO3_MIRG.MagOut", "weapons/tfa_bo3/mirg2000/fly_mirg_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_MIRG.MagIn", "weapons/tfa_bo3/mirg2000/fly_mirg_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_MIRG.Prime", "weapons/tfa_bo3/mirg2000/fly_mirg_prime.wav")
TFA.AddWeaponSound("TFA_BO3_MIRG.Rechamber", "weapons/tfa_bo3/mirg2000/fly_mirg_rechamber.wav")

TFA.AddSound ("TFA_BO3_MIRG.Charge1", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/mirg2000/wpn_hive_act_00.wav",")")
TFA.AddSound ("TFA_BO3_MIRG.Charge2", CHAN_STATIC, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/mirg2000/fly_lightning_first_flaps.wav",")")
TFA.AddSound ("TFA_BO3_MIRG.Charge3", CHAN_WEAPON, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/mirg2000/wpn_arrow_timer.wav",")")

TFA.AddSound ("TFA_BO3_MIRG.Start", CHAN_STATIC, 0.5, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/mirg2000/fly_mirg_start.wav"},")")
TFA.AddSound ("TFA_BO3_MIRG.Idle", CHAN_ITEM, 0.1, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/mirg2000/fly_mirg_idle.wav"},")")
TFA.AddSound ("TFA_BO3_MIRG.Stop", CHAN_ITEM, 0.5, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/mirg2000/fly_mirg_end_00.wav"},")")

TFA.AddSound ("TFA_BO3_MIRG.Slime", CHAN_STATIC, 0.05, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/ww_slime_charged_01.wav", "weapons/tfa_bo3/mirg2000/goo/ww_slime_charged_02.wav"},")")

TFA.AddSound ("TFA_BO3_MIRG.ImpactSwt", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/acid_sizzle_00.wav", "weapons/tfa_bo3/mirg2000/goo/acid_sizzle_01.wav", "weapons/tfa_bo3/mirg2000/goo/acid_sizzle_02.wav", "weapons/tfa_bo3/mirg2000/goo/acid_sizzle_03.wav", "weapons/tfa_bo3/mirg2000/goo/acid_sizzle_04.wav"},")")
TFA.AddSound ("TFA_BO3_MIRG.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/gooball_explo_empty_0.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_empty_1.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_empty_2.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_empty_3.wav"},")")

TFA.AddSound ("TFA_BO3_MIRG.Spore.Infect", CHAN_STATIC, 0.5, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/gooball_explo_full_0.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_full_1.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_full_2.wav", "weapons/tfa_bo3/mirg2000/goo/gooball_explo_full_3.wav"},")")
TFA.AddSound ("TFA_BO3_MIRG.Spore.Grow", CHAN_STATIC, 0.5, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/ww_spores_01.wav", "weapons/tfa_bo3/mirg2000/goo/ww_spores_02.wav", "weapons/tfa_bo3/mirg2000/goo/ww_spores_03.wav", "weapons/tfa_bo3/mirg2000/goo/ww_spores_04.wav", "weapons/tfa_bo3/mirg2000/goo/ww_spores_05.wav"},")")
TFA.AddSound ("TFA_BO3_MIRG.Spore.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/mirg2000/goo/zmb_spore_eject.wav"},")")

-- Ragnarok DG-4 --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_DG4.FirstDraw", "weapons/tfa_bo3/dg4/talon_1st_raise.wav")
TFA.AddWeaponSound("TFA_BO3_DG4.Draw", "weapons/tfa_bo3/dg4/talon_raise.wav")

TFA.AddWeaponSound("TFA_BO3_DG4.Melee", {"weapons/tfa_bo3/dg4/melee/spike_melee_00.wav", "weapons/tfa_bo3/dg4/melee/spike_melee_01.wav", "weapons/tfa_bo3/dg4/melee/spike_melee_02.wav", "weapons/tfa_bo3/dg4/melee/spike_melee_03.wav"})
TFA.AddWeaponSound("TFA_BO3_DG4.Activate", {"weapons/tfa_bo3/dg4/slam/sword_jump_00.wav", "weapons/tfa_bo3/dg4/slam/sword_jump_01.wav"})

TFA.AddSound ("TFA_BO3_DG4.Vortex.Start", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/dg4/vortex/talon_vortex_start.wav",")")
TFA.AddSound ("TFA_BO3_DG4.Vortex.Loop", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/dg4/vortex/talon_vortex_loop.wav",")")
TFA.AddSound ("TFA_BO3_DG4.Vortex.End", CHAN_ITEM, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/dg4/vortex/talon_vortex_end.wav",")")

TFA.AddSound ("TFA_BO3_DG4.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/dg4/slam/sword_spark_explode_00.wav", "weapons/tfa_bo3/dg4/slam/sword_spark_explode_01.wav"},")")
TFA.AddSound ("TFA_BO3_DG4.Strike", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/dg4/slam/sword_ground_strike_00.wav", "weapons/tfa_bo3/dg4/slam/sword_ground_strike_01.wav"},")")
TFA.AddSound ("TFA_BO3_DG4.Shockwave", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/dg4/slam/wpn_gravity_shockwave.wav",")")
TFA.AddSound ("TFA_BO3_DG4.Hit", CHAN_STATIC, 0.5, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/dg4/slam/wpn_gravity_hit_00.wav",")")
TFA.AddSound ("TFA_BO3_DG4.EMP", CHAN_BODY, 0.2, SNDLVL_GUNFIRE, {90,110}, {"weapons/tfa_bo3/dg4/slam/emp_exp_dist_00.wav", "weapons/tfa_bo3/dg4/slam/emp_exp_dist_01.wav", "weapons/tfa_bo3/dg4/slam/emp_exp_dist_02.wav", "weapons/tfa_bo3/dg4/slam/emp_exp_dist_03.wav"},")")
TFA.AddSound ("TFA_BO3_DG4.Dist", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/dg4/slam/concussion_dist_00.wav", "weapons/tfa_bo3/dg4/slam/concussion_dist_01.wav", "weapons/tfa_bo3/dg4/slam/concussion_dist_02.wav"},")")

TFA.AddSound ("TFA_BO3_DG4.Idle", CHAN_WEAPON, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/dg4/talon_spike_loop_idle.wav",")")

-- Wrath of the Ancients --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_ZMBBOW.Fire", {"weapons/tfa_bo3/zmbbow/base_bow_fire_00.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_01.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_02.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_03.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_04.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_05.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_06.wav", "weapons/tfa_bo3/zmbbow/base_bow_fire_07.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_ZMBBOW.FullCharge", "weapons/tfa_bo3/zmbbow/bow_fire_full_00.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_ZMBBOW.Draw", "weapons/tfa_bo3/zmbbow/zm_bow_first_raise.wav")
TFA.AddWeaponSound("TFA_BO3_ZMBBOW.Reload", "weapons/tfa_bo3/zmbbow/arrow_load.wav")

TFA.AddSound ("TFA_BO3_ZMBBOW.PullBack", CHAN_ITEM, 1, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/zmbbow/base_bow_pullback_00.wav", "weapons/tfa_bo3/zmbbow/base_bow_pullback_01.wav"},")")
TFA.AddSound ("TFA_BO3_ZMBBOW.DrawLoop", CHAN_WEAPON, 0.1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/zmbbow/bowlauncher_loop_stretch.wav",")")
TFA.AddSound ("TFA_BO3_ZMBBOW.Cancel", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/zmbbow/base_bow_cancel_00.wav",")")

TFA.AddSound ("TFA_BO3_ZMBBOW.ExplodeSwt", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {90,110}, {"weapons/tfa_bo3/zmbbow/bow_exp_basic_0.wav", "weapons/tfa_bo3/zmbbow/bow_exp_basic_1.wav", "weapons/tfa_bo3/zmbbow/bow_exp_basic_2.wav"},")")
TFA.AddSound ("TFA_BO3_ZMBBOW.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/zmbbow/proj_explo_00.wav", "weapons/tfa_bo3/zmbbow/proj_explo_01.wav", "weapons/tfa_bo3/zmbbow/proj_explo_02.wav"},")")
TFA.AddSound ("TFA_BO3_ZMBBOW.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/zmbbow/upgraded_imp.wav", "weapons/tfa_bo3/zmbbow/proj_explo_01.wav", "weapons/tfa_bo3/zmbbow/proj_explo_02.wav"},")")

-- Lil' Arnie --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_ARNIE.JarScream", {"weapons/tfa_bo3/lilarnie/viewarm_arnie_00.wav", "weapons/tfa_bo3/lilarnie/viewarm_arnie_01.wav", "weapons/tfa_bo3/lilarnie/viewarm_arnie_02.wav", "weapons/tfa_bo3/lilarnie/viewarm_arnie_03.wav"})
TFA.AddWeaponSound("TFA_BO3_ARNIE.JarRaise", "weapons/tfa_bo3/lilarnie/viewarm_bottle_raise.wav")
TFA.AddWeaponSound("TFA_BO3_ARNIE.JarShake", "weapons/tfa_bo3/lilarnie/viewarm_bottle_shake.wav")
TFA.AddWeaponSound("TFA_BO3_ARNIE.JarBounce", {"weapons/tfa_bo3/lilarnie/octo_bounce_00.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_01.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_02.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_03.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_04.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_05.wav", "weapons/tfa_bo3/lilarnie/octo_bounce_06.wav"})

TFA.AddSound ("TFA_BO3_ARNIE.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/lilarnie/arnie_lp_0.wav", "weapons/tfa_bo3/lilarnie/arnie_lp_1.wav"},")")

TFA.AddSound ("TFA_BO3_ARNIE.DeathThroes", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/lilarnie/arnie_death_throes.wav",")")

TFA.AddSound ("TFA_BO3_ARNIE.DeathVox", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/lilarnie/death_vox_00.wav", "weapons/tfa_bo3/lilarnie/death_vox_01.wav"},")")

TFA.AddSound ("TFA_BO3_ARNIE.OctoFlail", CHAN_ITEM, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/lilarnie/octobomb_flail.wav",")")
TFA.AddSound ("TFA_BO3_ARNIE.OctoEnd", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/lilarnie/octobomb_end.wav",")")
TFA.AddSound ("TFA_BO3_ARNIE.OctoExpl", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/lilarnie/octobomb_explode.wav",")")

TFA.AddSound ("TFA_BO3_ARNIE.ZombieDie", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_00.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_01.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_02.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_03.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_04.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_05.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_06.wav", "weapons/tfa_bo3/lilarnie/zombie_imp/zombie_imp_07.wav"},")")

TFA.AddSound ("TFA_BO3_ARNIE.AttackVox", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_00.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_01.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_02.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_03.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_04.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_05.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_06.wav", "weapons/tfa_bo3/lilarnie/attack_vox/attack_vox_07.wav"},")")

TFA.AddSound ("TFA_BO3_ARNIE.AcidSizzle", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo3/lilarnie/acid_sizzle/acid_sizzle_00.wav", "weapons/tfa_bo3/lilarnie/acid_sizzle/acid_sizzle_01.wav", "weapons/tfa_bo3/lilarnie/acid_sizzle/acid_sizzle_02.wav", "weapons/tfa_bo3/lilarnie/acid_sizzle/acid_sizzle_03.wav", "weapons/tfa_bo3/lilarnie/acid_sizzle/acid_sizzle_04.wav"},")")

-- Monkey Bomb --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_MNKEY.Upgrade", "weapons/tfa_bo3/monkeybomb/monkey_kill_confirm.wav", true, ")")

TFA.AddSound ("TFA_BO3_MNKEY.Song", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/monkeybomb/monkey_song_00.wav", "weapons/tfa_bo3/monkeybomb/monkey_song_01.wav", "weapons/tfa_bo3/monkeybomb/monkey_song_02.wav"},")")
TFA.AddSound ("TFA_BO3_MNKEY.Upg.Song", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/monkeybomb/wpn_dubstep_monkey_00.wav",")")

TFA.AddWeaponSound("TFA_BO3_MNKEY.Ratchet", "weapons/tfa_bo3/monkeybomb/monkey_ratchet.wav")
TFA.AddWeaponSound("TFA_BO3_MNKEY.Cymbl", "weapons/tfa_bo3/monkeybomb/monk_cymb_st.wav")
TFA.AddWeaponSound("TFA_BO3_MNKEY.VOX.Prime", {"weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_00.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_01.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_02.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_03.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_04.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_05.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_06.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_07.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_08.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_09.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_10.wav", "weapons/tfa_bo3/monkeybomb/voice_prime/raise_vox_11.wav"})
TFA.AddWeaponSound("TFA_BO3_MNKEY.VOX.Upg.Prime", {"weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_00.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_01.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_02.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_03.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_04.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_prime/raise_vox_05.wav"})

TFA.AddSound ("TFA_BO3_MNKEY.VOX.Bounce", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo3/monkeybomb/voice_bounce/land_00.wav", "weapons/tfa_bo3/monkeybomb/voice_bounce/land_01.wav", "weapons/tfa_bo3/monkeybomb/voice_bounce/land_02.wav", "weapons/tfa_bo3/monkeybomb/voice_bounce/land_03.wav"},")")
TFA.AddSound ("TFA_BO3_MNKEY.VOX.Scream", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/monkeybomb/monkey_scream_vox_00.wav",")")

TFA.AddSound ("TFA_BO3_MNKEY.VOX.Throw", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo3/monkeybomb/voice_throw/throw_00.wav", "weapons/tfa_bo3/monkeybomb/voice_throw/throw_01.wav", "weapons/tfa_bo3/monkeybomb/voice_throw/throw_02.wav", "weapons/tfa_bo3/monkeybomb/voice_throw/throw_03.wav"},")")
TFA.AddSound ("TFA_BO3_MNKEY.VOX.Upg.Throw", CHAN_STATIC, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo3/monkeybomb/upgraded_voice_throw/throw_00.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_throw/throw_01.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_throw/throw_02.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_throw/throw_03.wav"},")")

TFA.AddSound ("TFA_BO3_MNKEY.VOX.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_00.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_01.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_02.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_03.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_04.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_05.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_06.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_07.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_08.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_09.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_10.wav", "weapons/tfa_bo3/monkeybomb/voice_explosion/explo_vox_11.wav"},")")
TFA.AddSound ("TFA_BO3_MNKEY.VOX.Upg.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_00.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_01.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_02.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_03.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_04.wav", "weapons/tfa_bo3/monkeybomb/upgraded_voice_explosion/explo_vox_05.wav"},")")

-- Q.E.D. --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_QED.KN44.Fire", "weapons/tfa_bo3/qed/wep/wpn_ar_standard_fire.wav", false, ")")
TFA.AddFireSound("TFA_BO3_QED.HMKR.Fire", "weapons/tfa_bo3/qed/wep/wpn_full_auto_fire.wav", false, ")")
TFA.AddFireSound("TFA_BO3_QED.MAXGL.Fire", "weapons/tfa_bo3/qed/wep/wpn_china_lake_fire.wav", false, ")")

TFA.AddFireSound("TFA_BO3_QED.NukeFlux", "weapons/tfa_bo3/qed/drop/pv_powerup_nuke_exp_flux.wav", false, ")")

TFA.AddWeaponSound("TFA_BO3_QED.Plunge", "weapons/tfa_bo3/qed/quantum_plunge.wav")
TFA.AddWeaponSound("TFA_BO3_QED.Twist", "weapons/tfa_bo3/qed/quantum_twist_a.wav")
TFA.AddWeaponSound("TFA_BO3_QED.TeleFX", "weapons/tfa_bo3/qed/beam_fx.wav")
TFA.AddWeaponSound("TFA_BO3_QED.Flare", {"weapons/tfa_bo3/qed/flare/wpn_incindiary_flare_00.wav", "weapons/tfa_bo3/qed/flare/wpn_incindiary_flare_01.wav", "weapons/tfa_bo3/qed/flare/wpn_incindiary_flare_02.wav", "weapons/tfa_bo3/qed/flare/wpn_incindiary_flare_03.wav", "weapons/tfa_bo3/qed/flare/wpn_incindiary_flare_04.wav"})

TFA.AddSound ("TFA_BO3_QED.Bounce.Earth", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/qed/bounce/concussion_bounce_earth_00.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_earth_01.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_earth_02.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_earth_03.wav"},")")
TFA.AddSound ("TFA_BO3_QED.Bounce.Metal", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/qed/bounce/concussion_bounce_metal_00.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_metal_01.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_metal_02.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_metal_03.wav"},")")
TFA.AddSound ("TFA_BO3_QED.Bounce.Wood", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/qed/bounce/concussion_bounce_wood_00.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_wood_01.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_wood_02.wav", "weapons/tfa_bo3/qed/bounce/concussion_bounce_wood_03.wav"},")")

TFA.AddSound ("TFA_BO3_QED.Think", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/qed/evt_qed_think_loop.wav",")")
TFA.AddSound ("TFA_BO3_QED.Poof", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo3/qed/evt_qed_poof.wav",")")

TFA.AddSound ("TFA_BO3_QED.MaxAmmo", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/qed/drop/max_ammo_00.wav",")")
TFA.AddSound ("TFA_BO3_QED.Pickup", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/qed/drop/pv_powerup_grab.wav",")")

TFA.AddSound ("TFA_BO3_QED.AstroPop", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/qed/evt_astro_pop.wav",")")
TFA.AddSound ("TFA_BO3_QED.Teleport", CHAN_STATIC, 1, SNDLVL_IDLE, {95,105}, "weapons/tfa_bo3/qed/gersh_teleport.wav",")")
TFA.AddSound ("TFA_BO3_QED.Anime", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/qed/teleports.wav",")")

TFA.AddSound ("TFA_BO3_QED.DropGrab", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/qed/drop/grab.wav",")")
TFA.AddSound ("TFA_BO3_QED.DropLoop", CHAN_STATIC, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/qed/drop/loop.wav",")")
TFA.AddSound ("TFA_BO3_QED.DropSpawn", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/qed/drop/spawn.wav",")")

-- Grenade --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_GRENADE.Bounce", {"weapons/tfa_bo3/grenade/earth_00.wav", "weapons/tfa_bo3/grenade/earth_01.wav", "weapons/tfa_bo3/grenade/earth_02.wav", "weapons/tfa_bo3/grenade/earth_03.wav", "weapons/tfa_bo3/grenade/earth_04.wav"})
TFA.AddWeaponSound("TFA_BO3_GRENADE.Throw", "weapons/tfa_bo3/grenade/gren_throw.wav")
TFA.AddWeaponSound("TFA_BO3_GRENADE.Pin", "weapons/tfa_bo3/grenade/grenade_pull_pin.wav")

TFA.AddSound ("TFA_BO3_GRENADE.Dist", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/grenade/exp_grenade_dist_00.wav", "weapons/tfa_bo3/grenade/exp_grenade_dist_01.wav", "weapons/tfa_bo3/grenade/exp_grenade_dist_02.wav"},")")
TFA.AddSound ("TFA_BO3_GRENADE.Exp", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/grenade/explode_00.wav", "weapons/tfa_bo3/grenade/explode_01.wav", "weapons/tfa_bo3/grenade/explode_02.wav"},")")
TFA.AddSound ("TFA_BO3_GRENADE.ExpClose", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/grenade/explode_close_00.wav", "weapons/tfa_bo3/grenade/explode_close_01.wav", "weapons/tfa_bo3/grenade/explode_close_02.wav"},")")
TFA.AddSound ("TFA_BO3_GRENADE.Flux", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo3/grenade/flux_00.wav",")")
TFA.AddSound ("TFA_BO3_GRENADE.Snow", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/grenade/snow_00.wav", "weapons/tfa_bo3/grenade/snow_01.wav", "weapons/tfa_bo3/grenade/snow_02.wav"},")")

TFA.AddSound ("TFA_BO3_SPIDERNADE.Stick", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/grenade/stick_00.wav",")")
TFA.AddSound ("TFA_BO3_SPIDERNADE.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/grenade/gooball_explo_full_0.wav", "weapons/tfa_bo3/grenade/gooball_explo_full_1.wav", "weapons/tfa_bo3/grenade/gooball_explo_full_2.wav", "weapons/tfa_bo3/grenade/gooball_explo_full_3.wav"},")")
TFA.AddSound ("TFA_BO3_SPIDERNADE.Loop", CHAN_WEAPON, 1, SNDLVL_NORM, {97,103}, "weapons/tfa_bo3/grenade/ww_cocoon_lp.wav",")")
TFA.AddSound ("TFA_BO3_SPIDERNADE.End", CHAN_WEAPON, 0.5, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/grenade/ww_entity_imp_00.wav", "weapons/tfa_bo3/grenade/ww_entity_imp_01.wav", "weapons/tfa_bo3/grenade/ww_entity_imp_02.wav", "weapons/tfa_bo3/grenade/ww_entity_imp_03.wav"},")")

-- Gersch Device --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_GERSCH.Raise", "weapons/tfa_bo3/gersch/raise.wav")
TFA.AddWeaponSound("TFA_BO3_GERSCH.FlipDown", "weapons/tfa_bo3/gersch/flipdown.wav")
TFA.AddWeaponSound("TFA_BO3_GERSCH.Switch", "weapons/tfa_bo3/gersch/switch.wav")
TFA.AddWeaponSound("TFA_BO3_GERSCH.Throw", "weapons/tfa_bo3/gersch/throw.wav")
TFA.AddWeaponSound("TFA_BO3_GERSCH.Bounce", {"weapons/tfa_bo3/gersch/bounce_00.wav", "weapons/tfa_bo3/gersch/bounce_01.wav", "weapons/tfa_bo3/gersch/bounce_02.wav", "weapons/tfa_bo3/gersch/bounce_03.wav"})

TFA.AddSound ("TFA_BO3_GERSCH.BHStart", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gersch/bhbomb_start.wav",")")
TFA.AddSound ("TFA_BO3_GERSCH.BHPrePop", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gersch/bhbomb_prepop.wav",")")
TFA.AddSound ("TFA_BO3_GERSCH.BHPop", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gersch/bhbomb_pop.wav",")")

TFA.AddSound ("TFA_BO3_GERSCH.BHLoopClose", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/gersch/close_lp.wav",")")
TFA.AddSound ("TFA_BO3_GERSCH.BHLoopFar", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gersch/far_lp.wav",")")

TFA.AddSound ("TFA_BO3_GERSCH.Teleport", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/gersch/gersh_teleport.wav",")")
TFA.AddSound ("TFA_BO3_GERSCH.TeleOut", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo3/gersch/gersh_teleport_out.wav",")")

TFA.AddSound ("TFA_BO3_GERSCH.Suck", CHAN_STATIC, 1, SNDLVL_NORM, {97,103}, {"weapons/tfa_bo3/gersch/wpn_gersh_zombie_suck_00.wav", "weapons/tfa_bo3/gersch/wpn_gersh_zombie_suck_01.wav"},")")

-- Матрешка (idk how to type accent marks with my russian keyboard) --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_DOLL.Draw", "weapons/tfa_bo3/matryoshka/open_struggle_st.wav")
TFA.AddWeaponSound("TFA_BO3_DOLL.Open", "weapons/tfa_bo3/matryoshka/open.wav")
TFA.AddWeaponSound("TFA_BO3_DOLL.Pop", {"weapons/tfa_bo3/matryoshka/pop_00.wav", "weapons/tfa_bo3/matryoshka/pop_01.wav", "weapons/tfa_bo3/matryoshka/pop_02.wav"})

TFA.AddWeaponSound("TFA_BO3_DOLL.Bounce", {"weapons/tfa_bo3/matryoshka/bounce_00.wav", "weapons/tfa_bo3/matryoshka/bounce_01.wav", "weapons/tfa_bo3/matryoshka/bounce_02.wav", "weapons/tfa_bo3/matryoshka/bounce_03.wav", "weapons/tfa_bo3/matryoshka/bounce_04.wav", "weapons/tfa_bo3/matryoshka/bounce_05.wav", "weapons/tfa_bo3/matryoshka/bounce_06.wav"})

-- G-Strike --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_GSTRIKE.Launch", "weapons/tfa_bo3/gstrike/wpn_mortar_launch.wav", true, ")")
TFA.AddWeaponSound("TFA_BO3_GSTRIKE.Pin", "weapons/tfa_bo3/gstrike/beacon_pin.wav")
TFA.AddWeaponSound("TFA_BO3_GSTRIKE.Bounce", {"weapons/tfa_bo3/gstrike/bot_bodyfall_01.wav", "weapons/tfa_bo3/gstrike/bot_bodyfall_02.wav", "weapons/tfa_bo3/gstrike/bot_bodyfall_03.wav", "weapons/tfa_bo3/gstrike/bot_bodyfall_04.wav"})

TFA.AddSound ("TFA_BO3_GSTRIKE.Beep", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/gstrike/beacon_beep.wav",")")
TFA.AddSound ("TFA_BO3_GSTRIKE.Alarm", CHAN_ITEM, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/gstrike/robot_alarm.wav",")")
TFA.AddSound ("TFA_BO3_GSTRIKE.Incoming", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/gstrike/incoming_00.wav", "weapons/tfa_bo3/gstrike/incoming_01.wav", "weapons/tfa_bo3/gstrike/incoming_02.wav", "weapons/tfa_bo3/gstrike/incoming_03.wav"},"^")

TFA.AddSound ("TFA_BO3_GSTRIKE.Exp", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/gstrike/exp_shell_nodebris_01.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_02.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_03.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_04.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_05.wav"},")")
TFA.AddSound ("TFA_BO3_GSTRIKE.Exp.Debris", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo3/gstrike/exp_shell_nodebris_01.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_02.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_03.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_04.wav", "weapons/tfa_bo3/gstrike/exp_shell_nodebris_05.wav"},")")

-- GKz-45 MK-3 --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_GKZ.Shoot", "weapons/tfa_bo3/gkzmk3/wpn_mk3_lh_fire.wav", true, ")")
TFA.AddFireSound("TFA_BO3_GKZ.Act", "weapons/tfa_bo3/gkzmk3/wpn_mk3_lh_act.wav", true, ")")

TFA.AddFireSound("TFA_BO3_MK3.Shoot", "weapons/tfa_bo3/gkzmk3/wpn_mk3_rh_fire.wav", true, ")")
TFA.AddFireSound("TFA_BO3_MK3.Act", "weapons/tfa_bo3/gkzmk3/wpn_mk3_rh_act.wav", true, ")")
TFA.AddFireSound("TFA_BO3_MK3.Decay", "weapons/tfa_bo3/gkzmk3/wpn_mk3_rh_fire_decay.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_MK3.First", "weapons/tfa_bo3/gkzmk3/fly_mkiii_reload_rh_first.wav")
TFA.AddWeaponSound("TFA_BO3_MK3.Reload", "weapons/tfa_bo3/gkzmk3/fly_mkiii_reload.wav")
TFA.AddWeaponSound("TFA_BO3_GKZ.First", "weapons/tfa_bo3/gkzmk3/fly_mkiii_reload_lh_first.wav")
TFA.AddWeaponSound("TFA_BO3_GKZ.Reload", "weapons/tfa_bo3/gkzmk3/fly_mkiii_reload_lh_00.wav")

TFA.AddWeaponSound("TFA_BO3_MK3.Reload_Start", "weapons/tfa_bo3/gkzmk3/reload_start.wav")
TFA.AddWeaponSound("TFA_BO3_MK3.Reload_End", "weapons/tfa_bo3/gkzmk3/reload_end.wav")
TFA.AddWeaponSound("TFA_BO3_MK3.Charge", "weapons/tfa_bo3/gkzmk3/charge.wav")

TFA.AddWeaponSound("TFA_BO3_GKZ.Gears", "weapons/tfa_bo3/gkzmk3/fly_mkiii_reload_lh_gears.wav")

TFA.AddSound ("TFA_BO3_GKZMK3.Orb.End", CHAN_WEAPON, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/gkzmk3/wpn_mk3_orb_disappear.wav",")")
TFA.AddSound ("TFA_BO3_GKZMK3.Orb.Loop", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gkzmk3/wpn_mk3_orb_loop.wav",")")
TFA.AddSound ("TFA_BO3_GKZMK3.Orb.Loop2", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/gkzmk3/wpn_mk3_orb_activated_loop.wav",")")
TFA.AddSound ("TFA_BO3_GKZMK3.Orb.Start", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/gkzmk3/wpn_mk3_orb_creation_00.wav",")")

TFA.AddSound ("TFA_BO3_GKZMK3.Orb.Damage", CHAN_AUTO, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo3/gkzmk3/wpn_orb_damage_00.wav", "weapons/tfa_bo3/gkzmk3/wpn_orb_damage_01.wav", "weapons/tfa_bo3/gkzmk3/wpn_orb_damage_02.wav", "weapons/tfa_bo3/gkzmk3/wpn_orb_damage_03.wav"},")")

-- Zap Guns / Wavegun --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_ZAPGUN.Shoot", "weapons/tfa_bo3/zapgun/microwave_shot.wav", true, ")")
TFA.AddSound ("TFA_BO3_ZAPGUN.ShootRear", CHAN_STATIC, 0.4, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/zapgun/microwave_shot_rear.wav",")")

TFA.AddFireSound("TFA_BO3_WAVEGUN.Shoot", "weapons/tfa_bo3/zapgun/microwave_rifle_shot.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.LeftStart", "weapons/tfa_bo3/zapgun/wpn_micro_rld_left_start.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.LeftMagIn", "weapons/tfa_bo3/zapgun/wpn_micro_rld_left_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.LeftEnd", "weapons/tfa_bo3/zapgun/wpn_micro_rld_left_end.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.RightStart", "weapons/tfa_bo3/zapgun/wpn_micro_rld_right_start.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.RightMagIn", "weapons/tfa_bo3/zapgun/wpn_micro_rld_right_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Reload.RightEnd", "weapons/tfa_bo3/zapgun/wpn_micro_rld_right_end.wav")

TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Join", "weapons/tfa_bo3/zapgun/wpn_micro_rld_join.wav")
TFA.AddWeaponSound("TFA_BO3_ZAPGUN.Seperate", "weapons/tfa_bo3/zapgun/wpn_micro_rld_separate.wav")

TFA.AddWeaponSound("TFA_BO3_WAVEGUN.RifleStart", "weapons/tfa_bo3/zapgun/wpn_micro_rld_rifle_start.wav")
TFA.AddWeaponSound("TFA_BO3_WAVEGUN.RifleMagOut", "weapons/tfa_bo3/zapgun/wpn_micro_rld_rifle_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_WAVEGUN.RifleMagIn", "weapons/tfa_bo3/zapgun/wpn_micro_rld_rifle_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_WAVEGUN.RifleFutz", "weapons/tfa_bo3/zapgun/wpn_micro_rld_rifle_futz.wav")
TFA.AddWeaponSound("TFA_BO3_WAVEGUN.RiflePower", "weapons/tfa_bo3/zapgun/wpn_micro_rld_rifle_power_up.wav")

TFA.AddSound ("TFA_BO3_WAVEGUN.Microwave.Ding", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/zapgun/microwave_ding.wav",")")
TFA.AddSound ("TFA_BO3_WAVEGUN.Microwave.Cook", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo3/zapgun/microwave_cooking.wav",")")
TFA.AddSound ("TFA_BO3_ZAPGUN.Flux", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo3/zapgun/microwave_flux.wav",")")

-- Apothicon Sword --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_ZODSWORD.Swing", {"weapons/tfa_bo3/zodsword/swing_1_00.wav", "weapons/tfa_bo3/zodsword/swing_1_01.wav", "weapons/tfa_bo3/zodsword/swing_1_02.wav", "weapons/tfa_bo3/zodsword/swing_2_00.wav", "weapons/tfa_bo3/zodsword/swing_2_01.wav", "weapons/tfa_bo3/zodsword/swing_2_02.wav"})
TFA.AddWeaponSound("TFA_BO3_ZODSWORD.SwingFoly", {"weapons/tfa_bo3/zodsword/swing_foley_1_00.wav", "weapons/tfa_bo3/zodsword/swing_foley_1_01.wav"})

TFA.AddWeaponSound("TFA_BO3_ZODSWORD.GroundStrike", {"weapons/tfa_bo3/zodsword/sword_ground_strike_00.wav", "weapons/tfa_bo3/zodsword/sword_ground_strike_01.wav"})
TFA.AddWeaponSound("TFA_BO3_ZODSWORD.SparkExplode", {"weapons/tfa_bo3/zodsword/sword_spark_explode_00.wav", "weapons/tfa_bo3/zodsword/sword_spark_explode_01.wav"})
TFA.AddWeaponSound("TFA_BO3_ZODSWORD.Jump", {"weapons/tfa_bo3/zodsword/sword_jump_00.wav", "weapons/tfa_bo3/zodsword/sword_jump_01.wav"})

TFA.AddWeaponSound("TFA_BO3_ZODSWORD.Raise", "weapons/tfa_bo3/zodsword/sword_raise.wav")
TFA.AddWeaponSound("TFA_BO3_ZODSWORD.Throw", "weapons/tfa_bo3/zodsword/sword_throw.wav")

TFA.AddWeaponSound("TFA_BO3_ZODSWORD.Impact", {"weapons/tfa_bo3/zodsword/sword2_imp_00.wav", "weapons/tfa_bo3/zodsword/sword2_imp_01.wav", "weapons/tfa_bo3/zodsword/sword2_imp_02.wav", "weapons/tfa_bo3/zodsword/sword2_imp_03.wav", "weapons/tfa_bo3/zodsword/sword2_imp_04.wav", "weapons/tfa_bo3/zodsword/sword2_imp_05.wav", "weapons/tfa_bo3/zodsword/sword2_imp_06.wav", "weapons/tfa_bo3/zodsword/sword2_imp_07.wav"})

-- Keeper Sword --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_KPRSWORD.Swing", {"weapons/tfa_bo3/keepersword/hyperswing_1_00.wav", "weapons/tfa_bo3/keepersword/hyperswing_1_01.wav", "weapons/tfa_bo3/keepersword/hyperswing_1_02.wav", "weapons/tfa_bo3/keepersword/hyperswing_2_00.wav", "weapons/tfa_bo3/keepersword/hyperswing_2_01.wav", "weapons/tfa_bo3/keepersword/hyperswing_2_02.wav"})

TFA.AddSound ("TFA_BO3_KPRSWORD.Loop", CHAN_WEAPON, 0.4, SNDLVL_TALKING, 100, "weapons/tfa_bo3/keepersword/sword_looper_close.wav",")")
TFA.AddSound ("TFA_BO3_KPRSWORD.Idle", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/keepersword/sword_loop_idle_lv2.wav",")")

TFA.AddWeaponSound("TFA_BO3_KPRSWORD.Throw", "weapons/tfa_bo3/keepersword/sword_throw.wav")
TFA.AddWeaponSound("TFA_BO3_KPRSWORD.Return", "weapons/tfa_bo3/keepersword/sword2_return_01.wav")
TFA.AddWeaponSound("TFA_BO3_KPRSWORD.Full", "weapons/tfa_bo3/keepersword/sword_meter_full.wav")

-- Gauntlet of Siegfried --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_GAUNTLET.ShootIn", "weapons/tfa_bo3/gauntlet/wpn_dragon_gauntlet_start.wav", true, ")")
TFA.AddFireSound("TFA_BO3_GAUNTLET.ShootLoop", "weapons/tfa_bo3/gauntlet/wpn_dragon_gauntlet_loop.wav", false, ")")
TFA.AddFireSound("TFA_BO3_GAUNTLET.ShootOut", "weapons/tfa_bo3/gauntlet/wpn_dragon_gauntlet_stop.wav", false, ")")

TFA.AddWeaponSound("TFA_BO3_GAUNTLET.ShootShort", {"weapons/tfa_bo3/gauntlet/dragon_gaunt_fire_short_00.wav", "weapons/tfa_bo3/gauntlet/dragon_gaunt_fire_short_01.wav", "weapons/tfa_bo3/gauntlet/dragon_gaunt_fire_short_02.wav", "weapons/tfa_bo3/gauntlet/dragon_gaunt_fire_short_03.wav"})

TFA.AddWeaponSound("TFA_BO3_GAUNTLET.Hit", {"weapons/tfa_bo3/gauntlet/fist_00.wav", "weapons/tfa_bo3/gauntlet/fist_01.wav", "weapons/tfa_bo3/gauntlet/fist_02.wav"})

TFA.AddWeaponSound("TFA_BO3_GAUNTLET.Attach", "weapons/tfa_bo3/gauntlet/fly_gaunt_attach.wav")
TFA.AddWeaponSound("TFA_BO3_GAUNTLET.Scream", {"weapons/tfa_bo3/gauntlet/fly_gaunt_scream_1.wav", "weapons/tfa_bo3/gauntlet/fly_gaunt_scream_2.wav", "weapons/tfa_bo3/gauntlet/fly_gaunt_scream_3.wav", "weapons/tfa_bo3/gauntlet/fly_gaunt_scream_4.wav", "weapons/tfa_bo3/gauntlet/fly_gaunt_scream_5.wav"})
TFA.AddWeaponSound("TFA_BO3_GAUNTLET.Shake", "weapons/tfa_bo3/gauntlet/fly_gaunt_shake.wav")
TFA.AddWeaponSound("TFA_BO3_GAUNTLET.Poof", {"weapons/tfa_bo3/gauntlet/wpn_gaunt_poof_00.wav", "weapons/tfa_bo3/gauntlet/wpn_gaunt_poof_01.wav"})

-- Annihilator --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_ANNIHILATOR.Shoot", "weapons/tfa_bo3/annihilator/wpn_annihilator_fire.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_ANNIHILATOR.Rechamber", "weapons/tfa_bo3/annihilator/fly_anni_rechamber_02.wav")
TFA.AddWeaponSound("TFA_BO3_ANNIHILATOR.RechamberADS", "weapons/tfa_bo3/annihilator/fly_anni_rechamber_ads_01.wav")
TFA.AddWeaponSound("TFA_BO3_ANNIHILATOR.Raise", "weapons/tfa_bo3/annihilator/annihilator_first_raise.wav")

TFA.AddFireSound("TFA_BO3_ANNIHILATOR.Gib", {"weapons/tfa_bo3/annihilator/margwa_head_explo_0.wav", "weapons/tfa_bo3/annihilator/margwa_head_explo_1.wav", "weapons/tfa_bo3/annihilator/margwa_head_explo_2.wav", "weapons/tfa_bo3/annihilator/margwa_head_explo_3.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_ANNIHILATOR.Lfe", {"weapons/tfa_bo3/annihilator/lfe_sweep_hit_01.wav", "weapons/tfa_bo3/annihilator/lfe_sweep_hit_02.wav", "weapons/tfa_bo3/annihilator/lfe_sweep_hit_03.wav", "weapons/tfa_bo3/annihilator/lfe_sweep_hit_04.wav", "weapons/tfa_bo3/annihilator/lfe_sweep_hit_05.wav", "weapons/tfa_bo3/annihilator/lfe_sweep_hit_06.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_ANNIHILATOR.Exp", "weapons/tfa_bo3/annihilator/exp_explosion_decay_00.wav", true, ")")

-- Storm Bow --------------------------------------------------------------------------------------------------------
TFA.AddSound ("TFA_BO3_STORMBOW.DrawLoop", CHAN_WEAPON, 0.25, SNDLVL_IDLE, 100, "weapons/tfa_bo3/stormbow/wpn_bow_storm_draw_loop.wav",")")

TFA.AddSound ("TFA_BO3_STORMBOW.Explode", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/stormbow/wpn_lightning_ball_explo.wav",")")
TFA.AddSound ("TFA_BO3_STORMBOW.Lightning", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/stormbow/lightning_flash_00.wav", "weapons/tfa_bo3/stormbow/lightning_flash_01.wav", "weapons/tfa_bo3/stormbow/lightning_flash_02.wav"},")")
TFA.AddSound ("TFA_BO3_STORMBOW.Arc", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/stormbow/arc_00.wav", "weapons/tfa_bo3/stormbow/arc_01.wav", "weapons/tfa_bo3/stormbow/arc_02.wav", "weapons/tfa_bo3/stormbow/arc_03.wav", "weapons/tfa_bo3/stormbow/arc_04.wav", "weapons/tfa_bo3/stormbow/arc_05.wav"},")")

TFA.AddSound ("TFA_BO3_STORMBOW.BallLoop", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/stormbow/lightning_ball_01.wav",")")
TFA.AddSound ("TFA_BO3_STORMBOW.TornadoLoop", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/stormbow/pfx_stormbow_tornado.wav",")")
TFA.AddSound ("TFA_BO3_STORMBOW.ArrowLoop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/stormbow/pfx_stormbow_arrowhead.wav",")")

-- Rune Bow --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_RUNEBOW.Shoot", {"weapons/tfa_bo3/runebow/rune_bow_fire_01.wav", "weapons/tfa_bo3/runebow/rune_bow_fire_02.wav", "weapons/tfa_bo3/runebow/rune_bow_fire_03.wav", "weapons/tfa_bo3/runebow/rune_bow_fire_04.wav", "weapons/tfa_bo3/runebow/rune_bow_fire_05.wav"}, true, ")")

TFA.AddSound ("TFA_BO3_RUNEBOW.DrawLoop", CHAN_WEAPON, 0.25, SNDLVL_IDLE, 100, "weapons/tfa_bo3/runebow/rune_fire_loop_plr.wav",")")
TFA.AddSound ("TFA_BO3_RUNEBOW.DrawLoopUpg", CHAN_ITEM, 0.25, SNDLVL_IDLE, 100, "weapons/tfa_bo3/runebow/rune_bow_fire_upg.wav",")")

TFA.AddSound ("TFA_BO3_RUNEBOW.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/runebow/proj_explo_00.wav", "weapons/tfa_bo3/runebow/proj_explo_01.wav", "weapons/tfa_bo3/runebow/proj_explo_02.wav"},")")

TFA.AddSound ("TFA_BO3_RUNEBOW.Lava", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/runebow/lava_lump_01.wav", "weapons/tfa_bo3/runebow/lava_lump_02.wav", "weapons/tfa_bo3/runebow/lava_lump_03.wav"},")")
TFA.AddSound ("TFA_BO3_RUNEBOW.PrisonAppear", CHAN_STATIC, 0.5, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/runebow/rune_prison_appear_01.wav", "weapons/tfa_bo3/runebow/rune_prison_appear_02.wav", "weapons/tfa_bo3/runebow/rune_prison_appear_03.wav"},")")
TFA.AddSound ("TFA_BO3_RUNEBOW.PrisonDisappear", CHAN_STATIC, 0.5, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/runebow/rune_prison_disappear_01.wav", "weapons/tfa_bo3/runebow/rune_prison_disappear_02.wav", "weapons/tfa_bo3/runebow/rune_prison_disappear_03.wav"},")")
TFA.AddSound ("TFA_BO3_RUNEBOW.ArrowLoop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/runebow/bow_fire_loop.wav",")")

-- Wolf Bow --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_WOLFBOW.Charge", "weapons/tfa_bo3/wolfbow/wolf_bow_charge_01.wav", true, ")")
TFA.AddSound ("TFA_BO3_WOLFBOW.Howl", CHAN_STATIC, 0.1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/wolfbow/wolf_bow_howl.wav",")")

TFA.AddSound ("TFA_BO3_WOLFBOW.DrawLoop", CHAN_WEAPON, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/wolfbow/wolf_draw_back_fx.wav",")")
TFA.AddSound ("TFA_BO3_WOLFBOW.DrawLoopShim", CHAN_BODY, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/wolfbow/wolf_draw_back_fx_shim.wav",")")

TFA.AddSound ("TFA_BO3_WOLFBOW.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/wolfbow/wolf_bow_impact.wav",")")
TFA.AddSound ("TFA_BO3_WOLFBOW.Sweet", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/wolfbow/wolf_bow_sweet_00.wav", "weapons/tfa_bo3/wolfbow/wolf_bow_sweet_01.wav", "weapons/tfa_bo3/wolfbow/wolf_bow_sweet_02.wav"},")")

TFA.AddSound ("TFA_BO3_WOLFBOW.ArrowLoop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/wolfbow/wolf_bow_fx_loop_01.wav",")")

-- Demon Bow --------------------------------------------------------------------------------------------------------
TFA.AddSound ("TFA_BO3_DEMONBOW.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/demonbow/demongate_imp_00.wav", "weapons/tfa_bo3/demonbow/demongate_imp_01.wav", "weapons/tfa_bo3/demonbow/demongate_imp_02.wav", "weapons/tfa_bo3/demonbow/demongate_imp_03.wav", "weapons/tfa_bo3/demonbow/demongate_imp_04.wav"},")")

TFA.AddSound ("TFA_BO3_DEMONBOW.Portal.Start", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/demonbow/demongate_portal_start.wav",")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Portal.Loop", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/demonbow/demongate_portal_loop.wav",")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Portal.Close", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/demonbow/demongate_portal_close.wav",")")

TFA.AddSound ("TFA_BO3_DEMONBOW.ArrowLoop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/demonbow/demon_frenzy_loop.wav",")")

TFA.AddSound ("TFA_BO3_DEMONBOW.Chomper.Appear", CHAN_STATIC, 1, SNDLVL_NORM, 100, "weapons/tfa_bo3/demonbow/demon_appear.wav",")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Chomper.Loop", CHAN_STATIC, 0.1, SNDLVL_NORM, 100, "weapons/tfa_bo3/demonbow/chomper/chomper_lp.wav",")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Chomper.Bite", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_00.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_01.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_02.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_03.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_04.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_05.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_06.wav", "weapons/tfa_bo3/demonbow/chomper/bite/chomper_bite_07.wav"},")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Chomper.Disappear", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/demonbow/chomper/disappear/chomper_disappear.wav",")")
TFA.AddSound ("TFA_BO3_DEMONBOW.Chomper.Vox.Short", CHAN_STATIC, 0.5, SNDLVL_NORM, 100, {"weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_00.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_01.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_02.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_03.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_04.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_05.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_06.wav", "weapons/tfa_bo3/demonbow/chomper/vox_short/chomper_vox_short_07.wav"},")")

-- Hacker Device --------------------------------------------------------------------------------------------------------
TFA.AddSound ("TFA_BO3_HACKER.Loop", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/evt_moon_hacker_loop.wav", "weapons/tfa_bo3/hacker/hacker_meme.wav"},")")
TFA.AddSound ("TFA_BO3_HACKER.Finish", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, {"weapons/tfa_bo3/hacker/evt_correct_hack_00.wav", "weapons/tfa_bo3/hacker/evt_correct_hack_01.wav"},")")

TFA.AddSound ("TFA_BO3_HACKER.Fail", CHAN_BODY, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo3/hacker/vox_mcomp_hack_fail.wav",")")
TFA.AddSound ("TFA_BO3_HACKER.Success", CHAN_BODY, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo3/hacker/vox_mcomp_hack_success.wav",")")

TFA.AddWeaponSound("TFA_BO3_HACKER.Open", "weapons/tfa_bo3/hacker/evt_moon_hacker_open.wav")
TFA.AddWeaponSound("TFA_BO3_HACKER.Close", "weapons/tfa_bo3/hacker/evt_moon_hacker_close.wav")
TFA.AddWeaponSound("TFA_BO3_HACKER.PenOut", "weapons/tfa_bo3/hacker/evt_moon_hacker_pen_out.wav")
TFA.AddWeaponSound("TFA_BO3_HACKER.PenIn", "weapons/tfa_bo3/hacker/evt_moon_hacker_pen_in.wav")
TFA.AddWeaponSound("TFA_BO3_HACKER.Throwup", "weapons/tfa_bo3/hacker/evt_perk_throwup.wav")

TFA.AddSound ("TFA_BO3_HACKER.Shield.Start", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/hacker/shield/sfx_playershieldhit_00.wav", "weapons/tfa_bo3/hacker/shield/sfx_playershieldhit_01.wav", "weapons/tfa_bo3/hacker/shield/sfx_playershieldhit_02.wav", "weapons/tfa_bo3/hacker/shield/sfx_playershieldhit_03.wav"},")")
TFA.AddSound ("TFA_BO3_HACKER.Shield.Break", CHAN_WEAPON, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo3/hacker/shield/sfx_playershieldbreak_00.wav", "weapons/tfa_bo3/hacker/shield/sfx_playershieldbreak_01.wav"},")")

-- PES ------------------------
TFA.AddWeaponSound("TFA_BO3_PES.Equip", "weapons/tfa_bo3/pes/evt_stand_up.wav")
TFA.AddWeaponSound("TFA_BO3_PES.On", "weapons/tfa_bo3/pes/helmet_on.wav")
TFA.AddWeaponSound("TFA_BO3_PES.Off", "weapons/tfa_bo3/pes/helmet_off.wav")

TFA.AddSound ("TFA_BO3_PES.Chatter", CHAN_ITEM, 0.5, SNDLVL_NORM, 100, {"weapons/tfa_bo3/pes/amb_benburt_00.wav", "weapons/tfa_bo3/pes/amb_benburt_01.wav", "weapons/tfa_bo3/pes/amb_benburt_02.wav", "weapons/tfa_bo3/pes/amb_benburt_03.wav", "weapons/tfa_bo3/pes/amb_benburt_04.wav"},")")

-- Death Machine ------------------------
TFA.AddWeaponSound("TFA_BO3_MINGN.Equip", "weapons/tfa_bo3/mingun/fly_minigun_up.wav")

TFA.AddFireSound("TFA_BO3_MINGN.Start", "weapons/tfa_bo3/mingun/wpn_vulcan_fire_start_plr.wav", true, ")")
TFA.AddFireSound("TFA_BO3_MINGN.Loop", "weapons/tfa_bo3/mingun/wpn_vulcan_fire_loop_plr.wav", false, ")")
TFA.AddFireSound("TFA_BO3_MINGN.Stop", "weapons/tfa_bo3/mingun/wpn_vulcan_fire_stop_plr.wav", false, ")")

TFA.AddSound ("TFA_BO3_MINGN.SpinStart", CHAN_ITEM, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo3/mingun/wpn_vulcan_start_plr.wav",")")
TFA.AddSound ("TFA_BO3_MINGN.SpinLoop", CHAN_ITEM, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/mingun/wpn_vulcan_loop_plr.wav",")")
TFA.AddSound ("TFA_BO3_MINGN.SpinStop", CHAN_ITEM, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo3/mingun/wpn_vulcan_stop_plr.wav",")")

-- Staffs --------------------------------------------------------------------------------------------------------
TFA.AddWeaponSound("TFA_BO3_STAFFS.Pullout", "weapons/tfa_bo3/staffs/shared/fly_staff_pullout.wav")
TFA.AddWeaponSound("TFA_BO3_STAFFS.Putaway", "weapons/tfa_bo3/staffs/shared/fly_staff_putaway.wav")

TFA.AddWeaponSound("TFA_BO3_STAFFS.ReloadIn", "weapons/tfa_bo3/staffs/shared/reload_1719.wav")
TFA.AddWeaponSound("TFA_BO3_STAFFS.Reload", "weapons/tfa_bo3/staffs/shared/reload_1734.wav")
TFA.AddWeaponSound("TFA_BO3_STAFFS.ReloadOut", "weapons/tfa_bo3/staffs/shared/reload_1748.wav")
TFA.AddWeaponSound("TFA_BO3_STAFFS.Lever", "weapons/tfa_bo3/staffs/shared/reload_1764.wav")
TFA.AddWeaponSound("TFA_BO3_STAFFS.Draw", "weapons/tfa_bo3/staffs/shared/upgraded_shing.wav")

TFA.AddWeaponSound("TFA_BO3_STAFFS.Melee", {"weapons/tfa_bo3/staffs/shared/staff_melee_upgrd_00.wav", "weapons/tfa_bo3/staffs/shared/staff_melee_upgrd_01.wav", "weapons/tfa_bo3/staffs/shared/staff_melee_upgrd_02.wav"})
TFA.AddWeaponSound("TFA_BO3_STAFFS.MeleeHit", {"weapons/tfa_bo3/staffs/shared/knife_blade_imp_00.wav", "weapons/tfa_bo3/staffs/shared/knife_blade_imp_01.wav", "weapons/tfa_bo3/staffs/shared/knife_blade_imp_02.wav"})
TFA.AddWeaponSound("TFA_BO3_STAFFS.MeleeHitFlesh", {"weapons/tfa_bo3/staffs/shared/knife_hit_00.wav", "weapons/tfa_bo3/staffs/shared/knife_hit_01.wav"})

-- Wind Staff --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_STAFF_WIND.Shoot", "weapons/tfa_bo3/staffs/windstaff/airstaff_shot_frnt_01.wav", true, ")")
TFA.AddSound ("TFA_BO3_STAFF_WIND.Flux", CHAN_STATIC, 0.2, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_shot_flux_l.wav",")")

TFA.AddWeaponSound("TFA_BO3_STAFF_WIND.Draw", "weapons/tfa_bo3/staffs/windstaff/1straise_air.wav")

TFA.AddSound ("TFA_BO3_STAFF_WIND.Charge1", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_charge_00.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_WIND.Charge2", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_charge_01.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_WIND.Charge3", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_charge_02.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_WIND.ChargeLoop", CHAN_ITEM, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_charge_loop.wav",")")

TFA.AddSound ("TFA_BO3_STAFF_WIND.Tornado", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_tornado.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_WIND.TornadoImp", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/windstaff/airstaff_tornado_imp.wav",")")

-- Ice Staff --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_STAFF_ICE.Shoot", "weapons/tfa_bo3/staffs/icestaff/ice_staff_shot_frnt.wav", true, ")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.Flux", CHAN_STATIC, 0.25, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/staffs/icestaff/icestaff_flux_3_l.wav",")")

TFA.AddWeaponSound("TFA_BO3_STAFF_ICE.Draw", "weapons/tfa_bo3/staffs/icestaff/1straise_water.wav")

TFA.AddSound ("TFA_BO3_STAFF_ICE.Charge1", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/icestaff/icestaff_charge_001.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.Charge2", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/icestaff/icestaff_charge_002.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.Charge3", CHAN_WEAPON, 1, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/icestaff/icestaff_charge_003.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.ChargeLoop", CHAN_ITEM, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/icestaff/icestaff_charge_lp_01.wav",")")

TFA.AddSound ("TFA_BO3_STAFF_ICE.Tornado", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/icestaff/ice_staff_storm_st.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.TornadoImp", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/icestaff/ice_staff_storm_imp.wav",")")

TFA.AddSound ("TFA_BO3_STAFF_ICE.Freeze", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/icestaff/freeze_00.wav", "weapons/tfa_bo3/staffs/icestaff/freeze_01.wav", "weapons/tfa_bo3/staffs/icestaff/freeze_02.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.Shatter", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/icestaff/shatter_00.wav", "weapons/tfa_bo3/staffs/icestaff/shatter_01.wav", "weapons/tfa_bo3/staffs/icestaff/shatter_02.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ICE.ShatterImp", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/icestaff/ice_impact_00.wav", "weapons/tfa_bo3/staffs/icestaff/ice_impact_01.wav", "weapons/tfa_bo3/staffs/icestaff/ice_impact_02.wav",")")

-- Fire Staff --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_STAFF_FIRE.Shoot", "weapons/tfa_bo3/staffs/firestaff/shot_front.wav", true, ")")
TFA.AddSound ("TFA_BO3_STAFF_FIRE.Flux", CHAN_STATIC, 0.25, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/staffs/firestaff/flux.wav",")")

TFA.AddWeaponSound("TFA_BO3_STAFF_FIRE.Draw", "weapons/tfa_bo3/staffs/firestaff/1straise_fire.wav")

TFA.AddSound ("TFA_BO3_STAFF_FIRE.Charge1", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/firestaff/charge_1.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_FIRE.Charge2", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/firestaff/charge_2.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_FIRE.Charge3", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/firestaff/charge_3.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_FIRE.ChargeLoop", CHAN_ITEM, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/firestaff/loop.wav",")")

TFA.AddSound ("TFA_BO3_STAFF_FIRE.Loop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/firestaff/grenade_loop.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_FIRE.LoopImp", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/firestaff/upgraded_imp.wav",")")

-- Lightning Staff --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_STAFF_ELEC.Shoot", "weapons/tfa_bo3/staffs/elecstaff/wpn_elec_staff_fire.wav", true, ")")

TFA.AddWeaponSound("TFA_BO3_STAFF_ELEC.Draw", "weapons/tfa_bo3/staffs/elecstaff/1straise_lightning.wav")

TFA.AddSound ("TFA_BO3_STAFF_ELEC.Charge1", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/elecstaff/lghtng_charge_01.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ELEC.Charge2", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/elecstaff/lghtng_charge_02.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ELEC.Charge3", CHAN_WEAPON, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/elecstaff/lghtng_charge_03.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ELEC.ChargeLoop", CHAN_ITEM, 0.2, SNDLVL_IDLE, 100, "weapons/tfa_bo3/staffs/elecstaff/lghtng_charge_loop.wav",")")

TFA.AddSound ("TFA_BO3_STAFF_ELEC.Loop", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/elecstaff/lightning_ball_01.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ELEC.LoopImp", CHAN_STATIC, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/elecstaff/wpn_lightning_ball_explo.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_ELEC.Impact", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, {"weapons/tfa_bo3/staffs/elecstaff/lightning_flash_00.wav", "weapons/tfa_bo3/staffs/elecstaff/lightning_flash_01.wav", "weapons/tfa_bo3/staffs/elecstaff/lightning_flash_02.wav", "weapons/tfa_bo3/staffs/elecstaff/lightning_flash_03.wav"},")")

TFA.AddSound ("TFA_BO3_STAFF_ELEC.Shock", CHAN_STATIC, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo3/staffs/elecstaff/shock_effect_01.wav",")")

-- Revive Staff --------------------------------------------------------------------------------------------------------
TFA.AddFireSound("TFA_BO3_STAFF_REV.Shoot", {"weapons/tfa_bo3/staffs/revivestaff/shot.wav"}, true, ")")

TFA.AddSound ("TFA_BO3_STAFF_REV.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/revivestaff/impact_00.wav",")")
TFA.AddSound ("TFA_BO3_STAFF_REV.Loop", CHAN_WEAPON, 0.5, SNDLVL_TALKING, 100, "weapons/tfa_bo3/staffs/revivestaff/proj_loop.wav",")")
