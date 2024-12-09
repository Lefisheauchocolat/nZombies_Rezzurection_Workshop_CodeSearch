-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("infileditor", {
	displayname = "Infil Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:InfilPos({tr.HitPos, Angle(0,ply:GetAngles().y-180,0)}, data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_infil_point" then
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
	displayname = "Infil Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/car.png",
	weight = 5.9,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.infiltype
		valz["Row2"] = data.infilchief

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		function DProperties.CompileData()
			data.infiltype = valz["Row1"]
			data.infilchief = valz["Row2"]
			return data
		end
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "infileditor")
		end

		local Row = DProperties:CreateRow("Config Settings", "Enable Infil?")
		Row:Setup("Boolean")
		Row:SetValue(nzSettings:GetSimpleSetting("InfilEnabled", false))
		Row:SetToolTip("If you want disable infil without removing positions on map, just disable this.")
		nzSettings:SyncValueToElement("InfilEnabled", Row)
		Row.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("InfilEnabled", tobool(val))
		end

		local Row1 = DProperties:CreateRow("Position Settings", "Infil Type")
		Row1:Setup( "Combo" )
		Row1:AddChoice("by Black Hawk", "Heli")
		Row1:AddChoice("by Van", "Van")
		Row1:AddChoice("by Teleportation", "Teleport")
		Row1.DataChanged = function( _, val )
			valz["Row1"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row2 = DProperties:CreateRow("Position Settings", "Infil Chief Model")
		Row2:Setup("Generic")
		Row2:SetValue("models/player/urban.mdl")
		nzSettings:SyncValueToElement("InfilChief", Row2)
		Row2.DataChanged = function( _, val ) 
			valz["Row2"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Tip: Place your position away from walls to prevent bugs.")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 160)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("One position of the van can use 6 players, a helicopter or teleporter can use 3 players.\nIf players are not within the spawn range, they will spawn\nwithout animation on player spawn positions, unlike infil points..")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 240)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 80)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Infil Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	defaultdata = {
		infiltype = "Heli",
		infilchief = "models/player/urban.mdl"
	},
})

if SERVER then	
	nzMapping:AddSaveModule("InfilPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_infil_point")) do
				table.insert(tab_pos, {{v:GetPos(), v:GetAngles()}, {infiltype = v.type, infilchief = v.chief}})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				print(v[2])
				PrintTable(v[2])
				nzMapping:InfilPos(v[1], v[2])
			end
		end,
		cleanents = {"bo6_infil_point"},
	})
end