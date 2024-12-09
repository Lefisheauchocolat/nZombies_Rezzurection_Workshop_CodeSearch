local placeingstart = true

local generator1 = 1
local function nextKey()
	local i = #nzMapping.Settings.gocamerastart
	generator1 = generator1 + 1

	if generator1 > i then
		generator1 = 1
	end

	return generator1
end

nzTools:CreateTool("gocamera", {
	displayname = "Game Over Camera Placer",
	desc = "LMB: Place Camera Start & Camera End, RMB:Remove Selected Camera, Reload: Cycle Selected Camera",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		if placeingstart then
			if !nzMapping.Settings.gocamerastart then
				nzMapping.Settings.gocamerastart = {}
			end

			local camid = #nzMapping.Settings.gocameraend + 1
			nzMapping.Settings.gocamerastart[camid] = ply:EyePos()
			nzMapping:SendMapDataSingle("gocamerastart", nzMapping.Settings.gocamerastart)

			local fucker = tostring(nzMapping.Settings.gocamerastart[camid])
			PrintMessage(HUD_PRINTTALK, "[NZ] Game Over camera ["..camid.."] start set to Vector("..fucker..")")
		else
			if !nzMapping.Settings.gocameraend then
				nzMapping.Settings.gocameraend = {}
			end

			local camid = #nzMapping.Settings.gocameraend + 1
			nzMapping.Settings.gocameraend[camid] = ply:EyePos()
			nzMapping:SendMapDataSingle("gocameraend", nzMapping.Settings.gocameraend)

			local fucker = tostring(nzMapping.Settings.gocameraend[camid])
			PrintMessage(HUD_PRINTTALK, "[NZ] Game Over camera ["..camid.."] end set to Vector("..fucker..")")
		end

		placeingstart = !placeingstart
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		table.RemoveByValue(nzMapping.Settings.gocamerastart, nzMapping.Settings.gocamerastart[generator1])
		table.RemoveByValue(nzMapping.Settings.gocameraend, nzMapping.Settings.gocameraend[generator1])

		nzMapping:SendMapDataSingle("gocamerastart", nzMapping.Settings.gocamerastart)
		nzMapping:SendMapDataSingle("gocameraend", nzMapping.Settings.gocameraend)

		PrintMessage(HUD_PRINTTALK, "[NZ] Game Over camera ["..generator1.."] removed")
	end,
	Reload = function(wep, ply, tr, data)
		nextKey()
		ply:ChatPrint("Selected Camera ["..generator1.."]")
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Game Over Camera Placer",
	desc = "LMB: Place Camera Start & Camera End, RMB:Remove Selected Camera, Reload: Cycle Selected Camera",
	icon = "icon16/camera.png",
	weight = 24,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, tooldata)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		local color_red = Color(150, 50, 50)

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("Warning, removing a camera will cause the entire table to be shifted over")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(0, 140)
		textw:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("Camera order will change!")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 160)
		textw2:CenterHorizontal()

		return DProperties
	end,
	-- defaultdata = {}
	drawhud = function()
		local ply = LocalPlayer()
		local gocamerastarts = nzMapping.Settings.gocamerastart
		local gocameraends = nzMapping.Settings.gocameraend
		if gocamerastarts and not table.IsEmpty(gocamerastarts) then
			local mat = Material("cable/chain")
			local size = Vector(5,5,5)
			cam.Start3D()
				for id, pos in pairs(gocamerastarts) do
					local ourang = angle_zero
					if gocameraends and gocameraends[id] then
						ourang = (gocameraends[id] - pos):Angle()

						local dist = (pos:Distance(gocameraends[id]))/48
						local scroll = (CurTime() * -2)
						render.SetMaterial(mat)
						render.DrawBeam(pos, gocameraends[id], 2, scroll, scroll + dist, color_white)

						render.DrawWireframeBox(gocameraends[id], (pos - gocameraends[id]):Angle(), Vector(-5,-5,-5), Vector(5,5,5), color_white, true)
					end

					render.DrawWireframeBox(pos, ourang, -size, size, color_white, true)
				end
			cam.End3D()
		end
	end,
})