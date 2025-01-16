if (CLIENT) then
	local cl_drawhud = GetConVar("cl_drawhud")
	local cl_skyintro = GetConVar("nz_sky_intro_always")
	local sv_skyintro = GetConVar("nz_sky_intro_server_allow")

	local b_clientskyintro = false

	hook.Add("Think", "nzcacheskyconvar", function(ply)
		hook.Remove("Think", "nzcacheskyconvar")
		if sv_skyintro:GetBool() then
			b_clientskyintro = cl_skyintro:GetBool()
		end
	end)

	cvars.AddChangeCallback("nz_sky_intro_always", function(name, old, new)
		if sv_skyintro:GetBool() then
			b_clientskyintro = tonumber(new) == 1
		end
	end)

	local PLAYER = FindMetaTable("Player")
	local b_activated = false

	local n_dpaddrawtime = 2.5
	local n_inventorydrawtime = 2.65
	local n_scoredrawtime = 2
	local b_recache = false

	//the entire hud
	function PLAYER:ShouldDrawHUD()
		if cl_drawhud and !cl_drawhud:GetBool() then
			return false
		end

		local override = hook.Run("nzShouldDrawHUD", self)
		if override ~= nil and tobool(override) then
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

		if nzRound and nzRound:InState(ROUND_INIT) and not self:Alive() then
			return false
		end

		if self:GetCreationTime() + 10 > CurTime() then
			return false
		end

		if (nzMapping.Settings.skyintro or b_clientskyintro) then
			if !b_recache then
				b_recache = true
				n_dpaddrawtime = nzMapping.Settings.skyintrotime + 0.5
				n_inventorydrawtime = nzMapping.Settings.skyintrotime + 0.65
				n_scoredrawtime = nzMapping.Settings.skyintrotime + 0.15
			end
		else
			if b_recache then
				b_recache = false
				n_dpaddrawtime = 2.5
				n_inventorydrawtime = 2.65
				n_scoredrawtime = 2
			end
		end

		if (nzMapping.Settings.skyintro or b_clientskyintro) and self.GetLastSpawnTime and self:GetLastSpawnTime() + (nzMapping.Settings.skyintrotime or 1.4) > CurTime() then
			return false
		end

		if nzRound and nzRound:InState(ROUND_WAITING) then
			return false
		end

		//please please please dont remove this function from cl_lobby.lua i beg of you (11/12/24)
		//it got fucking deleted :D (17/12/24)

		if nzLobby and nzLobby.IsLobbyMenuOpen and nzLobby:IsLobbyMenuOpen() then
			return false
		end

		return true
	end

	//dpad, ammo count, AAT, mulekick/underbarrel icon
	function PLAYER:ShouldDrawGunHUD()
		local override = hook.Run("nzShouldDrawGunHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		if self:IsInCreative() and (nzMapping.Settings.skyintro or b_clientskyintro) and self:GetLastSpawnTime() + n_dpaddrawtime > CurTime() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + n_dpaddrawtime > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end

	//grenades, equipment, specialist, shield
	function PLAYER:ShouldDrawInventoryHUD()
		local override = hook.Run("nzShouldDrawInventoryHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then
			return false
		end

		if self:IsInCreative() and (nzMapping.Settings.skyintro or b_clientskyintro) and self:GetLastSpawnTime() + n_inventorydrawtime > CurTime() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + n_inventorydrawtime > CurTime() then
			return false
		end

		return true
	end

	//round counter
	function PLAYER:ShouldDrawRoundHUD()
		local override = hook.Run("nzShouldDrawRoundHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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
		local override = hook.Run("nzShouldDrawScoreHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		if nzRound:InState(ROUND_GO) and not self:Alive() then
			return false
		end

		if self:IsInCreative() and (nzMapping.Settings.skyintro or b_clientskyintro) and self:GetLastSpawnTime() + n_scoredrawtime > CurTime() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + n_scoredrawtime > CurTime() then
			return false
		end

		return true
	end

	//perks, perk frames, perk statistics icons
	function PLAYER:ShouldDrawPerksHUD()
		local override = hook.Run("nzShouldDrawPerksHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then
			return false
		end

		if self:IsInCreative() and (nzMapping.Settings.skyintro or b_clientskyintro) and self:GetLastSpawnTime() + n_inventorydrawtime > CurTime() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + n_inventorydrawtime > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end

	//powerup icons and looping sounds
	function PLAYER:ShouldDrawPowerupsHUD()
		local override = hook.Run("nzShouldDrawPowerupsHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

		return true
	end

	//revive progress bar, downed player icons
	function PLAYER:ShouldDrawReviveHUD()
		local override = hook.Run("nzShouldDrawReviveHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

		if nzRound:InState(ROUND_WAITING) then
			return false
		end

		return true
	end

	//powerup notification, player revived/downed/killed notification
	function PLAYER:ShouldDrawNotificationHUD()
		local override = hook.Run("nzShouldDrawNotificationHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		return true
	end

	//target id hint string
	function PLAYER:ShouldDrawHintHUD()
		local override = hook.Run("nzShouldDrawHintHUD", self)
		if override ~= nil and tobool(override) then
			return false
		end

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

		if self:IsInCreative() and (nzMapping.Settings.skyintro or b_clientskyintro) and self:GetLastSpawnTime() + n_dpaddrawtime > CurTime() then
			return false
		end

		if self:GetNW2Float("FirstSpawnedTime", 0) + n_dpaddrawtime > CurTime() then
			return false
		end

		if nzRound:InState(ROUND_GO) then
			return false
		end

		return true
	end
end
