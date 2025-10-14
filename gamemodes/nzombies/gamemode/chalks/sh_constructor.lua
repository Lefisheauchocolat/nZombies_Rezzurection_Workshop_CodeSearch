-- Main Tables
nzChalks = nzChalks or AddNZModule("Chalks")

nzChalks.Players = {}

if SERVER then
	util.AddNetworkString("nzChalks.Reset")
	util.AddNetworkString("nzChalks.Sync")

	function nzChalks:Reset()
		nzChalks.Players = {}

		for k, v in pairs(ents.FindByClass("nz_weaponchalk")) do
			v:Reset()
		end
		for k, v in pairs(ents.FindByClass("nz_blankchalk")) do
			v:Reset()
		end

		net.Start("nzChalks.Reset")
		net.Broadcast()
	end

	function nzChalks:GivePlayerChalk(ply, ent)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		if not IsValid(ent) then return end

		local data = {
			player = ply:EntIndex(),
			class = ent:GetWepClass(),
			icon = ent:GetHudIcon(),
			price = ent:GetPrice(),
			points = ent:GetPoints(),
			flipped = ent:GetFlipped(),
			ent = ent:EntIndex(),
		}

		local wep = weapons.Get(data.class)
		if wep then
			data.name = wep.PrintName
		end

		nzChalks.Players[ply] = data

		net.Start("nzChalks.Sync")
			net.WriteBool(false)
			net.WriteTable(data)
		net.Broadcast()
	end

	function nzChalks:TakePlayerChalk(ply, reset)
		if not IsValid(ply) or not ply:IsPlayer() then return end
		local data = nzChalks:GetPlayerChalk(ply)
		if not data then return end

		if reset and data.ent then
			local ent = Entity(data.ent)
			if IsValid(ent) then
				ent:Reset()
			end
		end

		nzChalks.Players[ply] = nil

		net.Start("nzChalks.Sync")
			net.WriteBool(true)
			net.WriteInt(ply:EntIndex(), 8)
		net.Broadcast()
	end
end

function nzChalks:GetPlayerChalk(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	return nzChalks.Players[ply]
end

if CLIENT then
	local function ReceiveChalkReset( length )
		nzChalks.Players = {}
	end

	net.Receive("nzChalks.Reset", ReceiveChalkReset)

	local function ReceiveChalkSync( length )
		local take = net.ReadBool()
		if take then
			local ply = net.ReadInt(8)
			nzChalks.Players[ply] = nil
		else
			local data = net.ReadTable()
			data.icon = Material(tostring(data.icon), "unlitgeneric smooth")

			nzChalks.Players[data.player] = data
			nzChalks:ChalkHudUpdate(data.icon)
		end
	end

	net.Receive("nzChalks.Sync", ReceiveChalkSync)
end
