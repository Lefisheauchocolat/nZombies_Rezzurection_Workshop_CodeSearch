local WeaponModificationFunctions = {}
local WeaponModificationFunctionsDefaults = {}
local WeaponModificationRevertDefaults = {}

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

if GetConVar("nz_tfa_attachments") == nil then
	CreateReplConVar("nz_tfa_attachments", "0", "VERY FUCKED! enable at your own risk! some attachments (typically ones that change magazine size, or animations) are broken!")
end
local cvar_tfaattachments = GetConVar("nz_tfa_attachments")

-- These work by modifying weapons in a special way - they are called via ApplyWeaponModifier with the event being the type of modification
-- "speed" = Applied to all weapons when Speed Cola is owned
-- "dtap" = Applied to all weapons when Double Tap 1 or 2 is owned
-- "pap" = Applied on Pack-a-Punch
-- "repap" = Applied on Pack-a-Punching again; this is not saved as a modifier, so it can run again and again
-- "equip" = Applied when weapon is equipped; doesn't have any restoration

-- Any other custom event can be used with weapon:ApplyNZModifier(event)

function nzWeps:AddWeaponModification(id, event, condition, apply, revert, reapply)
	if !WeaponModificationFunctions[event] then WeaponModificationFunctions[event] = {} end
	
	WeaponModificationFunctions[event][id] = {
		condition = condition, -- Condition is checked on both revert and apply
		apply = apply, -- Applies changes, all changes are restored when reverted automatically
		revert = revert, -- If you need some special revert function, this is optional
		reapply = reapply -- If modification should run again after weapon is pack a punch'ed
	}
end

function nzWeps:RemoveWeaponModification(id, event)
	if !WeaponModificationFunctions[event] then return end
	WeaponModificationFunctions[event][id] = nil
end

local cvar_dev = GetConVar("developer")

local wepmeta = FindMetaTable("Weapon")
if !wepmeta then return end

local function RecursiveDifferenceCheck(tbl1, tbl2)
	local diffs = {}

	for k, v in pairs(tbl1) do
		if tbl2 and v != tbl2[k] then
			if v == nil then //the sin
				diffs[k] = "nil"
			elseif type(v) == "table" then
				local t = RecursiveDifferenceCheck(v, tbl2[k])
				if table.Count(t) > 0 then
					diffs[k] = t
				end
			else
				diffs[k] = v
			end
		end
	end

	if tbl2 then
		for k, v in pairs(tbl2) do
			if v and tbl1[k] == nil then
				diffs[k] = "nil"
			end
		end
	end

	return diffs
end

function wepmeta:ApplyDefaultNZModifier(modifier)
	if WeaponModificationFunctionsDefaults[modifier] then
		WeaponModificationFunctionsDefaults[modifier](self)
	end
end

