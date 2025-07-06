-- In here we have all default savemodules. You can add your own with the function used here:
-- nzMapping:AddSaveModule(id, {savefunc, loadfunc, cleanents, cleanfunc, prerestorefunc, postrestorefunc})

-- Savefunc should return the table to be written into the save file

-- Loadfunc takes 1 argument, data, which is the saved table

-- Cleanents is a table containing all entity types that should get cleaned when the config is cleared
-- and that should be spared when the map is cleanup for a simple game reset

-- Cleanfunc is run when the config is wiped, like when switching config or /clean (not after each game)
-- It should remove all entities related to your module that aren't in the cleanents table

-- Prerestorefunc is only used for modules that need to "reinitialize" post-map cleanup (NOT config cleanup, MAP cleanup)
-- This is run before the map cleanup, making you able to temporarily save data to use after the map cleanup again
-- This function should only be used for stuff that needs to mark how it is before map cleanup, to reset to that post-cleanup
-- such as SpecialEntities that need to be temporarily duplicate-saved so they can be spawned afterwards
-- It should return a table that will be used in the postrestorefunc

-- Postrestorefunc is only used for stuff that needs to "reintialize" after the map has been cleaned up, like Prerestorefunc
-- It gets an argument, data, which is the table stored from Prerestorefunc, if any
-- This function should be used for stuff such as doors, that otherwise would be cleaned up by map cleanup
-- and thus needs to get their data re-applied.

-- Put simply:
-- savefunc: Run when saved
-- loadfunc: Run when load
-- cleanents: A table containing entities related to module
-- cleanfunc: Run when CONFIG is cleaned (optional)
-- prerestorefunc: Run before MAP is cleaned and NOT config (optional)
-- postrestorefunc: Run after MAP is cleaned and NOT config (optional)

-- Note: MAP is cleaned after EVERY game (restore funcs)!
-- MAP cleanup ignores all entity types in CLEANENTS!
-- Always add entity types that relate to your module that should NOT be removed on reset, but SHOULD on clean!

nzMapping:AddSaveModule("ZedSpawns", {
	savefunc = function()
		local zed_spawns = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_normal")) do
			table.insert(zed_spawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				link2 = v.link2,
				link3 = v.link3,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
				miscspawn 	= v:GetMixedSpawn(),
				totalspawn  = v:GetTotalSpawns(),
				aliveamount  = v:GetAliveAmount(),
				roundcooldown  = v:GetRoundCooldown(),
			})
		end
		return zed_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedSpawn(v.pos, v.angle, v.link, v.link2, v.link3, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance, v.miscspawn, v.totalspawn, v.aliveamount, v.roundcooldown)
		end
	end,
	cleanents = {"nz_spawn_zombie_normal"}, -- Simply clean entities of this type
})

nzMapping:AddSaveModule("ZedSpecialSpawns", {
	savefunc = function()
		local zed_special_spawns = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_special")) do
			table.insert(zed_special_spawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				link2 = v.link2,
				link3 = v.link3,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
			})
		end
		return zed_special_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedSpecialSpawn(v.pos,v.angle , v.link, v.link2, v.link3, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance)
		end
	end,
	cleanents = {"nz_spawn_zombie_special"},
})

nzMapping:AddSaveModule("ZedBossSpawn", {
	savefunc = function()
		local zed_boss_spawns = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_boss")) do
			table.insert(zed_boss_spawns, {
			pos = v:GetPos(),
			angle = v:GetAngles(),
			link = v.link,
			link2 = v.link2,
			link3 = v.link3,
			roundactive = v:GetActiveRound() or 0,
			})
		end
		return zed_boss_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedBossSpawn(v.pos, v.angle, v.link, v.link2, v.link3, v.roundactive)
		end
	end,
	cleanents = {"nz_spawn_zombie_boss"},
})

--[[
nzMapping:AddSaveModule("ZedExtraSpawn1", {
	savefunc = function()
		local zed_add_spawns1 = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_extra1")) do
			table.insert(zed_add_spawns1, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
			})
		end
		return zed_add_spawns1
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedExtraSpawn1(v.pos,v.angle , v.link, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance)
		end
	end,
	cleanents = {"nz_spawn_zombie_extra1"},
})

nzMapping:AddSaveModule("ZedExtraSpawn2", {
	savefunc = function()
		local zed_add_spawns2 = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_extra2")) do
			table.insert(zed_add_spawns2, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
			})
		end
		return zed_add_spawns2
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedExtraSpawn2(v.pos,v.angle , v.link, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance)
		end
	end,
	cleanents = {"nz_spawn_zombie_extra2"},
})

