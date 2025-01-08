if (CLIENT) then
	local cl_drawhud = GetConVar("cl_drawhud")

	local PLAYER = FindMetaTable("Player")

	//the entire hud
	function PLAYER:ShouldDrawHUD()
		if cl_drawhud and !cl_drawhud:GetBool() then
			return false
		end

		local observed = self:GetObserverTarget()
		if IsValid(observed) then
			if observed.GetTeleporterEntity and IsValid(observed:GetTeleporterEntity()) then
				return false
			end

			if observed.NZIsThrasherVictim and observed:NZIsThrasherVictim() then
				return false
			end
		else
			if self.GetTeleporterEntity and IsValid(self:GetTeleporterEntity()) then
				return false
			end

			if self.NZIsThrasherVictim and self:NZIsThrasherVictim() then
				return false
			end
		end

		if nzRound:InState(ROUND_INIT) and not self:Alive() then
			return false
		end

		if self:GetCreationTime() + 10 > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_WAITING) then
			return false
		end

		//please please please dont remove this function from cl_lobby.lua i beg of you
		if self.IsLobbyMenuOpen and self:IsLobbyMenuOpen() then
			return false
		end

		return true
	end

	//dpad, ammo count, AAT, mulekick/underbarrel icon
	function PLAYER:ShouldDrawGunHUD()
		local observed = self:GetObserverTarget()
		if IsValid(observed) then
			if observed.IsFrozen and observed:IsFrozen() then
				return false
			end
		else
			if self:IsFrozen() then
				return false
			end
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + 2.5 > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end

	//grenades, equipment, specialist, shield
	function PLAYER:ShouldDrawInventoryHUD()
		if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + 2.65 > CurTime() then
			return false
		end

		return true
	end

	//round counter
	function PLAYER:ShouldDrawRoundHUD()
		if not (nzRound:InProgress() or nzRound:InState(ROUND_GO) or nzRound:InState(ROUND_CREATE)) then
			return false
		end

		if nzRound:InState(ROUND_GO) and not self:Alive() then
			return false
		end

		return true
	end

	//player score, player health, player stamina, player armor, zombies alive counter
	function PLAYER:ShouldDrawScoreHUD()
		if nzRound:InState(ROUND_GO) and not self:Alive() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + 2 > CurTime() then
			return false
		end

		return true
	end

	//perks, perk frames, perk statistics icons
	function PLAYER:ShouldDrawPerksHUD()
		if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + 2.65 > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end

	//powerup icons and looping sounds
	function PLAYER:ShouldDrawPowerupsHUD()
		return true
	end

	//revive progress bar, downed player icons
	function PLAYER:ShouldDrawReviveHUD()
		if nzRound:InState(ROUND_WAITING) then
			return false
		end

		return true
	end

	//powerup notification, player revived/downed/killed notification
	function PLAYER:ShouldDrawNotificationHUD()
		return true
	end

	//target id hint string
	function PLAYER:ShouldDrawHintHUD()
		local observed = self:GetObserverTarget()
		if IsValid(observed) then
			if observed.IsFrozen and observed:IsFrozen() then
				return false
			end
		else
			if self:IsFrozen() then
				return false
			end
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + 2.65 > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end
end
