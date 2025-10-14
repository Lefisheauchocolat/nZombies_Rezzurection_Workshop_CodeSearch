function nzMapping:SpawnSoulBox(pos, ang, ply, data)
	local ent = ents.Create("nz_soulbox")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.flag then
			ent:SetFlag(tonumber(data.flag))
		end
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.reward then
			ent:SetRewardType(tonumber(data.reward))
		end
		if data.souls then
			ent:SetSoulCost(tonumber(data.souls))
		end
		if data.range then
			ent.Range = tonumber(data.range)
		end
		if data.killall then
			ent.KillAll = tobool(data.killall)
		end
		if data.elec then
			ent.Elec = tobool(data.elec)
			ent:SetElectric(tobool(data.elec))
		end
		if data.limited then
			ent:SetLimited(tobool(data.limited))
		end
		if data.aoe then
			ent:SetAOE(tonumber(data.aoe))
		end
		if data.door then
			ent:SetDoorFlag(tostring(data.door))
		end
		if data.weapon then
			ent:SetWepClass(tostring(data.weapon))
		end
		if data.powerup then
			ent:SetGivePowerup(tobool(data.powerup))
		end
		if data.skin then
			ent:SetSkin(tonumber(data.skin))
		end
		if data.specials then
			ent:SetSpecials(tobool(data.specials))
		end
		if data.sound and file.Exists("sound/"..data.sound, "GAME") then
			ent.ActivateSound = Sound(data.sound)
		else
			ent.ActivateSound = Sound("zmb/tomb/evt_souls_full.wav")
		end
		if data.class and (nzConfig.ValidEnemies[tostring(data.class)] or nzRound.BossData[tostring(data.class)]) then
			ent:SetZombieClass(tostring(data.class))
		end
		if data.collision then
			ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
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
			ent.CompletedText = "Soul Box completed!"
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Soul Box")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
