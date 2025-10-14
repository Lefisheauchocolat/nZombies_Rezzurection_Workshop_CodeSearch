if SERVER then
	util.AddNetworkString("nzTrialsSync")
	util.AddNetworkString("nzTrialsReset")
	util.AddNetworkString("nzTrialsPlayerReset")
	util.AddNetworkString("nzTrialsMenu")
	util.AddNetworkString("nzTrialsBuyPerk")

	function nzTrials:PlayerDataSync(data, ply)
		if not data or not istable(data) then return end
		if not IsValid(ply) then return end

		net.Start("nzTrialsSync")
			net.WriteTable(data)
		net.Send(ply)
	end

	function nzTrials:ResetTrials()
		for k, v in pairs(nzTrials.ActiveTrials) do
			if nzTrials:IsTrialActive(k) then
				nzTrials:ResetTrial(k)
			end
		end
		nzTrials.PlayerData = {}
		nzTrials.ActiveTrials = {}

		net.Start("nzTrialsReset")
		net.Broadcast()
	end

	net.Receive("nzTrialsBuyPerk", function(len, ply)
		if not IsValid(ply) then return end
		local trial = net.ReadString()
		local perk = net.ReadString()
		local upgrade = net.ReadBool()

		if not ply:GetTrialCompleted(trial) then return end
		if ply:GetTrialRewardUsed(trial) then return end
		ply:SetTrialRewardUsed(trial)

		if perk == "perk_slot" then
			ply:SetMaxPerks(ply:GetMaxPerks() + 1)
			ply:PerkBlur(0.5)
			return
		end

		local bottle = "tfa_perk_bottle"
		if nzMapping.Settings and nzMapping.Settings.bottle and weapons.Get(nzMapping.Settings.bottle) then
			bottle = tostring(nzMapping.Settings.bottle)
		end

		local wep = ply:Give(bottle)
		if IsValid(wep) then wep:SetPerk(perk) end

		if upgrade then
			ply:GiveUpgrade(perk)
		else
			ply:GivePerk(perk)
		end
	end)
end

if CLIENT then
	local function ReceiveTrialsSync( length )
		local data = net.ReadTable()
		if not data then return end

		nzTrials.PlayerData[LocalPlayer()] = data
	end

	local function ReceiveTrialsReset( length )
		nzTrials.PlayerData = {}
	end

	local function ReceiveTrialsPlayerReset( length )
		nzTrials.PlayerData[LocalPlayer()] = {}
	end

	net.Receive("nzTrialsSync", ReceiveTrialsSync)
	net.Receive("nzTrialsReset", ReceiveTrialsReset)
	net.Receive("nzTrialsPlayerReset", ReceiveTrialsPlayerReset)
end
