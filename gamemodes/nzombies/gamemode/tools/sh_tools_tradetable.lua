nzTools:CreateTool("tradetable", {
	displayname = "Trading Table Placer",
	desc = "LMB: Place Trading Table, RMB: Remove Tading Table",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_tradetable" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.price then
				ent:SetPrice(tonumber(data.price))
			end
			if data.offset then
				ent.WeaponOffset = tonumber(data.offset)
			end
			if data.specials ~= nil then
				ent:SetAllowWonder(tobool(data.specials))
			end
			return
		end

		nzMapping:SpawnTradeTable(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_tradetable" then
			ent:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_tradetable"then
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
	displayname = "Trading Table Placer",
	desc = "LMB: Place Trading Table, RMB: Remove Trading Table",
	icon = "icon16/arrow_refresh.png",
	weight = 21,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tostring(data.model)
		valz["Row3"] = tonumber(data.offset)
		valz["Row4"] = tobool(data.specials)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 250 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.model = tostring(valz["Row2"])
			data.offset = tonumber(valz["Row3"])
			data.specials = tobool(valz["Row4"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "tradetable")
		end

		local Row1 = DProperties:CreateRow("Options", "Price")
		Row1:Setup("Integer")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Price to pickup weapons from Trading Table, SET TO 0 TO DISSABLE!")

		local Row3 = DProperties:CreateRow("Options", "Weapon height offset")
		Row3:Setup("Integer")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Height to vertically offset the placed weapon by. Weapon spawns from tables WorldSpaceCenter(), defaults to 24 units.")

		local Row4 = DProperties:CreateRow("Options", "Allow trading Wonder Weapons")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Allow placing weapons with NZWonderWeapon bool set to true, does not include things like the raygun.")

		local Row2 = DProperties:CreateRow("Model", "Model path")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Defaults to 'models/zmb/bo2/tranzit/zm_work_bench.mdl'")

		return DProperties
	end,

	defaultdata = {
		price = 0,
		model = "models/zmb/bo2/tranzit/zm_work_bench.mdl",
		offset = 22,
		specials = true,
	},
})

if SERVER then
	nzMapping:AddSaveModule("tradetable", {
		savefunc = function()
			local tradetable_spawn = {}
			for k, v in pairs(ents.FindByClass("nz_tradetable")) do
				table.insert(tradetable_spawn, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						price = v:GetPrice(),
						model = v:GetModel(),
						offset = v.WeaponOffset,
						specials = v:GetAllowWonder(),
					}
				})
			end

			return tradetable_spawn
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnTradeTable(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_tradetable"}
	})
end

if SERVER then
	hook.Add("OnPlayerPickupPowerUp", "NZ.TradeTables.Maxammo", function( _, id, ent)
		if id ~= "maxammo" then return end
		for k, v in pairs(ents.FindByClass('nz_tradetable')) do
			v:MaxAmmo()
		end
	end)

	hook.Add("OnRoundInit", "NZ.Reset.TradeTables", function()
		for k, v in pairs(ents.FindByClass("nz_tradetable")) do
			v:Reset()
		end
	end)

	hook.Add("OnRoundEnd", "NZ.Reset.TradeTables", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_tradetable")) do
				v:Reset()
			end
		end
	end)

	hook.Add("PlayerCanPickupWeapon", "NZ.TradeTables.Fuck", function(ply, wep)
		if not IsValid(ply) or not IsValid(wep) then return end
		local p = wep:GetParent()
		if IsValid(p) and p:GetClass() == "nz_tradetable" then
			return false
		end
	end)

	hook.Add("AllowPlayerPickup", "NZ.TradeTables.Fuck", function(ply, wep)
		if not IsValid(ply) or not IsValid(wep) then return end
		local p = wep:GetParent()
		if IsValid(p) and p:GetClass() == "nz_tradetable" then
			return false
		end
	end)
end
