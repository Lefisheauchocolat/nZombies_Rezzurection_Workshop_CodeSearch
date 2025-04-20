-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local nzombies = engine.ActiveGamemode() == "nzombies"
local killamount_cvar = GetConVar("nz_difficulty_bo3_tacticalkills")

if nzombies then
	if SERVER then
		hook.Add("WeaponEquip", "BO3.NZ.WW.EquipStinger", function(wep, ply)
			local rayguns = {
				["tfa_bo3_raygun"] = true,
				["tfa_bo4_raygun"] = true,
				["tfa_bo3_mk2"] = true,
				["tfa_bo3_mk3"] = true,
				["tfa_bo4_mk2"] = true,
				["tfa_bo3_monkeybomb"] = true,
				["tfa_bo4_monkeybomb"] = true,
			}

			if rayguns[wep:GetClass()] and not wep.HasEmitEquipSound then
				wep.HasEmitEquipSound = true
				net.Start("TFA.BO3.QED_SND")
					net.WriteString("Raygun")
				net.Broadcast()
			end
		end)

		hook.Add("OnRoundStart", "BO3.NZ.WW.Hacker.Money", function()
			local round = tonumber(nzRound:GetNumber())

			for _, ply in ipairs(player.GetAll()) do
				local wep = ply:GetWeapon("tfa_bo3_hacker")

				if IsValid(wep) and wep.equipment_got_in_round then
					local rounds_kept = (round - wep.equipment_got_in_round)

					if round > 10 and rounds_kept > 0 then
						rounds_kept = math.min(rounds_kept, 5)
						local score = rounds_kept * 100
						ply:GivePoints(score)
					end

					break
				end
			end
		end)

		hook.Add("OnRoundEnd", "BO3.NZ.WW.Hacker.RoundEnd", function()
			if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
				for k, v in pairs(ents.FindByClass("nz_bo3_hacker")) do
					v:Remove()
				end

				for k, v in pairs(ents.FindByClass("wall_buys")) do
					if v.GetHacked and v:GetHacked() then
						local ang = v:GetAngles()
						ang:RotateAroundAxis(ang:Up(), 180)
						ang:RotateAroundAxis(ang:Right(), 180)
						v:SetAngles(ang)
						v:SetHacked(false)
					end
				end
			end
		end)
	end

	hook.Add("InitPostEntity", "BO3.NZ.WW.RegisterSpecials", function()
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_gstrike", 3, false, 1.4, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_monkeybomb", 3, false, 2, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_lilarnie", 3, false, 2, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_qed", 3, false, 1.1, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_gersch", 3, false, 1.7, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo3_matryoshka", 3, false, 1.4, false, 0.4 )

		nzSpecialWeapons:AddDisplay("tfa_nz_bo3_deathmachine", false, function(wep) return false end)
	end)

	hook.Add("PostConfigLoad", "BO3.NZ.WW.Hacker.Remove", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_bo3_hacker")) do
				v:Remove()
			end
		end
	end)

	hook.Add("OnGameBegin", "BO3.NZ.WW.Hacker.Spawn", function(nzRound)
		if not IsValid(ents.FindByClass("nz_bo3_hacker")[1]) then
			hook.Call("RespawnHackerDevice")
		end
	end)

	hook.Add("RespawnHackerDevice", "BO3.NZ.WW.Hacker.Respawn", function()
		if (nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO)) then return end

		local hacker_spawns = {}
		for _, v in pairs(ents.FindByClass("nz_bo3_hacker_spawn")) do
			table.insert(hacker_spawns, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
			})
		end
		if #hacker_spawns <= 0 then print("no hacker spawns found") return end

		print("The hacker has been removed from the game. Spawning it again.")

		local spawn = hacker_spawns[math.random(#hacker_spawns)]
		local hacker = ents.Create("nz_bo3_hacker")
		hacker:SetModel("models/weapons/tfa_bo3/hacker/hacker_prop.mdl")
		hacker:SetPos(spawn.pos)
		hacker:SetAngles(spawn.angle)
		hacker:Spawn()
	end)

	if SERVER then
		hook.Add("OnZombieKilled", "BO3.NZ.WW.KillIncrement", function(npc, dmginfo)
			if nzEnemies and nzEnemies.Updated then
				hook.Remove("OnZombieKilled", "BO3.NZ.WW.KillIncrement")
			end

			local ply = dmginfo:GetAttacker()
			local ent = dmginfo:GetInflictor()
			if not IsValid(npc) or not IsValid(ply) or not IsValid(ent) then return end
			if not ply:IsPlayer() then return end

			if not ent.NZTacticalPaP then return end

			for _, wep in pairs(ply:GetWeapons()) do
				local class = wep:GetClass()
				if wep.NZTacticalPaP and not wep:HasNZModifier("pap") then
					local tactkills = wep:GetNW2Int("nz.TactKills", 0)
					if tactkills < killamount_cvar:GetInt() then
						wep:SetNW2Int("nz.TactKills", tactkills + 1)
					elseif tactkills == killamount_cvar:GetInt() then
						net.Start("TFA.BO3.QED_SND")
							net.WriteString("MonkeyUpgrade")
						net.Send(ply)

						if nzWeps.Updated then
							wep:ApplyNZModifier("pap")
						else
							ply:StripWeapon(class)
							local wep2 = ply:Give(class)
							timer.Simple(0, function()
								if not IsValid(ply) or not IsValid(wep2) then return end
								wep2:ApplyNZModifier("pap")
							end)
						end
					end
				end
			end
		end)

		hook.Add("OnZombieKilled", "BO3.NZ.WW.Kill", function(ent, dmginfo)
			if not IsValid(ent) then return end
			local wep = dmginfo:GetInflictor()
			if IsValid(wep) and wep:GetClass() == "tfa_bo3_rocketshield" and wep:GetDashing() then
				wep:SetKillCount(wep:GetKillCount() + 1)
			end

			if ent:PanzerDGLifted() then
				for _, ply in pairs(player.GetAllPlaying()) do
					if not ply.bo3panzerdgkill and ply:GetPos():DistToSqr(ent:GetPos()) <= 3240000 then //1800 units
						TFA.BO3GiveAchievement("Not Big Enough", "vgui/overlay/achievment/panzer.png", ply)
						ply.bo3panzerdgkill = true
					end
				end
			end
		end)
	end
end
