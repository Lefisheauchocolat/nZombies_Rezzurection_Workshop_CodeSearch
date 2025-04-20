-- Main Tables
nzLocker = nzLocker or AddNZModule("Locker")

nzLocker.HasKey = false
nzLocker.KeyIcon = Material("vgui/icon/zom_hud_icon_key.png", "unlitgeneric smooth")
nzLocker.KeyConsume = false
nzLocker.UsedKeys = {}

if SERVER then
	util.AddNetworkString("nzLocker.SyncKeys")
	util.AddNetworkString("nzLocker.HudUpdate")

	function nzLocker:PickupKey(ent)
		nzLocker.HasKey = ent:GetFlag()
		net.Start("nzLocker.SyncKeys")
			net.WriteBool(true)
		net.Broadcast()

		if IsValid(ent) and ent.GetHudIcon then
			net.Start("nzLocker.HudUpdate")
				net.WriteString(ent:GetHudIcon())
			net.Broadcast()
		end

		if nzLocker.KeyConsume and IsValid(ent) then
			table.insert(nzLocker.UsedKeys, ent)
		end
	end

	function nzLocker:UseKey()
		nzLocker.HasKey = false
		net.Start("nzLocker.SyncKeys")
			net.WriteBool(false)
		net.Broadcast()
		nzLocker:RespawnKey()
	end

	function nzLocker:RespawnKey()
		local keys = ents.FindByClass("nz_keyspawn")
		if not IsValid(keys[1]) then return end

		for k, v in pairs(keys) do
			v:Trigger()
		end

		for k, v in RandomPairs(keys) do
			if nzLocker.UsedKeys and table.HasValue(nzLocker.UsedKeys, v) then continue end
			v:Reset()
			break
		end
	end

	function nzLocker:ResetKeys()
		nzLocker.HasKey = false
		nzLocker.UsedKeys = {}

		for k, v in pairs(ents.FindByClass("nz_keyspawn")) do
			v:Reset()
		end
		for k, v in pairs(ents.FindByClass("nz_locker")) do
			v:Reset()
		end

		net.Start("nzLocker.SyncKeys")
			net.WriteBool(false)
		net.Broadcast()
	end

	function nzLocker:LockLocks()
		for k, v in pairs(ents.FindByClass("nz_locker")) do
			v:LockerLock()
		end
	end
end

if CLIENT then
	local function ReceiveDoorKeySync( length )
		local bool = net.ReadBool()
		nzLocker.HasKey = bool
	end

	net.Receive("nzLocker.SyncKeys", ReceiveDoorKeySync)
end
