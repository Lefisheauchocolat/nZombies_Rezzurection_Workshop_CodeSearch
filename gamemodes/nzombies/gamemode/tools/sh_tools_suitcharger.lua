nzTools:CreateTool("suitcharger", {
	displayname = "Suit Charger Placer",
	desc = "LMB: Place Suit Charger, RMB: Remove Suit Charger",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ang = tr.HitNormal:Angle()
		nzMapping:SuitCharger(tr.HitPos, Angle(ang[1],ang[2],0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "item_suitcharger" then
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
	displayname = "Suit Charger Placer",
	desc = "LMB: Place Suit Charger, RMB: Remove Suit Charger",
	icon = "icon16/attach.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.spawnflag)
		valz["Row2"] = tonumber(data.delay)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.spawnflag = tonumber(valz["Row1"])
			data.delay = tonumber(valz["Row2"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "suitcharger")
		end

		local Row1 = DProperties:CreateRow("Options", "Charger type")
		Row1:Setup("Combo")
		Row1:AddChoice("Default Charger (75)", 0, valz["Row1"] == 0)
		Row1:AddChoice("Citadel Charger (500)", 8192, valz["Row1"] == 8192)
		Row1:AddChoice("Kleiner's Lab Charger (25)", 16384, valz["Row1"] == 16384)
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Options", "Recharge Delay")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2:SetTooltip("How long it takes for the charger to recharge after being emptied")
		Row2.DataChanged = function( _, val ) valz["Row2"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,

	defaultdata = {
		spawnflag = 0,
		delay = 90,
	},
})

if SERVER then
	nzMapping:AddSaveModule("SuitCharger", {
		savefunc = function()
			local chargers = {}
			for _, v in pairs(ents.FindByClass("item_suitcharger")) do
				table.insert(chargers, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						spawnflag = (v:HasSpawnFlags(16384) and 16384) or (v:HasSpawnFlags(8192) and 8192) or 0,
						delay = tonumber(v:GetInternalVariable("m_iReactivate")),
					},
				})
			end
			return chargers
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:SuitCharger(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"item_suitcharger"},
	})
end