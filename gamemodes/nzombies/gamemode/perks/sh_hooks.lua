if SERVER then
	//randomized perk machines

	hook.Add("OnGameBegin", "nz.PerkMachineRolling", function()
		timer.Simple(0, function()
			local machines = ents.FindByClass("perk_machine")

			nzPerks:RebuildPaPCount()

			if nzMapping.Settings.randompap then
				local paptime = nzMapping.Settings.randompaptime
				if paptime and paptime > 0 then
					timer.Create("nzPaPShuffler", paptime, 0, function()
						if nzPerks.PackAPunchCount <= 1 then return end

						local machines = ents.FindByClass("perk_machine")
						for k, v in pairs(machines) do
							if v:GetSelected() then
								nzPerks.LastPaPMachine = v
								v.MarkedForRemoval = true
							end
						end

						for k, v in RandomPairs(machines) do
							if v:GetPerkID() == "pap" then
								if nzPerks.LastPaPMachine and nzPerks.LastPaPMachine == v then continue end

								v:SetSelected(true)

								ParticleEffect("driese_tp_arrival_phase2", v:GetPos(), Angle(0,0,0))
								v:EmitSound("amb/weather/lightning/lightning_flash_0"..math.random(0,3)..".wav", 511, 100, 1, CHAN_STATIC)

								if (!v:GetDoorActivated() or v.DoorRevealed) then
									v:ShowMachine()
								end
								break
							end
						end
					end)
				elseif nzPerks.PackAPunchCount > 1 then
					for k, v in pairs(machines) do
						if v:GetPerkID() == "pap" then
							v:SetSelected(false)
						end
					end

					for k, v in RandomPairs(machines) do
						if v:GetPerkID() == "pap" and !v:GetSelected() then
							v:SetSelected(true)
							if (!v:GetDoorActivated() or v.DoorRevealed) then
								v:ShowMachine()
							end
							break
						end
					end
				end
			end

			for _, v in pairs(machines) do
				if v:GetDoorActivated() then
					v:HideMachine()
					continue
				end
				if v:GetRandomize() then
					v:StartRolling()
				end
			end
		end)
	end)

	hook.Add("OnRoundPreparation", "nz.PerkMachineRolling", function(round)
		local machines = ents.FindByClass("perk_machine")
		if round <= 1 then return end

		if nzMapping.Settings.randompap and (nzPerks.PackAPunchCount or 0) > 1 and (!nzMapping.Settings.randompaptime or nzMapping.Settings.randompaptime <= 0) and nzMapping.Settings.randompapinterval > 0 and round%(nzMapping.Settings.randompapinterval) == 0 then
			for k, v in pairs(machines) do
				if v:GetSelected() then
					nzPerks.LastPaPMachine = v
					v.MarkedForRemoval = true
				end
			end

			for k, v in RandomPairs(machines) do
				if v:GetPerkID() == "pap" then
					if nzPerks.LastPaPMachine and nzPerks.LastPaPMachine == v then continue end

					v:SetSelected(true)

					ParticleEffect("driese_tp_arrival_phase2", v:GetPos() + vector_up, Angle(0,0,0))
					v:EmitSound("amb/weather/lightning/lightning_flash_0"..math.random(0,3)..".wav", 511, 100, 1, CHAN_STATIC)

					if (!v:GetDoorActivated() or v.DoorRevealed) then
						v:ShowMachine()
					end
					break
				end
			end
		end

		for k, v in pairs(machines) do
			if v:GetRandomize() and (!v:GetDoorActivated() or v.DoorRevealed) and v:GetRandomizeRounds() and v:GetRandomizeInterval() then
				if round%(v:GetRandomizeInterval()) == 0 and round ~= 1 then
					v:StartRolling(true)
				end
			end
		end
	end)

	hook.Add("OnDoorUnlocked", "NZ.PerkMachineRolling", function(ent, link, rebuyable, ply)
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			if v:GetDoorActivated() and !v.DoorRevealed then
				local door_flags = {}
				if v.DoorFlag then
					door_flags[v.DoorFlag] = true
				end
				if v.DoorFlag2 then
					door_flags[v.DoorFlag2] = true
				end
				if v.DoorFlag3 then
					door_flags[v.DoorFlag3] = true
				end

				if door_flags[tostring(link)] then
					if v:GetPerkID() == "pap" and nzMapping.Settings.randompap then
						if (nzPowerUps:IsPowerupActive("bonfiresale") or v:GetSelected() or (nzPerks.PackAPunchCount or 0) <= 1) then
							if (nzPerks.PackAPunchCount or 0) <= 1 and !v:GetSelected() then
								v:SetSelected(true)
							end
							v:ShowMachine(true)
						else
							v.DoorRevealed = true
						end
					else
						v:ShowMachine(true)
					end

					if v:GetRandomize() then
						v:StartRolling()
					end
				end
			end
		end
	end)

	hook.Add("OnRoundInit", "nz.PerkMachineRolling", function()
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			v.SpawnPos = v:GetPos()
			v:Reset()
		end
	end)

	hook.Add("OnRoundEnd", "nz.PerkMachineRolling", function()
		nzPerks.LastPaPMachine = nil
		nzPerks:RebuildPaPCount()
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			v:Reset()
		end
		timer.Remove("nzPaPShuffler")
	end)

	//nuked perk machines

	local b_whatamidoingpleasehelp = false
	hook.Add("OnRoundInit", "nz.NukedPerks", function()
		if !nzMapping.Settings.nukedperks then return end

		if b_whatamidoingpleasehelp then return end
		b_whatamidoingpleasehelp = true

		local singleplayer = game.SinglePlayer() or #player.GetAll() <= 1
		if !singleplayer then
			nzPerks.NextNukedRound = math.random(nzMapping.Settings.nukedroundmin, nzMapping.Settings.nukedroundmax)
		end

		local spawns = ents.FindByClass("player_spawns")
		local map_perks = {} //table of perk id's on the map
		local total_machines = {} //table of perk entities on the map

		local machines = table.Copy(ents.FindByClass("perk_machine"))
		for k, ent in pairs(machines) do
			local perk = ent:GetPerkID()
			if perk == "pap" and !nzMapping.Settings.nukedpap then
				table.RemoveByValue(machines, ent)
				continue
			end
			map_perks[#map_perks + 1] = perk
		end
		table.Add(total_machines, machines)

		if nzMapping.Settings.nukedfizz then
			local fizzies = ents.FindByClass("wunderfizz_machine")
			for k, ent in pairs(fizzies) do
				map_perks[#map_perks + 1] = "wunderfizz"
			end
			table.Add(total_machines, fizzies)
		end

		print('////////////////// Total Perks to Roll')
		PrintTable(map_perks)

		nzPerks.NukedPerks = map_perks

		if singleplayer then
			for index, perk in pairs(map_perks) do
				if perk == "revive" then
					map_perks[index] = nil
					break
				end
			end

			print('////////////////// Singleplayer Detected')
		end

		if nzMapping.Settings.nukedrandom then
			for _, ent in RandomPairs(total_machines) do
				if not IsValid(ent) then continue end

				if ent:GetClass() == "wunderfizz_machine" then
					local ourperk = "wunderfizz"
					for index, perk in RandomPairs(map_perks) do
						ourperk = perk
						map_perks[index] = nil
						break
					end

					print('////////////////// Original Perk wunderfizz')
					print('////////////////// Rolled Perk '..ourperk)

					nzMapping:PerkCratePile(ent:GetPos(), ent:GetAngles(), {id = ourperk}, "wunderfizz")
					SafeRemoveEntity(ent)

					/*print('////////////////// Map Perks left')
					PrintTable(map_perks)*/
				else
					local ourperk = ent:GetPerkID()
					local storedperk = ourperk

					if singleplayer and ourperk ~= "revive" then
						for index, perk in RandomPairs(map_perks) do
							ourperk = perk
							map_perks[index] = nil
							break
						end
					elseif !singleplayer then
						for index, perk in RandomPairs(map_perks) do
							ourperk = perk
							map_perks[index] = nil
							break
						end
					end

					local data = {
						id = ourperk,
						random = ent:GetRandomize(),
						fizzlist = ent:GetRandomizeFizz(),
						randomround = ent:GetRandomizeRounds(),
						roundnum = ent:GetRandomizeInterval(),
						door = ent:GetDoorActivated(),
						doorflag = ent.DoorFlag,
						doorflag2 = ent.DoorFlag2,
						doorflag3 = ent.DoorFlag3,
						price = ent.PriceOverride,
						priceupg = ent.PriceOverrideUpgrade,
					}

					print('////////////////// Original Perk '..storedperk)
					print('////////////////// Rolled Perk '..ourperk)

					local cratepile = nzMapping:PerkCratePile(ent:GetPos(), ent:GetAngles(), data, ent:GetPerkID())
					if storedperk == "revive" and !nzPerks.StartingNukedPerk then
						nzPerks.StartingNukedPerk = cratepile
					end

					SafeRemoveEntity(ent)

					/*print('////////////////// Map Perks left')
					PrintTable(map_perks)*/
				end
			end
		else
			for _, ent in pairs(total_machines) do
				if ent:GetClass() == "wunderfizz_machine" then
					nzMapping:PerkCratePile(ent:GetPos(), ent:GetAngles(), {id = "wunderfizz"})
					SafeRemoveEntity(ent)
				else
					local data = {
						id = ent:GetPerkID(),
						random = ent:GetRandomize(),
						fizzlist = ent:GetRandomizeFizz(),
						randomround = ent:GetRandomizeRounds(),
						roundnum = ent:GetRandomizeInterval(),
						door = ent:GetDoorActivated(),
						doorflag = ent.DoorFlag,
						doorflag2 = ent.DoorFlag2,
						doorflag3 = ent.DoorFlag3,
						price = ent.PriceOverride,
						priceupg = ent.PriceOverrideUpgrade,
					}

					nzMapping:PerkCratePile(ent:GetPos(), ent:GetAngles(), data)
					SafeRemoveEntity(ent)
				end
			end
		end
	end)

	hook.Add("OnRoundPreparation", "nz.NukedPerks", function(round)
		if !nzMapping.Settings.nukedperks then return end
		if round < 1 then return end

		local singleplayer = game.SinglePlayer() or #player.GetAll() <= 1
		if nzPerks.NextNukedRound <= round then
			if round == 1 and singleplayer then
				nzSounds:PlayFile("nz_moo/perkacola/perk_siren.wav")
			else
				timer.Simple(4.5, function()
					if nzMapping.Settings.nukedspawn then
						sound.Play("nz_moo/perkacola/clock_hand.wav", nzMapping.Settings.nukedspawn, 511, 100, 1)
					end
				end)
				timer.Simple(5, function()
					nzSounds:PlayFile("nz_moo/perkacola/perk_siren.wav")
				end)
			end
		end
	end)

	hook.Add("OnRoundStart", "nz.NukedPerks", function(round)
		if !nzMapping.Settings.nukedperks then return end

		if nzPerks.NextNukedRound <= round then
			local nukedspawns = ents.FindByClass("perk_cratepile")

			if nzPerks.StartingNukedPerk and IsValid(nzPerks.StartingNukedPerk) then
				print('////////////////// Launching Starting Perk to revive')
				local fucker = nzPerks.StartingNukedPerk
				if round == 1 then
					timer.Simple(4, function()
						if not IsValid(fucker) then return end
						fucker:Launch()
					end)
				else
					fucker:Launch()
				end
				nzPerks.StartingNukedPerk = nil
			else
				for k, v in RandomPairs(nukedspawns) do
					if (v.PerkMachine or v.TimeToImpact) then continue end

					if round == 1 then
						timer.Simple(4, function()
							if not IsValid(v) then return end
							v:Launch()
						end)
					else
						v:Launch()
					end
					print('////////////////// Launching '..v.PerkData["id"]..' Machine')
					break
				end
			end

			local b_alldone = true
			for k, v in pairs(nukedspawns) do
				if !v.PerkMachine then
					if v.TimeToImpact then
						continue
					end
					b_alldone = false
				end
			end

			if b_alldone then
				nzPerks.NextNukedRound = math.huge
				print('////////////////// Nuked Perks Completed')
			else
				nzPerks.NextNukedRound = round + math.random(nzMapping.Settings.nukedroundmin, nzMapping.Settings.nukedroundmax)
			end

			print('////////////////// Next Nuked Perk Round '..nzPerks.NextNukedRound)
		end
	end)

	hook.Add("OnRoundEnd", "nz.NukedPerks", function()
		if b_whatamidoingpleasehelp then
			b_whatamidoingpleasehelp = false
		end

		nzPerks.NextNukedRound = 0
		nzPerks.StartingNukedPerk = nil
		nzPerks.NukedPerks = nil
		for _, v in pairs(ents.FindByClass("perk_cratepile")) do
			if v.PerkMachine and IsValid(v.PerkMachine) then
				SafeRemoveEntityDelayed(v.PerkMachine, 0)
			end

			local newdata = v.PerkData
			if v.StoredPerk then
				newdata["id"] = v.StoredPerk
			end
			nzMapping:PerkMachine(v:GetPos(), v:GetAngles(), newdata)

			v:Remove()
		end
	end)

	//perk effects
	local boobookeys = {
		[IN_RELOAD] = true,
		[IN_ATTACK] = true,
	}

	hook.Add("KeyPress", "nzPolitanEffects", function(ply, key)
		if not IsValid(ply) then return end
		if not ply:HasPerk("politan") then return end
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) or wep.NZSpecialCategory or not wep.IsTFAWeapon then return end

		if boobookeys[key] and (wep.Primary.ClipSize > 0 and wep:Clip1() == 0 or ply:GetAmmoCount(wep:GetPrimaryAmmoType()) == 0) then
			if ply:HasPerk("cherry") then
				ply:SetNW2Bool("nz.CherryBool", false)
			end

			for k, v in RandomPairs(nzMapping.Settings.rboxweps) do
				if ply:HasWeapon(k) then continue end
				local gun = weapons.Get(k)
				if not gun then continue end

				local guntogive = k
				local fucker = true

				if gun.NZSpecialCategory then
					fucker = false
				end
				if gun.NZPaPReplacement and ply:HasWeapon(gun.NZPaPReplacement) then
					fucker = false
				end
				if not gun.NZPaPReplacement and not gun.OnPaP then
					fucker = false
				end
				if gun.NZPaPReplacement then
					guntogive = gun.NZPaPReplacement
				end

				if fucker then
					ply:StripWeapon(wep:GetClass())

					if not ply:HasUpgrade("politan") and not ply:HasPerk("wall") then
						ply:Give(guntogive)
					else
						local wep2 = ply:Give(guntogive)
						wep2.NZPaPME = true
					end

					break
				end
			end
		end
	end)

	hook.Add("PlayerPostThink", "nzCandolierMod", function(ply)
		local bandit = ply:HasUpgrade("candolier")
		local speed = ply:HasUpgrade("speed")
		if not (bandit or speed) then return end

		local speeddelay = ply:GetNW2Float("nz.SpeedDelay", 0)

		local weps = ply:GetWeapons()
		for _, wep in ipairs(weps) do
			if wep:IsSpecial() or !wep.IsTFAWeapon then continue end

			local speedtimer = wep.NZSpeedHolster
			if speed then
				local ply = wep:GetOwner()
				if IsValid(ply) and ply:IsPlayer() and ply:HasUpgrade("speed") and wep:GetStatusEnd() < CurTime() and wep ~= ply:GetActiveWeapon() and !wep.NZSpeedHolster then
					local b_notfull = false
					if wep:Clip1() < wep:GetPrimaryClipSize() and wep:Ammo1() > 0 then
						b_notfull = true
					end
					if wep:Clip2() < (wep.Akimbo and wep:GetPrimaryClipSize() or wep:GetSecondaryClipSize()) and (wep.Akimbo and wep:Ammo1() or wep:Ammo2()) > 0 then
						b_notfull = true
					end

					if b_notfull then
						local ct = CurTime()
						wep.NZSpeedHolster = ct
						ply:SetNW2Float("nz.SpeedDelay", ct + 4)
						ply:SetNW2Int("nz.SpeedCount", 4)
					end
				end

				if speedtimer then
					if speedtimer + 4 == speeddelay then
						local frac = 1 - math.Clamp((CurTime() - speedtimer) / 4, 0, 1)
						local count = math.Round(4*frac)
						if ply:GetNW2Int("nz.SpeedCount", 0) > count then
							ply:SetNW2Int("nz.SpeedCount", math.max(count, 0))
						end
					end

					if speedtimer + 4 < CurTime() then
						local active = ply:GetActiveWeapon()
						if wep ~= active then
							wep.NZSpeedHolster = nil
							if (wep.LoopedReload or wep.Shotgun) then
								local amt = wep:GetStatL("LoopedReloadInsertAmount", 1)
								wep:InsertPrimaryAmmo(amt)
								wep:CallOnClient("InsertPrimaryAmmo", tostring(amt))
							else
								wep:CompleteReload()
								wep:CallOnClient("CompleteReload", "")
							end
						end
						continue
					end
				end
			end

			if wep.NZDontRegen or !bandit then continue end

			if wep.IsTFAWeapon and (wep:GetStatus() == TFA.Enum.STATUS_SHOOTING or TFA.Enum.ReloadStatus[wep:GetStatus()]) then
				if wep.NZLastAmmoRegen then
					local time = math.Clamp(10/wep.Primary.ClipSize, 0.1, 1) + 1
					wep.NZLastAmmoRegen = math.Max(wep.NZLastAmmoRegen, CurTime() + time)
				end
				continue
			end

			if wep.NZLastAmmoRegen and wep.NZLastAmmoRegen > CurTime() then continue end

			if not wep.Primary or not wep.Primary.ClipSize then continue end
			if wep.Primary.ClipSize <= 0 then continue end

			local ammo1 = wep:GetPrimaryAmmoType()
			if ammo1 > 0 then
				local clip1 = wep:Clip1()
				local ammo1count = ply:GetAmmoCount(ammo1)
				if clip1 > 0 and clip1 < wep.Primary.ClipSize and ammo1count > 0 then
					ply:RemoveAmmo(1, ammo1)
					wep.NZSpeedRegenerating = true
					wep:SetClip1(math.min(clip1 + 1, wep.Primary.ClipSize))
					wep.NZSpeedRegenerating = nil
				end
			end

			if wep.Akimbo then
				if ammo1 > 0 and wep.Secondary and wep.Secondary.ClipSize then
					local clip2 = wep:Clip2()
					local ammo1count = ply:GetAmmoCount(ammo1)
					if clip2 > 0 and clip2 < wep.Secondary.ClipSize and ammo1count > 0 then
						ply:RemoveAmmo(1, ammo1)
						wep.NZSpeedRegenerating = true
						wep:SetClip2(math.min(clip2 + 1, wep.Secondary.ClipSize))
						wep.NZSpeedRegenerating = nil
					end
				end
			else
				local ammo2 = wep:GetSecondaryAmmoType()
				if ammo2 > 0 and wep.Secondary and wep.Secondary.ClipSize then
					local ammo2count = ply:GetAmmoCount(ammo2)
					local clip2 = wep:Clip2()
					if clip2 > 0 and clip2 < wep.Secondary.ClipSize and ammo2count > 0 then
						ply:RemoveAmmo(1, ammo2)
						wep.NZSpeedRegenerating = true
						wep:SetClip2(math.min(clip2 + 1, wep.Secondary.ClipSize))
						wep.NZSpeedRegenerating = nil
					end
				end
			end

			local active = ply:GetActiveWeapon()
			if wep == active then
				local time = 10/wep.Primary.ClipSize
				wep.NZLastAmmoRegen = CurTime() + math.Clamp(time, 0.2, 2)
			else
				local time = 10/wep.Primary.ClipSize
				wep.NZLastAmmoRegen = CurTime() + math.Clamp(time, 0.1, 2)
			end
		end
	end)

	hook.Add("TFA_Deploy", "nzSpeedColaMod", function(wep)
		local ply = wep:GetOwner()
		local speedtimer = wep.NZSpeedHolster
		if IsValid(ply) and ply:IsPlayer() and speedtimer then
			wep.NZSpeedHolster = nil
			if speedtimer + 4 == ply:GetNW2Float("nz.SpeedDelay", 0) then
				ply:SetNW2Float("nz.SpeedDelay", 0)
				ply:SetNW2Int("nz.SpeedCount", 0)
			end
		end
	end)

	hook.Add("TFA_PostPrimaryAttack", "nzCherryMod", function(wep)
		local ply = wep:GetOwner()
		if not IsValid(ply) or not ply:IsPlayer() then return end

		local fuck = false
		if wep:GetStatL("Primary.ClipSize") <= 0 and wep:Ammo1() < wep:GetStatL("Primary.AmmoConsumption") then
			fuck = true
		end
		if wep:GetPrimaryClipSize(true) > 0 and wep:Clip1() < wep:GetStatL("Primary.AmmoConsumption") then
			fuck = true
		end

		if ply:HasUpgrade("cherry") and fuck and ply:GetNW2Float("nz.CherryWaffe", 0) < CurTime() then
			wep:EmitGunfireSound("TFA_BO3_WAFFE.Shoot")

			local arc = ents.Create("bo3_ww_wunderwaffe")
			if not IsValid(arc) then return end

			arc:SetModel("models/dav0r/hoverball.mdl")
			arc:SetPos(ply:GetShootPos())
			arc:SetAngles(wep:GetAimVector():Angle())

			arc:SetOwner(ply)
			arc:SetNoDraw(true)

			arc.MaxChain = math.random(4, 6)
			arc.ZapRange = 300 * (1 - math.Clamp(ply:GetNW2Int("nz.CherryCount", 0) / 10, 0, 0.9))
			arc.ArcDelay = 0.2

			arc:Spawn()

			arc:SetOwner(ply)
			arc.Inflictor = wep

			local dir = wep:GetAimVector()
			dir:Mul(2000)

			arc:SetVelocity(dir)
			local phys = arc:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(dir)
			end

			ply:SetNW2Float("nz.CherryWaffe", CurTime() + 10)
		end
	end)

	-- Resseting player stats on round start
	hook.Add("OnRoundStart", "nz.ResetKillStats", function()
		for _, ply in ipairs(player.GetAll()) do
			if ply:HasPerk("vulture") then
				ply:SetNW2Int("nz.VultureCount", 0)
			end
			if ply:HasPerk("everclear") then
				ply:SetNW2Float("nz.ZombShellDelay", 1)
				ply:SetNW2Int("nz.ZombShellCount", 0)
			end
			if ply:HasPerk("fire") then
				ply:SetNW2Float("nz.BurnDelay", 1)
				ply:SetNW2Int("nz.BurnCount", 0)
			end
			if ply:HasPerk("winters") then
				ply:SetNW2Float("nz.WailDelay", 1)
				ply:SetNW2Int("nz.WailCount", ply:HasUpgrade("winters") and 4 or 3)
			end
			if ply:HasUpgrade("jugg") then
				local bonus = math.max(ply:GetMaxArmor(), ply:Armor())
				ply:SetArmor(bonus)
			end
		end
	end)
end

local PLAYER = FindMetaTable("Player")
if PLAYER then
	function PLAYER:GetPHDJumped()
		return self:GetNW2Bool("nz.PHDJumpd", false)
	end
	function PLAYER:SetPHDJumped(bool)
		return self:SetNW2Bool("nz.PHDJumpd", bool)
	end
	function PLAYER:GetPHDDelay()
		return self:GetNW2Float("nz.PHDDelay", 0)
	end
	function PLAYER:SetPHDDelay(float)
		return self:SetNW2Float("nz.PHDDelay", float)
	end
end

local function GetMoveVector(mv) //from willox's double jump
	local ang = mv:GetAngles()

	local max_speed = mv:GetMaxSpeed()

	local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
	local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

	local abs_xy_move = math.abs(forward) + math.abs(side)

	if abs_xy_move == 0 then
		return vector_origin
	end

	local mul = max_speed / abs_xy_move

	local vec = Vector()

	vec:Add(ang:Forward() * forward)
	vec:Add(ang:Right() * side)

	vec:Mul(mul)

	return vec
end

hook.Add("SetupMove", "nzPHDEffects", function(ply, mv, cmd)
	if ply:HasUpgrade("phd") and !ply:InVehicle() and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
		local onground = ply:IsOnGround()
		if onground and ply:GetPHDJumped() then
			ply:SetPHDJumped(false)
		end

		if not onground and mv:KeyPressed(IN_JUMP) and not ply:GetPHDJumped() then
			ply:SetPHDJumped(true)

			local vel = GetMoveVector(mv)
			vel.z = ply:GetJumpPower()

			local max = mv:GetMaxSpeed()
			local fwd = math.Clamp(mv:GetForwardSpeed(), -max, max)
			local side = math.Clamp(mv:GetSideSpeed(), -max, max)

			mv:SetVelocity(vel)

			ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)

			local sidesway = side / max
			local fwdsway = fwd / max

			ply:ViewPunch(Angle(fwdsway*2, 0, sidesway*3))
			if IsFirstTimePredicted() then
				local fx = EffectData()
				fx:SetOrigin(ply:GetPos())
				fx:SetEntity(ply)
				fx:SetScale(120)
				util.Effect("ThumperDust", fx)

				ply:EmitSound("NZ.PHD.Jump")
			end
		end

		if not onground and ply:GetPHDJumped() and mv:KeyReleased(IN_DUCK) and ply:GetPHDDelay() < CurTime() and !ply:GetDiving() then
			ply:SetPHDDelay(CurTime() + 7)
			mv:SetVelocity(mv:GetVelocity() - (vector_up*1000))
		end
	end
end)

