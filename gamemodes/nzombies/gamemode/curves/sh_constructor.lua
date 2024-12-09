if SERVER then
	-- Main Tables
	nzCurves = nzCurves or AddNZModule("Curves")

	function nzCurves.GenerateHealthCurve(round)
		local hp = nzMapping.Settings.healthstart or 75
		local hpinc = nzMapping.Settings.healthinc or 50
		local hpmult = nzMapping.Settings.healthmult or 0.1
		local hpcap = nzMapping.Settings.healthcap or 60000

		for i=2, round do -- Now featuring 1:1 Health Scaling.
			if i >= 10 then
				hp = hp + (math.floor(hp * hpmult))
			else
				hp = math.Round(hp + hpinc)
			end
		end

		if hp > hpcap then
			hp = hpcap
		end

		--[[local nextround = 163 -- This shit doesn't work as intended rn lmao.
		if round > 162 and round == nextround then -- Forced insta kill rounds.
			hp = 1
			if round > 185 then
				nextround = round + math.random(5) -- Literally just mimicking insta-kill rounds down to the slight randomness past round 185 :wind_blowing_face:
			else
				nextround = round + 2 -- Every other round until past 185.
			end
		end]]

		return hp
	end

	function nzCurves.GenerateMaxZombies(round)
		local round = round
		local ply = #player.GetAllPlaying()
		local extrazombiesint = nzMapping.Settings.zombiesperplayer
		local extraZombies = 0
		local cap = nzMapping.Settings.amountcap or 240 -- In this context, the amount of zombies the "max" has will be capped by the value set here.

		local max = 24
		local multiplier = math.max(1, round / 5)
		local sp = (ply == 1)

		if round > 10 then
			multiplier = multiplier * round * 0.15
		end

		-- The actual code uses "+=" which just means it adds to the variable which in this case is "max"
		max = max + (sp and 0.5 or (ply - 1)) * 6 * multiplier

		--[[Rounds 1 to 5]]--
		local roundtab = {
			[1] = function(max) return max * 0.25 end,
			[2] = function(max) return max * 0.3 end,
			[3] = function(max) return max * 0.5 end,
			[4] = function(max) return max * 0.7 end,
			[5] = function(max) return max * 0.9 end,
		}

		if max > cap then
			max = cap + ((ply - 1) * 6) -- Did the amount of zombies go over the cap? Force it to the capped value. (Considering for multiple players of course.)
		end

		return (round == -1 and 666 or round <= 5 and math.floor(roundtab[round](max)) or math.floor(max))
	end

	function nzCurves.GenerateSpeedTable(round)
		if not round then return {[50] = 100} end -- Default speed for any invalid round (Say, creative mode test zombies)
		local tbl = {}
		local round = round
		local range = 3 -- The range on either side of the tip (current round) of speeds in steps of "steps"
		local min = 20 -- Minimum speed (Round 1)
		local max = 300 -- Maximum speed
		local maxround = 27 -- The round at which the speed has its tip
		local steps = ((max-min)/maxround) -- The different speed steps speed can exist in
		--print("Generating round speeds with steps of "..steps.."...")
		for i = -range, range do
			local speed = (min - steps + steps*round) + (steps*i)
			if speed >= min and speed <= max then
				local chance = 100 - 10*math.abs(i)^2
				--print("Speed is "..speed..", with a chance of "..chance)
				tbl[speed] = chance
			elseif speed >= max then
				tbl[max] = 100
			end
		end
		return tbl
	end

	-- Moo's more CoDZ like speed increase.
	function nzCurves.GenerateCoDSpeedTable(round) -- Works best for enemies that obey the speed given to them by an animation rather than code.
		if not round then return {[50] = 100} end
		local tbl = {}
		local round = round
		local multiplier = nzMapping.Settings.speedmulti or 4 -- Actual value used in BO3 onward. If you want Pre-BO3 Speed increases, use 8 instead.
		local speed = nzMapping.Settings.startspeed or 0

		local cap = nzMapping.Settings.speedcap

		if cap <= 0 then cap = 999 end -- If its set to 0, then default to 999(Idiot protection).

		for i = 1,round do
			speed = math.Clamp(round * multiplier - multiplier, 0, cap) -- Subbing by multiplier as well cause that seems to work.
		end

		speed = speed + nzMapping.Settings.startspeed

		tbl[speed] = 100 -- This calculates the base number for the zombies of the round to use, further speed adjustments are done in the zombie luas themselves if they support it.

		return tbl
	end

	-- Cold War Style Zombie attack damage increase.
	function nzCurves.GenerateAttackDamage(round)

		if nzMapping.Settings.dmgincrease == false then return 50 end

		local damage_increase = {
			{
        		round = {
        			from = 1, 
        			to = 6
        		},
        		damage = 30
    		},
			{
        		round = {
        			from = 7, 
        			to = 15
        		},
        		damage = 50
    		},
			{
        		round = {
        			from = 16, 
        			to = 30
        		},
        		damage = 75
    		},
		}

		if isnumber(round) and round <= 0 then return 50 end

    	for _, hitdamage in pairs(damage_increase) do
        	if round >= hitdamage.round.from and round <= hitdamage.round.to then
            	return hitdamage.damage
        	end
    	end
    	return 90
	end
end

-- :sleeping_accommodation:
-- I understood the assignment
