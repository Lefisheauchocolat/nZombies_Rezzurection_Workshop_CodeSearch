SWEP.Base = "tfa_ms_akimbo_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Pistol"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = "Mustang & Sally | BOCW"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bocw/mustangsally/c_mustangsally.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo1/mustangsally/w_mustangsally.mdl"
SWEP.HoldType = "duel"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
        Right = 1,
        Forward = 4.5,
        },
        Ang = {
		Up = -95,
        Right = 180,
        Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BOCW_MS.Shoot"
SWEP.Primary.SoundLayer1 = "TFA_BOCW_MS.Sub"
SWEP.Primary.SoundLayer2 = "TFA_BOCW_MS.Mech"
SWEP.Primary.SoundLayer3 = "TFA_BOCW_MS.Trigger"
SWEP.Primary.SoundFlux = "TFA_BO3_MS.PapFlux"
SWEP.Secondary.Sound = "TFA_BOCW_MS.Shoot"
SWEP.Primary.Ammo = "SMG1_Grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 600
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = engine.ActiveGamemode() == "nzombies" and 3000 or 120
SWEP.Primary.Knockback = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 10
SWEP.Primary.DryFireDelay = 0.35
SWEP.Primary.Sound_DryFire = "TFA_BO3MS_FLY.DryFire"
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
SWEP.LowAmmoSoundThreshold = 0.2 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.3 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 1.5 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.5 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.15 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.3 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.1 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .05
SWEP.Primary.IronAccuracy = .05
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.5
SWEP.Primary.KickDown			= 0.3
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.4

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 0
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 0.7
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "mustangsally_proj" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 4000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {smg1_grenade = "40mm Rounds"}
SWEP.FireModeSound = "TFA_BO3MS_FLY.SelectFire"
SWEP.InspectPos = Vector(0, -2, -2)
SWEP.InspectAng = Vector(15, 0, 0)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 1)
SWEP.SafetyAng = Vector(-15, 0, 0)

--[NZombies]--
SWEP.Ispackapunched = true
SWEP.NZPaPName = "Mustang & Sally"
SWEP.NZPreventBox = true
SWEP.Primary.MaxAmmo = 62 -- 50 + 6/6

function SWEP:NZMaxAmmo()

	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

	if SERVER then
		self:GetOwner():SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary_TFA.ClipSize )
		self:SetClip2( self.Secondary_TFA.ClipSize )
	end
end

function SWEP:OnPaP()
self.Ispackapunched = true
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 30 / 30,
	[ACT_VM_RELOAD2] = 30 / 30,
	[ACT_VM_RELOAD_DEPLOYED] = 30 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Cloth") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Gear") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Cloth") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Gear") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Cloth") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3MS_FLY.Gear") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.SlideFwd") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.SlideFwd") },
},
[ACT_VM_RELOAD2] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.MagOut") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.MagIn") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.SlideBack") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.SlideFwd") },
},
[ACT_VM_RELOAD_DEPLOYED] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.MagOut") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.MagIn") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.SlideBack") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.SlideFwd") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.MagOut") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.MagIn") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.SlideBack") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Left.SlideFwd") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.MagOut") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.MagIn") },
{ ["time"] = 45 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.SlideBack") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Right.SlideFwd") },
},
[ACT_VM_FIDGET] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Inspect1") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Inspect2") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Inspect3") },
{ ["time"] = 75 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Inspect4") },
{ ["time"] = 120 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_MS.Inspect5") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_ANI --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PreDrawViewModel(vm)
	vm:SetSubMaterial(0, self.nzPaPCamo)
	vm:SetSubMaterial(1, self.nzPaPCamo)
	vm:SetSubMaterial(2, self.nzPaPCamo)
end
