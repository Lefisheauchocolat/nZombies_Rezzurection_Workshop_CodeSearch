function nzAATs:RegisterAAT(id, data)
	nzAATs.Data[id] = data
end

function nzAATs:Get(id)
	return nzAATs.Data[id]
end

function nzAATs:GetAATs()
	return nzAATs.Data
end

function nzAATs:GetList()
	local tbl = {}

	for k, v in pairs(nzAATs.Data) do
		tbl[k] = v.name
	end

	return tbl
end

if SERVER then
	local WEAPON = FindMetaTable("Weapon")
	if WEAPON then
		function WEAPON:RandomizeAAT()
			local ply = self:GetOwner()
			if not IsValid(ply) then return end

			local lastaat = ply.LastNZAATType or ""
			local aat = ""
			for k, v in RandomPairs(nzAATs.Data) do
				if k ~= lastaat then
					aat = k
					break
				end
			end

			print("Applying ["..aat.."] Alt Ammo Type to "..ply:Nick().."'s "..self.PrintName)
			self:SetNW2String("nzAATType", aat)
			ply.LastNZAATType = aat
		end
	end
end
