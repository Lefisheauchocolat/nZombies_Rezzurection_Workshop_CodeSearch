include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local limit = " | "..string.Comma(self:GetPointLimit()).." Point limit"
		local fee = " | "..self:GetPointFee().." Point withdraw fee"
		local elec = self:GetElectric() and " | Requires Electricity" or ""
		return "Bank"..limit..fee..elec
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return ""
	end

	if self.bankfulltime and self.bankfulltime > CurTime() then
		return "Bank is full!"
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply:GetNW2Bool("nzBankDeposit", false) then
		local ent = ents.FindByClass("nz_powerup_bankteller")[1]
		if IsValid(ent) then
			return "Press "..string.upper(input.LookupBinding("+USE")).." - to add 1000 [Cost: "..(1000 + self:GetPointFee()).."] [Total: "..ent:GetPoints().."]"
		end

		return "Press "..string.upper(input.LookupBinding("+USE")).." - to add 1000 [Cost: "..(1000 + self:GetPointFee()).."]"
	end

	if ply:KeyDown(IN_SPEED) then
		return "Press "..string.upper(input.LookupBinding("+USE")).." - to withdraw [Amount: 1000] [Fee: "..self:GetPointFee().."]"
	else
		return "Press "..string.upper(input.LookupBinding("+USE")).." - to deposit [Amount: 1000] [Total: "..self:GetPoints().."]"
	end
end

function ENT:GetNZTargetText2()
	if nzRound:InState(ROUND_CREATE) then
		return
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return
	end

	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if ply:GetNW2Bool("nzBankDeposit", false) then
		return
	end

	if ply:KeyDown(IN_SPEED) then
		return
	end

	return "Hold "..string.upper(input.LookupBinding("+SPEED")).." - to withdraw"
end

function ENT:BankFull()
	self.bankfulltime = CurTime() + 0.65

	local banktimer = "bankfulltimer"..self:EntIndex()
	if timer.Exists(banktimer) then timer.Remove(banktimer) end
	timer.Create(banktimer, 0.65, 1, function()
		if not IsValid(self) then return end
		self.bankfulltime = nil
	end)
end

function ENT:IsTranslucent()
	return true
end