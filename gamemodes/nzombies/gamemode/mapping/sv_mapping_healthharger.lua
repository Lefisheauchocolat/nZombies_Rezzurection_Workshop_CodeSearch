function nzMapping:HealthCharger(pos, ang, data, ply)
	local ent = ents.Create("item_healthcharger")

	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.delay and data.delay > 0 then
			ent:SetKeyValue("dmdelay", tostring(data.delay))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("HealthCharger")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( sound ) .. ")")
	end

	return ent
end
