nzTools:CreateTool("ee", {
	displayname = "Easter Egg Placer",
	desc = "LMB: Easter Egg, RMB: Remove Easter Egg, Use Player Handler to select song",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		if IsValid(ent) and ent:GetClass() == "easter_egg" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			ent:DrawShadow(!ent:GetNoModel())
			return
		end
		nzMapping:EasterEgg(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 90,0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "easter_egg" then
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
	displayname = "Easter Egg Placer",
	desc = "LMB: Easter Egg, RMB: Remove Easter Egg, Use Player Handler to select song",
	icon = "icon16/music.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.model)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 300 )
		DProperties:SetPos( 10, 10 )
		
		function DProperties.CompileData()
			data.model = tostring(valz["Row1"])
			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "easter_egg")
		end

		local Row1 = DProperties:CreateRow("Model", "Model path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		model = "models/props_lab/huladoll.mdl",
	}
})

if SERVER then
	nzMapping:AddSaveModule("EasterEggs", {
		savefunc = function()
			local easter_eggs = {}
			for k, v in pairs(ents.FindByClass("easter_egg")) do
				table.insert(easter_eggs, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						model = v:GetModel(),
					}
				})
			end

			return easter_eggs
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:EasterEgg(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"easter_egg"}
	})
end