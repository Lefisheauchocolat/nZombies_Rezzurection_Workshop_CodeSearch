
function nzPlayers.PlayerNoClip( ply, desiredState )
	if ply:Alive() and nzRound:InState( ROUND_CREATE ) then
		return ply:IsInCreative()
	end
end

function nzPlayers:FullSync( ply )
	-- A full sync module using the new rewrites
	if IsValid(ply) then
		ply:SendFullSync()
	end
end

function GM:PlayerNoClip( ply, desiredState )
	return nzPlayers.PlayerNoClip(ply, desiredState)
end

-- this was previously hooked to PlayerDisconnected
-- it will now detect leaving players via entity removed, to take kicking banning etc into account.
hook.Add("EntityRemoved", "nzPlayerLeft", function(ply)
	if ply:IsPlayer() then
		ply:DropOut()
		if IsValid(ply.TimedUseEntity) then
			ply:StopTimedUse()
		end
	end
end)

hook.Add("GetFallDamage", "nzFallDamage", function(ply, speed)
	if not IsValid(ply) then return end
	if ply:HasPerk("phd") then
		return 0
	end
	return (speed / 10)
end)

hook.Add("PlayerShouldTakeDamage", "nzPlayerIgnoreDamage", function(ply, ent)
	if not ply:GetNotDowned() then
		return false
	end

	if nzRound:InState(ROUND_GO) then
		return false
	end

	if nzPowerUps:IsPlayerPowerupActive(ply, "berzerk") then
		return false
	end
	
	if nzPowerUps:IsPlayerPowerupActive(ply, "godmode") then
		return false
	end

	if !nzRound:InState(ROUND_CREATE) and !ply:IsPlaying() then
		return false
	end

	if ent:IsValidZombie() and ply:HasPerk("widowswine") and ply:GetAmmoCount(GetNZAmmoID("grenade")) > 0 then
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), ply:HasUpgrade("widowswine") and 300 or 200)) do
			if v:IsValidZombie() and ply:VisibleVec(v:EyePos()) and v.BO3SpiderWeb then
				v:BO3SpiderWeb(10, ply)
			end
		end

		timer.Simple(0, function()
			if not IsValid(ply) then return end //fuck yuo :)

			local fx = EffectData()
			fx:SetOrigin(ply:GetPos())
			fx:SetEntity(ply)
			util.Effect("nz_spidernade_explosion", fx)
		end)

		local nade = GetNZAmmoID("grenade")
		ply:SetAmmo(ply:GetAmmoCount(nade) - 1, nade)

		return false
	end

	if ent:IsPlayer() then
		if ent == ply then
			return !ply:HasPerk("phd") and !ply.SELFIMMUNE
		else
			if ent:HasPerk("gum") then
				return true
			else
				return false
			end
		end
	end
end)

