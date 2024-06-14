nzTools:CreateTool("suitcharger", {
	displayname = "Suit Charger Placer",
	desc = "LMB: Place Suit Charger, RMB: Remove Suit Charger",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:SuitCharger(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "item_suitcharger" then
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
	displayname = "Suit Charger Placer",
	desc = "LMB: Place Suit Charger, RMB: Remove Suit Charger",
	icon = "icon16/attach.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		
	end,
})

if SERVER then
	nzMapping:AddSaveModule("SuitCharger", {
		savefunc = function()
			local chargers = {}
			for _, v in pairs(ents.FindByClass("item_suitcharger")) do
				table.insert(chargers, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
				})
			end
			return chargers
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:SuitCharger(v.pos, v.angle)
			end
		end,
		cleanents = {"item_suitcharger"},
	})
end