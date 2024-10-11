function nzMapping:SpawnDerWunder(pos, ang, ply, data)
	local ent = ents.Create("nz_derwunder")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.fizzlist then
			ent.UseFizzlist = tobool(data.fizzlist)
		end
	end

	ent:Spawn()

	if data then
		if data.fizzlist then
			ent.UseFizzlist = tobool(data.fizzlist)
		end
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("ColdWunderfizz")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end