hook.Add("OnPlayerHitGround", "nzPlayerHitGround", function(ply, inWater, onFloater, speed)
	if ply:HasPerk("phd") and (speed >= 400 or (ply.DivingGroundZ and ply:GetPos().z <= ply.DivingGroundZ)) then
		ply.DivingGroundZ = nil
		/*if speed < 400 and ply:GetDiving() and ply:GetNW2Float("nz.PHDDelay", 0) > CurTime() then
			return
		end*/

		local mult = math.Clamp(math.floor(speed/400), 1, 3)

		local maxpunch = 2*mult
		ply:ViewPunch(Angle(3.5*mult, math.random(-maxpunch,maxpunch), math.random(-maxpunch,maxpunch)))

		//only for our self (clientside in multiplayer)
		if IsFirstTimePredicted() and (game.SinglePlayer() or CLIENT) then
			local fx = EffectData()
			fx:SetOrigin(ply:GetPos() + vector_up*4)
			fx:SetAngles(angle_zero)
			util.Effect("nz_phd_flop", fx)

			ply:EmitSound("NZ.PHD.Wubz")
			ply:EmitSound("NZ.PHD.Impact")

			util.ScreenShake(ply:GetPos(), 10*mult, 5, math.max(1*mult, 1.2), 200*mult)
		end

		if SERVER then
			/*if speed < 400 and ply:GetDiving() then
				ply:SetNW2Float("nz.PHDDelay", CurTime() + 2)
			end*/

			//network to other clients in multiplayer
			if !game.SinglePlayer() then
				local filter = RecipientFilter()
				filter:AddPAS(ply:GetPos())
				filter:RemovePlayer(ply)

				ply:EmitSound("NZ.PHD.Wubz", SNDLVL_GUNFIRE, math.random(97,103), 1, CHAN_USER_BASE, 0, 0, filter)
				ply:EmitSound("NZ.PHD.Impact", SNDLVL_NORM, math.random(97,103), 1, CHAN_VOICE_BASE, 0, 0, filter)

				filter:RemoveAllPlayers()
				filter:AddPVS(ply:GetPos())
				filter:RemovePlayer(ply)

				local fx = EffectData()
				fx:SetOrigin(ply:GetPos() + vector_up*4)
				fx:SetAngles(angle_zero)
				util.Effect("nz_phd_flop", fx, filter)

				util.ScreenShake(ply:GetPos(), 10*mult, 5, math.max(1*mult, 1.2), 200*mult, true, filter)
			end

			util.BlastDamage(ply:GetActiveWeapon(), ply, ply:GetPos(), 150*mult, 4000*mult)
		end
	end
end)

