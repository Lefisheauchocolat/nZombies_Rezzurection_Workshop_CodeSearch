if SERVER then
	util.AddNetworkString("nzSendSpecialWeapon")

	local load_queue_add = {}
	local load_queue_remove = {}
	local queued_weapons = {}

	function nzSpecialWeapons:SendSpecialWeaponAdded(ply, wep, id)
		if IsValid(ply) then
			if !load_queue_add[ply] then
				load_queue_add[ply] = {}
			end

			local data = {wep = wep:GetClass(), id = id}
			table.insert(load_queue_add[ply], data)

			queued_weapons[wep] = id
		end
	end

	function nzSpecialWeapons:SendSpecialWeaponRemoved(ply, id)
		if IsValid(ply) then
			if !load_queue_remove[ply] then
				load_queue_remove[ply] = {}
			end

			local data = {id = id}
			table.insert(load_queue_remove[ply], data)
		end
	end

	hook.Add("SetupMove", "nZ.SpecialWepSync", function( ply, _, cmd )
		if load_queue_add[ply] and not cmd:IsForced() then
			for k, data in pairs(load_queue_add[ply]) do
				net.Start("nzSendSpecialWeapon")
					net.WriteString(data.id)
					net.WriteUInt(ply:EntIndex(), 8)
					net.WriteBool(true)
					net.WriteString(data.wep)
				net.Broadcast()

				load_queue_add[ply][k] = nil
				if table.IsEmpty(load_queue_add[ply]) then
					load_queue_add[ply] = nil
				end
			end
		end

		if load_queue_remove[ply] and not cmd:IsForced() then
			for k, data in pairs(load_queue_remove[ply]) do
				net.Start("nzSendSpecialWeapon")
					net.WriteString(data.id)
					net.WriteUInt(ply:EntIndex(), 8)
					net.WriteBool(false)
				net.Broadcast()

				load_queue_remove[ply][k] = nil
				if table.IsEmpty(load_queue_remove[ply]) then
					load_queue_remove[ply] = nil
				end
			end
		end
	end)

	hook.Add("EntityRemoved", "nZ.SpecialWepSync", function(wep, fullUpdate)
		if ( fullUpdate ) then return end

		if queued_weapons[wep] and IsValid(wep:GetOwner()) then
			nzSpecialWeapons:SendSpecialWeaponRemoved(wep:GetOwner(), queued_weapons[wep])
			queued_weapons[wep] = nil
		end
	end)

	//sync other players special weapons for spectator and hud related stuff
	FullSyncModules["SpecialWeapons"] = function(ply)
		for k, v in ipairs(player.GetAll()) do
			if v:EntIndex() == ply:EntIndex() then continue end
			if not v.NZSpecialWeapons or not istable(v.NZSpecialWeapons) then continue end

			for category, wep in pairs(v.NZSpecialWeapons) do
				if wep and IsValid(wep) then
					net.Start("nzSendSpecialWeapon")
						net.WriteString(category)
						net.WriteUInt(v:EntIndex(), 8)
						net.WriteBool(true)
						net.WriteString(wep:GetClass())
					net.Send(ply)
				end
			end
		end
	end
end

if CLIENT then
	//hopefully this fixes things randomly not working on the client
	local load_queue_cl = {}

	local function ReceiveSpecialWeaponAdded()
		local id = net.ReadString()
		local index = net.ReadUInt(8)
		local bool = net.ReadBool()

		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if !load_queue_cl[ply] then
			load_queue_cl[ply] = {}
		end

		if bool then
			local class = net.ReadString()
			local data = {wep = class, id = id, bool = true, ply = index}

			table.insert(load_queue_cl[ply], data)
		else
			local data = {id = id, ply = index}
			table.insert(load_queue_cl[ply], data)
		end
	end

	hook.Add("EntityRemoved", "nZ.SpecialWepFix", function(ply, fullUpdate)
		if ( fullUpdate ) then return end
		if not ply:IsPlayer() then return end

		local ourply = LocalPlayer()
		if !load_queue_cl[ourply] then return end

		for k, data in pairs(load_queue_cl[ourply]) do
			if data.ply and data.ply == ply:EntIndex() then
				load_queue_cl[ourply][k] = nil
				if table.IsEmpty(load_queue_cl[ourply]) then
					load_queue_cl[ourply] = nil
				end
			end
		end
	end)

	hook.Add("Think", "nZ.SpecialWepSync", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if load_queue_cl[ply] then
			for k, data in pairs(load_queue_cl[ply]) do
				if data.bool then
					local class = tostring(data.wep)
					local ourply = Entity(data.ply)

					if IsValid(ourply) then
						local id = data.id
						local wep = ourply:GetWeapon(class)

						if IsValid(wep) then
							if !ourply.NZSpecialWeapons then ourply.NZSpecialWeapons = {} end
							ourply.NZSpecialWeapons[id] = wep

							load_queue_cl[ply][k] = nil
							if table.IsEmpty(load_queue_cl[ply]) then
								load_queue_cl[ply] = nil
							end
							break
						end
					end
				else
					local id = data.id
					local ourply = Entity(data.ply)

					if IsValid(ourply) then
						if !ourply.NZSpecialWeapons then ourply.NZSpecialWeapons = {} end
						ourply.NZSpecialWeapons[id] = nil

						load_queue_cl[ply][k] = nil
						if table.IsEmpty(load_queue_cl[ply]) then
							load_queue_cl[ply] = nil
						end
						break
					end
				end
			end
		end
	end)

	net.Receive("nzSendSpecialWeapon", ReceiveSpecialWeaponAdded)
end