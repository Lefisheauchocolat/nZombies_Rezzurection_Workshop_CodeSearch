local PLAYER = FindMetaTable("Player")
if PLAYER then
	if SERVER then
		function PLAYER:AddBuildable(ent)
			if !nzBuilds.Players[self] then nzBuilds.Players[self] = {} end
			if !table.HasValue(nzBuilds.Players[self], ent) then
				table.insert(nzBuilds.Players[self], ent)
				nzBuilds:PlayerAddBuildable(ent, self)
			end
		end

		function PLAYER:RemoveBuildable(ent)
			if !nzBuilds.Players[self] then nzBuilds.Players[self] = {} end
			if table.HasValue(nzBuilds.Players[self], ent) then
				table.RemoveByValue(nzBuilds.Players[self], ent)
				nzBuilds:PlayerRemoveBuildable(ent , self)
			end
		end
	end

	function PLAYER:GetBuildables()
		if !nzBuilds.Players[self] then nzBuilds.Players[self] = {} end
		return nzBuilds.Players[self]
	end
end