hook.Add("EntityTakeDamage", "nzTortoiseBuildables", function(ent, dmginfo)
	if ent.GetTrapClass and not ent.NZIgnoreTortoiseBuff then
		local ply = ent:GetOwner()
		if IsValid(ply) and ply:IsPlayer() and ply:HasPerk("tortoise") then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
		end
	end
end)

hook.Add("OnZombieKilled", "nzTombstoneModifierWavy", function(ent, dmginfo)
	local ply = dmginfo:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and IsValid(ent) and ent:IsValidZombie() then
		if ply.FightersFizz and !ply:GetNotDowned() then
			ply:RevivePlayer(ply)
		end
	end
end)

hook.Add("TFA_CanPrimaryAttack", "nzDeadlockBanana", function(weapon)
	local ply = weapon:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and ply:HasUpgrade("banana") and ply:GetSliding() and ply:GetNW2Int("nz.BananaCount", 0) > 0 then
		return true
	end
end)

//removed, but the code for finding head pos is usefull for reference
/*hook.Add("TFA_SecondaryAttack", "nzDeadshotMod", function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasUpgrade("deadshot") then
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if IsValid(ent) and ent:IsValidZombie() and ent:Health() > 0 then
			local head
			for i = 0, ent:GetHitBoxCount(0) do
				if ent:GetHitBoxHitGroup(i,0) == HITGROUP_HEAD then
					head = ent:GetHitBoxBone(i, 0)
					break
				end
			end

			if not head then
				for i = 0, ent:GetHitBoxCount(0) do
					if ent:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
						head = ent:GetHitBoxBone(i, 0)
						break
					end
				end
			end

			if head then
				local headpos, headang = ent:GetBonePosition(head)
				headpos = ply:KeyDown(IN_ATTACK) and (headpos - Vector(0,0,8)) or headpos
				ply:SetEyeAngles((headpos - ply:GetShootPos()):Angle())
			end
		end
	end
end)*/

