function nzMapping:AmmoMod(pos, ang, data, ply)
	local ammomod = ents.Create("ammo_mod")
	ammomod:SetPos( pos )
	ammomod:SetAngles( ang )

	ammomod:SetPrice(data.price)
	--ammomod:SetScrap(data.scrap)

	ammomod:Spawn()

	local phys = ammomod:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create( "Ammo Mod" )
			undo.SetPlayer( ply )
			undo.AddEntity( ammomod )
		undo.Finish( "Effect (" .. tostring( model ) .. ")" )
	end
	return ammomod
end
