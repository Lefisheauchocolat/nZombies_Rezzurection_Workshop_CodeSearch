function nzMapping:Ending(pos, ang, price, data, ply)
	local ent = ents.Create( "buyable_ending" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:SetPrice( price )

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
	end

	local phys = ent:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	ent:Spawn()

	if ply then
		undo.Create( "Ending" )
			undo.SetPlayer( ply )
			undo.AddEntity( ent )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ent
end

