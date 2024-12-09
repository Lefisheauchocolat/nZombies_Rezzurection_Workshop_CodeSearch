if SERVER then
	util.AddNetworkString( "nzCamos.Generate" )
	util.AddNetworkString( "nzCamos.SyncFix" )
	util.AddNetworkString( "nzCamos.Generate3p" )
	util.AddNetworkString( "nzCamos.SyncFix3p" )
	util.AddNetworkString( "nzCamos.Request" )
	util.AddNetworkString( "nzCamos.Update" )

	local load_queue_3p_sv = {}
	local load_queue_sv = {}
	local queued_weapons = {}

	function nzCamos:GenerateCamo(ply, wep)
		if not IsValid(wep) or not IsValid(ply) then return end

		if wep.NZCamoBlacklist then return end
		if wep.PreDrawViewModel then
			local info = debug.getinfo(wep.PreDrawViewModel)
			local weapon = file.Read(info.short_src, true)
			local weptab = string.Split(weapon, '\n')

			for i=info.linedefined + 1, info.lastlinedefined - 1 do
				if string.find(weptab[i], "SetSubMaterial") then 
					return
				end
			end
		end

		if !load_queue_sv[ply] then
			load_queue_sv[ply] = {}
		end

		local data = {wep = wep, velements = {}}

		if wep.IsTFAWeapon and wep.VElements then
			for k, v in pairs(wep.VElements) do
				if not v.active then continue end
				table.insert(data.velements, k)
			end
		end

		table.insert(load_queue_sv[ply], data)

		if !queued_weapons[wep] then
			queued_weapons[wep] = true
		end
	end

	function nzCamos:Generate3pCamo(ply, wep)
		if !load_queue_3p_sv[ply] then
			load_queue_3p_sv[ply] = {}
		end

		local wdata = {wep = wep, welements = {}}

		if wep.IsTFAWeapon and wep.WElements then
			for k, v in pairs(wep.WElements) do
				if not v.active then continue end
				table.insert(wdata.welements, k)
			end
		end

		table.insert(load_queue_3p_sv[ply], wdata)

		if !queued_weapons[wep] then
			queued_weapons[wep] = true
		end
	end

	function nzCamos:UpdatePlayerViewmodel(ply, model)
		net.Start("nzCamos.Update")
			net.WriteString(model)
		net.Send(ply)
	end

	hook.Add("SetupMove", "nzCamos.SyncCamos", function( ply, _, cmd )
		if load_queue_3p_sv[ply] and not cmd:IsForced() then
			for k, data in pairs(load_queue_3p_sv[ply]) do
				local wep = data.wep
				if IsValid(wep) and ply:HasWeapon(wep:GetClass()) then
					local welements = data.welements
					if table.IsEmpty(welements) then
						net.Start("nzCamos.Generate3p")
							net.WriteInt(wep:EntIndex(), 16)
							net.WriteBool(false)
						net.Broadcast()
					else
						net.Start("nzCamos.Generate3p")
							net.WriteInt(wep:EntIndex(), 16)
							net.WriteBool(true)
							net.WriteTable(welements)
						net.Broadcast()
					end

					load_queue_3p_sv[ply][k] = nil
					if table.IsEmpty(load_queue_3p_sv[ply]) then
						load_queue_3p_sv[ply] = nil
					end
					break
				end
			end
		end

		if load_queue_sv[ply] and not cmd:IsForced() then
			for k, data in pairs(load_queue_sv[ply]) do
				local wep = data.wep
				if IsValid(wep) and ply:HasWeapon(wep:GetClass()) then
					local vels = data.velements
					if table.IsEmpty(vels) then
						net.Start("nzCamos.Generate")
							net.WriteInt(wep:EntIndex(), 16)
							net.WriteBool(false)
						net.Send(ply)
					else
						net.Start("nzCamos.Generate")
							net.WriteInt(wep:EntIndex(), 16)
							net.WriteBool(true)
							net.WriteTable(vels)
						net.Send(ply)
					end

					load_queue_sv[ply][k] = nil
					if table.IsEmpty(load_queue_sv[ply]) then
						load_queue_sv[ply] = nil
					end
					break
				end
			end
		end
	end)

	hook.Add("EntityRemoved", "nzCamos.SyncCamos", function(wep)
		if queued_weapons[wep] then
			local ply = wep:GetOwner()
			if IsValid(ply) and ply:IsPlayer() then
				net.Start("nzCamos.SyncFix")
					net.WriteInt(wep:EntIndex(), 16)
				net.Send(ply)
			end

			net.Start("nzCamos.SyncFix3p")
				net.WriteInt(wep:EntIndex(), 16)
			net.Broadcast()

			queued_weapons[wep] = nil
		end
	end)

	net.Receive("nzCamos.Request", function(len, ply)
		local wep = net.ReadEntity()
		if not IsValid(wep) then return end
		nzCamos:GenerateCamo(ply, wep)
		nzCamos:UpdatePlayerViewmodel(ply, wep:GetWeaponViewModel())
	end)
