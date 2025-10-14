function nzMapping:SpawnWeaponLocker(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_weaponlocker")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.price ~= nil then
		ent:SetPrice(tonumber(data.price))
	end
	if data.boxlist ~= nil then
		ent:SetUseBoxList(tobool(data.boxlist))
	end
	if data.elec ~= nil then
		ent.Elec = tobool(data.elec)
		ent:SetElectric(tobool(data.elec))
	end
	if data.sound1 and file.Exists("sound/"..data.sound1, "GAME") then
		ent.OpenSound = Sound(data.sound1)
	else
		ent.OpenSound = Sound("zmb/tranzit/locker/fridge_locker_open.wav")
	end
	if data.sound2 and file.Exists("sound/"..data.sound2, "GAME") then
		ent.CloseSound = Sound(data.sound2)
	else
		ent.CloseSound = Sound("zmb/tranzit/locker/fridge_locker_close.wav")
	end
	if data.model and util.IsValidModel(data.model) then
		ent:SetModel(tostring(data.model))
	else
		ent:SetModel("models/zmb/bo2/tranzit/zm_weapon_locker.mdl")
	end
	if data.blacklist then
		ent.BlacklistWeapons = data.blacklist
	end
	if data.collision ~= nil then
		if data.collision then
			ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
		else
			ent:SetCollisionGroup(COLLISION_GROUP_NONE)
		end
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Weapon Locker")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect")
	end

	return ent
end
