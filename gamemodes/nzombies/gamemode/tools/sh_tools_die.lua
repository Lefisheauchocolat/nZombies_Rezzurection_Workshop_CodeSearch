nzTools:CreateTool("die", {
	displayname = "Misery Acceleration Device",
	desc = "LMB: Place, RMB: Remove",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		if IsValid(ent) and ent:GetClass() == "stinky_lever" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.snd and isstring(data.snd) then
				ent:SetActivateSound(data.snd)
			end
			ent:DrawShadow(!ent:GetNoModel())
			return
		end
		nzMapping:StinkyLever(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 90,0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "stinky_lever" then
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
	displayname = "Misery Acceleration Device",
	desc = "LMB: Place, RMB: Remove ",
	icon = "icon16/cut.png",
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
			data.snd = tostring(valz["Row2"])
			return data
		end
		
		function DProperties.UpdateData(data)
			nzTools:SendData(data, "die")
		end

		local Row1 = DProperties:CreateRow("Model", "Model path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Sound", "Activate Sound")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		model = "models/nzr/2022/misc/maldometer.mdl",
		snd = "nz_moo/zombies/vox/mute_00.wav",
	}
})

if SERVER then
	nzMapping:AddSaveModule("SufferingMachine", {
		savefunc = function()
			local machines = {}
			for k, v in pairs(ents.FindByClass("stinky_lever")) do
				table.insert(machines, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						model = v:GetModel(),
						snd = v:GetActivateSound(),
					}
				})
			end

			return machines
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:StinkyLever(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"stinky_lever"}
	})
end