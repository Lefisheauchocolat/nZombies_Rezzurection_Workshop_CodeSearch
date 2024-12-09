function nzMapping:Ending(pos, ang, price, data, ply)
	local ent = ents.Create( "buyable_ending" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:SetPrice( price )

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.keepplaying ~= nil then
			ent:SetKeepPlaying(tobool(data.keepplaying))
		end
		if data.giveallperks ~= nil then
			ent:SetRewardPerks(tobool(data.giveallperks))
		end
		if data.permaperks ~= nil then
			ent:SetPermaPerks(tobool(data.permaperks))
		end
		if data.hint then
			ent:SetHintString(tostring(data.hint))
		end
		if data.customtext then
			ent:SetCustomText(tostring(data.customtext))
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

