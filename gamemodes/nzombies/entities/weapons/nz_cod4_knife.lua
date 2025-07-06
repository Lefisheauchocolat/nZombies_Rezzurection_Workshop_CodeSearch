SWEP.Base = "tfa_quickknife_base"
SWEP.Category = "nZombies Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "Latte, Wavy"
SWEP.Slot = 0
SWEP.PrintName = "Priced Knife"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_cod4/parabolic_knife/vm_iw3_knife.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_cod4/parabolic_knife/world/wm_iw3_knife.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(-5, 2, 0)
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
        Right = -90,
        Forward = 180,
        },
                Scale = 0.8
}
--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 300
SWEP.Secondary.Damage = 300
SWEP.Secondary.BashDamage = SWEP.Secondary.Damage

--[Bash]--
SWEP.Secondary.BashSound = "TFA_GHOSTS_KNIFE.Swing"
SWEP.Secondary.BashHitSound = "TFA_GHOSTS_KNIFE.Hit"
SWEP.Secondary.BashHitSound_Flesh = "TFA_GHOSTS_KNIFE.Hit_Flesh"
SWEP.Secondary.BashHitSound_Lunge = "TFA_GHOSTS_KNIFE.Hit_Lunge"
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
