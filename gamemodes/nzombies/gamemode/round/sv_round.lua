function GM:InitPostEntity()
	nzRound:Waiting()
end

function nzRound:Waiting()
	self:SetState( ROUND_WAITING )
	hook.Call( "OnRoundWaiting", nzRound )
end

function nzRound:Init()
	local starttime = CurTime() + (nzSettings:GetSimpleSetting("Lobby_Enabled", true) and engine.TickInterval() or 5)

	hook.Add("Think", "nzRoundGameInit", function()
		if CurTime() > starttime then
			self:SetupGame()
			self:Prepare()
			//timer.Simple(0, function()
				for _, ply in ipairs(player.GetAllPlaying()) do
					ply:ScreenFade(SCREENFADE.IN, color_black, 2, engine.TickInterval())
					ply:SetNW2Float("FirstSpawnedTime", CurTime())
				end
			//end)
			hook.Remove("Think", "nzRoundGameInit")
		end
	end)

	self:SetVictory( false )
	self:SetState( ROUND_INIT )

	self:SetEndTime( starttime )
	--PrintMessage( HUD_PRINTTALK, "5 seconds till start time." )
	hook.Call( "OnRoundInit", nzRound )
end

function nzRound:Prepare( time )
	hook.Remove("EntityTakeDamage", "TFA_MeleeScaling")
	hook.Remove("EntityTakeDamage", "TFA_MeleeReceiveLess")
	hook.Remove("EntityTakeDamage", "TFA_MeleePaP")
	if self:IsSpecial() then -- From previous round
		local data = self:GetSpecialRoundData()
		if data and data.endfunc then data.endfunc() end
	end

	-- Update special round type every round, before special state is set
	local roundtype = nzMapping.Settings.specialroundtype
	self:SetSpecialRoundType(roundtype)

	RunConsoleCommand("r_cleardecals") -- BEGONE DECALS!!!

	-- Set special for the upcoming round during prep, that way clients have time to fade the fog in
	self:SetSpecial( self:MarkedForSpecial( self:GetNumber() + 1 ) )
	self:SetState( ROUND_PREP )

	--[[if self:GetNumber() < 666 then
	end]]

	-- Round Counter is in 16 bit, so it can only display up to 32767 before it starts back at 0.
	-- Depending on the hud of the config, it'll actually display 0 or it'll stay at 32767 before starting back at 1.
	self:IncrementNumber()

	if self:GetNumber() < 1 then
		self:SetNumber(1) -- No more -1 :steamhappy:
	end

	self:SetZombieHealth( nzCurves.GenerateHealthCurve(self:GetNumber()) )
	self:SetZombieDamage( nzCurves.GenerateAttackDamage(self:GetNumber()) )

	if nzMapping.Settings.timedgame == 1 then
		self:SetZombiesMax( 666 )
	else
		self:SetZombiesMax( nzCurves.GenerateMaxZombies(self:GetNumber()) )
	end

	self:SetZombieSpeeds( nzCurves.GenerateSpeedTable(self:GetNumber()) )
	self:SetZombieCoDSpeeds( nzCurves.GenerateCoDSpeedTable(self:GetNumber()) )

	if nzRound:GetRampage() and self:GetNumber() < 35 then -- Silently disable it once round 35 is passed.
		local tbl = {
			[200] = 100,
			[36] = 15,
			[1] = 1,
		}
		self:SetZombieSpeeds( tbl )
		self:SetZombieCoDSpeeds( tbl )
		--you fool owl boy, you've fallen for the classic blunder
	else
		self:SetZombieSpeeds( nzCurves.GenerateSpeedTable(self:GetNumber()) )
		self:SetZombieCoDSpeeds( nzCurves.GenerateCoDSpeedTable(self:GetNumber()) )
	end

	local slot_reward = nzMapping.Settings.roundperkbonus
	if slot_reward == nil or tobool(slot_reward) then
		local n_rewardround = nzMapping.Settings.slotrewardround or 15
		local n_rewardinterval = nzMapping.Settings.slotrewardinterval or 10
		local n_maxslots = nzMapping.Settings.slotrewardcount or 2

		local b_dothething = false
		if !nzRound.RewardedPerkSlots and self:GetNumber() >= (n_rewardround + 1) then
			nzRound.RewardedPerkSlots = 1
			nzRound.NextPerkSlot = self:GetNumber() + n_rewardinterval
			b_dothething = true
		elseif nzRound.RewardedPerkSlots and nzRound.RewardedPerkSlots < n_maxslots and (self:GetNumber() >= nzRound.NextPerkSlot) then
			nzRound.RewardedPerkSlots = nzRound.RewardedPerkSlots + 1
			nzRound.NextPerkSlot = self:GetNumber() + n_rewardinterval
			b_dothething = true
		end

		if b_dothething then
			local cvar_maxperks = GetConVar("nz_difficulty_perks_max")

			cvar_maxperks:SetInt(cvar_maxperks:GetInt() + 1)
			for k, v in pairs(player.GetAll()) do
				if (v:IsPlaying() or v:IsInCreative()) then
					v:SetMaxPerks(v:GetMaxPerks() + 1)
				end
			end

			net.Start("nzPowerUps.PickupHud")
				net.WriteString("Perk Slot!")
				net.WriteBool(true)
			net.Broadcast()
		end
	end

	if nzMapping.Settings.timedgame ~= 1 then
		self:ResetZombiesRemaining()
		self:SetZombiesKilled( 0 )
	else
		self:ResetZombiesRemaining()
		self:SetZombiesKilled( 0 )
	end

	--Notify
	--PrintMessage( HUD_PRINTTALK, "ROUND: " .. self:GetNumber() .. " preparing" )
	hook.Call( "OnRoundPreparation", nzRound, self:GetNumber() )
	--Play the sound

	--Spawn all players
	--Check config for dropins
	--For now, only allow the players who started the game to spawn
	for _, ply in pairs( player.GetAllPlaying() ) do
		ply:ReSpawn()
	end

	-- Setup the spawners after all players have been spawned

	-- Reset and remove the old spawners
	if self:GetNormalSpawner() then
		self:GetNormalSpawner():Remove()
		self:SetNormalSpawner(nil)
	end
	if self:GetSpecialSpawner() then
		self:GetSpecialSpawner():Remove()
		self:SetSpecialSpawner(nil)
	end

	-- Prioritize any configs (useful for mapscripts)
	if nzConfig.RoundData[ self:GetNumber() ] or (self:IsSpecial() and self:GetSpecialRoundData()) then
		local roundData = self:IsSpecial() and self:GetSpecialRoundData().data or nzConfig.RoundData[ self:GetNumber() ]

		--normal spawner
		local normalCount = 0

		-- only setup a spawner if we have zombie data
		if roundData.normalTypes then
			if roundData.normalCountMod then
				local mod = roundData.normalCountMod
				normalCount = mod(self:GetZombiesMax())
			elseif roundData.normalCount then
				normalCount = roundData.normalCount
			else
				normalCount = self:GetZombiesMax()
			end
			
			local normalDelay
			if roundData.normalDelayMod then
				local mod = roundData.normalDelayMod
				normalDelay = mod(self:GetZombiesMax())
			elseif roundData.normalDelay then
				normalDelay = roundData.normalDelay
			else
				normalDelay = 2
			end

			local normalData = roundData.normalTypes
			local normalSpawner = Spawner("nz_spawn_zombie_normal", normalData, normalCount, normalDelay or 0.95)

			-- save the spawner to access data
			self:SetNormalSpawner(normalSpawner)
		end

		-- special spawner
		local specialCount = 0

		-- only setup a spawner if we have zombie data
		if roundData.specialTypes then
			if roundData.specialCountMod then
				local mod = roundData.specialCountMod
				specialCount = mod(self:GetZombiesMax())
			elseif roundData.specialCount then
				specialCount = roundData.specialCount
			else
				specialCount = self:GetZombiesMax()
			end
			
			local specialDelay
			if roundData.specialDelayMod then
				local mod = roundData.specialDelayMod
				specialDelay = mod(self:GetZombiesMax())
			elseif roundData.specialDelay then
				specialDelay = roundData.specialDelay
			else
				specialDelay = 0.5
			end

			local specialData = roundData.specialTypes
			local specialSpawner = Spawner("nz_spawn_zombie_special", specialData, specialCount, specialDelay or 0.76)

			-- save the spawner to access data
			self:SetSpecialSpawner(specialSpawner)
		end

		-- update the zombiesmax (for win detection)
		self:SetZombiesMax(normalCount + specialCount)
	elseif self:IsSpecial() then
		-- only setup a special spawner
		local amntforrnd = self:SetZombiesMax(math.floor(self:GetZombiesMax() / 2)) -- Half the amount of special zombies
		local ply = #player.GetAllPlaying()
		if amntforrnd > 24 then
			self:SetZombiesMax(math.floor(self:GetZombiesMax() / 2) + ((ply - 1) * 6))
		end
		
		local specialSpawner = Spawner("nz_spawn_zombie_special", {["nz_zombie_special_dog"] = {chance = 100}}, self:GetZombiesMax(), 2)

		-- save the spawner to access data
		self:SetSpecialSpawner(specialSpawner)

	-- else just do regular walker spawning
	else
		local normalSpawner = Spawner("nz_spawn_zombie_normal", {[nzRound:GetZombieType(nzMapping.Settings.zombietype)] = {chance = 100}}, self:GetZombiesMax())
		
		-- save the spawner to access data
		self:SetNormalSpawner(normalSpawner)
	end

	--Set this to reset the overspawn debug message status
	CurRoundOverSpawned = false

	--Start the next round
	local time = (nzMapping.Settings.roundwaittime or 15)
	if self:GetNumber() == -1 then time = 10 end
	if self:GetNumber() == 1 then time = (nzMapping.Settings.firstroundwaittime or 1) end
	if self:IsSpecial() then time = (nzMapping.Settings.specialroundwaittime or 15) end

	if nzMapping.Settings.timedgame == 1 then time = (nzMapping.Settings.timedgameroundwaittime or 0.5) end -- Timed Gameplay has next to no time in between rounds, in order to keep the zombie spawning near constant.

	local starttime = CurTime() + time
	hook.Add("Think", "nzRoundPreparing", function()
		if CurTime() > starttime then
			if self:InProgress() then self:Start() end
			hook.Remove("Think", "nzRoundPreparing")
		end
	end)

	if self:IsSpecial() and nzMapping.Settings.timedgame ~= 1 then
		local specialround = math.random(nzMapping.Settings.specialroundmin or 5, nzMapping.Settings.specialroundmax or 7)
		self:SetNextSpecialRound(self:GetNumber() + specialround)
	end
