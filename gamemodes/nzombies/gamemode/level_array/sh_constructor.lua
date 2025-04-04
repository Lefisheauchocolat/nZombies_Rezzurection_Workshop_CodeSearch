
nzLevel = nzLevel or AddNZModule("Level")

nzLevel.TriggerCache = nzLevel.TriggerCache or {}
nzLevel.ToggleCache = nzLevel.ToggleCache or {}
nzLevel.ZombieCache = nzLevel.ZombieCache or {}
nzLevel.ZBossCache = nzLevel.ZBossCache or {}
nzLevel.ShieldCache = nzLevel.ShieldCache or {}
nzLevel.CreativeCache = nzLevel.CreativeCache or {}
nzLevel.VultureCache = nzLevel.VultureCache or {}
nzLevel.BarricadeCache = nzLevel.BarricadeCache or {}
nzLevel.JumpTravCache = nzLevel.JumpTravCache or {}
nzLevel.TargetCache = nzLevel.TargetCache or {}
nzLevel.HudEntityCache = nzLevel.HudEntityCache or {}
nzLevel.BrutusEntityCache = nzLevel.BrutusEntityCache or {}
nzLevel.GrenadeCache = nzLevel.GrenadeCache or {}
nzLevel.SpecialGrenadeCache = nzLevel.SpecialGrenadeCache or {}
nzLevel.PowerUpsCache = nzLevel.PowerUpsCache or {}

nzLevel.HudEntityClass = nzLevel.HudEntityClass or {}
nzLevel.BrutusEntityClass = nzLevel.BrutusEntityClass or {}
nzLevel.ToggleClass = nzLevel.ToggleClass or {}
nzLevel.ShieldClass = nzLevel.ShieldClass or {}
nzLevel.GrenadeClass = nzLevel.GrenadeClass or {}
nzLevel.SpecialGrenadeClass = nzLevel.SpecialGrenadeClass or {}

nzLevel.PSpawnCache = nzLevel.PSpawnCache or {}
nzLevel.ZSpawnCache = nzLevel.ZSpawnCache or {}
nzLevel.ESpawnCache = nzLevel.ESpawnCache or {}
nzLevel.SSpawnCache = nzLevel.SSpawnCache or {}
nzLevel.ENVSpawnCache = nzLevel.ENVSpawnCache or {}

local inext = ipairs({})

local string_find = string.find

local zspawnerclasses = {
	["nz_spawn_zombie"] = true,
	["nz_spawn_zombie_boss"] = true,
	["nz_spawn_zombie_extra1"] = true,
	["nz_spawn_zombie_extra2"] = true,
	["nz_spawn_zombie_extra3"] = true,
	["nz_spawn_zombie_extra4"] = true,
	["nz_spawn_zombie_normal"] = true,
	["nz_spawn_zombie_special"] = true,
}

local espawnerclasses = {
	["nz_spawn_zombie_extra1"] = true,
	["nz_spawn_zombie_extra2"] = true,
	["nz_spawn_zombie_extra3"] = true,
	["nz_spawn_zombie_extra4"] = true,
}

local sspawnerclasses = {
	["nz_spawn_zombie_special"] = true,
}

local envspawnerclasses = {
	["nz_spawn_zombie_vign"] = true,
}

local barricadeclasses = {
	["breakable_entry"] = true,
}

local scripttriggers = {
	["nz_script_triggerzone"] = true,
}

hook.Add("PreRegisterSENT", "nzLevel.SHENT", function(ent, class)
	if ent.NZThrowIcon or ent.NZNadeRethrow then
		nzLevel.HudEntityClass[class] = true
	end
	if ent.bIsShield then
		nzLevel.ShieldClass[class] = true
	end
	if (ent.TurnOff and ent.TurnOn) then
		nzLevel.ToggleClass[class] = true
	end
	if ent.BrutusDestructable then
		nzLevel.BrutusEntityClass[class] = true
	end
end)