nzMapping:AddSaveModule("ZedExtraSpawn3", {
	savefunc = function()
		local zed_add_spawns3 = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_extra3")) do
			table.insert(zed_add_spawns3, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
			})
		end
		return zed_add_spawns3
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedExtraSpawn3(v.pos,v.angle , v.link, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance)
		end
	end,
	cleanents = {"nz_spawn_zombie_extra3"},
})

nzMapping:AddSaveModule("ZedExtraSpawn4", {
	savefunc = function()
		local zed_add_spawns4 = {}
		for _, v in pairs(ents.FindByClass("nz_spawn_zombie_extra4")) do
			table.insert(zed_add_spawns4, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				link = v.link,
				master = v:GetMasterSpawn(),
				spawntype = v:GetSpawnType() or 0,
				zombietype = v:GetZombieType() or "none",
				roundactive = v:GetActiveRound() or 0,
				spawnchance = v:GetSpawnChance() or 100,
			})
		end
		return zed_add_spawns4
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZedExtraSpawn4(v.pos,v.angle , v.link, v.master, v.spawntype, v.zombietype, v.roundactive, v.spawnchance)
		end
	end,
	cleanents = {"nz_spawn_zombie_extra4"},
})
]]

nzMapping:AddSaveModule("PlayerSpawns", {
	savefunc = function()
		local player_spawns = {}
		for _, v in pairs(ents.FindByClass("player_spawns")) do
			table.insert(player_spawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				tab = {
					dooractivate = v:GetDoorActivated(),
					activatetype = v:GetDoorActivateType(),
					doorflag = v:GetDoorFlag(),
					doorflag2 = v:GetDoorFlag2(),
					doorflag3 = v:GetDoorFlag3(),
					preferred = v:GetPreferred(),
				},
			})
		end
		return player_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:PlayerSpawn(v.pos, v.angle, v.tab)
		end
	end,
	cleanents = {"player_spawns"},
})

nzMapping:AddSaveModule("WallBuys", {
	savefunc = function()
		local wall_buys = {}
		for _, v in pairs(ents.FindByClass("wall_buys")) do
			table.insert(wall_buys, {
				pos = v:GetPos(),
				wep = v.WeaponGive,
				price = v.Price,
				angle = v:GetAngles(),
				flipped = v:GetFlipped(),
				showmodel = v:GetNoChalk(),
			})
		end
		return wall_buys
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:WallBuy(v.pos, v.wep, v.price, v.angle, nil, nil, v.flipped, v.showmodel)
		end
	end,
	cleanents = {"wall_buys"},
	postrestorefunc = function(data) -- Post-map cleanup restoration (game reset)
		-- Reset bought status on wall buys
		for k,v in pairs(ents.FindByClass("wall_buys")) do
			v:SetBought(false)
		end
	end,
})

--[[nzMapping:AddSaveModule("Teleporter", {
	savefunc = function()
		local teleporters = {}
		for _, v in pairs(ents.FindByClass("nz_teleporter")) do
			table.insert(teleporters, {
			pos = v:GetPos(),
			angle = v:GetAngles(),
			desti = v:GetDestination(),
			id = v:GetID(),
			price = v:GetPrice(),
			mdltype = v:GetModelType(),
			gif = v:GetGifType(),
			cd = v:GetCooldownTime(),
			kino = v:GetKino(),
			delay = v:GetKinodelay(),
			buyable = v:GetUsable()
			})
		end
		return teleporters
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:Teleporter(v.pos,v.angle, v.desti, v.id, v.price, v.mdltype, v.gif, v.cd, v.kino, v.delay,v.buyable)
		end
	end,
	cleanents = {"nz_teleporter"},
	postrestorefunc = function(data) -- Post-map cleanup restoration (game reset)
		for k,v in pairs(ents.FindByClass("nz_teleporter")) do
			v:TurnOff()
		end
	end,
})]]


