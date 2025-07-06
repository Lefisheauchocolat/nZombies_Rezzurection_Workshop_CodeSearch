local nzombies = engine.ActiveGamemode() == "nzombies"

if nzombies then
    hook.Add("InitPostEntity", "Moo_NZR_CreateTicTacs", function()
        nzSpecialWeapons:AddKnife("nz_2019_knife", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo1_sickle", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo1_bowie", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo2_knife", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo3_bowie", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo3_combatknife", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo3_oip", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo3_plunger", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo3_sickle", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo4_bowie", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo4_galvies", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_bo4_spork", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_iw6_knife", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_knife_w@w", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_knife_badgame", false, 0.65)
        nzSpecialWeapons:AddKnife("nz_knife_aw", false, 0.65)


        nzSpecialWeapons:AddDisplay("nz_bo3_bowie_display", false, function(wep)
            return SERVER and (wep.nzDeployTime + 2.8 < CurTime())
        end)
        --[[nzSpecialWeapons:AddGrenade("nz_bo1_russiangrenade", 4, false, 0.6, false, 0.4)
        nzSpecialWeapons:AddSpecialGrenade( "nz_ren_monkeybomb", 3, false, 1, false, 0.4 )
        nzSpecialWeapons:AddDisplay("nz_bo2_bowie_display", false, function(wep)
            return SERVER and (wep.nzDeployTime + 2.8 < CurTime())
        end)
        nzSpecialWeapons:AddDisplay("nz_ugx_fuckfinger", false, function(wep)
            return SERVER and (wep.nzDeployTime + 1.6 < CurTime())
        end)]]
    end)
end



-- W@W Knife Sounds
TFA.AddSound("TFA.WAW.KNIFE.Swing", CHAN_STATIC, 1, 75, 100, {
	"weapons/tfa_cod/waw/knife/swing/melee_swing_sm_00.mp3",
	"weapons/tfa_cod/waw/knife/swing/melee_swing_sm_01.mp3",
	"weapons/tfa_cod/waw/knife/swing/melee_swing_sm_02.mp3",
}, ")")

TFA.AddSound("TFA.WAW.KNIFE.Hit", CHAN_STATIC, 1, 75, 100, {
	"weapons/tfa_cod/waw/knife/hit_other/hit_other_00.mp3",
	"weapons/tfa_cod/waw/knife/hit_other/hit_other_01.mp3",
	"weapons/tfa_cod/waw/knife/hit_other/hit_other_02.mp3",
	"weapons/tfa_cod/waw/knife/hit_other/hit_other_03.mp3",
}, ")")

TFA.AddSound("TFA.WAW.KNIFE.Slash", CHAN_STATIC, 1, 75, 100, {
	"weapons/tfa_cod/waw/knife/slash/knife_slash_00.mp3",
	"weapons/tfa_cod/waw/knife/slash/knife_slash_01.mp3",
	"weapons/tfa_cod/waw/knife/slash/knife_slash_02.mp3",
}, ")")

TFA.AddSound("TFA.WAW.KNIFE.Stab", CHAN_STATIC, 1, 75, 100, {
	"weapons/tfa_cod/waw/knife/stab/knife_stab_00.mp3",
	"weapons/tfa_cod/waw/knife/stab/knife_stab_01.mp3",
	"weapons/tfa_cod/waw/knife/stab/knife_stab_02.mp3",
	"weapons/tfa_cod/waw/knife/stab/knife_stab_03.mp3",
}, ")")

TFA.AddSound("TFA.WAW.KNIFE.Pull", CHAN_STATIC, 1, 75, 100, {
	"weapons/tfa_cod/waw/knife/pull/knife_pull_00.mp3",
	"weapons/tfa_cod/waw/knife/pull/knife_pull_01.mp3",
	"weapons/tfa_cod/waw/knife/pull/knife_pull_02.mp3",
	"weapons/tfa_cod/waw/knife/pull/knife_pull_03.mp3",
}, ")")
