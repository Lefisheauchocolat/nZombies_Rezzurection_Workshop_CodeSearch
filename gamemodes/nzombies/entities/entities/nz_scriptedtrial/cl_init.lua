include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()
end

function ENT:IsTranslucent()
	return true
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local douse = self:GetPressUse() and " | Requires USE" or ""
		return self:GetUseRandom() and "Scripted Trial - Random Trial"..douse or "Scripted Trial - "..nzTrials:GetTrial(self:GetScriptedTrial()).name..douse
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if self:GetUseRandom() then
		local trialid = ply:GetNW2String("nzTrial"..self:EntIndex(), "")
		if trialid and trialid ~= "" then
			local trial = nzTrials:GetTrial(trialid)

			if ply:GetTrialCompleted(trialid) then
				if not ply:GetTrialRewardUsed(trialid) then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - Claim Reward"
				else
					return "Trial Completed - "..trial.name
				end
			end

			if trial and trial.text then
				return trial.text(self)
			else
				return "Invalid Trial ID!"
			end
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Start Trial"
		end
	else
		local trial = nzTrials:GetTrial(self:GetScriptedTrial())

		if ply:GetTrialCompleted(self:GetScriptedTrial()) then
			if not ply:GetTrialRewardUsed(self:GetScriptedTrial()) then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - Claim Reward"
			else
				return "Trial Completed - "..trial.name
			end
		end

		if trial and trial.text then
			return trial.text(self)
		else
			return "Invalid Trial ID!"
		end
	end
end