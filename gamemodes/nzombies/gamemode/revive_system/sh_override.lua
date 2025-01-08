local playersReviving = {}

hook.Add("CalcMainActivity", "nZ_here_lemme_give_you_a_hand", function(ply)
	local b_reviving = ply:GetPlayerReviving()

	if b_reviving and !playersReviving[ply] then
		playersReviving[ply] = true
		
		local seq, dur = ply:LookupSequence("revive_player")
		ply:SetPlaybackRate(1)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
	end

	if !b_reviving and playersReviving[ply] then
		playersReviving[ply] = nil
	end
	
end)