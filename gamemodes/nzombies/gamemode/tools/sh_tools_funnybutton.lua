local colorselect = 1
local customcolor = Color(255, 0, 0, 255)
local nextmsg = 0

nzTools:CreateTool("funnybutton", {
	displayname = "Button Placer",
	desc = "LMB: Place/Update Button, RMB: Remove Button",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_funnybutton" and data then
			if data.door then
				ent:SetDoorFlag(tostring(data.door))
			end
			if data.price then
				ent:SetPrice(tonumber(data.price))
			end
			if data.elec ~= nil then
				ent.Elec = tobool(data.elec)
				ent:SetElectric(tobool(data.elec))
			end
			if data.glow ~= nil then
				ent:SetGlow(tobool(data.glow))
			end
			if data.sound and file.Exists("sound/"..data.sound, "GAME") then
				ent.ActivateSound = Sound(data.sound)
			end
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.timed ~= nil then
				ent:SetTimed(tobool(data.timed))
			end
			if data.time then
				ent:SetTimeLimit(tonumber(data.time))
			end
			if data.glowcolor ~= nil then
				ent:SetGlowColor(data.glowcolor)
			else
				ent:SetGlowColor(Vector(1,0,0))
			end
			local pickuptext = data.text
			if pickuptext then
				pickuptext = string.sub(tostring(pickuptext), 1, 48)
				if pickuptext == "" then pickuptext = "Activate" end

				ent:SetPickupHint(pickuptext)
			else
				ent:SetPickupHint("Activate")
			end
			local doortext = data.doortext
			if doortext then
				ent.DoorOpenText = tostring(doortext)
			else
				ent.DoorOpenText = "A door somewhere has opened..."
			end
			return
		end

		local ang = tr.HitNormal:Angle()
		nzMapping:SpawnFunnyButton(tr.HitPos, Angle(ang[1],ang[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_funnybutton" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ply) and IsValid(ent) and ent:GetClass() == "nz_funnybutton" then
			if ply:KeyDown(IN_USE) then
				local selected = data.colselect or 0
				if selected ~= 1 then return end

				local color = data.glowcolor
				local colorbox, coloreye
				if ply:KeyDown(IN_SPEED) then
					colorselect = colorselect - 1
					if colorselect < 1 then
						colorselect = 3
					end
				else
					colorselect = colorselect + 1
					if colorselect > 3 then
						colorselect = 1
					end
				end

				if colorselect == 3 then
					if IsValid(ply) then
						ply:ChatPrint("Box light color selected.")
					end
					local box = nzMapping.Settings.boxlightcolor
					if box and IsColor(box) then
						colorbox = Vector(box.r/255, box.g/255, box.b/255)
					end
					color = colorbox or color
				elseif colorselect == 2 then
					if IsValid(ply) then
						ply:ChatPrint("Zombie eye color selected.")
					end
					local eye = nzMapping.Settings.zombieeyecolor
					if eye and IsColor(eye) then
						coloreye = Vector(eye.r/255, eye.g/255, eye.b/255)
					end
					color = coloreye or color
				elseif colorselect == 1 then
					if IsValid(ply) then
						ply:ChatPrint("Custom color selected.")
					end
				end

				ent:SetGlowColor(color)
			else
				if ply:KeyDown(IN_SPEED) then
					local ang = ent:GetAngles()
					ang:RotateAroundAxis(ent:GetForward(), ply:KeyDown(IN_DUCK) and 5 or 45)
					ent:SetAngles(ang)
				else
					local ang = ent:GetAngles()
					ang:RotateAroundAxis(ent:GetForward(), ply:KeyDown(IN_DUCK) and -5 or -45)
					ent:SetAngles(ang)
				end
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Button Placer",
	desc = "LMB: Place/Update Button, RMB: Remove Button",
	icon = "icon16/add.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.door)
		valz["Row2"] = tonumber(data.price)
		valz["Row3"] = tobool(data.elec)
		valz["Row4"] = tobool(data.glow)
		valz["Row6"] = tostring(data.sound)
		valz["Row7"] = tostring(data.model)
		valz["Row8"] = tobool(data.timed)
		valz["Row9"] = tonumber(data.time)
		valz["Row10"] = tostring(data.text)
		valz["Row11"] = data.glowcolor or Vector(1, 0, 0)
		valz["Row12"] = tobool(data.hide)
		valz["Row13"] = tostring(data.doortext)
		valz["Row14"] = tostring(data.completetext)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.door = tostring(valz["Row1"])
			data.price = tonumber(valz["Row2"])
			data.elec = tobool(valz["Row3"])
			data.glow = tobool(valz["Row4"])
			data.sound = tostring(valz["Row6"])
			data.model = tostring(valz["Row7"])
			data.timed = tobool(valz["Row8"])
			data.time = tonumber(valz["Row9"])
			data.text = tostring(valz["Row10"])
			data.glowcolor = valz["Row11"]
			data.hide = tobool(valz["Row12"])
			data.doortext = tostring(valz["Row13"])
			data.completetext = tostring(valz["Row14"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "funnybutton")
		end

		local Row1 = DProperties:CreateRow("Options", "Door flag")
		local Row2 = DProperties:CreateRow("Options", "Price")
		local Row3 = DProperties:CreateRow("Options", "Require electricity")
		local Row8 = DProperties:CreateRow("Options", "Timed activation")
		local Row9 = DProperties:CreateRow("Options", "Time")
		local Row10 = DProperties:CreateRow("Options", "Interact hint text")
		local Row12 = DProperties:CreateRow("Options", "Hide after use")
		local Row13 = DProperties:CreateRow("Options", "Door Open Chat Message")
		local Row14 = DProperties:CreateRow("Options", "Buttons Pressed Chat Message")

		local Row4 = DProperties:CreateRow("Glow", "Enable glow")
		local Row11 = DProperties:CreateRow("Glow", "Glow Color")

		local Row6 = DProperties:CreateRow("Sound", "Activate sound")
		local Row7 = DProperties:CreateRow("Model", "Model path")

		local colorChoose = vgui.Create("DColorMixer", DProperties)

		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Required.")

		Row2:Setup("Int", { min = 0, max = 30000 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("SET TO 0 TO DISSABLE.")

		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Button cannot be activated until power is on.")

		Row8:Setup("Boolean")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetToolTip("Enable time limit requirement, if time runs out all buttons reset.")

		Row9:Setup("Int", { min = 1, max = 600 })
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row9:SetToolTip("Time given to activate all the buttons.")

		Row10:Setup("Generic")
		Row10:SetValue(valz["Row10"])
		Row10.DataChanged = function( _, val ) valz["Row10"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row10:SetToolTip("Limited to 48 characters. Always begins with 'Press (USE) - '")

		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Enable glow, idea taken from Project Viking.")

		Row11:Setup("Combo")
		Row11:AddChoice("Custom (Default)", 1, colorselect == 1)
		Row11:AddChoice("Zombie Eye Glow Color", 2, colorselect == 2)
		Row11:AddChoice("Box Light Color", 3, colorselect == 3)
		Row11.DataChanged = function( _, val )
			local color = colorChoose:GetVector()
			colorselect = val //client
			data.colselect = val //server

			if val == 3 then
				local mc = nzMapping.Settings.boxlightcolor
				if mc and IsColor(mc) then
					color = Vector(mc.r/255, mc.g/255, mc.b/255)
				end
			elseif val == 2 then
				local mc = nzMapping.Settings.zombieeyecolor
				if mc and IsColor(mc) then
					color = Vector(mc.r/255, mc.g/255, mc.b/255)
				end
			end

			valz["Row11"] = color
			DProperties.UpdateData(DProperties.CompileData())
		end

		Row12:Setup("Boolean")
		Row12:SetValue(valz["Row12"])
		Row12.DataChanged = function( _, val ) valz["Row12"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row12:SetToolTip("Button vanishes after use.")

		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Defaults to 'zmb/tomb/robot/button.wav'")

		Row7:Setup("Generic")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Defaults to 'models/zmb/bo2/highrise/p6_zm_hr_key_console.mdl'")

		Row13:Setup("Generic")
		Row13:SetValue(valz["Row13"])
		Row13.DataChanged = function( _, val ) valz["Row13"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row13:SetToolTip("A door somewhere has opened...")

		Row14:Setup("Generic")
		Row14:SetValue(valz["Row14"])
		Row14.DataChanged = function( _, val ) valz["Row14"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row14:SetToolTip("All buttons pressed!")

		local color_red = Color(150, 50, 50)

		local Butn = DProperties:Add("DButton")
		Butn:SetText( "print assets to console" )
		Butn:SetPos(80, 420)
		Butn:SetSize(120, 30)
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("zmb/tomb/robot/button.wav")
			print("zmb/moon/comp_activate.wav")
			print("-------------------------------------------")
			print("models/zmb/bo2/highrise/p6_zm_hr_key_console.mdl")
			print("models/zmb/bo3/tomb/p7_zm_ori_button_alarm.mdl")
			print("-------------------------------------------")
		end

		colorChoose:SetColor(customcolor)
		colorChoose:SetPalette(false)
		colorChoose:SetAlphaBar(false)
		colorChoose:SetSize(220, 105)
		colorChoose:SetPos(260, 360)

		colorChoose.ValueChanged = function(col)
			customcolor = colorChoose:GetColor()
			if colorselect == 1 then
				valz["Row11"] = colorChoose:GetVector()
				DProperties.UpdateData(DProperties.CompileData())
			end
		end

		return DProperties
	end,

	defaultdata = {
		door = "nil",
		price = 0,
		elec = false,
		glow = true,
		sound = "zmb/moon/comp_activate.wav",
		model = "models/zmb/bo2/highrise/p6_zm_hr_key_console.mdl",
		timed = false,
		time = 30,
		text = "Activate",
		glowcolor = Vector(1,0,0),
		colselect = 1,
		hide = false,
		doortext = "A door somewhere has opened...",
		completetext = "All buttons pressed!"
	},
})

if SERVER then
	nzMapping:AddSaveModule("FunnyButtonSpawns", {
		savefunc = function()
			local button_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_funnybutton")) do
				table.insert(button_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						door = v:GetDoorFlag(),
						price = v:GetPrice(),
						elec = v:GetElectric(),
						glow = v:GetGlow(),
						sound = v.ActivateSound,
						model = v:GetModel(),
						timed = v:GetTimed(),
						time = v:GetTimeLimit(),
						text = v:GetPickupHint(),
						glowcolor = v:GetGlowColor(),
						hide = v:GetHideOnUse(),
						doortext = v.DoorOpenText,
						compeltetext = v.CompletedText,
					}
				})
			end

			return button_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnFunnyButton(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_funnybutton"}
	})

	hook.Add("OnRoundEnd", "NZ.Reset.Button", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_funnybutton")) do
				v:Reset()
			end
		end

		for i=1, player.GetCount() do
			local ply = Entity(i)
			if not IsValid(ply) or not ply:IsPlayer() then continue end
			if ply:GetNW2String("nzButonFlag", "") ~= "" then
				ply:SetNW2String("nzButonFlag", nil)
			end
		end
	end)
end

if CLIENT then
	local color_red = Color(220, 0, 0, 255)
	hook.Add("PreDrawHalos", "NZ.Button.Halo", function()
		local ply = LocalPlayer()
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_funnybutton" and tr.StartPos:DistToSqr(tr.HitPos) < 10000 and ent:GetGlow() and !ent:GetUsed() then
			if !nzRound:InState(ROUND_CREATE) and ent:GetElectric() and not nzElec:IsOn() then return end
			if ent:GetTimed() and ply:GetNW2String("nzButonFlag", "") ~= "" and ply:GetNW2String("nzButonFlag", "") ~= ent:GetDoorFlag() then return end
			local color = ent:GetGlowColor()
			halo.Add({[1] = ent}, Color(color[1]*255, color[2]*255, color[3]*255, 255), 2, 2, 1, true, false) //bad
		end
	end)
end
