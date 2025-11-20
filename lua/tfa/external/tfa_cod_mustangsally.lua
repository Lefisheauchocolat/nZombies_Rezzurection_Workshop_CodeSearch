if CLIENT then
killicon.Add( "tfa_bo1_mustangsally", "vgui/killicons/tfa_bo2_mustangsally", Color( 255, 0, 0, 255 ) )
killicon.Add( "tfa_bo2_mustangsally", "vgui/killicons/tfa_bo2_mustangsally", Color( 255, 0, 0, 255 ) )
killicon.Add( "tfa_bo3_mustangsally", "vgui/killicons/tfa_bo2_mustangsally", Color( 255, 0, 0, 255 ) )
killicon.Add( "tfa_bocw_mustangsally", "vgui/killicons/tfa_bo2_mustangsally", Color( 255, 0, 0, 255 ) )
killicon.Add( "mustangsally_proj", "vgui/killicons/tfa_bo2_mustangsally", Color( 255, 0, 0, 255 ) )
end

-- BO2 foley
TFA.AddWeaponSound("TFA_BO2MS_FLY.SelectFire", "weapons/tfa_bo2/mustangsally/fly/fly_select_fire.wav")
TFA.AddWeaponSound("TFA_BO2MS_FLY.DryFire", "weapons/tfa_bo2/mustangsally/fly/dry_fire_00.wav")

TFA.AddWeaponSound("TFA_BO2MS_FLY.Cloth", {"weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_00.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_01.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_02.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_03.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_04.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_05.wav", "weapons/tfa_bo2/mustangsally/fly/fly_cloth_short_06.wav"})
TFA.AddWeaponSound("TFA_BO2MS_FLY.Gear", {"weapons/tfa_bo2/mustangsally/fly/gear_rattle_00.wav", "weapons/tfa_bo2/mustangsally/fly/gear_rattle_01.wav", "weapons/tfa_bo2/mustangsally/fly/gear_rattle_02.wav", "weapons/tfa_bo2/mustangsally/fly/gear_rattle_03.wav", "weapons/tfa_bo2/mustangsally/fly/gear_rattle_04.wav", "weapons/tfa_bo2/mustangsally/fly/gear_rattle_05.wav"})

-- BO2 Mustang & Sally
TFA.AddFireSound("TFA_BO2_MS.Shoot", {"weapons/tfa_bo2/mustangsally/wpn_fnp45_fire_plr.wav"}, true, ")")
TFA.AddFireSound("TFA_BO2_MS.Decay", {"weapons/tfa_bo2/mustangsally/wpn_pistol_decay_ext.wav"}, false, ")")
TFA.AddSound ("TFA_BO2_MS.PapFlux", CHAN_ITEM, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo2/mustangsally/pap_shot_st.wav",")")

TFA.AddWeaponSound("TFA_BO2_MS.Hammer", "weapons/tfa_bo2/mustangsally/fly_pistol_hammer.wav")
TFA.AddWeaponSound("TFA_BO2_MS.MagOut", "weapons/tfa_bo2/mustangsally/fly_pistol_mag_out.wav")
TFA.AddWeaponSound("TFA_BO2_MS.MagIn", "weapons/tfa_bo2/mustangsally/fly_pistol_mag_in.wav")
TFA.AddWeaponSound("TFA_BO2_MS.SlideBack", "weapons/tfa_bo2/mustangsally/fly_pistol_sb.wav")
TFA.AddWeaponSound("TFA_BO2_MS.SlideFwd", "weapons/tfa_bo2/mustangsally/fly_pistol_sf.wav")

-- BO1 foley
TFA.AddWeaponSound("TFA_BO1MS_FLY.DryFire", "weapons/tfa_bo1/mustangsally/fly/pistol_dry_fire_st.wav")

