local PLAYER = FindMetaTable("Player")

if PLAYER then
	function PLAYER:GetSliqPuddle()
		return self:GetNW2Entity("BO3.Sliquified")
	end

	function PLAYER:SetSliqPuddle(ent)
		return self:SetNW2Entity("BO3.Sliquified", ent)
	end
end
