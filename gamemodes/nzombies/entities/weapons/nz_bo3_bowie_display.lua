SWEP.Base = "tfa_gun_base"
SWEP.Category = "Other"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Wavy"
SWEP.Slot = 0
SWEP.PrintName = "Bowie Knife Flourish"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel 			= "models/weapons/wavy_ports/bo3/c_bo3_bowie_display.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel 		= "models/weapons/wavy_ports/bo3/w_bo3_bowie.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 2.5, -0.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 1.2,
        Forward = 3,
        },
        Ang = {
		Up = -90,
        Right = 90,
        Forward = 90
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Sound_Hit = ""
SWEP.Primary.Sound_HitFlesh = ""
SWEP.Primary.DamageType = DMG_SLASH
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 1000
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 1000
SWEP.Secondary.MaxCombo = 0

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.NZPreventBox = true	-- If true, this gun won't be placed in random boxes GENERATED. Users can still place it in manually.
SWEP.NZTotalBlackList = true	

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.START") },
{ ["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.TURN") },
{ ["time"] = 48 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.TOSS") },
{ ["time"] = 61 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.CATCH") },
},
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

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