-- bo3 down animations ported by Wavy
-- vmanip bo3 crawl animations ported by latte
-- coded by wavy & latte w/ help from ghostlymoo

local downedPlayers = {}

if CLIENT then
    CreateClientConVar("nz_vmanip_crawl", "1", true, false, "0 = Disabled, 1 = T9 anims, 2 = T7 anims")
end

//hack fix for players disconnecting while down, PlayerDisconnect is not shared
hook.Add("EntityRemoved", "nzDownedAnimationFix", function(ply, fullUpdate)
	if (fullUpdate) then return end

	if downedPlayers[ply:EntIndex()] then
		downedPlayers[ply:EntIndex()] = nil
	end
end)

//adding ability to fake the player being down for use later
hook.Add("CalcMainActivity", "nzDownedAnimation", function(ply, vel)
	local stored = downedPlayers[ply:EntIndex()]
	local notdowned = ply:GetNotDowned()
	if ply:GetNW2Bool("nzFakeDown", false) then
		notdowned = false
	end

	if notdowned and stored ~= nil then
		downedPlayers[ply:EntIndex()] = nil

        if CLIENT then
            VManip:QuitHolding("crawl_forward_t7")
            VManip:QuitHolding("crawl_back_t7")
            VManip:QuitHolding("crawl_left_t7")
            VManip:QuitHolding("crawl_right_t7")
            VManip:QuitHolding("crawl_forward_t9")
            VManip:QuitHolding("crawl_back_t9")
            VManip:QuitHolding("crawl_left_t9")
            VManip:QuitHolding("crawl_right_t9")
        end

		local seq, dur = ply:LookupSequence("bo3_revived")
		ply:SetPlaybackRate(1)
		ply:SetCycle(0)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
	end

	if not notdowned and stored == nil then
		local seq, dur = ply:LookupSequence("bo3_downed")
		ply:SetPlaybackRate(1)
		ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)

		downedPlayers[ply:EntIndex()] = true
	end

	if stored then
		local angle, angle2 = vel:Angle(), ply:GetAngles()
		local ydif = math.abs(math.NormalizeAngle(angle.y - angle2.y))

		local seq1 = ply:LookupSequence("bo3_crawl_idle")
		local seq2 = ply:LookupSequence("bo3_crawl_back")
		local seq3 = ply:LookupSequence("bo3_crawl_forward")

		ply:SetPlaybackRate(1)

		if vel:Length2D() < 1 then
			return ACT_IDLE, seq1
		elseif ydif < 90 then
			return ACT_IDLE, seq3
		else
			return ACT_IDLE, seq2
		end
	end
end)


local cyclex, cycley = 0.6, 0.65
hook.Add("UpdateAnimation", "nzDownedAnimation", function(ply, vel, seqspeed)
	local notdowned = ply:GetNotDowned()
	if ply:GetNW2Bool("nzFakeDown", false) then
		notdowned = false
	end

	if not notdowned then
		local movement = 0
		local len = vel:Length2D()
		if len > 1 then
			movement = len / seqspeed
		else
			local cycle = ply:GetCycle()
			if cycle < cyclex or cycle > cycley then
				movement = 5
			end
		end


		ply:SetPlaybackRate(1)

		local crawltype = GetConVar("nz_vmanip_crawl"):GetInt()
		if CLIENT and VManip and crawltype > 0 then
			local animSuffix = crawltype == 1 and "_t9" or "_t7"
            local angle, angle2 = vel:Angle(), ply:GetAngles()
            local ydif = math.abs(math.NormalizeAngle(angle.y - angle2.y))
            local xdif = math.NormalizeAngle(angle.y - angle2.y)
            
            if ply == LocalPlayer() then
	            if len < 1 then
            		VManip:QuitHolding("crawl_forward_t7")
            		VManip:QuitHolding("crawl_back_t7")
            		VManip:QuitHolding("crawl_left_t7")
            		VManip:QuitHolding("crawl_right_t7")
            		VManip:QuitHolding("crawl_forward_t9")
            		VManip:QuitHolding("crawl_back_t9")
            		VManip:QuitHolding("crawl_left_t9")
            		VManip:QuitHolding("crawl_right_t9")
	            elseif ydif < 45 then
	                VManip:QuitHolding("crawl_back" .. animSuffix)
	                VManip:QuitHolding("crawl_left" .. animSuffix)
	                VManip:QuitHolding("crawl_right" .. animSuffix)
	                VManip:PlayAnim("crawl_forward" .. animSuffix)
	            elseif ydif > 135 then
	                VManip:QuitHolding("crawl_forward" .. animSuffix)
	                VManip:QuitHolding("crawl_left" .. animSuffix)
	                VManip:QuitHolding("crawl_right" .. animSuffix)
	                VManip:PlayAnim("crawl_back" .. animSuffix)
	            elseif xdif > 0 then
	                VManip:QuitHolding("crawl_forward" .. animSuffix)
	                VManip:QuitHolding("crawl_back" .. animSuffix)
	                VManip:QuitHolding("crawl_right" .. animSuffix)
	                VManip:PlayAnim("crawl_left" .. animSuffix)
	            else
	                VManip:QuitHolding("crawl_forward" .. animSuffix)
	                VManip:QuitHolding("crawl_back" .. animSuffix)
	                VManip:QuitHolding("crawl_left" .. animSuffix)
	                VManip:PlayAnim("crawl_right" .. animSuffix)
	            end
	        end
	    end

		return true
	end
end)