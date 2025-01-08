game.AddParticles( "particles/snowman_essence.pcf" )
PrecacheParticleSystem( "snowman_cloud" )

game.AddParticles( "particles/alien_swarm/asw_weapon_fx.pcf" )
PrecacheParticleSystem( "asw_fast_reload" )

sound.Add({
	name = 			"NZ.UGX.Present.Open",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"nzr/2024/present_box/open.wav"
})

sound.Add({
	name = 			"NZ.UGX.Present.Close",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"nzr/2024/present_box/close.wav"
})

sound.Add({
	name = 			"NZ.UGX.Present.Land",
	channel = 		CHAN_AUTO,
	volume = 		1,
	sound = 			"nzr/2024/present_box/land.wav"
})