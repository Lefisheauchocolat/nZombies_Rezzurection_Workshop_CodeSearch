-- 

hook.Add("Think", "CheckActivePowerups", function()
	for k, v in pairs(nzPowerUps.ActivePowerUps) do
		if CurTime() >= v then
			local func = nzPowerUps:Get(k).expirefunc
			if func then func(k) end

			nzPowerUps.ActivePowerUps[k] = nil
			nzPowerUps:SendSync()
		end
	end

	for k,v in pairs(nzPowerUps.ActivePlayerPowerUps) do
		if not IsValid(k) then
			nzPowerUps.ActivePlayerPowerUps[k] = nil
			nzPowerUps:SendPlayerSyncFull()
		else
			for id, time in pairs(v) do
				if CurTime() >= time then
					local func = nzPowerUps:Get(id).expirefunc
					if func then func(id, k) end
					nzPowerUps.ActivePlayerPowerUps[k][id] = nil
					nzPowerUps:SendPlayerSync(k)
				end
			end
		end
	end
end)

function nzPowerUps:Nuke(pos, nopoints, noeffect, instant)
	-- Kill them all
	local highesttime = 0
	local total = {}

	local function NukeKill(ent) //this would be usefull as a function on the zombies
		if math.random(5) <= 2 then
			if ent.IsMooZombie and !ent.IsMooSpecial then
				ent:GibHead()
			end
		end

		ent:TakeDamage(ent:Health() + 666, Entity(0), Entity(0))

		ent:Ignite(5)
		ent:EmitSound("nz_moo/powerups/nuke_ignite.mp3", 511)	
		if ent.NukeDeathSounds then
			ent:EmitSound(ent.NukeDeathSounds[math.random(#ent.NukeDeathSounds)], 75, math.random(75,135))
		end
	end

	for _, ent in nzLevel.GetZombieArray() do
		if IsValid(ent) and ent:IsValidZombie() and !ent.IsTurned and ent:Alive() then
			ent:OnNuke() -- Call this function on the zombies so special enemies can react if coded.

			if !ent.NZBossType and !ent.IsMiniBoss and !ent.IsMooBossZombie then
				highesttime = highesttime + math.Rand(0.15, 0.45)

				ent:SetRunSpeed(1)
				ent:SpeedChanged()
				ent:SetBlockAttack(true)

				if math.random(100) < 50 then
					ent:PerformStun(666)
				end

				ent.BeingNuked = true
				table.insert(total, ent)

				if instant then
					NukeKill(ent)
				else
					-- In Serverside related stuff, timers are fine.
					timer.Simple(highesttime, function()
						if not IsValid(ent) then return end
						NukeKill(ent)
					end)
				end
			end
		end
	end

	if self.ActivePowerUps["nuke"] then
		self.ActivePowerUps["nuke"] = CurTime() + highesttime + engine.TickInterval()
	end

	if #total == 1 and TFA.BO3GiveAchievement then
		timer.Simple(highesttime, function()
			for _, ply in pairs(player.GetAllPlaying()) do
				if !IsValid(ply) or !ply:IsPlayer() then continue end
				if ply.MOOS_FAV_THING_TO_SAY_ON_NUKES_TM then continue end

	      		TFA.BO3GiveAchievement("Weapon of Minor Destruction", "vgui/overlay/achievment/Weapon_of_Minor_Destruction_WaW.png", ply)
	    		ply.MOOS_FAV_THING_TO_SAY_ON_NUKES_TM = true
			end
		end)
	end

	if nopoints and !nzPowerUps.NoNukePoints then
		nzPowerUps.NoNukePoints = true
	end

	if not noeffect then
		nzSounds:Play("Kaboom")
		for _, ply in ipairs(player.GetAll()) do
			ply:ScreenFade(SCREENFADE.IN, ColorAlpha(color_white, 12), 1.2, 0 )
		end
	end

	for k,v in nzLevel.GetZombieSpawnArray() do
        if IsValid(v) and v:GetMasterSpawn() and !instant then
        	v.NukeDelay = true
        end
    end
end

function nzPowerUps:FireSale()
	-- Like a sane person, the functions of Fire Sale boxes being created is handled by the box spawn entity itself now.

	--print("Running")
	-- Get all spawns
	--[[local all = ents.FindByClass("random_box_spawns")
	
	for k,v in pairs(all) do
		if not IsValid(v.Box) then
			local box = ents.Create( "random_box" )
			local pos = v:GetPos()
			local ang = v:GetAngles()
			
			if (nzMapping.Settings.boxtype == "Original" or nzMapping.Settings.boxtype == "Black Ops 3" or nzMapping.Settings.boxtype == "Black Ops 3(Quiet Cosmos)" or nzMapping.Settings.boxtype == "Leviathan") then
				box:SetPos( pos + ang:Up()*10 + ang:Right()*7 )
			else
				box:SetPos( pos + ang:Right()*7 )
			end

			box:SetAngles( ang )
			box:Spawn()
			box.SpawnPoint = v
			box.IsFireSaleBox = true

			v.FireSaleBox = box
			
			v:SetBodygroup(1,1)

			local phys = box:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion(false)
			end
		end
	end]]
end

function nzPowerUps:Carpenter(nopoints, pos)
	-- Repair them all, More nZU code? no way.
	if !pos or !isvector(pos) then
		pos = vector_origin //use map origin
	end

	if nopoints and !nzPowerUps.NoCarpenterPoints then
		nzPowerUps.NoCarpenterPoints = true //hack, see carpenter in sh_powerups
	end

	local barricades = ents.FindByClass("breakable_entry")
	if not IsValid(barricades[1]) then
		if self.ActivePowerUps["carpenter"] then
			self.ActivePowerUps["carpenter"] = CurTime()
		end
		return
	end

	local sortedcades = {}
	for i=1, #barricades do
		local ent = barricades[i]
		if not IsValid(ent) then continue end
		sortedcades[i] = ent:GetPos():DistToSqr(pos)
	end

	local count = 0
	local highesttime = 0

	for k, dist in SortedPairsByValue(sortedcades) do
		local ent = barricades[k]
		if not IsValid(ent) then return end

		if ent:GetHasPlanks() then //0.05 second for every plank, _zm_powerups.gsc#L1196
			count = count + (6 - ent:GetNumPlanks())
		end

		local t = (count*0.05) + math.Clamp(dist/2000, 0, 4) //just so carpenter doesnt go on forever
		if t > highesttime then
			highesttime = t
		end

		timer.Simple(t, function()
			if IsValid(ent) and !IsValid(ent.ZombieUsing) then
				ent:FullRepair()
			end
		end)
	end

	if self.ActivePowerUps["carpenter"] then
		self.ActivePowerUps["carpenter"] = CurTime() + highesttime + engine.TickInterval()
	end
end

function nzPowerUps:CleanUp()
	-- Clear all powerups
	for k,v in pairs(ents.FindByClass("drop_powerup")) do
		v:Remove()
	end

	nzPowerUps.BoxMoved = false
	nzPowerUps.HasPaped = false

	-- Turn off all modifiers
	table.Empty(self.ActivePowerUps)
	table.Empty(self.ActiveAntiPowerUps)

	-- Sync
	self:SendSync()
end
