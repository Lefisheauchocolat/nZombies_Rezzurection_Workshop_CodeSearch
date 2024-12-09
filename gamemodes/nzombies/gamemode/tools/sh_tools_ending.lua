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
			if data.keepplaying ~= nil then
				ent:SetKeepPlaying(tobool(data.keepplaying))
			end
			if data.giveallperks ~= nil then
				ent:SetRewardPerks(tobool(data.giveallperks))
			end
			if data.permaperks ~= nil then
				ent:SetPermaPerks(tobool(data.permaperks))
			end
			if data.hint then
				ent:SetHintString(tostring(data.hint))
			end
			if data.customtext then
				ent:SetCustomText(tostring(data.customtext))
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
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tostring(data.model)
		valz["Row5"] = tobool(data.keepplaying)
		valz["Row6"] = tobool(data.giveallperks)
		valz["Row7"] = tobool(data.permaperks)
		valz["Row8"] = tostring(data.hint)
		valz["Row9"] = tostring(data.customtext)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 300 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.model = tostring(valz["Row2"])
			data.keepplaying = tobool(valz["Row5"])
			data.giveallperks = tobool(valz["Row6"])
			data.permaperks = tobool(valz["Row7"])
			data.hint = tostring(valz["Row8"])
			data.customtext = tostring(valz["Row9"])

			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "ending")
		end

		local Row1 = DProperties:CreateRow("Options", "Price")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Options", "Model path")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row5 = DProperties:CreateRow("Options", "Keep Playing")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row6 = DProperties:CreateRow("Options", "Reward All Perks")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row7 = DProperties:CreateRow("Options", "Permanent Perks")
		Row7:Setup("Boolean")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val ) valz["Row7"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row8 = DProperties:CreateRow("Options", "Hint String")
		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val ) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row9 = DProperties:CreateRow("Options", "Game Win Sub Text Override")
		Row9:Setup("Generic")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val ) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		price = 500,
		model = "models/hoff/props/teddy_bear/teddy_bear.mdl",
		keepplaying = false,
		giveallperks = false,
		permaperks = false,
		hint = "End game",
		customtext = "",
	},
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
						keepplaying = v:GetKeepPlaying(),
						giveallperks = v:GetRewardPerks(),
						permaperks = v:GetPermaPerks(),
						hint = v:GetHintString(),
						customtext = v:GetCustomText(),
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