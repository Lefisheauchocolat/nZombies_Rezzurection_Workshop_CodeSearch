local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Raygun MK3 animated by Lethal Peelz. \nFrom the Black Ops 3 custom map 'VOID EXPANSE' by Renegade"
SWEP.Author = "Lethal Peelz, FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Ray Gun Mark III | BO3" or "Ray Gun Mark III"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/mk3/c_mk3.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/mk3/w_mk3.mdl"
SWEP.HoldType = "revolver"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1.5,
        Right = 1.2,
        Forward = 3,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_MK3.Shoot"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 260
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 800 or 50
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 15
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_mk3"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

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
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.8
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.6
SWEP.Primary.KickDown			= 0.4
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 80
SWEP.IronSightsPos = Vector(-4.33, -1, 0.03)
SWEP.IronSightsAng = Vector(-1, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_mk3" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 4000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/hunter/misc/sphere025x025.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {battery = "115 Batteries"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Yuri's Mark III Ray Gun"
SWEP.NZWonderWeapon = false
SWEP.Primary.MaxAmmo = 150

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo(self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType())
	self:SetClip1(self.Primary_TFA.ClipSize)
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_mk3_pap"
SWEP.Primary.DamagePAP = 80
SWEP.Primary.ClipSizePAP = 30

function SWEP:OnPaP()
self.Ispackapunched = true
self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_mk3_pap"
self.Primary_TFA.ClipSize = 30
self.Primary_TFA.MaxAmmo = 180
self.Primary_TFA.Damage = 2000
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 60 / 30,
}

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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.First") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.Reload_Start") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.Charge") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.Reload_End") },
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

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if IsFirstTimePredicted() then
		self:EmitGunfireSound("TFA_BO3_MK3.Act")
		self:EmitGunfireSound("TFA_BO3_MK3.Decay")
	end
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(0, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_front_pap.vmt")
		vm:SetSubMaterial(2, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_upg_pap.vmt")
		vm:SetSubMaterial(4, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_rear_off_pap.vmt")
		vm:SetSubMaterial(7, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_vents_pap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(7, nil)
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end
