local playersDiving = {}

hook.Add("CalcMainActivity", "KLEINANDDIVESOCIETY", function(ply)
	local b_diving = ply:GetDiving()

	if b_diving and !playersDiving[ply] then
		playersDiving[ply] = true

		local seq, dur = ply:LookupSequence("bo1_stand2dive")
		ply:SetPlaybackRate(1)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
	end

	if !b_diving and playersDiving[ply] and (ply:IsOnGround() or (ply:WaterLevel() > 2)) then
		playersDiving[ply] = nil

		if ply:WaterLevel() < 2 then
			local seq, dur = ply:LookupSequence("bo1_dive2stand")
			ply:SetPlaybackRate(1)
			ply:SetCycle(0)
			ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
		end
	end

	if playersDiving[ply] then
		local seq = ply:LookupSequence("bo1_dive_idle")
		return ACT_IDLE, seq
	end
end)
