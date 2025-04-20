-- Main Tables
nzTrials = nzTrials or AddNZModule("Trials")
nzTrials.Data = nzTrials.Data or {}
nzTrials.PlayerData = nzTrials.PlayerData or {}

if SERVER then
	nzTrials.ActiveTrials = nzTrials.ActiveTrials or {}
end

/*
list of server side only hooks to use

//Trial hooks

GM:OnTrialStarted(trial_id)
-- Called after the trial's state is set to 'Active'

GM:OnTrialReset(trial_id)
-- Called before the trial's data is cleared

//Player hooks

GM:PlayerTrialStarted(player, trial_id)
-- Called after the player is assigned a trial, usually on match begin

GM:PlayerTrialCompleted(player, trial_id)
-- Called after the player completes the specified trial

GM:PlayerTrialRewarded(player, trial_id)
-- Called after the player claims their reward

//Unused

GM:PlayerTrialReset(player)
-- Called before all the Player's trial data is cleared
*/