nzTools:CreateTool("peslocker", {
	displayname = "Dig Site Placer",
	desc = "LMB: Place P.E.S. Spawner, RMB: Remove",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		if data and data.model == "models/weapons/tfa_bo3/pes/p7_zm_moo_space_suit_body_lod7.mdl" then
			nzMapping:SpawnPESLocker(tr.HitPos + vector_up*35, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0) - Angle(0,-145,0), ply, data)
		else
			nzMapping:SpawnPESLocker(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
		end
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_bo3_pes_spawn" then
			tr.Entity:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "P.E.S. Placer",
	desc = "LMB: Place P.E.S. Spawner, RMB: Remove",
	icon = "icon16/status_offline.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.model)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.model = tostring(valz["Row1"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "peslocker")
		end

		local Row1 = DProperties:CreateRow("Model", "Model path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Defaults to 'models/weapons/tfa_bo3/pes/p7_zm_moo_space_suit_body_lod7.mdl'")

		return DProperties
	end,

	defaultdata = {
		model = "models/weapons/tfa_bo3/pes/p7_zm_moo_space_suit_body_lod7.mdl",
	},
})

if SERVER then
	nzMapping:AddSaveModule("peslocker", {
		savefunc = function()
			local pes_spawn = {}
			for k, v in pairs(ents.FindByClass("nz_bo3_pes_spawn")) do
				table.insert(pes_spawn, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						model = v:GetModel(),
					}
				})
			end

			return pes_spawn
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnPESLocker(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_bo3_pes_spawn"}
	})
end