nzMapping:AddSaveModule("Teleporter", {
	savefunc = function()
		local teleporters = {}
		for _, v in pairs(ents.FindByClass("nz_teleporter")) do
			table.insert(teleporters, {
				pos = v:GetPos(),
				angles = v:GetAngles(),
				flag = v:GetFlag(),
				destination = v:GetDestination(),
				requiresdoor = v:GetRequiresDoor(),
				door = v:GetDoor(),
				price = v:GetPrice(),
				mdltype = v:GetModelType(),
				mdlcollisions = v:GetModelCollisions(),
				visible = v:GetModelVisible(),
				useable = v:GetUseable(),
				gif = v:GetGifType(),
				teleportertime = v:GetTeleporterTime(),
				cooldown = v:GetCooldownTime(),
				tpback = v:GetTPBack(),
				tpbackdelay = v:GetTPBackDelay(),
				activatestrap = v:GetActivatesTrap(),
				trap = v:GetTrap()
			})
		end
		return teleporters
	end,
	loadfunc = function(data)
		for _,v in pairs(data) do
			nzMapping:Teleporter(v)
		end
	end,
	cleanents = {"nz_teleporter"},
	postrestorefunc = function(data) -- Post-map cleanup restoration (game reset)
		for k,v in pairs(ents.FindByClass("nz_teleporter")) do
			v:TurnOff()
		end
	end,
})


nzMapping:AddSaveModule("Benches", {
	savefunc = function()
		local buildable_table = {}
		for _, v in pairs(ents.FindByClass("buildable_table")) do
			table.insert(buildable_table, {
			postbl = v:GetPos(),
			angtbl = v:GetAngles(),
			reward = v.Craftables,
			parts = v.ValidItems
			})
		end
		return buildable_table
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:LoadBench(v.postbl,v.angtbl,v.reward,v.parts)
		end
	end,
	cleanents = {"buildable_table"},
})
		
		
nzMapping:AddSaveModule("Buildable_Parts", {
	savefunc = function()
		
		local buildable_parts = {}
		for _, v in pairs(ents.FindByClass("nz_script_prop")) do
		local itm = v:GetNWString("NZItemCategory")
		print(itm)
		local itmdata = nzItemCarry.Items[itm]
		PrintTable(itmdata)
			table.insert(buildable_parts, {
			model = v:GetModel(),
			angle = v:GetAngles(),
			pos = v:GetPos(),
			id = itmdata.id,
			text = itmdata.text,
			icon = itmdata.icon,
			shared = itmdata.shared,
			drop = itmdata.dropondowned
			})
		end
		return buildable_parts
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			print(v.id)
			print(v.text)
			print(v.icon)
			--nzMapping:SpawnEntity(v.pos, v.angle, v.model)
			nzDoors:AddBuildable( v.model, v.angle, v.pos, v.id, v.text, v.icon, v.shared, v.drop, 0)
		end
	end,
	cleanents = {"nz_script_prop"},
})


nzMapping:AddSaveModule("BuyablePropSpawns", {
	savefunc = function()
		local buyableprop_spawns = {}
		for _, v in pairs(ents.FindByClass("prop_buys")) do

			-- Convert the table to a flag string - if it even has any
			local data = v:GetDoorData()
			if istable(data) then PrintTable(data) end
			local flagstr
			if data then
				flagstr = ""
				for k2, v2 in pairs(data) do
					flagstr = flagstr .. k2 .."=" .. v2 .. ","
				end
				flagstr = string.Trim(flagstr, ",")
			end

			table.insert(buyableprop_spawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				model = v:GetModel(),
				flags = flagstr,
				collision = v:GetCollisionGroup(),
				skingroup = v:GetSkin(),
			})
		end
		return buyableprop_spawns
	end,
	loadfunc = function(data)

		local count = #data
		PrintMessage( HUD_PRINTTALK, "[nZ] Loading..." )

		-- This is the most sinful thing I have ever done. But it is a required evil for doors to work correctly on large maps.
		timer.Simple(1, function()
			PrintMessage( HUD_PRINTTALK, "[nZ] Loaded!" )
			for i = 1, count do
				timer.Simple(i * 0.0001, function()
					for k,v in pairs(data) do
						if k ~= i then continue end
						local prop = nzMapping:PropBuy(v.pos, v.angle, v.model, v.flags)
						prop:SetCollisionGroup(v.collision or COLLISION_GROUP_NONE)
						prop:SetSkin(v.skingroup or 0)

						--PrintMessage( HUD_PRINTTALK, "[nZ] Loading Doors... "..i.." out of "..count.."." )
					end
				end)
			end
		end)
		
	end,
	cleanents = {"prop_buys"},
})

