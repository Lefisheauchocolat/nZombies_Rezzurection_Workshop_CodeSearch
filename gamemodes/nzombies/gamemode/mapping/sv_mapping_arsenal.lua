function nzMapping:Arsenal(pos, ang, ply)
	local ar = ents.Create( "bo6_arsenal" )
	ar:SetPos(pos)
	ar:SetAngles(ang)
	ar:Spawn()

	if ply then
		undo.Create("Arsenal")
			undo.SetPlayer( ply )
			undo.AddEntity( ar )
		undo.Finish()
	end
	
	return ar
end