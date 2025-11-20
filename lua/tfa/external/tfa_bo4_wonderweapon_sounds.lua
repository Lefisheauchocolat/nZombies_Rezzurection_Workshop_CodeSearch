-- General
TFA.AddSound ("TFA_BO4_GRENADE.Decay.Ext", CHAN_ITEM, 0.5, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo4/grenade/exp_grenade_decay_ext_00.wav",")")
TFA.AddSound ("TFA_BO4_GRENADE.Decay.Int", CHAN_ITEM, 0.5, SNDLVL_GUNFIRE, {97,103}, "weapons/tfa_bo4/grenade/exp_grenade_decay_ext_00.wav",")")
TFA.AddSound ("TFA_BO4_GRENADE.Dist", CHAN_WEAPON, 1, SNDLVL_180dB, {97,103}, {"weapons/tfa_bo4/grenade/exp_grenade_dist_00.wav", "weapons/tfa_bo4/grenade/exp_grenade_dist_01.wav", "weapons/tfa_bo4/grenade/exp_grenade_dist_02.wav"},")")
TFA.AddSound ("TFA_BO4_GRENADE.Flux", CHAN_STATIC, 1, SNDLVL_80db, {97,103}, "weapons/tfa_bo4/grenade/flux_00.wav",")")
TFA.AddSound ("TFA_BO4_GRENADE.Close", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo4/grenade/explode_close_00.wav", "weapons/tfa_bo4/grenade/explode_close_01.wav", "weapons/tfa_bo4/grenade/explode_close_02.wav"},")")

