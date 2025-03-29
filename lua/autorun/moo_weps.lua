
local nzombies = engine.ActiveGamemode() == "nzombies"

if nzombies then
	--local wep = ply:GetActiveWeapon()
    hook.Add("InitPostEntity", "TacticoolMFW", function()
		nzSpecialWeapons:AddKnife("nz_knife_aw", false, 0.7)	
    end)
end

sound.Add({
	name = 			"TFA_MOO_AW_KNIFE.SWING",			
	channel = 		CHAN_WEAPON + 10,
	volume = 		1.0,
	pitch = 		{95,105},
	sound = 		{ 
		"tfa/moo/cod/s1/tactical_knife/wpn_knife_pullout_blade_01.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_knife_pullout_blade_02.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_knife_pullout_blade_03.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_knife_pullout_blade_04.ogg", 
	}
})

sound.Add({
	name = 			"TFA_MOO_AW_KNIFE.STAB",			
	channel = 		CHAN_WEAPON + 11,
	volume = 		1.0,
	pitch = 		{95,105},
	sound = 		{ 
		"tfa/moo/cod/s1/tactical_knife/wpn_tac_knife_stab_01.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_tac_knife_stab_02.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_tac_knife_stab_03.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_tac_knife_stab_04.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_combatknife_stab_01.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_combatknife_stab_02.ogg", 
		"tfa/moo/cod/s1/tactical_knife/wpn_combatknife_stab_03.ogg", 
	}
})
