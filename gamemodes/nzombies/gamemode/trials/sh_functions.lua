function nzTrials:NewTrial(id, data)
	nzTrials.Data[id] = data
end

function nzTrials:GetTrial(id)
	return nzTrials.Data[id]
end

function nzTrials:GetPlayerData(ply)
	if not IsValid(ply) then return end
	if not nzTrials.PlayerData[ply] then nzTrials.PlayerData[ply] = {} end
	return nzTrials.PlayerData[ply]
end

if SERVER then
	function nzTrials:IsTrialActive(id)
		if not id then return end
		return nzTrials.ActiveTrials[id] or false
	end

	function nzTrials:StartTrial(id)
		if not id then return end
		local trial = nzTrials:GetTrial(id)
		if not (trial and trial.start) then return end
		if nzTrials.ActiveTrials[id] then return end

		nzTrials.ActiveTrials[id] = true
		hook.Call("OnTrialStarted", nzTrials, id)
		return nzTrials:GetTrial(id).start()
	end

	function nzTrials:ResetTrial(id)
		if not id then return end
		local trial = nzTrials:GetTrial(id)
		if not (trial and trial.reset) then return end

		hook.Call("OnTrialReset", nzTrials, id) //trial is still 'active' during this call
		if nzTrials:IsTrialActive(id) then
			nzTrials.ActiveTrials[id] = nil
		end
		return nzTrials:GetTrial(id).reset()
	end
end