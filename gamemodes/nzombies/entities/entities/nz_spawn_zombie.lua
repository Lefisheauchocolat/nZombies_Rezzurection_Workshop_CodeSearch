AddCSLuaFile( )
 
ENT.Type = "anim"
ENT.Base = "base_entity"
 
ENT.PrintName       = "nz_spawn_zombie"
 
AccessorFunc(ENT, "iSpawnWeight", "SpawnWeight", FORCE_NUMBER)
AccessorFunc(ENT, "tZombieData", "ZombieData")
AccessorFunc(ENT, "iZombiesToSpawn", "ZombiesToSpawn", FORCE_NUMBER)
AccessorFunc(ENT, "hSpawner", "Spawner")
AccessorFunc(ENT, "dNextSpawn", "NextSpawn", FORCE_NUMBER)
AccessorFunc(ENT, "dSpawnUpdateRate", "SpawnUpdateRate", FORCE_NUMBER)
 
ENT.NZOnlyVisibleInCreative = true
 
function ENT:DecrementZombiesToSpawn()
	self:SetZombiesToSpawn( self:GetZombiesToSpawn() - 1 )
end
 
function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Link")
	self:NetworkVar("String", 1, "ZombieType")
	self:NetworkVar("String", 2, "Link2")
	self:NetworkVar("String", 3, "Link3")
	self:NetworkVar("Bool", 0, "Skip")
	self:NetworkVar("Bool", 1, "MasterSpawn")
	self:NetworkVar("Bool", 2, "MixedSpawn")
	self:NetworkVar("Float", 0, "SpawnChance")
	self:NetworkVar("Int", 0, "SpawnType")
	self:NetworkVar("Int", 1, "ActiveRound")
	self:NetworkVar("Int", 3, "TotalSpawns")
	self:NetworkVar("Int", 4, "AliveAmount")
	--self:NetworkVar("Int", 5, "SpeedOverride")
end

