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
					net.WriteBool(true)
					net.WriteString(data.wep)
				net.Send(ply)

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
					net.WriteBool(false)
				net.Send(ply)

				load_queue_remove[ply][k] = nil
				if table.IsEmpty(load_queue_remove[ply]) then
					load_queue_remove[ply] = nil
				end
			end
		end
	end)

	hook.Add("EntityRemoved", "nZ.SpecialWepSync", function(wep)
		if queued_weapons[wep] and IsValid(wep:GetOwner()) then
			nzSpecialWeapons:SendSpecialWeaponRemoved(wep:GetOwner(), queued_weapons[wep])
			queued_weapons[wep] = nil
		end
	end)
end

if CLIENT then
	//hopefully this fixes things randomly not working on the client
	local load_queue_cl = {}

	local function ReceiveSpecialWeaponAdded()
		local id = net.ReadString()
		local bool = net.ReadBool()

		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if !load_queue_cl[ply] then
			load_queue_cl[ply] = {}
		end

		if bool then
			local class = net.ReadString()
			local data = {wep = class, id = id, bool = true}

			table.insert(load_queue_cl[ply], data)
		else
			local data = {id = id}
			table.insert(load_queue_cl[ply], data)
		end
	end

	hook.Add("Think", "nZ.SpecialWepSync", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if load_queue_cl[ply] then
			for k, data in pairs(load_queue_cl[ply]) do
				if data.bool then
					local wepid = tostring(data.wep)
					local id = data.id
					local wep = ply:GetWeapon(wepid)

					if IsValid(wep) then
						if !ply.NZSpecialWeapons then ply.NZSpecialWeapons = {} end
						ply.NZSpecialWeapons[id] = wep

						load_queue_cl[ply][k] = nil
						if table.IsEmpty(load_queue_cl[ply]) then
							load_queue_cl[ply] = nil
						end
						break
					end
				else
					local id = data.id
					if !ply.NZSpecialWeapons then ply.NZSpecialWeapons = {} end
					ply.NZSpecialWeapons[id] = nil

					load_queue_cl[ply][k] = nil
					if table.IsEmpty(load_queue_cl[ply]) then
						load_queue_cl[ply] = nil
					end
					break
				end
			end
		end
	end)

	net.Receive("nzSendSpecialWeapon", ReceiveSpecialWeaponAdded)
end