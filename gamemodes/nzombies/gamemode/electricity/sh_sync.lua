-- Client Server Syncing

if SERVER then

	-- Server to client (Server)
	util.AddNetworkString( "nz.nzElec.Sync" )
	util.AddNetworkString( "nz.nzElec.Sound" )
	
	function nzElec:SendSync(ply)
		net.Start( "nz.nzElec.Sync" )
			net.WriteBool(self.Active)
		return IsValid(ply) and net.Send(ply) or net.Broadcast()
	end
	
	FullSyncModules["Elec"] = function(ply)
		nzElec:SendSync(ply)
	end

end

if CLIENT then
	
	-- Server to client (Client)
	local function ReceiveSync( length )
		local active = net.ReadBool()
		nzElec.Active = active
	end
	
	local function RecievePowerSound()
		local on = net.ReadBool()
		--print(on)
		if on then
			local snd = "nz/machines/power_up.wav"

			if !table.IsEmpty(nzSounds.Sounds.Custom.Poweron) then
				snd = tostring(nzSounds.Sounds.Custom.Poweron[math.random(#nzSounds.Sounds.Custom.Poweron)])
			end
			
			surface.PlaySound(snd)
		else
			surface.PlaySound("nz/machines/power_down.wav")
		end
	end
	
	-- Receivers 
	net.Receive( "nz.nzElec.Sync", ReceiveSync )
	net.Receive( "nz.nzElec.Sound", RecievePowerSound )


end