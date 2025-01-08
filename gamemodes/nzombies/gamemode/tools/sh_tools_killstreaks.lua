-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("killstreakeditor", {
	displayname = "Chopper & Hellstorm Path",
	desc = "LMB: Add Chopper Gunner Position, RMB: Add Hellstorm Position, R: Clear Positions in 256 Radius",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:KillstreakChopperPath(ply:EyePos(), Angle(0,ply:GetAngles().y,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		nzMapping:KillstreakHellstormPath(ply:EyePos(), Angle(0,ply:GetAngles().y,0), ply)
	end,
	Reload = function(wep, ply, tr, data)
		for _, ent in pairs(ents.FindInSphere(ply:EyePos(), 256)) do
			if ent:GetClass() == "bo6_choppergunner_point" or ent:GetClass() == "bo6_hellstorm_point" then
				ent:Remove()
			end
		end
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Chopper & Hellstorm Path",
	desc = "LMB: Add Chopper Gunner Position, RMB: Add Hellstorm Position, R: Clear Positions in 256 Radius",
	icon = "icon16/arrow_up.png",
	weight = 5.88,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		function DProperties.CompileData()
			return data
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Chopper Gunner must have 2 or more path points to work!\nHellstorm must have 1 or more spawn points to work!")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 200)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Killstreak Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	defaultdata = {},
})

if SERVER then	
	nzMapping:AddSaveModule("KillstreakPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_choppergunner_point")) do
				table.insert(tab_pos, {"bo6_choppergunner_point", v:GetPos(), v:GetAngles()})
			end
			for _, v in pairs(ents.FindByClass("bo6_hellstorm_point")) do
				table.insert(tab_pos, {"bo6_hellstorm_point", v:GetPos(), v:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				if v[1] == "bo6_choppergunner_point" then
					nzMapping:KillstreakChopperPath(v[2], v[3])
				else
					nzMapping:KillstreakHellstormPath(v[2], v[3])
				end
			end
		end,
		cleanents = {"bo6_choppergunner_point", "bo6_hellstorm_point"},
	})
end