hook.Add("OnEntityCreated", "nzLevel.Iterator", function(ent)
	local class = ent:GetClass()

	if SERVER and ent:IsValidZombie() and !ent.IsENVZombie then
		SetGlobal2Int("AliveZombies", GetGlobal2Int("AliveZombies", 0) + 1)
	end

	timer.Simple(engine.TickInterval(), function()
		if not IsValid(ent) then return end
		if ent:IsValidZombie() and !ent.IsENVZombie then
			if ent.NZBossType or string.find(class, "zombie_boss") then
				table.insert(nzLevel.ZBossCache, ent)
			else
				table.insert(nzLevel.ZombieCache, ent)
			end
		end
	end)

	if IsValid(ent) then
		if SERVER and nzLevel.GrenadeClass[class] then
			timer.Simple(engine.TickInterval(), function()
				if not IsValid(ent) then return end
				local ply = ent:GetOwner()
				if not IsValid(ply) or not ply:IsPlayer() then return end
				if not ply:HasPerk("mask") then return end

				ent:CallOnRemove("mask_gasnade"..ent:EntIndex(), function(old)
					if old.NadeRethrown then return end

					local ply = old:GetOwner()
					local tr = util.QuickTrace(old:GetPos(), vector_up*-1024, old)
					if IsValid(ply) and tr.Hit then
						local wep = (old.Inflictor and IsValid(old.Inflictor)) and old.Inflictor or ply:GetActiveWeapon()
						if ply.NZSpecialWeapons and ply.NZSpecialWeapons["grenade"] then
							wep = ply.NZSpecialWeapons["grenade"]
						end

						local gas = ents.Create("mask_toxic_effect")
						gas:SetPos(tr.HitPos)
						gas:SetOwner(ply)
						gas:SetAttacker(ply)
						gas:SetInflictor(wep)
						gas:SetAngles(angle_zero)

						gas:Spawn()

						gas:SetOwner(ply)
						gas.Inflictor = wep
					end
				end)
			end)
		end

		if nzLevel.HudEntityClass[class] then
			table.insert(nzLevel.HudEntityCache, ent)
		end
		if nzLevel.ShieldClass[class] then
			table.insert(nzLevel.ShieldCache, ent)
		end
		if nzLevel.ToggleClass[class] then
			table.insert(nzLevel.ToggleCache, ent)
		end
		if nzLevel.BrutusEntityClass[class] then
			table.insert(nzLevel.BrutusEntityCache, ent)
		end
		if nzPerks.VultureClass[class] then
			table.insert(nzLevel.VultureCache, ent)
		end

		if class == "drop_powerup" then
			table.insert(nzLevel.PowerUpsCache, ent)
		end
		if class == "jumptrav_block" then
			table.insert(nzLevel.JumpTravCache, ent)
		end
		if class == "player_spawns" then
			table.insert(nzLevel.PSpawnCache, ent)
		end

		if scripttriggers[class] then
			table.insert(nzLevel.TriggerCache, ent)
		end
		if barricadeclasses[class] then
			table.insert(nzLevel.BarricadeCache, ent)
		end
		if zspawnerclasses[class] then
			table.insert(nzLevel.ZSpawnCache, ent)
		end
		if espawnerclasses[class] then
			table.insert(nzLevel.ESpawnCache, ent)
		end
		if sspawnerclasses[class] then
			table.insert(nzLevel.SSpawnCache, ent)
		end
		if envspawnerclasses[class] then
			table.insert(nzLevel.ENVSpawnCache, ent)
		end
	end
end)

if SERVER then
	hook.Add("OnZombieKilled", "nzLevel.ZedCounter", function(ent)
		if ent:IsValidZombie() and not ent.ZedKillCounted then
			ent.ZedKillCounted = true
			SetGlobal2Int("AliveZombies", math.max(GetGlobal2Int("AliveZombies", 0) - 1), 0)
		end
	end)
end

