nzTools:CreateTool("ending", {
	displayname = "Buyable Ending Spawner",
	desc = "LMB: Place Buyable Ending, RMB: Remove that shit",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		if IsValid(ent) and ent:GetClass() == "nz_ending" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			ent:DrawShadow(!ent:GetNoModel())
			return
		end
		nzMapping:Ending(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 90,0), tonumber(data.price), data, ply)
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "buyable_ending" then
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
	displayname = "Buyable Ending Spawner",
	desc = "LMB: Place Buyable Ending, RMB: Remove that shit",
	icon = "icon16/tick.png",
	weight = 4,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = data.price
		valz["Row2"] = tostring(data.model)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 300 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			data.price = valz["Row1"]
			data.model = tostring(valz["Row2"])
			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "ending")
		end

		local Row1 = DProperties:CreateRow( "Buyable Ending", "Price" )
		Row1:Setup( "Integer" )
		Row1:SetValue( valz["Row1"] )
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		local Row2 = DProperties:CreateRow("Model", "Model path")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		price = 500,
		model = "models/hoff/props/teddy_bear/teddy_bear.mdl",
	}
})

if SERVER then
	nzMapping:AddSaveModule("Endings", {
		savefunc = function()
			local endings = {}
			for _, v in pairs(ents.FindByClass("buyable_ending")) do
				table.insert(endings, {
				pos = v:GetPos(),
				angle = v:GetAngles(),
				price = v:GetPrice(),
					tab = {
						model = v:GetModel(),
					}
				})
			end
			return endings
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:Ending(v.pos, v.angle, v.price, v.tab)
			end
		end,
		cleanents = {"buyable_ending"},
	})
end