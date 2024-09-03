-- Main Tables
nzAATs = nzAATs or AddNZModule("AATs")
nzAATs.Data = nzAATs.Data or {}

if SERVER then
	hook.Add("OnZombieShot", "NZ.AAT.Activate", function(ent, ply, dmginfo, hitgroup)
		if nzMapping.Settings.aats ~= nil and nzMapping.Settings.aats == 0 then return end
		if not IsValid(ent) or not ent:IsValidZombie() then return end
		if not IsValid(ply) or not ply:IsPlayer() then return end
		local wep = dmginfo:GetInflictor()
		if not IsValid(wep) then return end
		local aat = wep:GetNW2String("nzAATType", "")
		if aat == "" then return end
		if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then return end

		local data = nzAATs:Get(aat)
		if math.Rand(0,1) < (data.chance + (ply.AATChanceBonus or 0)) then
			ply:SetNW2Float("nzAATDecay", CurTime() + 2)
			wep:SetNW2Float("nzAATDelay", CurTime() + (data.cooldown * (ply.AATCooldownMult or 1)))

			local aat = ents.Create(data.ent)
			aat:SetPos(ent:GetPos())
			aat:SetParent(ent)
			aat:SetOwner(ply)
			aat:SetAttacker(ply)
			aat:SetInflictor(wep)
			aat:SetAngles(angle_zero)

			aat:Spawn()

			aat:SetOwner(ply)
			aat.Inflictor = wep
		end
	end)

	hook.Add("OnZombieKilled", "NZ.AAT.Activate", function(ent, dmginfo)
		if nzMapping.Settings.aats ~= nil and nzMapping.Settings.aats == 0 then return end
		if not IsValid(ent) or not ent:IsValidZombie() then return end
		local ply = dmginfo:GetAttacker()
		if not IsValid(ply) or not ply:IsPlayer() then return end
		local wep = dmginfo:GetInflictor()
		if not IsValid(wep) then return end
		local aat = wep:GetNW2String("nzAATType", "")
		if aat == "" then return end
		if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then return end

		local data = nzAATs:Get(aat)
		if math.Rand(0,1) < (data.chance + (ply.AATChanceBonus or 0)) then
			ply:SetNW2Float("nzAATDecay", CurTime() + 2)
			wep:SetNW2Float("nzAATDelay", CurTime() + (data.cooldown * (ply.AATCooldownMult or 1)))

			local aat = ents.Create(data.ent)
			aat:SetPos(ent:GetPos())
			aat:SetParent(ent)
			aat:SetOwner(ply)
			aat:SetAttacker(ply)
			aat:SetInflictor(wep)
			aat:SetAngles(angle_zero)

			aat:Spawn()

			aat:SetOwner(ply)
			aat.Inflictor = wep
		end
	end)
end
