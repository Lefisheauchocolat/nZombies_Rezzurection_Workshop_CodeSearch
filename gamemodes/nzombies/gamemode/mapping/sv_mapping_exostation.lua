function nzMapping:ExoStation(pos, ang, ply)
	local t = ents.Create( "aw_exostation" )
	t:SetPos(pos)
	t:SetAngles(ang)
	t:Spawn()

	if ply then
		undo.Create("Exostation")
			undo.SetPlayer( ply )
			undo.AddEntity( t )
		undo.Finish()
	end
	
	return t
end