TFA.AddWeaponSound("TFA_BO1MS_FLY.Cloth", {"weapons/tfa_bo1/mustangsally/fly/cloth_00.wav", "weapons/tfa_bo1/mustangsally/fly/cloth_01.wav", "weapons/tfa_bo1/mustangsally/fly/cloth_02.wav", "weapons/tfa_bo1/mustangsally/fly/cloth_03.wav"})
TFA.AddWeaponSound("TFA_BO1MS_FLY.Gear", {"weapons/tfa_bo1/mustangsally/fly/weapon_00.wav", "weapons/tfa_bo1/mustangsally/fly/weapon_01.wav", "weapons/tfa_bo1/mustangsally/fly/weapon_02.wav", "weapons/tfa_bo1/mustangsally/fly/weapon_03.wav", "weapons/tfa_bo1/mustangsally/fly/weapon_04.wav", "weapons/tfa_bo1/mustangsally/fly/weapon_05.wav"})
TFA.AddWeaponSound("TFA_BO1MS_FLY.Reload", {"weapons/tfa_bo1/mustangsally/fly/fly_gear_reload_plr_00.wav", "weapons/tfa_bo1/mustangsally/fly/fly_gear_reload_plr_01.wav", "weapons/tfa_bo1/mustangsally/fly/fly_gear_reload_plr_02.wav", "weapons/tfa_bo1/mustangsally/fly/fly_gear_reload_plr_03.wav"})

