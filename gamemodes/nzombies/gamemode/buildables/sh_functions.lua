function nzBuilds:NewBuildable(id, data)
	nzBuilds.Data[id] = data
end

function nzBuilds:GetBuildable(id)
	return nzBuilds.Data[id]
end

function nzBuilds:GetBuildParts(id) //returns part table
	return nzBuilds.Data[id].parts
end

function nzBuilds:GetBuildableList()
	local tbl = {}

	for k, v in pairs(nzBuilds.Data) do
		tbl[k] = v.name
	end

	return tbl
end

if SERVER then
	function nzBuilds:GetHeldParts()
		return nzBuilds.Parts
	end
end
if CLIENT then
	function nzBuilds:GetHeldParts()
		return nzBuilds.ClientParts
	end
end
