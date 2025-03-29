--
function nzMapping:ZedSpawn(pos, angle, link, link2, link3, master, spawntype, zombietype, roundactive, spawnchance, miscspawn, totalspawn, aliveamount, ply)

	local ent = ents.Create("nz_spawn_zombie_normal")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	
	ent:Spawn()

	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end
	if link2 != nil then
		ent:SetLink2(tostring(link2))
		ent.link2 = tostring(link2)
	end
	if link3 != nil then
		ent:SetLink3(tostring(link3))
		ent.link3 = tostring(link3)
	end

	ent:SetMasterSpawn(master)
	ent:SetMixedSpawn(miscspawn)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if totalspawn ~= nil then
		ent:SetTotalSpawns(tonumber(totalspawn))
	else
		ent:SetTotalSpawns(0)
	end

	if aliveamount ~= nil then
		ent:SetAliveAmount(tonumber(aliveamount))
	else
		ent:SetAliveAmount(0)
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Zombie Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:ZedSpecialSpawn(pos, angle, link, link2, link3, master, spawntype, zombietype, roundactive, spawnchance, ply)

	local ent = ents.Create("nz_spawn_zombie_special")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end
	if link2 != nil then
		ent:SetLink2(tostring(link2))
		ent.link2 = tostring(link2)
	end
	if link3 != nil then
		ent:SetLink3(tostring(link3))
		ent.link3 = tostring(link3)
	end

	ent:SetMasterSpawn(master)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Special Zombie Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:ZedBossSpawn(pos, angle, link, link2, link3, roundactive, ply)

	local ent = ents.Create("nz_spawn_zombie_boss")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end
	if link2 != nil then
		ent:SetLink2(tostring(link2))
		ent.link2 = tostring(link2)
	end
	if link3 != nil then
		ent:SetLink3(tostring(link3))
		ent.link3 = tostring(link3)
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if ply then
		undo.Create( "Boss Zombie Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

--[[
function nzMapping:ZedExtraSpawn1(pos, angle, link, master, spawntype, zombietype, roundactive, spawnchance, ply)

	local ent = ents.Create("nz_spawn_zombie_extra1")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end

	ent:SetMasterSpawn(master)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Extra Zombie 1 Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:ZedExtraSpawn2(pos, angle, link, master, spawntype, zombietype, roundactive, spawnchance, ply)

	local ent = ents.Create("nz_spawn_zombie_extra2")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end

	ent:SetMasterSpawn(master)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Extra Zombie 2 Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:ZedExtraSpawn3(pos, angle, link, master, spawntype, zombietype, roundactive, spawnchance, ply)

	local ent = ents.Create("nz_spawn_zombie_extra3")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end

	ent:SetMasterSpawn(master)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Extra Zombie 3 Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:ZedExtraSpawn4(pos, angle, link, master, spawntype, zombietype, roundactive, spawnchance, ply)

	local ent = ents.Create("nz_spawn_zombie_extra4")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	if angle ~= nil then -- Just incase something stupid happens.
		ent:SetAngles( angle )
	else
		ent:SetAngles(Angle(0,0,0))
	end
	ent:Spawn()
	-- For the link displayer
	if link != nil then
		ent:SetLink(tostring(link))
		ent.link = tostring(link)
	end

	ent:SetMasterSpawn(master)

	if spawntype ~= nil then
		ent:SetSpawnType(spawntype)
	end

	if zombietype ~= nil then
		ent:SetZombieType(zombietype)
	else
		ent:SetZombieType("none")
	end

	if roundactive ~= nil then
		ent:SetActiveRound(tonumber(roundactive))
	else
		ent:SetActiveRound(0)
	end

	if spawnchance ~= nil then
		ent:SetSpawnChance(tonumber(spawnchance))
	else
		ent:SetSpawnChance(100)
	end

	if ply then
		undo.Create( "Extra Zombie 4 Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end
]]

function nzMapping:PlayerSpawn(pos, angle, data, ply)
	local ent = ents.Create("player_spawns")
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos(pos)
	ent:SetAngles(angle or Angle(0,0,0))

	if data then
		if data.dooractivate ~= nil then
			ent:SetDoorActivated(tobool(data.dooractivate))
		end
		if data.activatetype then
			ent:SetDoorActivateType(tonumber(data.activatetype))
		end
		if data.doorflag then
			ent:SetDoorFlag(tostring(data.doorflag))
		end
		if data.doorflag2 then
			ent:SetDoorFlag2(tostring(data.doorflag2))
		end
		if data.doorflag3 then
			ent:SetDoorFlag3(tostring(data.doorflag3))
		end
		if data.preferred ~= nil then
			ent:SetPreferred(tobool(data.preferred))
		end
	end

	ent:Spawn()

	if ply then
		undo.Create( "Player Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:EasterEgg(pos, ang, tab, ply)
	local egg = ents.Create( "easter_egg" )
	egg:SetPos( pos )
	egg:SetAngles( ang )
	egg:Spawn()

	if tab.model then
		egg:SetModel(tab.model)
	end

	local phys = egg:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Easter Egg" )
			undo.SetPlayer( ply )
			undo.AddEntity( egg )
		undo.Finish( "Effect" )
	end
	return egg
end

function nzMapping:StinkyLever(pos, ang, ply)
	local category5 = ents.Create( "stinky_lever" )
	category5:SetPos( pos )
	category5:Setohfuck( false )
	category5:SetAngles( ang )
	category5:Spawn()

	local phys = category5:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Suffering Amplification Device" )
			undo.SetPlayer( ply )
			undo.AddEntity( category5 )
		undo.Finish( "Effect" )
	end
	return category5
end

function nzMapping:Ending(pos, ang, price, ply)
	local ending = ents.Create( "buyable_ending" )
	ending:SetPos( pos )
	ending:SetAngles( ang )
	ending:SetPrice( price )
	ending:Spawn()

	local phys = ending:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Ending" )
			undo.SetPlayer( ply )
			undo.AddEntity( ending )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ending
end

function nzMapping:WallBuy(pos, gun, price, angle, oldent, ply, flipped, showmodel)
	if IsValid(oldent) then oldent:Remove() end

	local ent = ents.Create("wall_buys")
	ent:SetAngles(angle)
	pos.z = pos.z - ent:OBBMaxs().z
	ent:SetPos( pos )
	ent:SetWeapon(gun, price)

	if showmodel ~= nil then
		ent:SetNoChalk(tobool(showmodel))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if flipped != nil then
		ent:SetFlipped(flipped)
	end

	if ply then
		undo.Create( "Wall Gun" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect" )
	end
	return ent

end

function nzMapping:PropBuy(pos, ang, model, flags, ply)
	local prop = ents.Create( "prop_buys" )
	prop:SetModel( model )
	prop:SetPos( pos )
	prop:SetAngles( ang )
	prop:Spawn()
	prop:PhysicsInit( SOLID_VPHYSICS )
	
	local phys = prop:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if flags != nil then
		nzDoors:CreateLink( prop, flags )
	end

	if ply then
		undo.Create( "Prop" )
			undo.SetPlayer( ply )
			undo.AddEntity( prop )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return prop
end

function nzMapping:Electric(pos, ang, data, ply)
	--THERE CAN ONLY BE ONE TRUE HERO, actually thats cap this is my zombie acadummya
	--[[local prevs = ents.FindByClass("power_box")
	if prevs[1] != nil then
		prevs[1]:Remove()
	end]]

	if not data then return end

	local ent = ents.Create( "power_box" )
	ent:SetPos( pos )
	ent:SetAngles( ang )

	if data.limited ~= nil then
		ent:SetLimited(tobool(data.limited))
	end
	if data.aoe ~= nil then
		ent:SetAOE(tonumber(data.aoe))
	else
		ent:SetAOE(1000)
	end

	if data.requireall ~= nil then
		ent:SetRequireAll(tobool(data.requireall))
	end
	if data.reset ~= nil then
		ent:SetDoReset(tobool(data.reset))
	end
	if data.resettime then
		ent:SetResetTime(tonumber(data.resettime))
	end
	if data.model then
		ent:SetPowerSwitchModel(tonumber(data.model))
	end
	if data.activetype then
		ent:SetActivationType(tonumber(data.activetype))
	end
	if data.dmgtype then
		ent:SetDmgType(tonumber(data.dmgtype))
	end

	ent:Spawn()
	ent:PhysicsInit( SOLID_VPHYSICS )

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Power Switch" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

function nzMapping:BlockSpawn(pos, ang, model, flags, ply)
	local block = ents.Create( "wall_block" )
	
	-- Replace with nZombies versions of the same model (if exist) which are grate-based (bullets go through)
	local model2 = string.Replace(model, "/hunter/plates/", "/nzombies_plates/")
	if !util.IsValidModel(model2) then
		model2 = model
	end
	
	block:SetModel( model2 )
	block:SetPos( pos )
	block:SetAngles( ang )
	block:Spawn()
	block:PhysicsInit( SOLID_VPHYSICS )

	-- REMINDER APPLY FLAGS
	if flags != nil then
		nzDoors:CreateLink( block, flags )
	end
	
	local phys = block:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Invisible Block" )
			undo.SetPlayer( ply )
			undo.AddEntity( block )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return block
end

function nzMapping:ZombieBlockSpawn(pos, ang, model, flags, ply)
	local block = ents.Create( "zombie_wall_block" )
	
	-- Replace with nZombies versions of the same model (if exist) which are grate-based (bullets go through)
	local model2 = string.Replace(model, "/hunter/plates/", "/nzombies_plates/")
	if !util.IsValidModel(model2) then
		model2 = model
	end
	
	block:SetModel( model2 )
	block:SetPos( pos )
	block:SetAngles( ang )
	block:Spawn()
	block:PhysicsInit( SOLID_VPHYSICS )

	-- REMINDER APPLY FLAGS
	if flags != nil then
		nzDoors:CreateLink( block, flags )
	end
	
	local phys = block:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Invisible Zombie Block" )
			undo.SetPlayer( ply )
			undo.AddEntity( block )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return block
end

function nzMapping:BoxSpawn(pos, ang, spawn, ply)
	local box = ents.Create( "random_box_spawns" )
	box:SetPos( pos )
	box:SetAngles( ang )
	box:Spawn()
	box:PhysicsInit( SOLID_VPHYSICS )
	box:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	box.PossibleSpawn = spawn

	if ply then
		undo.Create( "Random Box Spawnpoint" )
			undo.SetPlayer( ply )
			undo.AddEntity( box )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return box
end

function nzMapping:SpawnPowerupSpawner(pos, ang, ply, data)
	if not data then return end
	if not data.powerup then return end

	local pdata = nzPowerUps:Get(data.powerup)
	if not pdata then return end

	local ent = ents.Create("powerup_spawner")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.powerup then
		ent:SetPowerUp(tostring(data.powerup))
	end
	if data.randomize ~= nil then
		ent:SetRandomize(tobool(data.randomize))
	end
	if data.randomizeround then
		ent:SetRandomizeRound(tonumber(data.randomizeround))
	end
	if data.scroll ~= nil then
		ent:SetDoScroll(tobool(data.scroll))
	end
	if data.scrollrate then
		ent:SetScrollTime(tonumber(data.scrollrate))
	end
	if data.scrollraterare then
		ent:SetScrollTimeRare(tonumber(data.scrollraterare))
	end
	if data.scrollsequential then
		ent:SetSequential(tobool(data.scrollsequential))
	end
	if data.door ~= nil then
		ent:SetDoor(tobool(data.door))
	end
	if data.doorflag then
		ent:SetDoorFlag(tostring(data.doorflag))
	end

	ent:Spawn()

	/*local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end*/

	if ply then
		undo.Create("Powerup Spawner")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect ()")
	end

	return ent
end

function nzMapping:PerkCratePile(pos, ang, data, oldperk)
	if not data then return end

	local perk = ents.Create("perk_cratepile")
	perk:SetPos(pos)
	perk:SetAngles(ang)
	perk.PerkData = data
	perk.StoredPerk = oldperk
	perk:Spawn()
	perk.StoredPerk = oldperk

	local phys = perk:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	return perk
end

function nzMapping:PerkMachine(pos, ang, data, ply, fizzprice)
	if not data then return end

	if istable(data) then
		if not data.id then return end

		if data.id == "wunderfizz" then
			local perk = ents.Create("wunderfizz_machine")
			perk:SetPos(pos)
			perk:SetAngles(ang)

			if data.price and data.price > 0 then
				perk.PriceOverride = tonumber(data.price)
			end

			perk:Spawn()
			perk:Activate()
			perk:PhysicsInit( SOLID_VPHYSICS )
			perk:TurnOff()

			local phys = perk:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion(false)
			end

			if ply then
				undo.Create( "Der Wunderfizz" )
					undo.SetPlayer( ply )
					undo.AddEntity( perk )
				undo.Finish( "Effect (" .. tostring( model ) .. ")" )
			end
			return perk
		else
			local perk = ents.Create("perk_machine")
			perk:SetPerkID(data.id)
			perk:TurnOff()

			if data.random then
				perk:SetRandomize(tobool(data.random))
			end
			if data.fizzlist then
				perk:SetRandomizeFizz(tobool(data.fizzlist))
			end
			if data.randomround then
				perk:SetRandomizeRounds(tobool(data.randomround))
			end
			if data.roundnum then
				perk:SetRandomizeInterval(tonumber(data.roundnum))
			end
			if data.door then
				perk:SetDoorActivated(tobool(data.door))
			end
			if data.doorflag then
				perk.DoorFlag = tostring(data.doorflag)
			end
			if data.doorflag2 then
				perk.DoorFlag2 = tostring(data.doorflag2)
			end
			if data.doorflag3 then
				perk.DoorFlag3 = tostring(data.doorflag3)
			end
			if data.price and data.price > 0 then
				perk.PriceOverride = tonumber(data.price)
			end
			if data.priceupg and data.priceupg > 0 then
				perk.PriceOverrideUpgrade = tonumber(data.priceupg)
			end

			perk:SetPos(pos)
			perk:SetAngles(ang)
			perk:Spawn()
			perk:Activate()
			perk:PhysicsInit( SOLID_VPHYSICS )

			local phys = perk:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion(false)
			end

			if ply then
				undo.Create( "Perk Machine" )
					undo.SetPlayer( ply )
					undo.AddEntity( perk )
				undo.Finish( "Effect (" .. tostring( model ) .. ")" )
			end

			return perk
		end
	elseif data == "wunderfizz" then
		local perk = ents.Create("wunderfizz_machine")
		perk:SetPos(pos)
		perk:SetAngles(ang)

		if fizzprice then
			perk.PriceOverride = fizzprice
		end

		perk:Spawn()
		perk:Activate()
		perk:PhysicsInit(SOLID_VPHYSICS)
		perk:TurnOff()

		local phys = perk:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion(false)
		end

		if ply then
			undo.Create( "Der Wunderfizz" )
				undo.SetPlayer( ply )
				undo.AddEntity( perk )
			undo.Finish( "Effect (" .. tostring( model ) .. ")" )
		end
		return perk
	else
		local perk = ents.Create("perk_machine")
		perk:SetPerkID(data)
		perk:SetPos(pos)
		perk:SetAngles(ang)

		if fizzprice then
			perk.PriceOverride = fizzprice
		end

		perk:Spawn()
		perk:Activate()
		perk:PhysicsInit(SOLID_VPHYSICS)
		perk:TurnOff()

		local phys = perk:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion(false)
		end

		if ply then
			undo.Create( "Perk Machine" )
				undo.SetPlayer( ply )
				undo.AddEntity( perk )
			undo.Finish( "Effect (" .. tostring( model ) .. ")" )
		end
		return perk
	end
end

function nzMapping:BreakEntry(pos, ang, planks, jump, boardtype, prop, jumptype, plycollision, ambsnds, ply)
	local planks = planks
	if planks == nil then planks = true else planks = tobool(planks) end
	local jump = jump
	if jump == nil then jump = false else jump = tobool(jump) end
	local boardtype = boardtype
	if boardtype == nil then boardtype = 1 else boardtype = boardtype end
	local plycollision = plycollision
	if plycollision == nil then plycollision = false else plycollision = tobool(plycollision) end
	if ambsnds == nil then ambsnds = false else ambsnds = tobool(ambsnds) end

	local entry = ents.Create( "breakable_entry" )
	entry:SetPos( pos )
	entry:SetAngles( ang )

	entry:SetHasPlanks( planks )
	entry:SetTriggerJumps( jump )
	entry:SetBoardType( boardtype )
	entry:SetProp( prop )
	entry:SetJumpType( jumptype )
	entry:SetPlayerCollision( plycollision )
	entry:SetAmbientSounds( ambsnds )

	entry:Spawn()
	entry:PhysicsInit( SOLID_VPHYSICS )


	local phys = entry:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Barricade" )
			undo.SetPlayer( ply )
			undo.AddEntity( entry )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return entry
end

function nzMapping:SpawnEffect( pos, ang, model, ply )

	local e = ents.Create("nz_prop_effect")
	e:SetModel(model)
	e:SetPos(pos)
	e:SetAngles( ang )
	e:Spawn()
	e:Activate()
	if ( !IsValid( e ) ) then return end

	if ply then
		undo.Create( "Effect" )
			undo.SetPlayer( ply )
			undo.AddEntity( e )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return e

end
	
--[[function nzMapping:Teleporter( pos, ang,dest,id,price,modeltype,anim,cd,kino, kinodur,buyable, ply )
	print(buyable)

	local tele = ents.Create("nz_teleporter")
	tele:SetPos(pos)
	tele:SetAngles( ang )
	tele:SetDestination(dest)
	tele:SetID(id)
	tele:SetPrice(price)
	tele:SetModelType(modeltype)
	tele:SetGifType(anim)
	tele:SetCooldownTime(cd)
	tele:SetKino(kino)
	tele:SetKinodelay(kinodur)
	tele:SetUsable(buyable)
	tele:TurnOff()
	tele:Spawn()
	local phys = tele:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Teleporter" )
			undo.SetPlayer( ply )
			undo.AddEntity( tele )
		undo.Finish( "Teleporter (" .. tostring( model ) .. ")" )
	end
	return tele

end]]

function nzMapping:Teleporter(data)
	if !data then return end
	local tele = ents.Create("nz_teleporter")
	tele:SetMoveType( MOVETYPE_NONE )
	tele:SetSolid( SOLID_VPHYSICS )
--	tele:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )

	if data.pos != nil then
		tele:SetPos(data.pos)
	end

	if data.angles != nil then
		tele:SetAngles(data.angles)
	end

	if data.flag != nil then
		tele:SetFlag(data.flag)
	end

	if data.destination != nil then
		tele:SetDestination(data.destination)
	end

	if data.requiresdoor != nil then
		tele:SetRequiresDoor(data.requiresdoor)
	end

	if data.door != nil then
		tele:SetDoor(data.door)
	end

	if data.price != nil then
		tele:SetPrice(data.price)
	end

	if data.mdltype != nil then
		tele:SetModelType(data.mdltype)
	end

	if data.mdlcollisions != nil then
		tele:SetModelCollisions(data.mdlcollisions)
	end

	if data.visible != nil then
		tele:SetModelVisible(data.visible)
	end

	if data.useable != nil then
		tele:SetUseable(data.useable)
	end

	if data.gif != nil then
		tele:SetGifType(data.gif)
	end

	if data.teleportertime != nil then
		tele:SetTeleporterTime(data.teleportertime)
	end

	if data.cooldown != nil then
		tele:SetCooldownTime(data.cooldown)
	end

	if data.tpback != nil then
		tele:SetTPBack(tobool(data.tpback))
	end

	if data.tpbackdelay != nil then
		tele:SetTPBackDelay(data.tpbackdelay)
	end

	if data.activatestrap != nil then
		tele:SetActivatesTrap(data.activatestrap)
	end

	if data.trap != nil then
		tele:SetTrap(data.trap)
	end

	-- Compatibility stuff, just so previous NZR config teleporters continue to work
	-- These will not exist for new configs
	-- (not really a fan of these)
	if data.angle != nil then
		tele:SetAngles(data.angle)
	end

	if data.id != nil then
		tele:SetFlag(tostring(data.id))
	end

	if data.desti != nil then
		tele:SetDestination(tostring(data.desti))
	end

	if data.cd != nil then
		tele:SetCooldownTime(data.cd)
	end

	if data.kino != nil then
		tele:SetTPBack(tobool(data.kino))
	end

	if data.delay != nil then
		tele:SetTPBackDelay(data.delay)
	end
	--------------------------------------------------------------------------------

	tele:TurnOff()
	tele:Spawn()

	tele:PhysicsInit( SOLID_VPHYSICS )

	local phys = tele:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if data.ply then
		undo.Create("Teleporter")
		undo.SetPlayer(data.ply)
		undo.AddEntity(tele)
		undo.Finish("Teleporter")
	end

	return tele
end

function nzMapping:SpawnEntity(pos, ang, ent, ply)
	local entity = ents.Create( ent )
	entity:SetPos( pos )
	entity:SetAngles( ang )
	entity:Spawn()
	entity:PhysicsInit( SOLID_VPHYSICS )

	table.insert(nzQMenu.Data.SpawnedEntities, entity)

	entity:CallOnRemove("nzSpawnedEntityClean", function(ent)
		table.RemoveByValue(nzQMenu.Data.SpawnedEntities, ent)
	end)

	if ply then
		undo.Create( "Entity" )
			undo.SetPlayer( ply )
			undo.AddEntity( entity )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return entity
end

function nzMapping:CreateInvisibleWall(vec1, vec2, ply)
	local wall = ents.Create( "invis_wall" )
	wall:SetPos( vec1 ) -- Later we might make the position the center
	--wall:SetAngles( ang )
	--wall:SetMinBound(vec1) -- Just the position for now
	wall:SetMaxBound(vec2)
	wall:Spawn()
	wall:PhysicsInitBox( Vector(0,0,0), vec2 )

	local phys = wall:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Invis Wall" )
			undo.SetPlayer( ply )
			undo.AddEntity( wall )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return wall
end

function nzMapping:CreateInvisibleWallZombie(vec1, vec2, ply)
	local wall = ents.Create( "invis_wall_zombie" )
	wall:SetPos( vec1 ) -- Later we might make the position the center
	--wall:SetAngles( ang )
	--wall:SetMinBound(vec1) -- Just the position for now
	wall:SetMaxBound(vec2)
	wall:Spawn()
	wall:PhysicsInitBox( Vector(0,0,0), vec2 )

	local phys = wall:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Invis Wall Zombie" )
			undo.SetPlayer( ply )
			undo.AddEntity( wall )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return wall
end

function nzMapping:CreateAntiCheatExclusion(vec1, vec2, ply)
	local wall = ents.Create( "anticheat_exclude" )
	wall:SetPos( vec1 ) -- Later we might make the position the center
	--wall:SetAngles( ang )
	--wall:SetMinBound(vec1) -- Just the position for now
	wall:SetMaxBound(vec2)
	wall:Spawn()
	wall:PhysicsInitBox( Vector(0,0,0), vec2 )

	local phys = wall:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Anti-Cheat Exclusion" )
			undo.SetPlayer( ply )
			undo.AddEntity( wall )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return wall
end

function nzMapping:CreateInvisibleDamageWall(vec1, vec2, ply, dmg, delay, dmgtype, respawnz, elec)
	local wall = ents.Create( "invis_damage_wall" )
	wall:SetPos( vec1 )
	wall:SetMaxBound(vec2)

	wall:SetDamage(dmg)
	wall:SetDelay(delay)
	wall:SetRespawnZombie(tobool(respawnz))
	wall:SetDamageWallType(dmgtype or 1)
	wall:SetElectric(elec or false)

	wall:Spawn()
	wall:PhysicsInitBox( Vector(0,0,0), vec2 )
	wall:SetNotSolid(true)
	wall:SetTrigger(true)

	local phys = wall:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Damage Wall" )
			undo.SetPlayer( ply )
			undo.AddEntity( wall )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return wall
end

function nzMapping:CreateDamageIgnoreWall(vec1, vec2, data, ply)
	local wall = ents.Create( "damage_ignore_wall" )
	wall:SetPos( vec1 )
	wall:SetMaxBound(vec2)
	
	if data then
		if data.dmg1 then
			wall:SetDamage(tonumber(data.dmg1))
		end
		if data.dmg2 then
			wall:SetDamage2(tonumber(data.dmg2))
		end
		if data.dmg3 then
			wall:SetDamage3(tonumber(data.dmg3))
		end
	end

	wall:Spawn()
	wall:PhysicsInitBox( Vector(0,0,0), vec2 )
	wall:SetNotSolid(true)
	wall:SetTrigger(true)

	local phys = wall:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Damage Ignore Trigger")
			undo.SetPlayer( ply )
			undo.AddEntity( wall )
		undo.Finish("")
	end
	return wall
end

-- Physgun Hooks
local ghostentities = {
	["prop_buys"] = true,
	["nz_prop_effect"] = true,
	["wall_block"] = true,
	["breakable_entry"] = true,
	["invis_wall"] = true,
	["invis_wall_zombie"] = true,
	["jumptrav_block"] = true,
	["wall_buys"] = true,
	["zombie_wall_block"] = true,
	--["perk_machine"] = true,
}
local function onPhysgunPickup( ply, ent )
	local class = ent:GetClass()
	if ghostentities[class] or ent:ShouldPhysgunNoCollide() then
		-- Ghost the entity so we can put them in walls.
		local phys = ent:GetPhysicsObject()
		phys:EnableCollisions(false)
		phys:Wake()
	end

end

local function onPhysgunDrop( ply, ent )
	local class = ent:GetClass()
	if ghostentities[class] or ent:ShouldPhysgunNoCollide() then
		-- Unghost the entity so we can put them in walls.
		local phys = ent:GetPhysicsObject()
		phys:EnableCollisions(true)
		phys:EnableMotion(false)
		phys:Sleep()
	end

end

hook.Add( "PhysgunPickup", "nz.OnPhysPick", onPhysgunPickup )
hook.Add( "PhysgunDrop", "nz.OnDrop", onPhysgunDrop )
