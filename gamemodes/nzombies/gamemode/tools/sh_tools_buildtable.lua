local generator1 = 1
local function nextKey(class)
	local i = #nzBuilds:GetBuildParts(class)
	generator1 = generator1 + 1

	if generator1 > i then
		generator1 = 1
	end

	return generator1
end
local selected1 = "bo2_tranzitshield"
local selected2 = 0

nzTools:CreateTool("builds", {
	displayname = "Buildables Placer",
	desc = "LMB: Place Part, RMB: Place Table & Remove Part/Table, Reload: Cycle Selected Part",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:SpawnBuildPart(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local bclasses = {
			["nz_buildable"] = true,
			["nz_buildtable"] = true,
		}

		if IsValid(tr.Entity) and bclasses[tr.Entity:GetClass()] then
			tr.Entity:Remove()
			return
		end

		if data and data.class then
			for k, v in pairs(ents.FindByClass("nz_buildtable")) do
				if v:GetBuildable() == tostring(data.class) then return end
			end
		end

		nzMapping:SpawnBuildTable(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_buildtable" and IsValid(ent.CraftedModel) then
			if ply:KeyDown(IN_USE) then
				if ply:KeyDown(IN_SPEED) then
					ent.CraftedModel:SetAngles(ent.CraftedModel:GetAngles() - Angle(0,ply:KeyDown(IN_DUCK) and -5 or -45,0))
				else
					ent.CraftedModel:SetAngles(ent.CraftedModel:GetAngles() + Angle(0,ply:KeyDown(IN_DUCK) and -5 or -45,0))
				end
			else
				if ply:KeyDown(IN_SPEED) then
					ent:SetAngles(ent:GetAngles() - Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
				else
					ent:SetAngles(ent:GetAngles() + Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
				end
			end
			return
		end

		if not data then return end
		if not data.class then return end

		data.part = nextKey(data.class)

		if IsValid(ply) then
			local name = nzBuilds:GetBuildParts(data.class)[data.part].id
			ply:ChatPrint("Currently selected part - "..tostring(name))
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Buildables Placer",
	desc = "LMB: Place Part, RMB: Place Table & Remove Part/Table, Reload: Cycle Selected Part",
	icon = "icon16/chart_bar.png",
	weight = 22,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.class)
		valz["Row2"] = tonumber(data.price)
		valz["Row3"] = tonumber(data.style)
		valz["Row4"] = tonumber(data.weight)
		valz["Row5"] = tobool(data.oldsound)
		valz["Row6"] = tobool(data.notable) or false
		valz["Row7"] = tobool(data.collision) or false

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.class = tostring(valz["Row1"])
			data.price = tonumber(valz["Row2"])
			data.style = tonumber(valz["Row3"])
			data.weight = tonumber(valz["Row4"])
			data.oldsound = tobool(valz["Row5"])
			data.notable = tobool(valz["Row6"])
			data.collision = tobool(valz["Row7"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "builds")
		end

		local Row1 = DProperties:CreateRow("Table", "Buildable")
		Row1:Setup("Combo")
		for i, tab in pairs(nzBuilds.Data) do Row1:AddChoice(tab.name, i, i == selected1) end
		Row1.DataChanged = function( _, val ) selected1 = val valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Select Buildable to setup.")

		local Row2 = DProperties:CreateRow("Table", "Price")
		Row2:Setup("Int", { min = 0, max = 30000 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Price for Buildable, SET TO 0 TO DISSABLE!")

		local Row3 = DProperties:CreateRow("Table", "Table Style")
		Row3:Setup("Combo")
		Row3:AddChoice("Toolbox", 0, selected2 == 0)
		Row3:AddChoice("Empty", 1, selected2 == 1)
		Row3:AddChoice("Lamp", 2,  selected2 == 2)
		Row3:AddChoice("Chess", 3,  selected2 == 3)
		Row3.DataChanged = function( _, val ) selected2 = val valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Bodygroup for table to use")

		local Row6 = DProperties:CreateRow("Table", "No table model")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Hides the table model, just the buildable hologram will be used.")

		local Row7 = DProperties:CreateRow("Table", "Disable collision")
		Row7:Setup("Boolean")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Name.")

		local Row4 = DProperties:CreateRow("Buildable Specific", "'Mystery Box' Weapon Weight")
		Row4:Setup("Int", { min = 1, max = 100 })
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Buildables that give Wonder Weapons on pickup get added to the random box list, this is the weight it will use")

		local Row5 = DProperties:CreateRow("Misc", "Use Black Ops 2 Sound Effects")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Build Table will use Black Ops 2 sounds instead of Black Ops 4")

		local Row8 = DProperties:CreateRow("Misc", "Use Classic Inventory HUD")
		Row8:Setup("Boolean")
		Row8:SetValue(!nzBuilds.ModernInventory)
		Row8.DataChanged = function( _, val ) nzTools:UpdateBuildablesData({["modernhud"] = !nzBuilds.ModernInventory}) end
		Row8:SetToolTip("Enable for config to use classic build parts inventory HUD.")

		return DProperties
	end,
	defaultdata = {
		class = "bo2_tranzitshield",
		part = 1,
		price = 0,
		style = 0,
		weight = 10,
		oldsound = false,
		notable = false,
		collision = false,
	},
})

if SERVER then
	nzMapping:AddSaveModule("BuildTables", {
		savefunc = function()
			local build_tables = {}
			for k, v in pairs(ents.FindByClass("nz_buildtable")) do
				table.insert(build_tables, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						class = v:GetBuildable(),
						price = v:GetPrice(),
						style = v:GetBodygroup(0),
						weight = v.WeaponWeight,
						oldsound = v.ClassicSounds,
						notable = v.HideTableModel,
						collision = (v:GetCollisionGroup() == COLLISION_GROUP_WORLD),
					}
				})
			end

			return build_tables
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnBuildTable(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_buildtable", "nz_buildholo"}
	})
	nzMapping:AddSaveModule("BuildParts", {
		savefunc = function()
			local build_parts = {}
			for k, v in pairs(ents.FindByClass("nz_buildable")) do
				table.insert(build_parts, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						class = v:GetBuildable(),
						part = v:GetPartID(),
					}
				})
			end

			return build_parts
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnBuildPart(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_buildable"}
	})
	nzMapping:AddSaveModule("BuildablesSettings", {
		savefunc = function()
			local savedata = {
				modernhud = nzBuilds.ModernInventory,
			}
			return savedata
		end,
		loadfunc = function(data)
			nzBuilds:UpdateSettings(data)
		end,
	})
end

if SERVER then
	hook.Add("OnRoundInit", "NZ.Buildable.Start", function()
		for k, v in pairs(ents.FindByClass("nz_buildtable")) do
			v:ResetParts()
		end
	end)

	hook.Add("OnRoundEnd", "NZ.Buildable.Reset", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_buildable")) do
				v:Reset()
				v:SetActivated(true)
			end

			for k, v in pairs(ents.FindByClass("nz_buildtable")) do
				v:Reset()
			end

			nzBuilds:CleanHeldParts()
		end
	end)

	util.AddNetworkString("nzBuildsToolUpdate")

	local function ReceiveData(len, ply)
		local data = net.ReadTable()
		nzBuilds:UpdateSettings(data)
		if !data.modernhud then
			PrintMessage(HUD_PRINTTALK, "[NZ] Enabled classic buildables inventory style")
		end
	end
	net.Receive("nzBuildsToolUpdate", ReceiveData)
end

if CLIENT then
	local color_backup = Color(255, 155, 0, 255)
	function nzTools:UpdateBuildablesData(data)
		net.Start("nzBuildsToolUpdate")
			net.WriteTable(data)
		net.SendToServer()
	end

	hook.Add("PreDrawHalos", "NZ.Buildable.Halo", function()
		local ply = LocalPlayer()
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_buildable" and tr.StartPos:DistToSqr(tr.HitPos) < 10000 then
			local color = nzMapping.Settings.boxlightcolor or color_backup
			if nzMapping.Settings.monochrome and !nzElec:IsOn() then
				local avg = (color.r + color.g + color.b) / 3
				color = Color(avg, avg, avg, 255)
			end
			halo.Add({[1] = ent}, color, 1, 1, 1, true, false)
		end

		if IsValid(ent) and ent:GetClass() == "nz_buildtable" and !ent:GetCompleted() and tr.StartPos:DistToSqr(tr.HitPos) < 10000 and ent:GetRemainingParts() <= 0 then
			local color = nzMapping.Settings.boxlightcolor or color_backup
			if nzMapping.Settings.monochrome and !nzElec:IsOn() then
				local avg = (color.r + color.g + color.b) / 3
				color = Color(avg, avg, avg, 255)
			end
			local tabs = {[1] = ent}
			if ent.HoloGramEnt then
				tabs = table.Copy(ent.HoloGramEnt)
			end

			halo.Add(tabs, color, 1, 1, 1, true, false)
		end
	end)
end