local selected1, selected2 = "tfa_bo3_raygun", 3

nzTools:CreateTool("weaponpickup", {
	displayname = "Weapon Pickup Placer",
	desc = "LMB: Place/Update Weapon Pickup, RMB: Remove Weapon Pickup",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_weaponpickup" and data then
			if data.class then
				local wep = weapons.Get(data.class)
				if wep then
					ent:SetGun(tostring(data.class))
					ent:SetModel(wep.WM or wep.WorldModel)
				end
			end
			if data.givetype then
				ent:SetGiveType(tonumber(data.givetype))
			end
			if data.addtobox ~= nil then
				ent:SetBoxWeapon(tobool(data.addtobox))
			end
			if data.weight then
				ent.WeaponWeight = math.Round(tonumber(data.weight))
			end
			if data.reqclass then
				ent:SetRequiredGun(tostring(data.reqclass))
			end
			if data.hide ~= nil then
				ent:SetDoHide(tobool(data.hide))
			end
			return
		end

		local size = 8
		local SpawnPos = tr.HitPos + tr.HitNormal * size

		-- Make sure the spawn position is not out of bounds
		local oobTr = util.TraceLine({
			start = tr.HitPos,
			endpos = SpawnPos,
			mask = MASK_SOLID_BRUSHONLY
		})

		if (oobTr.Hit) then
			SpawnPos = oobTr.HitPos + oobTr.HitNormal * (tr.HitPos:Distance(oobTr.HitPos)/2)
		end

		nzMapping:SpawnWeaponPickup(SpawnPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0) - Angle(0,90,0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_weaponpickup" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_weaponpickup" then
			if ply:KeyDown(IN_SPEED) then
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetUp(), ply:KeyDown(IN_DUCK) and -5 or -45)
				ent:SetAngles(ang)
			else
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetUp(), ply:KeyDown(IN_DUCK) and 5 or 45)
				ent:SetAngles(ang)
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Weapon Pickup Placer",
	desc = "LMB: Place/Update Weapon Pickup, RMB: Remove Weapon Pickup",
	icon = "icon16/heart.png",
	weight = 21,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.class)
		valz["Row2"] = tonumber(data.givetype)
		valz["Row3"] = tobool(data.addtobox)
		valz["Row4"] = tonumber(data.weight)
		valz["Row5"] = tostring(data.reqclass)
		valz["Row6"] = tostring(data.doorflag)
		valz["Row7"] = tobool(data.hide)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.class = tostring(valz["Row1"])
			data.givetype = tonumber(valz["Row2"])
			data.addtobox = tobool(valz["Row3"])
			data.weight = tonumber(valz["Row4"])
			data.reqclass = tostring(valz["Row5"])
			data.doorflag = tostring(valz["Row6"])
			data.hide = tobool(valz["Row7"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "weaponpickup")
		end

		local Row1 = DProperties:CreateRow("Options", "Select Weapon Class")
		local Row2 = DProperties:CreateRow("Options", "Class Name")
		local Row3 = DProperties:CreateRow("Options", "Weapon Give Type")
		local Row4 = DProperties:CreateRow("Random Box", "Add to 'Mystery Box' list on pickup")
		local Row5 = DProperties:CreateRow("Random Box", "'Mystery Box' Weapon Weight")
		local Row6 = DProperties:CreateRow("Restrictions", "Require specific held weapon to pickup")
		local Row7 = DProperties:CreateRow("Restrictions", "Require specific door open to pickup")
		local Row8 = DProperties:CreateRow("Restrictions", "Hide model until door opened")

		Row1:Setup("Combo")
		for _, SWEP in pairs(weapons.GetList()) do 
			if SWEP.PrintName and SWEP.PrintName != "" and !nzConfig.WeaponBlackList[SWEP.ClassName] and SWEP.PrintName != "Scripted Weapon" and !SWEP.NZPreventBox and !SWEP.NZTotalBlacklist then
				Row1:AddChoice((SWEP.Category and SWEP.Category != "") and SWEP.Category.." - "..SWEP.PrintName or SWEP.ClassName, SWEP.ClassName, selected1 == SWEP.ClassName)
			end
		end
		Row1.DataChanged = function( _, val ) selected1 = val valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) Row2:SetValue(valz["Row1"]) end
		Row1:SetToolTip("Select what weapon you would like to place down.")

		Row2:Setup("Generic")
		Row2:SetValue(valz["Row1"])
		Row2.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("use this instead of scrolling through the list.")

		Row3:Setup("Combo")
		Row3:SetValue(valz["Row2"])
		Row3:AddChoice("Single Use - removed after first pickup by anyone", 1, selected2 == 1)
		Row3:AddChoice("Single Use per Player - removed only for each client after first pickup", 2, selected2 == 2)
		Row3:AddChoice("Unlimited Use - weapon can be pickuped up infinintely", 3, selected2 == 3)
		Row3.DataChanged = function( _, val ) selected2 = val valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Select how weapon pickup acts after being used.")

		Row6:Setup("Generic")
		Row6:SetValue(valz["Row5"])
		Row6.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Weapon cannot be picked up unless the specified weapon is in the players hands. LEAVE EMPTY IF NOT USING!")

		Row7:Setup("Generic")
		Row7:SetValue(valz["Row6"])
		Row7.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Weapon cannot be picked up unless the specified door is open. LEAVE EMPTY IF NOT USING!")

		Row8:Setup("Boolean")
		Row8:SetValue(valz["Row7"])
		Row8.DataChanged = function( _, val ) valz["Row7"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetToolTip("Hide weapon model until required door is opened.")

		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row3"])
		Row4.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("If weapon is not in the 'Random Box' list, it will be added on pickup then removed after game end.")

		Row5:Setup("Int", { min = 1, max = 100 })
		Row5:SetValue(valz["Row4"])
		Row5.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,

	defaultdata = {
		class = "tfa_bo3_raygun",
		givetype = 3,
		addtobox = false,
		weight = 10,
		reqclass = "",
		doorflag = "",
		hide = false,
	},
})

if SERVER then
	nzMapping:AddSaveModule("WeaponPickupSpawns", {
		savefunc = function()
			local pickup_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_weaponpickup")) do
				table.insert(pickup_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						class = v:GetGun(),
						givetype = v:GetGiveType(),
						addtobox = v:GetBoxWeapon(),
						weight = v.WeaponWeight,
						reqclass = v:GetRequiredGun(),
						doorflag = v:GetDoorFlag(),
						hide = v:GetDoHide()
					}
				})
			end

			return pickup_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnWeaponPickup(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_weaponpickup"}
	})

	local doorpickups = {}

	hook.Add("OnDoorUnlocked", "NZ.WepPickup.Door", function(ent, link, rebuyable, ply)
		link = tostring(link)
		if doorpickups[link] then
			for k, v in pairs(doorpickups[link]) do
				if IsValid(v) then
					v:SetDoored(true)
				end
			end
		end
	end)

	hook.Add("OnRoundEnd", "NZ.WepPickup.Reset", function()
		if nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
			for k, v in pairs(ents.FindByClass("nz_weaponpickup")) do
				v:Reset()
				v:SetDoored(false)
			end
			doorpickups = {}
		end
	end)

	hook.Add("OnRoundInit", "NZ.WepPickup.Door", function()
		for k, v in pairs(ents.FindByClass("nz_weaponpickup")) do
			local flag = v.GetDoorFlag and v:GetDoorFlag() or ""
			if flag ~= "" then
				if not doorpickups[flag] then doorpickups[flag] = {} end
				table.insert(doorpickups[flag], v)
			end
			if v:GetDoHide() then
				v:SetNoDraw(true)
				v:SetSolid(SOLID_NONE)
			end
		end
	end)
end

if CLIENT then
	local color_wonderweapon = Color(0, 255, 255, 255)
	local colors = {
		["specialist"] = Color(255, 0, 0, 255),
		["trap"] = Color(255, 180, 20, 255),
		["specialgrenade"] = Color(0, 255, 0, 255)
	}

	hook.Add("PreDrawHalos", "NZ.WepPickup.Halo", function()
		local ply = LocalPlayer()
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_weaponpickup" and tr.StartPos:DistToSqr(tr.HitPos) < 10000 then
			if !ply:IsInCreative() then
				local door = ent:GetDoorFlag()
				if door ~= "" and not ent:GetDoored() then return end

				local class = ent:GetRequiredGun()
				if class ~= "" then
					local wep = ply:GetActiveWeapon()
					if IsValid(wep) and wep:GetClass() ~= class then return end
				end
			end

			local color = color_white

			local wep = weapons.Get(ent:GetGun())
			if wep.NZSpecialCategory and colors[wep.NZSpecialCategory] then
				color = colors[wep.NZSpecialCategory]
			end
			if wep.NZWonderWeapon or (!wep.NZSpecialCategory and wep.Category and wep.Category ~= "" and wep.Category == "TFA Wonder Weapons") then
				color = color_wonderweapon
			end
			if nzMapping.Settings.monochrome and !nzElec:IsOn() then
				color = color_white
			end

			halo.Add({[1] = ent}, color, 1, 1, 1, true, false)
		end
	end)
end
