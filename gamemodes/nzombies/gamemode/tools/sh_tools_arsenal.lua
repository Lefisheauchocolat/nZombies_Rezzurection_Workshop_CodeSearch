-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("arsenaleditor", {
	displayname = "Arsenal Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:Arsenal(tr.HitPos, Angle(0,ply:GetAngles().y+90,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_arsenal" then
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
	displayname = "Arsenal Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/table_edit.png",
	weight = 5.855,
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

		for k, tab in pairs(nzAATs.Data) do
			local name = tab.name
			local Row1 = DProperties:CreateRow("Config Settings", name.." Salvage Cost")
			Row1:Setup("Generic")
			Row1:SetValue(nzSettings:GetSimpleSetting("ArsenalSalvageCost"..k, 500))
			nzSettings:SyncValueToElement("ArsenalSalvageCost"..k, Row1)
			Row1.DataChanged = function( _, val ) 
				nzSettings:SetSimpleSetting("ArsenalSalvageCost"..k, tonumber(val) or 500)
			end
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Require Power?")
		Row2:Setup("Boolean")
		Row2:SetValue(nzSettings:GetSimpleSetting("ArsenalRequirePower", false))
		nzSettings:SyncValueToElement("ArsenalRequirePower", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ArsenalRequirePower", tobool(val) or false)
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Crafting Module made by Hari")
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
	nzMapping:AddSaveModule("ArsenalPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_arsenal")) do
				table.insert(tab_pos, {v:GetPos(), v:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:Arsenal(v[1], v[2])
			end
		end,
		cleanents = {"bo6_arsenal"},
	})
end