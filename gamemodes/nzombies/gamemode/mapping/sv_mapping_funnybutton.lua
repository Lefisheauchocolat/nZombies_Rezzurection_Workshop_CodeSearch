function nzMapping:SpawnFunnyButton(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_funnybutton")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.model and util.IsValidModel(data.model) then
		ent:SetModel(tostring(data.model))
	end
	if data.door then
		ent:SetDoorFlag(tostring(data.door))
	end
	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.elec then
		ent.Elec = tobool(data.elec)
		ent:SetElectric(tobool(data.elec))
	end
	if data.glow then
		ent:SetGlow(tobool(data.glow))
	end
	if data.sound and file.Exists("sound/"..data.sound, "GAME") then
		ent.ActivateSound = Sound(data.sound)
	else
		ent.ActivateSound = Sound("zmb/moon/comp_activate.wav")
	end
	if data.timed then
		ent:SetTimed(tobool(data.timed))
	end
	if data.time then
		ent:SetTimeLimit(tonumber(data.time))
	end
	if data.glowcolor ~= nil then
		ent:SetGlowColor(data.glowcolor)
	else
		ent:SetGlowColor(Vector(1,0,0))
	end
	if data.hide ~= nil then
		ent:SetHideOnUse(tobool(data.hide))
	end

	local pickuptext = data.text
	if pickuptext then
		pickuptext = string.sub(tostring(pickuptext), 1, 48)
		if pickuptext == "" then pickuptext = "Activate" end

		ent:SetPickupHint(pickuptext)
	else
		ent:SetPickupHint("Activate")
	end

	local doortext = data.doortext
	if doortext then
		ent.DoorOpenText = tostring(doortext)
	else
		ent.DoorOpenText = "A door somewhere has opened..."
	end

	local completetext = data.completetext
	if completetext then
		ent.CompletedText = tostring(completetext)
	else
		ent.CompletedText = "All buttons pressed!"
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Funny Button")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect ()")
	end

	return ent
end
