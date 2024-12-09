-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

util.AddNetworkString("nZr.ShowBO6GameOver")

hook.Add("InitPostEntity", "nZr.ChangeFunctionEE", function()
    local original = nzRound.GameOver
    function nzRound:GameOver(message, time, noautocam, camstart, camend, ourtype, keepplaying)
        local bo6 = nzSettings:GetSimpleSetting("DeathAnim_BO6_GO", false)
        original(self, message, time, noautocam, camstart, camend, ourtype, keepplaying)
        if bo6 then
            net.Start("nZr.ShowBO6GameOver")
            net.WriteBool(ourtype == "win")
            net.Broadcast()
        end
	end
end)