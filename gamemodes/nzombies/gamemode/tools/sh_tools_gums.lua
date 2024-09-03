if SERVER then
    nzMapping:AddSaveModule("bo3gobblegum", {
        savefunc = function()
            local bo3gobblegum = {}
            for _, v in pairs(ents.FindByClass("nz_gummachine")) do
                table.insert(bo3gobblegum, {
                    pos = v:GetPos(),
                    angle = v:GetAngles(),
                })
            end
            return bo3gobblegum
        end,
        loadfunc = function(data)
            for k,v in pairs(data) do
                local ent = ents.Create("nz_gummachine")
                ent:SetPos(v.pos)
                ent:SetAngles(v.angle)
				ent:Spawn()
            end
        end,
        cleanents = {"nz_gummachine"},
    })

    function nzMapping:GobbleGum(pos, ang, ply)
		local ent = ents.Create("nz_gummachine")

		ent:SetPos(pos)
		ent:SetAngles(ang)

		ent:Spawn()

		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion(false)
		end

		if ply then
			undo.Create("GobbleGum")
				undo.SetPlayer(ply)
				undo.AddEntity(ent)
			undo.Finish("Effect (" .. tostring( sound ) .. ")")
		end

		return ent
	end
end



nzTools:CreateTool("bo3gobblegum", {
	displayname = "Gobble Gum Machine Placer",
	desc = "LMB: Apply buildable data, RMB: Remove",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr)
		local ang = tr.HitNormal:Angle()
		nzMapping:GobbleGum(tr.HitPos, Angle(0,(tr.HitPos - ply:GetPos()):Angle()[2] - 180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_gummachine" then
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
	displayname = "Gobble Gum Machine Placer",
	desc = "LMB: Spawn Machine, RMB: Remove",
	icon = "icon16/wrench.png",
	weight = 3,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data, context)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )
		return DProperties
	end,
})