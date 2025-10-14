function nzMapping:SpawnAmmomatic(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_ammo_matic")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.price then
		ent:SetPrice(math.max(tonumber(data.price), 1000))
	end
	if data.cooldown then
		ent:SetTotalCooldown(math.max(tonumber(data.cooldown), 30))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Amm-O-Matic")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
