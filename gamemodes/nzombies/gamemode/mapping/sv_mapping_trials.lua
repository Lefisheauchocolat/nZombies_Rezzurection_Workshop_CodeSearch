function nzMapping:SpawnTrial(pos, ang, ply, data)
	local ent = ents.Create("nz_scriptedtrial")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data then
		if data.model and util.IsValidModel(data.model) then
			ent:SetModel(tostring(data.model))
		end
		if data.class and data.class ~= "" then
			ent:SetScriptedTrial(tostring(data.class))
		else
			ent:SetScriptedTrial("random")
		end
		if data.sound and file.Exists("sound/"..data.sound, "GAME") then
			ent.CompleteSound = Sound(data.sound)
		else
			ent.CompleteSound = Sound("zmb/tomb/challenge_medal_r3.wav")
		end
		if data.fizzlist then
			ent.UseFizzlist = tobool(data.fizzlist)
		end
		if data.trialslist then
			ent.TrialsList = data.trialslist
		end
		if data.pressuse ~= nil then
			ent:SetPressUse(tobool(data.pressuse))
		end
	end

	ent:Spawn()

	if data then
		if data.fizzlist then
			ent.UseFizzlist = tobool(data.fizzlist)
		end
		if data.trialslist then
			ent.TrialsList = data.trialslist
		end
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Scripted Trial")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect (" .. tostring( data.model ) .. ")")
	end

	return ent
end
