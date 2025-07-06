SWEP.Base = "tfa_quickknife_base"
SWEP.Category = "nZombies Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "USA Knife"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_waw/knife/c_knife.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_waw/knife/w_knife.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1.5
SWEP.VMPos = Vector(0, 6, -1)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1.5,
        Forward = 3,
        },
        Ang = {
		Up = -125,
        Right = 180,
        Forward = 70
        },
		Scale = 1.1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 300
SWEP.Secondary.Damage = 300
SWEP.Secondary.BashDamage = SWEP.Secondary.Damage

--[Bash]--
SWEP.Secondary.BashSound = "TFA.WAW.KNIFE.Swing"
SWEP.Secondary.BashHitSound = "TFA.WAW.KNIFE.Hit"
SWEP.Secondary.BashHitSound_Flesh = "TFA.WAW.KNIFE.Slash"
SWEP.Secondary.BashDamageType = DMG_SLASH

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(4, -5, 4)
SWEP.InspectAng = Vector(-5, 45, 15)

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
        [ACT_VM_HITRIGHT] = {
                { ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("TFA.WAW.KNIFE.Stab") },
                { ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA.WAW.KNIFE.Pull") },
        },
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )
