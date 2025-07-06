SWEP.Base = "tfa_quickknife_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "Latte, Wavy"
SWEP.Slot = 0
SWEP.PrintName = "TCT Crowbar"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_bo2/crowbar/vm_t6_crowbar.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_bo2/crowbar/world/wm_t6_crowbar.mdl"
SWEP.HoldType = "melee"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 2, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 1,
        Forward = 3,
        },
        Ang = {
        Up = 0,
        Right = 0,
        Forward = 180,
        },
                Scale = 1.0
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 300
SWEP.Secondary.Damage = 1250
SWEP.Secondary.BashDamage = SWEP.Secondary.Damage

--[Bash]--
SWEP.Secondary.BashSound = "TFA_BO2.Crowbar_Swing"
SWEP.Secondary.BashHitSound = "TFA_BO2.Crowbar_Hit_World"
SWEP.Secondary.BashHitSound_Flesh = "TFA_BO2.Crowbar_Hit_Flesh"
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