function wepmeta:ApplyNZModifier(modifier, blocknetwork)
	if self:HasNZModifier(modifier) then return end

	if WeaponModificationFunctions and WeaponModificationFunctions[modifier] then
		local oldversion = table.Copy(self:GetTable()) -- We'll kill our selves later
		local modded = false

		if self.NZModifierAdd and !self:NZModifierAdd(modifier) then
			modded = true
		end

		local oldmods = {}
		if !modded then
			if modifier == "pap" and self.OnPaP then
				//this is awful, but it works (probably not)
				for k, data in pairs(WeaponModificationFunctions) do
					for _, tab in pairs(data) do
						if self:HasNZModifier(k) and tab.reapply and tab.condition(self) then
							self:RevertNZModifier(k, true)
							oldmods[k] = true
						end
					end
				end

				self:OnPaP()
				modded = true

				for k, data in pairs(WeaponModificationFunctions) do
					for _, tab in pairs(data) do
						if tab.reapply and tab.condition(self) and oldmods[k] then
							self:ApplyNZModifier(k, true)
						end
					end
				end

				if SERVER and not self.NoSpawnAmmo then
					self:GiveMaxAmmo()
				end
			elseif modifier == "repap" and self.OnRePaP then
				for k, data in pairs(WeaponModificationFunctions) do
					for _, tab in pairs(data) do
						if tab.reapply and tab.condition(self) and self:HasNZModifier(k) then
							self:RevertNZModifier(k, true)
							oldmods[k] = true
						end
					end
				end

				self:OnRePaP()
				if nzMapping.Settings.aats ~= nil and nzMapping.Settings.aats < 2 then
					modded = true
				end

				for k, data in pairs(WeaponModificationFunctions) do
					for _, tab in pairs(data) do
						if tab.reapply and tab.condition(self) and oldmods[k] then
							self:ApplyNZModifier(k, true)
						end
					end
				end

				if SERVER and not self.NoSpawnAmmo then
					self:GiveMaxAmmo()
				end
			end
		end

		if !modded then
			for k,v in pairs(WeaponModificationFunctions[modifier]) do
				if v.condition(self) then
					if !v.apply(self) then
						modded = true
						break
					end
				end
			end
		end

		if !modded then
			self:ApplyDefaultNZModifier(modifier)
		end

		if SERVER and !blocknetwork then
			nzWeps:SendSync(self.Owner, self, modifier, false)
			if modifier == "pap" then //3p
				nzCamos:Generate3pCamo(self.Owner, self)
			end
		end
		if CLIENT and modifier == "pap" and LocalPlayer() == self.Owner then
			net.Start("nzCamos.Request") //fp
				net.WriteEntity(self)
			net.SendToServer()
		end

		if !self.NZModifiers then self.NZModifiers = {} end
		if modifier != "repap" and modifier != "equip" then self.NZModifiers[modifier] = RecursiveDifferenceCheck(oldversion, self:GetTable()) end //hehe killyourself
	else
		print("Tried to apply invalid modifier "..modifier.." to weapon "..tostring(self))
	end
end

function wepmeta:RevertNZModifier(modifier, blocknetwork)
	if self.IsTFAWeapon then
		self:RevertNZModifier_TFA(modifier, blocknetwork)
		return
	end

	if WeaponModificationFunctions and WeaponModificationFunctions[modifier] then
		if (!istable(self.NZModifiers) or istable(self.NZModifiers) and table.IsEmpty(self.NZModifiers)) then return end
		local olds = self.NZModifiers[modifier]

		if olds then
			for k,v in pairs(olds) do
				self[k] = v
			end
		end

		for k,v in pairs(WeaponModificationFunctions[modifier]) do
			if v.revert and v.condition(self) then
				v.revert(self)
			end
		end
		if WeaponModificationRevertDefaults[modifier] then WeaponModificationRevertDefaults[modifier](self) end

		if SERVER and !blocknetwork then
			nzWeps:SendSync(self.Owner, self, modifier, true)
		end


		if !self.NZModifiers then self.NZModifiers = {} end
		self.NZModifiers[modifier] = nil
	else
		print("Tried to revert invalid modifier "..modifier.." to weapon "..tostring(self))
	end
end

