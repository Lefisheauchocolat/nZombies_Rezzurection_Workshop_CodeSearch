local selected1 = "tfa_bo3_raygun"

nzTools:CreateTool("chalks", {
	displayname = "Chalk Wallbuy Placer",
	desc = "LMB: Place Weapon Chalk, RMB: Place Blank Chalk, Reload: Rotate Weapon Chalk",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and data and ent:GetClass() == "nz_weaponchalk" then
			if data.class and weapons.Get(class) then
				ent:SetWepClass(tostring(data.class))
			end
			if data.price then
				ent:SetPrice(tonumber(data.price))
			end
			if data.icon and file.Exists("materials/"..data.icon, "GAME") then
				ent:SetHudIcon(tostring(data.icon))
			end
			if data.points then
				ent:SetPoints(tonumber(data.points))
			end
			return
		end

		for k, v in pairs(ents.FindByClass("nz_weaponchalk")) do
			if v:GetWepClass() == data.class then
				if IsValid(ply) then
					local pos = tostring(v:GetPos())
					ply:ChatPrint(data.class.." weapon chalk is already placed down at Vector("..pos..")")
				end
				return
			end
		end

		local ang = tr.HitNormal:Angle()
		ang:RotateAroundAxis(tr.HitNormal:Angle():Up(), -90)
		data.flipped = nil

		nzMapping:SpawnWeaponChalk(tr.HitPos + tr.HitNormal, ang, ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local chalkss = {
			["nz_weaponchalk"] = true,
			["nz_blankchalk"] = true,
		}

		if IsValid(tr.Entity) and chalkss[tr.Entity:GetClass()] then
			tr.Entity:Remove()
			return
		end

		local ang = tr.HitNormal:Angle()
		nzMapping:SpawnBlankChalk(tr.HitPos, Angle(ang[1],ang[2],0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent.ToggleRotate then
			ent:ToggleRotate()
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Chalk Wallbuy Placer",
	desc = "LMB: Place Weapon Wallbuy Chalk, RMB: Place Blank Chalk, Reload: Rotate Weapon Chalk",
	icon = "icon16/cursor.png",
	weight = 19,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.class)
		valz["Row2"] = tonumber(data.price)
		valz["Row3"] = tobool(data.nochalk)
		valz["Row4"] = tostring(data.icon)
		valz["Row5"] = tonumber(data.points)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.class = tostring(valz["Row1"])
			data.price = tonumber(valz["Row2"])
			data.nochalk = tobool(valz["Row3"])
			data.icon = tostring(valz["Row4"])
			data.points = tonumber(valz["Row5"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "chalks")
		end

		local Row1 = DProperties:CreateRow("Weapon Chalk Options", "Select Weapon")
		local Row5 = DProperties:CreateRow("Weapon Chalk Options", "Weapon Class")
		local Row2 = DProperties:CreateRow("Weapon Chalk Options", "Price")
		local Row6 = DProperties:CreateRow("Weapon Chalk Options", "Point reward")
		local Row4 = DProperties:CreateRow("Weapon Chalk Options", "HUD Icon")
		local Row3 = DProperties:CreateRow("Blank Chalk Options", "NoChalk on wallbuy")

		Row1:Setup("Combo")
		for _, SWEP in pairs(weapons.GetList()) do 
			if SWEP.PrintName and SWEP.PrintName != "" and !nzConfig.WeaponBlackList[SWEP.ClassName] and SWEP.PrintName != "Scripted Weapon" and !SWEP.NZPreventBox and !SWEP.NZTotalBlacklist then
				Row1:AddChoice((SWEP.Category and SWEP.Category != "") and SWEP.Category.." - "..SWEP.PrintName or SWEP.ClassName, SWEP.ClassName, selected1 == SWEP.ClassName)
			end
		end
		Row1.DataChanged = function( _, val ) selected1 = val valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) Row5:SetValue(valz["Row1"]) end
		Row1:SetToolTip("Select what weapon you would like to place down.")

		Row5:Setup("Generic")
		Row5:SetValue(valz["Row1"])
		Row5.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("use this instead of scrolling through the list.")

		Row2:Setup("Int", { min = 0, max = 30000 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		Row6:Setup("Int", { min = 0, max = 1000 })
		Row6:SetValue(valz["Row5"])
		Row6.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end

		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("When chalk is drawn, the wallbuy spawned will use the NoChalk setting.")

		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("If no valid image is provided, defaults to 'vgui/icon/zom_hud_icon_buildable_weap_chalk.png'")

		return DProperties
	end,

	defaultdata = {
		class = "tfa_bo3_raygun",
		price = 500,
		points = 1000,
		nochalk = false,
		icon = "vgui/icon/zom_hud_icon_buildable_weap_chalk.png",
	},
})

if SERVER then
	nzMapping:AddSaveModule("WeaponChalksSpawns", {
		savefunc = function()
			local chalks_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_weaponchalk")) do
				table.insert(chalks_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						class = v:GetWepClass(),
						price = v:GetPrice(),
						flipped = v:GetFlipped(),
						icon = v:GetHudIcon(),
						points = v:GetPoints(),
					}
				})
			end

			return chalks_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnWeaponChalk(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_weaponchalk"}
	})
	nzMapping:AddSaveModule("BlankChalksSpawn", {
		savefunc = function()
			local blankchalk_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_blankchalk")) do
				table.insert(blankchalk_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						nochalk = v:GetNoChalk(),
					}
				})
			end

			return blankchalk_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnBlankChalk(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_blankchalk"}
	})

	hook.Add("OnRoundInit", "NZ.Chalks.Reset", function()
		nzChalks:Reset()
	end)

	hook.Add("OnRoundEnd", "NZ.Chalks.Reset", function()
		if nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
			nzChalks:Reset()
		end
	end)

	hook.Add("EntityRemoved", "NZ.Chalks.Fix", function(ply)
		if ply:IsPlayer() and nzRound:InProgress() then
			nzChalks:TakePlayerChalk(ply, true)
		end
	end)
end
