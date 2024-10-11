local sp = game.SinglePlayer()

local function TimerEnd(ply, gumid)
	local gum = nzGum:GetData(gumid)
	if gum.ontimerend then
		gum.ontimerend(ply)
	end

	if gum.revert then
		nzGum:RevertToAllWeaponsGumModifier(ply)
	end

	net.Start("nz_GumTimerEnd")
	net.Send(ply)
	ply:SetNWBool("nz_GumTimerProceed", false)
end

local function StartTimer(ply, gumid)
	local gum = nzGum:GetData(gumid)
	if gum.ontimerstart then
		gum.ontimerstart(ply)
	end

	timer.Create("nzGumTimer_" .. gumid .. "_" .. ply:EntIndex(), gum.time, 1, function()
		if IsValid(ply) then
			nzGum:TakeUses(ply)
			TimerEnd(ply, gumid)
		end
	end)

	net.Start("nz_GumTimerStart")
	net.WriteFloat(0)
	net.Send(ply)
	ply:SetNWBool("nz_GumTimerProceed", true)
end

function nzGum:SetActiveGum(ply, gumid)
	local gumdata = nzGum:GetData(gumid)
	if !gumdata then
		return
	end

	nzGum:EraseGum(ply)
	ply:SetNWString("nzCurrentGum", gumid)

	if gumdata.type == nzGum.Types.USABLE or gumdata.type == nzGum.Types.USABLE_WITH_TIMER or (gumdata.type == nzGum.Types.SPECIAL and gumdata.uses) then
		nzGum:SetUses(ply, gumdata.uses)
	elseif gumdata.type == nzGum.Types.ROUNDS then
		nzGum:SetRoundsRemain(ply, gumdata.rounds)
		if gumdata.modifier then
			nzGum:ApplyToAllWeaponsGumModifier(ply)
		end
	elseif gumdata.type == nzGum.Types.TIME then
		StartTimer(ply, gumid)
		if gumdata.modifier then
			nzGum:ApplyToAllWeaponsGumModifier(ply)
		end
	end

	if gumdata.ongain then
		gumdata.ongain(ply)
	end
end

