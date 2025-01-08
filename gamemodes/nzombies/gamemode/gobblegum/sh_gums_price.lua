local rounds_prices = {
	[1] = {from=1, to=9},
	[2] = {from=10, to=19},
	[3] = {from=20, to=29},
	[4] = {from=30, to=39},
	[5] = {from=40, to=49},
	[6] = {from=50, to=59},
	[7] = {from=60, to=69},
	[8] = {from=70, to=79},
	[9] = {from=80, to=89},
	[10] = {from=90, to=99},
	[11] = {from=100, to=255},
}

local function GetGumCost()
	if nzPowerUps:IsPowerupActive("firesale") then
		return 490
	end

	local price_data = nzMapping.Settings.gumpricelist or nzGum.RoundPrices

	local cur_round = nzRound:GetNumber()
	if !cur_round or cur_round < 0 then
		return price_data[3]
	end

	for num, rounds in pairs(rounds_prices) do
		if cur_round >= rounds.from and cur_round <= rounds.to then
			return price_data[num]
		end
	end

	return price_data[#price_data]
end

function nzGum:GetCost(ply) //calling without a player will provide price without multiplier
	if not IsValid(ply) or not ply:IsPlayer() then
		return GetGumCost()
	end
	return GetGumCost() * nzGum:GetPlayerPriceMultiplier(ply)
end

function nzGum:SetPlayerPriceMultiplier(ply, num)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	ply:SetNWInt("nzGumPriceMultiplier", num)
end

function nzGum:GetPlayerPriceMultiplier(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	return ply:GetNWInt("nzGumPriceMultiplier", 0)
end

function nzGum:GetTotalBuys(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	return ply:GetNWInt("nzGumRoundBuyPerRound", 0)
end

function nzGum:AddToTotalBuys(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	ply:SetNWInt("nzGumRoundBuyPerRound", nzGum:GetTotalBuys(ply) + 1)
end

function nzGum:ResetTotalBuys(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	ply:SetNWInt("nzGumRoundBuyPerRound", 0)
end