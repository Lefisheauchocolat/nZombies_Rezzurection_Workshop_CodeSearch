
function nzMapping:ZedVignSpawn(pos, angle, data, ply)

	local ent = ents.Create("nz_spawn_zombie_vign")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	
	ent:Spawn()
	if data then
		if data.spawntype ~= nil then
			ent:SetSpawnType(data.spawntype)
		end

		if data.zombietype ~= nil then
			ent:SetZombieType(data.zombietype)
		else
			ent:SetZombieType("none")
		end

		if data.spawnchance ~= nil then
			ent:SetSpawnChance(tonumber(data.spawnchance))
		else
			ent:SetSpawnChance(100)
		end

		if data.instantawake ~= nil then
			ent:SetInstantAwake(tobool(data.instantawake))
		else
			ent:SetInstantAwake(false)
		end

		if data.awakeradius ~= nil then
			ent:SetAwakeRadius(tonumber(data.awakeradius))
		else
			ent:SetAwakeRadius(175)
		end

		if data.link ~= nil then
			ent:SetLink(tostring(data.link))
			ent.link = tostring(data.link)
		end
		if data.link2 ~= nil then
			ent:SetLink2(tostring(data.link2))
			ent.link2 = tostring(data.link2)
		end
		if data.link3 ~= nil then
			ent:SetLink3(tostring(data.link3))
			ent.link3 = tostring(data.link3)
		end
	end

	if ply then
		undo.Create( "Environmental Zombie Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end
