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
		return price_data[3].price
	end

	for num, rounds in pairs(rounds_prices) do
		if cur_round >= rounds.from and cur_round <= rounds.to then
			return price_data[num]
		end
	end

	return price_data[#price_data]
end

function nzGum:GetCost(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local price = GetGumCost()
	price = price * ply:GetNWInt("nzGumPriceMultiplier", 0)
	return price
end

function nzGum:GetActiveGum(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local gum = ply:GetNWString("nzCurrentGum", "")
	if !gum or gum == "" then
		return
	end
	return gum
end

function nzGum:GetMaxBuysPerRound(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local limit = ply:GetNWInt("nzGumRoundBuyPerRound", 0)
	return limit
end

function nzGum:AddToTotalBuys(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	local total = ply:GetNWInt("nzGumRoundBuyPerRound", 0)
	total = ply:SetNWInt("nzGumRoundBuyPerRound", total + 1)
end

function nzGum:ResetTotalBuys(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	ply:SetNWInt("nzGumRoundBuyPerRound", 0)
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v:IsPlayer() then
			v:SetNWInt("nzGumRoundBuyPerRound", 0)
		end
	end
end