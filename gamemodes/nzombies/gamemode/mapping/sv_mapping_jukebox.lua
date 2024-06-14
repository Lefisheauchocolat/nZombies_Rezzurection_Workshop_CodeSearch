function nzMapping:Jukebox(pos, ang, data, ply)
	local ent = ents.Create("nz_jukebox")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Jukebox")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( sound ) .. ")")
	end

	return ent
end