nzMapping:AddSaveModule("PropEffects", {
	savefunc = function()
		local prop_effects = {}
		for _, v in pairs(ents.FindByClass("nz_prop_effect")) do
			table.insert(prop_effects, {
			pos = v:GetPos(),
			angle = v:GetAngles(),
			model = v.AttachedEntity:GetModel(),
			})
		end
		return prop_effects
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:SpawnEffect(v.pos, v.angle, v.model)
		end
	end,
	cleanents = {"nz_prop_effect", "nz_prop_effect_attachment"},
})

nzMapping:AddSaveModule("ElecSpawns", {
	savefunc = function()
		local elec_spawn = {}
		for _, v in pairs(ents.FindByClass("power_box")) do
			table.insert(elec_spawn, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				tab = {
					model = v:GetPowerSwitchModel(),
					activetype = v:GetActivationType(),
					dmgtype = v:GetDmgType(),
					limited = v:GetLimited(),
					aoe = v:GetAOE(),
					requireall = v:GetRequireAll(),
					reset = v:GetDoReset(),
					resettime = v:GetResetTime(),
				},
			})
		end
		return elec_spawn
	end,
	loadfunc = function(data)
		for k, v in pairs(data) do
			local vdata = v.tab or {}
			if v.limited ~= nil then
				table.insert(vdata, v.limited)
			end
			if v.aoe ~= nil then
				table.insert(vdata, v.aoe)
			end
			nzMapping:Electric(v.pos, v.angle, vdata)
		end
	end,
	cleanents = {"power_box", "button_elec"}, -- Cleans two entity types
})
	
nzMapping:AddSaveModule("BlockSpawns", {
	savefunc = function()
		local block_spawns = {}
		for _, v in pairs(ents.FindByClass("wall_block")) do
			-- Convert the table to a flag string - if it even has any
			local data = v:GetDoorData()
			local flagstr
			if data then
				flagstr = ""
				for k2, v2 in pairs(data) do
					flagstr = flagstr .. k2 .."=" .. v2 .. ","
				end
				flagstr = string.Trim(flagstr, ",")
			end

			table.insert(block_spawns, {
			pos = v:GetPos(),
			angle = v:GetAngles(),
			model = v:GetModel(),
			flags = flagstr,
			})
		end
		return block_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:BlockSpawn(v.pos, v.angle, v.model, v.flags)
		end
	end,
	cleanents = {"wall_block"},
})

nzMapping:AddSaveModule("ZombieBlockSpawns", {
	savefunc = function()
		local zombie_block_spawns = {}
		for _, v in pairs(ents.FindByClass("zombie_wall_block")) do
			-- Convert the table to a flag string - if it even has any
			local data = v:GetDoorData()
			local flagstr
			if data then
				flagstr = ""
				for k2, v2 in pairs(data) do
					flagstr = flagstr .. k2 .."=" .. v2 .. ","
				end
				flagstr = string.Trim(flagstr, ",")
			end

			table.insert(zombie_block_spawns, {
			pos = v:GetPos(),
			angle = v:GetAngles(),
			model = v:GetModel(),
			flags = flagstr,
			})
		end
		return zombie_block_spawns
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:ZombieBlockSpawn(v.pos, v.angle, v.model, v.flags)
		end
	end,
	cleanents = {"zombie_wall_block"},
})


nzMapping:AddSaveModule("RandomBoxSpawns", {
	savefunc = function()
		local randombox_spawn = {}
		for _, v in pairs(ents.FindByClass("random_box_spawns")) do
			table.insert(randombox_spawn, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				spawn = v.PossibleSpawn,
				boxtype = v:GetBoxType(),
			})
		end
		return randombox_spawn
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:BoxSpawn(v.pos, v.angle, v.spawn, v.boxtype)
		end
	end,
	cleanents = {"random_box_spawns"},
})

nzMapping:AddSaveModule("PerkCratePiles", {
	savefunc = function()
		return {}
	end,
	loadfunc = function(data)
	end,
	cleanents = {"perk_cratepile"},
})

