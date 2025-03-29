-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("humanspawner", {
	displayname = "Human Spawner",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:HumanPos(tr.HitPos, Angle(0,ply:GetAngles().y-180,0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_human_point" then
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
	displayname = "Human Spawner",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/group_add.png",
	weight = 5.94,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.baseClass
		valz["Row2"] = data.baseModel
		valz["Row3"] = data.hp
		valz["Row4"] = data.weaponClass
		valz["Row5"] = data.hostileToPlayer
		valz["Row6"] = data.noTargetToZombies
		valz["Row7"] = data.followNearestPlayer
		valz["Row8"] = data.flag
		valz["Row9"] = data.isDeathAnim
		valz["Row10"] = data.flag2
		valz["Row11"] = data.flag3
		valz["Row12"] = data.chance

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		function DProperties.CompileData()
			data.baseClass = valz["Row1"]
			data.baseModel = valz["Row2"]
			data.hp = valz["Row3"]
			data.weaponClass = valz["Row4"]
			data.hostileToPlayer = valz["Row5"]
			data.noTargetToZombies = valz["Row6"]
			data.followNearestPlayer = valz["Row7"]
			data.flag = valz["Row8"]
			data.isDeathAnim = valz["Row9"]
			data.flag2 = valz["Row10"]
			data.flag3 = valz["Row11"]
			data.chance = valz["Row12"]
			return data
		end
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "humanspawner")
		end

		local Row1 = DProperties:CreateRow("Position Settings", "NPC Class")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) 
			valz["Row1"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row2 = DProperties:CreateRow("Position Settings", "NPC Model")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) 
			valz["Row2"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row3 = DProperties:CreateRow("Position Settings", "NPC Health")
		Row3:Setup("Generic")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) 
			valz["Row3"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row4 = DProperties:CreateRow("Position Settings", "NPC Weapon")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) 
			valz["Row4"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row5 = DProperties:CreateRow("Position Settings", "Enemy for Players?")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) 
			valz["Row5"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row6 = DProperties:CreateRow("Position Settings", "Invisible for Zombies?")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) 
			valz["Row6"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row7 = DProperties:CreateRow("Position Settings", "Follow Nearest Player?")
		Row7:Setup("Boolean")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) 
			valz["Row7"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end
		
		local Row9 = DProperties:CreateRow("Position Settings", "Is Death Animation?")
		Row9:Setup("Boolean")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) 
			valz["Row9"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row8 = DProperties:CreateRow("Position Settings", "Door Flag 1")
		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) 
			valz["Row8"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row10 = DProperties:CreateRow("Position Settings", "Door Flag 2")
		Row10:Setup("Generic")
		Row10:SetValue(valz["Row10"])
		Row10.DataChanged = function( _, val ) 
			valz["Row10"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row11 = DProperties:CreateRow("Position Settings", "Door Flag 3")
		Row11:Setup("Generic")
		Row11:SetValue(valz["Row11"])
		Row11.DataChanged = function( _, val ) 
			valz["Row11"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local Row12 = DProperties:CreateRow("Position Settings", "Spawn Chance")
		Row12:Setup("Generic")
		Row12:SetValue(valz["Row12"])
		Row12.DataChanged = function( _, val ) 
			valz["Row12"] = val 
			DProperties.UpdateData(DProperties.CompileData())
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("You can leave empty any settings to use default values.\nUse HL2 NPC for stability.")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 250)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 80)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Human Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	defaultdata = {
		baseClass = "npc_combine_s",
		baseModel = "",
		hp = 100,
		weaponClass = "weapon_smg1",
		hostileToPlayer = false,
		noTargetToZombies = false,
		followNearestPlayer = false,
		flag = "",
		isDeathAnim = false,
		flag2 = "",
		flag3 = "",
		chance = "100",
	},
})

if SERVER then	
	nzMapping:AddSaveModule("HumanPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_human_point")) do
				table.insert(tab_pos, {{v:GetPos(), v:GetAngles()}, v:GetData()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:HumanPos(v[1][1], v[1][2], v[2])
			end
		end,
		cleanents = {"bo6_human_point"},
	})
end