local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_melee_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.trap"
SWEP.Purpose = "Custom melee weapon, animated by SajeOne(?). \nFrom the W@W map 'UGX Requiem' by Treminator"
SWEP.Author = "Treminator, SajeOne, FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Axe | WAW" or "Axe"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/ugxaxe/c_ugxaxe.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/ugxaxe/w_ugxaxe.mdl"
SWEP.HoldType = "melee2"
SWEP.SprintHoldTypeOverride = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 6, 1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -9,
		Right = 2.2,
		Forward = 5.4,
	},
	Ang = {
		Up = -200,
		Right = -190,
		Forward = 0
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_AXE.Swing"
SWEP.Primary.Sound_Hit = "TFA_BO2_RAKETRAP.Hit"
SWEP.Primary.Sound_HitFlesh = "TFA_BO3_GENERIC.Gib"
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_SLASH)
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 115
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 115
SWEP.Secondary.MaxCombo = 0
SWEP.Secondary.Automatic = false
SWEP.Delay = 0.35

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.AmmoConsumption = 0
SWEP.Primary.Ammo = "none"

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 70, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, -5, -60), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 35 / 45, --Delay
		["snd_delay"] = 30 / 45, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 8, --Hullsize
	}
}

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(6, -2, -2)
SWEP.InspectAng = Vector(5, 25, 15)
SWEP.Secondary.CanBash = false
SWEP.AllowSprintAttack = true

SWEP.RunSightsPos = Vector(0, -1, -0.5)
SWEP.RunSightsAng = Vector(-10, 0, 0)

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/ugx_axe_icon.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

function SWEP:NZSpecialHolster(wep)
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

DEFINE_BASECLASS(SWEP.Base)

function SWEP:ApplyDamage(trace, dmginfo, attk)
	local ply = self:GetOwner()
	local ent = trace.Entity
	local dam, force = dmginfo:GetBaseDamage(), dmginfo:GetDamageForce()
	dmginfo:SetDamagePosition(trace.HitPos)
	dmginfo:SetReportedPosition(trace.StartPos)
	dmginfo:SetDamageForce(force*4)

	if nzombies and IsValid(ent) then
		local mydamage = ent:Health() + 666
		if ent.NZBossType or ent.IsMooBossZombie then
			mydamage = math.max(1200, ent:GetMaxHealth() / (ent.IsMooMiniBoss and 3 or 8))
		end

		dmginfo:SetDamageType(DMG_MISSILEDEFENSE)
		dmginfo:SetDamage(mydamage)

		self:SetClip1(math.max(self:Clip1() - 5, 0))

		if SERVER and self:Clip1() <= 0 then
			ply:EmitSound("TFA_BO3_SHIELD.Break")

			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()

			local class = self:GetClass()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon(class)
			end)
		end
	end

	ent:DispatchTraceAttack(dmginfo, trace, fwd)

	dmginfo:SetDamage(dam)

	self:ApplyForce(ent, dmginfo:GetDamageForce(), trace.HitPos)
end
