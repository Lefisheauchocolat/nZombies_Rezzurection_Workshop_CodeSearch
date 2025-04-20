local colorselect = 1
local customcolor = Color(255, 240, 150, 255)

nzTools:CreateTool("locker", {
	displayname = "Lock & Key Placer",
	desc = "LMB: Place Key Spawn, RMB: Lock Entity",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and data then
			if ent:GetClass() == "nz_keyspawn" then
				if data.keysound and file.Exists("sound/"..data.keysound, "GAME") then
					ent.ActivateSound = Sound(data.keysound)
				else
					ent.ActivateSound = Sound("zmb/alcatraz/master_key_pickup_lng.wav")
				end
				if data.keymodel and util.IsValidModel(data.keymodel) then
					ent:SetModel(tostring(data.keymodel))
				end
				if data.consume ~= nil then
					ent:SetSingleUse(tobool(data.consume))
				end
				if data.flag and data.flag ~= "" then
					ent:SetFlag(tostring(data.flag))
				else
					ent:SetFlag("")
				end
				if data.keytext ~= nil then
					local pickuptext = string.sub(tostring(data.keytext), 1, 48)
					if pickuptext == "" then pickuptext = "Pickup key" end

					ent:SetPickupHint(pickuptext)
				else
					ent:SetPickupHint("Pickup key")
				end
				if data.keyicon and file.Exists("materials/"..data.keyicon, "GAME") then
					ent:SetHudIcon(tostring(data.keyicon))
				else
					ent:SetHudIcon("vgui/icon/zom_hud_icon_key.png")
				end
				return
			elseif ent:GetClass() == "nz_locker" then
				if data.time then
					ent:SetTime(tonumber(data.time))
				end
				if data.price then
					ent:SetPrice(tonumber(data.price))
				end
				/*if data.door then
					ent:SetDoorFlag(tostring(data.door))
				end*/
				if data.lockflag and data.lockflag ~= "" then
					ent:SetFlag(tostring(data.lockflag))
				else
					ent:SetFlag("")
				end
				if data.elec then
					ent.Elec = tobool(data.elec)
					ent:SetElectric(tobool(data.elec))
				end
				if data.sound and file.Exists("sound/"..data.sound, "GAME") then
					ent.ActivateSound = Sound(data.sound)
				else
					ent.ActivateSound = Sound("zmb/alcatraz/master_key_open.wav")
				end
				if data.model and util.IsValidModel(data.model) then
					ent:SetModel(tostring(data.model))
				end
				if data.text ~= nil then
					local pickuptext = string.sub(tostring(data.text), 1, 48)
					if pickuptext == "" then pickuptext = "Unlock" end

					ent:SetPickupHint(pickuptext)
				else
					ent:SetPickupHint("Unlock")
				end
				if data.dofx ~= nil then
					ent.DoCustomEffects = tobool(data.dofx)
				else
					ent.DoCustomEffects = true
				end
				return
			end
		end

		nzMapping:SpawnKeySpawn(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local entclass = {
			["nz_keyspawn"] = true,
			["nz_locker"] = true,
		}

		local ent = tr.Entity
		if not IsValid(ent) then return end

		if entclass[ent:GetClass()] then
			ent:Remove()
			return
		end

		local door = ent:GetDoorData()
		if door and door.link then
			data.door = tostring(door.link)
		else
			data.door = ""
		end
		data.class = ent:GetClass()

		nzMapping:SpawnLocker(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_keyspawn" then
			if ply:KeyDown(IN_SPEED) then
				ent:SetAngles(ent:GetAngles() - Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			else
				ent:SetAngles(ent:GetAngles() + Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			end
			return
		end
		if IsValid(ent) and ent:GetClass() == "nz_locker" then
			if ent.NextUse and ent.NextUse > CurTime() then return end
			ent.NextUse = CurTime() + 0.1

			if ent:GetLockerClass() ~= "" then
				local failed = ent:TestLock(ply)
				if failed then return end
			end

			if ent.DoCustomEffects then
				ent:DoFX()
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Lock & Key Placer",
	desc = "LMB: Place Key Spawn, RMB: Lock Entity",
	icon = "icon16/key.png",
	weight = 19,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.time)
		valz["Row2"] = tonumber(data.price)
		//valz["Row3"] = tostring(data.door)
		valz["Row4"] = tobool(data.elec)
		valz["Row5"] = tostring(data.sound)
		valz["Row6"] = tostring(data.model)
		valz["Row7"] = tostring(data.text)
		valz["Row8"] = tobool(data.consume)
		valz["Row9"] = tostring(data.keysound)
		valz["Row10"] = tostring(data.keymodel)
		valz["Row11"] = tostring(data.keytext)
		valz["Row12"] = tobool(data.dofx)
		valz["Row13"] = tostring(data.keyicon)
		valz["Row14"] = data.glowcolor or Vector(255/255, 240/255, 150/255)
		valz["Row15"] = tostring(data.flag)
		valz["Row16"] = tostring(data.lockflag)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.time = tonumber(valz["Row1"])
			data.price = tonumber(valz["Row2"])
			//data.door = tostring(valz["Row3"])
			data.elec = tonumber(valz["Row4"])
			data.sound = tostring(valz["Row5"])
			data.model = tostring(valz["Row6"])
			data.text = tostring(valz["Row7"])
			data.consume = tobool(valz["Row8"])
			data.keysound = tostring(valz["Row9"])
			data.keymodel = tostring(valz["Row10"])
			data.keytext = tostring(valz["Row11"])
			data.dofx = tobool(valz["Row12"])
			data.keyicon = tostring(valz["Row13"])
			data.glowcolor = valz["Row14"]
			data.flag = tostring(valz["Row15"])
			data.lockflag = tostring(valz["Row16"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "locker")
		end

		local Row16 = DProperties:CreateRow("Lock Options", "Key Flag")
		local Row12 = DProperties:CreateRow("Lock Options", "Unlock FX")
		local Row1 = DProperties:CreateRow("Lock Options", "Unlock time")
		local Row2 = DProperties:CreateRow("Lock Options", "Price")
		local Row4 = DProperties:CreateRow("Lock Options", "Require electricity")
		local Row7 = DProperties:CreateRow("Lock Options", "Interact hint text")
		local Row5 = DProperties:CreateRow("Lock Options", "Unlock sound")
		local Row6 = DProperties:CreateRow("Lock Options", "Model path")

		local Row8 = DProperties:CreateRow("Global Options", "Consume after use")

		local Row15 = DProperties:CreateRow("Key Options", "Flag")
		local Row11 = DProperties:CreateRow("Key Options", "Interact hint text")
		local Row9 = DProperties:CreateRow("Key Options", "Pickup sound")
		local Row10 = DProperties:CreateRow("Key Options", "Model path")
		local Row13 = DProperties:CreateRow("Key Options", "HUD Icon path")
		local Row14 = DProperties:CreateRow("Key Options", "Glow Color")

		local colorChoose = vgui.Create("DColorMixer", DProperties)

		Row16:Setup("Generic")
		Row16:SetValue(valz["Row16"])
		Row16.DataChanged = function( _, val ) valz["Row16"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row16:SetToolTip("For if the lock requires a specific key with a set flag to be unlocked.")

		Row12:Setup("Boolean")
		Row12:SetValue(valz["Row12"])
		Row12.DataChanged = function( _, val ) valz["Row12"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row12:SetToolTip("Enable spark FX and lock popping off when used.")

		Row1:Setup("Int", { min = 0, max = 300 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("SET TO 0 TO DISSABLE, if set to 0 use time is insant.")

		Row2:Setup("Int", { min = 0, max = 30000 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("SET TO 0 TO DISSABLE.")

		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Require electricity activated to unlock.")

		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("If no sound is provided, defaults to 'zmb/alcatraz/master_key_open.wav'")

		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("If no model is provided, defaults to 'models/zmb/bo2/alcatraz/zm_al_magic_box_lock.mdl'")

		Row7:Setup("Generic")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Limited to 48 characters. Always begins with 'Press (USE) - '")

		Row8:Setup("Boolean")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val local data = DProperties.CompileData() DProperties.UpdateData(data) nzTools:UpdateKeySpawns(tobool(data.consume)) end
		Row8:SetToolTip("Key is consumed after use, will respawn at another key spawn that hasn't been consumed.")

		Row9:Setup("Generic")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row9:SetToolTip("If no valid sound is provided, defaults to 'zmb/alcatraz/master_key_pickup_lng.wav'")

		Row10:Setup("Generic")
		Row10:SetValue(valz["Row10"])
		Row10.DataChanged = function( _, val ) valz["Row10"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row10:SetToolTip("If no valid model is provided, defaults to 'models/zmb/bo2/alcatraz/zm_al_key.mdl'")

		Row13:Setup("Generic")
		Row13:SetValue(valz["Row13"])
		Row13.DataChanged = function( _, val ) valz["Row13"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row13:SetToolTip("If no valid image is provided, defaults to 'vgui/icon/zom_hud_icon_key.png'")

		Row11:Setup("Generic")
		Row11:SetValue(valz["Row11"])
		Row11.DataChanged = function( _, val ) valz["Row11"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row11:SetToolTip("Limited to 48 characters. Always begins with 'Press (USE) - '")

		Row15:Setup("Generic")
		Row15:SetValue(valz["Row15"])
		Row15.DataChanged = function( _, val ) valz["Row15"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row15:SetToolTip("For if this key should correspond to a certain lock entity.")

		Row14:Setup("Combo")
		Row14:AddChoice("None", 0, colorselect == 0)
		Row14:AddChoice("Custom (Default)", 1, colorselect == 1)
		Row14:AddChoice("Zombie Eye Glow Color", 2, colorselect == 2)
		Row14:AddChoice("Box Light Color", 3, colorselect == 3)
		Row14.DataChanged = function( _, val )
			local color = colorChoose:GetVector()
			colorselect = val //client

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
			elseif val == 0 then
				color = vector_origin
			end

			valz["Row14"] = color
			DProperties.UpdateData(DProperties.CompileData())
		end

		local color_red = Color(150, 50, 50)

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("Right click an entity to attach a Lock to it")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(10, 375)

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("Locked entities cannot be interacted with")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(10, 395)

		local textw3 = vgui.Create("DLabel", DProperties)
		textw3:SetText("LOCK MUST BE TOUCHING THE ENTITY")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor(color_red)
		textw3:SizeToContents()
		textw3:SetPos(10, 415)

		local textw5 = vgui.Create("DLabel", DProperties)
		textw5:SetText("Press ["..string.upper(input.LookupBinding("+use")).."] on a Lock to test it")
		textw5:SetFont("Trebuchet18")
		textw5:SetTextColor(color_red)
		textw5:SizeToContents()
		textw5:SetPos(10, 435)

		local Butn = DProperties:Add("DButton")
		Butn:SetText("print assets")
		Butn:SetPos(180, 435)
		Butn:SetSize(80, 30)
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("zmb/alcatraz/master_key_open.wav")
			print("zmb/alcatraz/master_key_pickup_lng.wav")
			print("-------------------------------------------")
			print("models/zmb/bo2/alcatraz/zm_al_magic_box_lock.mdl")
			print("models/zmb/bo2/alcatraz/zm_al_key.mdl")
			print("models/zmb/bo2/highrise/zm_hr_key.mdl")
			print("models/zmb/bo2/tranzit/zm_keycard.mdl")
			print("models/zmb/bo2/buried/zm_bu_sloth_key.mdl")
			print("-------------------------------------------")
			print("vgui/icon/t8_hud_key.png")
			print("vgui/icon/t8_hud_warden_key.png")
			print("vgui/icon/zom_hud_icon_key.png")
			print("vgui/icon/zom_hud_icon_epod_key.png")
			print("vgui/icon/zom_hud_icon_sq_keycard.png")
			print("vgui/icon/zom_hud_icon_sq_keycard_highrise.png")
			print("vgui/icon/zom_hud_icon_buildable_sloth_key.png")
			print("-------------------------------------------")
		end

		colorChoose:SetColor(customcolor)
		colorChoose:SetPalette(false)
		colorChoose:SetAlphaBar(false)
		colorChoose:SetSize(220, 95)
		colorChoose:SetPos(275, 375)

		colorChoose.ValueChanged = function(col)
			customcolor = colorChoose:GetColor()
			if colorselect == 1 then
				valz["Row14"] = colorChoose:GetVector()
				DProperties.UpdateData(DProperties.CompileData())
			end
		end

		return DProperties
	end,

	defaultdata = {
		time = 0,
		price = 0,
		door = "",
		elec = false,
		sound = "zmb/alcatraz/master_key_open.wav",
		model = "models/zmb/bo2/alcatraz/zm_al_magic_box_lock.mdl",
		text = "Unlock",
		consume = false,
		keysound = "zmb/alcatraz/master_key_pickup_lng.wav",
		keymodel = "models/zmb/bo2/alcatraz/zm_al_key.mdl",
		keytext = "Pickup key",
		dofx = true,
		keyicon = "vgui/icon/zom_hud_icon_key.png",
		glowcolor = Vector(255/255, 240/255, 150/255),
		flag = "",
		lockflag = "",
	},
})

if SERVER then
	nzMapping:AddSaveModule("LockerSpawns", {
		savefunc = function()
			local doorlock_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_locker")) do
				table.insert(doorlock_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						time = v:GetTime(),
						price = v:GetPrice(),
						door = v:GetDoorFlag(),
						elec = v:GetElectric(),
						sound = v.ActivateSound,
						model = v:GetModel(),
						text = v:GetPickupHint(),
						dofx = v.DoCustomEffects,
						class = v:GetLockerClass(),
						lockflag = v:GetFlag(),
					}
				})
			end

			return doorlock_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnLocker(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_locker"}
	})
	nzMapping:AddSaveModule("KeySpawns", {
		savefunc = function()
			local key_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_keyspawn")) do
				table.insert(key_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						consume = v:GetSingleUse(),
						keysound = v.ActivateSound,
						keymodel = v:GetModel(),
						keytext = v:GetPickupHint(),
						keyicon = v:GetHudIcon(),
						glowcolor = v:GetCustomGlow(),
						flag = v:GetFlag(),
					}
				})
			end

			return key_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnKeySpawn(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_keyspawn"}
	})

	hook.Add("OnRoundInit", "NZ.Locker.Start", function()
		nzLocker:ResetKeys()
		nzLocker:RespawnKey()
		nzLocker:LockLocks()
	end)

	hook.Add("OnRoundEnd", "NZ.Locker.Resett", function()
		if nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
			nzLocker:ResetKeys()
		end
	end)

	util.AddNetworkString("nzKeySpawnerUpdate")

	local function ReceiveData(len, ply)
		local bool = net.ReadBool()
		for k, v in pairs(ents.FindByClass("nz_keyspawn")) do
			v:SetSingleUse(bool)
		end
	end
	net.Receive("nzKeySpawnerUpdate", ReceiveData)
end

if CLIENT then
	function nzTools:UpdateKeySpawns(bool)
		net.Start("nzKeySpawnerUpdate")
			net.WriteBool(bool)
		net.SendToServer()
	end
end