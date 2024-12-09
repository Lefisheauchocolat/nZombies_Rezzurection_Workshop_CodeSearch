local playersSliding = {}

hook.Add("CalcMainActivity", "SLIIIDETOTHELEFTSLIIIDETOTHERIGHT", function(ply)
	local b_sliding = ply:GetSliding()

	if b_sliding and !playersSliding[ply] then
		playersSliding[ply] = true
		
		local seq, dur = ply:LookupSequence("bo3_slide_start")
		ply:SetPlaybackRate(1)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
	end

	if !b_sliding and playersSliding[ply] and (ply:IsOnGround() or (ply:WaterLevel() > 2)) then
		playersSliding[ply] = nil
	end

	if playersSliding[ply] then
		local seq = ply:LookupSequence("bo3_slide_idle")
		return ACT_IDLE, seq
	end
end)