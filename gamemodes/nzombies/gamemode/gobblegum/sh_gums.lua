function nzGum:RegisterGum(gumid, data)
	nzGum.Gums[gumid] = data
end

function nzGum:GetData(gumid)
	return nzGum.Gums[gumid]
end

local function GetBoxAroundEnt(ply, poss, donttouchplayer, dontignorepowerups, filters)
	return util.TraceHull({
		start = poss or ply:GetPos(),
		endpos = poss or ply:GetPos(),
		maxs = Vector(ply:OBBMaxs().X / ply:GetModelScale(), ply:OBBMaxs().Y / ply:GetModelScale(), ply:OBBMaxs().Z / ply:GetModelScale()), -- Exactly the size the player uses to collide with stuff
		mins = Vector(ply:OBBMins().X / ply:GetModelScale(), ply:OBBMins().Y / ply:GetModelScale(), ply:OBBMins().Z / ply:GetModelScale()), -- ^
		collisiongroup = COLLISION_GROUP_PLAYER, -- Collides with stuff that players collide with
		mask = MASK_PLAYERSOLID, -- Detects things like map clips
		filter = function(ent) -- Slow but necessary
			if not donttouchplayer and ent:IsPlayer() or not dontignorepowerups and string.sub(ent:GetClass(), 1, 5) == "drop_" or filters and table.HasValue(filters, ent:GetClass()) then return end -- The ent is a different player (AutoUnstuck_IgnorePlayers ConVar)
			--if ent:IsValidZombie() then return true end
			return true
		end
	})
end

/*EXAMPLE
nzGum:RegisterGum("unique_id", {
	name = "Gum Name",
	desc = "Short description of how the gum works.",
	icon = Material("path/to/icon.png", "smooth unlitgeneric"),
	type = nzGum.Types.USABLE, //gum usage type, refer to Types table above
	rare = nzGum.RareTypes.DEFAULT, //gum rarity, refer to RareTypes table above (THIS IS REALLY FUCKING NEEDED!!!!!!!!!!!)
	multiplayer = bool, //set to true for gum to only be rolled in multiplayer (example, phoenix up)
	donteraseonspawn = bool, //set to true for gum to not be consumed after respawning, delete if not needed

	//SPECIFIC GUM TYPE VARIABLES
	uses = 1, //amount of uses the gum will have, delete if not a use based gum
	time = 60, //time in seconds the gum will last, delete if not a time based gum
	rounds = 3, //amount of rounds the gum will last, delete if not a round based gum
	desc_howactivates = "How to use special description.", //for special gums with unique activation cases, delete if not using

	//WEAPON MODIFIER VARIABLES
	modifier = "modifier_id", //runs WEAPON:ApplyNZModifier("modifier_id") on ALL held weapons
	revert = bool, //set to true to revert weapon modifier when gum is used up/expires

	//if time/round based gum, applys modifier on pickup
	//if uses based gum, applys modifier on use

	//SPECIFIC GUM TYPE FUNCTIONS
	onuse = function(ply) //SERVER, called when player presses gum use key, delete if not a usable type gum
	end,

	ontimerstart = function(ply) //SERVER, called when gum timer is started, delete if not a time based gum
	end,
	ontimerend = function(ply) //SERVER, called when gum timer expires, delete if not a time based gum
	end,

	//GENERIC GUM FUNCTIONS
	canuse = function(ply) //SHARED, called when player tries to activate gum, delete if not needed
		return true
	end,
	canroll = function(ply, ent) //SERVER, called when player tries to roll for a gum from a gobble gum machine, delete if not needed
		return true
	end,

	ongain = function(ply) //SERVER, called when gum is picked up by player, delete if not needed
	end,
	onerase = function(ply) //SERVER, called when gum is used up, delete if not needed
	end,
})
*/

--[[-------------------------------------------------------------------------
Purples
---------------------------------------------------------------------------]]