-- BO1 Mustang & Sally
TFA.AddFireSound("TFA_BO1_MS.Shoot", {"weapons/tfa_bo1/mustangsally/shot_00.wav", "weapons/tfa_bo1/mustangsally/shot_01.wav", "weapons/tfa_bo1/mustangsally/shot_02.wav", "weapons/tfa_bo1/mustangsally/shot_03.wav", "weapons/tfa_bo1/mustangsally/shot_04.wav"}, true, ")")
TFA.AddFireSound("TFA_BO1_MS.Act", {"weapons/tfa_bo1/mustangsally/act_00.wav"}, true, ")")
TFA.AddFireSound("TFA_BO1_MS.Ring", {"weapons/tfa_bo1/mustangsally/1911_ring_00.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BO1_MS.Futz", "weapons/tfa_bo1/mustangsally/fly_colt45_futz.wav")
TFA.AddWeaponSound("TFA_BO1_MS.MagOut", "weapons/tfa_bo1/mustangsally/fly_colt45_mag_out.wav")
TFA.AddWeaponSound("TFA_BO1_MS.MagIn", "weapons/tfa_bo1/mustangsally/fly_colt45_mag_in.wav")
TFA.AddWeaponSound("TFA_BO1_MS.SlideBack", "weapons/tfa_bo1/mustangsally/fly_colt45_slide_back.wav")
TFA.AddWeaponSound("TFA_BO1_MS.SlideFwd", "weapons/tfa_bo1/mustangsally/fly_colt45_slide_forward.wav")

-- BO3 foley
TFA.AddWeaponSound("TFA_BO3MS_FLY.DryFire", "weapons/tfa_bo3/mustangsally/fly/dry_fire_00_assault.wav")
TFA.AddWeaponSound("TFA_BO3MS_FLY.SelectFire", "weapons/tfa_bo3/mustangsally/fly/fly_select_fire.wav")

TFA.AddWeaponSound("TFA_BO3MS_FLY.Cloth", {"weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_00.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_01.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_02.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_03.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_04.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_05.wav", "weapons/tfa_bo3/mustangsally/fly/fly_cloth_shrt_06.wav"})
TFA.AddWeaponSound("TFA_BO3MS_FLY.Gear", {"weapons/tfa_bo3/mustangsally/fly/gear_rattle_13.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_15.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_17.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_18.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_19.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_20.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_21.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_22.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_23.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_24.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_25.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_27.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_28.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_29.wav", "weapons/tfa_bo3/mustangsally/fly/gear_rattle_30.wav"})

-- BO3 Mustang & Sally
TFA.AddFireSound("TFA_BO3_MS.Shoot", {"weapons/tfa_bo3/mustangsally/wpn_pistol_1911_fire.wav"}, true, ")")
TFA.AddFireSound("TFA_BO3_MS.Decay", {"weapons/tfa_bo3/mustangsally/wpn_smg_decay_close_ext.wav"}, false, ")")
TFA.AddSound ("TFA_BO3_MS.PapFlux", CHAN_ITEM, 1, SNDLVL_GUNFIRE, 100, "weapons/tfa_bo3/mustangsally/wpn_pap_first.wav",")")

TFA.AddWeaponSound("TFA_BO3_MS.Hammer", "weapons/tfa_bo3/mustangsally/fly_pistol_hammer.wav")
TFA.AddWeaponSound("TFA_BO3_MS.MagOut", "weapons/tfa_bo3/mustangsally/fly_1911_mag_out.wav")
TFA.AddWeaponSound("TFA_BO3_MS.MagIn", "weapons/tfa_bo3/mustangsally/fly_1911_mag_in.wav")
TFA.AddWeaponSound("TFA_BO3_MS.SlideBack", "weapons/tfa_bo3/mustangsally/fly_1911_slide_back.wav")
TFA.AddWeaponSound("TFA_BO3_MS.SlideFwd", "weapons/tfa_bo3/mustangsally/fly_1911_slide_forward.wav")

-- BOCW Mustang & Sally
TFA.AddFireSound("TFA_BOCW_MS.Shoot", {"weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot1.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot2.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot3.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot4.wav","weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot5.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_shot6.wav"}, true, ")")
TFA.AddFireSound("TFA_BOCW_MS.Mech", {"weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech1.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech2.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech3.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech4.wav","weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech5.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_mech6.wav"}, true, ")")
TFA.AddFireSound("TFA_BOCW_MS.Sub", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_sub.wav", true, ")")

TFA.AddWeaponSound("TFA_BOCW_MS.Trigger", {"weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull1.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull2.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull3.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull4.wav","weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull5.wav", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_trig_pull6.wav"})

TFA.AddWeaponSound("TFA_BOCW_MS.Left.MagOut", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_ldw_mag_out.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Left.MagIn", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_ldw_mag_in.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Left.SlideBack", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_ldw_slide_back.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Left.SlideFwd", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_ldw_slide_forward.wav")

TFA.AddWeaponSound("TFA_BOCW_MS.Right.MagOut", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_rdw_mag_out.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Right.MagIn", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_rdw_mag_in.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Right.SlideBack", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_rdw_slide_back.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Right.SlideFwd", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_rdw_slide_forward.wav")

TFA.AddWeaponSound("TFA_BOCW_MS.Inspect1", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_fdw_inspect_part1.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Inspect2", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_fdw_inspect_part2.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Inspect3", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_fdw_inspect_part3.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Inspect4", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_fdw_inspect_part4.wav")
TFA.AddWeaponSound("TFA_BOCW_MS.Inspect5", "weapons/tfa_bocw/mustangsally/wpn_t9_1911_fdw_inspect_part5.wav")

-- BO3 Mustang & Sally
TFA.AddFireSound("TFA_VANGUARD_MS.Shoot", {"weapons/tfa_vg/mustangsally/wpn_s4_1911_shot1.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_shot2.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_shot3.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_shot4.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_shot5.wav"}, true, ")")
TFA.AddFireSound("TFA_VANGUARD_MS.Mech", {"weapons/tfa_vg/mustangsally/wpn_s4_1911_mech1.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_mech2.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_mech3.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_mech4.wav", "weapons/tfa_vg/mustangsally/wpn_s4_1911_mech5.wav"}, true, ")")
TFA.AddFireSound("TFA_VANGUARD_MS.Ext", {"weapons/tfa_vg/mustangsally/wpn_s4_pi_tail_ext1.wav", "weapons/tfa_vg/mustangsally/wpn_s4_pi_tail_ext2.wav", "weapons/tfa_vg/mustangsally/wpn_s4_pi_tail_ext3.wav"}, true, ")")
TFA.AddFireSound("TFA_VANGUARD_MS.Sub", {"weapons/tfa_vg/mustangsally/wpn_s4_1911_sub.wav"}, true, ")")

TFA.AddWeaponSound("TFA_VANGUARD_MS.Left.Charge", "weapons/tfa_vg/mustangsally/wpn_s4_1911_ldw_charge.wav")
TFA.AddWeaponSound("TFA_VANGUARD_MS.Left.MagOut", "weapons/tfa_vg/mustangsally/wpn_s4_1911_ldw_empty_mag_out.wav")
TFA.AddWeaponSound("TFA_VANGUARD_MS.Left.MagIn", "weapons/tfa_vg/mustangsally/wpn_s4_1911_ldw_empty_mag_in.wav")

TFA.AddWeaponSound("TFA_VANGUARD_MS.Right.Charge", "weapons/tfa_vg/mustangsally/wpn_s4_1911_rdw_charge.wav")
TFA.AddWeaponSound("TFA_VANGUARD_MS.Right.MagOut", "weapons/tfa_vg/mustangsally/wpn_s4_1911_rdw_empty_mag_out.wav")
TFA.AddWeaponSound("TFA_VANGUARD_MS.Right.MagIn", "weapons/tfa_vg/mustangsally/wpn_s4_1911_rdw_empty_mag_in.wav")
