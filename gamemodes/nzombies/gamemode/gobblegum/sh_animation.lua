-- third person gum eating animations

local playersEating = {}

hook.Add("CalcMainActivity", "nzEatGum3rdPerson", function(ply)

	local wep = ply:GetActiveWeapon()

	if not IsValid(wep) or wep:GetClass() ~= "tfa_nz_gum" then
		return
	end

	if not playersEating[ply] then
		playersEating[ply] = true

		local seq, dur = ply:LookupSequence("eat_gum")
		ply:SetPlaybackRate(1)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)

		timer.Simple(dur, function()
			if IsValid(ply) and playersEating[ply] then
				playersEating[ply] = nil
			end
		end)
	end
end)
