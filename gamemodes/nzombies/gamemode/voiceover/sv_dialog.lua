-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzDialog = nzDialog or {}

util.AddNetworkString("nZr.DialogVoice")

function nzDialog:PlayCustomDialog(voiceover)
    net.Start("nZr.DialogVoice")
    net.WriteString(voiceover)
    net.Broadcast()
end