end

local CurRoundOverSpawned = false

function nzRound:Start()

	self:SetState( ROUND_PROG )

	self:SetZombiesKilled( 0 )

	if nzMapping.Settings.timedgame == 1 then
		local time = CurTime() + nzMapping.Settings.timedgametime * self:GetNumber()
		local cap = CurTime() + nzMapping.Settings.timedgamemaxtime
		if time > cap then
			time = cap
		end
		self:SetTimedRoundTime( time )
	else
		self:SetTimedRoundTime( 0 )
	end

	local spawner = self:GetNormalSpawner()
	if spawner then
		if self:GetNumber() == 1 then
			spawner:SetNextSpawn( CurTime() + 7 ) -- Round 1 spawns are delayed by a comical amount... Mainly so the First round music can play fully.
		else
			spawner:SetNextSpawn( CurTime() + 3 ) -- Delayed zombie spawning.
		end
		if nzMapping.Settings.timedgame == 1 then
			spawner:SetNextSpawn( CurTime() + 0.1 ) -- Only wait 0.1 seconds on Timed Gameplay.
		end
	end

	local specialspawner = self:GetSpecialSpawner()
	if self:IsSpecial() then
        if specialspawner then
            specialspawner:SetNextSpawn( CurTime() + 6 ) -- Delay spawning even further
        end
		timer.Simple(3, function()
			nzRound:CallHellhoundRound() -- Play the sound
		end)
		
		local data = self:GetSpecialRoundData()
		if data and data.roundfunc then data.roundfunc() end
	end

	--Notify
	--PrintMessage( HUD_PRINTTALK, "ROUND: " .. self:GetNumber() .. " started" )
	hook.Call("OnRoundStart", nzRound, self:GetNumber() )
	--nzNotifications:PlaySound("nz/round/round_start.mp3", 1)

	timer.Create( "NZRoundThink", 0.1, 0, function() self:Think() end )

	nzWeps:DoRoundResupply()
	
	if self:GetNumber() == -1 then
		self.InfinityStart = CurTime()
	end

	if self:GetNumber() == 1 then
		nzRound:EnableInitialBossRound()
	end