hook.Add("TFA_CompleteReload", "nzCherryBool", function(wep)
	if wep.NZSpecialCategory then return end
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasPerk("cherry") then
		ply:SetNW2Bool("nz.CherryBool", false)
	end
end)

hook.Add("TFA_LoadShell", "nzCherryBool2", function(wep)
	if wep.NZSpecialCategory then return end
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasPerk("cherry") then
		ply:SetNW2Bool("nz.CherryBool", false)
	end
end)

hook.Add("TFA_Reload", "nzCherryEffects", function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if wep.NZSpecialCategory then return end

	if ply:HasPerk("cherry") and not ply:GetNW2Bool("nz.CherryBool") and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) > 0 then
		ply:SetNW2Bool("nz.CherryBool", true)

		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1

		if ply:GetNW2Float("nz.CherryDelay", 0) < CurTime() and ply:GetNW2Int("nz.CherryCount", 0) > 0 then
			ply:SetNW2Int("nz.CherryCount", 0)
		end

		local scale = 1 - math.Clamp(ply:GetNW2Int("nz.CherryCount", 0) / 10, 0, 0.9)
		local proc = 1 - math.Clamp(wep:Clip1() / wep.Primary.ClipSize, 0, 1)
		local dmg = (320 * math.pow(1.1, math.floor(round/2) - 1)) * proc
		local count = 0

		local damage = DamageInfo()
		damage:SetDamage(dmg * scale)
		damage:SetDamageType(DMG_SHOCK)
		damage:SetAttacker(ply)
		damage:SetInflictor(wep)
		damage:SetDamageForce(vector_up)

		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 160 * proc)) do
			if ((v:IsNPC() or v:IsNextBot()) and v:Health() > 0) or v.DoCherryShock then
				damage:SetDamagePosition(v:WorldSpaceCenter())	

				if ply:HasUpgrade("cherry") and !v.IsMooBossZombie then
					damage:SetDamage(v:Health() + 666)
				end

				if damage:GetDamage() > v:Health() and IsFirstTimePredicted() and !v.DoCherryShock then
					ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, v, 2)
					if v:OnGround() then
						ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, v, 0)
					end
					if v:IsValidZombie() and not v.IsMooSpecial then
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, v, 3)
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, v, 4)
					end
				end

				if SERVER then
				
					if v:IsValidZombie() and !v:GetSpecialAnimation() and !v.IsMooSpecial and !v:GetCrawler() and !(v.NZBossType or v.IsMooBossZombie) then
						v:PerformStun( math.Rand(1,3) )
					end
					--[[if v.TempBehaveThread and v.SparkySequences then
						ParticleEffectAttach("bo3_shield_electrify_zomb", PATTACH_ABSORIGIN_FOLLOW, v, 2)
						if v.PlaySound and v.ElecSounds then
							v:PlaySound(v.ElecSounds[math.random(#v.ElecSounds)], v.SoundVolume or SNDLVL_NORM, math.random(v.MinSoundPitch, v.MaxSoundPitch), 1, 2)
						end

						v:TempBehaveThread(function(v)
							local seq = v.SparkySequences[math.random(#v.SparkySequences)]
							local id, time = v:LookupSequence(seq)
							v:PlaySequenceAndWait(seq)
							v:StopParticles()
						end)
					end]]

					v.WasShockedThisTick = true
					v:TakeDamageInfo(damage)

					timer.Simple(0, function()
						if not IsValid(v) then return end
						v.WasShockedThisTick = nil
					end)

					if damage:GetDamage() > v:Health() then
						count = count + 1
					end
				end
			end
		end

		ply:SetNW2Int("nz.CherryCount", ply:GetNW2Int("nz.CherryCount", 0) + 1)
		ply:SetNW2Float("nz.CherryDelay", CurTime() + 10)

		if IsFirstTimePredicted() then
			ParticleEffectAttach("nz_perks_cherry", PATTACH_ABSORIGIN_FOLLOW, ply, 0)
			ply:EmitSound("NZ.Cherry.Shock")
			if ply:HasUpgrade("cherry") or proc >= 1 then
				ply:EmitSound("NZ.Cherry.Sweet")
			end
		end

		if SERVER then
			timer.Simple(scale, function()
				if not IsValid(ply) then return end
				ply:StopParticles()

				if count and count >= 12 then
					if not ply.bo3cherryachv and TFA.BO3GiveAchievement then
						TFA.BO3GiveAchievement("A Burst of Flavor", "vgui/overlay/achievment/cherry.png", ply)
						ply.bo3cherryachv = true
					end
				end
			end)
		end
	end
end)

if CLIENT then
	local zmhud_icon_headshot = Material("nz_moo/icons/hud_headshoticon.png", "smooth unlitgeneric")
	local zmhud_icon_marker = Material("nz_moo/icons/marker.png", "smooth unlitgeneric")
	local zmhud_overlay_stink = Material("nz_moo/overlay/i_vulture_hud_glow_stink.png", "smooth unlitgeneric")

	local blur_mat = Material("pp/bokehblur")
	local function MyDrawBokehDOF(fac)
		render.UpdateScreenEffectTexture()
		render.UpdateFullScreenDepthTexture()
		blur_mat:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
		blur_mat:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())
		blur_mat:SetFloat("$size", fac * 4)
		blur_mat:SetFloat("$focus", 1)
		blur_mat:SetFloat("$focusradius", 10*fac)
		render.SetMaterial(blur_mat)
		render.DrawScreenQuad()
	end

	local vulture_tab = {
		["$pp_colour_addr"] = 0.05,
		["$pp_colour_addg"] = 0.2,
		["$pp_colour_addb"] = 0.0,
		["$pp_colour_brightness"] = 0.0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}

	local easy_tab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}

	local nz_preview = GetConVar("nz_creative_preview")
	local stinkfade = 0
	local AGH_MY_EYES = false
	local THX_SOUND_FX = 0
	local b_nochrome = false

	local function ScreenEffects()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local b_nopower = !nzElec:IsOn() and !nzRound:InState(ROUND_CREATE)

		if nzMapping.Settings.monochrome and b_nopower then
			if nzMapping.Settings.blurpoweron and !AGH_MY_EYES then
				AGH_MY_EYES = true
				THX_SOUND_FX = 1
			end

			DrawColorModify(easy_tab)
		elseif nzMapping.Settings.blurpoweron and b_nopower then
			if !AGH_MY_EYES then
				AGH_MY_EYES = true
				THX_SOUND_FX = 1
				b_nochrome = true
			end
		elseif AGH_MY_EYES then
			if THX_SOUND_FX > 0 then
				THX_SOUND_FX = math.max(THX_SOUND_FX - FrameTime()*0.65, 0)
			end

			easy_tab["$pp_colour_contrast"] = math.Remap(THX_SOUND_FX, 0, 1, 1, 1.5)
			easy_tab["$pp_colour_colour"] = b_nochrome and 1 or math.min(1, math.Remap(1 - (1*THX_SOUND_FX), 0, 1, 0, 1.5))

			if THX_SOUND_FX <= 0 then
				AGH_MY_EYES = false
				b_nochrome = false
			end

			DrawColorModify(easy_tab)

			if !AGH_MY_EYES then
				easy_tab["$pp_colour_contrast"] = 1
				easy_tab["$pp_colour_colour"] = 0
			end
			MyDrawBokehDOF(math.Remap(THX_SOUND_FX, 0, 1, 0, 1.5))
		end

		if !ply:ShouldDrawHUD() then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if ply:HasVultureStink() then
			stinkfade = math.Approach(stinkfade, 1, FrameTime()*6)
		end

		if stinkfade > 0 then
			vulture_tab["$pp_colour_addr"] = 0.05*stinkfade
			vulture_tab["$pp_colour_addg"] = 0.2*stinkfade
			vulture_tab["$pp_colour_colour"] = 1 + (0.1*stinkfade)

			DrawColorModify(vulture_tab)

			surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))
			surface.SetMaterial(zmhud_overlay_stink)
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

			stinkfade = math.max(stinkfade - math.min(FrameTime()*4, engine.TickInterval()*5), 0)
		end

		if ply:HasPerkBlur() then
			MyDrawBokehDOF(ply:PerkBlurIntensity())
		end
	end

	local function ElementalHUD()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if !ply:ShouldDrawHUD() then return end
		if !ply:ShouldDrawGunHUD() then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if ply:HasPerk("pop") then
			local fadefac = 0
			local PopDelay = ply:GetNW2Float("nz.EPopDecay", 0)
			local PopEffect = ply:GetNW2Int("nz.EPopEffect", 1)

			if PopDelay > CurTime() then
				fadefac = PopDelay - CurTime()
				fadefac = math.Clamp(fadefac / 2, 0, 1)
			end

			if fadefac > 0 then
				surface.SetMaterial(nzPerks.EPoPIcons[PopEffect])
				surface.SetDrawColor(ColorAlpha(color_white, 300*fadefac))
				surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 128)
			end
		end

		if ply:HasPerk("deadshot") then
			local fadefac = 0
			local notifdelay = ply:GetNW2Float("nz.DeadshotDecay", 0)
			if notifdelay > CurTime() then
				fadefac = notifdelay - CurTime()
				fadefac = math.Clamp(fadefac / 1, 0, 1)
			end

			if fadefac > 0 then
				surface.SetMaterial(zmhud_icon_headshot)
				surface.SetDrawColor(ColorAlpha(color_white, 300*fadefac))
				surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 128)
			end
		end
	end

	local PixVis = {}
	hook.Add('OnEntityCreated', 'nzSetupDeathVis', function(ent)
		if IsValid(ent) and ent:IsValidZombie() then
			PixVis[ent] = util.GetPixelVisibleHandle()
		end
	end)

	local color_red = Color(255, 0, 0, 255)
	local dim = Material( "sprites/splodesprite" )

	local function DeathHalo()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if !ply:ShouldDrawHUD() then return end
		if !ply:ShouldDrawPerksHUD() then return end

		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if not ply:HasPerk("death") then return end

		local pos = ply:GetPos()
		local range = 160000 //400^2
		local tooclose = 784 //28^2

		for i, ent in nzLevel.GetZombieArray() do
			if not IsValid(ent) then continue end
			if ent:IsValidZombie() and ent:Alive() and ent:GetCreationTime() + engine.TickInterval() < CurTime() then
				local epos = ent:GetPos()
				local dist = pos:DistToSqr(epos)
				if dist > range then continue end
				if dist < 784 then continue end

				local ang = ply:EyeAngles()
				local dir = Angle(0,ang.yaw,ang.roll):Forward()
				local facing = (epos - pos):GetNormalized()

				if facing:Dot(dir) > 0.45 then
					local fac = 1 - math.Clamp(dist / range, 0, 1)
					local visible = util.PixelVisible(ent:WorldSpaceCenter(), 26, PixVis[ent])

					if visible <= 0 then
						if not ent.pixrendertime then //this is hacky
							ent.pixrendertime = CurTime() + 0.1
							continue
						end

						if ent.pixrendertime and ent.pixrendertime > CurTime() then continue end

						halo.Add({[1] = ent}, ColorAlpha(color_red, 300*fac), 2*fac, 2*fac, 2, true, true)
					end
				end
			end
		end
	end

	/*local function DeathLungeHUD(bdepth, bskybox)
		//if not cl_drawhud:GetBool() then return end
		if bskybox then return end

		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if not ply:HasPerk("death") then return end
		if not ply.GetKnifingTarget then return end

		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) or not wep.CanKnifeLunge then return end

		local ent = ply:GetKnifingTarget()
		if not IsValid(ent) then return end

		if ent:IsValidZombie() and ent:Alive() then
			local render_ang = EyeAngles()
			render_ang:RotateAroundAxis(render_ang:Right(), 90)
			render_ang:RotateAroundAxis(-render_ang:Up(), 90)

			local size = ScreenScale(24)
			local pos = ent:WorldSpaceCenter()
			local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
			if !headbone then headbone = ent:LookupBone("j_neck") end
			if headbone then
				pos = ent:GetBonePosition(headbone)
			end

			cam.Start3D2D(pos, render_ang, 0.24)
				cam.IgnoreZ(true)
				surface.SetMaterial(zmhud_icon_marker)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(-(size)/2, -(size)/2, size, size)
				cam.IgnoreZ(false)
			cam.End3D2D()
		end
	end*/

	hook.Add("PreDrawHalos", "nzDeathHalo", DeathHalo ) 
	hook.Add("RenderScreenspaceEffects", "nzscreeneffectsHUD", ScreenEffects )
	//hook.Add("PostDrawTranslucentRenderables", "nzDeathKnifeHUD", DeathLungeHUD )
	hook.Add("HUDPaint", "elementalHUD", ElementalHUD)
end
