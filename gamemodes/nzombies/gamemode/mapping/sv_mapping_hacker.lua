function nzMapping:HackerSpawner(pos, ang, ply)
	local ent = ents.Create("nz_bo3_hacker_spawn")
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Hacker Spawn")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end

function nzMapping:HackerButton(pos, ang, ply, data)
	if not data then return end
	local ent = ents.Create("nz_bo3_hackerbutton")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.time then
		ent:SetTime(tonumber(data.time))
	end
	if data.elec ~= nil then
		ent:SetElectric(tobool(data.elec))
	end
	if data.flag then
		ent:SetFlag(tostring(data.flag))
	end
	if data.hide ~= nil then
		ent:SetDoHide(tobool(data.hide))
	end
	if data.revealdoor then
		ent:SetDoorFlag(tostring(data.revealdoor))
	end
	if data.glowsprite ~= nil then
		ent:SetDoSprite(tobool(data.glowsprite))
	end
	if data.glowcolor then
		ent:SetGlowColor(data.glowcolor)
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Hacker Button")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect")
	end

	return ent
end
