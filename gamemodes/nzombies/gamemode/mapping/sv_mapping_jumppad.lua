function nzMapping:SpawnLaunchPad(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_launchpad")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.flag then
		ent:SetFlag(tonumber(data.flag))
	end
	if data.cooldown then
		ent:SetCooldown(math.max(tonumber(data.cooldown), 2))
	end
	if data.airtime then
		ent:SetAirTime(tonumber(data.airtime))
	end
	if data.elec then
		ent.Elec = tobool(data.elec)
		ent:SetElectric(tobool(data.elec))
	end
	if data.req then
		ent:SetRequireActive(tobool(data.req))
	end
	if data.model1 and util.IsValidModel(data.model1) then
		ent:SetModel(tostring(data.model1))
	end

	ent:Spawn()

	if data.elec then
		ent.Elec = tobool(data.elec)
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Launch Pad")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end

function nzMapping:SpawnLandingPad(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_landingpad")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.flag then
		ent:SetFlag(tonumber(data.flag))
	end
	if data.req then
		ent:SetRequireActive(tobool(data.req))
	end
	if data.model2 and util.IsValidModel(data.model2) then
		ent:SetModel(tostring(data.model2))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Landing Pad")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end