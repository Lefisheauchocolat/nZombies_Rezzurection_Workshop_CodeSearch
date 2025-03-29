-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

function nzMapping:HumanPos(pos, ang, data, ply)
	local p = ents.Create( "bo6_human_point" )
	p:SetSpawnerData(data)
	p:SetPos(pos)
	p:SetAngles(ang)
	p:Spawn()

	if ply then
		undo.Create("Human Spawner")
			undo.SetPlayer( ply )
			undo.AddEntity( p )
		undo.Finish()
	end
	
	return p
end