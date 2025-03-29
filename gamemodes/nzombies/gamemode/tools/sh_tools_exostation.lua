-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("exostationeditor", {
	displayname = "Exo Station Placer",
	desc = "LMB: Add Station, RMB: Remove Station",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:ExoStation(tr.HitPos, Angle(0,ply:GetAngles().y+90,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "aw_exostation" then
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
	displayname = "Exo Station Placer",
	desc = "LMB: Add Station, RMB: Remove Station",
	icon = "icon16/vector.png",
	weight = 5.899,
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
		text:SetText("Exosuit Module made by Hari")
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
	nzMapping:AddSaveModule("ExostationPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("aw_exostation")) do
				table.insert(tab_pos, {v:GetPos(), v:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:ExoStation(v[1], v[2])
			end
		end,
		cleanents = {"aw_exostation"},
	})
end