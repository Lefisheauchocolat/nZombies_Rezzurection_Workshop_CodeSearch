-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("exfilzoneeditor", {
	displayname = "Exfil Zone Placer",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:ExfilLandingPos(tr.HitPos, Angle(0,ply:GetAngles().y-180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_exfil_point" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)

	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Exfil Zone Placer",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/door_in.png",
	weight = 5.5,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("You can find config settings for exfil in radio placer.")
		text:SetFont("DermaLarge")
		text:SetPos(0, 100)
		text:SetTextColor( Color(150, 50, 50) )
		text:SetSize(400, 60)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Tip: Place your position far away from walls to prevent bugs.\nYou can have many exfil zones on map!")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 260)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Exfil Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	--defaultdata = {}
})

if SERVER then	
	nzMapping:AddSaveModule("ExfilPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_exfil_point")) do
				table.insert(tab_pos, {type = "point", pos = v:GetPos(), ang = v:GetAngles()})
			end
			local r = ents.FindByClass("bo6_exfil_radio")[1]
			if IsValid(r) then
				table.insert(tab_pos, {type = "radio", pos = r:GetPos(), ang = r:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				if v.type == "radio" then
					nzMapping:ExfilRadioPos(v.pos, v.ang)
				else
					nzMapping:ExfilLandingPos(v.pos, v.ang)
				end
			end
		end,
		cleanents = {"bo6_exfil_point", "bo6_exfil_radio"},
	})
end