nzMapping:AddSaveModule("PerkMachineSpawns", {
	savefunc = function()
		local perk_machinespawns = {}

		for _, v in pairs(ents.FindByClass("perk_machine")) do
			table.insert(perk_machinespawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				tab = {
					id = v:GetPerkID(),
					random = v:GetRandomize(),
					fizzlist = v:GetRandomizeFizz(),
					randomround = v:GetRandomizeRounds(),
					roundnum = v:GetRandomizeInterval(),
					door = v:GetDoorActivated(),
					doorflag = v.DoorFlag,
					doorflag2 = v.DoorFlag2,
					doorflag3 = v.DoorFlag3,
					price = v.PriceOverride,
					priceupg = v.PriceOverrideUpgrade,
				}
			})
		end
		for _, v in pairs(ents.FindByClass("wunderfizz_machine")) do
			table.insert(perk_machinespawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				id = "wunderfizz",
				price = v.PriceOverride,
			})
		end
		return perk_machinespawns
	end,
	loadfunc = function(data)
		for k, v in pairs(data) do
			nzMapping:PerkMachine(v.pos, v.angle, v.tab or v.id, nil, v.price)
		end
	end,
	cleanents = {"perk_machine", "wunderfizz_machine"},
})

nzMapping:AddSaveModule("DoorSetup", {
	savefunc = function()
		local door_setup = {}
		for k,v in pairs(nzDoors.MapDoors) do
			local flags = ""
			for k2, v2 in pairs(v.flags) do
				flags = flags .. k2 .. "=" .. v2 .. ","
			end
			flags = string.Trim(flags, ",")
			door = nzDoors:DoorIndexToEnt(k)
			if door:IsDoor() then
				door_setup[k] = {
				flags = flags,
				}
				--print(door.Data)
			end
		end
		return door_setup
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			--print(v.flags)
			nzDoors:CreateMapDoorLink(k, v.flags)
		end
	end, 
	cleanfunc = function()
		-- Cleans up differently, does not return any entity types
		for k,v in pairs(nzDoors.MapDoors) do
			nzDoors:RemoveMapDoorLink( k )
		end
		
		-- This module is responsible for both prop doors and map doors
		nzDoors.MapDoors = {}
		nzDoors.PropDoors = {}
		-- Clear all door data on clients
		net.Start("nzClearDoorData")
		net.Broadcast()
	end, 
	postrestorefunc = function(data)
		-- Doors are reset by map cleanup, we loop through the data and reapply them!
		for k,v in pairs(nzDoors.MapDoors) do
			local door = nzDoors:DoorIndexToEnt(k)
			door:SetLocked(true)
			if door:IsDoor() then
				door:LockDoor()
			elseif door:IsButton() then
				door:LockButton()
			end
			nzDoors.SendSync( ply )
		end
	end,
})

nzMapping:AddSaveModule("BreakEntry", {
	savefunc = function()
		local break_entry = {}
		for _, v in pairs(ents.FindByClass("breakable_entry")) do
			table.insert(break_entry, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				planks = v:GetHasPlanks(),
				jump = v:GetTriggerJumps(),
				boardtype = v:GetBoardType(),
				prop = v:GetProp() or 0,
				jumptype = v:GetJumpType() or 0,
				plycollision = v:GetPlayerCollision(),
				ambsnds = v:GetAmbientSounds(),
			})
		end
		return break_entry
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			if not v.prop then v.prop = 0 end 
			if not v.jumptype then v.jumptype = 0 end
			if v.plycollision == nil then v.plycollision = true end
			if v.ambsnds == nil then v.ambsnds = false end
			nzMapping:BreakEntry(v.pos, v.angle, v.planks, v.jump, v.boardtype, v.prop, v.jumptype, v.plycollision, v.ambsnds)
		end
	end,
	cleanents = {
		"breakable_entry", 
		"breakable_entry_plank", 
		"breakable_entry_bar", 
		"breakable_entry_ventslat", 
		"breakable_entry_plank_zhd",
		"breakable_entry_plank_classic"
	},
	postrestorefunc = function(data)
		-- Now we respawn them! :D
		for k,v in pairs(ents.FindByClass("breakable_entry")) do
			if IsValid(v) then
				v:FullRepair()
			end
		end
	end,
})

