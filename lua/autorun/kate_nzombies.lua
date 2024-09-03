

local nzombies = engine.ActiveGamemode() == "nzombies"

if nzombies then
    hook.Add("InitPostEntity", "katelynn_knives_in_multicolor_crayon_smileyface", function()
        nzSpecialWeapons:AddKnife( "tfa_moo_combatknife_wwii", false, 0.6 )
		nzSpecialWeapons:AddKnife( "tfa_moo_pushdagger_wwii", false, 0.6 )
		nzSpecialWeapons:AddKnife( "tfa_moo_shovel_wwii", false, 0.65 )
		nzSpecialWeapons:AddKnife( "tfa_moo_trenchknife_wwii", false, 0.6 )
    end)
end