function wepmeta:RevertNZModifier_TFA(modifier, blocknetwork)
	if WeaponModificationFunctions and WeaponModificationFunctions[modifier] then
		if (!istable(self.NZModifiers) or istable(self.NZModifiers) and table.IsEmpty(self.NZModifiers)) then return end
		local olds = self.NZModifiers[modifier]

		if olds then
			for k, v in pairs(olds) do -- Shoot me in the head!
				if v == "nil" then //that time i got sent directly to hell for writing ungodly code
					self[k] = nil
					self:ClearStatCache(k)
				elseif type(v) == "table" then
					for stat, val in pairs(v) do
						if val == "nil" then
							self[k][stat] = nil

							if string.find("Primary_TFA", k) then
								self:ClearStatCache("Primary."..stat)
							end
							if string.find("Secondary_TFA", k) then
								self:ClearStatCache("Secondary."..stat)
							end
						else
							self[k][stat] = val

							if string.find("Primary_TFA", k) then
								self:ClearStatCache("Primary."..stat)
							end
							if string.find("Secondary_TFA", k) then
								self:ClearStatCache("Secondary."..stat)
							end
						end
					end
				else
					self[k] = v
					self:ClearStatCache(k)
				end
			end

			if self.NZStoredRPM then
				self.Primary_TFA.RPM = self.NZStoredRPM
				self:ClearStatCache("Primary.RPM")
			end
			if self.NZStoredRPM2 then
				self.Secondary_TFA.RPM = self.NZStoredRPM2
				self:ClearStatCache("Secondary.RPM")
			end
		end

		for k,v in pairs(WeaponModificationFunctions[modifier]) do
			if v.revert and v.condition(self) then
				v.revert(self)
			end
		end
		if WeaponModificationRevertDefaults[modifier] then WeaponModificationRevertDefaults[modifier](self) end

		if SERVER and !blocknetwork then
			nzWeps:SendSync(self.Owner, self, modifier, true)
		end

		if !self.NZModifiers then self.NZModifiers = {} end
		self.NZModifiers[modifier] = nil
	else
		print("Tried to revert invalid modifier "..modifier.." to weapon "..tostring(self))
	end
end

function wepmeta:HasNZModifier(id)
	if self.NZModifiers == nil then return false end
	if !self.NZModifiers then return false end
	return self.NZModifiers[id] and true or false
end

nzWeps:AddWeaponModification("staminup_tfa", "staminup", function(wep) return wep.IsTFAWeapon end, function(wep)
	local ply = wep:GetOwner()

	wep.MoveSpeed = 1
	wep.IronSightsMoveSpeed = math.max(wep.IronSightsMoveSpeed, 0.8)

	wep:ClearStatCache("MoveSpeed")
	wep:ClearStatCache("IronSightsMoveSpeed")
end, nil, true)

nzWeps:AddWeaponModification("deadshot_tfa", "deadshot", function(wep) return wep.IsTFAWeapon end, function(wep)
	if not wep.NZSpecialCategory and wep:GetMuzzleAttachment() then
		/*if SERVER then //no worky, look bad :(
			TFA.Effects.Create("tfa_deadshot_laser", EffectData())
		end*/

		wep.LaserDistance = 1024
		wep.LaserDistanceVisual = 64
		wep.LaserBeamWidth = 1
		wep.LaserSightAttachment = wep:GetMuzzleAttachment()
		wep.LaserSightAttachmentWorld = wep:GetMuzzleAttachment()
	end

	wep.IronSightTime = wep.IronSightTime * 0.5
	wep.IronRecoilMultiplier = wep.IronRecoilMultiplier * 0.5

	wep.Primary_TFA.Spread = wep.Primary_TFA.Spread * 0.5
	wep.Primary_TFA.IronAccuracy = wep.Primary_TFA.IronAccuracy * 0.5

	wep.ChangeStateAccuracyMultiplier = 1
	wep.JumpAccuracyMultiplier = 1
	wep.WalkAccuracyMultiplier = 1

	wep:ClearStatCache("IronSightTime")
	wep:ClearStatCache("IronRecoilMultiplier")

	wep:ClearStatCache("Primary.Spread")
	wep:ClearStatCache("Primary.IronAccuracy")

	wep:ClearStatCache("ChangeStateAccuracyMultiplier")
	wep:ClearStatCache("JumpAccuracyMultiplier")
	wep:ClearStatCache("WalkAccuracyMultiplier")
end, nil, true)

