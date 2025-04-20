--[[function GM:OnZombieKilled(zombie, dmgInfo)
	local attacker = dmgInfo:GetAttacker()
	if IsValid(attacker) and attacker:IsPlayer() then
		local hitgroup = zombie.LastHitGroup or HITGROUP_GENERIC
		if (hitgroup == HITGROUP_HEAD) or (zombie.GetDecapitated and zombie:GetDecapitated()) then
			attacker:IncrementTotalHeadshots()
		end
		attacker:IncrementTotalKills()
	end
end]]

hook.Add("PlayerRevived", "nzupdateReviveScore", function(ply, revivor)
	if IsValid(revivor) and revivor:IsPlayer() then
		revivor:IncrementTotalRevives()
	end
end )

hook.Add("PlayerDowned", "nzupdateDownedScore", function(ply)
	if IsValid(ply) and ply:IsPlayer() then
		ply:IncrementTotalDowns()
	end
end )
