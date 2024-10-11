if SERVER then
	util.AddNetworkString( "nzMapping.SyncSettings" )

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
end

if CLIENT then
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

		//register display type of starting pistol, for reasons
		local class = nzMapping.Settings.startwep
		if class then
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
		if nzMapping.Settings.rboxweps then
			local model = ClientsideModel("models/hoff/props/teddy_bear/teddy_bear.mdl")
			for k,v in pairs(nzMapping.Settings.rboxweps) do
				local wep = weapons.Get(k)
				if wep and (wep.WM or wep.WorldModel) then
					util.PrecacheModel(wep.WM or wep.WorldModel)
					model:SetModel(wep.WM or wep.WorldModel)
				end
			end
			model:Remove()
		end

		if nzMapping.Settings.wunderfizzperklist then
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

	function nzMapping:SendMapData( data )
		if data then
			net.Start("nzMapping.SyncSettings")
				net.WriteTable(data)
			net.SendToServer()
		end
	end
end
