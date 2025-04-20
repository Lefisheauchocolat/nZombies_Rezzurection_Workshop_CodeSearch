--[[Example
nzTrials:NewTrial("unique_trial_id", {
	name = "trial name", //generic name for the tool dropdown list
	default = bool, //only set to true if trial is possible on *all* configs
	coop = bool, //set to true for trial to only be active in multiplayer
	hudicon = Material("path/to/icon.png", "unlitgeneric smooth"), //not required, functionality will be added later
	start = function(self, ply) //called on game start
	end,
	reset = function(self, ply) //called on game end to clean up everything for next match
	end,
	text = function(self) //short description of how to do the trial
		return "trial description"
	end,
})
]]--

nzTrials:NewTrial("foxtrial_1", {
	name = "Spend 30,000 points",
	default = true,
	start = function()
		if CLIENT then return end
		hook.Add("OnPlayerLosePoints", "nz.foxtrial_1", function(ply, amount)
			if not (IsValid(ply) and ply:HasTrial("foxtrial_1") and not ply:GetTrialCompleted("foxtrial_1")) then return end

			if not ply.foxtrial_1points then ply.foxtrial_1points = 0 end
			ply.foxtrial_1points = ply.foxtrial_1points + amount

			if ply.foxtrial_1points >= 30000 then
				ply:SetTrialCompleted("foxtrial_1")
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnPlayerLosePoints", "nz.foxtrial_1")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_1points = 0
		end

		return true
	end,
	text = function(self)
		return "Spend 30,000 points"
	end,
})

nzTrials:NewTrial("foxtrial_2", {
	name = "Get 115 headshots",
	default = true,
	start = function()
		if CLIENT then return end
		hook.Add("OnZombieKilled", "nz.foxtrial_2", function(ent, dmginfo)
			local ply = dmginfo:GetAttacker()
			if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_2") and not ply:GetTrialCompleted("foxtrial_2")) then return end
			local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup

			if (hitgroup and hitgroup == HITGROUP_HEAD) or (ent.GetDecapitated and ent:GetDecapitated()) then
				if not ply.foxtrial_2kills then ply.foxtrial_2kills = 0 end
				ply.foxtrial_2kills = ply.foxtrial_2kills + 1

				if ply.foxtrial_2kills >= 115 then
					ply:SetTrialCompleted("foxtrial_2")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnZombieKilled", "nz.foxtrial_2")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_2kills = 0
		end

		return true
	end,
	text = function(self)
		return "Get 115 headshots"
	end,
})

nzTrials:NewTrial("foxtrial_3", {
	name = "PaP 4 different guns",
	start = function()
		if CLIENT then return end
		hook.Add("OnPlayerBuyPackAPunch", "nz.foxtrial_3", function(ply, wep)
			if not (IsValid(wep) and IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_3") and not ply:GetTrialCompleted("foxtrial_3")) then return end

			if not ply.foxtrial_3guns then ply.foxtrial_3guns = {} end
			if not table.HasValue(ply.foxtrial_3guns, wep:GetClass()) then
				table.insert(ply.foxtrial_3guns, wep:GetClass())
			end

			if #ply.foxtrial_3guns >= 4 then
				ply:SetTrialCompleted("foxtrial_3")
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnPlayerBuyPackAPunch", "nz.foxtrial_3")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_3guns = {}
		end

		return true
	end,
	text = function(self)
		return "Pack a' Punch 4 different weapons"
	end,
})

nzTrials:NewTrial("foxtrial_4", {
	name = "Take 1000 damage without going down",
	default = true,
	start = function()
		if CLIENT then return end
		hook.Add("PlayerDowned", "nz.foxtrial_4", function(ply)
			if ply:HasTrial("foxtrial_4") and not ply:GetTrialCompleted("foxtrial_4") then
				ply.foxtrial_4damage = 0
			end
		end)

		hook.Add("PostEntityTakeDamage", "nz.foxtrial_4", function(ply, dmginfo, took)
			if took and ply:IsPlayer() and ply:HasTrial("foxtrial_4") and not ply:GetTrialCompleted("foxtrial_4") then
				if not ply.foxtrial_4damage then ply.foxtrial_4damage = 0 end
				ply.foxtrial_4damage = ply.foxtrial_4damage + dmginfo:GetDamage()

				if ply.foxtrial_4damage >= 1000 then
					ply:SetTrialCompleted("foxtrial_4")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("PlayerDowned", "nz.foxtrial_4")
		hook.Remove("PostEntityTakeDamage", "nz.foxtrial_4")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_4damage = 0
		end

		return true
	end,
	text = function(self)
		return "Take 1000 damage without going down"
	end,
})

nzTrials:NewTrial("foxtrial_5", {
	name = "Get 35 headshots during special rounds",
	start = function()
		if CLIENT then return end
		hook.Add("OnZombieKilled", "nz.foxtrial_5", function(ent, dmginfo)
			if not (nzRound and nzRound:InProgress() and nzRound:IsSpecial()) then return end
			local ply = dmginfo:GetAttacker()
			if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_5") and not ply:GetTrialCompleted("foxtrial_5")) then return end
			local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup

			if (hitgroup and hitgroup == HITGROUP_HEAD) or (ent.GetDecapitated and ent:GetDecapitated()) then
				if not ply.foxtrial_5kills then ply.foxtrial_5kills = 0 end
				ply.foxtrial_5kills = ply.foxtrial_5kills + 1

				if ply.foxtrial_5kills >= 35 then
					ply:SetTrialCompleted("foxtrial_5")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnZombieKilled", "nz.foxtrial_5")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_5kills = 0
		end

		return true
	end,
	text = function(self)
		return "Get 35 headshots during special rounds"
	end,
})

nzTrials:NewTrial("foxtrial_6", {
	name = "Spend 2 rounds camping nearby any Perk Machine without leaving",
	start = function()
		if CLIENT then return end

		local perkmachines = {
			["perk_machine"] = true,
			["wunderfizz_machine"] = true,
		}

		local function CreateTrialRing(ply, pos)
			local ring = ents.Create("nz_trialplayerwatcher")
			ring:SetModel("models/dav0r/hoverball.mdl")
			ring:SetNoDraw(true)
			ring:SetPos(pos)
			ring:SetOwner(ply)
			ring:SetRadius(450) //min of 50, max of 900

			ring:Spawn()
			ring:SetOwner(ply)

			ring:CallOnRemove("nz.foxtrial_6", function(ent)
				local ply = ent:GetOwner()
				if IsValid(ply) then
					if ply.foxtrial_6round and ply.foxtrial_6round > 0 then
						ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
					end
					ply.foxtrial_6round = 0
				end
			end)

			ply.foxtrial_6round = ply.foxtrial_6round + 1
			ply.foxtrial_6ring = ring
		end

		hook.Add("OnRoundStart", "nz.foxtrial_6", function()
			if nzRound:GetNumber() <= 8 then return end

			for _, ply in ipairs(player.GetAll()) do
				if ply:HasTrial("foxtrial_6") and not ply:GetTrialCompleted("foxtrial_6") then
					if not ply.foxtrial_6round then ply.foxtrial_6round = 0 end
					if IsValid(ply.foxtrial_6ring) then
						ply.foxtrial_6round = ply.foxtrial_6round + 1

						if ply.foxtrial_6round > 2 then
							ply:SetTrialCompleted("foxtrial_6")

							if ply.foxtrial_6ring and IsValid(ply.foxtrial_6ring) then
								ply.foxtrial_6ring:RemoveCallOnRemove("nz.foxtrial_6")
								ply.foxtrial_6ring:Remove()
								ply.foxtrial_6ring = nil
							end
						end
					else
						for k, v in nzLevel.GetVultureArray() do
							if not (IsValid(v) and perkmachines[v:GetClass()]) then continue end
							if v.IsOn and not v:IsOn() then continue end
							if ply:GetPos():DistToSqr(v:GetPos()) > 202500 then continue end

							CreateTrialRing(ply, v:GetPos() + v:GetUp())
							break
						end
					end
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnRoundStart", "nz.foxtrial_6")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_6round = 0
			ply.foxtrial_6ring = nil
		end
		for k, v in pairs(ents.FindByClass("nz_trialplayerwatcher")) do
			v:RemoveCallOnRemove("nz.foxtrial_6")
			v:Remove()
		end

		return true
	end,
	text = function(self)
		return "After round 8, start and finish 2 rounds camping at any active Perk Machine without leaving"
	end,
})

nzTrials:NewTrial("foxtrial_7", {
	name = "Kill a boss zombie in 12 seconds",
	start = function()
		if CLIENT then return end

		hook.Add("OnEntityCreated", "nz.foxtrial_7", function(ent)
			if string.find(ent:GetClass(), "nz_zombie_boss") then
				local plys = {}
				for _, ply in ipairs(player.GetAll()) do
					if ply:HasTrial("foxtrial_7") and not ply:GetTrialCompleted("foxtrial_7") then
						table.insert(plys, ply)
					end
				end

				if table.IsEmpty(plys) then return end

				if table.Count(plys) > 1 then
					table.sort(plys, function(a, b) return a:GetPos():DistToSqr(ent:GetPos()) < b:GetPos():DistToSqr(ent:GetPos()) end)
				end

				local ratio = math.Clamp(plys[1]:GetPos():Distance(ent:GetPos()) / 2048, 0, 1)
				ent.nzfreebietime = 4*ratio
			end
		end)

		hook.Add("OnBossKilled", "nz.foxtrial_7", function(ent)
			local killtime = 12
			if ent.nzfreebietime then
				killtime = killtime + tonumber(ent.nzfreebietime)
			end

			if (ent:GetCreationTime() + killtime) > CurTime() then
				for _, ply in ipairs(player.GetAll()) do
					if ply:HasTrial("foxtrial_7") and not ply:GetTrialCompleted("foxtrial_7") then
						ply:SetTrialCompleted("foxtrial_7")
					end
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnBossKilled", "nz.foxtrial_7")
		hook.Remove("OnEntityCreated", "nz.foxtrial_7")

		return true
	end,
	text = function(self)
		return "Kill a boss zombie within 12 seconds of it spawning"
	end,
})

nzTrials:NewTrial("foxtrial_8", {
	name = "Kill 20 crawlers with melee",
	start = function()
		if CLIENT then return end
		hook.Add("OnZombieKilled", "nz.foxtrial_8", function(ent, dmginfo)
			local ply = dmginfo:GetAttacker()
			if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_8") and not ply:GetTrialCompleted("foxtrial_8")) then return end

			if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SLASH, DMG_CLUB, DMG_CRUSH, DMG_GENERIC)) ~= 0 and ent.GetCrawler and ent:GetCrawler() then
				if not ply.foxtrial_8kills then ply.foxtrial_8kills = 0 end
				ply.foxtrial_8kills = ply.foxtrial_8kills + 1

				if ply.foxtrial_8kills >= 20 then
					ply:SetTrialCompleted("foxtrial_8")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnZombieKilled", "nz.foxtrial_8")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_8kills = 0
		end

		return true
	end,
	text = function(self)
		return "Kill 20 crawler zombies with a melee weapon"
	end,
})

nzTrials:NewTrial("foxtrial_9", {
	name = "Dont let shield take damage",
	start = function()
		if CLIENT then return end
		hook.Add("OnRoundStart", "nz.foxtrial_9", function()
			if nzRound:GetNumber() <= 12 then return end

			for _, ply in ipairs(player.GetAll()) do
				if ply:HasTrial("foxtrial_9") and not ply:GetTrialCompleted("foxtrial_9") and IsValid(ply:GetShield()) then
					if not ply.foxtrial_9shield then
						ply.foxtrial_9shield = true
						ply:GetShield():CallOnRemove("nz.foxtrial_9", function(ent)
							local ply = ent:GetOwner()
							if IsValid(ply) and ply.foxtrial_9shield then
								ply.foxtrial_9shield = false
								timer.Simple(0.5, function()
									if not IsValid(ply) then return end
									ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
								end)
							end
						end)
					elseif ply.foxtrial_9shield then
						ply:GetShield():RemoveCallOnRemove("nz.foxtrial_9")
						ply.foxtrial_9shield = false
						ply:SetTrialCompleted("foxtrial_9")
					end
				end
			end
		end)

		hook.Add("PostEntityTakeDamage", "nz.foxtrial_9", function(ent, dmginfo, took)
			if took and ent.bIsShield then
				local ply = ent:GetOwner()
				if IsValid(ply) and ply:IsPlayer() and ply.foxtrial_9shield then
					ply.foxtrial_9shield = false
					ent:RemoveCallOnRemove("nz.foxtrial_9")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnRoundStart", "nz.foxtrial_9")
		hook.Remove("PostEntityTakeDamage", "nz.foxtrial_9")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_9shield = false
			if IsValid(ply:GetShield()) then
				ply:GetShield():RemoveCallOnRemove("nz.foxtrial_9")
			end
		end

		return true
	end,
	text = function(self)
		return "After round 12, start and finish a round without your shield taking damage"
	end,
})

nzTrials:NewTrial("foxtrial_10", {
	name = "Purchase every wallbuy",
	default = true,
	start = function()
		if CLIENT then return end

		local maxguns = 0
		for k, v in pairs(ents.FindByClass("wall_buys")) do
			if v.GetWepClass and v:GetWepClass() ~= "tfa_bo1_m67" then
				maxguns = maxguns + 1
			end
		end

		if IsValid(ents.FindByClass("wall_buys_blank")[1]) then
			maxguns = maxguns + #ents.FindByClass("wall_buys_blank")
		end

		hook.Add("OnPlayerBuy", "nz.foxtrial_10", function(ply, amount, ent, func)
			if not IsValid(ent) or ent:GetClass() ~= "wall_buys" then return nil end
			if not (IsValid(ply) and ply:HasTrial("foxtrial_10") and not ply:GetTrialCompleted("foxtrial_10")) then return nil end

			if not ply.foxtrial_10guns then ply.foxtrial_10guns = {} end
			if not table.HasValue(ply.foxtrial_10guns, ent:EntIndex()) then
				table.insert(ply.foxtrial_10guns, ent:EntIndex())
			end

			if #ply.foxtrial_10guns >= maxguns then
				ply:SetTrialCompleted("foxtrial_10")
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnPlayerBuy", "nz.foxtrial_10")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_10guns = {}
		end

		return true
	end,
	text = function(self)
		return "Purchase, or buy ammo for, every wall buy on the map once"
	end,
})

nzTrials:NewTrial("foxtrial_11", {
	name = "Complete 2 rounds without emptying a mag",
	default = true,
	start = function()
		if CLIENT then return end

		hook.Add("OnRoundStart", "nz.foxtrial_11", function(wep)
			if nzRound:GetNumber() <= 10 then return end

			for _, ply in ipairs(player.GetAll()) do
				if ply:HasTrial("foxtrial_11") and not ply:GetTrialCompleted("foxtrial_11") then
					if not ply.foxtrial_11round then ply.foxtrial_11round = 0 end
					ply.foxtrial_11round = ply.foxtrial_11round + 1

					if ply.foxtrial_11round > 2 then
						ply:SetTrialCompleted("foxtrial_11")
					end
				end
			end
		end)

		hook.Add("TFA_PostPrimaryAttack", "nz.foxtrial_11", function(wep)
			if CLIENT then return end
			if not IsValid(wep) then return end
			if nzRound and nzRound:GetNumber() <= 10 then return end
			local ply = wep:GetOwner()
			if not (IsValid(ply) and ply:IsPlayer()) then return end
			if ply.foxtrial_11round and ply.foxtrial_11round <= 0 then return end

			local empty = false
			if wep:GetMaxClip1() > 0 then
				if wep:Clip1() <= 0 then
					empty = true
				end
			else
				if ply:GetAmmoCount(wep:GetPrimaryAmmoType()) <= 0 then
					empty = true
				end
			end
			if wep:GetMaxClip2() > 0 and wep:Clip2() <= 0 then
				empty = true
			end

			if empty and ply:HasTrial("foxtrial_11") and not ply:GetTrialCompleted("foxtrial_11") then
				if ply.foxtrial_11round and ply.foxtrial_11round > 1 then
					timer.Simple(0.5, function()
						if not IsValid(ply) then return end
						ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
					end)
				end
				ply.foxtrial_11round = 0
			end
		end)

		hook.Add("TFA_Reload", "nz.foxtrial_11", function(wep)
			if CLIENT then return end
			if not IsValid(wep) then return end
			if nzRound and nzRound:GetNumber() <= 10 then return end
			local ply = wep:GetOwner()
			if not (IsValid(ply) and ply:IsPlayer()) then return end
			if ply.foxtrial_11round and ply.foxtrial_11round <= 0 then return end

			if ((wep:GetMaxClip1() > 0 and wep:Clip1() <= 0) or (wep:GetMaxClip2() > 0 and wep:Clip2() <= 0)) and ply:HasTrial("foxtrial_11") and not ply:GetTrialCompleted("foxtrial_11") then
				if ply.foxtrial_11round and ply.foxtrial_11round > 1 then
					timer.Simple(0.5, function()
						if not IsValid(ply) then return end
						ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
					end)
				end
				ply.foxtrial_11round = 0
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnRoundStart", "nz.foxtrial_11")
		hook.Remove("TFA_PostPrimaryAttack", "nz.foxtrial_11")
		hook.Remove("TFA_Reload", "nz.foxtrial_11")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_11round = 0
		end

		return true
	end,
	text = function(self)
		return "After round 10, finish 2 rounds without letting your weapons magazine reach 0"
	end,
})

nzTrials:NewTrial("foxtrial_12", {
	name = "Complete 1 round each with only Snipers, only Shotguns, and only Pistols",
	start = function()
		if CLIENT then return end

		local shotguntypes = {
			["weapon"] = true, //failsafe for some shotgun types, can cause false positives but its the best i got
			["shotgun"] = true,
		}

		local snipertypes = {
			["designatedmarksmanrifle"] = true,
			["sniperrifle"] = true,
			["dmr"] = true,
		}

		local pistoltypes = {
			["handgun"] = true,
			["pistol"] = true,
			["dualpistols"] = true,
			["machinepistol"] = true,
			["handcannon"] = true,
			["revolver"] = true,
			["dualrevolvers"] = true,
		}

		hook.Add("OnRoundStart", "nz.foxtrial_12", function()
			if nzRound and nzRound:GetNumber() <= 6 then return end
			for _, ply in ipairs(player.GetAll()) do
				if ply:HasTrial("foxtrial_12") and not ply:GetTrialCompleted("foxtrial_12") then
					if ply.foxtrial_12lock1 then ply.foxtrial_12lock1 = false end
					if ply.foxtrial_12lock2 then ply.foxtrial_12lock2 = false end
					if ply.foxtrial_12lock3 then ply.foxtrial_12lock3 = false end
					if ply.foxtrial_12type1 then
						ply.foxtrial_12finish1 = true
						ply.foxtrial_12type1 = false
					end
					if ply.foxtrial_12type2 then
						ply.foxtrial_12finish2 = true
						ply.foxtrial_12type2 = false
					end
					if ply.foxtrial_12type3 then
						ply.foxtrial_12finish3 = true
						ply.foxtrial_12type3 = false
					end

					if ply.foxtrial_12finish1 and ply.foxtrial_12finish2 and ply.foxtrial_12finish3 then
						ply:SetTrialCompleted("foxtrial_12")
					end
				end
			end
		end)

		hook.Add("OnZombieKilled", "nz.foxtrial_12", function(ent, dmginfo)
			if nzRound and nzRound:GetNumber() <= 6 then return end
			local ply = dmginfo:GetAttacker()
			local wep = dmginfo:GetInflictor()
			if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_12") and not ply:GetTrialCompleted("foxtrial_12")) then return end
			if not (IsValid(wep) and wep.IsTFAWeapon) then return end

			local t1, t2 = wep:GetType():lower():gsub("[^%w]+", ""), (wep:GetStatRawL("Type_Displayed") or ""):lower():gsub("[^%w]+", "")

			if (shotguntypes[t2] or shotguntypes[t1]) and not ply.foxtrial_12finish1 then
				if not ply.foxtrial_12lock1 then
					ply.foxtrial_12type1 = true
					ply.foxtrial_12lock1 = true
				end
			else
				ply.foxtrial_12lock1 = true
				if ply.foxtrial_12type1 then
					ply.foxtrial_12type1 = false
				end
			end

			if (snipertypes[t2] or snipertypes[t1]) and not ply.foxtrial_12finish2 then
				if not ply.foxtrial_12lock2 then
					ply.foxtrial_12type2 = true
					ply.foxtrial_12lock2 = true
				end
			else
				ply.foxtrial_12lock2 = true
				if ply.foxtrial_12type2 then
					ply.foxtrial_12type2 = false
				end
			end

			if (pistoltypes[t2] or pistoltypes[t1]) and not ply.foxtrial_12finish3 then
				if not ply.foxtrial_12lock3 then
					ply.foxtrial_12type3 = true
					ply.foxtrial_12lock3 = true
				end
			else
				ply.foxtrial_12lock3 = true
				if ply.foxtrial_12type3 then
					ply.foxtrial_12type3 = false
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnZombieKilled", "nz.foxtrial_12")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_8kills = 0
		end

		return true
	end,
	text = function(self)
		return "After round 6, complete 1 round using only Snipers, 1 round using only Shotguns, and 1 round using only Pistols"
	end,
})

//wonder weapon system no worky :DDDDDDDDDDDD
/*nzTrials:NewTrial("foxtrial_13", {
	name = "[MP ONLY] Share a Wonder Weapon from the box to another Player",
	coop = true,
	start = function()
		if CLIENT then return end
		hook.Add("PlayerUse", "nz.foxtrial_13", function(ply, ent)
			if ent:GetClass() ~= "random_box_windup" then return end
			local ply1 = ent:GetBuyer()
			if not (IsValid(ply1) and ply1:IsPlayer() and ply1:HasTrial("foxtrial_13") and not ply1:GetTrialCompleted("foxtrial_13")) then return end

			if !ent:GetWinding() and ent:GetSharing() and nzWeps:IsWonderWeapon(ent:GetWepClass()) and ply:EntIndex() ~= ply1:EntIndex() then
				ply:SetTrialCompleted("foxtrial_13")
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("PlayerUse", "nz.foxtrial_13")

		return true
	end,
	text = function(self)
		return "Share a Wonder Weapon, that only one player can hold, from the Mystery Box to another Player"
	end,
})*/

nzTrials:NewTrial("foxtrial_14", {
	name = "Get 24 kills while airborne after using a Jump Pad",
	start = function()
		if CLIENT then return end
		hook.Add("OnZombieKilled", "nz.foxtrial_14", function(ent, dmginfo)
			local ply = dmginfo:GetAttacker()
			if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("foxtrial_14") and not ply:GetTrialCompleted("foxtrial_14")) then return end

			if ply.GetNZLauncher and IsValid(ply:GetNZLauncher())then
				if not ply.foxtrial_14kills then ply.foxtrial_14kills = 0 end
				ply.foxtrial_14kills = ply.foxtrial_14kills + 1

				if ply.foxtrial_14kills >= 24 then
					ply:SetTrialCompleted("foxtrial_14")
				end
			end
		end)

		return true
	end,
	reset = function()
		if CLIENT then return end
		hook.Remove("OnZombieKilled", "nz.foxtrial_14")
		for _, ply in ipairs(player.GetAll()) do
			ply.foxtrial_14kills = 0
		end

		return true
	end,
	text = function(self)
		return "Get 24 kills while airborne after using a Jump Pad"
	end,
})
