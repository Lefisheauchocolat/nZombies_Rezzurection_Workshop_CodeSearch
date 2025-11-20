local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = "Annihilator"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/annihilator/c_annihilator.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/annihilator/w_annihilator.mdl"
SWEP.HoldType = "revolver"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1.2,
        Forward = 2.5,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_ANNIHILATOR.Shoot"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 167
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_Displayed = 67
SWEP.Primary.Damage = 5000
SWEP.Primary.DamageType = bit.bor(DMG_AIRBOAT, DMG_ALWAYSGIB)
SWEP.Primary.PenetrationMultiplier	= 5
SWEP.Primary.HullSize = 4
SWEP.Primary.Knockback = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 5
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.DryFireDelay = 0.5
SWEP.Primary.Force = 25000
SWEP.MaxPenetrationCounter = 12
SWEP.MuzzleFlashEffect	= "tfa_muzzleflash_shotgun"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

SWEP.Primary.PenetrationMaterials = {
	[MAT_DEFAULT] = 0.1,
	[MAT_VENT] = 0.1, --Since most is aluminum and stuff
	[MAT_METAL] = 0.1, --Since most is aluminum and stuff
	[MAT_WOOD] = 0.1,
	[MAT_PLASTIC] = 0.1,
	[MAT_FLESH] = 0.1,
	[MAT_CONCRETE] = 0.1,
	[MAT_GLASS] = 0.1,
	[MAT_SAND] = 0.1,
	[MAT_SLOSH] = 0.1,
	[MAT_DIRT] = 0.1, --This is plaster, not dirt, in most cases.
	[MAT_FOLIAGE] = 0.1
}

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.FireModeName = "Single-Action"

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .00
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1.0
SWEP.Primary.KickDown 			= 0.8
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-3.518, 0, 0.31)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {["357"] = ".467 SwS Depleted"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 5
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 15

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/uie_t7_zm_derriese_hud_ammo_icon_gun_ready.png", "unlitgeneric smooth")
SWEP.AmmoRegen = 4

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
end

local DontBleed = {
	[BLOOD_COLOR_MECH] = true,
	[DONT_BLEED] = true,
}

SWEP.CustomBulletCallback = function(ply, tr, dmg)
	local ent = tr.Entity
	if not SERVER then return end
	if IsValid(ent) and ply:IsPlayer() then
		if nzombies and ent.NZBossType then
			dmg:SetDamage(math.max(2400, ent:GetMaxHealth() / 8))
			dmg:ScaleDamage(math.Round(nzRound:GetNumber()/8))
		end

		if ent:IsPlayer() or ent:IsNextBot() or ent:IsNPC() then
			if nzombies and ent:IsPlayer() then return end
			if nzombies and ent.NZBossType then return end

			ent:SetHealth(1)
			dmg:SetDamage(ent:Health() + 666)
			//dmg:SetDamageForce(((dmg:GetDamagePosition() - ply:GetShootPos()):GetNormalized() * 20000) + ent:GetUp()*3000)

			if ent.GetBloodColor and DontBleed[ent:GetBloodColor()] then return end
			ent:SetNW2Bool("AnniKilled", true)
			ent:EmitSound("TFA_BO3_ANNIHILATOR.Lfe")
		end
	end
end

--[Animations]--
SWEP.PumpAction = {
	["type"] = TFA.Enum.ANIMATION_ACT,
	["value"] = ACT_VM_PULLBACK_HIGH,
	["value_is"] = ACT_VM_PULLBACK_LOW,
	["value_empty"] = ACT_VM_PULLBACK_HIGH,
}

--[Tables]--
SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ANNIHILATOR.Raise") },
},
[ACT_VM_PULLBACK_HIGH] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ANNIHILATOR.Rechamber") },
},
[ACT_VM_PULLBACK_LOW] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ANNIHILATOR.RechamberADS") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:GetAmmoRicochetMultiplier()
	return 1
end

function SWEP:GetAmmoForceMultiplier()
	return 1
end

function SWEP:Deploy(...)
	if SERVER and self.IsFirstDeploy then
		local ply = self:GetOwner()
		local damage = DamageInfo()
		damage:SetAttacker(ply)
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_MISSILEDEFENSE)

		for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 200)) do
			if v:IsNPC() or v:IsNextBot() then
				if v == ply then continue end
				if nzombies and v.NZBossType then continue end

				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

				v:TakeDamageInfo(damage)
			end
		end
	end

	return BaseClass.Deploy(self, ...)
end
