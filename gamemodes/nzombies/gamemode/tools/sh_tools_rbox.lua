nzTools:CreateTool("rbox", {
	displayname = "Random Box Spawnpoint",
	desc = "LMB: Place Random Box Spawnpoint, RMB: Remove Random Box Spawnpoint",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:BoxSpawn(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 90,0), data.PossibleSpawn, data.BoxType, ply)
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "random_box_spawns" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Random Box Spawnpoint",
	desc = "LMB: Place Random Box Spawnpoint, RMB: Remove Random Box Spawnpoint",
	icon = "icon16/briefcase.png",
	weight = 4,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tobool(data.PossibleSpawn)
		valz["Row2"] = tostring(data.BoxType)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 300 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			data.PossibleSpawn 	= tobool(valz["Row1"])
			data.BoxType 		= tostring(valz["Row2"])
			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "rbox")
		end

		local Row1 = DProperties:CreateRow( "Random Box", "Possible Spawn?" )
		Row1:Setup( "Boolean" )
		Row1:SetValue( valz["Row1"] )
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow( "Random Box", "Box Type" )
		Row2:Setup( "Combo" )
		Row2:AddChoice("Original"						,"Original")
		Row2:AddChoice("Black Ops 3"					,"Black Ops 3")
		Row2:AddChoice("Black Ops 3(Quiet Cosmos)"		,"Black Ops 3(Quiet Cosmos)")
		Row2:AddChoice("Leviathan"						,"Leviathan")
		Row2:AddChoice("Mob of the Dead"				,"Mob of the Dead")
		Row2:AddChoice("Nacht Der Untoten"				,"Nacht Der Untoten")
		Row2:AddChoice("Verruckt"						,"Verruckt")
		Row2:AddChoice("UGX Coffin"						,"UGX Coffin")
		Row2:AddChoice("Cold War"						,"Cold War")
		Row2:AddChoice("Present Box"					,"Present Box")
		Row2:AddChoice("Origins"						,"Origins")
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		PossibleSpawn = 0,
		BoxType = tostring(nzMapping.Settings.boxtype) and nzMapping.Settings.boxtype ~= nil or "Original",
	}
})