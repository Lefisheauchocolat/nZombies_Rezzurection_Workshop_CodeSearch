function nzMapping:CraftingTable(pos, ang, ply)
	local t = ents.Create( "bo6_crafting_table" )
	t:SetPos(pos)
	t:SetAngles(ang)
	t:Spawn()

	if ply then
		undo.Create("Crafting Table")
			undo.SetPlayer( ply )
			undo.AddEntity( t )
		undo.Finish()
	end
	
	return t
end