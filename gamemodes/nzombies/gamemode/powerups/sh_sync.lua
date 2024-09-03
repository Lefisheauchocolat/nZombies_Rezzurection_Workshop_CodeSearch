-- Client Server Syncing

if SERVER then

	-- Server to client (Server)
	util.AddNetworkString( "nzPowerUps.Sync" )
	util.AddNetworkString( "nzPowerUps.SyncPlayer" )
	util.AddNetworkString( "nzPowerUps.SyncPlayerFull" )
	util.AddNetworkString( "nzPowerUps.Nuke" ) -- See the nuke function in sv_powerups //OBSOLETE
	util.AddNetworkString( "nzPowerUps.PickupHud" )
	util.AddNetworkString( "RenderMaxAmmo" )
	
	function nzPowerUps:SendSync(receiver)
		local data = table.Copy(self.ActivePowerUps)
		local data2 = table.Copy(self.ActiveAntiPowerUps)

		net.Start( "nzPowerUps.Sync" )
			net.WriteTable( data )
			net.WriteTable( data2 )
		return IsValid(receiver) and net.Send(receiver) or net.Broadcast()
	end

	function nzPowerUps:SendPlayerSync(ply, receiver)
		if !self.ActivePlayerPowerUps[ply] then self.ActivePlayerPowerUps[ply] = {} end
		local data = table.Copy(self.ActivePlayerPowerUps[ply])

		if !self.ActivePlayerAntiPowerUps[ply] then self.ActivePlayerAntiPowerUps[ply] = {} end
		local data2 = table.Copy(self.ActivePlayerAntiPowerUps[ply])

		net.Start("nzPowerUps.SyncPlayer")
			net.WriteEntity(ply)
			net.WriteTable(data)
			net.WriteTable(data2)
		return IsValid(receiver) and net.Send(receiver) or net.Broadcast()
	end
	
	function nzPowerUps:SendPlayerSyncFull(receiver)
		local data = table.Copy(self.ActivePlayerPowerUps)
		local data2 = table.Copy(self.ActivePlayerAntiPowerUps)

		net.Start("nzPowerUps.SyncPlayerFull")
			net.WriteTable(data)
			net.WriteTable(data2)
		return IsValid(receiver) and net.Send(receiver) or net.Broadcast()
	end
	
	FullSyncModules["PowerUps"] = function(ply)
		nzPowerUps:SendSync(ply)
		nzPowerUps:SendPlayerSyncFull(ply)
	end

end

if CLIENT then
	-- Server to client (Client)
	local function ReceivePowerupSync( length )
		local tab1 = net.ReadTable()
		local tab2 = net.ReadTable()

		nzPowerUps.ActivePowerUps = tab1
		nzPowerUps.ActiveAntiPowerUps = tab2
	end

	local function ReceivePowerupPlayerSync( length )
		local ply = net.ReadEntity()
		local tab1 = net.ReadTable()
		local tab2 = net.ReadTable()

		nzPowerUps.ActivePlayerPowerUps[ply] = tab1
		nzPowerUps.ActivePlayerAntiPowerUps[ply] = tab2
	end

	local function ReceivePowerupPlayerSyncFull( length )
		local tab1 = net.ReadTable()
		local tab2 = net.ReadTable()

		nzPowerUps.ActivePlayerPowerUps = tab1
		nzPowerUps.ActivePlayerAntiPowerUps = tab2
	end

	local function ReceiveNukeEffect() //OBSOLETE
		surface.PlaySound("nz_moo/powerups/nuke_flux.mp3") -- BOOM!
	end

	-- Receivers 
	net.Receive( "nzPowerUps.Sync", ReceivePowerupSync )
	net.Receive( "nzPowerUps.SyncPlayer", ReceivePowerupPlayerSync )
	net.Receive( "nzPowerUps.SyncPlayerFull", ReceivePowerupPlayerSyncFull )
	net.Receive( "nzPowerUps.Nuke", ReceiveNukeEffect )
end