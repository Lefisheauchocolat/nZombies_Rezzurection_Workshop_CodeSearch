local playerMeta = FindMetaTable("Player")
if SERVER then
	function playerMeta:DownPlayer()
		local id = self:EntIndex()

		local reviving = self:GetPlayerReviving()
		if IsValid(reviving) then //stop reviving if u die
			local revid = reviving:EntIndex()
			local data = nzRevive.Players[revid]
			if data and data.ReviveTime then
				reviving:StopRevive()
				self.Reviving = nil
			end
		end

		nzRevive.Players[id] = {}
		nzRevive.Players[id].DownTime = CurTime()

		-- downed players are not targeted
		self:SetTargetPriority(TARGET_PRIORITY_NONE)
		self:SetHealth(nzMapping.Settings.hp or 100)

		if #player.GetAllPlaying() > 1 and self:HasUpgrade("tombstone") and !self.FightersFizz then
			self.FightersFizz = true
		end

		self.OldUpgrades = self:GetUpgrades()
		self.OldPerks = self:GetPerks()

		local maxrevives = (nzMapping.Settings.solorevive or 3)
		if #player.GetAllPlaying() <= 1 and self:HasPerk("revive") and maxrevives > 0 and (!self.SoloRevive or self.SoloRevive < maxrevives) then
			self.SoloRevive = self.SoloRevive and self.SoloRevive + 1 or 1
			self.DownedWithSoloRevive = true

			self:SetNW2Int("nz.SoloReviveCount", maxrevives - self.SoloRevive)
			table.RemoveByValue(self.OldPerks, "revive")

			self:StartRevive(self)
			timer.Simple(8, function()
				if IsValid(self) and !self:GetNotDowned() then
					self:RevivePlayer(self)
				end
			end)
		end

		if !self.DownedWithSoloRevive and self:HasPerk("tombstone") then
			nzRevive.Players[id].tombstone = true
		end

		if #player.GetAllPlaying() <= 1 and !nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
			for k,v in pairs(ents.FindByClass("player_spawns")) do
				v:SetTargetPriority(TARGET_PRIORITY_SPECIAL) -- This allows zombies to retreat to player spawns in solo games.
			end
		end

		self.OldWeapons = {}
		for k, v in pairs(self:GetWeapons()) do
			if v.IsTFAWeapon then
				if v.NZSpecialCategory == "display" then continue end
				table.insert(self.OldWeapons, {class = v:GetClass(), pap = v:HasNZModifier("pap"), special = v.NZSpecialCategory})
			end
		end

		//solo tombstone
		if self.DownedWithSoloRevive and self:HasPerk("tombstone") then
			local upgrade = false
			for _, mod in pairs(self.OldUpgrades) do
				if mod == "tombstone" then
					upgrade = true
					break
				end
			end

			table.RemoveByValue(self.OldPerks, "tombstone")

			local tombstone = ents.Create("drop_tombstone")
			tombstone:SetOwner(self)
			tombstone:SetFunny(math.random(100) == 1)
			tombstone:SetPos(self:GetPos() + Vector(0,0,24))
			tombstone:Spawn()

			if not tombstone.OwnerData then tombstone.OwnerData = {} end
			tombstone.OwnerData.weps = {}
			tombstone.OwnerData.perks = self.OldPerks
			tombstone.OwnerData.upgrade = upgrade
			tombstone:SetOwner(self)
		end

		self:RemovePerks()
		self:RemoveUpgrades()

		self.DownPoints = math.Round(self:GetPoints()*0.05, -1)
		if self.DownPoints >= self:GetPoints() then
			self:SetPoints(0)
		else
			self:TakePoints(self.DownPoints, true)
		end

		hook.Call("PlayerDowned", nzRevive, self)

		-- Equip the first pistol found in inventory - unless a pistol is already equipped
		local wep = self:GetActiveWeapon()
		if IsValid(wep) and ((wep.GetHoldType and wep:GetHoldType() == "pistol") or (wep.HoldType == "pistol")) and not wep:IsSpecial() then
			return
		end

		for k, v in pairs(self:GetWeapons()) do
			if v.GetHoldType and v:GetHoldType() == "pistol" or v.HoldType == "pistol" and not v:IsSpecial() then
				self:SelectWeapon(v:GetClass())
				return
			end
		end
	end

	function playerMeta:RevivePlayer(revivor, nosync)
		local id = self:EntIndex()
		if !nzRevive.Players[id] then return end
		nzRevive.Players[id] = nil

		if !nosync then
			hook.Call("PlayerRevived", nzRevive, self, revivor)
		end

		local count = 0
		for k, v in RandomPairs(self.OldPerks) do
			--[[if IsValid(revivor) and revivor:HasUpgrade("revive") and revivor ~= self then
				self:GivePerk(v)

				continue]]
			if self.FightersFizz then
				if v == "tombstone" then continue end
				self:GivePerk(v)

				continue
			elseif !nzMapping.Settings.dontkeepperks then
				if count >= math.floor(#self.OldPerks/2) then break end
				if self.DownedWithSoloRevive and v == "revive" then continue end
				if self.DownedWithSoloRevive and v == "tombstone" then continue end

				self:GivePerk(v)
				count = count + 1
	        end
		end

		self:SetTargetPriority(TARGET_PRIORITY_NONE)
        timer.Simple(2, function()
			if (IsValid(self)) and (self:IsPlaying() or self:IsInCreative()) then
				self:SetTargetPriority(TARGET_PRIORITY_PLAYER)

				for k,v in pairs(ents.FindByClass("player_spawns")) do
					v:SetTargetPriority(TARGET_PRIORITY_NONE) -- Get rid of the spawn's target priority.
				end
			end
		end)
		
		if IsValid(revivor) and revivor:HasUpgrade("revive") then --revivor and revivee are invincible for a duration
			revivor:WAWPlasmaRage(10)
			self:WAWPlasmaRage(10)
		end

		if IsValid(revivor) and revivor:IsPlayer() then
			if self.DownPoints then
				revivor:GivePoints(self.DownPoints)
			end
		end

		self.DownPoints = nil
		self.DownedWithSoloRevive = nil
		self.FightersFizz = nil

		/*if GetGlobal2Int("AliveZombies", 0) >= 16 then
			local SND = "RevivalStinger"
			nzSounds:Play(SND)
		end*/
		self:ResetHull()
	end

	function playerMeta:StartRevive(revivor, nosync)
		local id = self:EntIndex()
		if not revivor then revivor = self end
		if !nzRevive.Players[id] then return end
		if nzRevive.Players[id].ReviveTime then return end
		if IsValid(nzRevive.Players[id].RevivePlayer) then return end

		nzRevive.Players[id].ReviveTime = CurTime()
		nzRevive.Players[id].RevivePlayer = revivor
		revivor.Reviving = self

		if not revivor:GetUsingSpecialWeapon() and revivor:GetNotDowned() then
			revivor:Give(nzMapping.Settings.syrette or "tfa_bo2_syrette") --alternatively 'tfa_bo2_syrette' or 'tfa_bo3_syrette'
			revivor:SelectWeapon(nzMapping.Settings.syrette or "tfa_bo2_syrette")
		end

		if !nosync then hook.Call("PlayerBeingRevived", nzRevive, self, revivor) end
	end

	function playerMeta:StopRevive(nosync)
		local id = self:EntIndex()
		if !nzRevive.Players[id] then return end

		local revivor = nzRevive.Players[id].RevivePlayer
		nzRevive.Players[id].ReviveTime = nil
		nzRevive.Players[id].RevivePlayer = nil
		revivor.Reviving = nil

		if revivor:HasWeapon(nzMapping.Settings.syrette or "tfa_bo2_syrette") and not revivor:IsRevivingPlayer() then
			revivor:SetUsingSpecialWeapon(false)
			revivor:EquipPreviousWeapon()
			timer.Simple(0, function() 
				if not IsValid(revivor) then return end
				revivor:StripWeapon(nzMapping.Settings.syrette or "tfa_bo2_syrette")
			end)
		end

		if !nosync then hook.Call("PlayerNoLongerBeingRevived", nzRevive, self) end
	end

	function playerMeta:KillDownedPlayer(silent, nosync, nokill)
		local id = self:EntIndex()
		if !nzRevive.Players[id] then return end

		local revivor = nzRevive.Players[id].RevivePlayer

		if !nosync then hook.Call("PlayerKilled", nzRevive, self) end

		nzRevive.Players[id] = nil
		if !nokill then
			if silent then
				self:KillSilent()
			else
				self:Kill()
			end
		end

		self.DownPoints = nil
		self.DownedWithSoloRevive = nil

		for k,v in pairs(player.GetAllPlayingAndAlive()) do
			v:TakePoints(math.Round(v:GetPoints()*0.1, -1), true)
		end
		
		self:RemoveAllPowerUps()
		self:RemoveAllAntiPowerUps()
		self:ResetHull()
	end
end

function playerMeta:SetReviveTime(num)
	self:SetNW2Float("nzTimeToRevive", num)
end

function playerMeta:GetReviveTime()
	local revive = self:GetNW2Float("nzTimeToRevive", 0)
	if self:HasPerk("revive") then
		revive = revive*0.5
	end

	return revive
end

function playerMeta:SetBleedoutTime(num)
	self:SetNW2Float("nzBleedoutTime", num)
end

function playerMeta:IncreaseBleedoutTime(num)
	self:SetNW2Float("nzBleedoutTime", math.max(self:GetBleedoutTime() + num, 0))
end

function playerMeta:DecreaseBleedoutTime(num)
	self:SetNW2Float("nzBleedoutTime", math.max(self:GetBleedoutTime() - num, 0))
end

function playerMeta:GetBleedoutTime()
	return self:GetNW2Float("nzBleedoutTime", 0)
end

function playerMeta:IsRevivingPlayer()
	for id, data in pairs(nzRevive.Players) do
		if data.RevivePlayer and IsValid(data.RevivePlayer) and data.RevivePlayer == self then
			return true
		end
	end

	return false
end

function playerMeta:GetNotDowned()
	local id = self:EntIndex()
	if nzRevive.Players[id] then
		return false
	else
		return true
	end
end

function playerMeta:GetDownedWithTombstone()
	local id = self:EntIndex()
	if nzRevive.Players[id] then
		return nzRevive.Players[id].tombstone or false
	else
		return false
	end
end

function playerMeta:GetPlayerReviving()
	return self.Reviving
end

//this is to prevent IW anims mod from erroring
function playerMeta:IsReviving()
	return false
end
