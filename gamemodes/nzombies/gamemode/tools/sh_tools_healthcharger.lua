nzTools:CreateTool("healthcharger", {
	displayname = "Health Charger Placer",
	desc = "LMB: Place Health Charger, RMB: Remove Health Charger",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ang = tr.HitNormal:Angle()
		nzMapping:HealthCharger(tr.HitPos, Angle(ang[1],ang[2],0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "item_healthcharger" then
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
	displayname = "Health Charger Placer",
	desc = "LMB: Place Health Charger, RMB: Remove Health Charger",
	icon = "icon16/pill.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.delay)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.delay = tonumber(valz["Row1"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "healthcharger")
		end

		local Row1 = DProperties:CreateRow("Options", "Recharge Delay")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1:SetTooltip("How long it takes for the charger to recharge after being emptied")
		Row1.DataChanged = function( _, val ) valz["Row1"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,

	defaultdata = {
		delay = 45,
	},
})

if SERVER then
	nzMapping:AddSaveModule("HealthCharger", {
		savefunc = function()
			local chargers = {}
			for _, v in pairs(ents.FindByClass("item_healthcharger")) do
				table.insert(chargers, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						delay = tonumber(v:GetInternalVariable("m_iReactivate"))
					},
				})
			end
			return chargers
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:HealthCharger(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"item_healthcharger"},
	})
end