hook.Add("EntityRemoved", "nzLevel.Iterator", function(ent)
	local class = ent:GetClass()

	if SERVER and ent:IsValidZombie() and not ent.ZedKillCounted then
		SetGlobal2Int("AliveZombies", math.max(GetGlobal2Int("AliveZombies", 0) - 1, 0))
	end

	if (ent.TurnOff and ent.TurnOn) then
		for i = 1, #nzLevel.ToggleCache do
			if nzLevel.ToggleCache[i] == ent then
				table.remove(nzLevel.ToggleCache, i)
				break
			end
		end
	end

	if ent.NZThrowIcon or ent.NZNadeRethrow then
		for i = 1, #nzLevel.HudEntityCache do
			if nzLevel.HudEntityCache[i] == ent then
				table.remove(nzLevel.HudEntityCache, i)
				break
			end
		end
	end

	if ent.BrutusDestructable then
		for i = 1, #nzLevel.BrutusEntityCache do
			if nzLevel.BrutusEntityCache[i] == ent then
				table.remove(nzLevel.BrutusEntityCache, i)
				break
			end
		end
	end

	if ent:IsValidZombie() then
		if ent.NZBossType or string.find(class, "zombie_boss") then
			for i = 1, #nzLevel.ZBossCache do
				if nzLevel.ZBossCache[i] == ent then
					table.remove(nzLevel.ZBossCache, i)
					break
				end
			end
		else
			for i = 1, #nzLevel.ZombieCache do
				if nzLevel.ZombieCache[i] == ent then
					table.remove(nzLevel.ZombieCache, i)
					break
				end
			end
		end
	end

	if nzPerks.VultureClass[class] then
		for i = 1, #nzLevel.VultureCache do
			if nzLevel.VultureCache[i] == ent then
				table.remove(nzLevel.VultureCache, i)
				break
			end
		end
	end

	if ent.bIsShield then
		for i = 1, #nzLevel.ShieldCache do
			if nzLevel.ShieldCache[i] == ent then
				table.remove(nzLevel.ShieldCache, i)
				break
			end
		end
	end

	if barricadeclasses[class] then
		for i = 1, #nzLevel.BarricadeCache do
			if nzLevel.BarricadeCache[i] == ent then
				table.remove(nzLevel.BarricadeCache, i)
				break
			end
		end
	end

	if class == "drop_powerup" then
		for i = 1, #nzLevel.PowerUpsCache do
			if nzLevel.PowerUpsCache[i] == ent then
				table.remove(nzLevel.PowerUpsCache, i)
				break
			end
		end
	end

	if class == "jumptrav_block" then
		for i = 1, #nzLevel.JumpTravCache do
			if nzLevel.JumpTravCache[i] == ent then
				table.remove(nzLevel.JumpTravCache, i)
				break
			end
		end
	end

	if class == "player_spawns" then
		for i = 1, #nzLevel.PSpawnCache do
			if nzLevel.PSpawnCache[i] == ent then
				table.remove(nzLevel.PSpawnCache, i)
				break
			end
		end
	end

	if zspawnerclasses[class] then
		for i = 1, #nzLevel.ZSpawnCache do
			if nzLevel.ZSpawnCache[i] == ent then
				table.remove(nzLevel.ZSpawnCache, i)
				break
			end
		end
	end
	if espawnerclasses[class] then
		for i = 1, #nzLevel.ESpawnCache do
			if nzLevel.ESpawnCache[i] == ent then
				table.remove(nzLevel.ESpawnCache, i)
				break
			end
		end
	end
	if sspawnerclasses[class] then
		for i = 1, #nzLevel.SSpawnCache do
			if nzLevel.SSpawnCache[i] == ent then
				table.remove(nzLevel.SSpawnCache, i)
				break
			end
		end
	end
	if envspawnerclasses[class] then
		for i = 1, #nzLevel.ENVSpawnCache do
			if nzLevel.ENVSpawnCache[i] == ent then
				table.remove(nzLevel.ENVSpawnCache, i)
				break
			end
		end
	end

	if scripttriggers[class] then
		for i = 1, #nzLevel.TriggerCache do
			if nzLevel.TriggerCache[i] == ent then
				table.remove(nzLevel.TriggerCache, i)
				break
			end
		end
	end

	if ent:GetTargetPriority() then
		for i = 1, #nzLevel.TargetCache do
			if nzLevel.TargetCache[i] == ent then
				table.remove(nzLevel.TargetCache, i)
				break
			end
		end
	end
end)

//vulture specific
if SERVER then
	util.AddNetworkString("nzUpdateVultureArray")

	function nzLevel:UpdateVultureArray(ent, reciever)
		if not IsValid(ent) then return end

		net.Start("nzUpdateVultureArray")
			net.WriteEntity(ent)
		return reciever and net.Send(reciever) or net.Broadcast()
	end

	FullSyncModules["nzLevel"] = function(ply)
		for _, ent in pairs(nzLevel.VultureCache) do
			nzLevel:UpdateVultureArray(ent, ply)
		end
	end
end

if CLIENT then
	local function RecieveVultureArrayUpdate( length )
		local ent = net.ReadEntity()
		if not table.HasValue(nzLevel.VultureCache, ent) then
			table.insert(nzLevel.VultureCache, ent)
		end
	end

	net.Receive("nzUpdateVultureArray", RecieveVultureArrayUpdate)
end

function nzLevel.GetVultureArray()
	return inext, nzLevel.VultureCache, 0
end

function nzLevel.GetZombieArray()
	return inext, nzLevel.ZombieCache, 0
end

function nzLevel.GetZombieBossArray()
	return inext, nzLevel.ZBossCache, 0
end

function nzLevel.GetPlayerSpawnArray()
	return inext, nzLevel.PSpawnCache, 0
end

function nzLevel.GetZombieSpawnArray()
	return inext, nzLevel.ZSpawnCache, 0
end

function nzLevel.GetExtraSpawnArray()
	return inext, nzLevel.ESpawnCache, 0
end

function nzLevel.GetSpecialSpawnArray()
	return inext, nzLevel.SSpawnCache, 0
end

function nzLevel.GetVignetteSpawnArray()
	return inext, nzLevel.ENVSpawnCache, 0
end

function nzLevel.GetTurnOnTurnOffArray()
	return inext, nzLevel.ToggleCache, 0
end

function nzLevel.GetPlayerShieldArray()
	return inext, nzLevel.ShieldCache, 0
end

function nzLevel.GetTriggerZoneArray()
	return inext, nzLevel.TriggerCache, 0
end

function nzLevel.GetBarricadeArray()
	return inext, nzLevel.BarricadeCache, 0
end

function nzLevel.GetPowerUpsArray()
	return inext, nzLevel.PowerUpsCache, 0
end

function nzLevel.GetJumpTravArray()
	return inext, nzLevel.JumpTravCache, 0
end

function nzLevel.GetTargetableArray()
	return inext, nzLevel.TargetCache, 0
end

function nzLevel.GetHudEntityArray()
	return inext, nzLevel.HudEntityCache, 0
end

function nzLevel.GetBrutusEntityArray()
	return inext, nzLevel.BrutusEntityCache, 0
end