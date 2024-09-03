local _PLAYER = FindMetaTable("Player")

function _PLAYER:GetPoints()
	return self:GetNW2Int("points") or 0
end

function _PLAYER:HasPoints(amount)
	return self:GetPoints() >= amount
end

function _PLAYER:CanAfford(amount)
	return (self:GetPoints() - amount) >= 0
end

if (SERVER) then
	//clientside points related stuff
	nzPlayers.CLPoints = nzPlayers.CLPoints or {}

	hook.Add("PlayerInitialSpawn", "nzRebuildCLPoints", function(ply)
		if ply:GetInfoNum("nz_hud_clientside_points", 0) > 0 then
			local b_test = true
			for i = 1, #nzPlayers.CLPoints do
				if nzPlayers.CLPoints[i] == ply then
					b_test = false
					break
				end
			end

			if b_test then
				table.insert(nzPlayers.CLPoints, ply)
			end
		end
	end)

	util.AddNetworkString("nz.CLPointsUpdate")
	net.Receive("nz.CLPointsUpdate", function(len, ply)
		if not IsValid(ply) then return end
		local b_clpoints = net.ReadBool()

		if b_clpoints then
			local b_test = true
			for i = 1, #nzPlayers.CLPoints do
				if nzPlayers.CLPoints[i] == ply then
					b_test = false
					break
				end
			end

			if b_test then
				table.insert(nzPlayers.CLPoints, ply)
			end
		else
			for i = 1, #nzPlayers.CLPoints do
				if nzPlayers.CLPoints[i] == ply then
					table.remove(nzPlayers.CLPoints, i)
					break
				end
			end
		end
	end)

	local sv_clientpoints = GetConVar("nz_point_notification_clientside")
	util.AddNetworkString("nz_points_notification")

	-- Sets the character's amount of currency to a specific value.
	function _PLAYER:SetPoints(amount, profit_id)
		amount = math.Round(amount)
		if not sv_clientpoints:GetBool() then
			local num = amount - self:GetPoints()
			if num ~= 0 then -- 0 points doesn't get sent
				local netstring = (nzDisplay and nzDisplay.HUDnetstrings) and nzDisplay.HUDnetstrings[nzMapping.Settings.hudtype] or "nz_points_notification"

				local profit = 0
				if profit_id then
					profit = profit_id
				end

				net.Start(netstring)
					net.WriteInt(num, 20)
					net.WriteEntity(self)
					net.WriteInt(profit, 9)
				net.SendOmit(nzPlayers.CLPoints)
			end
		end
		self:SetNW2Int("points", amount)
	end

	-- Quick function to set the money to the current amount plus an amount specified.
	function _PLAYER:GivePoints(amount, ignoredp, hassound)
		if nzMapping.Settings.antipowerups and nzPowerUps:IsAntiPowerupActive("dp") and not ignoredp then
			return //anti double points blocks earning points
		end

		-- If double points is on.
		if nzPowerUps:IsPowerupActive("dp") and not ignoredp then
			amount = amount * 2
		end
		amount = hook.Call("OnPlayerGetPoints", nil, self, amount) or amount

		self:SetPoints(self:GetPoints() + amount)

		if hassound then
			local snd = "nz_moo/effects/purchases/buy_classic.mp3"

			if !table.IsEmpty(nzSounds.Sounds.Custom.Purchase) then
				snd = tostring(nzSounds.Sounds.Custom.Purchase[math.random(#nzSounds.Sounds.Custom.Purchase)])
			end

			self:EmitSound(snd, SNDLVL_TALKING, math.random(99,101))
		end
	end

	-- Takes away a certain amount by inverting the amount specified.
	function _PLAYER:TakePoints(amount, hassound)
		-- Changed to prevent double points from removing double the points. - Don't even think of changing this back Ali, Love Ali.
		amount = hook.Call("OnPlayerLosePoints", nil, self, amount) or amount

		self:SetPoints(self:GetPoints() - amount)

		if hassound then
			local snd = "nz_moo/effects/purchases/buy_classic.mp3"

			if !table.IsEmpty(nzSounds.Sounds.Custom.Purchase) then
				snd = tostring(nzSounds.Sounds.Custom.Purchase[math.random(#nzSounds.Sounds.Custom.Purchase)])
			end

			self:EmitSound(snd, SNDLVL_TALKING, math.random(99,101))
		end

		-- If you have a clone like this, it tracks money spent which will be refunded on revival
		if self.WhosWhoMoney then self.WhosWhoMoney = self.WhosWhoMoney + amount end
	end
	
	function _PLAYER:Buy(amount, ent, func)
		local new = hook.Call("OnPlayerBuy", nil, self, amount, ent, func) or amount
		if type(new) == "number" then
			if self:CanAfford(new) then
				local success = func()
				if success then
					self:TakePoints(new, true)
					hook.Call("OnPlayerBought", nil, self, new, ent)
					return true -- If the buy was successfull, this function also returns true
				end
			else
				self:EmitSound("nz_moo/effects/purchases/deny.wav")
				return false -- Return false if we can't afford
			end
		else
			return false -- And return false if the hook blocked the event by returning true
		end
	end

end
