if SERVER then
	util.AddNetworkString("nzBuildsPartsUpdate")
	util.AddNetworkString("nzBuildsPartsClean")

	util.AddNetworkString("nzBuildsPlayerAdd")
	util.AddNetworkString("nzBuildsPlayerRemove")

	function nzBuilds:PartsUpdateSync(data, reciever)
		net.Start("nzBuildsPartsUpdate")
			net.WriteTable(data)
		return reciever and net.Send(reciever) or net.Broadcast()
	end

	function nzBuilds:PlayerAddBuildable(ent, ply)
		if not IsValid(ent) then return end
		if not IsValid(ply) then return end

		net.Start("nzBuildsPlayerAdd")
			net.WriteEntity(ent)
		net.Send(ply)
	end

	function nzBuilds:PlayerRemoveBuildable(ent, ply)
		if not IsValid(ent) then return end
		if not IsValid(ply) then return end

		net.Start("nzBuildsPlayerRemove")
			net.WriteEntity(ent)
		net.Send(ply)
	end

	function nzBuilds:UpdateHeldParts(ent)
		if not IsValid(ent) then return end
		assert(ent:GetClass() == "nz_buildable", "UpdateHeldParts failed!, entity is not a build part")

		if !table.HasValue(nzBuilds.Parts, ent) then
			table.insert(nzBuilds.Parts, ent)
			nzBuilds.ClientParts[ent:EntIndex()] = {}
			nzBuilds.ClientParts[ent:EntIndex()].build = ent:GetBuildable()
			nzBuilds.ClientParts[ent:EntIndex()].id = ent:GetPartID()
		else
			table.RemoveByValue(nzBuilds.Parts, ent)
			nzBuilds.ClientParts[ent:EntIndex()] = {}
		end

		nzBuilds:PartsUpdateSync(nzBuilds.ClientParts)
	end

	function nzBuilds:CleanHeldParts()
		nzBuilds.Parts = {}
		nzBuilds.ClientParts = {}

		net.Start("nzBuildsPartsClean")
		net.Broadcast()
	end

	FullSyncModules["nzBuilds"] = function(ply)
		nzBuilds:PartsUpdateSync(nzBuilds.ClientParts, ply)
	end
end

if CLIENT then
	local function ReceivePlayerAddBuild( length )
		local ent = net.ReadEntity()
		local ply = LocalPlayer()
		if not IsValid(ent) then return end
		if not IsValid(ply) then return end

		if !nzBuilds.Players[ply] then nzBuilds.Players[ply] = {} end
		if !table.HasValue(nzBuilds.Players[ply], ent) then
			table.insert(nzBuilds.Players[ply], ent)
		end
	end

	local function ReceivePlayerRemoveBuild( length )
		local ent = net.ReadEntity()
		local ply = LocalPlayer()
		if not IsValid(ent) then return end
		if not IsValid(ply) then return end

		if !nzBuilds.Players[ply] then nzBuilds.Players[ply] = {} end
		if table.HasValue(nzBuilds.Players[ply], ent) then
			table.RemoveByValue(nzBuilds.Players[ply], ent)
		end
	end

	local function ReceiveBuildsPartsUpdate( length )
		local attached = net.ReadTable()
		for k, v in pairs(attached) do
			nzBuilds.ClientParts[k] = v
		end
	end

	local function ReceiveBuildsPartsClean( length )
		nzBuilds.ClientParts = {}
	end

	net.Receive("nzBuildsPartsUpdate", ReceiveBuildsPartsUpdate)
	net.Receive("nzBuildsPartsClean", ReceiveBuildsPartsClean)

	net.Receive("nzBuildsPlayerAdd", ReceivePlayerAddBuild)
	net.Receive("nzBuildsPlayerRemove", ReceivePlayerRemoveBuild)
end
