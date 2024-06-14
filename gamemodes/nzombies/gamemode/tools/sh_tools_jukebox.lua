nzTools:CreateTool("jukebox", {
	displayname = "Jukebox Placer",
	desc = "LMB: Place Jukebox, RMB: Remove Jukebox",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		if IsValid(ent) and ent:GetClass() == "nz_jukebox" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			ent:DrawShadow(!ent:GetNoModel())
			return
		end
		nzMapping:Jukebox(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 180,0), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_jukebox" then
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
	displayname = "Jukebox Placer",
	desc = "LMB: Place Jukebox, RMB: Remove Jukebox",
	icon = "icon16/ipod.png",
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
			nzTools:SendData(data, "jukebox")
		end

		local Row1 = DProperties:CreateRow("Model", "Model path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		return DProperties
	end,
	defaultdata = {
		model = "models/zmb/ugx/jukebox.mdl",
	}
})

if SERVER then
	nzMapping:AddSaveModule("JukeboxSpawns", {
		savefunc = function()
			local jukebox_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_jukebox")) do
				table.insert(jukebox_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						model = v:GetModel(),
					}
				})
			end

			return jukebox_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:Jukebox(v.pos, v.angle, v.tab)
			end
		end,
		cleanents = {"nz_jukebox"}
	})
end