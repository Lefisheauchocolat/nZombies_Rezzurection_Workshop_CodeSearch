SWEP.Base = "tfa_gun_base"
SWEP.Category = "Other"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "Chalk"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.DrawAmmo = false
SWEP.DrawHUD = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/chalk/c_zom_chalk.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/chalk/w_zom_chalk.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 4, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2.6,
        Right = 2.2,
        Forward = 4,
        },
        Ang = {
		Up = 0,
        Right = -90,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = 0
SWEP.Primary.ClipSize = 0
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Knockback = 0
SWEP.MuzzleFlashEffect = ""
SWEP.MuzzleFlashEnabled = false
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

SWEP.NZPreventBox = true
SWEP.NZTotalBlacklist = true

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
SWEP.ViewModelPunchPitchMultiplier = 0.25 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.25 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 0.25 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 0.25 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.25 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .05
SWEP.Primary.IronAccuracy = .05
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0
SWEP.Primary.KickDown			= 0
SWEP.Primary.KickHorizontal		= 0
SWEP.Primary.StaticRecoilFactor	= 0

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[Tables]--
SWEP.StatusLengthOverride = {
}
SWEP.SequenceRateOverride = {
}

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
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

function SWEP:Equip(ply, ...)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:EmitSound("NZ.Chalks.Loop")
	end)

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:OnRemove(...)
	self:StopSound("NZ.Chalks.Loop")
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("NZ.Chalks.Loop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("NZ.Chalks.Loop")
	self:StopSoundNet("NZ.Chalks.Loop")
	return BaseClass.Holster(self,...)
end

-- Disable functions that should not be used
function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end

function SWEP:ToggleInspect()
end