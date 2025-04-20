nzTools:CreateTool("jumppad", {
	displayname = "Jump Pad Placer",
	desc = "LMB: Place/Update Launch Pad, RMB: Place Landing Pad",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_launchpad" and data then
			if data.price then
				ent:SetPrice(tonumber(data.price))
			end
			if data.flag then
				ent:SetFlag(tonumber(data.flag))
			end
			if data.cooldown then
				ent:SetCooldown(math.max(tonumber(data.cooldown), 2))
			end
			if data.airtime then
				ent:SetAirTime(tonumber(data.airtime))
			end
			if data.elec ~= nil then
				ent.Elec = tobool(data.elec)
				ent:SetElectric(tobool(data.elec))
			end
			if data.req ~= nil then
				ent:SetRequireActive(tobool(data.req))
			end
			if data.model1 and util.IsValidModel(data.model1) then
				ent:SetModel(tostring(data.model1))
			end
			return
		end

		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_landingpad" and data then
			if data.flag then
				ent:SetFlag(tonumber(data.flag))
			end
			if data.req then
				ent:SetRequireActive(tobool(data.req))
			end
			if data.model2 and util.IsValidModel(data.model2) then
				ent:SetModel(tostring(data.model2))
			end
			return
		end

		nzMapping:SpawnLaunchPad(tr.HitPos + tr.HitNormal*10, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0) - Angle(0,90,0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local pads = {
			["nz_launchpad"] = true,
			["nz_landingpad"] = true
		}

		if IsValid(tr.Entity) and pads[tr.Entity:GetClass()] then
			tr.Entity:Remove()
			return
		end

		if data and data.flag then
			for k, v in pairs(ents.FindByClass("nz_landingpad")) do
				if v:GetFlag() == tonumber(data.flag) then return end
			end
		end

		nzMapping:SpawnLandingPad(tr.HitPos + tr.HitNormal*10, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0) - Angle(0,90,0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		local pads = {
			["nz_launchpad"] = true,
			["nz_landingpad"] = true
		}

		if IsValid(ent) and pads[ent:GetClass()] then
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
	displayname = "Jump Pad Placer",
	desc = "LMB: Place/Update Launch Pad, RMB: Place Landing Pad",
	icon = "icon16/joystick.png",
	weight = 21,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tonumber(data.flag)
		valz["Row3"] = tonumber(data.cooldown)
		valz["Row4"] = tonumber(data.airtime)
		valz["Row5"] = tobool(data.elec)
		valz["Row6"] = tobool(data.req)
		valz["Row7"] = tostring(data.model1)
		valz["Row8"] = tostring(data.model2)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.flag = tonumber(valz["Row2"])
			data.cooldown = tonumber(valz["Row3"])
			data.airtime = tonumber(valz["Row4"])
			data.elec = tobool(valz["Row5"])
			data.req = tobool(valz["Row6"])
			data.model1 = tostring(valz["Row7"])
			data.model2 = tostring(valz["Row8"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "jumppad")
		end

		local Row1 = DProperties:CreateRow("Options", "Price")
		local Row2 = DProperties:CreateRow("Options", "Flag")
		local Row3 = DProperties:CreateRow("Options", "Cooldown")
		local Row4 = DProperties:CreateRow("Options", "Launch Height")
		local Row5 = DProperties:CreateRow("Options", "Require Electricity")
		local Row6 = DProperties:CreateRow("Options", "Require Activating Landing Pad")
		local Row7 = DProperties:CreateRow("Model", "Launch Pad model path")
		local Row8 = DProperties:CreateRow("Model", "Landing Pad model path")

		local color_red = Color(150, 50, 50)

		Row1:Setup("Int", { min = 0, max = 30000 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		Row2:Setup("Int", { min = 0, max = 100 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Required to link the Launch Pad to Landing Pad, only 1 set of each perk Flag.")

		Row3:Setup("Int", { min = 2, max = 600 })
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end

		Row4:Setup("Float", { min = 0, max = 60 })
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Usually doesnt work if less than 1, accepts decimals. (also acts as air time)")

		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Require electricity to be active to use the Launch Pad.")

		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Require linked Landing Pad to be activated before Launch Pad can be used.")

		Row7:Setup("Generic")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("If no model is provided, defaults to Moon Launch Pad.")

		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetToolTip("If no model is provided, defaults to Moon Landing Pad.")

		local chekc = vgui.Create("DCheckBoxLabel", DProperties)
		chekc:SetPos(170, 215)
		chekc:SetText("Preview Launch Trajectories")
		chekc:SetTextColor(Color(50, 50, 50))
		chekc:SetConVar("nz_jumppad_preview")
		chekc:SetValue(GetConVar("nz_jumppad_preview"):GetBool())
		chekc:SizeToContents()

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("While standing on a Launch Pad")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(0, 240)
		textw:CenterHorizontal()

		local walkkey = input.LookupBinding("+WALK")
		local textw2 = vgui.Create("DLabel", DProperties)
		if walkkey and walkkey ~= "" then
			textw2:SetText("Hold ["..string.upper(walkkey).."] to test its trajectory")
		else
			textw2:SetText("Hold [!!! W A L K  K E Y  N O T  B O U N D !!!] to test its trajectory")
		end
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 260)
		textw2:CenterHorizontal()

		local textw3 = vgui.Create("DLabel", DProperties)
		textw3:SetText("This also shows you the max distance at which it will launch players")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor(color_red)
		textw3:SizeToContents()
		textw3:SetPos(0, 280)
		textw3:CenterHorizontal()

		local textw4 = vgui.Create("DLabel", DProperties)
		textw4:SetText("If the arc ever turns red, the player will hit the world")
		textw4:SetFont("Trebuchet18")
		textw4:SetTextColor(color_red)
		textw4:SizeToContents()
		textw4:SetPos(0, 300)
		textw4:CenterHorizontal()

		local textw5 = vgui.Create("DLabel", DProperties)
		textw5:SetText("When that happens, try adjusting the launch height or its position")
		textw5:SetFont("Trebuchet18")
		textw5:SetTextColor(color_red)
		textw5:SizeToContents()
		textw5:SetPos(0, 320)
		textw5:CenterHorizontal()

		return DProperties
	end,

	defaultdata = {
		price = 500,
		flag = 1,
		cooldown = 30,
		airtime = 2,
		elec = false,
		req = true,
		model1 = "models/zmb/bo1/moon/zom_moon_jump_pad.mdl",
		model2 = "models/zmb/bo1/moon/zom_moon_jump_pad_cushions.mdl",
	},
})

if SERVER then
	nzMapping:AddSaveModule("LaunchPadSpawns", {
		savefunc = function()
			local launch_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_launchpad")) do
				table.insert(launch_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						price = v:GetPrice(),
						flag = v:GetFlag(),
						cooldown = v:GetCooldown(),
						airtime = v:GetAirTime(),
						elec = v:GetElectric(),
						req = v:GetRequireActive(),
						model1 = v:GetModel(),
					}
				})
			end

			return launch_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnLaunchPad(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_launchpad"}
	})
	nzMapping:AddSaveModule("LandingPadSpawns", {
		savefunc = function()
			local landing_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_landingpad")) do
				table.insert(landing_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						flag = v:GetFlag(),
						model2 = v:GetModel(),
						req = v:GetRequireActive(),
					}
				})
			end

			return landing_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnLandingPad(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_landingpad"}
	})

	hook.Add("OnRoundEnd", "NZ.Reset.JumpPads", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_launchpad")) do
				v:Reset()
			end
		end
	end)
end

if CLIENT then
	if not ConVarExists("nz_jumppad_preview") then
		CreateClientConVar("nz_jumppad_preview", "1")
	end
end
