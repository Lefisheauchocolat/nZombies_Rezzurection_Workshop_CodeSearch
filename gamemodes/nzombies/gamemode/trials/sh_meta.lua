local PLAYER = FindMetaTable("Player")
if PLAYER then
	if SERVER then
		function PLAYER:StartTrial(id, scriptedtrial)
			if not id then return end
			if nzTrials:GetPlayerData(self)[id] then return end

			// pc bootup noise
			if not nzTrials:IsTrialActive(id) then
				nzTrials:StartTrial(id)
			end

			nzTrials.PlayerData[self][id] = {completed = false, used = false, ent = scriptedtrial}
			nzTrials:PlayerDataSync(nzTrials:GetPlayerData(self), self)
			hook.Call("PlayerTrialStarted", nzTrials, self, id)
		end

		function PLAYER:SetTrialCompleted(id)
			if not id then return end
			if nzTrials:GetPlayerData(self)[id] and nzTrials:GetPlayerData(self)[id].completed then return end

			local trial = nzTrials:GetTrial(id)
			if trial and trial.name then
				self:ChatPrint("Trial Completed! "..trial.name)
			end

			net.Start("nzPowerUps.PickupHud")
				net.WriteString("Trial Completed!")
				net.WriteBool(false)
			net.Send(self)

			timer.Simple(0.5, function()
				if not IsValid(self) then return end
				local snd = Sound("zmb/tomb/challenge_medal_r3.wav")

				if nzTrials:GetPlayerData(self)[id] then
					local trialent = nzTrials:GetPlayerData(self)[id].ent
					if trialent and IsValid(trialent) and trialent.CompleteSound and file.Exists("sound/"..trialent.CompleteSound, "GAME") then
						snd = trialent.CompleteSound
					end
				end

				self:EmitSound(snd, 75, 100, 1, CHAN_VOICE2)
			end)

			nzTrials.PlayerData[self][id].completed = true
			nzTrials:PlayerDataSync(nzTrials:GetPlayerData(self), self)
			hook.Call("PlayerTrialCompleted", nzTrials, self, id)

			//if another player hasnt completed the trial, return before cleaning up
			for k, v in ipairs(player.GetAll()) do
				if v:HasTrial(id) and not v:GetTrialCompleted(id) then return end
			end

			if nzTrials:IsTrialActive(id) then
				nzTrials:ResetTrial(id)
			end
		end

		function PLAYER:SetTrialRewardUsed(id)
			if not id then return end
			if nzTrials:GetPlayerData(self)[id] and nzTrials:GetPlayerData(self)[id].used then return end

			nzTrials.PlayerData[self][id].used = true
			nzTrials:PlayerDataSync(nzTrials:GetPlayerData(self), self)
			hook.Call("PlayerTrialRewarded", nzTrials, self, id)
		end

		function PLAYER:ResetTrials()
			hook.Call("PlayerTrialReset", nzTrials, self)
			nzTrials.PlayerData[self] = {}

			net.Start("nzTrialsPlayerReset")
			net.Send(ply)
		end
	end

	function PLAYER:GetTrialCompleted(id)
		if not id then return false end
		return nzTrials:GetPlayerData(self)[id] and nzTrials:GetPlayerData(self)[id].completed or false
	end

	function PLAYER:GetTrialRewardUsed(id)
		if not id then return false end
		return nzTrials:GetPlayerData(self)[id] and nzTrials:GetPlayerData(self)[id].used or false
	end

	function PLAYER:HasTrial(id)
		if not id then return false end
		return nzTrials:GetPlayerData(self)[id] or false
	end
end
