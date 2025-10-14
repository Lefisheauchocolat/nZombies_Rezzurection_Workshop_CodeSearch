function nzMapping:SpawnWeaponChalk(pos, ang, ply, data)
	if not data then return end
	if not data.class or not weapons.Get(data.class) then return end

	local ent = ents.Create("nz_weaponchalk")
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:SetWepClass(data.class)

	if data.price then
		ent:SetPrice(tonumber(data.price))
	end
	if data.icon and file.Exists("materials/"..data.icon, "GAME") then
		ent:SetHudIcon(tostring(data.icon))
	else
		ent:SetHudIcon("vgui/icon/zom_hud_icon_buildable_weap_chalk.png")
	end
	if data.points ~= nil then
		ent:SetPoints(tonumber(data.points))
	else
		ent:SetPoints(1000)
	end

	ent:Spawn()

	if data.flipped ~= nil then
		ent:SetFlipped(tobool(data.flipped))
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Weapon Chalk")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect")
	end

	return ent
end

function nzMapping:SpawnBlankChalk(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_blankchalk")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.nochalk then
		ent:SetNoChalk(tobool(data.nochalk))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Blank Chalk")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect")
	end

	return ent
end