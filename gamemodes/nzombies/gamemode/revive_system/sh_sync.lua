-- Client Server Syncing

if SERVER then

	util.AddNetworkString( "nzRevivePlayerFull" )
	util.AddNetworkString( "nzRevivePlayerDowned" )
	util.AddNetworkString( "nzRevivePlayerRevived" )
	util.AddNetworkString( "nzRevivePlayerBeingRevived" )
	util.AddNetworkString( "nzRevivePlayerKilled" )


	function nzRevive:SendPlayerFullData(ply, receiver)
		local data = table.Copy(self.Players[ply:EntIndex()])

		net.Start( "nzRevivePlayerFull" )
			net.WriteInt(ply:EntIndex(), 13)
			net.WriteTable( data )
		return receiver and net.Send(receiver) or net.Broadcast()
	end

	function nzRevive:SendPlayerDowned(ply, receiver, attdata)
		//print("Sent")
		attdata = attdata or {}
		net.Start( "nzRevivePlayerDowned" )
			net.WriteInt(ply:EntIndex(), 13)
			net.WriteTable(attdata)
		return receiver and net.Send(receiver) or net.Broadcast()
	end

	function nzRevive:SendPlayerRevived(ply, receiver)
		net.Start( "nzRevivePlayerRevived" )
			net.WriteInt(ply:EntIndex(), 13)
		return receiver and net.Send(receiver) or net.Broadcast()
	end

	function nzRevive:SendPlayerBeingRevived(ply, revivor, receiver)
		net.Start( "nzRevivePlayerBeingRevived" )
			local id = ply:EntIndex()
			net.WriteInt(id, 13)
			if IsValid(revivor) then
				net.WriteBool(true)
				net.WriteInt(revivor:EntIndex(), 13)
				net.WriteFloat(nzRevive.Players[id].ReviveLength)
			else -- No valid revivor means the player stopped being revived
				net.WriteBool(false)
			end
		return receiver and net.Send(receiver) or net.Broadcast()
	end

	function nzRevive:SendPlayerKilled(ply, receiver)
		net.Start( "nzRevivePlayerKilled" )
			net.WriteInt(ply:EntIndex(), 13)
		return receiver and net.Send(receiver) or net.Broadcast()
	end

	FullSyncModules["Revive"] = function(ply)
		for k,v in pairs(player.GetAll()) do
			if !v:GetNotDowned() then -- Player needs to be downed
				nzRevive:SendPlayerFullData(v, ply)
			end
		end
	end
end

if CLIENT then
	local function ReceivePlayerDowned()
		--print("Gotten")
		local id = net.ReadInt(13)
		local attached = net.ReadTable()

		nzRevive.Players[id] = nzRevive.Players[id] or {}
		nzRevive.Players[id].DownTime = CurTime()

		for k,v in pairs(attached) do
			//print(k,v)
			nzRevive.Players[id][k] = v
		end

		local ply = Entity(id)
		if IsValid(ply) and ply:IsPlayer() then
			--ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_HL2MP_SWIM_PISTOL)
			nzRevive:DownedHeadsUp(ply, "needs to be revived!")
		end
	end

	local function ReceivePlayerRevived()
		local id = net.ReadInt(13)
		nzRevive.Players[id] = nil
		local ply = Entity(id)
		if IsValid(ply) and ply:IsPlayer() then
			--ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
			if ply == LocalPlayer() then nzRevive:ResetColorFade() end
			nzRevive:DownedHeadsUp(ply, "has been revived!")
		end
	end

	local function ReceivePlayerBeingRevived()
		local id = net.ReadInt(13)
		local bool = net.ReadBool()
		if bool then
			local reviving = Entity(id)
			local revivor = Entity(net.ReadInt(13))
			nzRevive.Players[id] = nzRevive.Players[id] or {}
			if !nzRevive.Players[id].ReviveTime then
				nzRevive.Players[id].ReviveTime = CurTime()

				local bleedtime = reviving.GetBleedoutTime and reviving:GetBleedoutTime() or cvar_bleedout:GetFloat()

				nzRevive.Players[id].KillTime = (nzRevive.Players[id].DownTime + bleedtime) - CurTime()
				nzRevive.Players[id].RevivePlayer = revivor
				revivor.Reviving = reviving
				nzRevive.Players[id].ReviveLength = net.ReadFloat(13)
			end
		else
			local revivor = nzRevive.Players[id].RevivePlayer
			if IsValid(revivor) then revivor.Reviving = nil end
			
			nzRevive.Players[id] = nzRevive.Players[id] or {}
			nzRevive.Players[id].ReviveTime = nil
			nzRevive.Players[id].RevivePlayer = nil
			nzRevive.Players[id].KillTime = nil
			nzRevive.Players[id].ReviveLength = nil
		end
	end

	local function ReceivePlayerKilled()
		local id = net.ReadInt(13)
		
		local revivor = nzRevive.Players[id].RevivePlayer
		if IsValid(revivor) then revivor.Reviving = nil end
		
		nzRevive.Players[id] = nil
		local ply = Entity(id)
		if IsValid(ply) and ply:IsPlayer() then
		ply:StopSound("nzrevive/laststand_lp.wav")
			--ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)
			if ply == LocalPlayer() then nzRevive:ResetColorFade() end
			nzRevive:DownedHeadsUp(ply, "has died!")
		end
	end

	local function ReceiveFullPlayerSync()
		local id = net.ReadInt(13)
		local data = net.ReadTable()
		nzRevive.Players[id] = data
		
		local ply = Entity(id)
		local revivor = data.RevivePlayer
		if IsValid(revivor) then revivor.Reviving = ply end
		
		if IsValid(ply) and ply:IsPlayer() then
			--ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, ACT_HL2MP_SWIM_PISTOL)
			nzRevive:DownedHeadsUp(ply, "has been downed!")
		end
	end

	-- Receivers
	net.Receive( "nzRevivePlayerDowned", ReceivePlayerDowned )
	net.Receive( "nzRevivePlayerRevived", ReceivePlayerRevived )
	net.Receive( "nzRevivePlayerBeingRevived", ReceivePlayerBeingRevived )
	net.Receive( "nzRevivePlayerKilled", ReceivePlayerKilled )
	net.Receive( "nzRevivePlayerFull", ReceiveFullPlayerSync )
end
