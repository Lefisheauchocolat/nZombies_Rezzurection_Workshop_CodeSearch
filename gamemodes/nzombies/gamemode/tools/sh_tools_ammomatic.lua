nzTools:CreateTool("ammomatic", {
	displayname = "Amm-O-Matic Machine",
	desc = "LMB: Place Amm-O-Matic Machine, RMB: Remove Amm-O-Matic Machine",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_ammo_matic" then
			if data and data.price and data.cooldown then
				ent:SetPrice(tonumber(data.price))
				ent:SetTotalCooldown(tonumber(data.cooldown))
				return
			end
		end
		nzMapping:SpawnAmmomatic(tr.HitPos + Vector(0,0,8), Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_ammo_matic" then
			ent:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_ammo_matic" then
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
	displayname = "Amm-O-Matic Placer",
	desc = "LMB: Place Amm-O-Matic Machine, RMB: Remove Amm-O-Matic Machine",
	icon = "icon16/money_dollar.png",
	weight = 18,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tonumber(data.cooldown)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.cooldown = tonumber(valz["Row2"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "ammomatic")
		end

		local Row1 = DProperties:CreateRow("Options", "Price")
		Row1:Setup("Int", { min = 1000, max = 30000 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Price, minimum of 1000")

		local Row2 = DProperties:CreateRow("Options", "Cooldown")
		Row2:Setup("Int", { min = 30, max = 600 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Cooldown, minimum of 30 seconds")

		return DProperties
	end,
	defaultdata = {
		price = 5000,
		cooldown = 120
	},
})

if SERVER then
	nzMapping:AddSaveModule("Ammomatic", {
		savefunc = function()
			local ammomatics = {}
			for k, v in pairs(ents.FindByClass("nz_ammo_matic")) do
				table.insert(ammomatics, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						price = v:GetPrice(),
						cooldown = v:GetTotalCooldown(),
					}
				})
			end

			return ammomatics
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnAmmomatic(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_ammo_matic"}
	})
end

if SERVER then
	hook.Add("OnRoundInit", "NZ.AmmoMatic.Reset", function()
		for k, v in pairs(ents.FindByClass("nz_ammo_matic")) do
			v:SetNextCooldown(CurTime())
		end
	end)
	hook.Add("ElectricityOn", "NZ.AmmoMatic.TurnOn", function()
		for k, v in pairs(ents.FindByClass("nz_ammo_matic")) do
			v:TurnOn()
		end
	end)
	hook.Add("OnRoundEnd", "NZ.AmmoMatic.TurnOff", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_ammo_matic")) do
				v:Reset()
			end
		end
	end)
end
