
local RegenRate = 0.05
local RegenRatio = 0.1

local RegenDelay = 4
local RegenDelayFast = 2.5

hook.Add("Think", "nzRegenHealth", function() //values and code taken from from _zm_playerhealth.gsc in bo2
	local curtime = CurTime()
	for _, ply in pairs(player.GetAll()) do
		if not ply:Alive() or not ply:GetNotDowned() then continue end
		if ply:Health() >= ply:GetMaxHealth() then continue end

		local health_ratio = math.Round(ply:Health() / ply:GetMaxHealth(), 1)
		local delay = ply:HasPerk("revive") and RegenDelayFast or RegenDelay

		if (!ply.lastregen or curtime > ply.lastregen + RegenRate) and (!ply.lasthit or curtime > ply.lasthit + delay) then
			ply.lastregen = curtime

			local newhealth = health_ratio + RegenRatio
			ply:SetHealth(math.Clamp(math.Round(ply:GetMaxHealth() * newhealth), 0, ply:GetMaxHealth()))
			continue
		end
	end
end)
