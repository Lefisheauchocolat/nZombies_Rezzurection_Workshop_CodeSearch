nzTools:CreateTool("powerupspawn", {
	displayname = "Power-Up Spawner",
	desc = "LMB: Place Power-Up Spawner, RMB: Remove Power-Up Spawner, R: Test Spawner",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:SpawnPowerupSpawner(tr.HitPos + tr.HitNormal*50, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local entclass = {
			["drop_powerup"] = true,
			["powerup_spawner"] = true,
		}

		local ent = tr.Entity
		if not IsValid(ent) then return end

		if entclass[ent:GetClass()] then
			ent:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if not IsValid(ent) or ent:GetClass() ~= "powerup_spawner" then return end

		ent:SpawnPowerUp()
		ent:SetSolid(SOLID_VPHYSICS)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Power-Up Spawner",
	desc = "LMB: Place Power-Up Spawner, RMB: Remove Power-Up Spawner, R: Test Spawner",
	icon = "icon16/asterisk_yellow.png",
	weight = 6,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.powerup)
		valz["Row2"] = tobool(data.randomize)
		valz["Row3"] = tonumber(data.randomizeround)
		valz["Row4"] = tobool(data.scroll)
		valz["Row5"] = tonumber(data.scrollrate)
		valz["Row6"] = tonumber(data.scrollraterare)
		valz["Row7"] = tobool(data.scrollsequential)
		valz["Row8"] = tobool(data.door)
		valz["Row9"] = tostring(data.doorflag)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.powerup = tostring(valz["Row1"])
			data.randomize = tobool(valz["Row2"])
			data.randomizeround = tonumber(valz["Row3"])
			data.scroll = tobool(valz["Row4"])
			data.scrollrate = tonumber(valz["Row5"])
			data.scrollraterare = tonumber(valz["Row6"])
			data.scrollsequential = tobool(valz["Row7"])
			data.door = tobool(valz["Row8"])
			data.doorflag = tostring(valz["Row9"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "powerupspawn")
		end

		local Row1 = DProperties:CreateRow("Settings", "Power-Up Type")
		Row1:Setup("Combo")
		for k, v in pairs(nzMapping.Settings.poweruplist) do
			if v[1] then
				Row1:AddChoice(v[2], k, k == valz["Row1"])
			end
		end
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Randomization Settings", "Randomize Power-Up")
		Row2:Setup("Boolean")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val) valz["Row2"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetTooltip("Enable for Power-Up to randomize what type it is on round start (Default Off, Does nothing if Scrolling is enabled).")

		local Row3 = DProperties:CreateRow("Randomization Settings", "Randomize Round Interval")
		Row3:Setup("Generic")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val) valz["Row3"] = math.max(tonumber(val), 1) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetTooltip("How many rounds before Power-Up is randomized (Default 5, Minimum of 1).")

		local Row4 = DProperties:CreateRow("Scrolling Settings", "Scroll Power-Up")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetTooltip("Enable for Power-Up to scroll every x amount of seconds (Default Off).")

		local Row5 = DProperties:CreateRow("Scrolling Settings", "Scroll Delay")
		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val) valz["Row5"] = math.max(tonumber(val), 0.1) DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetTooltip("Delay between each Power-Up scroll (Default 1).")

		local Row6 = DProperties:CreateRow("Scrolling Settings", "Scroll Delay Rare")
		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val) valz["Row6"] = math.max(tonumber(val), 0.1) DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetTooltip("Delay between each Power-Up scroll for rare powerups (Default 0.25).")

		local Row7 = DProperties:CreateRow("Scrolling Settings", "Scroll Sequential")
		Row7:Setup("Boolean")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetTooltip("Enable for Power-Up to scroll sequentially through Power-Up list (Default On).")

		local Row8 = DProperties:CreateRow("Door Settings", "Activate On Door Open")
		Row8:Setup("Boolean")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val) valz["Row8"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetTooltip("Should Power-Up spawn when a specific door is opened. (Default Off).")

		local Row9 = DProperties:CreateRow("Door Settings", "Door Flag")
		Row9:Setup("Generic")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,

	defaultdata = {
		powerup = "maxammo",
		randomize = false,
		randomizeround = 5,
		scroll = false,
		scrollrate = 1,
		scrollraterare = 0.25,
		scrollsequential = true,
		door = false,
		doorflag = "",
	},
})

if SERVER then
	nzMapping:AddSaveModule("PowerupSpawners", {
		savefunc = function()
			local powerup_spawners = {}
			for k, v in pairs(ents.FindByClass("powerup_spawner")) do
				table.insert(powerup_spawners, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						powerup = v:GetPowerUp(),
						randomize = v:GetRandomize(),
						randomizeround = v:GetRandomizeRound(),
						scroll = v:GetDoScroll(),
						scrollrate = v:GetScrollTime(),
						scrollraterare = v:GetScrollTimeRare(),
						scrollsequential = v:GetSequential(),
						door = v:GetDoor(),
						doorflag = v:GetDoorFlag(),
					}
				})
			end

			return powerup_spawners
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnPowerupSpawner(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"powerup_spawner"}
	})

	hook.Add("OnGameBegin", "nz.PowerUpSpawner", function()
		//we all die someday
		timer.Simple(0, function()
			for _, v in pairs(ents.FindByClass("powerup_spawner")) do
				v:SetSolid(SOLID_NONE)
				if v:GetDoor() then continue end
				v:SpawnPowerUp()
			end
		end)
	end)

	hook.Add("OnRoundPreparation", "nz.PowerUpSpawner", function(round)
		for k, v in pairs(ents.FindByClass("drop_powerup")) do
			if v:GetSpawnedPowerUp() then
				local ent = v.PowerUpSpawner
				if IsValid(ent) and ent:GetRandomize() and round%(ent:GetRandomizeRound()) == 0 and round ~= 1 then
					v:RerollPowerUp()
				end
			end
		end
	end)

	hook.Add("OnRoundEnd", "nz.PowerUpSpawner", function()
		for _, spawner in pairs(ents.FindByClass("powerup_spawner")) do
			spawner:SetSolid(SOLID_VPHYSICS)
		end
	end)

	hook.Add("OnDoorUnlocked", "NZ.PowerUpSpawner", function(ent, link, rebuyable, ply)
		for _, v in pairs(ents.FindByClass("powerup_spawner")) do
			if v:GetDoor() and v:GetDoorFlag() == tostring(link) then
				v:SpawnPowerUp()
			end
		end
	end)
end
