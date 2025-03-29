if SERVER then
	util.AddNetworkString("nzPlayerClientStartup")

	local load_queue = {}
	net.Receive("nzPlayerClientStartup", function(len, ply)
		load_queue[ply] = true
	end)

	hook.Add("SetupMove", "nzPlayerClientStartup", function( ply, _, cmd )
		if load_queue[ply] and not cmd:IsForced() then
			if isnumber(load_queue[ply]) and load_queue[ply] < CurTime() then //first send mapdata, then sync modules
				//print(CurTime())
				print('Sent module sync to '..ply:Nick())
				load_queue[ply] = nil
				nzPlayers:FullSync(ply)
			elseif not isnumber(load_queue[ply]) then
				//print(CurTime())
				print('Sent map data to '..ply:Nick())
				nzMapping:SendMapData(ply)
				load_queue[ply] = CurTime() + (ply:Ping()*0.01) + engine.TickInterval()
			end

			if !ply:GetNW2Bool("nzFullyConnected", false) then
				player_manager.SetPlayerClass(ply, "player_ingame")
				ply:SetNW2Bool("nzFullyConnected", true)
				hook.Call("PlayerFullyInitialized", nil, ply)
			end
		end
	end)
end

if CLIENT then
	if !IsValid(LocalPlayer()) then
		local matcolor = Material("color")
		local toggle_hud = false
		local fade_from_black = true

		local function FadeFromBlack()
			if fade_from_black then
				surface.SetDrawColor(color_black)
				surface.SetMaterial(matcolor)
				surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
			end

			local ply = LocalPlayer()
			if not IsValid(ply) then return end
			if ply:GetNW2Bool("nzFullyConnected", false) and fade_from_black then
				fade_from_black = false
				ply:ScreenFade(SCREENFADE.IN, color_black, 2, 1)

				if toggle_hud then
					RunConsoleCommand("cl_drawhud", "1")
				end

				hook.Call("ClientFullyInitialized", nil, ply)
			end
		end
		hook.Add("RenderScreenspaceEffects", "nzLoadingScreenCover", FadeFromBlack)

		//lawyers hate this one easy trick
		hook.Add("Think", "nzPlayerClientStartup", function()
			hook.Remove("Think", "nzPlayerClientStartup")

			if GetConVar("cl_drawhud"):GetBool() then
				toggle_hud = true
				RunConsoleCommand("cl_drawhud", "0")
			end
			net.Start("nzPlayerClientStartup")
			net.SendToServer()
		end)
	end
end
