-- Original Code by Hari, modified code by Latte and final code by GhostlyMoo(Hi thats me)
local nzombies = engine.ActiveGamemode() == "nzombies"

nz_suspense = nil
nz_suspensedelay = 0
nz_suspensestarttime = CurTime() + 6
nz_suspensespecialstarttime = CurTime() + 6

if CLIENT then
	hook.Add("OnRoundInit", "NZR.UNDERSCORE_INIT", function()
		nz_suspensestarttime = CurTime() + 12 + tonumber(nzMapping.Settings.roundwaittime)
		nz_suspensespecialstarttime = CurTime() + 12 + tonumber(nzMapping.Settings.specialroundwaittime)
	end)

	hook.Add("OnRoundPreparation", "NZR.UNDERSCORE_PREP", function()
		nz_suspensestarttime = CurTime() + 12 + tonumber(nzMapping.Settings.roundwaittime)
		nz_suspensespecialstarttime = CurTime() + 12 + tonumber(nzMapping.Settings.specialroundwaittime)
	end)

	hook.Add("OnRoundStart", "NZR.NROUND_UNDERSCORE", function()
		local snd = "sound/"..tostring(nzSounds.Sounds.Custom.UnderScore[math.random(#nzSounds.Sounds.Custom.UnderScore)])..""

		timer.Simple(0.1, function()
	        hook.Add("Think", "nz_suspense_loop", function()
	            if !nzRound:InState(ROUND_PROG) or nzRound:InState(ROUND_GO) and !nzRound:InState(ROUND_CREATE) then
	                if IsValid(nz_suspense) then
	                    nz_suspense:Stop()
	                    nz_suspense = nil
	                end
	                return
	            end

	            if LocalPlayer():Alive() then
	                if not IsValid(nz_suspense) and nz_suspensedelay < CurTime() and CurTime() > nz_suspensestarttime and !nzRound:IsSpecial() then
	                    nz_suspensedelay = CurTime() + 2
	                    sound.PlayFile(snd, "", function(st)
	                        if IsValid(st) then
	                            nz_suspense = st
	                            st:SetVolume(0.5)
	                            st:Play()
	                        end
	                    end)
	                elseif IsValid(nz_suspense) and nz_suspense:GetState() ~= 1 then
	                    nz_suspense:Stop()
	                    nz_suspense = nil
	                end
	            end
	        end)
	    end)
    end)

	hook.Add("OnSpecialRoundStart", "NZR.SROUND_UNDERSCORE", function()
		local snd = "sound/"..tostring(nzSounds.Sounds.Custom.SpecialUnderScore[math.random(#nzSounds.Sounds.Custom.SpecialUnderScore)])..""

		timer.Simple(0.1, function()
	        hook.Add("Think", "nz_suspense_loop", function()
	            if !nzRound:InState(ROUND_PROG) or nzRound:InState(ROUND_GO) and !nzRound:InState(ROUND_CREATE) then
	                if IsValid(nz_suspense) then
	                    nz_suspense:Stop()
	                    nz_suspense = nil
	                end
	                return
	            end

	            if LocalPlayer():Alive() then
	                if not IsValid(nz_suspense) and nz_suspensedelay < CurTime() and CurTime() > nz_suspensespecialstarttime and nzRound:IsSpecial() then
	                    nz_suspensedelay = CurTime() + 2
	                    sound.PlayFile(snd, "", function(st)
	                        if IsValid(st) then
	                            nz_suspense = st
	                            st:SetVolume(0.95)
	                            st:Play()
	                        end
	                    end)
	                elseif IsValid(nz_suspense) and nz_suspense:GetState() ~= 1 then
	                    nz_suspense:Stop()
	                    nz_suspense = nil
	                end
	            end
	        end)
	    end)
    end)
end
