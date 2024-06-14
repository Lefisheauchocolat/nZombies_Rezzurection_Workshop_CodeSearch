local function AddFile( fn )
	return game.AddParticles("particles/" .. fn .. ".pcf")
end

AddFile("tfa_bo3_enforcer_efx")

PrecacheParticleSystem("enforcer_efx")
PrecacheParticleSystem("enforcer_top_efx")