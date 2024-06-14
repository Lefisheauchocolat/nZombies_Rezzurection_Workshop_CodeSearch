if SERVER then
	util.AddNetworkString( "nzWeps.Sync" )
	util.AddNetworkString( "nzWeps.SyncFix" )

	local load_queue_sv = {}
	local queued_weapons = {}

	function nzWeps:SendSync(ply, wep, modifier, revert)
		if not IsValid(wep) or not modifier then return end
		if revert == nil then revert = false end
		local data = {wep = wep:EntIndex(), mod = modifier, revert = revert}

		if ply and IsValid(ply) then
			if !load_queue_sv[ply] then
				load_queue_sv[ply] = {}
			end
			table.insert(load_queue_sv[ply], data)

			//print('Send Sync Modifier')
		else
			net.Start( "nzWeps.Sync" )
				net.WriteInt(wep:EntIndex(), 16)
				net.WriteString(modifier)
				net.WriteBool(revert)
			net.Broadcast()

			//print('Send Sync Modifier No Player')
		end

		queued_weapons[wep] = true
	end

	hook.Add("SetupMove", "nzWeps.SyncModifiers", function( ply, _, cmd )
		if load_queue_sv[ply] and not cmd:IsForced() then
			for k, data in pairs(load_queue_sv[ply]) do
				local wep = Entity(data.wep)
				if IsValid(wep) and ply:HasWeapon(wep:GetClass()) then
					net.Start("nzWeps.Sync")
						net.WriteInt(data.wep, 16)
						net.WriteString(data.mod)
						net.WriteBool(data.revert)
					net.Broadcast()

					load_queue_sv[ply][k] = nil
					if table.IsEmpty(load_queue_sv[ply]) then
						load_queue_sv[ply] = nil
					end
					break
				end
			end
		end
	end)

	hook.Add("EntityRemoved", "nzWeps.SyncModifiers", function(wep)
		if queued_weapons[wep] then
			local ply = wep:GetOwner()
			if IsValid(ply) and ply:IsPlayer() then
				net.Start("nzWeps.SyncFix")
					net.WriteInt(wep:EntIndex(), 32)
				net.SendOmit(ply)

				queued_weapons[wep] = nil
			else
				net.Start("nzWeps.SyncFix")
					net.WriteInt(wep:EntIndex(), 32)
				net.Broadcast()

				queued_weapons[wep] = nil
			end
		end
	end)
end

if CLIENT then
	//hopefully this fixes things randomly not working on the client
	local load_queue_cl = {}

	local function ReceiveSync( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local wep = net.ReadInt(16)
		local mod = net.ReadString()
		local revert = net.ReadBool()

		if !load_queue_cl[ply] then
			load_queue_cl[ply] = {}
		end

		table.insert(load_queue_cl[ply], {wep = wep, mod = mod, revert = revert})
	end

	local function ReceiveSyncFix(length)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		local id = net.ReadInt(32)

		if !load_queue_cl[ply] then return end

		for k, data in pairs(load_queue_cl[ply]) do
			if data.wep and data.wep == id then
				load_queue_cl[ply][k] = nil
				if table.IsEmpty(load_queue_cl[ply]) then
					load_queue_cl[ply] = nil
				end
				break
			end
		end
	end

	hook.Add("Think", "nzWeps.SyncModifiers", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if load_queue_cl[ply] then
			for k, data in pairs(load_queue_cl[ply]) do
				local wepid = data.wep
				local mod = data.mod
				local revert = data.revert

				local wep = Entity(wepid)
				if IsValid(wep) and wep:IsWeapon() then
					local own = wep:GetOwner()

					if revert then
						if IsValid(own) and wep.PrintName then
							print("Reverting ["..mod.."] modifier for "..(own:IsPlayer() and own:Nick() or own:GetClass()).."'s "..wep.PrintName)
						end
						wep:RevertNZModifier(mod)
					else
						if IsValid(own) and wep.PrintName then
							print("Applying ["..mod.."] modifier for "..(own:IsPlayer() and own:Nick() or own:GetClass()).."'s "..wep.PrintName)
						end
						wep:ApplyNZModifier(mod)
					end

					load_queue_cl[ply][k] = nil
					if table.IsEmpty(load_queue_cl[ply]) then
						load_queue_cl[ply] = nil
					end
					break
				end
			end
		end
	end)

	-- Receivers
	net.Receive( "nzWeps.Sync", ReceiveSync )
	net.Receive( "nzWeps.SyncFix", ReceiveSyncFix )
end
