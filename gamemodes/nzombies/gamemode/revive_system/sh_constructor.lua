-- Main Tables
nzRevive = nzRevive or AddNZModule("Revive")

-- Variables
nzRevive.Players = {}
nzRevive.ReviveClasses = {
	["whoswho_downed_clone"] = true,
}

if CLIENT then
	nzRevive.Notify = {}
end
