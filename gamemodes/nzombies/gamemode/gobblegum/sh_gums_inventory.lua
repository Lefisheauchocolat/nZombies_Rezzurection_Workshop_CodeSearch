if SERVER then
	function nzGum:RebuildRollCounts()
		if not nzMapping or not nzMapping.Settings or not nzMapping.Settings.gumlist then return end

		nzGum:UpdateTotalCount(0)
		for id, data in pairs(nzMapping.Settings.gumlist) do
			if not data[1] then continue end

			nzGum.RollData[id] = {count = data[2], chance = nzGum.RollChance, roundgotin = 0}
			nzGum:UpdateTotalCount(nzGum:GetTotalCount() + tonumber(data[2]))
			nzGum:SendRollSync(id)
		end

		if nzGum:GetTotalCount() > 0 then
			for k, v in pairs(ents.FindByClass("nz_gummachine")) do
				if v.GumsEmpty then
					v:RefillGums()
				end
			end
		end
	end

	function nzGum:UpdateRollData(gumid)
		local rolldata = nzGum.RollData[gumid]
		if !rolldata then return end

		if !rolldata.roundgotin or (rolldata.roundgotin == 0) then
			rolldata.roundgotin = nzRound:GetNumber()
		end

		rolldata.chance = math.max((rolldata.chance or nzGum.RollChance) - 1, 1)
		rolldata.count = math.max((rolldata.count or nzGum.RollCounts[nzGum:GetGumRare(gumid)]) - 1, 0)

		nzGum:UpdateTotalCount(nzGum:GetTotalCount() - 1)
		nzGum:SendRollSync(gumid)
	end

	function nzGum:UpdateTotalCount(amount)
		SetGlobal2Int("nzGumsTotalCount", amount)
		nzGum.TotalGumCount = math.max(amount, 0)
	end

	function nzGum:GetTotalCount()
		return nzGum.TotalGumCount
	end

	util.AddNetworkString("nzGum.Sync")
	util.AddNetworkString("nzGum.FullSync")
	util.AddNetworkString("nzGum.ResetSync")

	function nzGum:SendRollSync(id, ply)
		if !id then nzGum:SendFullSync(ply) return end
		if !nzGum.RollData[id] then return end

		net.Start("nzGum.Sync")
			net.WriteString(id)
			net.WriteInt(math.Round(nzGum.RollData[id].count), 32)
		return ply and net.Send(ply) or net.Broadcast()
	end

	function nzGum:SendRollFullSync(ply)
		local countdata = {}
		for id, data in pairs(nzGum.RollData) do
			countdata[id] = data.count
		end

		net.Start("nzGum.FullSync")
			net.WriteTable(countdata)
		return ply and net.Send(ply) or net.Broadcast()
	end

	function nzGum:SendRollResetSync(ply)
		net.Start("nzGum.ResetSync")
		return ply and net.Send(ply) or net.Broadcast()
	end

	FullSyncModules["Gums"] = function(ply)
		nzGum:SendRollFullSync(ply)
	end
end

if CLIENT then
	-- Server to client (Client)
	local function ReceiveSync( length )
		local id = net.ReadString()
		nzGum.RollData[id] = net.ReadInt(32)
	end

	local function ReceiveFullSync( length )
		nzGum.RollData = net.ReadTable()
	end

	local function ReceiveResetSync( length )
		nzGum.RollData = {}
	end

	-- Receivers
	net.Receive( "nzGum.Sync", ReceiveSync )
	net.Receive( "nzGum.FullSync", ReceiveFullSync )
	net.Receive( "nzGum.ResetSync", ReceiveResetSync )
end
