nzTools:CreateTool("ammobox", {
	displayname = "Ammo Box Placer",
	desc = "LMB: Ammo Box, RMB: Remove Ammo Box",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:AmmoBox(tr.HitPos, (Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0)), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "ammo_box" then
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
	displayname = "Ammo Box Placer",
	desc = "LMB: Ammo Box, RMB: Remove Ammo Box",
	icon = "icon16/tab.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tonumber(data.papprice)
		valz["Row3"] = tonumber(data.wonderprice)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.price 			= tonumber(valz["Row1"])
			data.papprice 		= tonumber(valz["Row2"])
			data.wonderprice 	= tonumber(valz["Row3"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "ammo")
		end

		local Row1 = DProperties:CreateRow( "Price", "Normal" )
		Row1:Setup( "Integer" )
		Row1:SetValue( valz["Row1"] )
		Row1:SetTooltip("How much ammo should cost for normal weapons.")
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row2 = DProperties:CreateRow( "Price", "Pack-a-Punch" )
		Row2:Setup( "Integer" )
		Row2:SetValue( valz["Row2"] )
		Row2:SetTooltip("How much ammo should cost for upgraded weapons.")
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		local Row3 = DProperties:CreateRow( "Price", "Wonder Weapon" )
		Row3:Setup( "Integer" )
		Row3:SetValue( valz["Row3"] )
		Row3:SetTooltip("How much ammo should cost for wonder weapons.")
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		
		return DProperties
	end,

	defaultdata = {
		price 			= 1500,
		papprice 		= 5000,
		wonderprice 	= 15000,
	},
})

if SERVER then
	nzMapping:AddSaveModule("AmmoBox", {
		savefunc = function()
			local ammoboxes = {}
			for _, v in pairs(ents.FindByClass("ammo_box")) do
				table.insert(ammoboxes, {
					pos 	= v:GetPos(),
					angle 	= v:GetAngles(),
					tab = {
						price 			= v:GetPrice(),
						papprice 		= v:GetPapPrice(),
						wonderprice 	= v:GetWonderPrice(),
					},
				})
			end
			return ammoboxes
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:AmmoBox(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"ammo_box"},
	})
end