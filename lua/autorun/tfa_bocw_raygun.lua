TFA.AddFireSound("TFA_BOCW_RAYGN.Shoot", {"weapons/tfa_bocw/raygun/wpn_raygun_fire.wav"}, true, ")")
TFA.AddFireSound("TFA_BOCW_RAYGN.Act", {"weapons/tfa_bocw/raygun/wpn_raygun_fire_act.wav"}, false, ")")

TFA.AddWeaponSound("TFA_BOCW_RAYGN.Raise", "weapons/tfa_bocw/raygun/wpn_ray_1straise.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.Dial", "weapons/tfa_bocw/raygun/wpn_ray_1straise_dial.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.Open", "weapons/tfa_bocw/raygun/wpn_ray_reload_open.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.Close", "weapons/tfa_bocw/raygun/wpn_ray_reload_close.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.BatOut", "weapons/tfa_bocw/raygun/wpn_ray_reload_battery_out.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.BatIn", "weapons/tfa_bocw/raygun/wpn_ray_reload_battery.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.Inspect1", "weapons/tfa_bocw/raygun/wpn_ray_inspect.wav")
TFA.AddWeaponSound("TFA_BOCW_RAYGN.Trail", "weapons/tfa_bocw/raygun/wpn_ray_loop.wav")
TFA.AddWeaponSound("TFA_BO4_RAYGUN.PickUp", "weapons/tfa_bo4/raygun/xsound_e11b8baca21d1cb.wav")

sound.Add( {
	name = "TFA_BOCW_RAYGN.Expl",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = { 100 },
	sound = "weapons/tfa_bocw/raygun/wpn_ray_exp.wav"
} )