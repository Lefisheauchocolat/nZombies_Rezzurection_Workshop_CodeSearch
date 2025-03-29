nzTools:CreateTool("vzspawn", {
	displayname = "Environmental Zombie Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:ZedVignSpawn(tr.HitPos,(Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_vign" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_spawn_zombie_vign" then
			tr.Entity:Use(ply)
		end
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Environmental Zombie Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	icon = "icon16/user_green.png",
	weight = 5,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] 			= data.spawntype
		valz["Row2"] 			= data.spawnchance
		valz["Row3"] 			= data.zombietype
		valz["InstantAwake"] 	= data.instantawake
		valz["AwakeRadius"] 	= data.awakeradius
		valz["Row4"] 			= data.link
		valz["Row5"] 			= data.link2
		valz["Row6"] 			= data.link3

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.spawntype 			= tonumber(valz["Row1"])
			data.spawnchance 		= tostring(valz["Row2"])
			data.zombietype 		= tostring(valz["Row3"])
			data.instantawake 		= tobool(valz["InstantAwake"])
			data.awakeradius 		= tostring(valz["AwakeRadius"])
			data.link 				= tostring(valz["Row4"])
			data.link2 				= tostring(valz["Row5"])
			data.link3 				= tostring(valz["Row6"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "vzspawn")
		end

		local Row1 = DProperties:CreateRow("Options", "Type")
		Row1:Setup("Combo")
		Row1:AddChoice('Harmful - Slumped', 0, valz["Row1"] == 0)
		Row1:AddChoice('Harmful - Tranzit', 1, valz["Row1"] == 1)
		Row1:AddChoice('Harmful - Eating Corpse 1', 2, valz["Row1"] == 2)
		Row1:AddChoice('Harmful - Eating Corpse 2', 3, valz["Row1"] == 3)
		Row1:AddChoice('Harmless - Car Left Seat', 4, valz["Row1"] == 4)
		Row1:AddChoice('Harmless - Car Right Seat', 5, valz["Row1"] == 5)
		Row1.DataChanged = function( _, val ) valz["Row1"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow( "Options", "Spawn Chance" )
		Row2:Setup( "Integer" )
		Row2:SetValue( valz["Row2"] )
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row3 = DProperties:CreateRow("Options", "Zombie Type")
		Row3:Setup( "Combo" )
		local found = false
		for k,v in pairs(nzConfig.ValidEnemies) do
			if k == valz["Row3"] then
				Row3:AddChoice(k, k, true)
				found = true
			else
				Row3:AddChoice(k, k, false)
			end
		end
		Row3:AddChoice("none", "none", !found)
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local InstantAwake = DProperties:CreateRow("Options", "Spawn Awoken?")
		InstantAwake:Setup("Boolean")
		InstantAwake:SetValue(valz["InstantAwake"])
		InstantAwake.DataChanged = function( _, val ) valz["InstantAwake"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local AwakeRadius = DProperties:CreateRow("Options", "Awaken Radius")
		AwakeRadius:Setup("Generic")
		AwakeRadius:SetValue(valz["AwakeRadius"])
		AwakeRadius.DataChanged = function( _, val ) valz["AwakeRadius"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row4 = DProperties:CreateRow("Door Options", "Door flag")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row5 = DProperties:CreateRow("Door Options", "Door flag 2")
		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row6 = DProperties:CreateRow("Door Options", "Door flag 3")
		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Leave first Flag blank to trigger on game start.")
		text:SetFont("Trebuchet18")
		text:SetTextColor(Color(50, 50, 50))
		text:SizeToContents()
		text:Center()

		local text2 = vgui.Create("DLabel", DProperties)
		text2:SetText("Was made with normal zombies in mind, change zombie type with caution.")
		text2:SetFont("Trebuchet18")
		text2:SetTextColor(Color(255, 50, 50))
		text2:SizeToContents()
		text2:SetPos(25, 255)
		--text2:Center()

		return DProperties

	end,
	
	defaultdata = {
		spawntype = 0,
		spawnchance = 100,
		awakeradius = 175,
		instantawake = false,
		zombietype = zombietype or "none",
		link = "",
		link2 = "",
		link3 = "",
	}
})

if SERVER then

	nzMapping:AddSaveModule("ZedVignSpawn", {
		savefunc = function()
			local vign_spawns = {}
			for _, v in pairs(ents.FindByClass("nz_spawn_zombie_vign")) do
				table.insert(vign_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						spawntype 		= v:GetSpawnType(),
						zombietype 		= v:GetZombieType() or "none",
						spawnchance 	= v:GetSpawnChance(),
						instantawake 	= v:GetInstantAwake(),
						awakeradius 	= v:GetAwakeRadius(),
						link 			= v:GetLink(),
						link2 			= v:GetLink2(),
						link3 			= v:GetLink3(),
					},
				})
			end
			return vign_spawns
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:ZedVignSpawn(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"nz_spawn_zombie_vign"},
	})

end