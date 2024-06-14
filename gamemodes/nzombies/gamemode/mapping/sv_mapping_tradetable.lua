function nzMapping:SpawnTradeTable(pos, ang, ply, data)
	local ent = ents.Create("nz_tradetable")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.price then
			ent:SetPrice(tonumber(data.price))
		end
		if data.offset then
			ent.WeaponOffset = tonumber(data.offset)
		end
		if data.specials ~= nil then
			ent:SetAllowWonder(tobool(data.specials))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Trading Table")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end
