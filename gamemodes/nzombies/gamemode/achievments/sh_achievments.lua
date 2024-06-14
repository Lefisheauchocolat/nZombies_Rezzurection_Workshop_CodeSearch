-- Main Tables
nzAchievments = nzAchievments or AddNZModule("Achievments")
nzAchievments.Data = nzAchievments.Data or {}

if SERVER then
	util.AddNetworkString("NZ.ACHIEVEMENT")

	function nzAchievments:GiveAchievement(ply, str, icon, amt)
		if IsValid(ply) then
			if amt == nil then
				amt = 950
			end

			ply:EmitSound("NZ.Misc.Achievment")
			if nzombies and ply:Alive() then
				ply:GivePoints(amt)
			end

			net.Start("NZ.ACHIEVEMENT")
				net.WriteString(str)
				net.WriteString(icon)
			return net.Send(ply)
		end
	end
end

if CLIENT then
	local achievement, trophy, icon, text, text2
	net.Receive("NZ.ACHIEVEMENT", function(len, ply)
		LocalPlayer():EmitSound("NZ.Misc.Achievment")
		local actext = net.ReadString()
		local acicon = net.ReadString()

		if IsValid(achievement) then achievement:Remove() end
		achievement = vgui.Create("DImage")
		achievement:SetImage("vgui/hud/acvhievment/achievement_bkg2.png")
		achievement:SetSize(340, 85)
		achievement:SetPos(ScrW() - 480, ScrH() * 0.05)

		achievement.CreateTime = CurTime()
		achievement.Alpha = 0
		achievement.Offset = 0

		achievement.Think = function()
			if achievement.CreateTime + 5 < CurTime() then
				achievement.Alpha = math.Approach(achievement.Alpha, 0, FrameTime() * 2)
				if achievement.Alpha <= 0 then
					achievement:Remove()
				end
			elseif achievement.Alpha < 1 then
				achievement.Alpha = math.Approach(achievement.Alpha, 1, FrameTime() * 5)
			end
			achievement:SetAlpha(achievement.Alpha * 255)
		end

		if IsValid(trophy) then trophy:Remove() end
		trophy = vgui.Create("DImage", achievement)
		trophy:SetSize(30, 30)
		trophy:SetPos(95, 46)
		trophy:SetImage("vgui/hud/acvhievment/bronze.png", "smooth unlitgeneric")

		if IsValid(icon) then icon:Remove() end
		local icon = vgui.Create("DImage", achievement)
		icon:SetSize(72, 72)
		icon:SetPos(10, 6)
		icon:SetImage(acicon, "smooth unlitgeneric")

		if IsValid(text) then text:Remove() end
		local text = vgui.Create("DLabel", achievement)
		text:SetSize(256, 64)
		text:SetPos(100, -10)
		text:SetFont("HudHintTextLarge")
		text:SetText("You have earned a trophy.")
		text:SetTextColor(color_white)

		if IsValid(text2) then text2:Remove() end
		local text2 = vgui.Create("DLabel", achievement)
		text2:SetSize(256, 64)
		text2:SetPos(135, 30)
		text2:SetFont("HudHintTextLarge")
		text2:SetText(actext)
		text2:SetTextColor(color_white)
	end)
end
