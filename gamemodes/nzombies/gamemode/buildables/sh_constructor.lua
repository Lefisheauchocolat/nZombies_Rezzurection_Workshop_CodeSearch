-- Main Tables
nzBuilds = nzBuilds or AddNZModule("Builds")
nzBuilds.Data = nzBuilds.Data or {}
nzBuilds.Players = nzBuilds.Players or {}

nzBuilds.Parts = nzBuilds.Parts or {}
nzBuilds.ClientParts = nzBuilds.ClientParts or {}

nzBuilds.ModernInventory = true

function nzBuilds:UpdateSettings(data)
	if not data then return end

	if data.modernhud ~= nil then
		nzBuilds.ModernInventory = data.modernhud
	end

	if SERVER then
		net.Start("nzBuildsUpdate")
			net.WriteTable(data)
		net.Broadcast()
	end
end

if SERVER then
	util.AddNetworkString("nzBuildsUpdate")
end

if CLIENT then
	local function ReceiveData(len, ply)
		local data = net.ReadTable()
		nzBuilds:UpdateSettings(data)
	end
	net.Receive("nzBuildsUpdate", ReceiveData)

	if GetConVar("nz_buildable_sharing") == nil then
		CreateClientConVar("nz_buildable_sharing", 1, true, true, "Enable to allow other players to pickup your placed buildables. (0 false, 1 true), Default is 1.", 0, 1)
	end
end