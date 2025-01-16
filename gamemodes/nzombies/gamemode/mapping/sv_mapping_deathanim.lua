-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

function nzMapping:DeathAnimPos(pos, ang, ply)
	local da = ents.Create( "bo6_deathanim_point" )
	da:SetPos(pos)
	da:SetAngles(ang or Angle(0,0,0))
	da:Spawn()

	if ply then
		undo.Create("Death Anim Position")
			undo.SetPlayer( ply )
			undo.AddEntity( da )
		undo.Finish()
	end
	
	return da
end