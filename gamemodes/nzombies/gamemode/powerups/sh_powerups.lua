-- 

if SERVER then
	local plyMeta = FindMetaTable("Player")

	function plyMeta:GivePowerUp(id, duration)
		if duration > 0 then
			if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} end
			
			nzPowerUps.ActivePlayerPowerUps[self][id] = (nzPowerUps.ActivePlayerPowerUps[self][id] or CurTime()) + duration
			nzPowerUps:SendPlayerSync(self) -- Sync this player's powerups
		end
	end

	function plyMeta:RemovePowerUp(id, nosync)
		local PowerupData = nzPowerUps:Get(id)
		if PowerupData and PowerupData.expirefunc then
			PowerupData.expirefunc(id, self) -- Call expirefunc when manually removed
		end
	
		if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} end
		nzPowerUps.ActivePlayerPowerUps[self][id] = nil
		if not nosync then nzPowerUps:SendPlayerSync(self) end -- Sync this player's powerups
	end

	function plyMeta:RemoveAllPowerUps()
		if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} return end
		
		for k,v in pairs(nzPowerUps.ActivePlayerPowerUps[self]) do
			self:RemovePowerUp(k, true)
		end
		nzPowerUps:SendPlayerSync(self)
	end

	function nzPowerUps:Activate(id, ply, ent)
		if hook.Call("OnPlayerPickupPowerUp", nil, ply, id, ent) then return end
		
		local PowerupData = self:Get(id)

		if not PowerupData.global then
			if IsValid(ply) then
				if not nzPowerUps.ActivePlayerPowerUps[ply] or not nzPowerUps.ActivePlayerPowerUps[ply][id] then -- If you don't have the powerup
					PowerupData.func(id, ply)
				end
				ply:GivePowerUp(id, PowerupData.duration * (ply:HasUpgrade("time") and 2 or 1))
			end
		else
			if PowerupData.duration ~= 0 then
				-- Activate for a certain time
				if not self.ActivePowerUps[id] then
					PowerupData.func(id, ply)
				end
				self.ActivePowerUps[id] = (self.ActivePowerUps[id] or CurTime()) + PowerupData.duration * ((IsValid(ply) and ply:HasUpgrade("time")) and 2 or 1)
			else
				-- Activate Once
				PowerupData.func(id, ply)
			end
			-- Sync to everyone
			self:SendSync()
			
		end

		-- Notify
		
		if IsValid(ply) then 
		end

		-- if PowerupData.announcement then
		-- 	nzNotifications:PlaySound(PowerupData.announcement, 1)
		-- end
		if isstring(PowerupData.announcement) then
			local name = string.Replace(PowerupData.name, " ", "") -- Sound Events don't have spaces
			nzSounds:Play(name)
		end
	end


	--[[ Moo Mark 7/14/23:
		Added a drop cycle system to closer mimic
		how drops are handled in the real games.
		This will insure that you only ever get
		one of each drop per cycle.
		A cycle will be completed once the core four
		drops have appeared, these include: Insta-Kill, Double Points, Nuke, and Max Ammo.
		There is still some RNG involved but this makes drops more predictable and can
		also allow players to manipulate it by meeting criteria that stop other drops from spawning.
	]]
	local dropsthisround = 0
	local maxdrops = 4

	-- For reference so these are ALWAYS inserted into the core drops table if any of them are enabled in the map settings.
	local ogdrops = {
		insta = true,
		nuke = true,
		dp = true,
		maxammo = true,
	}

	-- These drops are forbidden from ever being considered core. Mainly cuz these powerups have criteria that keep them from EVER spawning.
	local forbiddenfromcore = {
		zombieblood = true,
		firesale = true,
		bottle = true,
		bottleslot = true,
		carpenter = true,
		timewarp = true,
		bloodmoney = true,
		godmode = true,
	}

	local dropped = {}
	local possibledrops = {}
	local coredrops = {}
	local iscoredrop = {}
	local allowedPowerups = {}
	local possibleforcore = {}

	hook.Add("OnRoundStart", "NODROPSFUCKU", function() 
		dropsthisround = 0
		if nzRound:IsSpecial() then
			maxdrops = 0 -- No drops on special rounds :wind_blowing_face:
		else
			maxdrops = 4
		end
		if nzRound:GetNumber() <= 1 then -- Reset everything on the first round... Or negative one... For some fucking reason idk, Justin Case.
			coredrops = {}
			dropped = {}
			possibledrops = {}
			iscoredrop = {}
			allowedPowerups = {}
			possibleforcore = {}

			nzPowerUps:SetupCoreDrops()
		end
	end)

	function nzPowerUps:SetupCoreDrops()
		if nzMapping.Settings.poweruplist then
			for k, v in pairs(nzMapping.Settings.poweruplist) do
				if v[1] then
					allowedPowerups[k] = true
					if !forbiddenfromcore[k] then
						possibleforcore[k] = true 
					end
				end
			end
		end

		-- Initial loop: Check each Original Powerup to see if it can be added(Add to the table if so.)
		for k2, v2 in pairs(ogdrops) do
			if table.Count(iscoredrop) < 4 then
				if allowedPowerups[k2] and ogdrops[k2] then
					iscoredrop[k2] = true 
				end
			end
		end

		-- Secondary loop: If any of the Original Powerups are missing(Disabled), add a new powerup to fill in for it.
		for k3, v3 in pairs(possibleforcore) do
			if table.Count(iscoredrop) < 4 then
				if !iscoredrop[k3] and !ogdrops[k3] then
					iscoredrop[k3] = true 
				end
			end
		end

		print("Core Drops for this Match:")
		PrintTable(iscoredrop)
		
		--print("Allowed Powerups:")
		--PrintTable(allowedPowerups)
	end

	function nzPowerUps:SpawnPowerUp(pos, specific)
		if specific or dropsthisround < maxdrops then -- If the drop is specific then it should ALWAYS spawn no matter what.

			local barricades = ents.FindByClass("breakable_entry")
			local choices = {}

			-- Queue all possible powerups
			if not specific then
				for k, v in pairs(self.Data) do
					if k ~= "maxammo" and nzRound:IsSpecial() then continue end -- Only allow max ammos on special rounds.
					if k == "bloodmoney" then continue end -- WHO ARE YOU?!
					if k == "zombieblood" and #player.GetAllPlaying() <= 1 then continue end
					if k == "godmode" and #player.GetAllPlaying() <= 1 then continue end
					if k == "firesale" and !nzPowerUps:GetBoxMoved() then continue end
					if k == "timewarp" and nzRound:GetNumber() < 9 then continue end
					if k == "bottleslot" and GetConVar("nz_difficulty_perks_max"):GetInt() >= 8 then continue end -- NOOOOO MOOOOORE INFINITE PERK SLOTS!!!!
					if k == "carpenter" then
						if #barricades >= 4 then
							local barricades_broken = 0
							for _,barricade in pairs(barricades) do 
								if barricade:GetHasPlanks() and (barricade:GetNumPlanks() <= 0) then
									barricades_broken = barricades_broken + 1
								end
							end

							if (barricades_broken < 5) then
								continue
							end
						else
							continue
						end
					end

					if k ~= "ActivePowerUps" and !dropped[k] and allowedPowerups[k] then -- Now tweaked to check if the powerup is enabled.
						table.insert(possibledrops, k) -- Only insert the ones that haven't dropped yet or met the criteria to drop.
					end
				end
			end

			local powup = possibledrops[math.random(#possibledrops)] -- Now select a random powerup.

			local id = specific and specific or powup
			if not id or id == "null" then return end --  Back out

			local ent = ents.Create("drop_powerup")
			id = hook.Call("OnPowerUpSpawned", nil, id, ent) or id
			if not IsValid(ent) then return end -- If a hook removed the powerup

			-- Spawn it
			local PowerupData = self:Get(id)

			local pos = pos + Vector(0, 0, 50)

			ent:SetPowerUp(id)
			pos.z = pos.z - ent:OBBMaxs().z
			ent:SetModel(PowerupData.model)
			ent:SetPos(pos)
			ent:SetAngles(PowerupData.angle)
			ent:Spawn()

			if id ~= specific and !specific then -- If the drop was specific/set, then it was probably important thus not having it count towards the cycle.
				--if id == "insta" or id == "dp" or id == "maxammo" or id == "nuke" then
				if iscoredrop[id] and !dropped[id] then
					table.insert(coredrops, id)
				end

				dropsthisround = dropsthisround + 1
				dropped[powup] = true

				if table.Count(coredrops) >= 4 then -- All of the core drops dropped... Reset the cycle.
					coredrops = {}
					dropped = {}
				end
			end

			PrintTable(possibledrops)
			possibledrops = {}

			-- PrintTable(coredrops)
			-- print(dropsthisround)
		end
	end
end

function nzPowerUps:IsPowerupActive(id)
	local time = self.ActivePowerUps[id]

	if time ~= nil then
		-- Check if it is still within the time.
		if CurTime() > time then
			-- Expired
			self.ActivePowerUps[id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:IsPlayerPowerupActive(ply, id)
	if not self.ActivePlayerPowerUps[ply] then self.ActivePlayerPowerUps[ply] = {} end
	local time = self.ActivePlayerPowerUps[ply][id]

	if time then
		-- Check if it is still within the time.
		if CurTime() > time then
			-- Expired
			self.ActivePlayerPowerUps[ply][id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:AllActivePowerUps()
	return self.ActivePowerUps
end

function nzPowerUps:NewPowerUp(id, data)
	if SERVER then
		-- Sanitise any client data.
	else
		data.Func = nil
	end
	self.Data[id] = data
end

function nzPowerUps:GetList()
	local tbl = {}

	for k,v in pairs(nzPowerUps.Data) do
		tbl[k] = v.name
	end

	return tbl
end

function nzPowerUps:Get(id)
	return self.Data[id]
end

-- Double Points
nzPowerUps:NewPowerUp("dp", {
	name = "Double Points",
	model = "models/powerups/w_double.mdl",
	global = true, -- Global means it will appear for any player and will refresh its own time if more
	angle = Angle(25,0,0),
	scale = 1,
	chance = 5,
	duration = 30,
	addpitch = 50,
	nopitchshift = 0,
	natural = true,
	announcement = "",
	loopsound = "nz_moo/powerups/doublepoints_loop_zhd.wav",
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
	func = function(self, ply)
		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				ply:TakePoints(1150)
				ply:ChatPrint( "115 Tax" )
			end
		end
	end,
})

-- Max Ammo
nzPowerUps:NewPowerUp("maxammo", {
	name = "Max Ammo",
	model = "models/powerups/w_maxammo.mdl",
	global = true,
	angle = Angle(0,0,25),
	scale = 1,
	chance = 5,
	duration = 0,
	natural = true,
	func = (function(self, ply)
		nzSounds:Play("MaxAmmo")
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Max Ammo!")
			net.WriteBool(true)
		net.Broadcast()
		-- Give everyone ammo
		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				for k,v in pairs(player.GetAll()) do
					v:ChatPrint( "Thank Joe Biden for this" )
					v:RemoveAllAmmo()
				end
			else
				for k,v in pairs(player.GetAll()) do
					v:GiveMaxAmmo()
				end	
			end
		else
			for k,v in pairs(player.GetAll()) do
				v:GiveMaxAmmo()
			end
		end
	end),
})

-- Insta Kill
nzPowerUps:NewPowerUp("insta", {
	name = "Insta Kill",
	model = "models/powerups/w_insta.mdl",
	global = true,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 5,
	duration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = "",
	loopsound = "nz_moo/powerups/instakill_loop_zhd.wav",
	stopsound = "nz_moo/powerups/instakill_end.mp3",
	func = function(self, ply)
		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				ply:SetHealth(1)
				ply:ChatPrint( "FIGHT FOR YOUR LIFE" )
			end
		end
	end,
})

-- Nuke
nzPowerUps:NewPowerUp("nuke", {
	name = "Nuke",
	model = "models/powerups/w_nuke.mdl",
	global = true,
	angle = Angle(10,0,0),
	scale = 1,
	chance = 5,
	duration = 0,
	natural = true,
	announcement = "",
	func = (function(self, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Ka-Boom!")
			net.WriteBool(false)
		net.Broadcast()

		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				nzPowerUps:Nuke(ply:GetPos())
			else
				PrintMessage( HUD_PRINTTALK, "Who didn't pay electric bill?!" )
				nzElec:Reset()
			end
		else
			nzPowerUps:Nuke(ply:GetPos())
		end
	end),
})

-- Fire Sale
nzPowerUps:NewPowerUp("firesale", {
	name = "Fire Sale",
	model = "models/powerups/w_firesale.mdl",
	global = true,
	angle = Angle(45,0,0),
	scale = 0.75,
	chance = 1,
	duration = 30,
	natural = true,
	announcement = "",
	--loopsound = "nz_moo/powerups/firesale_jingle.mp3", -- This makes the Firesale Jingle 2d. Its also a good way to prank Youtubers by giving them a Copyright Claim! Now thats what I call goofy.
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
	func = (function(self, ply)
		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				nzPowerUps:FireSale()
			else
				for k,v in pairs(player.GetAll()) do
					v:ChatPrint( "Stop Gambling Addictions Today" )
					local tbl = ents.FindByClass("random_box_spawns")
					for k,v in pairs(tbl) do
						if IsValid(v) then
							v:StopSound("nz_firesale_jingle")
							v:Remove()
						end
					end
				end
			end
		else
			nzPowerUps:FireSale()
		end
	end),
	expirefunc = function()
		local tbl = ents.FindByClass("random_box_spawns")
		for k,v in pairs(tbl) do
			local box = v.FireSaleBox
			if IsValid(box) then
				box:StopSound("nz_firesale_jingle")
				if box.MarkForRemoval then
					box:MarkForRemoval()
					box.FireSaling = false
				else
					box:Remove()
				end
			end
		end
	end,
})

-- Carpenter
nzPowerUps:NewPowerUp("carpenter", {
	name = "Carpenter",
	model = "models/powerups/w_carpenter.mdl",
	global = true,
	angle = Angle(45,0,0),
	scale = 1,
	chance = 5,
	duration = 7,
	natural = true,
	loopsound = "nz_moo/powerups/carpenter_loop_classic.wav",
	stopsound = "nz_moo/powerups/carpenter_end_classic.mp3",
	func = (function(self, ply)
		nzSounds:Play("Carpenter")
		nzPowerUps:Carpenter()
	end),
})

-- Zombie Blood
nzPowerUps:NewPowerUp("zombieblood", {
	name = "Zombie Blood",
	model = "models/powerups/w_zombieblood.mdl",
	global = false, -- Only applies to the player picking it up and time is handled individually per player
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = "nz/powerups/zombie_blood.wav",
	loopsound = "nz_moo/powerups/zombieblood_loop.wav",
	stopsound = "nz_moo/powerups/zombieblood_stop.mp3",
	func = (function(self, ply)
		if nzMapping.Settings.negative == true then
			if math.random(100) <= 25 then
				ply:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
				local zombls = ents.FindInSphere(ply:GetPos(), 5000)
				for k,v in pairs(zombls) do
					if IsValid(v) and v:IsValidZombie() then
						v:SetTarget(ply)
					end
				end
			else
				ply:SetTargetPriority(TARGET_PRIORITY_NONE)
			end
		else
			ply:SetTargetPriority(TARGET_PRIORITY_NONE)
		end
	end),
	expirefunc = function(self, ply) -- ply is only passed if the powerup is non-global
		if IsValid(ply) then
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
	end,
})

//Lightning is power
nzPowerUps:NewPowerUp("deathmachine", {
	name = "Death Machine",
	model = "models/powerups/w_deathmachine.mdl",
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 30,
	natural = true,
	announcement = "",
	func = (function(self, ply)
		if IsValid(ply) then
			ply:SetUsingSpecialWeapon(true)
			ply:Give(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")
			ply:SelectWeapon(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")
		end
	end),
	expirefunc = function(self, ply)
		if IsValid(ply) then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")
			end)
		end
	end,
})

--Blood Money
nzPowerUps:NewPowerUp("bonuspoints", {
    name = "Bonus Points",
    model = "models/powerups/w_zmoney.mdl",
    global = true, --Bo4 enstated that Bonus Points are Rated E for everyone!
    angle = Angle(0,0,0),
    scale = 1,
    chance = 2,
    duration = 0,
	natural = true,
    announcement = "",
    func = (function(self, ply)
		local BONUS = (math.random(25,150) * 10) -- Everyone should get the same amount.
		for k, v in pairs(player.GetAllPlaying()) do
			v:GivePoints(BONUS)
		end
    end),
})

--Perk Bottle(the one that gives you a perk slot)
nzPowerUps:NewPowerUp("bottleslot", {
    name = "Broken Bottle",
    model = "models/powerups/w_brokenbottle.mdl",
    global = true,
    angle = Angle(0,0,0),
    scale = 1,
    chance = 3,
    duration = 0,
	natural = false,
    announcement = "",
    func = (function(self, ply)
    	local P = GetConVar("nz_difficulty_perks_max"):GetInt()
        GetConVar("nz_difficulty_perks_max"):SetInt(P+1)
    end),
})

-- Perk Bottle(The one that actually gives you a perk)
nzPowerUps:NewPowerUp("bottle", {
    name = "Perk Bottle",
    model = "models/powerups/w_perkbottle.mdl",
    global = true,
    angle = Angle(0,0,0),
    scale = 1,
    chance = 0,
    duration = 0,
    natural = false,
    announcement = "",
    func = (function(self, ply)
        net.Start("nzPowerUps.PickupHud")
            net.WriteString("Free Perk!")
            net.WriteBool(true)
        net.Send(ply)

        for k,v in pairs(player.GetAllPlaying()) do
            local available = {}
            local fizzlist = nzMapping.Settings.wunderfizzperklist
            local blockedperks = {
                ["wunderfizz"] = true,
                ["pap"] = true,
                ["gum"] = true,
            }

            for perk, _ in pairs(nzPerks:GetList()) do
                if blockedperks[perk] then continue end
                if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then continue end
                if v:HasPerk(perk) then continue end
                table.insert(available, perk)
            end

            if table.IsEmpty(available) then nzSounds:PlayEnt("Laugh", v) end

            v:GivePerk(available[math.random(#available)])
        end
    end),
})

--Bonfire Sale
nzPowerUps:NewPowerUp("bonfiresale", {
    name = "BonFire Sale",
    model = "models/powerups/w_bonfire.mdl",
    global = true,
    angle = Angle(0,0,0),
    scale = 1,
    chance = 1,
    duration = 60,
	addpitch = 5,
	nopitchshift = 0,
	natural = false,
    announcement = "",
	loopsound = "nz_moo/powerups/omnov001l_1_l.wav",
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
    func = (function(self, ply)
    end),
})

nzPowerUps:NewPowerUp("timewarp", {
    name = "TimeWarp",
    model = "models/wavy/powerups/w_timewarp.mdl",
    global = true,
    angle = Angle(0,0,0),
    scale = 1.5,
    chance = 1,
    duration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
    announcement = "",
	loopsound = "nz_moo/powerups/timewarp_loop.wav",
	stopsound = "nz_moo/powerups/instakill_end.mp3",
    func = (function(self, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Time-Warp!")
			net.WriteBool(true)
		net.Broadcast()
    end),
})

nzPowerUps:NewPowerUp("berzerk", {
	name = "Berzerk",
	model = "models/wavy/powerups/w_fullpower.mdl",
	global = false,
	angle = Angle(0,0,0),
	scale = 1.2,
	chance = 2,
	duration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = "",
	loopsound = "powerups/berzerk_loop.wav",
	stopsound = "powerups/berzerk_end.wav",
	func = (function(self, ply)
		if IsValid(ply) then
			ply:SetUsingSpecialWeapon(true)
			ply:Give("nz_berzerk_fists")
			ply:SelectWeapon("nz_berzerk_fists")
		end
	end),
	expirefunc = function(self, ply)
		if IsValid(ply) then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon("nz_berzerk_fists")
			end)
		end
	end,
})

nzPowerUps:NewPowerUp("infinite", {
    name = "Infinite Ammo",
    model = "models/powerups/w_infinite.mdl",
    global = true,
    angle = Angle(25,0,0),
    scale = 1.2,
    chance = 5,
    duration = 30,
    addpitch = 50,
    nopitchshift = 0,
    natural = true,
    announcement = "",
    loopsound = "powerups/infiniteammo_loop.wav",
    stopsound = "powerups/infiniteammo_end.mp3",

    func = (function(self, ply)
		local clipSizeCheckTimerName = "clipSizeCheckTimer"
		local illegalspecials = {
			["specialweapon"] = true, //would do nothing
			["grenade"] = true, //would do nothing
			["knife"] = true,
			["display"] = true,
		}

		timer.Create(clipSizeCheckTimerName, 0.1, 0, function()
			if nzPowerUps:IsPowerupActive("infinite") then
				for _, ply in ipairs(player.GetAll()) do
					local wep = ply:GetActiveWeapon()
					if not IsValid(wep) then continue end
					if wep.NZSpecialCategory and illegalspecials[wep.NZSpecialCategory] then continue end

					if wep.IsTFAWeapon then
						if (wep.Primary_TFA and wep.Primary_TFA.ClipSize) and wep.Primary_TFA.ClipSize > 0 and wep:GetPrimaryAmmoType() > 0 then
							wep:SetClip1(wep.Primary_TFA.ClipSize)
						end
						if (wep.Secondary_TFA and wep.Secondary_TFA.ClipSize) and wep.Secondary_TFA.ClipSize > 0 and (wep.ShieldEnabled or wep:GetSecondaryAmmoType() > 0) then
							wep:SetClip2(wep.Secondary_TFA.ClipSize)
						end
					else
						if wep:GetMaxClip1() > 0 then
							wep:SetClip1(wep:GetMaxClip1())
						end
						if wep:GetMaxClip2() > 0 then
							wep:SetClip2(wep:GetMaxClip2())
						end
					end
				end
			else
                timer.Remove(clipSizeCheckTimerName)
            end
        end)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Infinite Ammo!")
			net.WriteBool(true)
		net.Broadcast()
    end),

    expirefunc = function(self, ply)
    end
})

nzPowerUps:NewPowerUp("random", {
    name = "Mystery",
    model = "models/powerups/w_random.mdl",
    global = true,
    angle = Angle(25,0,0),
    scale = 1.2,
    chance = 5,
    duration = 1,
    addpitch = 50,
    nopitchshift = 0,
    natural = false,

func = (function(self, ply)
    
    local possiblePowerups = {
        "maxammo",
        "nuke",
        "dp",
        "timewarp",
        "insta",
        "infinite",
        "bonuspoints",
		"bottle"
    }
    
    local randomPowerup = possiblePowerups[math.random(#possiblePowerups)]
    
    nzPowerUps:Activate(randomPowerup, ply)
end),
})

nzPowerUps:NewPowerUp("packapunch", {
    name = "Pack A Punch",
    model = "models/powerups/w_packapunch.mdl",
    global = false,
    angle = Angle(25,0,0),
    scale = 0.8,
    chance = 5,
    duration = 1,
    addpitch = 50,
    nopitchshift = 0,
    natural = false,
    announcement = "",

func = (function(self, ply)
	local wep = ply:GetActiveWeapon()
	if wep.NZSpecialCategory and !wep.OnPaP then
		for k, v in pairs(ply:GetWeapons()) do
			if v:GetNWInt("SwitchSlot", 0) > 0 and not v:HasNZModifier("pap") then
				wep = v
				break
			end
		end
	end
	if not IsValid(wep) then return end

	if wep.NZPaPReplacement then
		local wep2 = ply:Give(wep.NZPaPReplacement)
		wep2:ApplyNZModifier("pap")
		ply:SelectWeapon(wep2:GetClass())
		ply:StripWeapon(wep:GetClass())
	elseif wep.OnPaP then
		if wep:HasNZModifier("pap") then
			wep:ApplyNZModifier("repap")
		else
			wep:ApplyNZModifier("pap")
		end

		wep:ResetFirstDeploy()
		wep:CallOnClient("ResetFirstDeploy", "")
		wep:Deploy()
		wep:CallOnClient("Deploy", "")
	end
end),
})

nzPowerUps:NewPowerUp("godmode", {
    name = "Invulnerability",
    model = "models/powerups/w_godmode.mdl",
    global = false,
    angle = Angle(0, 0, 0),
    scale = 1.2,
    chance = 2,
    duration = 30,
    addpitch = 5,
    nopitchshift = 0,
    natural = true,
    announcement = "",
    loopsound = "powerups/lattegodmode_loop.wav",
    stopsound = "powerups/godmode_end.mp3",
    func = (function(self, ply)
        ply:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
        local function GodModeTimer()
            if not nzPowerUps:IsPowerupActive("godmode") then
                timer.Remove("GodModeTimer_" .. ply:EntIndex())
                return
            end
            local zombls = ents.FindInSphere(ply:GetPos(), 5000)
            for k, v in pairs(zombls) do
                if IsValid(v) and v:IsValidZombie() then
                    v:SetTarget(ply)
                end
            end
            timer.Simple(1, GodModeTimer)
        end
        timer.Create("GodModeTimer_" .. ply:EntIndex(), 1, 0, GodModeTimer)
    end),
    expirefunc = function(self, ply) -- ply is only passed if the powerup is non-global
        if IsValid(ply) then
            ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
            timer.Remove("GodModeTimer_" .. ply:EntIndex())
        end
    end,
})

nzPowerUps:NewPowerUp("weapondrop", {
	name = "Random Weapon",
	model = "models/powerups/w_randomgun.mdl",
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 1,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = "",
    func = (function(self, ply)
	local class = nzRandomBox.DecideWep(ply)
	ply:Give(class)
    end),
})

nzPowerUps:NewPowerUp("quickfoot", {
	name = "Quick Foot",
	model = "models/powerups/w_quickfoot.mdl",
	global = false,
	angle = Angle(0,0,0),
	scale = 1.2,
	chance = 2,
	duration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = "",
	loopsound = "powerups/quick_loop.wav",
	stopsound = "nz_moo/powerups/zombieblood_stop.mp3",
    func = (function(self, ply)
	ply:SetWalkSpeed(300)
	ply:SetRunSpeed(600)
	ply:SetMaxRunSpeed( 600 )
    end),
	
    expirefunc = function(self, ply)
	ply:SetWalkSpeed(ply:HasPerk("staminup") and 210 or 190)
	ply:SetRunSpeed(ply:HasPerk("staminup") and 341 or 310)
	ply:SetMaxRunSpeed(ply:HasPerk("staminup") and 341 or 310)
    end
})
