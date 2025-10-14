function nzMapping:SpawnWeaponPickup(pos, ang, ply, data)
	if not data then return end
	if not data.class or not weapons.Get(data.class) then return end

	local ent = ents.Create("nz_weaponpickup")
	ent:SetModel("models/dav0r/hoverball.mdl")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.class then
		ent:SetGun(tostring(data.class))
	end
	if data.givetype then
		ent:SetGiveType(tonumber(data.givetype))
	end
	if data.addtobox ~= nil then
		ent:SetBoxWeapon(tobool(data.addtobox))
	end
	if data.weight then
		ent.WeaponWeight = tonumber(data.weight)
	end
	if data.reqclass then
		ent:SetRequiredGun(tostring(data.reqclass))
	end
	if data.doorflag then
		ent:SetDoorFlag(tostring(data.doorflag))
	end
	if data.hide ~= nil then
		ent:SetDoHide(tobool(data.hide))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Weapon Pickup Spawn")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
