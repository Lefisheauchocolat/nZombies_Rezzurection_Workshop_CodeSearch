if SERVER then
	util.AddNetworkString( "nzMapping.SyncSettings" )
	util.AddNetworkString( "nzMapping.SyncSingle" )

	local developer = GetConVar("developer")
	local function receiveMapData(len, ply)
		local tbl = net.ReadTable()
		if developer:GetBool() then
			PrintTable(tbl)
		end
		nzMapping:LoadMapSettings(tbl)
		-- nzMapping.Settings = tbl
	end
	net.Receive( "nzMapping.SyncSettings", receiveMapData )

	function nzMapping:SendMapData(ply)
		if !self.GamemodeExtensions then self.GamemodeExtensions = {} end
		net.Start("nzMapping.SyncSettings")
			net.WriteTable(self.Settings)
		return IsValid(ply) and net.Send(ply) or net.Broadcast()
	end

	//be careful using this, while *most* vars should work fine being changed mid game
	//there are a handful that the data for is used only once on round begin
	//unexpected things may occur or just not work

	function nzMapping:SendMapDataSingle(name, var, ply)
		net.Start("nzMapping.SyncSingle")
			net.WriteString(name)
			net.WriteType(var)
		return IsValid(ply) and net.Send(ply) or net.Broadcast()
	end

	util.AddNetworkString("nzPlayerClientStartup")

	local load_queue = {}
	net.Receive("nzPlayerClientStartup", function(len, ply)
		load_queue[ply] = true
	end)

	hook.Add("SetupMove", "nzPlayerClientStartup", function( ply, _, cmd )
		if load_queue[ply] and not cmd:IsForced() then
			if isnumber(load_queue[ply]) and load_queue[ply] < CurTime() then //first send mapdata, then sync modules
				//print(CurTime())
				print('Sent module sync to '..ply:Nick())
				load_queue[ply] = nil
				nzPlayers:FullSync(ply)
			elseif not isnumber(load_queue[ply]) then
				//print(CurTime())
				print('Sent map data to '..ply:Nick())
				nzMapping:SendMapData(ply)
				load_queue[ply] = CurTime() + (ply:Ping()*0.01) + engine.TickInterval()
			end
		end
	end)
end

if CLIENT then
	//lawyers hate this one easy trick
	hook.Add("Think", "nzPlayerClientStartup", function()
		hook.Remove("Think", "nzPlayerClientStartup")

		net.Start("nzPlayerClientStartup")
		net.SendToServer()
	end)

	local lastconfig = ""
	local b_displayhack = false
	local b_hascachedguns = false
	local b_hascachedperks = false

	local function cleanUpMap()
		game.CleanUpMap()
	end

	net.Receive("nzCleanUp", cleanUpMap )

	local function receiveMapData()
		if ispanel(nzQMenu.Data.MainFrame) then -- New config was loaded, refresh config menu
			nzQMenu.Data.MainFrame:Remove()
		end

		local oldeeurl = nzMapping.Settings.eeurl or ""
		nzMapping.Settings = net.ReadTable()

		if !EEAudioChannel or (oldeeurl != nzMapping.Settings.eeurl and nzMapping.Settings.eeurl) then
			EasterEggData.ParseSong()
		end

		if lastconfig ~= nzMapping.CurrentConfig then
			lastconfig = nzMapping.CurrentConfig
			b_displayhack = false
			b_hascachedguns = false
			b_hascachedperks = false
		end

		//register display type of starting pistol, for reasons
		local class = nzMapping.Settings.startwep
		if class and !b_displayhack then
			b_displayhack = true

			local wep = weapons.Get(class)
			if wep then
				if nzSpecialWeapons:ModifyWeapon(wep, "display", {DrawFunction = false, ToHolsterFunction = function(wep) return false end}) then
					wep.Category = "Other"
					wep.StoredNZAmmo = wep.Primary.ClipSize*4
					wep.NZSpecialShowHUD = true
					wep.NZTotalBlacklist = true
					wep.NZCamoBlacklist = true
					wep.NZSpecialCategory = "display"
					wep.NZSpecialWeaponData = {MaxAmmo = wep.Primary.ClipSize*4, AmmoType = wep.Primary.Ammo}
					weapons.Register(wep, class.."_display")
				end
			end
		end

		-- Precache all random box weapons in the list
		if nzMapping.Settings.rboxweps and !b_hascachedguns then
			b_hascachedguns = true

			local boxguns = table.Copy(nzMapping.Settings.rboxweps)
			if nzMapping.Settings.deathmachine then
				boxguns[nzMapping.Settings.deathmachine] = true
			end
			if nzMapping.Settings.startwep then
				boxguns[nzMapping.Settings.startwep] = true
			end
			if nzMapping.Settings.grenade then
				boxguns[nzMapping.Settings.grenade] = true
			end
			if nzMapping.Settings.knife then
				boxguns[nzMapping.Settings.knife] = true
			end
			if nzMapping.Settings.bottle then
				boxguns[nzMapping.Settings.bottle] = true
			end
			if nzMapping.Settings.shield then
				boxguns[nzMapping.Settings.shield] = true
			end

			local model = ClientsideModel("models/hoff/props/teddy_bear/teddy_bear.mdl")
			for k, v in pairs(boxguns) do
				local wep = weapons.Get(k)
				if wep then
					if (wep.WM or wep.WorldModel) then
						util.PrecacheModel(wep.WM or wep.WorldModel)
						model:SetModel(wep.WM or wep.WorldModel)
					end
					if (wep.VM or wep.ViewModel) then
						util.PrecacheModel(wep.VM or wep.ViewModel)
						model:SetModel(wep.VM or wep.ViewModel)
					end
				end
			end
			model:Remove()
		end

		if nzMapping.Settings.wunderfizzperklist and !b_hascachedperks then
			b_hascachedperks = true

			local model = ClientsideModel("models/hoff/props/teddy_bear/teddy_bear.mdl")
			for k, v in pairs(nzMapping.Settings.wunderfizzperklist) do
				if !v[1] then continue end

				local pdata = nzPerks:Get(k)
				if pdata and pdata.model then
					util.PrecacheModel(pdata.model)
					model:SetModel(pdata.model)
				end
			end
			model:Remove()
		end
	end
	net.Receive( "nzMapping.SyncSettings", receiveMapData )

	local function receiveMapDataSingle()
		local k = net.ReadString()
		nzMapping.Settings[k] = net.ReadType()
	end
	net.Receive( "nzMapping.SyncSingle", receiveMapDataSingle )

	function nzMapping:SendMapData( data )
		if data then
			net.Start("nzMapping.SyncSettings")
				net.WriteTable(data)
			net.SendToServer()
		end
	end
end
