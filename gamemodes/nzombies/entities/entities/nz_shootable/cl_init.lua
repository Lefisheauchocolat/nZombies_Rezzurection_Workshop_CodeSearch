include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	self:DrawModel()
end

local hurttypes = {
	[1] = "Melee Damage",
	[2] = "Explosive Damage",
	[3] = "Fire Damage",
	[4] = "Bullet Damage",
	[5] = "Shock Damage",
}

local rewardtypes = {
	[1] = "Bonus Points",
	[2] = "Free Perk",
	[3] = "Pack a' Punch",
	[4] = "Open a Door",
	[5] = "Activate Electricity",
}

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local doorflag = self:GetDoorFlag() ~= "" and " | Door Flag '"..self:GetDoorFlag().."'" or ""
		local global = self:GetGlobal() and "Global | " or ""
		local upgrade = self:GetUpgrade() and "Requires PAP | " or ""
		local killall = self:GetKillAll() and "Requires All Activated | " or ""

		local cunt = ""
		local weptab = weapons.Get(self:GetWepClass())
		if weptab and istable(weptab) then
			cunt = "Requires "..weptab.PrintName.." | "
		end
		
		return "Shootable | Flag "..self:GetFlag().." | "..global..killall..upgrade..cunt..hurttypes[self:GetHurtType()].." | "..rewardtypes[self:GetRewardType()]..doorflag
	end
end

function ENT:IsTranslucent()
	return true
end