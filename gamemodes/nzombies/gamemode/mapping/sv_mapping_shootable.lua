function nzMapping:SpawnShootable(pos, ang, ply, data)
	if not data then return end
	local ent = ents.Create("nz_shootable")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.flag then
		ent:SetFlag(tonumber(data.flag))
	end
	if data.model and util.IsValidModel(data.model) then
		ent:SetModel(tostring(data.model))
	end
	if data.hurttype then
		ent:SetHurtType(tonumber(data.hurttype))
	end
	if data.rewardtype then
		ent:SetRewardType(tonumber(data.rewardtype))
	end
	if data.pointamount then
		ent:SetPointAmount(tonumber(data.pointamount))
	end
	if data.door then
		ent:SetDoorFlag(tostring(data.door))
	end
	if data.killall then
		ent:SetKillAll(tobool(data.killall))
	end
	if data.sound and file.Exists("sound/"..data.sound, "GAME") then
		ent.ActivateSound = Sound(data.sound)
	else
		ent.ActivateSound = Sound("zmb/stinger/afterlife_end.wav")
	end
	if data.upgrade then
		ent:SetUpgrade(tobool(data.upgrade))
	end
	if data.global then
		ent:SetGlobal(tobool(data.global))
	end
	if data.wepclass then
		ent:SetWepClass(tostring(data.wepclass))
	end
	if data.skin then
		ent:SetSkin(tonumber(data.skin))
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Shootable")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( model ) .. ")")
	end

	return ent
end
