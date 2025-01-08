nzTools:CreateTool("ammomod", {
	displayname = "Ammo Mod Station Placer",
	desc = "LMB: Ammo Mod Station, RMB: Remove Ammo Mod Station",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:AmmoMod(tr.HitPos, (Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "ammo_mod" then
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
	displayname = "Ammo Mod Station Placer",
	desc = "LMB: Ammo Mod Station, RMB: Remove Ammo Mod Station",
	icon = "icon16/monitor_lightning.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		--valz["Row2"] = tonumber(data.scrap)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.price 			= tonumber(valz["Row1"])
			--data.scrap 			= tonumber(valz["Row2"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "ammomod")
		end

		local Row1 = DProperties:CreateRow( "Price", "Normal" )
		Row1:Setup( "Integer" )
		Row1:SetValue( valz["Row1"] )
		Row1:SetTooltip("How much ammo mods cost")
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		--local Row2 = DProperties:CreateRow( "Currency", "Uses Scrap?" )
		--Row2:Setup( "Boolean" )
		--Row2:SetValue( valz["Row2"] )
		--Row2.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		
		return DProperties
	end,

	defaultdata = {
		price 			= 2500,
		--scrap = false

	},
})

if SERVER then
	nzMapping:AddSaveModule("AmmoMod", {
		savefunc = function()
			local ammomods = {}
			for _, v in pairs(ents.FindByClass("ammo_mod")) do
				table.insert(ammomods, {
					pos 	= v:GetPos(),
					angle 	= v:GetAngles(),
					tab = {
						price 			= v:GetPrice(),
					},
					})
			end
			return ammomods
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:AmmoMod(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"ammo_mod"},
	})
end