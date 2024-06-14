function nzMapping:Radio(pos, ang, data, ply, labymoment)
	local ent = ents.Create("nz_radio")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if labymoment and file.Exists("sound/"..labymoment, "GAME") then
		ent:SetRadio(Sound(labymoment))
	elseif data and data.sound and file.Exists("sound/"..data.sound, "GAME") then
		ent:SetRadio(Sound(data.sound))
	else
		ent:SetRadio(Sound("ambient/levels/launch/rockettakeoffblast.wav"))
	end

	if data then
		if data.door then
			ent:SetDoor(tobool(data.door))
		end
		if data.flag then
			ent:SetFlag(tostring(data.flag))
		end
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.nomodel then
			ent:SetNoModel(tobool(data.nomodel))
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Radio")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect")
	end

	return ent
end