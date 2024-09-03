function nzMapping:SuitCharger(pos, ang, data, ply)
	local ent = ents.Create("item_suitcharger")

	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.spawnflag and data.spawnflag > 0 then
			ent:SetKeyValue("spawnflags", tostring(data.spawnflag))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("SuitCharger")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( sound ) .. ")")
	end

	return ent
end
