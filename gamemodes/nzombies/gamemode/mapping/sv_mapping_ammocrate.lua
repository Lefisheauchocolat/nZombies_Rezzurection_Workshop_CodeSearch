function nzMapping:AmmoBox(pos, ang, data, ply)
	local ammobox = ents.Create("ammo_box")
	ammobox:SetPos( pos )
	ammobox:SetAngles( ang )

	ammobox:SetPrice(data.price)
	ammobox:SetPapPrice(data.papprice)
	ammobox:SetWonderPrice(data.wonderprice)

	ammobox:Spawn()

	local phys = ammobox:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Ammo Box" )
			undo.SetPlayer( ply )
			undo.AddEntity( ammobox )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ammobox
end
