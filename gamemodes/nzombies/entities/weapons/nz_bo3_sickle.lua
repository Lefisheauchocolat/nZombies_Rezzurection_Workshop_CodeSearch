SWEP.Base = "tfa_quickknife_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "Sickle"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_bo3/sickle/c_sickle.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_bo1/sickle/w_sickle.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, -3)
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
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 1250
SWEP.Secondary.Damage = 1250
SWEP.Secondary.BashDamage = SWEP.Secondary.Damage

--[Bash]--
SWEP.Secondary.BashSound = "TFA_BO3_KNIFE.Swing"
SWEP.Secondary.BashHitSound = "TFA_BO3_KNIFE.Hit"
SWEP.Secondary.BashHitSound_Flesh = "TFA_BO3_BOWIE.Hit"
SWEP.Secondary.BashDamageType = DMG_SLASH

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(4, -5, 4)
SWEP.InspectAng = Vector(-5, 45, 15)

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )
