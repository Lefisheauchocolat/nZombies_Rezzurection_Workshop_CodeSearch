nzTools:CreateTool("hacker_spawnpoint", {
	displayname = "Hacker Placer",
	desc = "LMB: Place Hacker Spawn, RMB: Place Hacker Button & Remove Hacker Spawn/Button",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_bo3_hackerbutton" and data then
			if data.price then
				ent:SetPrice(tonumber(data.price))
			end
			if data.time then
				ent:SetTime(tonumber(data.time))
			end
			if data.elec then
				ent:SetElectric(tobool(data.elec))
			elseif ent:GetElectric() then
				ent:SetElectric(false)
			end
			if data.flag then
				ent:SetFlag(tostring(data.flag))
			end
			if data.hide ~= nil then
				ent:SetDoHide(tobool(data.hide))
			end
			if data.revealdoor then
				ent:SetDoorFlag(tostring(data.revealdoor))
			end
			if data.glowsprite ~= nil then
				ent:SetDoSprite(tobool(data.glowsprite))
			end
			if data.glowcolor then
				ent:SetGlowColor(data.glowcolor)
			end
			return
		end

		nzMapping:HackerSpawner(tr.HitPos + tr.HitNormal, tr.HitNormal:Angle() + Angle(0,(tr.HitPos - ply:GetShootPos()):Angle()[2] - 180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local death = {
			["nz_bo3_hacker_spawn"] = true,
			["nz_bo3_hackerbutton"] = true
		}

		if IsValid(tr.Entity) and death[tr.Entity:GetClass()] then
			tr.Entity:Remove()
			return
		end

		local ang = tr.HitNormal:Angle()
		nzMapping:HackerButton(tr.HitPos + tr.HitNormal, Angle(ang[1],ang[2],0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Hacker Placer",
	desc = "LMB: Place Hacker Spawn, RMB: Place Hacker Button & Remove Hacker Spawn/Button",
	icon = "icon16/package.png",
	weight = 23,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tonumber(data.time)
		valz["Row3"] = tobool(data.elec)
		valz["Row4"] = tostring(data.flag)
		valz["Row5"] = tobool(data.hide)
		valz["Row6"] = tostring(data.revealdoor)
		valz["Row7"] = tobool(data.glowsprite)
		valz["Row8"] = data.glowcolor

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.time = tonumber(valz["Row2"])
			data.elec = tobool(valz["Row3"])
			data.flag = tostring(valz["Row4"])
			data.hide = tobool(valz["Row5"])
			data.revealdoor = tostring(valz["Row6"])
			data.glowsprite = tobool(valz["Row7"])
			data.glowcolor = valz["Row8"]

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "hacker_spawnpoint")
		end

		local Row1 = DProperties:CreateRow("Hacker Button Options", "Price")
		Row1:Setup("Int", { min = 0, max = 10000 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("SET TO 0 TO DISABLE.")

		local Row2 = DProperties:CreateRow("Hacker Button Options", "Hacking time")
		Row2:Setup("Float", { min = 0.1, max = 120 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Time required to hack the button. Default is 10 seconds")

		local Row3 = DProperties:CreateRow("Hacker Button Options", "Require electricity active")
		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Require electricity to be activated to hack the button.")

		local Row4 = DProperties:CreateRow("Hacker Button Options", "Door flag to open")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Door flag to open after hacking the button.")

		local Row5 = DProperties:CreateRow("Hacker Button Options", "Unusable until door opened")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Require a door being open to hack the button.")

		local Row6 = DProperties:CreateRow("Hacker Button Options", "Door flag to make usable")
		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Door flag to make the hacker button appear.")

		local Row7 = DProperties:CreateRow("Hacker Button Options", "Glow Sprite")
		Row7:Setup("Boolean")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Enable for a little sprite to show in the center of the hacker button bounds, does not show when activated.")

		local colorChoose = vgui.Create("DColorMixer", DProperties)
		colorChoose:SetColor(valz["Row8"]:ToColor())
		colorChoose:SetPalette(false)
		colorChoose:SetAlphaBar(false)
		colorChoose:SetSize(280, 160)
		colorChoose:SetPos(15, 175)

		colorChoose.ValueChanged = function(col)
			valz["Row8"] = colorChoose:GetVector()
			DProperties.UpdateData(DProperties.CompileData())
		end

		return DProperties
	end,

	defaultdata = {
		price = 0,
		time = 10,
		elec = false,
		flag = "",
		hide = false,
		revealdoor = "",
		glowsprite = false,
		glowcolor = Vector(1,0,0),
	},
})

if SERVER then
	nzMapping:AddSaveModule("HackerSpawns", {
		savefunc = function()
			local hacker_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_bo3_hacker_spawn")) do
				table.insert(hacker_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles()
				})
			end
		return hacker_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:HackerSpawner(v.pos, v.angle)
			end
		end,
		cleanents = {"nz_bo3_hacker_spawn"}
	})

	nzMapping:AddSaveModule("HackerButtons", {
		savefunc = function()
			local hacker_buttons = {}
			for k, v in pairs(ents.FindByClass("nz_bo3_hackerbutton")) do
				table.insert(hacker_buttons, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						price = v:GetPrice(),
						time = v:GetTime(),
						elec = v:GetElectric(),
						flag = v:GetFlag(),
						hide = v:GetDoHide(),
						revealdoor = v:GetDoorFlag(),
						glowsprite = v:GetDoSprite(),
						glowcolor = v:GetGlowColor(),
					}
				})
			end
		return hacker_buttons
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:HackerButton(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_bo3_hackerbutton"}
	})

	hook.Add("OnRoundInit", "NZ.Reset.HackerButtons", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.HackerHacks = nil
			ply.HackerDevicePAP = nil
		end

		for k, v in pairs(ents.FindByClass("nz_bo3_hackerbutton")) do
			v:SetActivated(false)
			if v:GetDoHide() then
				v:Hide()
			end
		end
	end)

	hook.Add("OnRoundEnd", "NZ.Reset.HackerButtons", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.HackerHacks = nil
			ply.HackerDevicePAP = nil
		end

		for k, v in pairs(ents.FindByClass("nz_bo3_hackerbutton")) do
			v:SetActivated(false)
			v:Reset()
		end
	end)

	hook.Add("OnDoorUnlocked", "NZ.Activate.HackerButtons", function(ent, link, _, ply)
		for k, v in pairs(ents.FindByClass("nz_bo3_hackerbutton")) do
			if v:GetDoHide() and v:GetNoDraw() and v:GetDoorFlag() == link then
				v:Reset()
			end
			if v:GetFlag() == link then
				v:SetActivated(true)
			end
		end
	end)
end