-- Winters Howl
TFA.AddFireSound("TFA_BO4_WINTERS.Shoot", {"weapons/tfa_bo4/winters/zm_office.all.sabl.471.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_WINTERS.Act", {"weapons/tfa_bo4/winters/zm_office.all.sabl.470.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_WINTERS.Crack", {"weapons/tfa_bo4/winters/zm_office.all.sabl.469.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_WINTERS.Lfe", {"weapons/tfa_bo4/winters/zm_office.all.sabl.468.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_WINTERS.Open", "weapons/tfa_bo4/winters/zm_office.all.sabl.424.wav")
TFA.AddWeaponSound("TFA_BO4_WINTERS.Insert", "weapons/tfa_bo4/winters/zm_office.all.sabl.423.wav")
TFA.AddWeaponSound("TFA_BO4_WINTERS.Spin", "weapons/tfa_bo4/winters/zm_office.all.sabl.425.wav")

TFA.AddSound ("TFA_BO4_WINTERS.Freeze", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/winters/zm_office.all.sabl.472.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.473.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.474.wav"},")")
TFA.AddSound ("TFA_BO4_WINTERS.Shatter", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/winters/zm_office.all.sabl.475.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.476.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.477.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.478.wav"},")")
TFA.AddSound ("TFA_BO4_WINTERS.Break", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/winters/zm_office.all.sabl.479.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.480.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.481.wav"},")")

TFA.AddSound ("TFA_BO4_WINTERS.Wind", CHAN_ITEM, 1, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo4/winters/zm_office.all.sabl.466.wav", "weapons/tfa_bo4/winters/zm_office.all.sabl.467.wav"},")")

-- Blundergat
TFA.AddFireSound("TFA_BO4_BLUNDER.Shoot", {"weapons/tfa_bo4/blundergat/zm_escape.all.sabl.797.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_BLUNDER.Act", {"weapons/tfa_bo4/blundergat/zm_escape.all.sabl.796.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_BLUNDER.Lfe", {"weapons/tfa_bo4/blundergat/zm_escape.all.sabl.795.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_BLUNDER.Dist", {"weapons/tfa_bo4/blundergat/zm_escape.all.sabl.794.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_BLUNDER.Draw", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.793.wav")
TFA.AddWeaponSound("TFA_BO4_BLUNDER.Open", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.791.wav")
TFA.AddWeaponSound("TFA_BO4_BLUNDER.Insert", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.792.wav")
TFA.AddWeaponSound("TFA_BO4_BLUNDER.Close", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.790.wav")

TFA.AddSound ("TFA_BO4_BLUNDER.Acid.Fuse", CHAN_ITEM, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.786.wav",")")
TFA.AddSound ("TFA_BO4_BLUNDER.Acid.Explode", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, {"weapons/tfa_bo4/blundergat/zm_escape.all.sabl.787.wav", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.788.wav", "weapons/tfa_bo4/blundergat/zm_escape.all.sabl.789.wav"},")")

TFA.AddSound ("TFA_BO4_BLUNDER.Magma.Loop", CHAN_ITEM, 1, SNDLVL_TALKING, {90,105}, "weapons/tfa_bo4/magmagat/bo4_magma_proj_loop.wav",")")
TFA.AddSound ("TFA_BO4_BLUNDER.Magma.End", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/magmagat/bo4_magma_proj_fizzle.wav",")")
TFA.AddSound ("TFA_BO4_BLUNDER.Magma.Explode.Swt", CHAN_STATIC, 0.8, SNDLVL_GUNFIRE, {90,110}, {"weapons/tfa_bo4/magmagat/bo4_magma_proj_explode01.wav", "weapons/tfa_bo4/magmagat/bo4_magma_proj_explode02.wav", "weapons/tfa_bo4/magmagat/bo4_magma_proj_explode03.wav"},")")
TFA.AddSound ("TFA_BO4_BLUNDER.Magma.Explode", CHAN_STATIC, 0.8, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo4/magmagat/xsound_549573baccb0aeb.wav",")")

-- Alistairs Folly
TFA.AddFireSound("TFA_BO4_ALISTAIR.Shoot", {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1029.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1030.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1031.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1032.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1033.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1034.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1035.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_ALISTAIR.Shoot.Upg", {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1037.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1038.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1039.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1040.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_ALISTAIR.Shoot.Charged", {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1025.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1026.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1027.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1028.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Lfe", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.1058.wav"}, false, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Lfe.Upg", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.1056.wav"}, false, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Lfe.Charged", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.1057.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_RAYGUN.Bweep", "weapons/tfa_bo4/raygun/wpn_ray_press.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.Open", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1069.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.Close", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1079.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.MagOut", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1077.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.MagIn", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1075.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.HammerUp", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1073.wav")
TFA.AddWeaponSound("TFA_BO4_ALISTAIR.HammerDown", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1071.wav")

TFA.AddSound ("TFA_BO4_ALISTAIR.Charge.Start", CHAN_STATIC, 1, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1008.wav",")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charge", CHAN_ITEM, 0.6, SNDLVL_IDLE, {97,103}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1007.wav",")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charge.Loop", CHAN_ITEM, 0.35, SNDLVL_IDLE, 100, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1006.wav",")")

TFA.AddSound ("TFA_BO4_ALISTAIR.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1063.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1064.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1065.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1066.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1067.wav"},")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Impact.Charged", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1059.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1060.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1061.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1062.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1067.wav"},")")

TFA.AddSound ("TFA_BO4_ALISTAIR.HeadPop", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo4/alistairs/ai_burst_00.wav",")")

TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.Toxic", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.650.wav",")")

TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.WindLoop", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1088.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1089.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1090.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1091.wav"},")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.WindEnd", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1048.wav"},")")

TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.FireStart", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1047.wav",")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.FireLoop", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1041.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1046.wav"},")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.FireExpl", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1042.wav",")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.FireEnd", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1043.wav",")")

TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.ShrinkLoop", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1050.wav",")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.ShrinkEnd", CHAN_WEAPON, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1051.wav", "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1052.wav"},")")
TFA.AddSound ("TFA_BO4_ALISTAIR.Charged.Shrink", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo4/alistairs/zm_mansion.all.sabl.1053.wav",")")

-- Raygun
TFA.AddFireSound("TFA_BO4_RAYGUN.Shoot", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.440.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Act", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.441.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Crack", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.442.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_RAYGUN.Lfe", {"weapons/tfa_bo4/raygun/zm_office.all.sabl.439.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_RAYGUN.Switch", "weapons/tfa_bo4/raygun/zm_office.all.sabl.461.wav")
TFA.AddWeaponSound("TFA_BO4_RAYGUN.PickUp", "weapons/tfa_bo4/raygun/xsound_e11b8baca21d1cb.wav")

-- Overkill
TFA.AddFireSound("TFA_BO4_OVERKILL.Start", "weapons/tfa_bo4/overkill/wpn_vulcan_fire_start_plr.wav", true, ")")
TFA.AddFireSound("TFA_BO4_OVERKILL.Loop", "weapons/tfa_bo4/overkill/wpn_vulcan_fire_loop_plr.wav", false, ")")
TFA.AddFireSound("TFA_BO4_OVERKILL.Stop", "weapons/tfa_bo4/overkill/wpn_vulcan_fire_stop_plr.wav", false, ")")

TFA.AddSound ("TFA_BO4_OVERKILL.SpinStart", CHAN_ITEM, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo4/overkill/wpn_vulcan_start_plr.wav",")")
TFA.AddSound ("TFA_BO4_OVERKILL.SpinLoop", CHAN_ITEM, 0.5, SNDLVL_IDLE, 100, "weapons/tfa_bo4/overkill/wpn_vulcan_loop_plr.wav",")")
TFA.AddSound ("TFA_BO4_OVERKILL.SpinStop", CHAN_ITEM, 0.5, SNDLVL_NORM, 100, "weapons/tfa_bo4/overkill/wpn_vulcan_stop_plr.wav",")")

TFA.AddFireSound("TFA_BO4_OVERKILL.ShootGL", {"weapons/tfa_bo4/overkill/wpn_t8_overkill_gl_shot1.wav", "weapons/tfa_bo4/overkill/wpn_t8_overkill_gl_shot2.wav", "weapons/tfa_bo4/overkill/wpn_t8_overkill_gl_shot3.wav", "weapons/tfa_bo4/overkill/wpn_t8_overkill_gl_shot4.wav", "weapons/tfa_bo4/overkill/wpn_t8_overkill_gl_shot5.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO4_OVERKILL.Draw", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1190.wav")
TFA.AddWeaponSound("TFA_BO4_OVERKILL.Pullout", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1192.wav")
TFA.AddWeaponSound("TFA_BO4_OVERKILL.Deploy", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1188.wav")
TFA.AddWeaponSound("TFA_BO4_OVERKILL.Holster", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1194.wav")
TFA.AddWeaponSound("TFA_BO4_OVERKILL.Throw", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1196.wav")
TFA.AddWeaponSound("TFA_BO4_OVERKILL.Bounce", "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1197.wav")

TFA.AddSound ("TFA_BO4_OVERKILL.Cook", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo4/overkill/zm_escape.all.sabl.1198.wav",")")

TFA.AddSound ("TFA_BO4_OVERKILL.NukeFlash", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo4/overkill/nuke_flash.wav",")")
TFA.AddSound ("TFA_BO4_OVERKILL.NukeEcho", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo4/overkill/xsound_435dfea6aa14637.wav",")")

TFA.AddSound ("TFA_BO4_OVERKILL.NukeSoul", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, {"weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_00.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_01.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_02.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_03.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_04.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_05.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_06.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_07.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_08.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_09.wav", "weapons/tfa_bo4/overkill/soul/zmb_nuke_soul_10.wav"},")")

-- Path of Sorrows
TFA.AddWeaponSound("TFA_BO4_KATANA.Draw", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1155.wav")
TFA.AddWeaponSound("TFA_BO4_KATANA.Holster", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1157.wav")
TFA.AddWeaponSound("TFA_BO4_KATANA.Deploy", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1153.wav")

TFA.AddWeaponSound("TFA_BO4_KATANA.Grab", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1184.wav")
TFA.AddWeaponSound("TFA_BO4_KATANA.Ult", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1185.wav")

TFA.AddWeaponSound("TFA_BO4_KATANA.Slash", {"weapons/tfa_bo4/katana/zm_escape.all.sabl.1170.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1171.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1172.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1173.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1174.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1175.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1176.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1177.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1178.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1179.wav"})
TFA.AddWeaponSound("TFA_BO4_KATANA.Dash", {"weapons/tfa_bo4/katana/zm_escape.all.sabl.1149.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1150.wav", "weapons/tfa_bo4/katana/zm_escape.all.sabl.1151.wav"})

-- Thundergun
TFA.AddFireSound("TFA_BO4_THUNDERGUN.Shoot", "weapons/tfa_bo4/thundergun/zm_orange.all.sabl.564.wav", true, ")")
TFA.AddFireSound("TFA_BO4_THUNDERGUN.Flux", {"weapons/tfa_bo4/thundergun/zm_orange.all.sabl.572.wav", "weapons/tfa_bo4/thundergun/zm_orange.all.sabl.573.wav", "weapons/tfa_bo4/thundergun/zm_orange.all.sabl.574.wav", "weapons/tfa_bo4/thundergun/zm_orange.all.sabl.575.wav", "weapons/tfa_bo4/thundergun/zm_orange.all.sabl.576.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_THUNDERGUN.Raise", "weapons/tfa_bo4/thundergun/zm_common.all.p.sabl.111.wav")
TFA.AddWeaponSound("TFA_BO4_THUNDERGUN.Open", "weapons/tfa_bo4/thundergun/zm_common.all.p.sabl.115.wav")
TFA.AddWeaponSound("TFA_BO4_THUNDERGUN.MagOut", "weapons/tfa_bo4/thundergun/zm_common.all.p.sabl.114.wav")
TFA.AddWeaponSound("TFA_BO4_THUNDERGUN.MagIn", "weapons/tfa_bo4/thundergun/zm_common.all.p.sabl.113.wav")
TFA.AddWeaponSound("TFA_BO4_THUNDERGUN.Close", "weapons/tfa_bo4/thundergun/zm_common.all.p.sabl.112.wav")

-- Tundragun
TFA.AddFireSound("TFA_BO4_TUNDRAGUN.Shoot", "weapons/tfa_bo4/tundragun/zm_orange.all.sabl.578.wav", true, ")")
TFA.AddSound ("TFA_BO4_TUNDRAGUN.Impact", CHAN_ITEM, 1, SNDLVL_TALKING, {97,103}, "weapons/tfa_bo4/tundragun/zm_orange.all.sabl.579.wav",")")

-- Death of Orion
TFA.AddFireSound("TFA_BO4_SCORPION.Shoot", {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.672.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.673.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.674.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.675.wav"}, false, ")")
TFA.AddFireSound("TFA_BO4_SCORPION.Act", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.666.wav", true, ")")

TFA.AddWeaponSound("TFA_BO4_SCORPION.Raise", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.627.wav")
TFA.AddWeaponSound("TFA_BO4_SCORPION.Draw", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.628.wav")
TFA.AddWeaponSound("TFA_BO4_SCORPION.Charge", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.667.wav")
TFA.AddWeaponSound("TFA_BO4_SCORPION.Hissing", {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.629.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.630.wav"})
TFA.AddWeaponSound("TFA_BO4_SCORPION.Movement", {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.632.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.633.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.634.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.635.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.636.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.637.wav"})
TFA.AddWeaponSound("TFA_BO4_SCORPION.Chains", {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.642.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.643.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.644.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.645.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.646.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.647.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.648.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.649.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.650.wav"})

TFA.AddSound ("TFA_BO4_SCORPION.ChargeLoop", CHAN_ITEM, 0.4, SNDLVL_IDLE, 100, "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.665.wav",")")

TFA.AddSound ("TFA_BO4_SCORPION.Impact", CHAN_STATIC, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.661.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.662.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.663.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.664.wav"},")")
TFA.AddSound ("TFA_BO4_SCORPION.Arc", CHAN_WEAPON, 1, SNDLVL_TALKING, {97,103}, {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.680.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.681.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.682.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.683.wav"},")")
TFA.AddSound ("TFA_BO4_SCORPION.Kill", CHAN_STATIC, 1, SNDLVL_NORM, {95,105}, "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.659.wav",")")
TFA.AddSound ("TFA_BO4_SCORPION.Shock", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {97,103}, {"weapons/tfa_bo4/scorpion/zm_towers.all.sabl.676.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.677.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.678.wav", "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.679.wav"},")")
TFA.AddSound ("TFA_BO4_SCORPION.Spin", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/scorpion/zm_towers.all.sabl.660.wav",")")

-- Savage Impaler
TFA.AddFireSound("TFA_BO4_IMPALER.Shoot", "weapons/tfa_bo4/impaler/zm_mansion.all.sabl.980.wav", true, ")")
TFA.AddFireSound("TFA_BO4_IMPALER.Lfe", "weapons/tfa_bo4/impaler/zm_mansion.all.sabl.979.wav", false, ")")

TFA.AddWeaponSound("TFA_BO4_IMPALER.Smoke", "weapons/tfa_bo4/impaler/zm_common.all.p.sabl.585.wav")
TFA.AddWeaponSound("TFA_BO4_IMPALER.MagOut", "weapons/tfa_bo4/impaler/zm_common.all.p.sabl.583.wav")
TFA.AddWeaponSound("TFA_BO4_IMPALER.MagIn", "weapons/tfa_bo4/impaler/zm_common.all.p.sabl.582.wav")
TFA.AddWeaponSound("TFA_BO4_IMPALER.Chamber", "weapons/tfa_bo4/impaler/zm_common.all.p.sabl.584.wav")
TFA.AddWeaponSound("TFA_BO4_IMPALER.Raise", "weapons/tfa_bo4/impaler/zm_common.all.p.sabl.581.wav")

-- DG-5
TFA.AddFireSound("TFA_BO4_DG5.Reverb", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1131.wav", false, ")")
TFA.AddFireSound("TFA_BO4_DG5.Impact", {"weapons/tfa_bo4/dg5/zm_escape.all.sabl.1123.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1124.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_DG5.Strike", {"weapons/tfa_bo4/dg5/zm_escape.all.sabl.1120.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1121.wav"}, true, ")")
TFA.AddFireSound("TFA_BO4_DG5.Activate", {"weapons/tfa_bo4/dg5/zm_escape.all.sabl.1096.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1097.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO4_DG5.Raise", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1125.wav")
TFA.AddWeaponSound("TFA_BO4_DG5.Clap", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1115.wav")
TFA.AddWeaponSound("TFA_BO4_DG5.Stop", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1117.wav")
TFA.AddWeaponSound("TFA_BO4_DG5.Spark", {"weapons/tfa_bo4/dg5/zm_escape.all.sabl.1106.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1107.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1108.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1109.wav"})

TFA.AddSound ("TFA_BO4_DG5.SparkLoop", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1119.wav",")")

TFA.AddSound ("TFA_BO4_DG5.ShockLoop", CHAN_WEAPON, 1, SNDLVL_NORM, 100, "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1127.wav",")")
TFA.AddSound ("TFA_BO4_DG5.ShockEnd", CHAN_WEAPON, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo4/dg5/zm_escape.all.sabl.1132.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1133.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1134.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1135.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1136.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1137.wav", "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1138.wav"},")")

TFA.AddSound ("TFA_BO4_DG5.Vortex.Start", CHAN_STATIC, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1131.wav",")")
TFA.AddSound ("TFA_BO4_DG5.Vortex.Loop", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1130.wav",")")
TFA.AddSound ("TFA_BO4_DG5.Vortex.End", CHAN_ITEM, 1, SNDLVL_TALKING, 100, "weapons/tfa_bo4/dg5/zm_escape.all.sabl.1129.wav",")")

-- Hellfire
TFA.AddFireSound("TFA_BO4_HELLFIRE.Start", "weapons/tfa_bo4/hellfire/wpn_flamethrower_start.wav", true, ")")
TFA.AddFireSound("TFA_BO4_HELLFIRE.Loop", "weapons/tfa_bo4/hellfire/wpn_flamethrower_loop.wav", false, ")")
TFA.AddFireSound("TFA_BO4_HELLFIRE.Stop", "weapons/tfa_bo4/hellfire/wpn_flamethrower_stop.wav", false, ")")

TFA.AddFireSound("TFA_BO4_HELLFIRE.AirBlast", {"weapons/tfa_bo4/hellfire/zm_office.all.sabl.625.wav", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.626.wav", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.627.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO4_HELLFIRE.Raise", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.630.wav")
TFA.AddWeaponSound("TFA_BO4_HELLFIRE.Draw", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.634.wav")
TFA.AddWeaponSound("TFA_BO4_HELLFIRE.Holster", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.636.wav")
TFA.AddWeaponSound("TFA_BO4_HELLFIRE.Charge", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.628.wav")
TFA.AddWeaponSound("TFA_BO4_HELLFIRE.Ult", {"weapons/tfa_bo4/hellfire/zm_office.all.sabl.644.wav", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.645.wav", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.646.wav", "weapons/tfa_bo4/hellfire/zm_office.all.sabl.647.wav"})
TFA.AddWeaponSound("TFA_BO4_HELLFIRE.CoolDown", "weapons/tfa_bo4/hellfire/wpn_flamethrower_cooldown_pings_00.wav")

TFA.AddSound ("TFA_BO4_HELLFIRE.Idle", CHAN_ITEM, 0.3, SNDLVL_NORM, 100, "weapons/tfa_bo4/hellfire/zm_office.all.sabl.632.wav",")")

TFA.AddSound ("TFA_BO4_HELLFIRE.Sizzle", CHAN_WEAPON, 1, SNDLVL_NORM, 100, {"weapons/tfa_bo4/hellfire/prj_lightning_body_sizzle_00.wav", "weapons/tfa_bo4/hellfire/prj_lightning_body_sizzle_01.wav", "weapons/tfa_bo4/hellfire/prj_lightning_body_sizzle_02.wav"},")")

TFA.AddSound ("TFA_BO4_HELLFIRE.Tornado.Start", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/hellfire/zm_office.all.sabl.637.wav",")")
TFA.AddSound ("TFA_BO4_HELLFIRE.Tornado.Loop", CHAN_ITEM, 1, SNDLVL_NORM, 100, "weapons/tfa_bo4/hellfire/zm_office.all.sabl.638.wav",")")
TFA.AddSound ("TFA_BO4_HELLFIRE.Tornado.End", CHAN_ITEM, 1, SNDLVL_TALKING, {95,105}, "weapons/tfa_bo4/hellfire/zm_office.all.sabl.639.wav",")")

-- Matryoshka
TFA.AddWeaponSound("TFA_BO4_DOLL.Raise", "weapons/tfa_bo4/matryoshka/zm_common.all.p.sabl.107.wav")
TFA.AddSound ("TFA_BO4_FRAG.Expl", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/frag/exp_frag_grenade_00.wav", "weapons/tfa_bo4/frag/exp_frag_grenade_01.wav"},")")
TFA.AddSound ("TFA_BO4_FRAG.Expl.Lfe", CHAN_STATIC, 1, SNDLVL_TALKING, {95,105}, {"weapons/tfa_bo4/frag/exp_frag_grenade_lfe_00.wav", "weapons/tfa_bo4/frag/exp_frag_grenade_lfe_01.wav"},")")
TFA.AddSound ("TFA_BO4_FRAG.Expl.Sw", CHAN_STATIC, 1, SNDLVL_GUNFIRE, {95,105}, "weapons/tfa_bo4/frag/exp_frag_shockwave.wav",")")

-- DG-ShartznFartz
TFA.AddFireSound("TFA_BO4_DG1.Shoot", {"weapons/tfa_bo4/dg1/zm_orange.all.sabl.511.wav", "weapons/tfa_bo4/dg1/zm_orange.all.sabl.512.wav", "weapons/tfa_bo4/dg1/zm_orange.all.sabl.513.wav", "weapons/tfa_bo4/dg1/zm_orange.all.sabl.514.wav"}, true, ")")

TFA.AddWeaponSound("TFA_BO4_DG1.Raise", "weapons/tfa_bo4/dg1/zm_common.all.p.sabl.108.wav")
TFA.AddWeaponSound("TFA_BO4_DG1.MagOut", "weapons/tfa_bo4/dg1/zm_common.all.p.sabl.109.wav")
TFA.AddWeaponSound("TFA_BO4_DG1.MagIn", "weapons/tfa_bo4/dg1/zm_common.all.p.sabl.110.wav")

-- Kraken
TFA.AddFireSound("TFA_BO4_KRAKEN.Shoot", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.616.wav", true, ")")
TFA.AddFireSound("TFA_BO4_KRAKEN.Mech", {"weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.609.wav", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.610.wav", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.611.wav", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.612.wav"}, false, ")")
TFA.AddFireSound("TFA_BO4_KRAKEN.Pap", "weapons/tfa_bo4/kraken/wpn_kraken_pap.wav", true, ")")

TFA.AddWeaponSound("TFA_BO4_KRAKEN.Open", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.580.wav")
TFA.AddWeaponSound("TFA_BO4_KRAKEN.Insert", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.579.wav")
TFA.AddWeaponSound("TFA_BO4_KRAKEN.Chamber", "weapons/tfa_bo4/kraken/zm_zodt8.all.sabl.578.wav")

/*-- Puke Ray
TFA.AddFireSound("TFA_BO4_PUKERAY.Shoot", "weapons/tfa_bo4/pukeray/wpn_ieu_gas_fire.wav", true, ")")

TFA.AddWeaponSound("TFA_BO4_PUKERAY.Reload", "weapons/tfa_bo4/pukeray/puke_gun_reload.wav")
TFA.AddWeaponSound("TFA_BO4_PUKERAY.Hit", "weapons/tfa_bo4/pukeray/puke_gun_reload_hit.wav")

TFA.AddSound ("TFA_BO4_PUKERAY.PukeSplash", CHAN_STATIC, 1, SNDLVL_TALKING, 100, {"weapons/tfa_bo4/pukeray/puke_splash_00.wav", "weapons/tfa_bo4/pukeray/puke_splash_01.wav", "weapons/tfa_bo4/pukeray/puke_splash_02.wav", "weapons/tfa_bo4/pukeray/puke_splash_03.wav", "weapons/tfa_bo4/pukeray/puke_splash_04.wav", "weapons/tfa_bo4/pukeray/puke_splash_05.wav", "weapons/tfa_bo4/pukeray/puke_splash_06.wav", "weapons/tfa_bo4/pukeray/puke_splash_07.wav", "weapons/tfa_bo4/pukeray/puke_splash_08.wav"},")")
*/
