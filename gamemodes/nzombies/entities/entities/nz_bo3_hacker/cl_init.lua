include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:GetNZTargetText()
	local ply = LocalPlayer()
	if ply:HasWeapon('tfa_bo3_hacker') then
		return "Already carrying Hacker Device"
	else
		return "Press "..string.upper(input.LookupBinding("+USE")).." - Hacker Device"
	end
end

function ENT:IsTranslucent()
	return true
end