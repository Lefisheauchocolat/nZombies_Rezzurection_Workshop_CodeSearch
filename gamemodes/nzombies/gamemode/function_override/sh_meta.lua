local playerMeta = FindMetaTable("Player")
local wepMeta = FindMetaTable("Weapon")

if SERVER then
	function ReplaceAimDownSight(wep)
		local oldfire = wep.SecondaryAttack
		if !oldfire then return end
		
		--print("Weapon fire modified")
		
		wep.SecondaryAttack = function(...)
			oldfire(wep, ...)
			-- With deadshot, aim at the head of the entity aimed at
			if wep.Owner:HasPerk("deadshot") then
				local tr = wep.Owner:GetEyeTrace()
				local ent = tr.Entity
				if IsValid(ent) and nzConfig.ValidEnemies[ent:GetClass()] then
					local head = ent:LookupBone("ValveBiped.Bip01_Neck1")
					if head then
						local headpos,headang = ent:GetBonePosition(head)
						wep.Owner:SetEyeAngles((headpos - wep.Owner:GetShootPos()):Angle())
					end
				end
			end
		end
	end
	hook.Add("WeaponEquip", "nzModifyAimDownSights", ReplaceAimDownSight)
	
	local oldsetwep = playerMeta.SetActiveWeapon
	function playerMeta:SetActiveWeapon(wep)
		local oldwep = self:GetActiveWeapon()
		if IsValid(oldwep) and !oldwep:IsSpecial() then
			self.NZPrevWep = oldwep
		end
		oldsetwep(self, wep)
	end
end

local olddefreload = wepMeta.DefaultReload
function wepMeta:DefaultReload(act)
	if IsValid(self.Owner) and self.Owner:HasPerk("speed") then return end
	olddefreload(self, act)
end

local ghosttraceentities = {
	["wall_block"] = true,
	["invis_wall"] = true,
	["invis_wall_zombie"] = true,
	["invis_damage_wall"] = true,
	["player"] = true,
}

function GM:EntityFireBullets(ent, data)

	-- Fire the PaP shooting sound if the weapon is PaP'd
	--print(wep, wep:HasNZModifier("pap"))
	if ent:IsPlayer() then
		local wep = ent:GetActiveWeapon()
		local papsound = tostring(nzSounds.Sounds.Custom.UpgradedShoot[math.random(#nzSounds.Sounds.Custom.UpgradedShoot)])
		if IsValid(wep) and wep:HasNZModifier("pap") and !wep.IsMelee and !wep.IsKnife then
			if papsound then
				ent:EmitSound(papsound, SNDLVL_TALKING, math.random(90,110))
			--[[else
				nzSounds:PlayEnt("UpgradedShoot", ent)]]
			end
		end
	end

	-- Perform a trace that filters out entities from the table above
	--[[local tr = util.TraceLine({
		start = data.Src,
		endpos = data.Src + (data.Dir*data.Distance),
		filter = function(ent2) 
			if ghosttraceentities[ent2:GetClass()] then
				return false
			else
				return true
			end 
		end
	})
	
	--PrintTable(tr)
	
	-- If we hit anything, move the source of the bullets up to that point
	if IsValid(tr.Entity) and tr.Fraction < 1 then
		data.Src = tr.HitPos - data.Dir * 5
		return true
	end]]

	if ent:IsPlayer() and ent:HasPerk("dtap2") then return true end
end

-- Ghost invisible walls so nothing but players or NPCs collide with them
local inviswalls = {
	["invis_damage_wall"] = true,
	["invis_wall"] = true,
	["wall_block"] = true,
}

hook.Add("ShouldCollide", "nz_InvisibleBlockFilter", function(ent1, ent2)
	if inviswalls[ent1:GetClass()] then
		return ent2:IsPlayer() or ent2:IsNPC()
	elseif inviswalls[ent2:GetClass()] then
		return ent1:IsPlayer() or ent1:IsNPC()
	end
end)

-- This is so awkward ._.
-- game.AddAmmoType doesn't take duplicates into account and has a hardcoded limit of 128
-- which means our ammo types won't exist if we pass that limit with the countless duplicates :(
local oldaddammo = game.AddAmmoType
local alreadyexist = alreadyexist or {}
function game.AddAmmoType( tbl ) -- Let's prevent that!
	if tbl.name and !alreadyexist[tbl.name] then -- Only if the ammo doesn't already exist!
		oldaddammo(tbl) -- THEN we can proceed with normal procedure!
		alreadyexist[tbl.name] = true
	end
end
-- This doesn't work for lua scripts run before the gamemode, but should help for weapons adding ammo types on-the-fly!
-- This will also prevent some ammo types from being added - that's fine. Our gamemode doesn't need them.