hook.Add("EntityTakeDamage", "nzPlayerTakeDamage", function(ply, dmginfo)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	local ent = dmginfo:GetAttacker()
	if IsValid(ent) and ent:GetClass() == "elemental_pop_effect_3" then
		dmginfo:SetAttacker(ent:GetAttacker())
		dmginfo:SetInflictor(ent:GetInflictor())

		if ply:IsPlayer() then
			dmginfo:SetDamage(0)
		end
	end

	if ply.DamageBarrierTypes and bit.band(dmginfo:GetDamageType(), ply.DamageBarrierTypes) ~= 0 then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return false
	end

	local gum = nzGum:GetActiveGum(ply)

	if (gum and gum == "blood_debt") and ply:GetPoints() > 0 then
		ply:TakePoints(math.min(ply:GetPoints(), math.floor(math.Clamp(dmginfo:GetDamage(), 10, 10000))))
		dmginfo:ScaleDamage(0)
		return false
	end

	if IsValid(ent) and ent:IsValidZombie() then
		if nzPowerUps:IsPlayerAntiPowerupActive(ply, "berzerk") then
			ply:ViewPunch(VectorRand():Angle() * 0.05)
			if ply:IsOnGround() then
				ply:SetVelocity((ply:GetPos() - ent:GetPos()) * 20 + Vector(0, 0, 12))
			end
		end

		if ply:HasPerk("winters") and (nzRound:InState(ROUND_CREATE) or ply:GetNW2Int("nz.WailCount", 0) > 0) and ply:GetNW2Float("nz.WailDelay", 0) < CurTime() and ply:Health() < ply:GetMaxHealth() then
			local upgrade = ply:HasUpgrade("winters")

			local class = "elemental_pop_effect_5"
			if upgrade then
				class = "winterswail_effect"
			end

			local freeze = ents.Create(class)
			freeze:SetPos(ply:WorldSpaceCenter())
			freeze:SetAngles(angle_zero)
			freeze:SetOwner(ply)
			freeze:SetParent(ply)
			freeze:SetAttacker(ply)
			freeze:SetInflictor(ply:GetActiveWeapon())

			if not upgrade then
				ply:EmitSound("NZ.Winters.Start")
				freeze.Range = 240
			end

			freeze:Spawn()

			ply:SetNW2Float("nz.WailDelay", CurTime() + 30)
			ply:SetNW2Int("nz.WailCount", math.max(ply:GetNW2Int("nz.WailCount",0) - 1, 0))
		end

		if ply:HasPerk("tortoise") and (ply.GetShield and not IsValid(ply:GetShield())) then
			local dot = (ent:GetPos() - ply:GetPos()):Dot(ply:GetAimVector())

			if dot < 0 then
				local scale = math.Clamp(ply:GetNW2Int("nz.TortCount", 0) / 10, 0, 1)
				dmginfo:ScaleDamage(0.5 + (scale * 0.5))

				ply:SetNW2Int("nz.TortCount", ply:GetNW2Int("nz.TortCount",0) + 1)
				ply:SetNW2Float("nz.TortDelay", CurTime() + 10)
			end
		end
	end

	if IsValid(ent) and not ent:IsPlayer() and dmginfo:IsDamageType(DMG_VEHICLE) then //assdonut teleport
		dmginfo:SetDamage(ply:Health() - 25)

		local perks = ply:GetPerks()
		if not table.IsEmpty(perks) then
			ply:RemovePerk(perks[math.random(#perks)], true)
		end

		local available = ents.FindByClass("nz_spawn_zombie_special")
		local pos = ply:GetPos()
		local spawns = {}

		if IsValid(available[1]) and !nzMapping.Settings.specialsuseplayers then
			for k, v in ipairs(available) do
				if v.link == nil or nzDoors:IsLinkOpened(v.link) then
					if v:IsSuitable() then
						table.insert(spawns, v)
					end
				end
			end
			if !IsValid(spawns[1]) then
				local pspawns = ents.FindByClass("player_spawns")
				if !IsValid(pspawns[1]) then
					ply:ChatPrint("Couldnt find an escape boss, sorry 'bout that.")
				else
					pos = pspawns[math.random(#pspawns)]:GetPos()
				end
			else
				pos = spawns[math.random(#spawns)]:GetPos()
			end
		else
			local pspawns = ents.FindByClass("player_spawns")
			if IsValid(pspawns[1]) then
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		end

		local moo = Entity(1) //10% chance to tp to host of lobby
		if ply:EntIndex() ~= moo:EntIndex() and math.random(10) == 1 then
			pos = moo:GetPos()
		end

		ply:SetPos(pos)
	end

	if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_VEHICLE, DMG_POISON, DMG_SHOCK)) ~= 0 and ply:HasPerk("mask") then
		dmginfo:ScaleDamage(0.15)
	end

	if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_NERVEGAS, DMG_RADIATION)) ~= 0 and ply:HasPerk("mask") then
		dmginfo:ScaleDamage(0)
	end

	if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_BURN, DMG_SLOWBURN)) ~= 0 and ply:HasPerk("fire") then
		dmginfo:ScaleDamage(0)
	end

	if dmginfo:IsDamageType(DMG_PHYSGUN) then
		dmginfo:ScaleDamage(0)
	end

	if dmginfo:IsExplosionDamage() and ply:HasPerk("phd") then
		dmginfo:ScaleDamage(0)
		return false
	end

	if dmginfo:IsFallDamage() and ply:HasPerk("phd") then
		dmginfo:ScaleDamage(0)
		return false
	end
end)

hook.Add("PostEntityTakeDamage", "nzPostPlayerTakeDamage", function(ply, dmginfo, took)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	if took and ply:GetNotDowned() then
		ply.lasthit = CurTime()
		ply:SetNW2Float("nz.LastHit", CurTime())

		if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SHOCK, DMG_ENERGYBEAM)) ~= 0 then
			ply:SetNW2Float("nzLastShock", CurTime())
		end

		if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_BURN, DMG_SLOWBURN)) ~= 0 then
			ply:SetNW2Float("nzLastBurn", CurTime())
		end

		local ent = dmginfo:GetAttacker()
		if IsValid(ent) and ent:IsValidZombie() then
			if ply:HasPerk("fire") and ply:GetNW2Float("nz.BurnDelay", 0) < CurTime() then
				local fire = ents.Create("elemental_pop_effect_1")
				fire:SetPos(ply:WorldSpaceCenter())
				fire:SetParent(ply)
				fire:SetOwner(ply)
				fire:SetAttacker(ply)
				fire:SetInflictor(ply:GetActiveWeapon())
				fire:SetAngles(angle_zero)

				fire:Spawn()

				local time = (ply:HasUpgrade("fire") and 15 or 30) * math.max(ply:GetNW2Int("nz.BurnCount", 1), 1)
				ply:SetNW2Float("nz.BurnDelay", CurTime() + time)
				ply:SetNW2Int("nz.BurnCount", math.min(ply:GetNW2Int("nz.BurnCount", 0) + 1), 10)
			end
		end
	end
end)

hook.Add("PlayerSpawn", "nzPlayerSpawnVars", function(ply, trans)
	ply:SetNW2Float("nz.DeadshotDecay", 1)
	ply:SetNW2Int("nz.DeadshotChance", 0)

	ply:SetNW2Float("nz.TortDelay", 1)
	ply:SetNW2Int("nz.TortCount", 1)

	ply:SetNW2Float("nz.ZombShellDelay", 1)
	ply:SetNW2Int("nz.ZombShellCount", 0)

	ply:SetNW2Float("nz.EPopDelay", 1)
	ply:SetNW2Int("nz.EPopChance", 0)

	ply:SetNW2Float("nz.BurnDelay", 1)
	ply:SetNW2Int("nz.BurnCount", 0)

	ply:SetNW2Float("nz.WailDelay", 1)
	ply:SetNW2Int("nz.WailCount", 3)

	ply:SetNW2Float("nz.BananaDelay", 1)
	ply:SetNW2Int("nz.BananaCount", 7)

	ply:SetNW2Int("nz.SoloReviveCount", #player.GetAll() <= 1 and (nzMapping.Settings.solorevive or 3) or 0)
end)

hook.Add("PlayerDowned", "nzPlayerDown", function(ply)
	for key, upgrade in pairs(ply.OldUpgrades) do
		if tostring(upgrade) == "danger" then
			nzPowerUps:Nuke(ply:GetPos(), true, false, true)
		end
	end
	for key, perk in pairs(ply.OldPerks) do
		if tostring(perk) == "tortoise" then
			local pos = ply:GetPos()
			local damage = DamageInfo()
			damage:SetDamage(666)
			damage:SetAttacker(ply)
			damage:SetInflictor(IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or ply)
			damage:SetDamageType(DMG_DIRECT)

			for k, v in pairs(ents.FindInSphere(pos, 360)) do
				if v:IsValidZombie() then
					damage:SetDamagePosition(v:EyePos())
					damage:SetDamageForce(v:GetUp()*8000 + (v:GetPos() - pos):GetNormalized()*10000)

					if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
						damage:SetDamage(math.max(2500, ent:GetMaxHealth() / 3))
						damage:ScaleDamage(math.Round(nzRound:GetNumber()/8))
					end

					v:TakeDamageInfo(damage)
				end
			end

			local fx = EffectData()
			fx:SetOrigin(pos)
			util.Effect("HelicopterMegaBomb", fx)
			util.Effect("Explosion", fx)

			util.ScreenShake(pos, 5, 5, 1.5, 600)

			if ply:IsOnGround() then
				util.Decal("Scorch", pos - vector_up, pos + vector_up)
			end

			ply:EmitSound("Perk.Tortoise.Exp")
			ply:EmitSound("Perk.Tortoise.Exp_Firey")
			ply:EmitSound("Perk.Tortoise.Exp_Decay")

			break
		end
	end
end)

hook.Add("PlayerPostThink", "nzStatsRestePlayer", function(ply)
	if ply:HasPerk("banana") then
		if ply:GetNW2Float("nz.BananaDelay", 0) < CurTime() and ply:GetNW2Int("nz.BananaCount", 0) < (ply:HasUpgrade("banana") and 9 or 7) then
			if !ply.NZBananaRegenDelay then
				ply.NZBananaRegenDelay = 0
			end

			if ply.NZBananaRegenDelay < CurTime() then
				ply:SetNW2Int("nz.BananaCount", math.min(ply:GetNW2Int("nz.BananaCount", 0) + 1, (ply:HasUpgrade("banana") and 9 or 7)))
				ply.NZBananaRegenDelay = CurTime() + 5
			end
		end
	end
	if ply:HasPerk("tortoise") then
		if ply:GetNW2Float("nz.TortDelay", 0) < CurTime() and ply:GetNW2Int("nz.TortCount", 0) > 0 then
			ply:SetNW2Int("nz.TortCount", 0)
		end
	end
	if ply:HasPerk("cherry") then
		if ply:GetNW2Float("nz.CherryDelay", 0) < CurTime() and ply:GetNW2Int("nz.CherryCount", 0) > 0 then
			ply:SetNW2Int("nz.CherryCount", 0)
		end
	end

	local barricade = ply.UsedBarricade
	if barricade then
		if IsValid(barricade) and barricade.GetHasPlanks and barricade:GetNumPlanks() < 6 then
			if !barricade.NextPlank or barricade.NextPlank < CurTime() then
				if barricade:GetPos():DistToSqr(ply:GetPos()) > 2500 then //50^2
					if ply:GetNW2Bool("nzInteracting", false) then
						ply:SetNW2Bool("nzInteracting", false)
					end
					ply.UsedBarricade = nil
				else
					barricade:Use(ply, ply, USE_ON, 1)
				end
			end
		else
			if ply:GetNW2Bool("nzInteracting", false) then
				ply:SetNW2Bool("nzInteracting", false)
			end
			ply.UsedBarricade = nil
		end
	end
end)

hook.Add("KeyPress", "nzBarricadeRebuild", function(ply, key)
	if key ~= IN_USE then return end
	if ply.UsedBarricade then return end

	local barricades = {}
	for k, v in pairs(ents.FindInSphere(ply:GetPos(), 50)) do
		if v:GetClass() == "breakable_entry" and v:GetHasPlanks() and v:GetNumPlanks() < 6 then
			barricades[#barricades + 1] = v
		end
	end

	local sortedcades = {}
	for i=1, #barricades do
		local ent = barricades[i]
		if not IsValid(ent) then continue end
		sortedcades[i] = ent:GetPos():DistToSqr(ply:GetPos())
	end

	for k, dist in SortedPairsByValue(sortedcades) do
		local ent = barricades[k]
		if not IsValid(ent) then continue end

		ply.UsedBarricade = ent
		if !ply:GetNW2Bool("nzInteracting", false) then
			ply:SetNW2Bool("nzInteracting", true)
		end
		break
	end
end)

hook.Add("KeyRelease", "nzBarricadeRebuild", function(ply, key)
	if key ~= IN_USE then return end
	if ply.UsedBarricade then
		ply.UsedBarricade = nil
		if ply:GetNW2Bool("nzInteracting", false) then
			ply:SetNW2Bool("nzInteracting", false)
		end
	end
end)

hook.Add("OnEntityCreated", "nodmglolfucku", function(ent)
	timer.Simple(0, function()
		if not IsValid(ent) then return end
		if IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer() then
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
			end
		end
	end)
end)

hook.Add("WeaponEquip", "nzWeaponPickupString", function(wep, ply)
	if wep.NZPickupHintText then
		timer.Simple(0, function()
			if not IsValid(wep) or not IsValid(ply) then return end
			ply:PrintMessage(HUD_PRINTCENTER, wep.NZPickupHintText)
		end)
	end
end)

local cvar_respawnonplayers = GetConVar("nz_difficulty_respawn_on_players")

local function GetClearPaths(ply, pos, tiles)
	local clearPaths = {}
	local filter = player.GetAll()
	for _, tile in pairs( tiles ) do
		local tr = util.TraceLine({
			start = pos,
			endpos = tile,
			filter = filter,
			mask = MASK_PLAYERSOLID
		})
		
		if not tr.Hit and util.IsInWorld(tile) then
			table.insert( clearPaths, tile )
		end
	end
	
	return clearPaths
end

local function GetSurroundingTiles(ply, pos)
	local tiles = {}
	local x, y, z
	local minBound, maxBound = ply:GetHull()
	local checkRange = math.max(32, maxBound.x, maxBound.y)

	for z = -1, 1, 1 do
		for y = -1, 1, 1 do
			for x = -1, 1, 1 do
				local testTile = Vector(x,y,z)
				testTile:Mul( checkRange )
				local tilePos = pos + testTile
				table.insert( tiles, tilePos )
			end
		end
	end
	
	return tiles
end

local function CollisionBoxClear(ply, pos, spawns)
	local filter = {ply}
	table.Add(filter, spawns)
	local tr = util.TraceEntity({
		start = pos,
		endpos = pos,
		filter = filter,
		mask = MASK_PLAYERSOLID
	}, ply)

	return !tr.StartSolid || !tr.AllSolid
end

local PLAYER = FindMetaTable("Player")
function PLAYER:MoveToSpawn(dontuseplayers)
	--Charlotte here, this took 2 fucking hours. I've never been so happy to have something done >:3
	local spawns = ents.FindByClass("player_spawns")
	if not IsValid(spawns[1]) then return end

	local availableSpawns = {}
	local finalpos = spawns[math.random(#spawns)]:GetPos()
	local finalang = self:GetAngles()

	-- Find all available spawn points
	for _, spawn in ipairs(spawns) do
		local isSpawnOccupied = false

		local mins, maxs = spawn:GetCollisionBounds()
		for _, ply in pairs(ents.FindInBox(spawn:LocalToWorld(mins), spawn:LocalToWorld(maxs))) do
			if IsValid(ply) and ply:IsPlayer() and ply:Alive() then
				isSpawnOccupied = true
			end
		end

		if not isSpawnOccupied then
			availableSpawns[#availableSpawns + 1] = spawn
		end
	end

	for _, spawn in RandomPairs(availableSpawns) do
		finalpos = spawn:GetPos()
		finalang = spawn:GetAngles()
		if spawn:GetPreferred() then break end
	end

	if cvar_respawnonplayers:GetBool() and nzRound:GetNumber() > 1 and !dontuseplayers then
		local spawns = player.GetAllPlaying()

		local spectator = self.LastSpectatedPlayer
		if IsValid(spectator) and spectator:Alive() and spectator:IsPlaying() then
			finalpos = spectator:GetPos()
		elseif not table.IsEmpty(spawns) then
			for _, ply in RandomPairs(spawns) do
				finalpos = ply:GetPos()
				finalang = Angle(0,math.random(-180,180),0)
				if !ply:GetNotDowned() then break end
				//prefer respawning on downed players :)
			end
		end
	end

	local minBound, maxBound = self:GetHull()
	if not CollisionBoxClear(self, finalpos, availableSpawns ) then
		local surroundingTiles = GetSurroundingTiles( self, finalpos )
		local clearPaths = GetClearPaths( self, finalpos, surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if CollisionBoxClear( self, tile, availableSpawns ) then
				finalpos = tile
				break
			end
		end
	end

	self:SetPos(finalpos + vector_up)
	self:SetAngles(Angle(0,finalang[2],0))
	self:SetEyeAngles(Angle(0,finalang[2],0))

	return finalpos
end

local ENTITY = FindMetaTable("Entity")
if ENTITY then
	local oldignite = ENTITY.Ignite
	function ENTITY:Ignite(...)
		if not self:IsPlayer() then return oldignite(self, ...) end
		if self:HasPerk("fire") then return end
		return oldignite(self, ...)
	end
end