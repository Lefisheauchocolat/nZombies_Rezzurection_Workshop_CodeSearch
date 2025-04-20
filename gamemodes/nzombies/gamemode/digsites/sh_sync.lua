if SERVER then
	util.AddNetworkString("nzDigs.SyncSettings")
	util.AddNetworkString("nzDigs.SyncToServer")

	function nzDigs:SyncWeaponList(data, reciever)
		net.Start("nzDigs.SyncSettings")
			net.WriteTable(data)
		return reciever and net.Send(reciever) or net.Broadcast()
	end

	FullSyncModules["nzDigs"] = function(ply)
		if nzDigs.weapons_dig_list and not table.Empty(nzDigs.weapons_dig_list) then
			nzDigs:SyncWeaponList(nzDigs.weapons_dig_list, ply)
		end
	end

	local function receivedigdata(len, ply)
		local data = net.ReadTable()
		nzDigs:UpdateSettings(data)
	end
	net.Receive("nzDigs.SyncToServer", receivedigdata)
end

if CLIENT then
	local function ReceiveWeaponListUpdate( length )
		local data = net.ReadTable()
		if not data then return end

		nzDigs.weapons_dig_list = data
	end

	net.Receive("nzDigs.SyncSettings", ReceiveWeaponListUpdate)
end
