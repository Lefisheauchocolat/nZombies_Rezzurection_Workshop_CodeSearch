include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:GetNZTargetText()
	local ply = self:GetOwner()
	if LocalPlayer() == ply then
		return ""
	end

	local dying = self:GetCreationTime() + (self.Delay - 1.5) < CurTime()
	local ahhhh = self:GetCreationTime() + (self.Delay - 0.5) < CurTime()
	if IsValid(ply) and nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then
		return "...?"
	end
	if IsValid(ply) and !ply:GetNotDowned() then
		return "!?"
	end
	return ahhhh and "!" or dying and "?" or "..."
end

function ENT:IsTranslucent()
	return true
end