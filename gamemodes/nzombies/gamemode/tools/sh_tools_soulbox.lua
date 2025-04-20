local selected1 = 2

nzTools:CreateTool("soulbox", {
	displayname = "Soul Box Placer",
	desc = "LMB: Place/Update Soul Box, RMB: Remove Soul Box",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_soulbox" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.reward then
				ent:SetRewardType(tonumber(data.reward))
			end
			if data.souls then
				ent:SetSoulCost(tonumber(data.souls))
			end
			if data.range then
				ent:SetRange(tonumber(data.range))
			end
			if data.killall ~= nil then
				ent.KillAll = tobool(data.killall)
			end
			if data.elec ~= nil then
				ent.Elec = tobool(data.elec)
				ent:SetElectric(tobool(data.elec))
			end
			if data.limited ~= nil then
				ent:SetLimited(tobool(data.limited))
			end
			if data.aoe then
				ent:SetAOE(tonumber(data.aoe))
			end
			if data.door then
				ent:SetDoorFlag(tostring(data.door))
			end
			if data.weapon then
				ent:SetWepClass(tostring(data.weapon))
			end
			if data.powerup ~= nil then
				ent:SetGivePowerup(tobool(data.powerup))
			end
			if data.skin then
				ent:SetSkin(tonumber(data.skin))
			end
			if data.specials ~= nil then
				ent:SetSpecials(tobool(data.specials))
			end
			if data.sound and file.Exists("sound/"..data.sound, "GAME") then
				ent.ActivateSound = Sound(data.sound)
			end
			if data.class and (nzConfig.ValidEnemies[tostring(data.class)] or nzRound.BossData[tostring(data.class)]) then
				ent:SetZombieClass(tostring(data.class))
			end
			if data.collision ~= nil then
				if data.collision then
					ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
				else
					ent:SetCollisionGroup(COLLISION_GROUP_NONE)
				end
			end
			return
		end
		nzMapping:SpawnSoulBox(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_soulbox" then
			ent:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_soulbox"then
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
	displayname = "Soul Box Placer",
	desc = "LMB: Place/Update Soul Box, RMB: Remove Soul Box",
	icon = "icon16/fire.png",
	weight = 21,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.reward)
		valz["Row2"] = tonumber(data.souls)
		valz["Row3"] = tonumber(data.range)
		valz["Row4"] = tobool(data.killall)
		valz["Row5"] = tobool(data.elec)
		valz["Row6"] = tobool(data.powerup)
		valz["Row7"] = tostring(data.door)
		valz["Row8"] = tostring(data.weapon)
		valz["Row9"] = tobool(data.limited)
		valz["Row10"] = tonumber(data.aoe)
		valz["Row11"] = tostring(data.model)
		valz["Row12"] = tonumber(data.skin)
		valz["Row13"] = tobool(data.specials)
		valz["Row14"] = tostring(data.class)
		valz["Row15"] = tostring(data.sound)
		valz["Row16"] = tonumber(data.flag)
		valz["Row17"] = tobool(data.collision) or false
		valz["Row18"] = tostring(data.doortext)
		valz["Row19"] = tostring(data.completetext)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.reward = tonumber(valz["Row1"])
			data.souls = tonumber(valz["Row2"])
			data.range = tonumber(valz["Row3"])
			data.killall = tobool(valz["Row4"])
			data.elec = tobool(valz["Row5"])
			data.powerup = tobool(valz["Row6"])
			data.door = tostring(valz["Row7"])
			data.weapon = tostring(valz["Row8"])
			data.limited = tobool(valz["Row9"])
			data.aoe = tonumber(valz["Row10"])
			data.model = tostring(valz["Row11"])
			data.skin = tonumber(valz["Row12"])
			data.specials = tobool(valz["Row13"])
			data.class = tostring(valz["Row14"])
			data.sound = tostring(valz["Row15"])
			data.flag = tonumber(valz["Row16"])
			data.collision = tobool(valz["Row17"])
			data.doortext = tostring(valz["Row18"])
			data.completetext = tostring(valz["Row19"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "soulbox")
		end

		local Row1 = DProperties:CreateRow("Options", "Reward Type")
		Row1:Setup("Combo")
		//Row1:AddChoice("Random Power-Up", 1)
		Row1:AddChoice("Random Perk", 2, selected1 == 2)
		Row1:AddChoice("PAP held weapon", 3, selected1 == 3)
		Row1:AddChoice("Open door", 4, selected1 == 4)
		Row1:AddChoice("Activate power", 5, selected1 == 5)
		Row1:AddChoice("CompleteFunc (for use in mapscript)", 6, selected1 == 6)
		Row1.DataChanged = function( _, val ) selected1 = val valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Reward goes to all players (if applicable). Default is random Perk")

		local Row2 = DProperties:CreateRow("Options", "Required Amount of Souls")
		Row2:Setup("Int", { min = 1, max = 255 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Amount of zomibes to kill before completing. Default is 24.")

		local Row3 = DProperties:CreateRow("Options", "Range of Soul Box")
		Row3:Setup("Int", { min = 80, max = 2400 })
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Range that the Soul Box will react to a zombie dying. Default is 400")

		local Row4 = DProperties:CreateRow("Options", "Require all Soul Boxes be filled")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("All Soul Boxses must be filled to give the reward.")

		local Row16 = DProperties:CreateRow("Options", "Flag")
		Row16:Setup("Int", { min = 0, max = 128 })
		Row16:SetValue(valz["Row16"])
		Row16.DataChanged = function( _, val ) valz["Row16"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row16:SetToolTip("If all soulboxes are required to be completed, only ones with the same flag will count.")

		local Row5 = DProperties:CreateRow("Options", "Require electricity to be on")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Soul Box wont activate till electricity is on.")

		local Row6 = DProperties:CreateRow("Options", "Always Reward Powerup")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Spawn powerup when a souldbox is completed, regardless of the reward type.")

		local Row7 = DProperties:CreateRow("Options", "Door flag")
		Row7:Setup("Generic")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row7:SetToolTip("Only applicable if reward is a door.")

		local Row13 = DProperties:CreateRow("Options", "Special enemies only")
		Row13:Setup("Boolean")
		Row13:SetValue(valz["Row13"])
		Row13.DataChanged = function( _, val ) valz["Row13"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row13:SetToolTip("Soul Box will only count special zombies.")

		local Row14 = DProperties:CreateRow("Options", "Require specific zombie type")
		Row14:Setup("Combo")
		Row14:AddChoice("DISABLE", "", valz["Row14"] == "")
		for k, v in pairs(nzConfig.ValidEnemies) do
			Row14:AddChoice(k, k, valz["Row14"] == k)
		end
		for k,v in pairs(nzRound.BossData) do
			Row14:AddChoice(v, k, valz["Row14"] == k)
		end
		Row14.DataChanged = function( _, val ) valz["Row14"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row14:SetTooltip("Soul Box will only count the specific zombie type selected.")

		local Row8 = DProperties:CreateRow("Options", "Required Weapon")
		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row8:SetToolTip("Require a specific weapon class to activate Soul Box. Leave blank to dissable.")

		local Row9 = DProperties:CreateRow("Power", "Enable Limited power radius")
		Row9:Setup("Boolean")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row9:SetToolTip("Similar to limited range power switches, REQUIRES REWARD BE ACTIVATE POWER")

		local Row10 = DProperties:CreateRow("Power", "Power activation radius")
		Row10:Setup("Int", { min = 0, max = 30000 })
		Row10:SetValue(valz["Row10"])
		Row10.DataChanged = function( _, val ) valz["Row10"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row10:SetToolTip("Radius that power will be activated, REQUIRES REWARD BE ACTIVATE POWER")

		local Row17 = DProperties:CreateRow("Other", "Disable collision")
		Row17:Setup("Boolean")
		Row17:SetValue(valz["Row17"])
		Row17.DataChanged = function( _, val ) valz["Row17"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row17:SetToolTip("Name.")

		local Row15 = DProperties:CreateRow("Other", "Completion sound path")
		Row15:Setup("Generic")
		Row15:SetValue(valz["Row15"])
		Row15.DataChanged = function( _, val ) valz["Row15"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row15:SetToolTip("Defaults to 'zmb/tomb/evt_souls_full.wav'")

		local Row11 = DProperties:CreateRow("Other", "Model path")
		Row11:Setup("Generic")
		Row11:SetValue(valz["Row11"])
		Row11.DataChanged = function( _, val ) valz["Row11"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row11:SetToolTip("Defaults to 'models/zmb/bo2/tomb/zm_tm_soul_box.mdl'")

		local Row12 = DProperties:CreateRow("Other", "Model skin")
		Row12:Setup("Int", { min = 0, max = 128 })
		Row12:SetValue(valz["Row12"])
		Row12.DataChanged = function( _, val ) valz["Row12"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row12:SetToolTip("as on the tin.")

		local Row18 = DProperties:CreateRow("Other", "Door Open Chat Message")
		Row18:Setup("Generic")
		Row18:SetValue(valz["Row18"])
		Row18.DataChanged = function( _, val ) valz["Row18"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row18:SetToolTip("A door somewhere has opened...")

		local Row19 = DProperties:CreateRow("Other", "Soul Box Completed Chat Message")
		Row19:Setup("Generic")
		Row19:SetValue(valz["Row19"])
		Row19.DataChanged = function( _, val ) valz["Row19"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row19:SetToolTip("Soul Box completed!")

		return DProperties
	end,

	defaultdata = {
		reward = 2,
		souls = 24,
		range = 400,
		killall = false,
		elec = false,
		powerup = true,
		door = "",
		weapon = "",
		limited = false,
		aoe = 0,
		model = "models/zmb/bo2/tomb/zm_tm_soul_box.mdl",
		skin = 0,
		specials = false,
		class = "",
		sound = "zmb/tomb/evt_souls_full.wav",
		collision = false,
		doortext = "A door somewhere has opened...",
		completetext = "Soul Box completed!",
	},
})

if SERVER then
	nzMapping:AddSaveModule("SoulBox", {
		savefunc = function()
			local soulbox_spawn = {}
			for k, v in pairs(ents.FindByClass("nz_soulbox")) do
				table.insert(soulbox_spawn, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						flag = v:GetFlag(),
						reward = v:GetRewardType(),
						souls = v:GetSoulCost(),
						range = v.Range,
						killall = v.KillAll,
						elec = v:GetElectric(),
						powerup = v:GetGivePowerup(),
						door = v:GetDoorFlag(),
						weapon = v:GetWepClass(),
						limited = v:GetLimited(),
						aoe = v:GetAOE(),
						model = v:GetModel(),
						skin = v:GetSkin(),
						specials = v:GetSpecials(),
						class = v:GetZombieClass(),
						sound = v.ActivateSound,
						collision = (v:GetCollisionGroup() == COLLISION_GROUP_WORLD),
						doortext = v.DoorOpenText,
						completetext = v.CompletedText,
					}
				})
			end

			return soulbox_spawn
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnSoulBox(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_soulbox"}
	})
end

if SERVER then
	hook.Add("OnRoundInit", "NZ.Start.SoulBoxs", function()
		for k, v in pairs(ents.FindByClass("nz_soulbox")) do
			v:Reset()
		end
	end)

	hook.Add("OnRoundEnd", "NZ.Reset.SoulBoxs", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_soulbox")) do
				v:Reset()
			end
		end
	end)
end
