local mapscript = {}

-- Any function added to this table will automatically get hooked to the hook with the same name
function mapscript.RoundInit()
	-- E.g. this function will run with the RoundInit hook
	print(mapscript.TestPrint)
end

function mapscript.OnGameBegin()

	--[[	Randomized Jugg and Speed Perk Locations	]]--

	local jugg = nil
	local speed = nil
	local tap = nil
	local revive = nil
	for k,v in pairs(ents.FindByClass("perk_machine")) do
    	if v:GetPerkID() == "jugg" then
			print("found Jugg")
        	jugg = v
			juggpos = v:GetPos()
			juggang = v:GetAngles()
    	end
		if v:GetPerkID() == "speed" then
			print("Found Speed Cola")
        	speed = v
			speedpos = v:GetPos()
			speedang = v:GetAngles()
    	end
		if v:GetPerkID() == "dtap" then
			print("Found Double Tap")
        	tap = v
			tappos = v:GetPos()
			tapang = v:GetAngles()
    	end
		if v:GetPerkID() == "revive" then
			print("Found Quick Revive")
        	revive = v
			revivepos = v:GetPos()
			reviveang = v:GetAngles()
    	end
	
		if nzRound:GetNumber() == 0 or nzRound:GetNumber() == 1 then
			if math.random(1,2) == 1 then
				if IsValid(jugg) and IsValid(speed) then
					print("swapping positions")
					jugg:SetPos(speedpos)
					jugg:SetAngles(speedang)
					speed:SetPos(juggpos)
					speed:SetAngles(juggang)
				end
			end
		else
			if IsValid(jugg) and IsValid(speed) then
				print("swapping positions")
				jugg:SetPos(speedpos)
				jugg:SetAngles(speedang)
				speed:SetPos(juggpos)
				speed:SetAngles(juggang)
			end
		end
		if nzRound:GetNumber() == 0 or nzRound:GetNumber() == 1 then
			if math.random(1,2) == 1 then
				if IsValid(revive) and IsValid(tap) then
					print("swapping positions")
					revive:SetPos(tappos)
					revive:SetAngles(tapang)
					tap:SetPos(revivepos)
					tap:SetAngles(reviveang)
				end
			end
		else
			if IsValid(revive) and IsValid(tap) then
				print("swapping positions")
				revive:SetPos(tappos)
				revive:SetAngles(tapang)
				tap:SetPos(revivepos)
				tap:SetAngles(reviveang)
			end
		end
	end

	--[[	Randomized Jugg and Speed Perk Locations	]]--
	
end

-- Only functions will be hooked, meaning you can safely store data as well
mapscript.TestPrint = "Randomized Perk Locations v1.0"
local testprint2 = "Local funny man commits mass murder." -- You can also store the data locally

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript
