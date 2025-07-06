SWEP.Base = "tfa_quickknife_base"
SWEP.Category = "nZombies Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "Wavy, Latte"
SWEP.Slot = 0
SWEP.PrintName = "SWAT Knife"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel                  = "models/weapons/wavy_ports/rainy_death/c_kf2_swatknife.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel                 = "models/weapons/wavy_ports/rainy_death/w_kf2_swatknife.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0.75, -0.75)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1.2,
        Forward = 3,
        },
        Ang = {
                Up = -90,
        Right = 90,
        Forward = -90
        },
                Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 300
SWEP.Secondary.Damage = 300
SWEP.Secondary.BashDamage = SWEP.Secondary.Damage

--[Bash]--
SWEP.Secondary.BashSound = "TFA_RD.SWAT_KNIFE.SWING"
SWEP.Secondary.BashHitSound = "Weapon_BO3_KNIFE.Hit"
SWEP.Secondary.BashHitSound_Flesh = "TFA_RD.SWAT_KNIFE.STAB"
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