end

function nzRound:Think()
	if self.Frozen then return end
	hook.Call( "OnRoundThink", self )
	--If all players are dead, then end the game.

	if #player.GetAllPlayingAndAlive() < 1 then
		local b_canend = hook.Run("CanEndGame", self)
		if b_canend == nil or b_canend then
			self:End()
			timer.Remove( "NZRoundThink" )
			return -- bail
		end
	end

	--If we've killed all the spawned zombies, then progress to the next level.
	local numzombies = nzEnemies:TotalAlive()

	-- failsafe temporary until i can identify the issue (why are not all zombies spawned and registered)
	--[[local zombiesToSpawn
	if self:GetNormalSpawner() then
		zombiesToSpawn = self:GetNormalSpawner():GetZombiesToSpawn()
	end

	if self:GetSpecialSpawner() then
		if zombiesToSpawn then
			zombiesToSpawn = zombiesToSpawn + self:GetSpecialSpawner():GetZombiesToSpawn()
		else
			zombiesToSpawn = self:GetSpecialSpawner():GetZombiesToSpawn()
		end
	end

	self:SetZombiesToSpawn(zombiesToSpawn)]]

	if (self:GetZombiesKilled() >= self:GetZombiesMax() and self:GetNumber() ~= -1) or (CurTime() > self:GetTimedRoundTime() and nzMapping.Settings.timedgame == 1) then
		if numzombies <= 0 or (CurTime() > self:GetTimedRoundTime() and nzMapping.Settings.timedgame == 1) then
			self:Prepare()
			timer.Remove( "NZRoundThink" )
		end
	end
