-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

if SERVER then
    nzVotes = nzVotes or {}

    util.AddNetworkString("nZr.HariVoteStart")
    util.AddNetworkString("nZr.HariVoteResponse")
    util.AddNetworkString("nZr.HariVoteUpdate")
    util.AddNetworkString("nZr.HariVoteResult")
    
    local activeVote = false
    local votes = {}
    local requiredVotes = 0
    local successCallback = nil
    local totalPlayers = 0

    local function sndplaycl(path)
        BroadcastLua([[
            surface.PlaySound("]]..path..[[")
        ]])
    end
    
    function nzVotes:StartVote(text, required, onSuccess)
        if activeVote then return end
        if not required then required = 0.75 end
    
        totalPlayers = #player.GetAllPlayingAndAlive()
        activeVote = true
        votes = {}
        requiredVotes = math.Round(totalPlayers*required) or 1
        successCallback = onSuccess
    
        net.Start("nZr.HariVoteStart")
        net.WriteString(text)
        net.WriteInt(requiredVotes, 8)
        net.Broadcast()
        sndplaycl("bo6/vote/started.mp3")
        timer.Create("VoteTimeout", 15, 1, function()
            nzVotes:EndVote(false)
        end)
    end
    
    function nzVotes:EndVote(success)
        if success then
            sndplaycl("bo6/vote/accepted.mp3")
        else
            sndplaycl("bo6/vote/denied.mp3")
        end
        timer.Simple(5, function()
            activeVote = false
        end)
        timer.Remove("VoteTimeout")
    
        net.Start("nZr.HariVoteResult")
        net.WriteBool(success)
        net.Broadcast()
    
        if success and successCallback then
            timer.Simple(2, successCallback)
        end
    end
    
    net.Receive("nZr.HariVoteResponse", function(len, ply)
        if not activeVote then return end
        local vote = net.ReadBool()

        if votes[ply] == nil then
            votes[ply] = vote
            if !ply:Alive() then return end
    
            local yesVotes = 0
            local noVotes = 0
            for _, v in pairs(votes) do
                if v then yesVotes = yesVotes + 1 end
                if v == false then noVotes = noVotes + 1 end
            end
    
            net.Start("nZr.HariVoteUpdate")
            net.WriteInt(requiredVotes - yesVotes, 8)
            net.Broadcast()
    
            if yesVotes >= requiredVotes then
                nzVotes:EndVote(true)
            elseif yesVotes+noVotes == #player.GetAllPlayingAndAlive() then
                nzVotes:EndVote(false)
            end
        end
    end)   
