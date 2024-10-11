local playerMeta = FindMetaTable("Player")
if SERVER then
	function playerMeta:GivePerk(id, machine)
		local block = hook.Call("OnPlayerBuyPerk", nil, self, id, machine)
	
		if block or self:HasPerk(id) then return end
		local perkData = nzPerks:Get(id)
		if !perkData or !perkData.func then return false end

		-- Specialmachine blocks the networking and storing of the perk
		if !perkData.specialmachine then
			if nzPerks.Players[self] == nil then nzPerks.Players[self] = {} end

			nzPerks.Players[self][id] = (#self:GetPerks() + 1)
			nzPerks:SendSync(self)
			hook.Call("OnPlayerGetPerk", nil, self, id, machine)

			local modslot = nzMapping.Settings.modifierslot
			if nzPerks.Players[self][id] == 4 and (modslot == nil or tobool(modslot)) then
				self:GiveUpgrade(id, nil, true)
			end
		end

		perkData.func(id, self, machine)
	end

	function playerMeta:GiveUpgrade(id, machine, mod)
		if not self:HasPerk(id) then return end
		local block = hook.Call("OnPlayerBuyUpgrade", nil, self, id, machine)

		if block or self:HasUpgrade(id) then return end
		local perkData = nzPerks:Get(id)
		if !perkData or !perkData.upgradefunc then return false end

		-- Specialmachine blocks the networking and storing of the perk
		if !perkData.specialmachine then
			if nzPerks.PlayerUpgrades[self] == nil then nzPerks.PlayerUpgrades[self] = {} end

			nzPerks.PlayerUpgrades[self][id] = mod and 1 or (nzPerks.Players[self][id] + 1)
			nzPerks:SendUpgradeSync(self)
			hook.Call("OnPlayerGetUpgrade", nil, self, id, machine)
		end

		perkData.upgradefunc(id, self, machine)
	end

	local exceptionperks = {
		["whoswho"] = true,
	}

	function playerMeta:RemovePerk(id, forced)
		local block = hook.Call("OnPlayerRemovePerk", nil, self, id, forced)
	
		if (self.PreventPerkLoss and !exceptionperks[id] or block) and !forced then return end
		local perkData = nzPerks:Get(id)
		if perkData == nil then return end
	
		if nzPerks.Players[self] == nil then nzPerks.Players[self] = {} end
		if self:HasPerk(id) then
			if self:HasUpgrade(id) then
				self:RemoveUpgrade(id)
			end

			perkData.lostfunc(id, self)

			local slot = nzPerks.Players[self][id]
			for k, v in pairs(nzPerks.Players[self]) do
				if v > slot then
					//if perk was modifier slot upgraded, remove it
					local modslot = nzMapping.Settings.modifierslot
					if v == 4 and nzPerks.PlayerUpgrades[self][k] and nzPerks.PlayerUpgrades[self][k] == 1 and (modslot == nil or tobool(modslot)) then
						self:RemoveUpgrade(k)
					end

					nzPerks.Players[self][k] = v - 1

					//if perk falls into modifier slot, upgrade it
					if nzPerks.Players[self][k] == 4 and !self:HasUpgrade(k) and (modslot == nil or tobool(modslot)) then
						self:GiveUpgrade(k, nil, true)
					end
				end
			end

			nzPerks.Players[self][id] = nil
			hook.Call("OnPlayerLostPerk", nil, self, id, forced)
		end
		nzPerks:SendSync(self)
	end

	function playerMeta:RemoveUpgrade(id, forced, nosync)
		local block = hook.Call("OnPlayerRemoveUpgrade", nil, self, id, forced)
		if nosync == nil then nosync = false end

		if (self.PreventPerkLoss and !exceptionperks[id] or block) and !forced then return end
		local perkData = nzPerks:Get(id)
		if perkData == nil then return end
	
		if nzPerks.PlayerUpgrades[self] == nil then nzPerks.PlayerUpgrades[self] = {} end
		if self:HasUpgrade(id) then
			if perkData.lostupgradefunc then
				perkData.lostupgradefunc(id, self)
			end

			local slot = nzPerks.PlayerUpgrades[self][id]
			for k, v in pairs(nzPerks.PlayerUpgrades[self]) do
				if v > slot then
					nzPerks.PlayerUpgrades[self][k] = v - 1
				end
			end

			nzPerks.PlayerUpgrades[self][id] = nil
			hook.Call("OnPlayerLostUpgrade", nil, self, id, forced)
		end

		if !nosync then
			nzPerks:SendUpgradeSync(self)
		end
	end

	function playerMeta:RemovePerks()
		if self.PreventPerkLoss then
			if nzPerks.Players[self] then
				for k, v in pairs(nzPerks.Players[self]) do
					if exceptionperks[k] then
						self:RemovePerk(k)
					end
				end
			end
		else
			if nzPerks.Players[self] then
				for k, v in pairs(nzPerks.Players[self]) do
					local perkData = nzPerks:Get(k)
					if perkData then
						perkData.lostfunc(k, self)
					end

					nzPerks.Players[self][k] = nil
				end
			end
		end
		nzPerks:SendSync(self)
	end

	function playerMeta:RemoveUpgrades()
		if self.PreventPerkLoss then
			if nzPerks.PlayerUpgrades[self] then
				for k, v in pairs(nzPerks.PlayerUpgrades[self]) do
					self:RemoveUpgrade(k)
				end
			end
		else
			if nzPerks.PlayerUpgrades[self] then
				for k, v in pairs(nzPerks.PlayerUpgrades[self]) do
					local perkData = nzPerks:Get(k)
					if perkData and perkData.lostupgradefunc then
						perkData.lostupgradefunc(k, self)
					end

					nzPerks.PlayerUpgrades[self][k] = nil
				end
			end
		end

		nzPerks:SendUpgradeSync(self)
	end

	function playerMeta:GiveRandomPerk(maponly)
		local available = {}
		local fizzlist = nzMapping.Settings.wunderfizzperklist
		local blockedperks = {
			["wunderfizz"] = true,
			["pap"] = true,
			["gum"] = true,
		}

		local machines = ents.FindByClass("perk_machine")
		for perk, _ in pairs(nzPerks:GetList()) do
			if blockedperks[perk] then continue end
			if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then continue end
			if self:HasPerk(perk) then continue end

			if maponly then
				for _, ent in pairs(machines) do
					if ent:GetPerkID() == perk then
						table.insert(available, perk)
					end
				end
			else
				table.insert(available, perk)
			end	
		end

		if table.IsEmpty(available) then nzSounds:PlayEnt("Laugh", self) end

		self:GivePerk(available[math.random(#available)])
	end

	function playerMeta:SetPreventPerkLoss(bool)
		self.PreventPerkLoss = bool
	end

	function playerMeta:GivePermaPerks()
		self:SetPreventPerkLoss(true)
		for k,v in pairs(nzPerks:GetList()) do
			if !nzPerks:Get(k).specialmachine then
				self:GivePerk(k)
			end
		end
	end

	//ignoreplayer can either be a single player or table of players
	function nzPerks:IncreaseAllPlayersMaxPerks(num, ignoreplayer)
		for k, v in pairs(player.GetAll()) do
			if (v:IsPlaying() or v:IsInCreative()) then
				if ignoreplayer then
					if istable(ignoreplayer) then
						if table.HasValue(ignoreplayer, v) then
							continue
						end
					elseif v == ignoreplayer then
						continue
					end
				end

				v:SetMaxPerks(v:GetMaxPerks() + num)
			end
		end
	end

	//ignoreplayer can either be a single player or table of players
	function nzPerks:DecreaseAllPlayersMaxPerks(num, ignoreplayer)
		for k, v in pairs(player.GetAll()) do
			if (v:IsPlaying() or v:IsInCreative()) then
				if ignoreplayer then
					if istable(ignoreplayer) then
						if table.HasValue(ignoreplayer, v) then
							continue
						end
					elseif v == ignoreplayer then
						continue
					end
				end

				v:SetMaxPerks(v:GetMaxPerks() - num)
			end
		end
	end

	//called on game start and game end
	function nzPerks:ResetMaxPlayerPerks()
		GetConVar("nz_difficulty_perks_max"):SetInt(nzMapping.Settings.playerperkmax or 4)
		for k, v in pairs(player.GetAll()) do
			if (v:IsPlaying() or v:IsInCreative()) then
				v:SetMaxPerks(GetConVar("nz_difficulty_perks_max"):GetInt())
			end
		end
	end
end

//the convar 'nz_difficulty_perks_max' is now used for setting players max perk count on spawn
//this is usefull because things like the broken bottle powerup and the round 15/25 perkslot reward
//increase the perk count globally for all players and should apply to late joiners

function playerMeta:SetMaxPerks(num)
	self:SetNW2Int("nzMaxPerks", math.Clamp(num, 0, (nzMapping.Settings.maxperkslots or 8)))
end

function playerMeta:GetMaxPerks()
	return self:GetNW2Int("nzMaxPerks", 0)
end

function playerMeta:HasPerk(id)
	if nzPerks.Players[self] == nil then nzPerks.Players[self] = {} end
	return tobool(nzPerks.Players[self][id])
end

function playerMeta:HasUpgrade(id)
	if nzPerks.PlayerUpgrades[self] == nil then nzPerks.PlayerUpgrades[self] = {} end
	return tobool(nzPerks.PlayerUpgrades[self][id])
end

function playerMeta:GetPerks()
	if nzPerks.Players[self] == nil then nzPerks.Players[self] = {} end

	local tbl = {}
	for k, v in pairs(nzPerks.Players[self]) do
		if k == "pap" then continue end
		tbl[v] = k
	end

	return tbl
end

/*function playerMeta:GetAllPerks()
	if nzPerks.Players[self] == nil then nzPerks.Players[self] = {} end

	local tbl = {}
	for k, v in pairs(nzPerks.Players[self]) do
		if k == "pap" then continue end
		tbl[v] = k
	end

	return tbl
end*/

function playerMeta:GetUpgrades()
	if nzPerks.PlayerUpgrades[self] == nil then nzPerks.PlayerUpgrades[self] = {} end

	local tbl = {}
	for k, v in pairs(nzPerks.PlayerUpgrades[self]) do
		if k == "pap" then continue end
		tbl[v] = k
	end

	return tbl
end