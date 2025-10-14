function nzMapping:SpawnBankTeller(pos, ang, ply, data)
	if not data then return end

	local ent = ents.Create("nz_bankteller")
	ent:SetPos(pos)
	ent:SetAngles(ang)

	if data.model and util.IsValidModel(data.model) then
		ent:SetModel(tostring(data.model))
	else
		ent:SetModel("models/zmb/bo2/tranzit/com_cash_register_gstation.mdl")
	end
	if data.fee then
		ent:SetPointFee(tonumber(data.fee))
	end
	if data.limit then
		ent:SetPointLimit(tonumber(data.limit))
	end
	if data.elec then
		ent.Elec = tobool(data.elec)
		ent:SetElectric(tobool(data.elec))
	end
	if data.sound1 and file.Exists("sound/"..data.sound1, "GAME") then
		ent.TakeSound = Sound(data.sound1)
	else
		ent.TakeSound = Sound("zmb/tranzit/bank/bank_deposit.wav")
	end
	if data.sound2 and file.Exists("sound/"..data.sound2, "GAME") then
		ent.GiveSound = Sound(data.sound2)
	else
		ent.GiveSound = Sound("zmb/tranzit/bank/bank_withdraw.wav")
	end

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if ply then
		undo.Create("Bank Teller")
			undo.SetPlayer(ply)
			undo.AddEntity(ent)
		undo.Finish("Effect ()")
	end

	return ent
end
