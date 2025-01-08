function nzMapping:KillstreakChopperPath(pos, ang, ply)
	local p = ents.Create( "bo6_choppergunner_point" )
	p:SetPos(pos)
	p:SetAngles(ang)
	p:Spawn()

	if ply then
		undo.Create("Chopper Gunner Path")
			undo.SetPlayer( ply )
			undo.AddEntity( p )
		undo.Finish()
	end
	
	return p
end

function nzMapping:KillstreakHellstormPath(pos, ang, ply)
	local p = ents.Create( "bo6_hellstorm_point" )
	p:SetPos(pos)
	p:SetAngles(ang)
	p:Spawn()

	if ply then
		undo.Create("Hellstorm Spawnpoint")
			undo.SetPlayer( ply )
			undo.AddEntity( p )
		undo.Finish()
	end
	
	return p
end