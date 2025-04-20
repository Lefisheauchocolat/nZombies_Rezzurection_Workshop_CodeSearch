local select1, select2 = 2, 4

nzTools:CreateTool("shootable", {
	displayname = "Shootable Placer",
	desc = "LMB: Place/Update Shootable, RMB: Remove Shootable",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_shootable" and data then
			ent:Update(data)
			return
		end
		if IsValid(ply) and data and data.wepclass ~= "" and not weapons.Get(data.wepclass) then
			ply:ChatPrint("Invalid weapon class set!")
			return
		end

		nzMapping:SpawnShootable(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_shootable" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_shootable" then
			if ply:KeyDown(IN_SPEED) then
				ent:SetAngles(ent:GetAngles() - Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			else
				ent:SetAngles(ent:GetAngles() + Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Shootable Placer",
	desc = "LMB: Place/Update Shootable, RMB: Remove Shootable",
	icon = "icon16/gun.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tobool(data.killall)
		valz["Row2"] = tobool(data.upgrade)
		valz["Row3"] = tobool(data.global)
		valz["Row4"] = tostring(data.door)
		valz["Row5"] = tonumber(data.pointamount)
		valz["Row6"] = tonumber(data.rewardtype)
		valz["Row7"] = tonumber(data.hurttype)
		valz["Row8"] = tostring(data.model)
		valz["Row9"] = tostring(data.sound)
		valz["Row10"] = tonumber(data.flag)
		valz["Row11"] = tostring(data.wepclass)
		valz["Row12"] = tonumber(data.skin)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.killall = tobool(valz["Row1"])
			data.upgrade = tobool(valz["Row2"])
			data.global = tobool(valz["Row3"])
			data.door = tostring(valz["Row4"])
			data.pointamount = tonumber(valz["Row5"])
			data.rewardtype = tonumber(valz["Row6"])
			data.hurttype = tonumber(valz["Row7"])
			data.model = tostring(valz["Row8"])
			data.sound = tostring(valz["Row9"])
			data.flag = tonumber(valz["Row10"])
			data.wepclass = tostring(valz["Row11"])
			data.skin = tonumber(valz["Row12"])

			return data
		end

		function DProperties.UpdateData(data)
			//nzTools:UpdateShootables(data)
			nzTools:SendData(data, "shootable")
		end

		local Row10 = DProperties:CreateRow("Options", "Flag")
		Row10:Setup("Int", { min = 0, max = 1000 })
		Row10:SetValue(valz["Row10"])
		Row10.DataChanged = function( _, val ) valz["Row10"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row10:SetToolTip("If all targets are required to be activated, only ones with the same flag will count.")

		local Row1 = DProperties:CreateRow("Options", "Require all targets to be activated")
		Row1:Setup("Boolean")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Name.")

		local Row2 = DProperties:CreateRow("Options", "Upgraded weapon only")
		Row2:Setup("Boolean")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Require Pack a' Punch to activate.")

		local Row3 = DProperties:CreateRow("Options", "Global")
		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Should all players recieve reward?")

		local Row11 = DProperties:CreateRow("Options", "Specific weapon only")
		Row11:Setup("Generic")
		Row11:SetValue(valz["Row11"])
		Row11.DataChanged = function( _, val ) valz["Row11"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row11:SetToolTip("Require a specific weapon (class) to activate shootable, LEAVE EMPTY TO DISABLE")

		local Row4 = DProperties:CreateRow("Reward", "Door flag")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Only applicable if reward is a door.")

		local Row5 = DProperties:CreateRow("Reward", "Point reward amount")
		Row5:Setup("Int", { min = 10, max = 10000 })
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Only applicable if reward is points.")

		local Row6 = DProperties:CreateRow("Reward", "Reward Type")
		Row6:Setup("Combo")
		Row6:AddChoice("Give points", 1, select1 == 1)
		Row6:AddChoice("Give random perk", 2, select1 == 2)
		Row6:AddChoice("PAP held weapon", 3, select1 == 3)
		Row6:AddChoice("Open door", 4, select1 == 4)
		Row6:AddChoice("Activate power", 5, select1 == 5)
		Row6.DataChanged = function( _, val ) select1 = val valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Name.")

		local Row7 = DProperties:CreateRow("Options", "Damage Type")
		Row7:Setup("Combo")
		Row7:AddChoice("Melee Damage", 1, select2 == 1)
		Row7:AddChoice("Explosive Damage", 2, select2 == 2)
		Row7:AddChoice("Fire Damage", 3, select2 == 3)
		Row7:AddChoice("Bullet Damage", 4, select2 == 4)
		Row7:AddChoice("Shock Damage", 5, select2 == 5)
		Row7.DataChanged = function( _, val ) select2 = val valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Damage type required to activate.")

		local Row8 = DProperties:CreateRow("Model", "Model path")
		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetToolTip("If no model is provided, defaults to Teddy.")

		local Row12 = DProperties:CreateRow("Model", "Model skin")
		Row12:Setup("Int", { min = 0, max = 128 })
		Row12:SetValue(valz["Row12"])
		Row12.DataChanged = function( _, val ) valz["Row12"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row12:SetToolTip("as on the tin.")

		local Row9 = DProperties:CreateRow("Sound", "Activation Sound path")
		Row9:Setup("Generic")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row9:SetToolTip("If no sound is provided, defaults to 'zmb/stinger/afterlife_end.wav'")

		local UpdateButn = DProperties:Add("DButton")
		UpdateButn:SetText( "Update All Shootables" )
		UpdateButn:SetPos( 0, 420 )
		UpdateButn:SetSize( 480, 30 )
		UpdateButn.DoClick = function()
			nzTools:UpdateShootables(DProperties.CompileData())
		end

		local color_red = Color(150, 50, 50)

		local Butn = DProperties:Add("DButton")
		Butn:SetText( "print assets to console" )
		Butn:SetPos( 0, 380 )
		Butn:SetSize( 240, 30 )
		Butn:CenterHorizontal()
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("zmb/stinger/afterlife_end.wav")
			print("zmb/tomb/medal_acquired_mn.wav")
			print("zmb/alcatraz/soul_count.wav")
			print("zmb/buried/lantern_fill_01.wav")
			print("-------------------------------------------")
			print("models/nzr/song_ee/teddybear.mdl")
			print("models/nzr/song_ee/teddybear_moon.mdl")
			print("models/nzr/song_ee/teddybear_shanks.mdl")
			print("models/nzr/song_ee/vodka.mdl")
			print("-------------------------------------------")
		end

		return DProperties
	end,

	defaultdata = {
		flag = 0,
		killall = false,
		upgrade = false,
		global = true,
		door = "",
		pointamount = 1000,
		rewardtype = 2,
		hurttype = 4,
		model = "models/nzr/song_ee/teddybear.mdl",
		sound = "zmb/stinger/afterlife_end.wav",
		wepclass = "",
		skin = 0,
	},
})

if SERVER then
	nzMapping:AddSaveModule("ShootableSpawns", {
		savefunc = function()
			local shootable_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_shootable")) do
				table.insert(shootable_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						flag = v:GetFlag(),
						model = v:GetModel(),
						hurttype = v:GetHurtType(),
						rewardtype = v:GetRewardType(),
						pointamount = v:GetPointAmount(),
						door = v:GetDoorFlag(),
						killall = v:GetKillAll(),
						upgrade = v:GetUpgrade(),
						global = v:GetGlobal(),
						sound = v.ActivateSound,
						wepclass = v:GetWepClass(),
						skin = v:GetSkin(),
					}
				})
			end

			return shootable_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnShootable(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_shootable"}
	})
end

if SERVER then
	hook.Add("OnRoundEnd", "NZ.RESPAWN.SHOOTABLES", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_shootable")) do
				v:Reset()
			end
		end
	end)

	util.AddNetworkString( "nzShootsUpdate" )

	local function ReceiveData(len, ply)
		local data = net.ReadTable()
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			v:Update(data)
		end
	end
	net.Receive( "nzShootsUpdate", ReceiveData )
end

if CLIENT then
	function nzTools:UpdateShootables(data)
		if data then
			net.Start("nzShootsUpdate")
				net.WriteTable(data)
			net.SendToServer()
		end
	end
end