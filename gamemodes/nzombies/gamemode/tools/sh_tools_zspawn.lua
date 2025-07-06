nzTools:CreateTool("zspawn", {
	displayname = "Zombie Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	condition = function(wep, ply)
		-- Function to check whether a player can access this tool - always accessible
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		-- Create a new spawnpoint and set its data to the guns properties
		local ent
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_normal" then
			ent = tr.Entity -- No need to recreate if we shot an already existing one
		else
			ent = nzMapping:ZedSpawn(tr.HitPos,(Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), tobool(data.flag) and data.link or nil, data.link2, data.link3, tobool(data.master), data.spawntype, data.zombietype, data.roundactive, data.spawnchance, tobool(data.miscspawn), data.totalspawn, data.aliveamount, data.roundcooldown, ply)
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

		ent.master 			= data.master
		ent.roundactive 	= data.roundactive
		ent.spawnchance 	= data.spawnchance
		ent.miscspawn 		= data.miscspawn
		ent.totalspawn 		= data.totalspawn
		ent.aliveamount 	= data.aliveamount
		ent.roundcooldown 	= data.roundcooldown
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		-- Remove entity if it is a zombie spawnpoint
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_normal" then
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
}, { -- Switch on to the client table (interfaces, defaults, HUD elements)
	displayname = "Zombie Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	icon = "icon16/user_green.png",
	weight = 1,
	condition = function(wep, ply)
		-- Function to check whether a player can access this tool - always accessible
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.flag
		valz["Row2"] = data.link
		valz["Row3"] = data.link2
		valz["Row4"] = data.link3
		valz["Row6"] = data.master
		valz["Row7"] = data.spawntype
		valz["Row8"] = data.zombietype
		valz["Row9"] = data.roundactive
		valz["Row10"] = data.spawnchance
		valz["Row11"] = data.miscspawn
		valz["TotalSpawn"] = data.totalspawn
		valz["AliveAmount"] = data.aliveamount
		valz["RoundCooldown"] = data.roundcooldown


		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			local str = "nil"
			local str2 = "nil"
			local str3 = "nil"
			local num = 0
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

			data.master 		= valz["Row6"]
			data.spawntype 		= valz["Row7"]
			data.zombietype 	= valz["Row8"]
			data.roundactive 	= valz["Row9"]
			data.spawnchance 	= valz["Row10"]
			data.miscspawn 		= valz["Row11"]
			data.totalspawn 	= valz["TotalSpawn"]
			data.aliveamount 	= valz["AliveAmount"]
			data.roundcooldown 	= valz["RoundCooldown"]

			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "zspawn")
		end

		local Row6 = DProperties:CreateRow( "Main", "Master Spawner?" )
		Row6:Setup( "Boolean" )
		Row6:SetValue( valz["Row6"] )
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row1 = DProperties:CreateRow( "Main", "Enable Flag?" )
		Row1:Setup( "Boolean" )
		Row1:SetValue( valz["Row1"] )
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row2 = DProperties:CreateRow( "Main", "Flag 1" )
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
		
		local Row7 = DProperties:CreateRow( "Settings", "Spawn Type" )
			Row7:Setup( "Combo" )
			Row7:AddChoice("Riser"							,0)
	        Row7:AddChoice("No Animation"					,1)
	        Row7:AddChoice("Undercroft"						,3)
			Row7:AddChoice("Wall Emerge"					,4)
			Row7:AddChoice("Jump Spawn"						,5)
			Row7:AddChoice("Barrel Climbout"				,6)
			Row7:AddChoice("Ceiling Dropdown Low"			,7)
			Row7:AddChoice("Ceiling Dropdown High"			,8)
			Row7:AddChoice("Ground Wall(Like Undercroft)"	,9)
			Row7:AddChoice("Dimensional Wall Emerge"		,10)
			Row7:AddChoice("Jump Portal"					,11)
			Row7:AddChoice("Elevator Spawn(Floor)"			,12)
			Row7:AddChoice("Elevator Spawn(Ceiling)"		,13)
			Row7:AddChoice("Crawl Spawn"					,14)
			Row7:AddChoice("Under Bed Spawn"				,15)
			Row7:AddChoice("Alcove Spawn 40"				,16)
			Row7:AddChoice("Alcove Spawn 56"				,17)
			Row7:AddChoice("Alcove Spawn 96"				,18)
			Row7:AddChoice("Riser(IW Style)"				,19)
			Row7:AddChoice("Crawl Spawn(BO6 Style)"			,20)
			Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row8 = DProperties:CreateRow("Settings", "Zombie Type")
		Row8:Setup( "Combo" )
		local found = false
		for k,v in pairs(nzConfig.ValidEnemies) do
			if k == valz["Row8"] then
				Row8:AddChoice(k, k, true)
				found = true
			else
				Row8:AddChoice(k, k, false)
			end
		end
		for k,v in pairs(nzRound.BossData) do
			if k == valz["Row8"] then
				Row8:AddChoice(v, v, true)
				found = true
			else
				Row8:AddChoice(v, v, false)
			end
		end
		Row8:AddChoice("none", "none", !found)
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row11 = DProperties:CreateRow( "Mixed Spawn Settings", "Mixed Spawn?" )
		Row11:Setup( "Boolean" )
		Row11:SetValue( valz["Row11"] )
		Row11.DataChanged = function( _, val ) valz["Row11"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row9 = DProperties:CreateRow( "Mixed Spawn Settings", "Round Activation" )
		Row9:Setup( "Integer" )
		Row9:SetValue( valz["Row9"] )
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row10 = DProperties:CreateRow( "Mixed Spawn Settings", "Spawn Chance" )
		Row10:Setup( "Integer" )
		Row10:SetValue( valz["Row10"] )
		Row10.DataChanged = function( _, val ) valz["Row10"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local TotalSpawn = DProperties:CreateRow( "Mixed Spawn Settings", "Total Possible Spawns" )
		TotalSpawn:Setup( "Integer" )
		TotalSpawn:SetValue( valz["TotalSpawn"] )
		TotalSpawn.DataChanged = function( _, val ) valz["TotalSpawn"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local AliveAmount = DProperties:CreateRow( "Mixed Spawn Settings", "Alive at Once" )
		AliveAmount:Setup( "Integer" )
		AliveAmount:SetValue( valz["AliveAmount"] )
		AliveAmount.DataChanged = function( _, val ) valz["AliveAmount"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local RoundCooldown = DProperties:CreateRow( "Mixed Spawn Settings", "Round Cooldown" )
		RoundCooldown:Setup( "Integer" )
		RoundCooldown:SetValue( valz["RoundCooldown"] )
		RoundCooldown.DataChanged = function( _, val ) valz["RoundCooldown"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local text = vgui.Create("DLabel", DProperties)
		text:SetText("You can only have one Master Spawn! You need at least one so zombies can spawn!")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 375)
		text:SetTextColor( Color(250, 50, 50) )
		text:SizeToContents()
		text:CenterHorizontal()

		local text2 = vgui.Create("DLabel", DProperties)
		text2:SetText("You must add flags in order!")
		text2:SetFont("Trebuchet18")
		text2:SetPos(0, 385)
		text2:SetTextColor( Color(250, 50, 50) )
		text2:SizeToContents()
		text2:CenterHorizontal()

		return DProperties
	end,
	defaultdata = {
		flag = 0,
		link = 1,
		link2 = 1,
		link3 = 1,
		master = 0,
		spawntype = 0,
		zombietype = zombietype or "none",
		roundactive = 0,
		spawnchance = 100,
		miscspawn = 0,
		totalspawn = 0,
		aliveamount = 0,
		roundcooldown = 0,
	}
})