function ENT:Initialize()
	if !NZNukeSpawnDelay then NZNukeSpawnDelay = 0 end
	self:SetModel( "models/player/odessa.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(0, 255, 0))
	self:DrawShadow( false )
	self:SetSpawnWeight(0)
	self:SetZombiesToSpawn(0)
	self:SetNextSpawn(CurTime())
	self:SetSpawnUpdateRate(0)

	if (self:GetSpawnType() == 0 or self:GetSpawnType() == nil) and !self:GetMasterSpawn() then
		self:AutoSpawnType() -- Spawns don't have the data set.
	end

	if self:GetSpawnChance() == 0 or self:GetSpawnChance() == nil then
		self:SetSpawnChance(100)
	end

	self.Spawns = {}
	self.MiscSpawns = {}

	self.TotalSpawns = 0
	self.MarkRound = false

	self.CurrentSpawnType = "nil"
	self:UpdateSpawnType()

	self.NukeDelay = false
	
	self.NextUse = CurTime() + 1

	if CLIENT then
		self:SetLOD(8)
	end
end

function ENT:UpdateSpawnType()
	local types = {
		[0] = "Riser",
		[1] = "No Animation",
		[3] = "Undercroft",
		[4] = "Wall Emerge",
		[5] = "Jump Spawn",
		[6] = "Barrel Climbout",
		[7] = "Ceiling Dropdown Low",
		[8] = "Ceiling Dropdown High",
		[9] = "Ground Wall",
		[10] = "Wall Emerge(CW)",
		[11] = "Portal Spawn",
		[12] = "Elevator Spawn(Floor)",
		[13] = "Elevator Spawn(Ceiling)",
		[14] = "Crawl Spawn",
		[15] = "Under Bed",
		[16] = "Alcove Spawn 40",
		[17] = "Alcove Spawn 56",
		[18] = "Alcove Spawn 96",
	}
	self.CurrentSpawnType = types[self:GetSpawnType()]
end

function ENT:AutoSpawnType()
	if SERVER then -- Client gets really mad cuz it doesn't know what a "navmesh" is.
		local nav = navmesh.GetNearestNavArea( self:GetPos() )
		if IsValid(nav) then
			if nav:HasAttributes(NAV_MESH_NO_JUMP) then
				self:SetSpawnType(1)
			elseif nav:HasAttributes(NAV_MESH_OBSTACLE_TOP) then
				self:SetSpawnType(3)
			elseif nav:HasAttributes(NAV_MESH_DONT_HIDE) then
				self:SetSpawnType(4)
			else
				self:SetSpawnType(0)
			end
		end
	end
end

function ENT:IsSuitable(ent) --OOOOoooo nZu Code Port!
	-- Optimization: No need to check trace in the same tick as another earlier check
	if self.LastSuccessfulCheck == engine.TickCount() then return true end

	local pos = self:GetPos() + Vector(0,0,1)
	local trace = {
		start = pos,
		endpos = pos,
		filter = ent,
		ignoreworld = true,
		mask = MASK_NPCSOLID,
	}
	local result
	if IsValid(ent) then result = util.TraceEntity(trace, ent) else
		trace.mins = Vector(-20,-20,0)
		trace.maxs = Vector(20,20,10)
		result = util.TraceHull(trace)
	end
	
	local entt = result.Entity

	if not result.Hit then
		self.LastSuccessfulCheck = engine.TickCount()
		return true
	end
	if result.Hit then
		if IsValid(entt) and entt.IsMooZombie or IsValid(entt) and entt:GetClass() == "prop_buys" then
			self.LastSuccessfulCheck = engine.TickCount()
			return true
		else
			return false
		end
	end
end

-- Moo Mark 7/24/23: Moved a bunch of code from "sv_spawner.lua" and put here, also tweaked it a ton too.
-- Basically I'ved reworked the spawn system to be less shitty and not spawn ALL of the zombies at one spawn when there like 20 other spawns to use.
-- This never really happened in solo, but in multiplayer games with around 4+ players... It got really bad to the point where the zombie industry crashed.

-- But now... Its been reworked to be more like actual CoD where you'll place down one main spawner and that spawner will randomly pick any open spawn to use.
-- This should basically get rid of the "dumping all the zombies at one spawn." thing thats been an issue in recent times.
-- Maps should also just flow better from this too.

-- Though it should be noted that this code isn't optimized at all, and should be improved in the future.

function ENT:Think()
	if SERVER then

		-- This may not be needed right now.. But Justin Case told me to keep it here for now.
		
		if nzRound:InState( ROUND_PROG ) and self:GetMasterSpawn() then
			debugoverlay.Text(self:GetPos() + Vector(0,0,75), "Zombies Left: "..tostring(self:GetZombiesToSpawn()), 0.25, false)
			debugoverlay.Text(self:GetPos() + Vector(0,0,85), "Zombies Total: "..tostring(nzRound:GetZombiesMax()), 0.25, false)
			if self:GetZombiesToSpawn() <= 0 and nzRound:GetZombiesKilled() + nzEnemies:TotalAlive() < nzRound:GetZombiesMax() then
				print("--Possible Underspawn--")
				self:SetZombiesToSpawn(nzRound:GetZombiesMax() - (nzRound:GetZombiesKilled() + nzEnemies:TotalAlive()))
			end
		end
		

		if nzRound:InState( ROUND_PROG ) and self:GetZombiesToSpawn() > 0 and self:GetMasterSpawn() then

			if (nzRound:GetZombiesKilled() + nzEnemies:TotalAlive()) + 1 > nzRound:GetZombiesMax() then --[[print("--Possible Overflow--")]] return end

			-- Delay the spawning if a Nuke just went off.
			if self:GetSpawner() and self:GetMasterSpawn() and self.NukeDelay then
				self.NukeDelay = false
				self:GetSpawner():SetNextSpawn(CurTime() + 8)
			end

			if self:GetSpawner() and self:GetSpawner():GetNextSpawn() < CurTime() and self:GetNextSpawn() < CurTime() then
				local maxspawns = NZZombiesMaxAllowed != nil and NZZombiesMaxAllowed or 24
				if nzEnemies:TotalAlive() < maxspawns then
					local class
					local zombie

					if self:GetSpawnUpdateRate() < CurTime() then

						local plys = player.GetAllPlaying()
						local range = math.Clamp(nzMapping.Settings.range / 2, 500, 60000) 
						if range <= 0 then range = 60000 end -- A quote on quote, infinite range.

						self.Spawns = {}
						self.MiscSpawns = {}

						for k,v in nzLevel.GetZombieSpawnArray() do -- You get an array now.
							if v:GetClass() == self:GetClass() then
								if !v:GetMasterSpawn() 
									and (v.link == nil or nzDoors:IsLinkOpened(v.link) or nzDoors:IsLinkOpened(v.link2) or nzDoors:IsLinkOpened(v.link3) ) 
									and (nzElec:IsOn() and v:GetActiveRound() == -1 or nzRound:GetNumber() >= v:GetActiveRound() and v:GetActiveRound() ~= -1) then

									if nzMapping.Settings.navgroupbased == 1 then
										for k2, v2 in pairs(plys) do
											if IsValid(v2) and v2:IsInWorld() and nzNav.Functions.IsInSameNavGroup(v2, v) then
												if v:GetPos():DistToSqr(v2:GetPos()) <= range^2 then
													if v.TotalSpawns < v:GetTotalSpawns() or v:GetTotalSpawns() == 0 then
														if v:GetMixedSpawn() then
															table.insert(self.MiscSpawns, v)
														else
															table.insert(self.Spawns, v)
														end
													end
												end
											end
										end
									else
										for k2, v2 in pairs(plys) do
											if v:GetPos():DistToSqr(v2:GetPos()) <= range^2 then
												if v.TotalSpawns < v:GetTotalSpawns() or v:GetTotalSpawns() == 0 then
													if v:GetMixedSpawn() then
														table.insert(self.MiscSpawns, v)
													else
														table.insert(self.Spawns, v)
													end
												end
											end
										end
									end
								end
							end
						end
						self:SetSpawnUpdateRate(CurTime() + 5)
					end

					local randomspawn = self.Spawns[math.random(#self.Spawns)]

					if IsValid(randomspawn) then

						local chance = randomspawn:GetSpawnChance()
						local multi = math.Clamp(nzRound:GetNumber() - randomspawn:GetActiveRound(), 0, math.huge)
						local limit = chance * 2

						if !randomspawn:GetMixedSpawn() then
							-- Get the chance of the spawner.
							local rnd = nzRound:GetNumber()
							if rnd == -1 then
								rnd = 1
							end

							if chance < 100 then
								for i=1, multi do
									chance = math.Clamp(chance + 0.5, 0, limit)
								end
							end
						end

						-- Find what type of spawner it is.
						local spawntypes = {
							["nz_spawn_zombie_normal"] = true,
							["nz_spawn_zombie_extra1"] = true,
							["nz_spawn_zombie_extra2"] = true,
							["nz_spawn_zombie_extra3"] = true,
							["nz_spawn_zombie_extra4"] = true,
						}

						if !randomspawn:GetMixedSpawn() then
							local zombietype = randomspawn:GetZombieType()

							-- Now we're gonna see if the spawner has a zombie type set.
							if !nzRound:IsSpecial() and zombietype ~= "none" and spawntypes[randomspawn:GetClass()] then
								-- Normal and Extra Spawns.
								class = zombietype
							elseif nzRound:IsSpecial() and !spawntypes[randomspawn:GetClass()] and randomspawn:GetClass() == "nz_spawn_zombie_special" and zombietype ~= "none" then
								-- Special Spawns.
								class = zombietype
							else
								-- No zombie type set, default to config mapsetting.
								class = nzMisc.WeightedRandom(self:GetZombieData(), "chance")
							end
						else
							class = nzMisc.WeightedRandom(self:GetZombieData(), "chance")
						end

						if math.Rand(0,100) < chance and randomspawn.TotalSpawns < randomspawn:GetTotalSpawns() or randomspawn:GetTotalSpawns() == 0 then
							zombie = ents.Create(class)
							zombie:SetPos(randomspawn:GetPos())
							zombie:SetAngles(randomspawn:GetAngles())
							zombie:Spawn()

							-- make a reference to the spawner object used for "respawning"
							zombie:SetSpawner(self:GetSpawner())
							zombie:Activate()

							-- reduce zombies in queue on self and spawner object
							self:GetSpawner():DecrementZombiesToSpawn()
							self:DecrementZombiesToSpawn()

							self:ChanceExtraEnemySpawn()

							randomspawn:DecrementTotalSpawns()
						end
					end
					
					if nzRound:IsSpecial() then
						local data = nzRound:GetSpecialRoundData()
						if data and data.spawnfunc then
							data.spawnfunc(zombie)
						end
					end
					
					hook.Call("OnZombieSpawned", nzEnemies, zombie, self )

					-- Global spawner timer only set if a successful spawn happens!
					self:GetSpawner():SetNextSpawn(CurTime() + self:GetSpawner():GetDelay())
				end
			end
		end
	end
end

function ENT:DecrementTotalSpawns()
	if self:GetTotalSpawns() ~= 0 then

		-- Find any other spawner that shares the same zombie type. Chances are if they share, they're probably the exact same.
		for k,v in nzLevel.GetZombieSpawnArray() do
			if v:GetTotalSpawns() ~= 0 and !v:GetMasterSpawn() and v:GetZombieType() == self:GetZombieType() and v:GetSpawnChance() == self:GetSpawnChance() then
				v.TotalSpawns = v.TotalSpawns + 1
				--print(v.TotalSpawns)
			end
		end
	end
end

function ENT:Use(ply)
	if nzRound:InState(ROUND_CREATE) and !self:GetMasterSpawn() then
		if CurTime() > self.NextUse then
			self:EmitSound("nz_moo/effects/ui/main_click_rear.mp3")
			self.NextUse = CurTime() + 1

			local class
			local zombie
			local zombietype = self:GetZombieType()

			-- Now we're gonna see if the spawner has a zombie type set.
			if zombietype ~= "none" then
				class = zombietype	
			else
				class = "nz_zombie_walker"
			end

			zombie = ents.Create(class)
			zombie:SetPos(self:GetPos())
			zombie:SetAngles(self:GetAngles())
			zombie:Spawn()

			-- make a reference to the spawner object used for "respawning"
			zombie:SetSpawner(self:GetSpawner())
			zombie:Activate()
		end
	end
end

-- While you'd still have to cover your map with a bunch of spawns, 
-- this is in hopes that having a large amount of spawns with different spawn chances
-- and round activations doesn't slow down spawning of regular/general enemies.
-- So now any spawn that has a class override should have the same chance of spawning 
-- reguardless of how many spawns with that type there are.
-- This means now any additional enemies will spawn at the same time as a regular enemy if the criteria is met.
function ENT:ChanceExtraEnemySpawn()
	local spawntbl = {}

	for _, spawn in ipairs(self.MiscSpawns) do
		if IsValid(spawn) then

			local class = spawn:GetZombieType()
			local alive = ents.FindByClass(class)

			-- Get the chance of the spawner.
			local rnd = nzRound:GetNumber()
			local active = spawn:GetActiveRound()

			if rnd == -1 then
				rnd = 1
			end

			if spawn:GetActiveRound() == -1 and nzElec:IsOn() and !spawn.MarkRound then
				spawn.MarkRound = true
				active = rnd
			end
			
			local chance = spawn:GetSpawnChance()
			local multi = math.Clamp(rnd - active, 0, math.huge)
			local limit = chance * 2

			if chance < 100 then
				for i=1, multi do
					chance = math.Clamp(chance + 0.15, 0, limit)
				end
			end

			if #alive < spawn:GetAliveAmount() and spawn:GetAliveAmount() ~= 0 then
				if math.Rand(0,100) < chance and (spawn.TotalSpawns < spawn:GetTotalSpawns() or spawn:GetTotalSpawns() == 0) then
					table.insert(spawntbl, spawn)
				end 
			end
		end
	end

	local randommiscspawn = spawntbl[math.random(#spawntbl)]

	--PrintTable(spawntbl)

	if IsValid(randommiscspawn) then

		local class = randommiscspawn:GetZombieType()
		local zombie

		zombie = ents.Create(class)
		zombie:SetPos(randommiscspawn:GetPos())
		zombie:SetAngles(randommiscspawn:GetAngles())
		zombie:Spawn()

		-- make a reference to the spawner object used for "respawning"
		zombie:SetSpawner(self:GetSpawner())
		zombie:Activate()

		-- reduce zombies in queue on self and spawner object
		self:GetSpawner():DecrementZombiesToSpawn()
		self:DecrementZombiesToSpawn()  

		randommiscspawn:DecrementTotalSpawns()
	end
end

hook.Add("OnRoundStart", "ResetTotalSpawns", function()
	for k,v in nzLevel.GetZombieSpawnArray() do
		v.TotalSpawns = 0
		if nzRound:GetNumber() == 1 then
			v.MarkRound = false
		end
	end
end)

if CLIENT then
	local nz_preview = GetConVar("nz_creative_preview")
	local displayfont = "ChatFont"
	local outline = Color(0,0,0,59)
	local drawdistance = 800^2
	local size = 0.25
	local col = Color(255,255,0)

	function ENT:Draw()
		if not nzRound:InState( ROUND_CREATE ) then return end
		if nz_preview:GetBool() then return end

		self:DrawModel()

		local ourcolor = self:GetColor()
		if self.GetMixedSpawn and self:GetMixedSpawn() and ourcolor ~= col then
			self:SetColor(col)
			--self:SetModel("models/combine_super_soldier.mdl")
		end

		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
				if self.GetLink then
					draw.SimpleText("Link: "..self:GetLink().."", displayfont, 0, 0, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetLink2 then
					draw.SimpleText("Link2: "..self:GetLink2().."", displayfont, 0, -15, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetLink3 then
					draw.SimpleText("Link3: "..self:GetLink3().."", displayfont, 0, -30, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.CurrentSpawnType then
					draw.SimpleText("Spawn Type: "..self.CurrentSpawnType.."", displayfont, 0, -45, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetMasterSpawn and self:GetMasterSpawn() then
					draw.SimpleText("Master Spawn", displayfont, 0, -60, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetZombieType then
					draw.SimpleText("Type: "..self:GetZombieType().."", displayfont, 0, -75, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetActiveRound then
					draw.SimpleText("Round: "..self:GetActiveRound().."", displayfont, 0, -90, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetSpawnChance then
					draw.SimpleText("Chance: "..self:GetSpawnChance().."", displayfont, 0, -105, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetTotalSpawns then
					draw.SimpleText("Total Spawns: "..self:GetTotalSpawns().."", displayfont, 0, -120, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetAliveAmount then
					draw.SimpleText("Alive Cap: "..self:GetAliveAmount().."", displayfont, 0, -135, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				--[[if self.GetSpeedOverride and self:GetSpeedOverride() then
					draw.SimpleText("Speed Override: "..self:GetSpeedOverride().."", displayfont, 0, -150, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end]]
				if self.GetMixedSpawn and self:GetMixedSpawn() then
					draw.SimpleText("Mixed Spawn", displayfont, 0, -150, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			cam.End3D2D()
		end
	end
end
 