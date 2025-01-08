-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("craftingeditor", {
	displayname = "Crafting Table Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:CraftingTable(tr.HitPos, Angle(0,ply:GetAngles().y-180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_crafting_table" then
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
	displayname = "Crafting Table Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/table_edit.png",
	weight = 5.85,
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
	nzMapping:AddSaveModule("CraftingPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_crafting_table")) do
				table.insert(tab_pos, {v:GetPos(), v:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:CraftingTable(v[1], v[2])
			end
		end,
		cleanents = {"bo6_crafting_table"},
	})
end