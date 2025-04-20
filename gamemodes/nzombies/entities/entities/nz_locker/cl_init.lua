include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	if self:GetUsed() then return end
	self:DrawModel()
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local time = self:GetTime() > 0 and " | "..math.Round(self:GetTime(), 2).."s Unlock" or ""
		local price = self:GetPrice() > 0 and " | Price "..self:GetPrice() or ""
		local electric = self:GetElectric() and " | Requires Electricity" or ""
		local fuck = self:GetDoorFlag() ~= "" and " | Door Flag '"..self:GetDoorFlag().."'" or ""
		local fuck2 = self:GetLockerClass() ~= "" and " | Locked Ent '"..self:GetLockerClass().."'" or ""
		local fuckered = self:GetFlag() ~= "" and " | Flag '"..self:GetFlag().."'" or ""
		return "Lock"..fuck..fuck2..time..price..electric..fuckered.." | '"..self:GetPickupHint().."'"
	end

	if self:GetUsed() then return end
	if not nzLocker.HasKey then return end

	local time = self:GetTime()
	local start = time > 0 and "Press & Hold " or "Press "
	local price = self:GetPrice() > 0 and " [Cost: "..string.Comma(self:GetPrice()).."]" or ""
	return start..string.upper(input.LookupBinding("+USE")).." - "..self:GetPickupHint()..price
end

function ENT:PopOff()
	local csEnt = ents.CreateClientProp(self:GetModel())
	if not IsValid(csEnt) then return end

	csEnt:SetPos(self:GetPos())
	csEnt:SetAngles(self:GetAngles())
	csEnt:Spawn()

	local phys = csEnt:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(1,math.Rand(0,1),0)*math.random(-200,200))
		phys:SetVelocity(self:GetForward()*math.random(10,20) + self:GetUp()*80 + self:GetRight()*math.random(-25,25))
	end

	SafeRemoveEntityDelayed(csEnt, 4)
	timer.Simple(4, function()
		if IsValid(csEnt) then
			SafeRemoveEntity(csEnt)
		end
	end)

	local fx = EffectData()
	fx:SetEntity(self)
	fx:SetOrigin(self:WorldSpaceCenter())
	fx:SetNormal(self:GetForward())
	fx:SetScale(1)
	fx:SetMagnitude(1)

	util.Effect("ElectricSpark", fx)
end

function ENT:IsTranslucent()
	return true
end