nzGum:RegisterGum("kill_joy", {
	name = "Kill Joy",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns an Insta-Kill Power-Up.",
	icon = Material("gums/KillJoy.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "insta")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "insta")
		end
	end,
})

nzGum:RegisterGum("cache_back", {
	name = "Cache Back",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 1,
	desc = "Spawns a Max Ammo Power-Up.",
	icon = Material("gums/CacheBack.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "maxammo")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "maxammo")
		end
	end,
})

nzGum:RegisterGum("whos_keeping_score", {
	name = "Who's Keeping Score?",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Double Points Power-Up.",
	icon = Material("gums/WhosKeepingScore.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "dp")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "dp")
		end
	end,
})

nzGum:RegisterGum("licensed_contractor", {
	name = "Licensed Contractor",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Carpenter Power-Up.",
	icon = Material("gums/LicensedContractor.png", "smooth unlitgeneric"),
	canroll = function(ply, ent)
		local barricades = ents.FindByClass("breakable_entry")
		if (#barricades < 1) then
			return false
		end

		return true
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "carpenter")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "carpenter")
		end
	end,
})

nzGum:RegisterGum("dead_of_nuclear_winter", {
	name = "Dead of Nuclear Winter",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawn a Nuke Power-Up.",
	icon = Material("gums/DeadOfNuclearWinter.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "nuke")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "nuke")
		end
	end,
})

nzGum:RegisterGum("on_the_house", {
	name = "On the House",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 1,
	desc = "Spawns a Random Perk Bottle Power-Up.",
	icon = Material("gums/OnTheHouse.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "bottle")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "bottle")
		end
	end,
})

nzGum:RegisterGum("im_feeling_lucky", {
	name = "I'm Feeling Lucky",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Mystery Power-Up.",
	icon = Material("gums/ImFeelingLucky.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "random")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "random")
		end
	end,
})

nzGum:RegisterGum("extra_credit", {
	name = "Extra Credit",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 2,
	desc = "Spawns a Bonus Points Power-Up.",
	icon = Material("gums/ExtraCredit.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "bonuspoints")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "bonuspoints")
		end
	end,
})

nzGum:RegisterGum("fatal_contraption", {
	name = "Fatal Contraption",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Death Machine Power-Up.",
	icon = Material("gums/FatalContraption.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "deathmachine")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "deathmachine")
		end
	end,
})

nzGum:RegisterGum("firearm_formulation", {
	name = "Firearm Formulation",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawn a Random Weapon Power-Up.",
	icon = Material("gums/FirearmFormulation.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "weapondrop")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "weapondrop")
		end
	end,
})

nzGum:RegisterGum("lead_rain", {
	name = "Lead Rain",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 2,
	desc = "Spawn a Infinite Ammo Power-Up.",
	icon = Material("gums/LeadRain.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "infinite")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "infinite")
		end
	end,
})

nzGum:RegisterGum("anywhere_but_here", {
	name = "Anywhere But Here",
	desc = "Instantly teleport to a random location. \nA concussive blast knocks away any nearby zombies, keeping you safe.",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 2,
	icon = Material("gums/AnywhereButHere.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local startpos = ply:GetPos()
		local pos = startpos
		local spawns = {}

		for k, v in nzLevel.GetSpecialSpawnArray() do
			if IsValid(v) and (v.link == nil or nzDoors:IsLinkOpened(v.link)) and v:IsSuitable() then
				table.insert(spawns, v)
			end
		end

		if table.IsEmpty(spawns) or !IsValid(spawns[1]) then
			local pspawns = ents.FindByClass("player_spawns")
			if !IsValid(pspawns[1]) then
				ply:ChatPrint("Couldnt find an escape boss, sorry 'bout that.")
			else
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		else
			pos = spawns[math.random(#spawns)]:GetPos()
		end

		ply:EmitSound("NZ.ChuggaBud.Sweet")
		ply:ViewPunch(Angle(-4, math.random(-6, 6), 0))
		ply:SetPos(pos)

		timer.Simple(0, function()
			if not IsValid(ply) then return end

			ply:SetPos(pos)
			ply:EmitSound("NZ.ChuggaBud.Teleport")
			ParticleEffect("nz_perks_chuggabud_tp", pos, angle_zero)

			local damage = DamageInfo()
			damage:SetAttacker(ply)
			damage:SetInflictor(ply:GetActiveWeapon())
			damage:SetDamageType(DMG_MISSILEDEFENSE)

			for k, ent in pairs(ents.FindInSphere(ply:WorldSpaceCenter(), 150)) do
				if ent.IsAlive and ent:IsAlive() and (ent:IsValidZombie() or ent.IsMooZombie) and !(ent.NZBossType or ent.IsMooBossZombie) then
					damage:SetDamage(75)
					damage:SetDamagePosition(ent:WorldSpaceCenter())
					ent:TakeDamageInfo(damage)
				end
			end
		end)
	end,
})

nzGum:RegisterGum("in_plain_sight", {
	name = "In Plain Sight",
	type = nzGum.Types.USABLE_WITH_TIMER,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "You are ignored by zombies for 10 seconds.",
	uses = 2,
	time = 10,
	icon = Material("gums/InPlainSight.png", "smooth unlitgeneric"),
	ontimerstart = function(ply)
		if IsValid(ply) then
			ply:EmitSound("nz_moo/powerups/zombieblood_start.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
			ply:SetTargetPriority(TARGET_PRIORITY_NONE)
		end
	end,
	ontimerend = function(ply)
		if IsValid(ply) then
			ply:EmitSound("nz_moo/powerups/zombieblood_stop.mp3", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
	end,
})

nzGum:RegisterGum("ctrl_z", {
	name = "CTRL Z",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "Turn a random nearby zombie.",
	uses = 2,
	icon = Material("gums/CTRLZ.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		for k, v in nzLevel.GetZombieArray() do
			if v:GetRangeTo(ply) < 500 then
				if v.BecomeTurned then continue end
				if v.IsAATTurned and v:IsAATTurned() then continue end

				v:AATTurned(60, ply, false)
				break
			end
		end
	end,
})

nzGum:RegisterGum("hordes_up", {
	name = "Hordes Up",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	desc = "Summons an army of the undead.",
	uses = 1,
	icon = Material("gums/hordesup.png", "smooth unlitgeneric"),
	canroll = function(ply)
		local zspawn = ents.FindByClass("nz_spawn_zombie_normal")[1]
		local spawn = ents.FindByClass("player_spawns")[1]

		return IsValid(zspawn) and IsValid(spawn)
	end,
	canuse = function(ply)
		return !nzRound:IsSpecial() and nzRound:InState(ROUND_PROG)
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		for i=1, 12 do
			timer.Simple(i*0.25, function()
				if not IsValid(ply) then return end
				local nearbyents = {}
				for k, v in pairs(ents.FindByClass("nz_spawn_zombie_normal")) do
					if v.GetSpawner and v:GetSpawner() and v:IsSuitable() then
						table.insert(nearbyents, v)
					end
				end

				local zspawn = table.Random(nearbyents)
				local spawn = table.Random(ents.FindByClass("player_spawns"))

				if IsValid(spawn) and IsValid(zspawn) and zspawn:IsSuitable() then
					local class
					local spawntypes = {
						["nz_spawn_zombie_normal"] = true,
						["nz_spawn_zombie_extra1"] = true,
						["nz_spawn_zombie_extra2"] = true,
						["nz_spawn_zombie_extra3"] = true,
						["nz_spawn_zombie_extra4"] = true,
					}

					if !nzRound:IsSpecial() and zspawn:GetZombieType() ~= "none" and spawntypes[zspawn:GetClass()] then
						class = zspawn:GetZombieType()
					elseif nzRound:IsSpecial() and !spawntypes[zspawn:GetClass()] and zspawn:GetClass() == "nz_spawn_zombie_special" and zspawn:GetZombieType() ~= "none" then
						class = zspawn:GetZombieType()
					else
						class = nzMisc.WeightedRandom(zspawn:GetZombieData(), "chance")
					end

					local zombie = ents.Create(class)
					zombie:SetPos(spawn:GetPos())
					zombie:SetAngles(spawn:GetAngles())
					zombie:Spawn()

					zombie:SetSpawner(zspawn:GetSpawner())
					zombie:Activate()
					zombie:AATTurned(60, ply, false)

					hook.Call("OnZombieSpawned", nzEnemies, zombie, zspawn)
					nzRound:SetZombiesMax(nzRound:GetZombiesMax() + 1) //how illegal is this
					zspawn:SetZombiesToSpawn(zspawn:GetZombiesToSpawn() + 1) //on a scale of 1-10

					if nzRound:IsSpecial() then
						local data = nzRound:GetSpecialRoundData()
						if data and data.spawnfunc then
							data.spawnfunc(zombie)
						end
					end

					//zspawn:SetNextSpawn(CurTime() + zspawn:GetSpawner():GetDelay() * 2)
				end
			end)
		end
	end,
})

nzGum:RegisterGum("reign_drops", {
	name = "Reign Drops",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	uses = 1,
	desc = "Spawns all the core Power-Ups at once.",
	icon = Material("gums/ReignDrops.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local powerups = {
			"insta", "maxammo", "dp", "nuke", "bonuspoints", "carpenter"
		}
		local i = 0
		table.Shuffle(powerups)
		local pastpos = ply:GetPos()
		local pastaimvector = ply:GetAimVector()
		local middleofspawns = Vector(pastpos[1] + pastaimvector[1] * 160,
			pastpos[2] + pastaimvector[2] * 160,
			pastpos[3] + 5)
		local offsety = pastaimvector[2] < 0 and -140 or 140
		local offsetx = 50 * -pastaimvector[1]
		timer.Create("nzGum_reign_drops_" .. ply:EntIndex(), 0.5, #powerups, function()
			if i % 3 == 0 then
				offsetx = 50 * -pastaimvector[1]
				offsety = offsety - (pastaimvector[2] < 0 and -70 or 70)
			else
				offsetx = offsetx - 50 * -pastaimvector[1]
			end
			i = i + 1

			local enddir
			if math.abs(pastaimvector[1]) > math.abs(pastaimvector[2]) then
				enddir = pastaimvector[1] < .5 and pastaimvector[1] > -.5 and Vector(middleofspawns[1] - offsety,
				middleofspawns[2] - offsetx,
				middleofspawns[3]) or Vector(middleofspawns[1] - offsetx,
				middleofspawns[2] - offsety,
				middleofspawns[3])
			else
				enddir = pastaimvector[2] < .5 and pastaimvector[2] > -.5 and Vector(middleofspawns[1] - offsety,
				middleofspawns[2] - (50 * pastaimvector[2]),
				middleofspawns[3]) or Vector(middleofspawns[1] - offsety,
				middleofspawns[2] - (50 * pastaimvector[2] * (i % 3 == 0 and 0 or i % 3 == 1 and -1 or 1)),
				middleofspawns[3])
			end

			local spawn_pos = not GetBoxAroundEnt(ply, enddir).Hit and enddir or pastpos + vector_up

			nzPowerUps:SpawnPowerUp(spawn_pos, powerups[i])
		end)
	end,
})

nzGum:RegisterGum("monkey_business", {
	name = "Monkey Business",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Summon a Monkey Bomb at your feet.",
	icon = Material("gums/MonkeyBusiness.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local simian = ents.Create("nz_bo3_tac_monkeybomb")
		simian:SetPos(ply:GetPos() + vector_up)
		simian:SetAngles(ply:GetAngles())
		simian:SetModel("models/weapons/tfa_bo3/monkeybomb/monkeybomb_prop.mdl")
		simian:SetOwner(ply)
		simian:Spawn()
		
		local phys = simian:GetPhysicsObject()

		simian:ActivateCustom(phys)
	end,
})

nzGum:RegisterGum("thinking_with_portals", {
	name = "Thinking with Portals",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 1,
	desc = "Summon a Gersch Device at your feet.",
	icon = Material("gums/ThinkingWithPortals.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		local simian = ents.Create("nz_bo3_tac_gersch")
		simian:SetPos(ply:GetPos() + vector_up)
		simian:SetAngles(ply:GetAngles())
		simian:SetModel("models/weapons/tfa_bo3/gersch/w_gersch.mdl")
		simian:SetOwner(ply)
		simian:Spawn()
		
		local phys = simian:GetPhysicsObject()

		simian:ActivateCustom(phys)
	end,
})

nzGum:RegisterGum("bullet_boost", {
	name = "Bullet Boost",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 2,
	desc = "Grants your gun a random AAT.",
	icon = Material("gums/BulletBoost.png", "smooth unlitgeneric"),
	canuse = function(ply)
		local gun = ply:GetActiveWeapon()
		if IsValid(gun) and not gun:IsSpecial() and gun:HasNZModifier("pap") and (ply:IsInCreative() or (gun:GetNWInt("switchslot", 0) > 0)) then
			if SERVER then
				ply.BulletBoostWeapon = gun
			end
			return true
		end

		for _, wep in ipairs(ply:GetWeapons()) do
			if not wep:IsSpecial() and wep:HasNZModifier("pap") and (ply:IsInCreative() or (wep:GetNWInt("switchslot", 0) > 0)) then
				if SERVER then
					ply.BulletBoostWeapon = wep
				end
				return true
			end
		end

		return false
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		local wep = ply.BulletBoostWeapon
		if IsValid(wep) then
			wep:RandomizeAAT()
			ply.BulletBoostWeapon = nil

			if wep.IsTFAWeapon then
				wep:ResetFirstDeploy()
				wep:CallOnClient("ResetFirstDeploy", "")
			end
		end
	end,
})

nzGum:RegisterGum("crawl_space", {
	name = "Crawl Space",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 3,
	desc = "All alive zombies become crawlers.",
	icon = Material("gums/CrawlSpace.png", "smooth unlitgeneric"),
	onuse = function(ply)
		if not IsValid(ply) then return end

		for k, v in nzLevel.GetZombieArray() do
			if IsValid(v) and v:IsAlive() and v:Health() > 0 and v:IsValidZombie() and !v:GetCrawler() and !v.IsMooSpecial then
				v:GibLegR()
				v:GibLegL()
			end
		end
	end,
	onerase = function(ply)
	end,
})

nzGum:RegisterGum("phoenix_up", {
	name = "Phoenix Up",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	uses = 1,
	desc = "Revive all downed players. Revived players keep their perks.",
	icon = Material("gums/PheonixUp.png", "smooth unlitgeneric"),
	multiplayer = true,
	canuse = function(ply)
		for _, ply in pairs(player.GetAll()) do
			if ply:Alive() and !ply:GetNotDowned() then
				return true
			end
		end

		return false
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		for k, v in pairs(player.GetAll()) do
			if IsValid(v) and !v:GetNotDowned() then
				v:RevivePlayer(ply)
				v:EmitSound("bo3/gobblegum/phoenix/bgb_phoenix.mp3", SNDLVL_GUNFIRE)

				for _, perk in pairs(v.OldPerks) do
					v:GivePerk(perk)
				end

				for _, upg in pairs(v.OldUpgrades) do
					v:GiveUpgrade(upg)
				end
			end
		end
	end,
})

nzGum:RegisterGum("nowhere_but_there", {
	name = "Nowhere But There",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 1,
	desc = "Instantly teleport to a downed players location.",
	icon = Material("gums/NowhereButThere.png", "smooth unlitgeneric"),
	multiplayer = true,
	canuse = function(ply)
		for _, ply in pairs(player.GetAll()) do
			if ply:Alive() and !ply:GetNotDowned() then
				return true
			end
		end

		return false
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		local startpos = ply:GetPos()
		local pos = startpos
		local spawns = {}

		for k, v in pairs(player.GetAll()) do
			if IsValid(v) and v:Alive() and !v:GetNotDowned() then
				table.insert(spawns, v)
			end
		end

		if table.IsEmpty(spawns) or !IsValid(spawns[1]) then
			ply:ChatPrint("No one needs help, chill.")
		else
			pos = spawns[math.random(#spawns)]:GetPos()
		end

		ply:EmitSound("NZ.ChuggaBud.Sweet")
		ply:ViewPunch(Angle(-4, math.random(-6, 6), 0))
		ply:SetPos(pos + Vector(0,0,5))

		timer.Simple(0, function()
			if not IsValid(ply) then return end

			ply:SetPos(pos + Vector(0,0,5))
			ply:EmitSound("NZ.ChuggaBud.Teleport")
			ParticleEffect("nz_perks_chuggabud_tp", pos, angle_zero)
		end)    
	end,
})

nzGum:RegisterGum("respin_cycle", {
	name = "Respin Cycle",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 2,
	desc = "Re-spins the Mystery Box after it has been opened.",
	icon = Material("gums/RespinCycle.png", "smooth unlitgeneric"),
	canuse = function(ply)
		local success = false
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 100)) do
			if v:GetClass() == "random_box_windup" then
				if (v:GetIsTeddy() or v:GetWinding()) then continue end
				if IsValid(v:GetBuyer()) and ply ~= v:GetBuyer() then continue end

				if SERVER then
					ply.RespinWindupGun = v
				end
				success = true
			end
			if v:GetClass() == "random_box" and !v:GetOpen() then
				success = false
			end
		end

		return success
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		local windup = ply.RespinWindupGun
		ply.RespinWindupGun = nil

		if IsValid(windup) and windup.Box and IsValid(windup.Box) then
			local box = windup.Box

			windup:Remove()
			box:Close()

			local class = nzRandomBox.DecideWep(ply)
			if class then
				box:Open()
				box:SpawnWeapon(ply, class)
			end
		end
	end,
})

nzGum:RegisterGum("mind_blown", {
	name = "Mind Blown",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 2,
	desc = "Instakills all zombies in your field of view.",
	icon = Material("gums/MindBlown.png", "smooth unlitgeneric"),
	onuse = function(ply)
		for k, v in pairs(ents.FindInCone(ply:GetPos(), ply:GetAimVector(), 2000, math.cos(math.rad(65)))) do //about 100fov
			if IsValid(v) and v:IsValidZombie() and !v.IsMooSpecial and v:Health() > 0 and ply:VisibleVec(v:WorldSpaceCenter()) then
				local headpos = v:EyePos()
				local headbone = v:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = v:LookupBone("j_head") end
				if headbone then headpos = v:GetBonePosition(headbone) end

				local dmg = DamageInfo()                
				dmg:SetInflictor(v)
				dmg:SetAttacker(ply)
				dmg:SetDamage(v:Health() + 666)
				dmg:SetDamageType(DMG_DIRECT)
				dmg:SetDamagePosition(headpos)

				v:TakeDamageInfo(dmg)
			end
		end
	end,
})

nzGum:RegisterGum("now_you_see_me", {
	name = "Now You See Me",
	type = nzGum.Types.USABLE_WITH_TIMER,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "All zombies will only target you.",
	uses = 2,
	time = 10,
	icon = Material("gums/NowYouSeeMe.png", "smooth unlitgeneric"),
	multiplayer = true,
	ontimerstart = function(ply)
		ParticleEffectAttach("bo3_aat_turned", PATTACH_ABSORIGIN_FOLLOW, ply, 0)
		ply:EmitSound("NZ.POP.Turned.Impact")

		for k, v in pairs(player.GetAll()) do
			if IsValid(v) and v:Alive() and v:GetNotDowned() and v ~= ply then
				if v.AntiBloodTarget then continue end
				v:SetTargetPriority(TARGET_PRIORITY_NONE)
			end
		end
	end,
	ontimerend = function(ply)
		ply:StopParticles()

		for k, v in pairs(player.GetAll()) do
			if IsValid(v) and v:Alive() and v:GetNotDowned() and v ~= ply then
				if nzPowerUps:IsPlayerPowerupActive(v, "zombieblood") then continue end
				v:SetTargetPriority(TARGET_PRIORITY_PLAYER)
			end
		end
	end,
})

nzGum:RegisterGum("overshielded", {
	name = "Overshielded",
	type = nzGum.Types.USABLE_WITH_TIMER,
	rare = nzGum.RareTypes.MEGA,
	desc = "Grants invincibility for a limited time.",
	uses = 2,
	time = 15,
	icon = Material("gums/Overshielded.png", "smooth unlitgeneric"),
	ontimerstart = function(ply)
		if IsValid(ply) and ply:Alive() and ply:GetNotDowned() then
			ply:WAWPlasmaRage(15)
		end
	end,
	ontimerend = function(ply)
	end,
})

nzGum:RegisterGum("point_drops", {
	name = "Point Drops",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "Take 1000 points from yourself, and give 500 points to every other player.",
	uses = 2,
	icon = Material("gums/pointdrops.png", "smooth unlitgeneric"),
	multiplayer = true,
	canroll = function(ply)
		return ply:CanAfford(1000)
	end,
	canuse = function(ply)
		return ply:CanAfford(1000)
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end

		ply:TakePoints(1000, true)
		for k, v in pairs(player.GetAll()) do
			if v:Alive() and (v:IsInCreative() or v:IsPlaying()) and v ~= ply then
				v:GivePoints(500, nil, true)
			end
		end
	end,
})

nzGum:RegisterGum("roundrobbin", {
	name = "Round Robbin'",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	desc = "Ends the current round. All players gain 1600 points.",
	uses = 1,
	icon = Material("gums/RoundRobbin.png", "smooth unlitgeneric"),
	canuse = function(ply)
		return not nzRound:IsSpecial()
	end,
	onuse = function(ply)
		local currentRound = nzRound:GetNumber()
		nzRound:SetNumber(currentRound)  -- Set the round to the current number to end it
		nzPowerUps:Nuke(nil, true, true, true)  -- Nuke kills all zombies, no points, no position delay

		local nextRound = currentRound + 1
		if nzMapping.Settings.timedgame ~= 1 then
			local specialround = math.random(nzMapping.Settings.specialroundmin or 5, nzMapping.Settings.specialroundmax or 7)
			self:SetNextSpecialRound(self:GetNumber() + specialround)
		end
		nzRound:Prepare()

		for k, v in pairs(player.GetAllPlaying()) do
			v:GivePoints(1600)
		end
	end,
})

nzGum:RegisterGum("ee_song", {
	name = "These Cats Are Cooking!",
	type = nzGum.Types.USABLE_WITH_TIMER,
	rare = nzGum.RareTypes.PINWHEEL,
	uses = 3,
	time = 240,
	desc = "Plays the maps easter egg song.",
	icon = Material("gums/TheseCatsAreCooking.png", "smooth unlitgeneric"),
	onuse = function(ply)
		PrintMessage( HUD_PRINTTALK,"Assume all Easter Egg songs are copyrighted!")
		nzSounds:Play("Music")
	end,
})

nzGum:RegisterGum("immolation_liquidation", {
	name = "Immolation Liquidation",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Fire Sale Power-Up.",
	icon = Material("gums/ImmolationLiquidation.png", "smooth unlitgeneric"),
	canroll = function(ply, ent)
		return nzPowerUps.BoxMoved == true
	end,
	onuse = function(ply)
		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "firesale")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "firesale")
		end
	end,
})

nzGum:RegisterGum("power_people", {
	name = "Power To The People",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 3,
	icon = Material("gums/PowerToThePeople.png", "smooth unlitgeneric"),
	desc = "Activates anything besides doors that require power within a radius around you.",
	canroll = function(ply, ent)
		if nzElec.IsOn() then
			return false
		end
		return true
	end,
	canuse = function(ply)
		if not IsValid(ply) then return false end

		local radius = 150
		local entities = ents.FindInSphere(ply:GetPos(), radius)
		local targets = {"perk_machine", "wunderfizz_machine"}
		
		for _, ent in ipairs(entities) do
			if table.HasValue(targets, ent:GetClass()) and ent.IsOn and not ent:IsOn() then
				return true 
			end
		end

		return false -- checks if there's anything to turn on, if not you cant use it
	end,
	onuse = function(ply)
		if not IsValid(ply) then return end
		
		local radius = 300
		local entities = ents.FindInSphere(ply:GetPos(), radius)
		local targets = {"perk_machine", "wunderfizz_machine"}
		
		for _, ent in ipairs(entities) do
			if table.HasValue(targets, ent:GetClass()) and ent.IsOn and not ent:IsOn() then
				ent:TurnOn()
			end
		end
	end,
})

nzGum:RegisterGum("doppelganger", {
	name = "Im Not That Man",
	type = nzGum.Types.USABLE_WITH_TIMER,
	rare = nzGum.RareTypes.MEGA,
	uses = 2,
	time = 10,
	desc = "Spawns a doppelganger clone to distract zombies.",
	icon = Material("gums/imnotthatman.png", "smooth unlitgeneric"),
	ontimerstart = function(ply)
		if not IsValid(ply) then return end

		local ghost = ents.Create("nz_gum_ghost")
		ghost:SetModel(ply:GetModel())
		ghost:SetPos(ply:GetPos())
		ghost:SetAngles(ply:GetAngles())
		ghost:SetOwner(ply)
		ghost.IsMonkeyBomb = true
		ghost:Spawn()

		ply.GumDoppelganger = ghost
	end,
	ontimerend = function(ply)
		if ply.GumDoppelganger and IsValid(ply.GumDoppelganger) then
			ply.GumDoppelganger:Remove()
		end
	end,
})

nzGum:RegisterGum("equipmint", {
	name = "Equip Mint",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 1,
	icon = Material("gums/equipmint.png", "smooth unlitgeneric"),
	desc = "Players grenades and equipment is replenished.",
	onuse = function(ply)
		local specialist = ply:GetSpecialWeaponFromCategory("specialist")
		if IsValid(specialist) and specialist.IsTFAWeapon then
			specialist:SetClip1(specialist.Primary_TFA.ClipSize)

			if specialist.OnSpecialistRecharged then
				specialist:OnSpecialistRecharged()
				specialist:CallOnClient("OnSpecialistRecharged", "")
			end
			hook.Run("OnSpecialistRecharged", specialist)

			if ply:GetActiveWeapon() ~= specialist then
				specialist:ResetFirstDeploy()
				specialist:CallOnClient("ResetFirstDeploy", "")
			end
		end

		local shield = ply:GetSpecialWeaponFromCategory("shield")
		if IsValid(shield) and shield.IsTFAWeapon and shield.Secondary_TFA then
			local clip2 = shield.Secondary_TFA.ClipSize
			if clip2 and clip2 > 0 then
				shield:SetClip2(clip2)
			end
		end

		local grenade = ply:GetSpecialWeaponFromCategory("grenade")
		if IsValid(grenade) then
			local max = 4
			local data = grenade.NZSpecialWeaponData
			if data and data.MaxAmmo then
				max = data.MaxAmmo
			end

			ply:SetAmmo(max, GetNZAmmoID("grenade"))
		end

		local special = ply:GetSpecialWeaponFromCategory("specialgrenade")
		if IsValid(special) then
			local max = 3
			local data = special.NZSpecialWeaponData
			if data and data.MaxAmmo then
				max = data.MaxAmmo
			end

			ply:SetAmmo(max, GetNZAmmoID("specialgrenade"))
		end

		local trap = ply:GetSpecialWeaponFromCategory("trap")
		if IsValid(trap) then
			local max = 1
			local data = trap.NZSpecialWeaponData
			if data then
				if data.MaxAmmo then
					max = data.MaxAmmo
					if trap.NZRegenTakeClip then
						max = max - trap:Clip1()
					end
				end
				if data.AmmoType then
					ply:SetAmmo(max, data.AmmoType)
				end
			end
		end

		nzSounds:PlayFile("weapons/tfa_bo3/zm_common.all.sabl.4316.wav", ply)
	end,
	onerase = function(ply)
	end,
})

nzGum:RegisterGum("func_breakable", {
	name = "Insured Disaster",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.PINWHEEL,
	uses = 1,
	desc = "Destroys all breakable props and surfaces on the map.",
	icon = Material("gums/func_breakable.png", "smooth unlitgeneric"),
	onuse = function(ply)
		local prop_phys = {
			["prop_dynamic"] = true,
			["prop_physics"] = true,
			["prop_physics_multiplayer"] = true,
		}
		local func_break = {
			["func_physbox"] = true,
			["func_physbox_multiplayer"] = true,
			["func_breakable"] = true,
			["func_breakable_surf"] = true,
		}

		local count, func_count, prop_count = 0, 0, 0, 0
		for k, v in ipairs(ents.GetAll()) do
			if !IsValid(v) then continue end
			local class = v:GetClass()
			if !(prop_phys[class] or func_break[class]) then continue end
			if v.GetName and nzGum.UnbreakableFunc[v:GetName()] then continue end

			count = count + 1
			if prop_phys[class] and v:Health() > 0 then
				prop_count = prop_count + 1
			elseif func_break[class] and v:Health() > 0 then
				func_count = func_count + 1
			end

			timer.Simple(0.05*count, function()
				if !IsValid(v) then return end

				/*if ply:IsInCreative() then
					ply:SetPos(v:GetPos() + vector_up*24)
					ply:SetEyeAngles((v:GetPos() - ply:GetPos()):Angle())
				end*/

				local dmginfo = DamageInfo()
				dmginfo:SetDamage(v:Health() + 666)
				dmginfo:SetAttacker(Entity(0))
				dmginfo:SetInflictor(Entity(0))
				dmginfo:SetDamageType(DMG_GENERIC)
				dmginfo:SetDamagePosition(v:GetPos())
				dmginfo:SetDamageForce(vector_up*12000)

				v:TakeDamageInfo(dmginfo)

				timer.Simple(engine.TickInterval(), function() 
					if !IsValid(v) or !v.Fire then return end
					v:Fire("Break")
				end)
			end)
		end

		if prop_count > 0 or func_count > 0 then
			ply:ChatPrint("[NZ] I hope you're insured.")
		end
		timer.Simple(count*0.05, function()
			if not IsValid(ply) then return end
			ply:ChatPrint("[NZ] Destroyed "..func_count.." Surfaces/Brushes, and "..prop_count.." Props")
		end)
	end,
})

--[[-------------------------------------------------------------------------
Oranges
---------------------------------------------------------------------------]]

nzGum:RegisterGum("wunderbar", {
	name = "Wunderbar",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	desc = "Next random box spin guarantees a Wonder Weapon.",
	uses = 1,
	icon = Material("gums/wunderbar.png", "smooth unlitgeneric"),
	canroll = function(ply)
		if !nzMapping.Settings.rboxweps then
			return false
		end
		local blacklist = table.Copy(nzConfig.WeaponBlackList)
		for k, v in pairs(nzMapping.Settings.rboxweps) do
			if !blacklist[k] and nzWeps:IsWonderWeapon(k) and IsValid(ply) and not ply:HasWeapon(k) then
				return true
			end
		end
		return false
	end,
	ongain = function(ply)
		if not IsValid(ply) then return end

		local hookname = "nzGums_wunderbar_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnPlayerBuyBox", hookname, function(ply, class)
			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end
			if class == "nz_box_teddy" then return end

			local blacklist = table.Copy(nzConfig.WeaponBlackList)
			for k, v in RandomPairs(nzMapping.Settings.rboxweps) do
				if !blacklist[k] and nzWeps:IsWonderWeapon(k) and not ply:HasWeapon(k) then
					nzGum:TakeUses(ply)
					nzSounds:PlayFile("weapons/tfa_bo3/zm_common.all.sabl.510.wav", ply)
					return k
				end
			end
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_wunderbar_" .. ply:EntIndex()
		hook.Remove("OnPlayerBuyBox", hookname)
	end,
})

nzGum:RegisterGum("unbearable", {
	name = "Unbearable",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.MEGA,
	desc = "When a teddy bear appears in the magic box. Magic box re-spins automatically.",
	uses = 1,
	desc_howactivates = "Has 1 uses",
	icon = Material("gums/unbearable.png", "smooth unlitgeneric"),
	ongain = function(ply)
		if not IsValid(ply) then return end

		local hookname = "nzGums_unbearable_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnEntityCreated", hookname, function(ent)
			if not IsValid(ent) then return end
			if ent:GetClass() ~= "random_box_windup" then return end

			timer.Simple(engine.TickInterval(), function()
				if not IsValid(ent) then return end
				if ent:GetWepClass() ~= "nz_box_teddy" then return end

				local buyer = ent:GetBuyer()
				if not IsValid(buyer) then return end
				if buyer:EntIndex() ~= index then return end

				ent.TeddyVelocity = ent.WindDownMovement
				ent.TeddyVelocityCoffin = ent.WindDownMovement
				ent.Unbearable = true

				local oldbox = ent.Box
				timer.Create(hookname, engine.TickInterval(), 0, function()
					if not IsValid(ent) then
						timer.Remove(hookname)
						return
					end
					if ent:GetWinding() then return end
					if not ent.Box then
						timer.Remove(hookname)
						return
					end
					ent.RemoveTime = CurTime() + 3.5
					ent.Box = nil
				end)

				ent:CallOnRemove(hookname, function(windup)
					if not IsValid(oldbox) then return end
					if not IsValid(ply) then return end

					nzGum:TakeUses(ply)
					nzRandomBox:ResetBoxUses()

					local class = nzRandomBox.DecideWep(ply)
					if class then
						oldbox:Close()
						oldbox:Open()
						oldbox:SpawnWeapon(ply, class)
					end
				end)
			end)
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_unbearable_" .. ply:EntIndex()
		hook.Remove("OnEntityCreated", hookname)
		if timer.Exists(hookname) then
			timer.Remove(hookname)
		end
	end,
})

nzGum:RegisterGum("aftertaste", {
	name = "Aftertaste",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.RAREMEGA,
	desc = "Keep all Perks after being revived. This will not keep the player's Quick Revive in solo.",
	uses = 2,
	desc_howactivates = "Has 2 uses",
	icon = Material("gums/aftertaste.png", "smooth unlitgeneric"),
	ongain = function(ply)
		if not IsValid(ply) then return end

		local hookname = "nzGums_aftertaste_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("PlayerRevived", hookname, function(ply, revivor)
			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end

			for k, v in pairs(ply.OldPerks) do
				if ply.DownedWithSoloRevive and v == "revive" then continue end
				if ply.DownedWithSoloRevive and v == "tombstone" then continue end

				ply:GivePerk(v)
			end

			if #ply:GetPerks() > 0 then
				nzGum:TakeUses(ply)
			end
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_aftertaste_" .. ply:EntIndex()
		hook.Remove("PlayerRevived", hookname)
	end,
})

nzGum:RegisterGum("astronomical", {
	name = "Astronomical",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 2,
	icon = Material("gums/Astronomical.png", "smooth unlitgeneric"),
	desc = "When taking fatal damage the player creates an astronaut pop, damage is ignored.",
	desc_howactivates = "Has 2 uses",
	ongain = function(ply)
		local hookname = "nzGums_astronomical_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("PlayerShouldTakeDamage", hookname, function(ply, ent, dmginfo)
			if not dmginfo then return end
			if not IsValid(ply) or not ply:IsPlayer() then return end
			if ply:EntIndex() ~= index then return end

			if not IsValid(ent) then return end
			if not ent:IsValidZombie() then return end

			if (math.floor(ply:Health() - dmginfo:GetDamage()) > 0) then return end

			nzGum:TakeUses(ply)

			ply:EmitSound("TFA_BO3_QED.AstroPop")
			ParticleEffect("bo3_astronaut_pulse", ply:WorldSpaceCenter(), Angle(0,0,0))

			local damage = DamageInfo()
			damage:SetAttacker(ply)
			damage:SetInflictor(IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or Entity(0))
			damage:SetDamageType(DMG_MISSILEDEFENSE)

			for k, v in pairs(ents.FindInSphere(ply:GetPos(), 300)) do
				if !v:IsWorld() and v:IsSolid() and v:IsValidZombie() then
					damage:SetDamage(v:Health() + 666)
					damage:SetDamageForce(v:GetUp()*22000 + (v:GetPos() - ply:GetPos()):GetNormalized() * 10000)
					damage:SetDamagePosition(v:WorldSpaceCenter())

					if v.NZBossType or v.IsMooBossZombie or v.IsMiniBoss then
						damage:SetDamage(math.max(v:GetMaxHealth()/6, 4000))
					else
						v:SetHealth(1)
					end

					v:TakeDamageInfo(damage)
				end
			end

			ply:ViewPunch(Angle(-25,math.random(-10, 10),0))
			ply:SetGroundEntity(nil)
			ply:SetVelocity(Vector(math.random(-200,200), math.random(-200,200), 0) + ply:GetUp()*200)
			return false
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_astronomical_"..ply:EntIndex()
		hook.Remove("PlayerShouldTakeDamage", hookname)
	end,
})

nzGum:RegisterGum("shield_up", {
	name = "Shield Up",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 1,
	icon = Material("gums/shieldsup.png", "smooth unlitgeneric"),
	desc = "Player is granted a shield.",
	canroll = function(ply, ent)
		if ply.GetShield and IsValid(ply:GetShield()) then
			return false
		end
		return true
	end,
	ongain = function(ply)
		local gun = nzMapping.Settings.shield or "tfa_bo2_tranzitshield"
		ply:Give(gun)

		//uh oh stinky! ill come up with a better fix l8r
		timer.Simple(1.75, function()
			if not IsValid(ply) then return end
			nzGum:TakeUses(ply)
		end)
	end,
	onerase = function(ply)
	end,
})

nzGum:RegisterGum("burned_out", {
	name = "Burned Out",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.MEGA,
	uses = 3,
	desc = "The next time the player takes damage, nearby zombies burst into fire.",
	desc_howactivates = "Has 3 uses",
	icon = Material("gums/burnedout.png", "smooth unlitgeneric"),
	ongain = function(ply)
		local hookname = "nzGums_burnedout_" .. ply:EntIndex()
		local index = ply:EntIndex()
		local next_burn = 0

		hook.Add("PostEntityTakeDamage", hookname, function(ent, dmginfo, took)
			if not IsValid(ent) or not ent:IsPlayer() then return end
			if ent:EntIndex() ~= index then return end

			local attacker = dmginfo:GetAttacker()
			if not IsValid(attacker) then return end
			if not attacker:IsValidZombie() then return end

			if !took and !ent:IsInCreative() then return end
			if next_burn > CurTime() then return end

			local fire = ents.Create("elemental_pop_effect_1")
			fire:SetPos(ent:WorldSpaceCenter())
			fire:SetParent(ent)
			fire:SetOwner(ent)
			fire:SetAttacker(ent)
			fire:SetInflictor(fire)
			fire:SetAngles(angle_zero)

			fire:Spawn()

			nzGum:TakeUses(ent)
			next_burn = CurTime() + 2
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_burnedout_"..ply:EntIndex()
		hook.Remove("PostEntityTakeDamage", hookname)
	end,
})

nzGum:RegisterGum("suit_up", {
	name = "Suit Up",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 1,
	desc = "All players recieve full Armor.",
	icon = Material("gums/SuitUp.png", "smooth unlitgeneric"),
	ongain = function(ply)
		for k, v in pairs(player.GetAll()) do
			local bonus = math.max(v:GetMaxArmor(), v:Armor())
			v:SetArmor(bonus)
			v:EmitSound("nzr/2023/buildables/zm_common.all.sabl.1471.wav", SNDLVL_GUNFIRE)
		end

		//uh oh stinky! ill come up with a better fix l8r
		timer.Simple(1.75, function()
			if not IsValid(ply) then return end
			nzGum:TakeUses(ply)
		end)
	end,
	onerase = function(ply)
	end,
})

nzGum:RegisterGum("all_powered_up", {
	name = "All Powered Up",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 1,
	desc = "Next acquired gun is upgraded.",
	desc_howactivates = "Has 1 uses",
	icon = Material("gums/AllPoweredUp.png", "smooth unlitgeneric"),
	ongain = function(ply)
	end,
	onerase = function(ply)
	end,
})

nzGum:RegisterGum("pop_shocks", {
	name = "Pop Shocks",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.MEGA,
	uses = 5,
	desc = "Melee attacks trigger an electrostatic discharge, electrocuting nearby Zombies.",
	desc_howactivates = "Has 5 uses",
	icon = Material("gums/popshocks.png", "smooth unlitgeneric"),
	ongain = function(ply)
		local meleetypes = {
			[DMG_CLUB] = true,
			[DMG_SLASH] = true,
			[DMG_CRUSH] = true,
		}

		local hookname = "nzGums_popshocks_"..ply:EntIndex()
		local index = ply:EntIndex()

		local function PopShocker(ent, ply, dmginfo)
			if not IsValid(ent) or not ent:IsValidZombie() then return end
			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end

			if meleetypes[dmginfo:GetDamageType()] or ent.SakeKilled then
				ent:EmitSound("NZ.POP.Deadwire.Shock")
				ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
				if ent:OnGround() then
					ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
				end

				dmginfo:SetDamage(ent:Health() + 666)
				dmginfo:SetDamageType(DMG_SHOCK)

				local arc = ents.Create("elemental_pop_effect_2")
				arc:SetModel("models/dav0r/hoverball.mdl")
				arc:SetPos(ent:GetPos())
				arc:SetAngles(angle_zero)
				arc:SetOwner(ply)
				arc:SetAttacker(ply)
				arc:SetInflictor(IsValid(dmginfo:GetInflictor()) and dmginfo:GetInflictor() or ent)
				arc:SetNoDraw(true)

				arc.MaxChain = 6
				arc.ZapRange = 200
				arc.ArcDelay = 0.25

				arc:Spawn()

				nzGum:TakeUses(ply)
			end
		end

		hook.Add("OnZombieShot", hookname, function(ent, ply, dmginfo, hitgroup)
			PopShocker(ent, ply, dmginfo)
		end)
		hook.Add("OnZombieKilled", hookname, function(ent, dmginfo)
			PopShocker(ent, dmginfo:GetAttacker(), dmginfo)
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_popshocks_" .. ply:EntIndex()
		hook.Remove("OnZombieShot", hookname)
		hook.Remove("OnZombieKilled", hookname)
	end,
})

nzGum:RegisterGum("tone_death", {
	name = "Tone Death",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.PINWHEEL,
	uses = 48,
	desc = "Zombies killed make goofy sounds.",
	desc_howactivates = "Lasts 48 kills",
	icon = Material("gums/ToneDeath.png", "smooth unlitgeneric"),
	ongain = function(ply)
		local hookname = "nzGums_tonedeath_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnZombieKilled", hookname, function(ent, dmginfo)
			if not IsValid(ent) or not ent:IsValidZombie() then return end
			local ply = dmginfo:GetAttacker()
			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end

			local comedy = "bo3/gobblegum/tonedeath/tonedeath_"..math.random(0,17)..".mp3"

			ply:EmitSound(comedy, SNDLVL_GUNFIRE)
			ent:EmitSound(comedy, SNDLVL_GUNFIRE)

			nzGum:TakeUses(ply)
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_tonedeath_" .. ply:EntIndex()
		hook.Remove("OnZombieKilled", hookname)
	end,
})

nzGum:RegisterGum("treasure_hunt", {
	name = "Treasure Hunt",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	uses = 1,
	desc = "Summons a Treasure Zombie.",
	icon = Material("gums/TreasureHunt.png", "smooth unlitgeneric"),
	ongain = function(ply)
		timer.Simple(1.75, function()
			if not IsValid(ply) then return end
			nzGum:TakeUses(ply)
		end)

		local victim = ents.Create("nz_zombie_special_bomba")
		victim:SetPos(ply:GetPos())
		victim:SetAngles(ply:GetAngles())
		victim.Gum = true
		victim:Spawn()
	end,
})

nzGum:RegisterGum("soda_fountain", {
	name = "Soda Fountain",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.RAREMEGA,
	uses = 1,
	desc = "Buying a perk will reward you an extra random perk.",
	desc_howactivates = "Has 1 uses",
	icon = Material("gums/perkfountain.png", "smooth unlitgeneric"),
	ongain = function(ply)
		local hookname = "nzGums_soda_fountain_" .. ply:EntIndex()
		local index = ply:EntIndex()

		hook.Add("OnPlayerGetPerk", hookname, function( ply, id, machine )
			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end
			nzGum:TakeUses(ply)
			ply:GiveRandomPerk()
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_soda_fountain_"..ply:EntIndex()
		hook.Remove("OnPlayerGetPerk", hookname)
	end,
})

nzGum:RegisterGum("perkaholic", {
	name = "Perkaholic",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	uses = 1,
	desc = "Gain 4 random Perks.",
	icon = Material("gums/Perkaholic.png", "smooth unlitgeneric"),
	ongain = function(ply)
		timer.Simple(1.75, function()
			if not IsValid(ply) then return end
			nzGum:TakeUses(ply)
		end)

		for i = 1, 4 do
			ply:GiveRandomPerk()
		end
	end,
})

nzGum:RegisterGum("stumbler", {
	name = "Tripping Hazard",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.DEFAULT,
	uses = 5,
	desc = "The next time the player takes damage, stun nearby zombies and cause them to stumble.",
	desc_howactivates = "Has 5 uses",
	icon = Material("gums/trippinghazard.png", "smooth unlitgeneric"),
	ongain = function(ply)
		local hookname = "nzGums_stumbler_" .. ply:EntIndex()
		local index = ply:EntIndex()
		local next_trip = 0

		hook.Add("PostEntityTakeDamage", hookname, function(ent, dmginfo, took)
			if not IsValid(ent) or not ent:IsPlayer() then return end
			if ent:EntIndex() ~= index then return end

			local attacker = dmginfo:GetAttacker()
			if not IsValid(attacker) then return end
			if not attacker:IsValidZombie() then return end

			if !took and !ent:IsInCreative() then return end
			if dmginfo:GetDamage() <= 0 then return end
			if next_trip > CurTime() then return end

			ply:EmitSound("NZ.ChuggaBud.Charge")
			ParticleEffectAttach("nz_gums_stumbler_flash", PATTACH_POINT_FOLLOW, ply, 0)

			nzGum:TakeUses(ent)
			next_trip = CurTime() + 1

			for k, v in RandomPairs(ents.FindInSphere(ply:GetPos(), 300)) do
				if v:IsValidZombie() and v.PainSequences and v:VisibleVec(ply:EyePos()) then
					if v.Target and IsValid(v.Target) and v.Target:EntIndex() ~= index then continue end
					if !v:IsAlive() then continue end
					if v:GetSpecialAnimation() or
					v:GetCrawler() or v:GetIsBusy() or
					v.ShouldCrawl or v.IsBeingStunned or
					v.Dying or v:IsAATTurned() then
						continue
					end

					if v.PainSounds and !v:GetDecapitated() then
						v:EmitSound(v.PainSounds[math.random(#v.PainSounds)], 100, math.random(85, 105), 1, 2)
						v.NextSound = CurTime() + v.SoundDelayMax
					end

					v.IsBeingStunned = true
					v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], false, true)
					v.IsBeingStunned = false
					v.LastStun = CurTime() + 8
					v:ResetMovementSequence()

					if !v.IsMooSpecial and !v.IsMooBossZombie then
						ParticleEffectAttach("nz_gums_stumbler_blind_eyes", PATTACH_POINT_FOLLOW, v, 3)
						ParticleEffectAttach("nz_gums_stumbler_blind_eyes", PATTACH_POINT_FOLLOW, v, 4)
					end
					ParticleEffectAttach("nz_gums_stumbler_blind_loop", PATTACH_POINT_FOLLOW, v, 2)
				end
			end
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_stumbler_"..ply:EntIndex()
		hook.Remove("PostEntityTakeDamage", hookname)
	end,
})

--[[-------------------------------------------------------------------------
Greens
---------------------------------------------------------------------------]]

nzGum:RegisterGum("sword_flay", {
	name = "Sword Flay",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.DEFAULT,
	time = 120,
	icon = Material("gums/SwordFlay.png", "smooth unlitgeneric"),
	desc = "Melee attacks do 10x more damage and heal you a random amount.",
	ontimerstart = function(ply)
		local meleetypes = {
			[DMG_CLUB] = true,
			[DMG_SLASH] = true,
			[DMG_CRUSH] = true,
			//[DMG_GENERIC] = true,
		}

		local hookname = "nzGums_sword_flay_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnZombieShot", hookname, function(ent, ply, dmginfo, hitgroup)
			if not IsValid(ent) or not ent:IsValidZombie() then return end
			if not IsValid(ply) then return end
			local wep = dmginfo:GetInflictor()
			if not IsValid(wep) then return end
			if ply:EntIndex() ~= index then return end

			if meleetypes[dmginfo:GetDamageType()] then
				local snd = "weapons/knife/knife_hit"..math.random(4)..".wav"

				dmginfo:ScaleDamage(10)
				ply:SetHealth(math.Clamp(math.Round(ply:Health() + math.random(15,50)), 0, ply:GetMaxHealth()))

				ply:EmitSound(snd, SNDLVL_GUNFIRE)
				ent:EmitSound(snd, SNDLVL_GUNFIRE)
			end
		end)
	end,
	ontimerend = function(ply)
		local hookname = "nzGums_sword_flay_" .. ply:EntIndex()
		hook.Remove("OnZombieShot", hookname)
	end,
})

nzGum:RegisterGum("blood_debt", {
	name = "Blood Debt",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	time = 120,
	icon = Material("gums/BloodDebt.png", "smooth unlitgeneric"),
	desc = "Lose points on hit instead of health (Amount lost depends on damage).",
	ontimerstart = function(ply)
		local hookname = "nzGums_blood_debt_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("EntityTakeDamage", hookname, function(ply, dmginfo)
			if not IsValid(ply) then return end
			if not ply:IsPlayer() then return end
			if ply:EntIndex() ~= index then return end

			if ply:GetPoints() > 0 then
				ply:TakePoints(math.min(ply:GetPoints(), math.floor(math.Clamp(dmginfo:GetDamage(), 10, 10000))))
				dmginfo:ScaleDamage(0)
				return false
			end
		end)
	end,
	ontimerend = function(ply)
		if not IsValid(ply) then return end

		local hookname = "nzGums_blood_debt_" .. ply:EntIndex()
		hook.Remove("EntityTakeDamage", hookname)
	end,
})

nzGum:RegisterGum("alchemical", {
	name = "Alchemical Antithesis",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.DEFAULT,
	time = 120,
	icon = Material("gums/alchemicalantithesis.png", "smooth unlitgeneric"),
	desc = "Every 10 points earned is instead awarded 1 ammo in the stock of the current weapon.",
	ontimerstart = function(ply)
		local hookname = "nzGums_alchemical_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnPlayerGetPoints", hookname, function(ply, amount)
			if not IsValid(ply) or not ply:IsPlayer() then return end
			if ply:EntIndex() ~= index then return end
			if not amount or amount == 0 then return end

			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.IsTFAWeapon and !wep:IsSpecial() and (ply:IsInCreative() or wep:GetNWInt("switchslot", 0) > 0) then
				local ammoname = wep:GetStatL("Primary.Ammo")

				if (!ammoname or ammoname == "none" or ammoname == "") and wep.Primary.ClipSize and wep.Primary.ClipSize > 0 then
					local max = wep.Primary.ClipSize
					local give = math.Round(amount/10)
					local cur = wep:Clip1()

					if (cur + give) > max then
						give = max - cur
					end

					if give > 0 then
						wep:SetClip1(give)
						amount = 0
						return amount
					end
				else
					local max = wep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(wep:GetClass(), wep:HasNZModifier("pap"))
					local give = math.Round(amount/10)
					local ammo = wep:GetPrimaryAmmoType()
					local cur = ply:GetAmmoCount(ammo)

					if (cur + give) > max then
						give = max - cur
					end

					if give > 0 then
						ply:GiveAmmo(give, ammo)
						amount = 0
						return amount
					end
				end
			end
		end)
	end,
	ontimerend = function(ply)
		local hookname = "nzGums_alchemical_"..ply:EntIndex()
		hook.Remove("OnPlayerGetPoints", hookname)
	end,
})

nzGum:RegisterGum("head_scan", {
	name = "Head Scan",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.MEGA,
	time = 120,
	icon = Material("gums/HeadScan.png", "smooth unlitgeneric"),
	desc = "Headshots have a chance to Instakill.",
	ontimerstart = function(ply)
		local hookname = "nzGums_head_scan_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnZombieShot", hookname, function(ent, ply, dmginfo, hitgroup)
			if not IsValid(ent) or not ent:IsValidZombie() then return end

			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end

			if hitgroup == HITGROUP_HEAD and math.Rand(0,3) <= 1 then
				local headpos = ent:EyePos()
				local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = ent:LookupBone("j_head") end
				if headbone then headpos = ent:GetBonePosition(headbone) end

				dmginfo:SetDamagePosition(headpos)
				dmginfo:SetDamage(ent:Health() + 666)

				local snd = "nzr/2022/effects/zombie/head_0"..math.random(3)..".wav"
				ply:EmitSound(snd, SNDLVL_GUNFIRE)
				ent:EmitSound(snd, SNDLVL_GUNFIRE)
			end
		end)
	end,
	ontimerend = function(ply)
		local hookname = "nzGums_head_scan_" .. ply:EntIndex()
		hook.Remove("OnZombieShot", hookname)
	end,
})

nzGum:RegisterGum("newtonian_negation", {
	name = "Newtonian Negation",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.PINWHEEL,
	time = 120,
	icon = Material("gums/NewtonianNegation.png", "smooth unlitgeneric"),
	desc = "Ragdolls have no gravity.",
	canroll = function(ply, ent)
		if nzGum.NewtonianNegation then
			return false
		end
		return true
	end,
	ontimerstart = function(ply)
		SetGlobal2Bool("Gum.NewtonianNegation", true)
		nzGum.NewtonianNegation = true
	end,
	ontimerend = function(ply)
		SetGlobal2Bool("Gum.NewtonianNegation", false)
		nzGum.NewtonianNegation = nil
	end,
})

nzGum:RegisterGum("stock_option", {
	name = "Stock Option",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "Ammo is taken from weapon's stockpile instead of the magazine.",
	time = 150,
	icon = Material("gums/stockoption.png", "smooth unlitgeneric"),
	ontimerstart = function(ply)
	end,
	ontimerend = function(ply)
	end,
})

nzGum:RegisterGum("clearance_aisle", {
	name = "Clearance Aisle",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	time = 300,
	icon = Material("gums/ClearanceAisle.png", "smooth unlitgeneric"),
	desc = "All purchases only take half the points.",
	ontimerstart = function(ply)
		local hookname = "nzGums_clearance_aisle_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnPlayerLosePoints", hookname, function(ply, amount)
			if not IsValid(ply) or not ply:IsPlayer() then return end
			if ply:EntIndex() ~= index then return end
			if not amount or amount == 0 then return end

			amount = amount / 2
			return amount
		end)
	end,
	ontimerend = function(ply)
		local hookname = "nzGums_clearance_aisle_"..ply:EntIndex()
		hook.Remove("OnPlayerLosePoints", hookname)
	end,
})

nzGum:RegisterGum("coagulant", {
	name = "Coagulant",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.DEFAULT,
	time = 1200,
	icon = Material("gums/Coagulant.png", "smooth unlitgeneric"),
	desc = "Bleedout duration is increased to 2 minutes.",
	multiplayer = true,
	ontimerstart = function(ply)
		if not IsValid(ply) then return end
		ply:IncreaseBleedoutTime(120)
	end,
	ontimerend = function(ply)
		if not IsValid(ply) then return end
		ply:DecreaseBleedoutTime(120)
	end,
})

nzGum:RegisterGum("profit_sharing", {
	name = "Profit Sharing",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	time = 180,
	icon = Material("gums/profitsharing.png", "smooth unlitgeneric"),
	desc = "Points you earn are also recieved by nearby players and vice versa.",
	multiplayer = true,
	ontimerstart = function(ply)
		if not IsValid(ply) then return end
		nzGum.ProfitSharingPlayers[ply:EntIndex()] = ply

		hook.Add("OnPlayerGetPoints", "nzProfitSharing", function(ply, amount)
			if nzGum.ProfitSharingPlayers[ply:EntIndex()] then
				for k, v in pairs(player.GetAll()) do
					if v ~= ply and v:Alive() and (v:IsInCreative() or v:IsPlaying()) and ply:GetPos():DistToSqr(v:GetPos()) <= nzGum.ProfitSharingDist then
						v:SetPoints(v:GetPoints() + amount, ply:EntIndex())
					end
				end
			else
				for k, v in pairs(nzGum.ProfitSharingPlayers) do
					if IsValid(v) and ply:GetPos():DistToSqr(v:GetPos()) <= nzGum.ProfitSharingDist then
						v:SetPoints(v:GetPoints() + amount, ply:EntIndex())
					end
				end
			end
		end)
	end,
	ontimerend = function(ply)
		if not IsValid(ply) then return end
		nzGum.ProfitSharingPlayers[ply:EntIndex()] = nil
	end,
})

--[[-------------------------------------------------------------------------
Blues
---------------------------------------------------------------------------]]

nzGum:RegisterGum("danger_closest", {
	name = "Danger Closest",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.DEFAULT,
	desc = "Immune to self damage and explosives, stuns effects are reduced.",
	rounds = 3,
	icon = Material("gums/dangerclosest.png", "smooth unlitgeneric"),
	ongain = function(ply)
		if not IsValid(ply) then return end
		ply.SELFIMMUNE = true

		local hookname = "nzGums_danger_closest_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("EntityTakeDamage", hookname, function(ply, dmginfo)
			if not IsValid(ply) then return end
			if not ply:IsPlayer() then return end
			if ply:EntIndex() ~= index then return end

			if dmginfo:IsExplosionDamage() then
				dmginfo:ScaleDamage(0)
				return false
			end
		end)
	end,
	onerase = function(ply)
		if not IsValid(ply) then return end
		ply.SELFIMMUNE = nil

		local hookname = "nzGums_danger_closest_" .. ply:EntIndex()
		hook.Remove("EntityTakeDamage", hookname)
	end,
})

nzGum:RegisterGum("lucky_crit", {
	name = "Lucky Crit",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.MEGA,
	desc = "Alternate Ammo Types activate more often and have a shorter cooldown.",
	rounds = 3,
	icon = Material("gums/luckycrit.png", "smooth unlitgeneric"),
	canroll = function(ply, ent)
		if not IsValid(ply) then return end
		for _, wep in pairs(ply:GetWeapons()) do
			if wep:GetNW2String("nzAATType", "") ~= "" then
				return true
			end
		end
		return false
	end,
	ongain = function(ply)
		if not IsValid(ply) then return end
		ply.AATChanceBonus = (ply.AATChanceBonus or 0) + 0.25
		ply.AATCooldownMult = (ply.AATCooldownMult or 1) * 0.5
	end,
	onerase = function(ply)
		if not IsValid(ply) then return end
		ply.AATChanceBonus = (ply.AATChanceBonus or 0.25) - 0.25
		ply.AATCooldownMult = (ply.AATCooldownMult or 0.5) * 2
	end,
})

nzGum:RegisterGum("power_vacuum", {
	name = "Power Vacuum",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	rounds = 2,
	icon = Material("gums/powervaccumm.png", "smooth unlitgeneric"),
	desc = "Power-Ups spawn more often. The normal cap of 4 drops per round is ignored.",
	canroll = function(ply, ent)
		if nzPowerUps.DisableDropLimit then
			return false
		end
		return true
	end,
	ongain = function(ply)
		nzPowerUps.PowerupChanceOverride = 12
		nzPowerUps.DisableDropLimit = true
	end,
	onerase = function(ply)
		nzPowerUps.PowerupChanceOverride = nil
		nzPowerUps.DisableDropLimit = nil
	end,
})

nzGum:RegisterGum("quacknarok", {
	name = "Quacknarok",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.PINWHEEL,
	rounds = 5,
	icon = Material("gums/Quacknarok.png", "smooth unlitgeneric"),
	desc = "Enemies wear duck floaties... It doesn't help anything else.",
	canroll = function(ply, ent)
		if nzGum.QuacknarokActive then
			return false
		end
		return true
	end,
	ongain = function(ply)
		nzGum.QuacknarokActive = true
	end,
	onerase = function(ply)
		nzGum.QuacknarokActive = nil
	end,
})

nzGum:RegisterGum("head_drama", {
	name = "Head Drama",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.DEFAULT,
	rounds = 2,
	icon = Material("gums/headdrama.png", "smooth unlitgeneric"),
	desc = "Any bullet which hits a zombie will damage its head.",
	ongain = function(ply)    
		local hookname = "nzGums_head_drama_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("OnZombieShot", hookname, function(ent, ply, dmginfo, hitgroup)
			if not IsValid(ent) or not ent:IsValidZombie() then return end

			if not IsValid(ply) then return end
			if ply:EntIndex() ~= index then return end

			local wep = dmginfo:GetInflictor()
			if not IsValid(wep) then return end

			if hitgroup ~= HITGROUP_HEAD and dmginfo:IsBulletDamage() then
				local headpos = ent:EyePos()
				local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = ent:LookupBone("j_head") end
				if headbone then headpos = ent:GetBonePosition(headbone) end

				dmginfo:SetDamagePosition(headpos)
				dmginfo:ScaleDamage(wep.NZHeadShotMultiplier or 2)
			end
		end)
	end,
	onerase = function(ply)
		local hookname = "nzGums_head_drama_" .. ply:EntIndex()
		hook.Remove("OnZombieShot", hookname)
	end,
})

nzGum:RegisterGum("temporal_gift", {
	name = "Temporal Gift",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.RAREMEGA,
	rounds = 2,
	icon = Material("gums/TemporalGift.png", "smooth unlitgeneric"),
	desc = "Power-Ups last 30 seconds longer.",
	ongain = function(ply)
		nzGum.TemporalGiftTime = nzGum.TemporalGiftTime + 30
	end,
	onerase = function(ply)
		nzGum.TemporalGiftTime = math.max(nzGum.TemporalGiftTime - 30, 0)
	end,
})

nzGum:RegisterGum("heavy_duty", {
	name = "Heavy Duty",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.MEGA,
	rounds = 3,
	desc = "All repaired barricade planks become upgraded.",
	icon = Material("gums/heavyduty.png", "smooth unlitgeneric"),
	canroll = function(ply)
		if nzGum.HeavyDutyPlanks then
			return false
		end

		local barricades = ents.FindByClass("breakable_entry")
		if IsValid(barricades[1]) then
			local b_hasplanks = false
			for _, ent in pairs(barricades) do 
				if ent:GetHasPlanks() then
					b_hasplanks = true
					break
				end
			end

			return b_hasplanks
		else
			return false
		end
	end,
	ongain = function(ply)
		nzGum.HeavyDutyPlanks = true

		hook.Add("BarricadePlankCheck", "nzGums_Heavyduty", function(barricade, plank, ply)
			if not IsValid(plank) then return end
			if !nzGum.HeavyDutyPlanks then return end

			plank.Enhanced = true
			if barricade:GetBoardType() == 1 then
				plank:SetBodygroup(1,1)
			end

			if IsValid(ply) and ply:IsPlayer() and ply:HasPerk("amish") then return end
			plank.HeavyDutyPlank = true
		end)
	end,
	onerase = function(ply)
		nzGum.HeavyDutyPlanks = nil

		for k, v in pairs(ents.FindByClass("breakable_entry")) do
			if !v:GetHasPlanks() or !v.Planks then continue end

			for i=1, 6 do
				local v2 = v.Planks[i]
				if not IsValid(v2) then continue end

				if v2.HeavyDutyPlank and v2.Enhanced then
					v2.Enhanced = nil
					v2.HeavyDutyPlank = nil

					if !v2.Torn and !v2.ZombieUsing then
						timer.Simple((i - 1)*0.1, function()
							if not IsValid(v) then return end
							if not IsValid(v2) then return end
							v:RemovePlank(v2)

							timer.Simple(0.6, function()
								if not IsValid(v) then return end
								if not IsValid(v2) then return end
								if v:GetBoardType() == 1 then
									v2:SetBodygroup(1,0)
								end
								if !v2.Torn or v2.ZombieUsing then return end

								v:AddPlank(v2)
							end)
						end)
					elseif v:GetBoardType() == 1 then
						v2:SetBodygroup(1,0)
					end
				end
			end
		end
	end,
})

nzGum:RegisterGum("power_hungry", {
	name = "Power Hungry",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.RAREMEGA,
	desc = "Power-Ups are automatically picked up after activating.",
	rounds = 3,
	icon = Material("gums/powerhungry.png", "smooth unlitgeneric"),
	canroll = function(ply, ent)
		if nzGum.PowerHungryPlayer then
			return false
		end
		return true
	end,
	ongain = function(ply)
		if not IsValid(ply) then return end
		nzGum.PowerHungryPlayer = ply

		hook.Add("Think", "nzGums_PowerHungry", function()
			for k, ent in nzLevel.GetPowerUpsArray() do
				if not IsValid(ent) then continue end
				if ent:GetClass() ~= "drop_powerup" then continue end

				if !ent.GetActivated or !ent:GetActivated() then continue end
				if !ent.GetAnti or ent:GetAnti() then continue end
				if !ent.GetPowerUp or ent:GetPowerUp() == "" then continue end
				if nzPowerUps:IsPlayerPowerupActive(ply, ent:GetPowerUp()) then continue end

				local pdata = nzPowerUps:Get(ent:GetPowerUp())
				if !pdata then continue end
				if !pdata.global and !ent:VisibleVec(ply:EyePos()) then continue end

				nzPowerUps:Activate(ent:GetPowerUp(), ply, ent)
				ply:EmitSound(nzPowerUps:Get(ent:GetPowerUp()).collect or ent.GrabSound)
				ent:Remove()
			end
		end)
	end,
	onerase = function(ply)
		nzGum.PowerHungryPlayer = nil

		hook.Remove("Think", "nzGums_PowerHungry")
	end,
})

--[[-------------------------------------------------------------------------
Unused/Scrapped
---------------------------------------------------------------------------]]

/*nzGum:RegisterGum("regen_haste", {
	name = "Intravenous Haste",
	type = nzGum.Types.TIME,
	rare = nzGum.RareTypes.RAREMEGA,
	time = 300,
	icon = Material("gums/intravenoushaste.png", "smooth unlitgeneric"),
	desc = "Player heals twice as fast.",
	ontimerstart = function(ply)
		if not IsValid(ply) then return end

		local regendelay = ply.RegenOverride or nzMapping.Settings.healthregendelay or 5
		ply.RegenOverride = regendelay*0.5
	end,
	ontimerend = function(ply)
		if not IsValid(ply) then return end
		ply.RegenOverride = nil
	end,
})*/

/*nzGum:RegisterGum("bar_tab", {
	name = "Bar Tab",
	type = nzGum.Types.ROUNDS,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	desc = "Gain 2 random perks from the wunderfizz list. \nPerks are lost on player down or when gum runs out.",
	rounds = 5,
	icon = Material("gums/onemore.png", "smooth unlitgeneric"),
	ongain = function(ply)
		if not IsValid(ply) then return end

		local available = {}
		local fizzlist = nzMapping.Settings.wunderfizzperklist
		local blockedperks = {
			["wunderfizz"] = true,
			["pap"] = true,
			["gum"] = true,
		}

		for perk, _ in RandomPairs(nzPerks:GetList()) do
			if blockedperks[perk] then continue end
			if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then continue end
			if ply:HasPerk(perk) then continue end
			table.insert(available, perk)
		end

		if table.IsEmpty(available) then
			nzSounds:PlayEnt("Laugh", ply)
			timer.Simple(1.75, function()
				if not IsValid(ply) then return end
				nzGum:TakeUses(ply)
			end)
			return
		end

		local perkl, perkb = table.Random(available), nil
		table.RemoveByValue(available, perkl)

		if table.IsEmpty(available) then
			nzSounds:PlayEnt("Laugh", ply)
		else
			perkb = table.Random(available)
		end

		ply:GivePerk(perkl)
		if perkb then
			ply:GivePerk(perkb)
		end

		ply.BarTabPerks = {perkl, perkb}

		local hookname = "nzGums_onemore_" .. ply:EntIndex()
		local index = ply:EntIndex()
		hook.Add("PlayerDowned", hookname, function(ent)
			if not IsValid(ent) then return end
			if not ent:IsPlayer() then return end
			if ent:EntIndex() ~= index then return end

			local oldperks = ply.OldPerks
			if ply.BarTabPerks and oldperks then
				for _, perk in pairs(ply.BarTabPerks) do
					if table.HasValue(oldperks, perk) then
						table.RemoveByValue(oldperks, perk)
					end
				end
			end

			nzGum:TakeUses(ply)
		end)
	end,
	onerase = function(ply)
		if not IsValid(ply) then return end
		if ply.BarTabPerks then
			for _, perk in pairs(ply.BarTabPerks) do
				if not ply:HasPerk(perk) then continue end
				ply:RemovePerk(perk)
			end
		end

		local hookname = "nzGums_onemore_" .. ply:EntIndex()
		hook.Remove("PlayerDowned", hookname)
	end,
})*/

nzGum:RegisterGum("power_keg", {
	name = "Power Keg",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Berzerk Power-Up.",
	icon = Material("gums/PowerKeg.png", "smooth unlitgeneric"),
	onuse = function(ply)
		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "berzerk")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "berzerk")
		end
	end,
})

nzGum:RegisterGum("conflagration_liquidation", {
	name = "Conflagration Liquidation",
	type = nzGum.Types.USABLE,
	rare = nzGum.RareTypes.MEGA,
	uses = 1,
	desc = "Spawns a Bonfire Sale Power-Up.",
	icon = Material("gums/ConflagrationLiquidation.png", "smooth unlitgeneric"),
	onuse = function(ply)
		local enddir = Vector(ply:GetPos()[1] + ply:GetAimVector()[1] * 80, ply:GetPos()[2] + ply:GetAimVector()[2] * 80, ply:GetPos()[3] + 1)
		if not GetBoxAroundEnt(ply, enddir).Hit then
			nzPowerUps:SpawnPowerUp(enddir, "bonfiresale")
		else
			nzPowerUps:SpawnPowerUp(ply:GetPos() + vector_up, "bonfiresale")
		end
	end,
})

--[[
nzGum:RegisterGum("perkaholic_old", {
	name = "Perkaholic",
	type = nzGum.Types.SPECIAL,
	rare = nzGum.RareTypes.ULTRARAREMEGA,
	uses = 1,
	desc = "Will fill in any open slots you may have with a random perk.",
	icon = Material("gums/Perkaholic.png", "smooth unlitgeneric"),
	ongain = function(ply)
		for i = 1, GetConVar("nz_difficulty_perks_max"):GetInt() do
			local available = {}
			local fizzlist = nzMapping.Settings.wunderfizzperklist
			local playerperks = ply:GetPerks()
			local limit = GetConVar("nz_difficulty_perks_max"):GetInt()
			local blockedperks = {
				["wunderfizz"] = true,
				["pap"] = true,
				["gum"] = true,
			}

			for perk, _ in pairs(nzPerks:GetList()) do
				if blockedperks[perk] then continue end
				if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then continue end
				if ply:HasPerk(perk) then continue end
				table.insert(available, perk)
			end

			if #playerperks >= limit then break end
			if table.IsEmpty(available) then nzSounds:PlayEnt("Laugh", ply) break end

			ply:GivePerk(table.Random(available))
		end
		nzGum:TakeUses(ply)
	end,
})
]]