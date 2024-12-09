-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

function nzMapping:ExfilLandingPos(pos, ang, ply)
	local ex = ents.Create( "bo6_exfil_point" )
	ex:SetPos(pos)
	ex:SetAngles(ang)
	ex:Spawn()

	if ply then
		undo.Create("Exfil Landing Zone")
			undo.SetPlayer( ply )
			undo.AddEntity( ex )
		undo.Finish()
	end
	
	return ex
end

function nzMapping:ExfilRadioPos(pos, ang, ply)
	local ex = ents.Create( "bo6_exfil_radio" )
	ex:SetPos(pos)
	ex:SetAngles(ang)
	ex:Spawn()

	if ply then
		undo.Create("Exfil Radio")
			undo.SetPlayer( ply )
			undo.AddEntity( ex )
		undo.Finish()
	end
	
	return ex
end