else
    local voteBg = Material("bo6/other/vote_bg.png")
    local voteActive = false
    local voteText = ""
    local voteEndTime = 0
    local voteResult = nil
    local votesLeft = 0
    local voteCan = true
    local voteAnswer = -1

    function We(x)
        return x/1920*ScrW()
    end
    
    function He(y)
        return y/1080*ScrH()
    end
    
    local function SendVoteResponse(accept)
        net.Start("nZr.HariVoteResponse")
        net.WriteBool(accept)
        net.SendToServer()
    end 

    local function response(bool)
        if bool then
            voteAnswer = 1
            SendVoteResponse(true)
            surface.PlaySound("bo6/vote/accept.mp3")
            voteCan = false
        else
            voteAnswer = 0
            SendVoteResponse(false)
            surface.PlaySound("bo6/vote/decline.mp3")
            voteCan = false
        end
    end
    
    surface.CreateFont("BO6_ExfilVote", {
        font = "KairosSansW06-CondMedium",
        extended = true,
        size = He(20),
    })
    
    net.Receive("nZr.HariVoteStart", function()
        voteAnswer = -1
        voteActive = true
        voteCan = true
        voteText = net.ReadString()
        votesLeft = net.ReadInt(8)
        voteEndTime = CurTime() + 15
        voteResult = nil
        if game.SinglePlayer() then
            response(true)
        end
    end)
    
    net.Receive("nZr.HariVoteUpdate", function()
        votesLeft = net.ReadInt(8)
    end)
    
    net.Receive("nZr.HariVoteResult", function()
        voteResult = net.ReadBool()
        timer.Simple(5, function()
            voteActive = false
        end)
    end)

    hook.Add("HUDPaint", "DrawVoteHUD", function()
        if not voteActive then return end
    
        if voteResult == nil then
            surface.SetMaterial(voteBg)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRect(We(20), ScrH() / 2 - He(100), We(400), He(120))
        
            draw.SimpleText("SQUAD VOTE", "BO6_ExfilVote", We(30), ScrH() / 2 - He(100), Color(0, 0, 0))
            draw.SimpleText("Initiated Vote", "BO6_ExfilVote", We(30), ScrH() / 2 - He(65), Color(255, 255, 255))
            draw.SimpleText(voteText, "BO6_ExfilVote", We(30), ScrH() / 2 - He(50), Color(200, 200, 200))
        
            draw.SimpleText(votesLeft.." Player Needed...", "BO6_ExfilVote", We(30), ScrH() / 2 - He(10), Color(255, 0, 0))
        
            if voteCan then
                draw.RoundedBox(4, We(178), ScrH() / 2 - He(11), We(24), He(24), Color(200,200,200))
                draw.SimpleText("9", "BO6_ExfilVote", We(190), ScrH() / 2 - He(10), Color(0, 0, 0), TEXT_ALIGN_CENTER)
                draw.SimpleText("ACCEPT", "BO6_ExfilVote", We(210), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_LEFT)
                draw.RoundedBox(4, We(298), ScrH() / 2 - He(11), We(24), He(24), Color(200,200,200))
                draw.SimpleText("0", "BO6_ExfilVote", We(310), ScrH() / 2 - He(10), Color(0, 0, 0), TEXT_ALIGN_CENTER)
                draw.SimpleText("DECLINE", "BO6_ExfilVote", We(330), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_LEFT)
            else
                if voteAnswer == 1 then
                    draw.SimpleText("YOU ACCEPTED", "BO6_ExfilVote", We(380), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                elseif voteAnswer == 0 then
                    draw.SimpleText("YOU DECLINED", "BO6_ExfilVote", We(380), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_RIGHT)
                end
            end
        else
            local resultText = voteResult and "ACCEPTED" or "DECLINED"
            local resultColor = voteResult and Color(0, 200, 0) or Color(200, 0, 0)
            
            surface.SetMaterial(voteBg)
            surface.SetDrawColor(resultColor.r, resultColor.g, resultColor.b)
            surface.DrawTexturedRect(We(20), ScrH() / 2 - He(100), We(400), He(120))
        
            draw.SimpleText(resultText, "BO6_ExfilVote", We(30), ScrH() / 2 - He(100), Color(0, 0, 0))
            draw.SimpleText("Initiated Vote", "BO6_ExfilVote", We(30), ScrH() / 2 - He(65), Color(255, 255, 255))
            draw.SimpleText(voteText, "BO6_ExfilVote", We(30), ScrH() / 2 - He(50), Color(200, 200, 200))

            if voteAnswer == 1 then
                draw.SimpleText("YOU ACCEPTED", "BO6_ExfilVote", We(380), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_RIGHT)
            elseif voteAnswer == 0 then
                draw.SimpleText("YOU DECLINED", "BO6_ExfilVote", We(380), ScrH() / 2 - He(10), Color(255, 255, 255), TEXT_ALIGN_RIGHT)
            end
        end
    end)
    
    hook.Add("PlayerButtonDown", "VoteKeyPress", function(ply, button)
        if not voteActive or voteResult ~= nil then return end
    
        if button == KEY_9 and voteCan then
            response(true)
        elseif button == KEY_0 and voteCan then
            response(false)
        end
    end)
end