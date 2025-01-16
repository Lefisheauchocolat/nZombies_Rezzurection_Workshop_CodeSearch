if (SERVER) then
	util.AddNetworkString("nz_update_clan_tags")
	util.AddNetworkString("nz_update_clan_icons")

	//clan tag system
	hook.Add("PlayerFullyInitialized", "nzUpdateClanTags", function(ply)
		if not IsValid(ply) then return end

		local ownindex = ply:EntIndex()
		for k, v in ipairs(player.GetAll()) do
			if v:EntIndex() == ownindex then continue end

			local clantag = v:GetInfo("nz_clan_tag")
			if clantag then
				clantag = string.sub(tostring(clantag), 1, 5)
				net.Start("nz_update_clan_tags")
					net.WriteInt(v:EntIndex(), 8)
					net.WriteString(clantag)
				net.Send(ply)
			end

			local clanicon = v:GetInfo("nz_clan_icon")
			if clanicon then
				clanicon = string.sub(tostring(clanicon), 1, 61)
				net.Start("nz_update_clan_icons")
					net.WriteInt(v:EntIndex(), 8)
					net.WriteString(clanicon)
				net.Send(ply)
			end
		end

		local clantag = ply:GetInfo("nz_clan_tag")
		if clantag then
			clantag = string.sub(tostring(clantag), 1, 5)
			net.Start("nz_update_clan_tags")
				net.WriteInt(ply:EntIndex(), 8)
				net.WriteString(clantag)
			net.Broadcast()
		end

		local clanicon = ply:GetInfo("nz_clan_icon")
		if clanicon then
			clanicon = string.sub(tostring(clanicon), 1, 61)
			net.Start("nz_update_clan_icons")
				net.WriteInt(ply:EntIndex(), 8)
				net.WriteString(clanicon)
			net.Broadcast()
		end
	end)

	local penaltytimes = {
		[0] = 0,
		[1] = 4,
		[2] = 5,
		[3] = 10,
		[4] = 15,
	}

	local penalty = {}
	local lastsend = {}

	function nzDisplay:UpdatePlayerClanTag(ply, new)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not isstring(new) then return end
		new = string.sub(tostring(new), 1, 5)

		if !penalty[ply] then
			penalty[ply] = 0
		end
		if !lastsend[ply] then
			lastsend[ply] = 0
		end

		local time = (game.SinglePlayer() and 0) or penaltytimes[penalty[ply]] or penaltytimes[4]
		if penalty[ply] > 1 then
			time = time + math.Rand(-0.1,0.2)
		end

		if ((lastsend[ply]) + (time) > CurTime()) or (time == 0) then
			penalty[ply] = penalty[ply] + 1
		else
			penalty[ply] = 0
		end

		local name = "nz_clan_tag"
		if timer.Exists(name) then timer.Remove(name) end
		timer.Create(name, time, 1, function() //delay so you cant spam netmessages, as that would be catastrophically bad
			if not IsValid(ply) then return end

			lastsend[ply] = CurTime()

			net.Start("nz_update_clan_tags")
				net.WriteInt(ply:EntIndex(), 8)
				net.WriteString(new)
			net.Broadcast()
		end)
	end

	function nzDisplay:UpdatePlayerClanIcon(ply, new)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not isstring(new) then return end
		new = string.sub(tostring(new), 1, 61)

		if !penalty[ply] then
			penalty[ply] = 0
		end
		if !lastsend[ply] then
			lastsend[ply] = 0
		end

		local time = (game.SinglePlayer() and 0) or penaltytimes[penalty[ply]] or penaltytimes[4]
		if penalty[ply] > 1 then
			time = time + math.Rand(-0.1,0.2)
		end

		if ((lastsend[ply]) + (time) > CurTime()) or (time == 0) then
			penalty[ply] = penalty[ply] + 1
		else
			penalty[ply] = 0
		end

		local name = "nz_clan_icon"
		if timer.Exists(name) then timer.Remove(name) end
		timer.Create(name, time, 1, function() //delay so you cant spam netmessages, as that would be catastrophically bad
			if not IsValid(ply) then return end

			lastsend[ply] = CurTime()

			net.Start("nz_update_clan_icons")
				net.WriteInt(ply:EntIndex(), 8)
				net.WriteString(new)
			net.Broadcast()
		end)
	end

	local oldtag = {}
	local oldicon = {}

	hook.Add("PlayerPostThink", "nzPlayerClanCache", function(ply)
		if not IsValid(ply) then return end
		if not ply:GetNW2Bool("nzFullyConnected", false) then return end

		local newtag = ply:GetInfo("nz_clan_tag") or ""
		if oldtag[ply] == nil then oldtag[ply] = newtag end

		if newtag ~= oldtag[ply] then
			oldtag[ply] = newtag
			nzDisplay:UpdatePlayerClanTag(ply, newtag)
		end

		local newicon = ply:GetInfo("nz_clan_icon") or ""
		if oldicon[ply] == nil then oldicon[ply] = newicon end

		if newicon ~= oldicon[ply] then
			oldicon[ply] = newicon
			nzDisplay:UpdatePlayerClanIcon(ply, newicon)
		end
	end)
end

if (CLIENT) then
	local nz_showclantags = GetConVar("nz_hud_show_clan_tags")
	local n_showclantags = 0

	hook.Add("Think", "nzcacheplytagconvar", function(ply)
		hook.Remove("Think", "nzcacheplytagconvar")
		n_showclantags = nz_showclantags:GetInt()
	end)

	cvars.AddChangeCallback("nz_hud_show_clan_tags", function(name, old, new)
		n_showclantags = math.Round(tonumber(new))
	end)

	//clan tags system
	nzDisplay.PlayerClanTag = nzDisplay.PlayerClanTag or {}
	net.Receive("nz_update_clan_tags", function(length)
		local index = net.ReadInt(8)
		local clantag = net.ReadString()

		if clantag == "" then
			nzDisplay.PlayerClanTag[index] = nil
		else
			nzDisplay.PlayerClanTag[index] = clantag
		end
	end)

	//clan icon system
	nzDisplay.PlayerClanIcon = nzDisplay.PlayerClanIcon or {}
	net.Receive("nz_update_clan_icons", function(length)
		local index = net.ReadInt(8)
		local clanicon = net.ReadString()

		if clanicon == "" then
			nzDisplay.PlayerClanIcon[index] = nil
		else
			local icon = Material(clanicon, "smooth unlitgeneric")
			if icon and not icon:IsError() then
				nzDisplay.PlayerClanIcon[index] = icon
			else
				nzDisplay.PlayerClanIcon[index] = nil
			end
		end
	end)

	local PLAYER = FindMetaTable("Player")

	nzDisplay.CachedNickFunc = nzDisplay.CachedNickFunc or PLAYER.Nick
	local function NewPlayerNick(self, ...)
		if n_showclantags > 0 and !MENU_DLL then
			local clantag = nzDisplay.PlayerClanTag[self:EntIndex()]
			if clantag and (self:GetFriendStatus() == "friend" or (self == LocalPlayer()) or n_showclantags > 1) then
				return "["..clantag.."]"..nzDisplay.CachedNickFunc(self, ...)
			else
				return nzDisplay.CachedNickFunc(self, ...)
			end
		else
			return nzDisplay.CachedNickFunc(self, ...)
		end
	end

	function PLAYER:Nick(...)
		return NewPlayerNick(self, ...)
	end
end
