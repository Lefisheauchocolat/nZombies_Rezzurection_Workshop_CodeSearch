-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

function nzMapping:InfilPos(pdata, sdata, ply)
	local inf = ents.Create( "bo6_infil_point" )
	inf:SetPos(pdata[1])
	inf:SetAngles(pdata[2])
	inf.type = sdata.infiltype
	inf.chief = sdata.infilchief
	inf:Spawn()

	if ply then
		undo.Create("Infil Position")
			undo.SetPlayer( ply )
			undo.AddEntity( inf )
		undo.Finish()
	end
	
	return inf
end