end

if CLIENT then
	local cvar_papcamo = GetConVar("nz_papcamo")

	net.Receive("nzCamos.Update", function(len, ply)
		if not cvar_papcamo:GetBool() then return end
		local model = net.ReadString()
		nzCamos:UpdatePlayerViewmodel(ply, model)
	end)

	function nzCamos:UpdatePlayerViewmodel(ply, model)
		nzCamos.ViewmodelsToUpdate[model] = true
	end

	local developer = GetConVar("developer")

	local function IsGoodMaterial(name)
		local bannedmatnames = {
			"_scope", "_sight",
			"_optic", "reticle", "_lens",
			"_glow", "tritium", "_glass"
		}

		for k, v in pairs(bannedmatnames) do
			if string.find(name, v) then
				return false
			end
		end

		return true
	end

	local function IsGoodMaterialKey(mat)
		local bannedkeys = {
			["$emissiveblendenabled"] = true,
		}

		local bannedflagval = {
			[2097152] = true,
			[256] = true,
			[128] = true,
			[64] = true,
			[4] = true,
		}

		for k, v in pairs(mat:GetKeyValues()) do
			if tostring(k) == "$flags" and bannedflagval[tonumber(v)] then
				return false
			end

			if bannedkeys[tostring(k)] and v == 1 then
				return false
			end

			/*if tostring(k) == "$detail" then //causes false positives with viewmodel stain mods
				return false
			end*/
		end

		if mat:GetShader() == "UnlitGeneric" then
			return false
		end

		return true
	end

	local cmdl

	local function GenerateVElementCamo(wep, element)
		if not IsValid(wep) then return end
		if not wep.IsTFAWeapon or not wep.VElements then return end

		if not wep.VPaPOverrideMat or table.IsEmpty(wep.VPaPOverrideMat) then
			wep.VPaPOverrideMat = {}

			local model = wep.VElements[element].model
			if model and util.IsValidModel(model) then
				cmdl = ClientsideModel(model)
				if IsValid(cmdl) then
					local mats = cmdl:GetMaterials()
					for k, v in pairs(mats) do
						if /*IsGoodMaterial(v) and*/ IsGoodMaterialKey(Material(v)) then
							if !wep.VPaPOverrideMat[model] then
								wep.VPaPOverrideMat[model] = {}
							end

							wep.VPaPOverrideMat[model][k - 1] = true
						end
					end
					cmdl:Remove()
				end
			end
		end
	end

	local function GenerateWElementCamo(wep, element)
		if not IsValid(wep) then return end
		if not wep.IsTFAWeapon or not wep.WElements then return end

		if not wep.WPaPOverrideMat or table.IsEmpty(wep.WPaPOverrideMat) then
			wep.WPaPOverrideMat = {}

			local model = wep.WElements[element].model
			if model and util.IsValidModel(model) then
				cmdl = ClientsideModel(model)
				if IsValid(cmdl) then
					local mats = cmdl:GetMaterials()
					for k, v in pairs(mats) do
						if IsGoodMaterial(v) and IsGoodMaterialKey(Material(v)) then
							if !wep.WPaPOverrideMat[model] then
								wep.WPaPOverrideMat[model] = {}
							end

							wep.WPaPOverrideMat[model][k - 1] = true
						end
					end
					cmdl:Remove()
				end
			end
		end
	end

	local function GenerateCamo(wep, velements)
		if not IsValid(wep) then return end
		wep.PaPOverrideMat = {}

		cmdl = ClientsideModel(wep:GetWeaponViewModel())
		local dev = developer:GetInt() > 0
		if dev then print("------------------------------------------------") print(cmdl) print(wep:GetWeaponViewModel())end
		if IsValid(cmdl) then
			local mats = cmdl:GetMaterials()
			if dev then PrintTable(mats) end

			for k, v in pairs(mats) do
				if IsGoodMaterial(v) and IsGoodMaterialKey(Material(v)) then
					if dev then print(k, v) end
					wep.PaPOverrideMat[k - 1] = true
				end
			end
			cmdl:Remove()
		end

		if not table.IsEmpty(velements) then
			for _, element in pairs(velements) do
				GenerateVElementCamo(wep, element)
			end
		end
	end

	local function Generate3pCamo(wep, welements)
		if not IsValid(wep) then return end

		wep.TPaPOverrideMat = {}

		local mats = wep:GetMaterials()
		local dev = developer:GetInt() > 0
		if dev then print("------------------------------------------------") print(wep) print(wep:GetWeaponWorldModel()) PrintTable(mats) end

		for k, v in pairs(mats) do
			if IsGoodMaterial(v) and IsGoodMaterialKey(Material(v)) then
				if dev then print(k, v) end
				wep.TPaPOverrideMat[k - 1] = true
			end
		end

		if not table.IsEmpty(welements) then
			for _, element in pairs(welements) do
				GenerateWElementCamo(wep, element)
			end
		end
	end

	//hopefully this fixes things randomly not working on the client
	local load_queue_cl = {}
	local load_queue_3p = {}

	local function ReceiveSync( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local wepid = net.ReadInt(16)
		local bool = net.ReadBool()
		local velements = bool and net.ReadTable() or {}

		if developer:GetBool() then
			print('Firstperson camo generation received...')
		end

		if !load_queue_cl[ply] then
			load_queue_cl[ply] = {}
		end

		local data = {wep = wepid, velements = velements}
		table.insert(load_queue_cl[ply], data)
	end

	local function ReceiveSyncFix( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local wepid = net.ReadInt(16)

		if !load_queue_cl[ply] then return end

		for k, data in pairs(load_queue_cl[ply]) do
			if data.wep and data.wep == wepid then
				load_queue_cl[ply][k] = nil
				if table.IsEmpty(load_queue_cl[ply]) then
					load_queue_cl[ply] = nil
				end
				break
			end
		end
	end

	local function Receive3pSync( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local wepid = net.ReadInt(16)
		local bool = net.ReadBool()
		local welements = bool and net.ReadTable() or {}

		if developer:GetBool() then
			print('Thirdperson camo generation received...')
		end

		if !load_queue_3p[ply] then
			load_queue_3p[ply] = {}
		end

		local data = {wep = wepid, welements = welements}
		table.insert(load_queue_3p[ply], data)
	end

	local function Receive3pSyncFix( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local wepid = net.ReadInt(16)

		if !load_queue_3p[ply] then return end

		for k, data in pairs(load_queue_3p[ply]) do
			if data.wep and data.wep == wepid then
				load_queue_3p[ply][k] = nil
				if table.IsEmpty(load_queue_3p[ply]) then
					load_queue_3p[ply] = nil
				end
				break
			end
		end
	end

	hook.Add("Think", "nzCamos.SyncCamos", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if load_queue_3p[ply] then
			for k, data in pairs(load_queue_3p[ply]) do
				local wep = Entity(data.wep)
				if IsValid(wep) and wep:IsWeapon() then
					if not data.halt then data.halt = true continue end //acts as a delay
					local own = wep:GetOwner()
					if developer:GetBool() and IsValid(own) then
						print("Thirdperson camo generated for "..(own:IsPlayer() and own:Nick() or own:GetClass()).."'s "..wep.PrintName)
					end

					Generate3pCamo(wep, data.welements)

					load_queue_3p[ply][k] = nil
					if table.IsEmpty(load_queue_3p[ply]) then
						load_queue_3p[ply] = nil
					end
					break
				end
			end
		end

		if load_queue_cl[ply] then
			for k, data in pairs(load_queue_cl[ply]) do
				local wep = Entity(data.wep)
				if IsValid(wep) and wep:IsWeapon() then
					local own = wep:GetOwner()
					if developer:GetBool() and IsValid(own) then
						print("Firstperson camo generated for "..(own:IsPlayer() and own:Nick() or own:GetClass()).."'s "..wep.PrintName)
					end

					GenerateCamo(wep, data.velements)
					nzCamos:UpdatePlayerViewmodel(ply, wep:GetWeaponViewModel())

					load_queue_cl[ply][k] = nil
					if table.IsEmpty(load_queue_cl[ply]) then
						load_queue_cl[ply] = nil
					end
					break
				end
			end
		end
	end)

	net.Receive("nzCamos.Generate", ReceiveSync)
	net.Receive("nzCamos.SyncFix", ReceiveSyncFix)

	net.Receive("nzCamos.Generate3p", Receive3pSync)
	net.Receive("nzCamos.SyncFix3p", Receive3pSyncFix)
end