function nzGum:GetActiveGum(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local gum = ply:GetNWString("nzCurrentGum", "")
	if !gum or gum == "" then
		return
	end
	return gum
end

function nzGum:GetActiveGumData(ply)
	local gum = nzGum:GetActiveGum(ply)
	if !gum then return end

	return nzGum.Gums[gum]
end

function nzGum:RemoveActiveGum(ply)
	ply:SetNWString("nzCurrentGum", "")
end

function nzGum:GetGumRare(gumid)
	local gum = nzGum.Gums[gumid]
	if !gum then return end

	return gum.rare or nzGum.RareTypes.DEFAULT
end

function nzGum:CanUse(ply)
	local gumdata = nzGum:GetActiveGumData(ply)
	if !gumdata then
		return false
	end

	if gumdata.type == nzGum.Types.SPECIAL and gumdata.uses then
		return false
	end

	if gumdata.type == nzGum.Types.ROUNDS then
		return false
	end

	if gumdata.type == nzGum.Types.TIME then
		return false
	end

	if !ply:Alive() or !ply:GetNotDowned() or ply:GetUsingSpecialWeapon() then
		if CLIENT then
			nzGum:DenyNotifcation()
		end
		return false
	end

	if gumdata.canuse and !gumdata.canuse(ply) then
		if CLIENT then
			nzGum:DenyNotifcation()
		end
		return false
	end

	local wep = ply:GetActiveWeapon()
	local gum_chewer = (IsValid(wep) and wep:GetClass() == "tfa_nz_bubble")

	return !ply.nzGum_isbubbling and nzGum:UsesRemain(ply) > 0 and !nzGum:IsWorking(ply) and !gum_chewer
end

function nzGum:UseGum(ply)
	if !nzGum:CanUse(ply) then return end
	local gumid = nzGum:GetActiveGum(ply)
	local gum = nzGum:GetActiveGumData(ply)

	ply:Give("tfa_nz_bubble")
	ply.nzGum_isbubbling = true

	timer.Simple(1.2, function()
		if IsValid(ply) then
			ply.nzGum_isbubbling = false

			if gum.onuse then
				gum.onuse(ply)
			end

			if gum.type == nzGum.Types.USABLE then
				nzGum:TakeUses(ply)
			elseif gum.type == nzGum.Types.USABLE_WITH_TIMER then
				StartTimer(ply, gumid)

				if gum.modifier then
					nzGum:ApplyToAllWeaponsGumModifier(ply)
				end
			elseif gum.type == nzGum.Types.ROUNDS then
				// it cant be
			end
		end
	end)
end

function nzGum:EraseGum(ply, gumid)
	gumid = gumid or nzGum:GetActiveGum(ply)

	local gumdata = gumid and nzGum:GetData(gumid)
	if !gumdata then
		gumdata = nzGum:GetActiveGumData(ply)
	end
	if !gumdata then
		return
	end
	if gumdata.onerase then
		gumdata.onerase(ply)
	end

	local timername = "nzGumTimer_" .. gumid .. "_" .. ply:EntIndex()
	if timer.Exists(timername) then
		TimerEnd(ply, gumid)
		timer.Remove(timername)
	end

	if gumdata.revert then
		nzGum:RevertToAllWeaponsGumModifier(ply)
	end

	nzGum:RemoveActiveGum(ply)
	nzGum:SetRoundsRemain(ply, -1)
	nzGum:SetUses(ply, -1)
end

---------------------------------------------------------------------- ROUNDS
---------------------------------------------------------------------- ROUNDS
function nzGum:SetRoundsRemain(ply, rounds)
	ply:SetNWInt("nzCurrentGum_RoundsRemain", rounds)
end

function nzGum:RoundsRemain(ply)
	local rounds = ply:GetNWInt("nzCurrentGum_RoundsRemain", 0)
	if rounds < 0 then
		return 0
	end
	return rounds
end

function nzGum:IsRoundBaseGum(ply)
	local gum = nzGum:GetActiveGumData(ply)
	if !gum then
		return false
	end
	return gum.type == nzGum.Types.ROUNDS
end
---------------------------------------------------------------------- ROUNDS
---------------------------------------------------------------------- ROUNDS


---------------------------------------------------------------------- TIMERS
---------------------------------------------------------------------- TIMERS
function nzGum:TimerTimeLeft(ply)
	local gumid = nzGum:GetActiveGum(ply)
	if !gumid then
		return 0
	end
	if CLIENT then
		return ply.nz_gum_timerstart or 0
	end
	return timer.TimeLeft("nzGumTimer_" .. gumid .. "_" .. ply:EntIndex()) or 0
end

function nzGum:IsWorking(ply)
	local gum = nzGum:GetActiveGumData(ply)
	if !gum then
		return false
	end

	if gum.type == nzGum.Types.ROUNDS then
		return nzGum:RoundsRemain(ply) > 0
	end

	if gum.type == nzGum.Types.USABLE_WITH_TIMER then
		return ply:GetNWBool("nz_GumTimerProceed", false)
	end

	return false
end
---------------------------------------------------------------------- TIMERS
---------------------------------------------------------------------- TIMERS

---------------------------------------------------------------------- USES
---------------------------------------------------------------------- USES
function nzGum:SetUses(ply, uses)
	ply:SetNWInt("nzCurrentGum_UsesRemain", uses)
end

function nzGum:TakeUses(ply)
	local gum = nzGum:GetActiveGum(ply)
	if !gum then return end
	local uses = nzGum:UsesRemain(ply)
	if uses < 0 then
		nzGum:EraseGum(ply)
		return
	end
	uses = uses - 1
	nzGum:SetUses(ply, uses)

	if uses <= 0 then
		nzGum:EraseGum(ply)
	end
end

function nzGum:UsesRemain(ply)
	local uses = ply:GetNWInt("nzCurrentGum_UsesRemain", 0)
	if uses < 0 then
		return 0
	end
	return uses
end

function nzGum:IsUseBaseGum(ply)
	local gum = nzGum:GetActiveGumData(ply)
	if !gum then
		return false
	end

	local gum_usetypes = {
		[nzGum.Types.USABLE_WITH_TIMER] = true,
		[nzGum.Types.USABLE] = true,
	}

	return gum_usetypes[gum.type] or (gum.type == nzGum.Types.SPECIAL and gum.uses)
end
---------------------------------------------------------------------- USES
---------------------------------------------------------------------- USES

if SERVER then
	util.AddNetworkString("nz_UseGum")

	hook.Add("OnRoundInit", "nzGums", function()
		nzGum:RebuildRollCounts()

		local gums = {}
		for id, data in pairs(nzGum.RollData) do
			gums[id] = data.count
		end

		print("Gobble Gums for this Match:")
		PrintTable(gums)
	end)

	hook.Add("OnRoundStart", "nz_GumCostReset", function(num)
		for id, data in pairs(nzGum.RollData) do
			local gumdata = nzGum.Gums[id]
			if !gumdata then continue end

			local roll_updated = false
			local rarity = nzGum:GetGumRare(id)

			local max = nzGum.RollCounts[rarity]
			if nzMapping.Settings.gumlist and nzMapping.Settings.gumlist[id] then
				max = nzMapping.Settings.gumlist[id][2]
			end

			local roll_reset = nzGum.RollCountResetRounds[rarity]
			if nzMapping.Settings.gumcountresetrounds then
				roll_reset = nzMapping.Settings.gumcountresetrounds[rarity]
			end

			if (data.count < max) and (data.roundgotin + roll_reset) <= num then
				roll_updated = true

				local old_count = data.count
				nzGum.RollData[id].count = max
				nzGum.RollData[id].roundgotin = 0

				nzGum:UpdateTotalCount(nzGum:GetTotalCount() + (max - old_count))

				print("Reset '"..gumdata.name.."' gum count to: "..max.." from: "..old_count)
			end

			local chance_reset = (nzMapping.Settings.gumchanceresetrounds or nzGum.RollChanceResetRounds)
			if data.chance < nzGum.RollChance and num%(chance_reset) == 0 then
				roll_updated = true

				print("Reset '"..gumdata.name.."' gum chance to: "..nzGum.RollChance.." from: "..nzGum.RollData[id].chance)
				nzGum.RollData[id].chance = nzGum.RollChance
			end

			if roll_updated then
				if nzGum:GetTotalCount() > 0 then
					for k, v in pairs(ents.FindByClass("nz_gummachine")) do
						if v.GumsEmpty then
							v:RefillGums()
						end
					end
				end
				nzGum:SendRollSync(id)
			end
		end

		for _, ply in pairs(player.GetAll()) do
			if !IsValid(ply) then continue end
			nzGum:ResetTotalBuys(ply)
			nzGum:SetPlayerPriceMultiplier(ply, 0)
		end
	end)

	hook.Add("OnRoundEnd", "nzGums", function()
		nzGum:UpdateTotalCount(0)
		nzGum:SendRollResetSync()
		for k, v in pairs(ents.FindByClass("nz_gummachine")) do
			if v.GumsEmpty then
				v:RefillGums()
			end
		end

		for _, ply in pairs(player.GetAll()) do
			nzGum:EraseGum(ply)
			nzGum:ResetTotalBuys(ply)
			nzGum:SetPlayerPriceMultiplier(ply, 0)
		end
	end)

	hook.Add("OnPlayerDropOut", "nzGums", function(ply)
		nzGum:EraseGum(ply)
	end)

	hook.Add("PlayerSpawn", "nzGumEraser", function(ply)
		local gumdata = nzGum:GetActiveGumData(ply)
		if gumdata and gumdata.donteraseonspawn then
			return
		end
		nzGum:EraseGum(ply)
	end)

	hook.Add("OnRoundPreparation", "nzGums", function()
		for _, ply in pairs(player.GetAllPlaying()) do
			if ply:Alive() then
				local gum = nzGum:GetActiveGumData(ply)

				if !gum then continue end

				if gum.type != nzGum.Types.ROUNDS then continue end

				local rounds = nzGum:RoundsRemain(ply)
				if rounds <= 0 then
					nzGum:EraseGum(ply)
					continue
				end
				rounds = rounds - 1
				nzGum:SetRoundsRemain(ply, rounds)
				if rounds <= 0 then
					nzGum:EraseGum(ply)
					continue
				end
			end
		end
	end)

	net.Receive("nz_UseGum", function(len, ply)
		nzGum:UseGum(ply)
	end)

	util.AddNetworkString("nz_GumTimerStart")
	util.AddNetworkString("nz_GumTimerEnd")
	util.AddNetworkString("nz_GumDenyNotif")

	if sp then //uh oh singleplayer stinky
		hook.Add("PlayerButtonDown", "nzGumActivate", function(ply, but)
			if but == ply:GetInfoNum("nz_key_gum", KEY_4) then
				if nzGum:CanUse(ply) then
					nzGum:UseGum(ply)
				elseif (!ply.LastGumDeny or ply.LastGumDeny + 0.5 < CurTime()) then
					ply.LastGumDeny = CurTime()
					local msg = "nzGum:CanUse(Entity("..ply:EntIndex().."))"
					ply:SendLua(msg)
				end
			end
		end)
	end
else
	net.Receive("nz_GumTimerStart", function(len, _)
		local ply = LocalPlayer()
		local timedelay = net.ReadFloat()
		ply.nz_gum_timerstart = CurTime() - timedelay
	end)

	net.Receive("nz_GumTimerEnd", function(len, _)
		local ply = LocalPlayer()
		ply.nz_gum_timerstart = nil
	end)

	CreateClientConVar("nz_key_gum", KEY_4, true, true, "Sets the key that activates your currently held Gum. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")

	hook.Add("PlayerButtonDown", "nzGumActivate", function(ply, but)
		local ply = LocalPlayer()
		if but == ply:GetInfoNum("nz_key_gum", KEY_4) and nzGum:CanUse(ply) then
			net.Start("nz_UseGum")
			net.SendToServer()
		end
	end)

	/*hook.Add("PlayerBindPress", "nzGumActivate", function( ply, bind, pressed )
		if string.find( bind, "slot4" ) and nzGum:CanUse(ply) then
			net.Start("nz_UseGum")
			net.SendToServer()
		end
	end)*/
end