nzMapping:AddSaveModule("SpecialEntities", {
	savefunc = function()
		local special_entities = {}
		for k, v in pairs(nzQMenu.Data.SpawnedEntities) do
			if IsValid(v) then
				table.insert(special_entities, duplicator.CopyEntTable(v))
			else
				nzQMenu.Data.SpawnedEntities[k] = nil
			end
		end
		return special_entities
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			--PrintTable(v)
			local ent = duplicator.CreateEntityFromTable(Entity(1), v)
			table.insert(nzQMenu.Data.SpawnedEntities, ent)
		end
	end,
	cleanfunc = function()
		--Specially spawned entities are directly removed, not by type
		for k,v in pairs(nzQMenu.Data.SpawnedEntities) do
			if IsValid(v) then
				v:Remove()
			end
		end
		nzQMenu.Data.SpawnedEntities = {} -- Also cleanup the table from it
	end,
	prerestorefunc = function() -- PRE-map cleanup! Save all special entities before they are wiped!
		local special_entities = {}
		for k,v in pairs(nzQMenu.Data.SpawnedEntities) do
			if IsValid(v) then
				special_entities[v] = duplicator.CopyEntTable(v)
			end
		end
		return special_entities -- Return the data to be used in the next function after the cleanup
	end,
	postrestorefunc = function(data)
		-- Now we respawn them! :D
		for k,v in pairs(data) do
			if !IsValid(k) then -- Only if they aren't still around
				local ent = duplicator.CreateEntityFromTable(Entity(1), v)
				table.insert(nzQMenu.Data.SpawnedEntities, ent)
			end
		end
	end,
})

nzMapping:AddSaveModule("InvisWalls", {
	savefunc = function()
		-- Store all invisible walls with their boundaries and angles
		local invis_walls = {}
		for _, v in pairs(ents.FindByClass("invis_wall")) do
			table.insert(invis_walls, {
				pos = v:GetPos(),
				maxbound = v:GetMaxBound(),
			})
		end
		return invis_walls
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:CreateInvisibleWall(v.pos, v.maxbound)
		end
	end,
	cleanents = {"invis_wall"},
})

nzMapping:AddSaveModule("InvisWallsZombie", {
	savefunc = function()
		-- Store all invisible walls with their boundaries and angles
		local invis_walls = {}
		for _, v in pairs(ents.FindByClass("invis_wall_zombie")) do
			table.insert(invis_walls, {
				pos = v:GetPos(),
				maxbound = v:GetMaxBound(),
			})
		end
		return invis_walls
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:CreateInvisibleWallZombie(v.pos, v.maxbound)
		end
	end,
	cleanents = {"invis_wall_zombie"},
})

nzMapping:AddSaveModule("CreateAntiCheatExclusions", {
	savefunc = function()
		-- Store all invisible walls with their boundaries and angles
		local anticheat_exclusions = {}
		for _, v in pairs(ents.FindByClass("anticheat_exclude")) do
			table.insert(anticheat_exclusions, {
				pos = v:GetPos(),
				maxbound = v:GetMaxBound(),
			})
		end
		return anticheat_exclusions
	end,
	loadfunc = function(data)
		for k,v in pairs(data) do
			nzMapping:CreateAntiCheatExclusion(v.pos, v.maxbound)
		end
	end,
	cleanents = {"anticheat_exclude"},
})

nzMapping:AddSaveModule("DamageWalls", {
	savefunc = function()
		local invis_damage_walls = {}
		for _, v in pairs(ents.FindByClass("invis_damage_wall")) do
			table.insert(invis_damage_walls, {
				pos = v:GetPos(),
				maxbound = v:GetMaxBound(),
				damage = v:GetDamage(),
				delay = v:GetDelay(),
				dmgtype = v:GetDamageWallType(),
				respawnz = v:GetRespawnZombie(),
				elec = v:GetElectric(),
				//radiation = v:GetRadiation(),
				//poison = v:GetPoison(),
				//tesla = v:GetTesla(),
			})
		end
		return invis_damage_walls
	end,
	loadfunc = function(data)
		for k, v in pairs(data) do
			//yippee suicide
			local fuckoffdie = 1
			if v.radiation then
				fuckoffdie = 1
			elseif v.poison then
				fuckoffdie = 2
			elseif v.tesla then
				fuckoffdie = 3
			end

			nzMapping:CreateInvisibleDamageWall(v.pos, v.maxbound, nil, v.damage, v.delay, v.dmgtype or fuckoffdie, v.respawnz, v.elec)
		end
	end,
	cleanents = {"invis_damage_wall"},
})
