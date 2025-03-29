hook.Add("PlayerPostThink", "nzrGiveDownedPistol", function(ply)
    if !nzSettings:GetSimpleSetting("nzrOnlyPistolDowned", false) then return end
    if ply:Alive() then
        if ply:GetNotDowned() then
            local pc = nzMapping.Settings.startwep
            local wep = ply:GetWeapon(pc)
            if IsValid(wep) and wep.NZIgnorePickup then
                ply:SetActiveWeapon(nil)
                wep:Remove()
                local we = ""
                if IsValid(ply:GetPreviousWeapon()) then
                    we = ply:GetPreviousWeapon():GetClass()
                end
                timer.Simple(0, function()
                    ply:SelectWeapon(we)
                end)
            end
        else
            local pc = nzMapping.Settings.startwep
            local wep = ply:GetWeapon(pc)
            if IsValid(wep) then
                local cur = ply:GetActiveWeapon()
                if !IsValid(cur) or cur:GetClass() != pc and not cur.NZSpecialCategory then
                    ply:SelectWeapon(pc)
                elseif cur:GetClass() == pc then
                    ply:SetUsingSpecialWeapon(false)
                end
            else
                local w = ents.Create(pc)
                w:SetPos(Vector(0,0,-9999))
                w.NZIgnorePickup = true
                w:Spawn()
                ply:PickupWeapon(w)
                ply:SelectWeapon(pc)
            end
        end
    end
end)