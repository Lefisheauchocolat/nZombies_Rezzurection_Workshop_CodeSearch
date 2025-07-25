nzTools:CreateTool("barricade", {
	displayname = "Barricade Creator",
	desc = "LMB: Place Barricade, RMB: Remove Barricade",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "breakable_entry" then
			nzMapping:BreakEntry(ent:GetPos(), ent:GetAngles(), data.planks, data.jump, data.boardtype, data.prop, data.jumptype, data.plycollision, data.ambsnds, ply)
			ent:Remove()
		else
			nzMapping:BreakEntry(tr.HitPos + Vector(0,0,0), Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2],0), data.planks, data.jump, data.boardtype, data.prop, data.jumptype, data.plycollision, data.ambsnds, ply)
		end
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "breakable_entry" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		//Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Barricade Creator",
	desc = "LMB: Place Barricade, RMB: Remove Barricade",
	icon = "icon16/door.png",
	weight = 7,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.planks
		valz["Row2"] = data.jump
		valz["Row3"] = data.boardtype
		valz["Row4"] = data.prop
		valz["Row5"] = data.jumptype
		valz["Row6"] = data.plycollision
		valz["Row7"] = data.ambsnds

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			data.planks 		= valz["Row1"]
			data.jump 			= valz["Row2"]
			data.boardtype 		= valz["Row3"]
			data.prop 			= valz["Row4"]
			data.jumptype 		= valz["Row5"]
			data.plycollision 	= valz["Row6"]
			data.ambsnds 		= valz["Row7"]

			--PrintTable(data)
			
			return data
		end
		
		function DProperties.UpdateData(data) -- This function will be overwritten if opened via context menu
			nzTools:SendData(data, "barricade")
		end

		local Row1 = DProperties:CreateRow( "Main", "Has Planks?" )
		Row1:Setup( "Boolean" )
		Row1:SetValue( valz["Row1"] )
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow( "Main", "Jump Animations?" )
		Row2:Setup( "Boolean" )
		Row2:SetValue( valz["Row2"] )
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row3 = DProperties:CreateRow( "Settings", "Board Type?" )
		Row3:Setup("Combo")
		--Row3:AddChoice("Wooden Boards(NZ CLASSIC)", 5)
		Row3:AddChoice("Wooden Boards(BO2/OG)", 1)
        Row3:AddChoice("Wooden Boards(BO4/BOCW)", 4)
        Row3:AddChoice("Metal Rebar", 2)
        Row3:AddChoice("Vent Slats", 3)
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetSelected(valz["Row3"])

		local Row4 = DProperties:CreateRow( "Settings", "Prop" )
		Row4:Setup( "Combo" )
		Row4:AddChoice("None",0)
        Row4:AddChoice("Cinderblocks",1)
        Row4:AddChoice("Metal Barrel",3)
		Row4:AddChoice("Broken Door",4)
		Row4:AddChoice("Sandbag",5)
		Row4:AddChoice("Rocks",6)
		Row4:AddChoice("Wooden Barrel",7)
		Row4:AddChoice("Wooden Crate",8)
		Row4:AddChoice("Barbwire Fence",9)
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row5 = DProperties:CreateRow( "Settings", "Jump Type" )
		Row5:Setup( "Combo" )
		Row5:AddChoice("Mantle Over: Barricade(Default)",0)
        Row5:AddChoice("Mantle Over: 128 Units"			,1)
        Row5:AddChoice("Mantle Over: 96 Units"			,2)
        Row5:AddChoice("Mantle Over: 72 Units"			,3)
        Row5:AddChoice("Mantle Over: 48 Units"			,4)
        Row5:AddChoice("Jump Up: 128 Units"				,5)
        Row5:AddChoice("Jump Up Fast: 128 Units"		,6)
        Row5:AddChoice("Jump Down: 128 Units"			,7)
        Row5:AddChoice("Jump Through: Closet Door"		,8)
        Row5:AddChoice("Crawl Through: Car Slow"		,9)
        Row5:AddChoice("Crawl Through: Car Fast"		,10)
        Row5:AddChoice("Crawl Through: Car Super Fast"	,11)
        Row5:AddChoice("Mantle Over: 36 Units Fast"		,12)
        Row5:AddChoice("Mantle Over: 48 Units Fast"		,13)
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row6 = DProperties:CreateRow( "Misc", "Player Collision" )
		Row6:Setup( "Boolean" )
		Row6:SetValue( valz["Row6"] )
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row7 = DProperties:CreateRow( "Misc", "Ambient Sounds" )
		Row7:Setup( "Boolean" )
		Row7:SetValue( valz["Row7"] )
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		

		return DProperties
	end,
	defaultdata = {
		planks = 1,
		jump = 0,
		boardtype = 1,
		prop = 0,
		jumptype = 0,
		plycollision = 1,
		ambsnds = 0,
	}
})