nzTools:CreateTool("radio", {
	displayname = "Radio Placer",
	desc = "LMB: Place Radio, RMB: Remove Radio",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_radio" and data then
			if data.sound and file.Exists("sound/"..data.sound, "GAME") then
				ent:SetRadio(Sound(data.sound))
			else
				ent:SetRadio(Sound("ambient/levels/launch/rockettakeoffblast.wav"))
			end
			if data.door then
				ent:SetDoor(tobool(data.door))
			end
			if data.flag then
				ent:SetFlag(tostring(data.flag))
			end
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.nomodel then
				ent:SetNoModel(tobool(data.nomodel))
			elseif ent:GetNoModel() then
				ent:SetNoModel(!ent:GetNoModel())
			end
			ent:DrawShadow(!ent:GetNoModel())
			return
		end

		nzMapping:Radio(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)+Angle(0,-90,0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_radio" then
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
	displayname = "Radio Placer",
	desc = "LMB: Place Radio, RMB: Remove Radio",
	icon = "icon16/drive.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.sound)
		valz["Row2"] = tobool(data.door)
		valz["Row3"] = tostring(data.flag)
		valz["Row4"] = tostring(data.model)
		valz["Row5"] = tobool(data.nomodel)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.sound = tostring(valz["Row1"])
			data.door = tobool(valz["Row2"])
			data.flag = tostring(valz["Row3"])
			data.model = tostring(valz["Row4"])
			data.nomodel = tobool(valz["Row5"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "radio")
		end

		local Row1 = DProperties:CreateRow("Options", "Sound path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Path to the desired sound file. Be sure to properly setup the file for use with 44100 sample rate.")

		local Row2 = DProperties:CreateRow("Door", "Play sound on door opened")
		Row2:Setup("Boolean")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Sound will be played when a specific door is opened.")

		local Row3 = DProperties:CreateRow("Door", "Flag")
		Row3:Setup("Generic")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row4 = DProperties:CreateRow("Model", "Model path")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row5 = DProperties:CreateRow("Model", "Hide model")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Disables the ability to interact with the radio.")

		return DProperties
	end,

	defaultdata = {
		sound = "ambient/levels/launch/rockettakeoffblast.wav",
		door = false,
		flag = "",
		model = "models/nzr/song_ee/army_radio.mdl",
		nomodel = false,
	},
})

if SERVER then
	nzMapping:AddSaveModule("RadioSpawns", {
		savefunc = function()
			//the following is brought to you by being minorly inconvenienced
			local name = nzMapping.CurrentConfig
			local configname
			if name and name != "" then
				configname = "nz_" .. game.GetMap() .. ";" .. name .. ".txt"
			else
				configname = "nz_" .. game.GetMap() .. ";" .. os.date("%H_%M_%j") .. ".txt"
			end

			local cuntdata
			local filepath = "nz/"..configname
			local location = "DATA"
			if string.GetExtensionFromFilename(name) == "lua" then
				if file.Exists("gamemodes/nzombies/officialconfigs/"..name, "GAME") then
					location, filepath = "GAME", "gamemodes/nzombies/officialconfigs/"..name
				else
					location = "LUA"
				end
			end

			if file.Exists( filepath, location ) then
				local data = util.JSONToTable( file.Read( filepath, location ) )
				if data["RadioSpawns"] then
					cuntdata = data["RadioSpawns"]
				end
			end

			local radio_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_radio")) do
				if cuntdata then
					for _, fuck in pairs(cuntdata) do
						if fuck.sound and fuck.pos and fuck.pos:DistToSqr(v:GetPos()) <= 2 then
							local labymoment = fuck.sound
							break
						end
					end
				end

				table.insert(radio_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						sound = labymoment or v:GetRadio(),
						door = v:GetDoor(),
						flag = v:GetFlag(),
						model = v:GetModel(),
						nomodel = v:GetNoModel(),
					}
				})
			end

			return radio_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:Radio(v.pos, v.angle , v.tab, nil, v.sound)
			end
		end,
		cleanents = {"nz_radio"}
	})

	hook.Add("OnDoorUnlocked", "NZ.StartRadio", function(ent, link, rebuyable, ply)
		for k, v in pairs(ents.FindByClass("nz_radio")) do
			if v:GetDoor() and v:GetFlag() == tostring(link) then
				v:Play()
			end
		end
	end)

	hook.Add("OnRoundEnd", "NZ.ResetRadios", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_radio")) do
				v:Reset()
			end
		end
	end)

	hook.Add("OnRoundInit", "NZ.ResetRadios", function()
		for k, v in pairs(ents.FindByClass("nz_radio")) do
			v:Reset()
		end
	end)
end