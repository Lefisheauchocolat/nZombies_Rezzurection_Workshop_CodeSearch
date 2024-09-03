nzTools:CreateTool("zbossspawn", {
	displayname = "Boss Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	condition = function(wep, ply)
		-- Function to check whether a player can access this tool - always accessible
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		-- Create a new spawnpoint and set its data to the guns properties
		local ent
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_boss" then
			ent = tr.Entity -- No need to recreate if we shot an already existing one
		else
			ent = nzMapping:ZedBossSpawn(tr.HitPos,(Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), tobool(data.flag) and data.link or nil, data.link2, data.link3, data.roundactive, ply)
		end

		ent.flag = data.flag
		if tobool(data.flag) and ent.link != "" then
			ent.link = data.link
			ent.link2 = data.link2
			ent.link3 = data.link3
		end

		-- For the link displayer
		if data.link then
			ent:SetLink(data.link)
		end
		if data.link2 then
			ent:SetLink2(data.link2)
		end
		if data.link3 then
			ent:SetLink3(data.link3)
		end
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		-- Remove entity if it is a zombie spawnpoint
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_boss" then
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
	displayname = "Boss Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	icon = "icon16/user_suit.png",
	weight = 2,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.flag
		valz["Row2"] = data.link
		valz["Row3"] = data.link2
		valz["Row4"] = data.link3
		valz["Row5"] = data.roundactive

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			local str = "nil"
			local str2 = "nil"
			local str3 = "nil"
			if valz["Row1"] == 0 then
				str = nil
				str2 = nil
				str3 = nil
				data.flag = 0
			else
				str = valz["Row2"]
				str2 = valz["Row3"]
				str3 = valz["Row4"]
				data.flag = 1
			end

			data.link = str
			data.link2 = str2
			data.link3 = str3
			
			data.roundactive = valz["Row5"]

			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "zbossspawn")
		end

		local Row1 = DProperties:CreateRow( "Main", "Enable Flag?" )
		Row1:Setup( "Boolean" )
		Row1:SetValue( valz["Row1"] )
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow( "Main", "Flag" )
		Row2:Setup( "Integer" )
		Row2:SetValue( valz["Row2"] )
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row3 = DProperties:CreateRow( "Main", "Flag 2" )
		Row3:Setup( "Integer" )
		Row3:SetValue( valz["Row3"] )
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row4 = DProperties:CreateRow( "Main", "Flag 3" )
		Row4:Setup( "Integer" )
		Row4:SetValue( valz["Row4"] )
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row5 = DProperties:CreateRow( "Settings", "Round Activation" )
		Row5:Setup( "Integer" )
		Row5:SetValue( valz["Row5"] )
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Boss Spawnpoints apply to the set boss")
		text:SetFont("Trebuchet18")
		text:SetTextColor( Color(50, 50, 50) )
		text:SizeToContents()
		text:Center()

		return DProperties
	end,
	defaultdata = {
		flag = 0,
		link = 1,
		link2 = 1,
		link3 = 1,
		roundactive = 0,
	}
})
