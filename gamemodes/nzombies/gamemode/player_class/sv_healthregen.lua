
local RegenRate = 0.05
local RegenRatio = 0.1

local RegenDelay = 5
local RegenDelayFast = 3

local playerMeta = FindMetaTable("Player")

function playerMeta:GetRegenDelay()
	local regendelay = self.RegenOverride or (nzMapping.Settings.healthregendelay or RegenDelay)
	if self:HasPerk("revive") then
		regendelay = regendelay*0.6
	end

	return regendelay
end

hook.Add("Think", "nzRegenHealth", function() //values and code taken from from _zm_playerhealth.gsc in bo2
	local curtime = CurTime()
	for _, ply in pairs(player.GetAll()) do
		if not ply:Alive() or not ply:GetNotDowned() then continue end
		if ply:Health() >= ply:GetMaxHealth() then continue end

		local health_ratio = ply:Health() / ply:GetMaxHealth()
		local delay = ply:GetRegenDelay()

		if (!ply.lastregen or curtime > ply.lastregen + (nzMapping.Settings.healthregenrate or RegenRate)) and (!ply.lasthit or curtime > ply.lasthit + delay) then
			ply.lastregen = curtime

			local newhealth = health_ratio + (nzMapping.Settings.healthregenratio or RegenRatio)
			ply:SetHealth(math.Clamp(math.Round(ply:GetMaxHealth() * newhealth), 0, ply:GetMaxHealth()))
			continue
		end
	end
end)
