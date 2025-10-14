function nzMapping:SpawnShovel(pos, ang, ply)
	local ent = ents.Create("nz_tool_shovel")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Shovel Spawn")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end

function nzMapping:SpawnDigSite(pos, ang, ply, data)
	if not data then return end

	if data.override and data.part and data.class then
		data.part = math.Clamp(tonumber(data.part), 1, #nzBuilds:GetBuildParts(tostring(data.class)))
	end

	local ent = ents.Create("nz_digsite")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.override and data.class then
			ent:SetBuildable(tostring(data.class))
		end
		if data.override and data.part then
			ent:SetPartID(tonumber(data.part))
		end
		if data.override then
			ent:SetOverride(tobool(data.override))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Dig Site Spawn")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