end

function nzRound:ResetGame()
	--Main Behaviour
	nzDoors:LockAllDoors()
	self:Waiting()

	--Notify
	PrintMessage( HUD_PRINTTALK, "GAME READY!" )

	--Reset variables
	self:SetNumber( 0 )
	self:SetZombiesKilled( 0 )
	self:SetZombiesMax( 0 )
	self:SetVictory( false )

	--Remove all enemies
	for k,v in pairs( nzConfig.ValidEnemies ) do
		for k2, v2 in pairs( ents.FindByClass( k ) ) do
			v2:Remove()
		end
	end

	--Reset the electricity
	nzElec:Reset(true)

	--Remove the random box
	nzRandomBox.Remove()

	--Reset all perk machines
	for k,v in pairs(ents.FindByClass("perk_machine")) do
		v:TurnOff()
		v:SetLooseChange(true)
		v:SetBrutusLocked(false)
	end

	for k,v in pairs(ents.FindByClass("stinky_lever")) do
		v:Setohfuck(false)
	end

	if nzRound:GetRampage() then
		nzRound:DisableRampage()
	end

	for _, ply in pairs(player.GetAll()) do
		if ply:IsReady() then
			ply:UnReady() --Reset all player ready states
		end

		if ply:GetNotDowned() then
			ply:DownPlayer()
		end

		ply:KillDownedPlayer(true) --Reset all downed players' downed status
		ply.SoloRevive = nil -- Reset Solo Revive counter
		ply:SetNW2Int("nz.SoloReviveCount", #player.GetAll() <= 1 and (nzMapping.Settings.solorevive or 3) or 0)

		if ply.GetUsingSpecialWeapon then
			ply:SetUsingSpecialWeapon(false)
		end
		ply:SetHealth(ply:GetMaxHealth())
		ply:SetPreventPerkLoss(false)
		ply:RemovePerks(true) --Remove all players perks
		ply:RemoveUpgrades() --Remove all players perk upgrades

		if ply:IsPlaying() then
			ply:SetPlaying(false) --Resets all active palyers playing state
		end

		ply.OldWeapons = nil --Remove stored weapons
		ply.OldUpgrades = nil --Remove stored perks
		ply.OldPerks = nil --Remove stored perk upgrades
		ply.lasthit = 0

		ply:SetPoints(0) --Reset all player points
		ply:SetTotalRevives(0) --Reset all player total revive
		ply:SetTotalDowns(0) --Reset all player total down
		ply:SetTotalKills(0) --Reset all player total kill
	end

	--Clean up powerups
	nzPowerUps:CleanUp()

	--Reset easter eggs
	nzEE:Reset()
	nzEE.Major:Reset()

	--Reset Box and Pap uses.
	nzPowerUps.HasPaped = false
	nzPowerUps.BoxMoved = false

	--Reset perk slot rewards
	nzRound.RewardedPerkSlots = nil
	nzRound.NextPerkSlot = nil

	nzPerks:ResetMaxPlayerPerks()
	GetConVar("nz_downtime"):SetFloat(nzMapping.Settings.downtime or 45)
	GetConVar("nz_revivetime"):SetFloat(nzMapping.Settings.revivetime or 4)
	RunConsoleCommand("sv_gravity", tostring(nzMapping.Settings.gravity or 600))

	for k,v in pairs(ents.FindByClass("player_spawns")) do
		v:SetTargetPriority(TARGET_PRIORITY_NONE) -- Get rid of the spawn's target priority.
	end

	navmesh.Load() -- Refreshes the navmesh/Rids it of navlock modifications.

	-- Load queued config if any
	if nzMapping.QueuedConfig then
		nzMapping:LoadConfig(nzMapping.QueuedConfig.config, nzMapping.QueuedConfig.loader)
	end
end

local cvar_classictext = GetConVar("nz_rounds_survived_classic")

function nzRound:GameOver(message, time, noautocam, camstart, camend, ourtype, keepplaying)
	local gameovertext = nzMapping.Settings.gameovertext or "Game Over"
	local survivedtext = nzMapping.Settings.survivedtext or "You Survived % Rounds"
	survivedtext = string.Replace(survivedtext, "%", self:GetNumber() - (1 - math.Round(cvar_classictext:GetInt())))

	if ourtype then
		if ourtype == "win" then
			gameovertext = nzMapping.Settings.gamewintext or "Game Over"
			survivedtext = nzMapping.Settings.escapedtext or "You Escaped after % Rounds"
			survivedtext = string.Replace(survivedtext, "%", self:GetNumber())
		end
		if ourtype == "inf" then
			local inftime = string.FormattedTime(CurTime() - self.InfinityStart)
			local inftimestr = string.format("%02i:%02i:%02i", inftime.h, inftime.m, inftime.s)
			survivedtext = nzMapping.Settings.infinitytext or "You Survived for %"
			survivedtext = string.Replace(survivedtext, "%", inftimestr)
		end
	end

	if message and isstring(message) and message ~= "" then
		survivedtext = message
	end

	net.Start("nz_game_end_notif")
		net.WriteString(tostring(gameovertext))
		net.WriteString(tostring(survivedtext))
	net.Broadcast()

	if keepplaying then return end

	local mapcamtime = nzMapping.Settings.gocamerawait
	local mapcamstart = nzMapping.Settings.gocamerastart
	local mapcamend = nzMapping.Settings.gocameraend

	if not noautocam and (!mapcamstart or table.IsEmpty(mapcamstart) or (camstart and camend)) then
		local poses = {}
		local zposes = {}
		for k, v in pairs(ents.FindByClass("player_spawns")) do
			poses[#poses + 1] = v:GetPos()
		end
		for k, v in pairs(ents.FindByClass("nz_spawn_zombie_normal")) do
			zposes[#zposes + 1] = v:GetPos()
		end

		local sum = Vector(0,0,0)
		for _, v3 in pairs(poses) do
			sum = sum + v3
		end
		local finalpos = (sum / #poses)

		local zsum = Vector(0,0,0)
		for _, v3 in pairs(zposes) do
			zsum = zsum + v3
		end
		local endpos = (zsum / #zposes)

		camstart = camstart or (finalpos + vector_up*72)
		camend = camend or (endpos + vector_up*72)

		timer.Simple(mapcamtime, function()
			for _, ply in pairs(player.GetAll()) do
				ply:ScreenFade(SCREENFADE.IN, color_black, 2, engine.TickInterval())
			end

			nzEE.Cam:QueueView(time - mapcamtime, camstart, camend, nil, true, nil)
			nzEE.Cam:Begin()
		end)
	elseif mapcamstart and mapcamend and mapcamtime then
		timer.Simple(mapcamtime, function()
			for _, ply in pairs(player.GetAll()) do
				ply:ScreenFade(SCREENFADE.IN, color_black, 2, engine.TickInterval())
			end

			local ourtime = (time - mapcamtime)*(1/#mapcamstart)
			for id, pos in pairs(mapcamstart) do
				nzEE.Cam:QueueView(ourtime, pos, mapcamend[id], nil, true, nil)
			end

			nzEE.Cam:Begin()
		end)
	end

	-- Set round state to Game Over
	self:SetState( ROUND_GO )

	nzPowerUps:CleanUp()

	if self.OverrideEndSlomo then
		game.SetTimeScale(0.25)
		timer.Simple(2, function()
			game.SetTimeScale(1)
		end)
	end

	if !ourtype or ourtype ~= "win" then
		for _, ply in pairs(player.GetAllPlaying()) do
			ply:Give("tfa_zomdeath")
			ply:SetHealth(1)
			ply.lasthit = math.huge
		end
	end

	timer.Simple(nzMapping.Settings.gocamerawait, function()
		for _, ply in pairs(player.GetAllPlaying()) do
			if ply:GetNotDowned() then
				ply:DownPlayer()
			end

			ply:KillDownedPlayer(true) --Reset all downed players' downed status
			ply.SoloRevive = nil -- Reset Solo Revive counter

			if ply.GetUsingSpecialWeapon then
				ply:SetUsingSpecialWeapon(false)
			end
			ply:SetHealth(ply:GetMaxHealth())
			ply:SetPreventPerkLoss(false)
			ply:RemovePerks(true) --Remove all players perks
			ply:RemoveUpgrades() --Remove all players perk upgrades

			ply.OldWeapons = nil --Remove stored weapons
			ply.OldUpgrades = nil --Remove stored perks
			ply.OldPerks = nil --Remove stored perk upgrades
			ply.lasthit = 0
		end
	end)

	timer.Simple(time, function()
		nzRound:ResetGame()
	end)

	hook.Call( "OnRoundEnd", nzRound )
end

function nzRound:End(message, time, noautocam, camstart, camend)
	local time = time or nzRound:GameOverDuration()

	if self:GetNumber() == -1 then
		self:GameOver(message, time, noautocam, camstart, camend, self.InfinityStart and "inf" or nil)
		nzSounds:Play("GameEnd")
	elseif nzMapping.OfficialConfig then
		self:GameOver(message, time, noautocam, camstart, camend)
		nzSounds:Play("GameEnd")
	else
		self:GameOver(message, time, noautocam, camstart, camend)
		nzSounds:Play("GameEnd")
	end
end

function nzRound:Win(message, keepplaying, time, noautocam, camstart, camend)
	self:SetVictory(true)

	local time = time or self:GameOverDuration()
	self:GameOver(message, time, noautocam, camstart, camend, "win", keepplaying)
	nzSounds:Play("GameEnd")

	hook.Call("OnRoundWin", nzRound, !self:InState(ROUND_GO)) //bool for if the game kept going or not

	if !keepplaying then
		timer.Remove("NZRoundThink")
	else
		timer.Simple(0, function()
			local currentRound = self:GetNumber()
			self:SetNumber(currentRound)  -- Set the round to the current number to end it
			nzPowerUps:Nuke(nil, true, true, true)  -- Nuke kills all zombies, no points, no position delay

			local nextRound = currentRound + 1
			if nzMapping.Settings.timedgame ~= 1 then
				local specialround = math.random(nzMapping.Settings.specialroundmin or 5, nzMapping.Settings.specialroundmax or 7)
				self:SetNextSpecialRound(nextRound + specialround)
			end
			self:Prepare()
		end)
	end
end

function nzRound:Lose(message, time, noautocam, camstart, camend)
	local time = time or self:GameOverDuration()
	self:GameOver(message, time, noautocam, camstart, camend)

	nzSounds:Play("GameEnd")
	timer.Remove("NZRoundThink")
end

function nzRound:Create(on)
	if on then
		if self:InState( ROUND_WAITING ) then
			PrintMessage( HUD_PRINTTALK, "The mode has been set to creative mode!" )
			self:SetState( ROUND_CREATE )
			hook.Call("OnRoundCreative", nzRound)
			--We are in create
			for _, ply in pairs( player.GetAll() ) do
				if ply:IsSuperAdmin() then
					ply:GiveCreativeMode()
				end
				if ply:IsReady() then
					ply:SetReady( false )
				end
			end

			nzMapping:CleanUpMap()
			nzDoors:LockAllDoors()

			navmesh.Load() -- Refreshes the navmesh/Rids it of navlock modifications.
			
			for k,v in pairs(ents.GetAll()) do
				if v.NZOnlyVisibleInCreative then
					v:SetNoDraw(false)
				end
			end
			
			self:SetZombieHealth(100)
		else
			PrintMessage( HUD_PRINTTALK, "Can only go in Creative Mode from Waiting state." )
		end
	elseif self:InState( ROUND_CREATE ) then
		PrintMessage( HUD_PRINTTALK, "The mode has been set to play mode!" )
		self:SetState( ROUND_WAITING )
		--We are in play mode
		for k,v in pairs(player.GetAll()) do
			v:SetSpectator()
		end

		for k,v in pairs(ents.FindByClass("perk_machine")) do
			v:SetLooseChange(true)
		end

		for k,v in pairs(ents.GetAll()) do
			if v.NZOnlyVisibleInCreative then -- This is set in each entity's file
				v:SetNoDraw(true) -- Yes this improves FPS by ~50% over a client-side convar and round state check
			end
		end
	else
		PrintMessage( HUD_PRINTTALK, "Not in Creative Mode." )
	end
end

function nzRound:SetupGame()
	self:SetNumber( 0 )

	-- Store a session of all our players
	for _, ply in pairs(player.GetAll()) do
		if not IsValid(ply) then continue end

		if ply:IsReady() then
			ply:SetPlaying(true)
		end

		ply:SetUsingSpecialWeapon(false)
		ply:SetPreventPerkLoss(false)
		ply:RemovePerks(true) --Remove all players perks
		ply:RemoveUpgrades() --Remove all players perk upgrades

		ply.OldWeapons = nil --Remove stored weapons
		ply.OldUpgrades = nil --Remove stored perks
		ply.OldPerks = nil --Remove stored perk upgrades

		ply:SetPoints(0) --Reset all player points
		ply:SetTotalRevives(0) --Reset all player total revive
		ply:SetTotalDowns(0) --Reset all player total down
		ply:SetTotalKills(0) --Reset all player total kill

		ply:SetFrags( 0 ) --Reset all player kills
	end

	nzMapping:CleanUpMap()
	nzDoors:LockAllDoors()
	
		--master spawner failsafe
	local normalMaster = false
		for k, v in ipairs( ents.FindByClass( "nz_spawn_zombie_normal" ) ) do
            	if v:GetMasterSpawn() then
                	normalMaster = true
					break
            	end        	
			end

		if not normalMaster then
		    	for k, v in ipairs( ents.FindByClass( "nz_spawn_zombie_normal" ) ) do
					v:SetMasterSpawn(true)
					break
    	end
		PrintMessage( HUD_PRINTTALK, "You need to place a normal master spawner. Skill issue." )
		end
	--special spawner check
	local specialMaster = false
		for k, v in ipairs( ents.FindByClass( "nz_spawn_zombie_special" ) ) do
            	if v:GetMasterSpawn() then
                	specialMaster = true
					break
            	end        	
			end

		if not specialMaster then
		    	for k, v in ipairs( ents.FindByClass( "nz_spawn_zombie_special" ) ) do
					v:SetMasterSpawn(true)
					break
    	end
		PrintMessage( HUD_PRINTTALK, "You need to place a special master spawner. Skill issue." )
		end
		
		
	nzNav.Functions.NavLockApply() -- Apply the Nav Locks that exist. Just don't do "nav_save" while playing... If you do this I want you to know personally that you're an idiot.

	-- Open all doors with no price and electricity requirement
	for k,v in pairs(ents.GetAll()) do
		if v:IsBuyableEntity() then
			local data = v:GetDoorData()
			if data then
				if tonumber(data.price) == 0 and tobool(data.elec) == false then
					nzDoors:OpenDoor( v )
				end
			end
		end
		-- Setup barricades
		if v:GetClass() == "breakable_entry" then
			v:ResetPlanks()
		end
	end

	-- Empty the link table
	table.Empty(nzDoors.OpenedLinks)

	-- All doors with Link 0 (No Link)
	nzDoors.OpenedLinks[0] = true
	--nz.nzDoors.Functions.SendSync()

	-- Spawn a random box at a possible starting position
	nzRandomBox.Spawn(nil, true)

	local power = ents.FindByClass("power_box")
	if !IsValid(power[1]) then -- No power switch D:
		nzElec:Activate(true) -- Silently turn on the power
	else
		nzElec:Reset() -- Reset with no value to play the power down sound
	end

	GetConVar("nz_downtime"):SetFloat(nzMapping.Settings.downtime or 45)
	GetConVar("nz_revivetime"):SetFloat(nzMapping.Settings.revivetime or 4)
	RunConsoleCommand("sv_gravity", tostring(nzMapping.Settings.gravity or 600))

	nzPerks:ResetMaxPlayerPerks()
	nzPerks:UpdateQuickRevive()

	if nzMapping.Settings.timedgame ~= 1 then
		local specialround = math.random(nzMapping.Settings.specialroundmin or 5, nzMapping.Settings.specialroundmax or 7)
		if nzMapping.Settings.forcefirstspecialround then
			specialround = (nzMapping.Settings.firstspecialround or 5)
		end
		nzRound:SetNextSpecialRound(self:GetNumber() + specialround)
	end

	nzEE.Major:Reset()

	for k,v in pairs(ents.FindByClass("player_spawns")) do
		v:SetTargetPriority(TARGET_PRIORITY_NONE) -- Get rid of the spawn's target priority.
	end

	hook.Call( "OnGameBegin", nzRound )
end

function nzRound:Freeze(bool)
	self.Frozen = bool
end

function nzRound:RoundInfinity(nokill)
	if !nokill then
		nzPowerUps:Nuke(nil, true) -- Nuke kills them all, no points, no position delay
	end

	nzRound:SetNumber( -2 )
	nzRound:SetState(ROUND_PROG)
	nzRound:Prepare()
end