nzWeps:AddWeaponModification("vigor_tfa", "vigor", function(wep) return wep.IsTFAWeapon end, function(wep)
	if not wep.Primary_TFA.Projectile then
		local ply = wep:GetOwner()

		--wep.Primary_TFA.DamageType = bit.bor(wep.Primary_TFA.DamageType, DMG_BLAST)
		wep.Primary_TFA.Damage = wep.Primary_TFA.Damage * (ply:HasUpgrade("vigor") and 3 or 2)
		--wep.Primary_TFA.BlastRadius = 32
		wep.Primary_TFA.ImpactEffect = "MetalSpark"

		--wep:ClearStatCache("Primary.DamageType")
		wep:ClearStatCache("Primary.Damage")
		--wep:ClearStatCache("Primary.BlastRadius")
		wep:ClearStatCache("Primary.ImpactEffect")
	end
end, nil, true)

nzWeps:AddWeaponModification("dtap2_tfa", "dtap2", function(wep) return wep.IsTFAWeapon end, function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) then return end

	local rate = 1.1
	if ply:HasPerk("dtap") then
		rate = 1.3
	end
	if ply:HasUpgrade("dtap") then
		rate = 1.6
	end

	if wep.Primary_TFA.RPM then
		if not wep.NZStoredRPM then
			wep.NZStoredRPM = wep.Primary_TFA.RPM
		end

		wep.Primary_TFA.RPM = math.floor(wep.NZStoredRPM * rate)
		wep:ClearStatCache("Primary.RPM")

		wep.Primary_TFA.RPM_Displayed = (wep.Primary_TFA.RPM_Displayed or wep.NZStoredRPM) * rate
		wep:ClearStatCache("Primary.RPM_Displayed")
	end

	if wep.Secondary_TFA.RPM then
		if not wep.NZStoredRPM2 then
			wep.NZStoredRPM2 = wep.Secondary_TFA.RPM
		end

		wep.Secondary_TFA.RPM = math.floor(wep.NZStoredRPM2 * rate)
		wep:ClearStatCache("Secondary.RPM")
	end

	if wep.Primary_TFA.NumShots >= 1 and not wep.NZSpecialCategory and (ply:HasUpgrade("dtap2") or (not wep.Primary.Projectile)) then
		wep.Primary_TFA.NumShots = math.Clamp(math.floor(wep.Primary_TFA.NumShots * 2), 2 ,math.Max(wep.Primary_TFA.NumShots, 24)) //limiting numshots to 24 unless base is higher
		wep:ClearStatCache("Primary.NumShots")
	end
end, nil, true)

nzWeps:AddWeaponModification("dtap_tfa", "dtap", function(wep) return wep.IsTFAWeapon end, function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) then return end

	local rate = 1.3
	if ply:HasUpgrade("dtap") then
		rate = 1.6
	end

	if wep.Primary_TFA.RPM then
		if not wep.NZStoredRPM then
			wep.NZStoredRPM = wep.Primary_TFA.RPM
		end

		wep.Primary_TFA.RPM = math.floor(wep.NZStoredRPM * rate)
		wep:ClearStatCache("Primary.RPM")

		wep.Primary_TFA.RPM_Displayed = (wep.Primary_TFA.RPM_Displayed or wep.NZStoredRPM) * rate
		wep:ClearStatCache("Primary.RPM_Displayed")
	end

	if wep.Secondary_TFA.RPM then
		if not wep.NZStoredRPM2 then
			wep.NZStoredRPM2 = wep.Secondary_TFA.RPM
		end

		wep.Secondary_TFA.RPM = math.floor(wep.NZStoredRPM2 * rate)
		wep:ClearStatCache("Secondary.RPM")
	end
end, nil, true)

nzWeps:AddWeaponModification("speed_tfa", "speed", function(wep) return wep.IsTFAWeapon end, function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) then return end

	if ply:HasUpgrade("speed") and (wep.LoopedReload or wep.Shotgun) then
		local clipsize = wep:GetStatL("Primary.ClipSize") or wep.Primary_TFA.ClipSize
		if clipsize > 0 then
			wep.LoopedReloadInsertAmount = clipsize
			wep:ClearStatCache("LoopedReloadInsertAmount")
		end
	end
end, nil, true)

