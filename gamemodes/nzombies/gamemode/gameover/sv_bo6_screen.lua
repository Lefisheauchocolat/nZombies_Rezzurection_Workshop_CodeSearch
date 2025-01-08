-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

util.AddNetworkString("nZr.ShowBO6GameOver")

hook.Add("InitPostEntity", "nZr.ChangeFunctionEE", function()
    local original = nzRound.GameOver
    function nzRound:GameOver(message, time, noautocam, camstart, camend, ourtype, keepplaying)
        local type = ourtype
        if type == "quest" then type = "win" end
        local bo6 = nzSettings:GetSimpleSetting("BO6_GO", false)
        original(self, message, time, noautocam, camstart, camend, type, keepplaying)
        if bo6 then
            net.Start("nZr.ShowBO6GameOver")
            net.WriteString(ourtype or "")
            net.Broadcast()
        end
	end

    function nzRound:QuestComplete()
        self:SetVictory(true)
        self:GameOver("Main Quest Completed", nzMapping.Settings.gameovertime+nzMapping.Settings.gocamerawait, nil, nil, nil, "quest")
        nzSounds:Play("GameEnd")
        hook.Call("OnRoundWin", nzRound, !self:InState(ROUND_GO))
        timer.Remove("NZRoundThink")
    end
end)