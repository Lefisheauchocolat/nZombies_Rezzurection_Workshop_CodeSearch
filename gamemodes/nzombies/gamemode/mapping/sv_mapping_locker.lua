function nzMapping:SpawnKeySpawn(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_keyspawn")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.keysound and file.Exists("sound/"..data.keysound, "GAME") then
		ent.ActivateSound = Sound(data.keysound)
	else
		ent.ActivateSound = Sound("zmb/alcatraz/master_key_pickup_lng.wav")
	end
	if data.keymodel and util.IsValidModel(data.keymodel) then
		ent:SetModel(tostring(data.keymodel))
	else
		ent:SetModel("models/zmb/bo2/alcatraz/zm_al_key.mdl")
	end
	if data.consume ~= nil then
		ent:SetSingleUse(tobool(data.consume))
	end
	if data.flag and data.flag ~= "" then
		ent:SetFlag(tostring(data.flag))
	end
	if data.keytext ~= nil then
		local pickuptext = string.sub(tostring(data.keytext), 1, 48)
		if pickuptext == "" then pickuptext = "Pickup key" end

		ent:SetPickupHint(pickuptext)
	else
		ent:SetPickupHint("Pickup key")
	end
	if data.keyicon and file.Exists("materials/"..data.keyicon, "GAME") then
		ent:SetHudIcon(tostring(data.keyicon))
	else
		ent:SetHudIcon("vgui/icon/zom_hud_icon_key.png")
	end
	if data.glowcolor ~= nil then
		ent:SetCustomGlow(data.glowcolor)
	else
		ent:SetCustomGlow(Vector(1, 0.94, 0.59))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Key Spawn")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end

function nzMapping:SpawnLocker(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_locker")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.time then
		ent:SetTime(tonumber(data.time))
	end
	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.door then
		ent:SetDoorFlag(tostring(data.door))
	end
	if data.lockflag and data.lockflag ~= "" then
		ent:SetFlag(tostring(data.lockflag))
	end
	if data.elec then
		ent.Elec = tobool(data.elec)
		ent:SetElectric(tobool(data.elec))
	end
	if data.sound and file.Exists("sound/"..data.sound, "GAME") then
		ent.ActivateSound = Sound(data.sound)
	else
		ent.ActivateSound = Sound("zmb/alcatraz/master_key_open.wav")
	end
	if data.model and util.IsValidModel(data.model) then
		ent:SetModel(tostring(data.model))
	end
	if data.text ~= nil then
		local pickuptext = string.sub(tostring(data.text), 1, 48)
		if pickuptext == "" then pickuptext = "Unlock" end

		ent:SetPickupHint(pickuptext)
	else
		ent:SetPickupHint("Unlock")
	end
	if data.dofx ~= nil then
		ent.DoCustomEffects = tobool(data.dofx)
	else
		ent.DoCustomEffects = true
	end
	if data.class then
		ent:SetLockerClass(tostring(data.class))
	else
		ent:SetLockerClass("")
	end

	ent:Spawn()

	if data.dofx ~= nil then
		ent.DoCustomEffects = tobool(data.dofx)
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Door Lock")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end