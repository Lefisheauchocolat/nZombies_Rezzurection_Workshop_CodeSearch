if SERVER then
	function nzDigs:IncrementZombieBloodSpawned()
		nzDigs.dig_n_zombie_bloods_spawned = nzDigs.dig_n_zombie_bloods_spawned + 1
	end

	function nzDigs:UpdateSettings(data)
		if not data then return end

		if data.whitelist then
			nzDigs.weapons_dig_list = data.whitelist

			nzDigs:SyncWeaponList(nzDigs.weapons_dig_list)
		end
	end
end

if CLIENT then
	function nzDigs:UpdateSettings(data)
		if data then
			net.Start("nzDigs.SyncToServer")
				net.WriteTable(data)
			net.SendToServer()
		end
	end
end