nzWeps:AddWeaponModification("candolier_tfa", "candolier", function(wep) return wep.IsTFAWeapon end, function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) then return end

	local invalid_ammo = {
		["nil"] = true,
		["none"] = true,
		["null"] = true,
		[""] = true
	}

	local ammo = wep:GetStatL("Primary.MaxAmmo") or wep.Primary_TFA.MaxAmmo or wep.Primary.MaxAmmo
	if !ammo or ammo >= 700 then return end

	local clipsize = wep:GetStatL("Primary.ClipSize") or wep.Primary_TFA.ClipSize
	if !clipsize or clipsize <= 0 then
		clipsize = wep:GetStatL("Primary.DefaultClip") or wep.Primary_TFA.DefaultClip
		clipsize = math.max(clipsize, math.min(clipsize*2, 700))

		wep.Primary.DefaultClip = clipsize
		wep.Primary_TFA.DefaultClip = clipsize
		wep:ClearStatCache("Primary.DefaultClip")

		wep.Primary.MaxAmmo = clipsize
		wep.Primary_TFA.MaxAmmo = clipsize
		wep:ClearStatCache("Primary.MaxAmmo")
	else
		local amount = clipsize*2

		local ammotype = wep:GetStatL("Primary.Ammo") or wep.Primary_TFA.Ammo
		if (!ammotype or invalid_ammo[ammotype] or game.GetAmmoID(ammotype) < 0) then
			if clipsize and clipsize > 0 then
				wep.Primary.ClipSize = math.max(wep.Primary.ClipSize, math.min(amount, 700))
				wep.Primary_TFA.ClipSize = math.max(wep.Primary_TFA.ClipSize, math.min(amount, 700))
				wep:ClearStatCache("Primary.ClipSize")

				wep.Primary.DefaultClip = wep.Primary_TFA.ClipSize
				wep.Primary_TFA.DefaultClip = wep.Primary_TFA.ClipSize
				wep:ClearStatCache("Primary.DefaultClip")
			end

			wep.Primary.MaxAmmo = math.max(ammo, math.min(amount, 700))
			wep.Primary_TFA.MaxAmmo = math.max(ammo, math.min(amount, 700))
			wep:ClearStatCache("Primary.MaxAmmo")
		else
			wep.Primary.MaxAmmo = math.max(ammo, math.min(ammo + amount, 700))
			wep.Primary_TFA.MaxAmmo = math.max(ammo, math.min(ammo + amount, 700))
			wep:ClearStatCache("Primary.MaxAmmo")
		end
	end
end, nil, true)

nzWeps:AddWeaponModification("tfa_attachmentmod", "equip", function(wep) return wep.IsTFAWeapon end, function(wep)
	if SERVER then
		//owner is valid next tick
		timer.Simple(0, function()
			if !IsValid(wep) then return end
			local ply = wep:GetOwner()
			if !IsValid(ply) then return end

			local gum = nzGum:GetActiveGumData(ply)
			if gum and gum.modifier and !nzGum:IsUseBaseGum(ply) then
				nzGum:ApplyGumModifier(ply, wep)
			end
		end)
	end

	wep.CanAttach = function()
		return cvar_tfaattachments:GetBool()
	end
end)

local cond = function(wep)
	return SERVER and wep.IsTFAWeapon and GetConVar("nz_papattachments"):GetBool()
end

local atts = function(wep)
	if wep.Attachments then
		for k,v in pairs(wep.Attachments) do
			if v.header and string.lower(v.header) != "magazine" and string.lower(v.header) != "mag" then -- Mag can't be edited
				wep:SetTFAAttachment(k, math.random(table.Count(v.atts)), true)
			end
		end
	end
	return true
end

nzWeps:AddWeaponModification("pap_tfa_attachments", "pap", cond, atts)
nzWeps:AddWeaponModification("pap_tfa_attachments", "repap", cond, atts)

//aats
nzWeps:AddWeaponModification("repap_aat", "repap", function(wep) return wep.IsTFAWeapon end, function(wep)
	if CLIENT then return end
	wep:RandomizeAAT()
end)
