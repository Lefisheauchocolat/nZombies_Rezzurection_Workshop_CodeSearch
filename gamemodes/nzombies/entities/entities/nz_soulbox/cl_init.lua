include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	self:DrawModel()

	if self.GlowMat then
		local mc = nzMapping.Settings.zombieeyecolor
		if mc and IsColor(mc) and (not self.lastcolor or self.lastcolor ~= mc) then
			self.lastcolor = mc
			self.eyecolor = Vector(mc.r/255, mc.g/255, mc.b/255)
		end

		if self.eyecolor and self.GlowMat:GetVector("$emissiveblendtint") ~= self.eyecolor then
			self.GlowMat:SetVector("$emissiveblendtint", self.eyecolor)
		end
	end
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if mdl == "models/zmb/bo2/tomb/zm_tm_soul_box.mdl" then
		self.GlowMat = Material("models/zmb/bo2/tomb/mtl_p6_zm_tm_soul_box")
	end
end

local killmyself = {
	[1] = " | Reward Random Powerup",
	[2] = " | Reward Random Perk",
	[3] = " | Reward PaP",
	[4] = " | Reward Door",
	[5] = " | Reward Power",
	[6] = " | Mapscript Reward",
}

function ENT:GetNZTargetText()
	if self:GetCompleted() then return end

	local cunt = ""
	local weptab = weapons.Get(self:GetWepClass())
	if weptab and istable(weptab) then
		cunt = " | Requires "..weptab.PrintName
	end

	local cost = self:GetSoulCost()
	local amount = cost - self:GetSoulAmount()
	local special = self:GetSpecials() and " | Special enemies only" or ""
	local zed = self:GetZombieClass() ~= "" and " | "..self:GetZombieClass() or ""
	local powered = self:GetElectric() and " | Requires Electricity" or ""
	local limit = self:GetLimited() and " | Power Radius "..self:GetAOE() or ""
	local powerup = self:GetGivePowerup() and " | Drop Powerup" or ""
	local doors = self:GetDoorFlag() ~= "" and " | Door Flag '"..self:GetDoorFlag().."'" or ""
	local reward = killmyself[self:GetRewardType()]

	if nzRound:InState(ROUND_CREATE) then
		return "Soul Box | "..cost.." Souls | Flag "..self:GetFlag().." | "..self:GetSoulRange().." Range"..reward..limit..doors..zed..powered..powerup..cunt..special
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return "You must turn on the electricity first!"
	end

	return amount.." of "..cost.." - Souls Remaning"..cunt
end

function ENT:IsTranslucent()
	return true
end