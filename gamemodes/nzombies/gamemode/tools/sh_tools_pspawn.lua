nzTools:CreateTool("pspawn", {
	displayname = "Player Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:PlayerSpawn(tr.HitPos,(Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "player_spawns" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Player Spawn Creator",
	desc = "LMB: Place Spawnpoint, RMB: Remove Spawnpoint",
	icon = "icon16/user.png",
	weight = 2,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.dooractivate
		valz["Row2"] = data.activatetype
		valz["Row3"] = data.doorflag
		valz["Row4"] = data.doorflag2
		valz["Row5"] = data.doorflag3
		valz["Row6"] = data.preferred

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.dooractivate = tobool(valz["Row1"])
			data.activatetype = tonumber(valz["Row2"])
			data.doorflag = tostring(valz["Row3"])
			data.doorflag2 = tostring(valz["Row4"])
			data.doorflag3 = tostring(valz["Row5"])
			data.preferred = tobool(valz["Row6"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "pspawn")
		end

		local Row1 = DProperties:CreateRow("Options", "Enable Door Activation")
		Row1:Setup("Boolean")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Options", "Door Activation Type")
		Row2:Setup("Combo")
		Row2:AddChoice('Deactivate on Door Flag', 0, valz["Row2"] == 0)
		Row2:AddChoice('Activate on Door Flag', 1, valz["Row2"] == 1)
		Row2.DataChanged = function( _, val ) valz["Row2"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row3 = DProperties:CreateRow("Options", "Door flag")
		Row3:Setup("Generic")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row4 = DProperties:CreateRow("Options", "Door flag 2")
		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row5 = DProperties:CreateRow("Options", "Door flag 3")
		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row6 = DProperties:CreateRow("Options", "Preferred Spawn")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Set round num to 0 and flag to nothing to disable")
		text:SetFont("Trebuchet18")
		text:SetTextColor(Color(50, 50, 50))
		text:SizeToContents()
		text:Center()

		return DProperties

	end,
	defaultdata = {
		dooractivate = false,
		activatetype = 0,
		doorflag = "",
		doorflag2 = "",
		doorflag3 = "",
		preferred = false,
	}
})

if SERVER then
	nzPlayers.StoredSpawnData = nzPlayers.StoredSpawnData or {}
	nzPlayers.SpawnsToActivate = nzPlayers.SpawnsToActivate or {}

	hook.Add("OnRoundInit", "nz.PlayerSpawnMagic", function()
		for _, ent in pairs(ents.FindByClass("player_spawns")) do
			if ent:GetDoorActivated() then
				local savedata = {
					pos = ent:GetPos(),
					angle = ent:GetAngles(),
					tab = {
						dooractivate = ent:GetDoorActivated(),
						activatetype = ent:GetDoorActivateType(),
						doorflag = ent:GetDoorFlag(),
						doorflag2 = ent:GetDoorFlag2(),
						doorflag3 = ent:GetDoorFlag3(),
						preferred = ent:GetPreferred(),
					}
				}
				table.insert(nzPlayers.StoredSpawnData, savedata)

				if ent:GetDoorActivateType() > 0 then
					table.insert(nzPlayers.SpawnsToActivate, savedata)
					SafeRemoveEntity(ent)
				end
			end
		end
	end)

	hook.Add("OnDoorUnlocked", "nz.PlayerSpawnMagic", function(ent, link, rebuyable, ply)
		for index, data in pairs(nzPlayers.SpawnsToActivate) do
			local spawndata = data.tab
			if not spawndata then continue end

			local door_flags = {}
			if spawndata.doorflag and spawndata.doorflag ~= "" then
				door_flags[spawndata.doorflag] = true
			end
			if spawndata.doorflag2 and spawndata.doorflag2 ~= "" then
				door_flags[spawndata.doorflag2] = true
			end
			if spawndata.doorflag3 and spawndata.doorflag3 ~= "" then
				door_flags[spawndata.doorflag3] = true
			end

			if door_flags[tostring(link)] then
				nzMapping:PlayerSpawn(data.pos, data.angle, spawndata)
				nzPlayers.SpawnsToActivate[index] = nil
			end
		end

		for _, ent in pairs(ents.FindByClass("player_spawns")) do
			if ent:GetDoorActivated() and ent:GetDoorActivateType() < 1 then
				local door_flags = {}
				if ent:GetDoorFlag() and ent:GetDoorFlag() ~= "" then
					door_flags[ent:GetDoorFlag()] = true
				end
				if ent:GetDoorFlag2() and ent:GetDoorFlag2() ~= "" then
					door_flags[ent:GetDoorFlag2()] = true
				end
				if ent:GetDoorFlag3() and ent:GetDoorFlag3() ~= "" then
					door_flags[ent:GetDoorFlag3()] = true
				end

				if door_flags[tostring(link)] then
					SafeRemoveEntity(ent)
				end
			end
		end
	end)

	hook.Add("OnRoundEnd", "nz.PlayerSpawnMagic", function()
		for _, ent in pairs(ents.FindByClass("player_spawns")) do
			if ent:GetDoorActivated() then
				SafeRemoveEntity(ent)
			end
		end
		for _, data in pairs(nzPlayers.StoredSpawnData) do
			nzMapping:PlayerSpawn(data.pos, data.angle, data.tab)
		end

		nzPlayers.SpawnsToActivate = {}
		nzPlayers.StoredSpawnData = {}
	end)
end