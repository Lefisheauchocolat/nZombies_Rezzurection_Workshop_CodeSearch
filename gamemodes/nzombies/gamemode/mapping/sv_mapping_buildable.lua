function nzMapping:SpawnBuildTable(pos, ang, ply, data)
	if not data then return end
	if not data.class then return end

	local ent = ents.Create("nz_buildtable")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.class then
		ent:SetBuildable(tostring(data.class))
	end
	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.weight then
		ent.WeaponWeight = tonumber(data.weight)
	end
	if data.oldsound ~= nil then
		ent.ClassicSounds = tobool(data.oldsound)
	end
	if data.notable ~= nil then
		ent.HideTableModel = tobool(data.notable)
	end
	if data.collision then
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	ent:Spawn()

	if data.style then
		ent:SetBodygroup(0, tonumber(data.style))
	end
	if data.weight then
		ent.WeaponWeight = tonumber(data.weight)
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Buildable Table")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end

function nzMapping:SpawnBuildPart(pos, ang, ply, data)
	if not data then return end
	if not data.class then return end
	if not data.part then return end

	local parttab = nzBuilds:GetBuildParts(tostring(data.class))
	if not parttab then return end
	local id = tonumber(data.part)

	local ent = ents.Create("nz_buildable")
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetModel(tostring(parttab[id].mdl))

	ent:SetBuildable(tostring(data.class))
	ent:SetPartID(id)

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Buildable Part")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
