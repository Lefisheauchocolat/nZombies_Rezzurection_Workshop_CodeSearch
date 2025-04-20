AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:AssignRandomTrial(ply)
	if not IsValid(ply) then return end

	local failed = true
	for k, v in RandomPairs(self.TrialsList) do
		if v and not ply:HasTrial(k) then
			if (game.SinglePlayer() or player.GetCount() < 2) and nzTrials:GetTrial(k).coop then continue end

			ply:SetNW2String("nzTrial"..self:EntIndex(), k)
			ply:StartTrial(k, self)
			failed = false
			break
		end
	end

	if failed then
		local trials = ents.FindByClass("nz_scriptedtrial")

		local num = 0
		for k, v in pairs(self.TrialsList) do
			if v then num = num + 1 end
		end

		if #trials >= num then
			ply:PrintMessage(HUD_PRINTCENTER, "Failed to assign trial! Possibly more trial entities placed down than trials available")
		end
	end
end

function ENT:AssignTrial(ply)
	if not IsValid(ply) then return end
	local trial = self:GetScriptedTrial()

	if not ply:HasTrial(trial) then
		ply:StartTrial(trial, self)
	end
end

function ENT:StartTrial()
	timer.Simple(engine.TickInterval()*math.random(#ents.FindByClass("nz_scriptedtrial")), function()
		if not IsValid(self) then return end
		if self:LookupSequence("open") > 0 then
			self:ResetSequence("open")
		end
	end)

	if self:GetPressUse() then return end

	if self:GetUseRandom() then
		for _, ply in ipairs(player.GetAll()) do
			self:AssignRandomTrial(ply)
		end
	else
		for _, ply in ipairs(player.GetAll()) do
			self:AssignTrial(ply)
		end
	end
end

function ENT:Reset()
	if self:LookupSequence("close") > 0 then
		self:ResetSequence("close")
	end

	if self:GetUseRandom() then
		for k, v in pairs(self.TrialsList) do
			if nzTrials:IsTrialActive(k) then
				nzTrials:ResetTrial(k)
			end
		end
	else
		nzTrials:ResetTrial(self:GetScriptedTrial())
	end

	for _, ply in ipairs(player.GetAll()) do
		ply:SetNW2String("nzTrial"..self:EntIndex(), "")
	end
end

function ENT:Use(ply)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.45

	if nzRound:InState(ROUND_CREATE) then
		if ply:KeyDown(IN_SPEED) then
			ply.NextUse = CurTime() + 4
			self:StopSound(self.CompleteSound)
			self:EmitSound(self.CompleteSound)
			ply:ChatPrint("Random Trials List")
			for k, v in pairs(self.TrialsList) do
				if v then
					ply:ChatPrint("Trial - "..nzTrials:GetTrial(k).name.." | "..k)
				end
			end
		else
			net.Start("nzTrialsMenu")
				net.WriteString("foxtrial_1")
				net.WriteBool(self.UseFizzlist)
			net.Send(ply)
		end
	return end

	if not nzRound:InProgress() then return end

	local trial = self:GetScriptedTrial()

	if self:GetUseRandom() then
		local trialid = ply:GetNW2String("nzTrial"..self:EntIndex())
		if not trialid or trialid == "" then //didnt have a trial, assign them one
			self:AssignRandomTrial(ply)
			return
		end
	elseif not ply:HasTrial(trial) then
		self:AssignTrial(ply)
		return
	end

	if self:GetUseRandom() then
		trial = ply:GetNW2String("nzTrial"..self:EntIndex(), "")
	end

	if ply:GetTrialCompleted(trial) then
		net.Start("nzTrialsMenu")
			net.WriteString(trial)
			net.WriteBool(self.UseFizzlist)
		net.Send(ply)
	end
end
