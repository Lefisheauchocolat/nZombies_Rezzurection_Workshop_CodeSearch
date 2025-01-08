AddCSLuaFile()

SWEP.NZSpecialCategory = "killstreak"
SWEP.Type_Displayed = "Killstreak"
SWEP.Base 			= "tfa_gun_base"
SWEP.Category = "nZombies Killstreaks"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Hari"
SWEP.Slot = 0
SWEP.PrintName = "Hellstorm"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/nzr/2024/radio/vm_t5_radio.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/nzr/2024/radio/world/wm_t5_radio.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(3, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = false

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 1,
        Right = 7,
        Forward = -4,
        },
        Ang = {
		Up = 0,
        Right = 90,
        Forward = -170
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.NZPreventBox = true

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = 0.0

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
}

SWEP.SprintAnimation = {
}

SWEP.EventTable = {
    [ACT_VM_HOLSTER] = {
        { ["time"] = 14 / 30, ["type"] = "sound", ["value"] = Sound("Latte_Radio.Off") },
    },
    [ACT_VM_DRAW] = {
        { ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO.FOLEY.EQUIP") },
        { ["time"] = 17 / 30, ["type"] = "sound", ["value"] = Sound("Latte_Radio.On") },
        { ["time"] = 40 / 30, ["type"] = "lua", value = function(self)
            local ply = self:GetOwner()
            if !IsValid(ply) or !ply:Alive() or !ply:GetNotDowned() then return end
            ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 0.5)
            self:Remove()
            local ent = ents.Create("bo6_hellstorm")
            ent:SetPos(ply:GetPos())
            ent.Player = ply
            ent:SetNoDraw(true)
            ent:Spawn()
            timer.Simple(0.5, function()
                if !IsValid(ent) then return end
                ent:SetNoDraw(false)
            end)
        end, client = false, server = true},
    },
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.WorldModelBoneMods = {
}

DEFINE_BASECLASS(SWEP.Base)

local sp = game.SinglePlayer()

-- Disable functions that should not be used
function SWEP:IsSpecial()
	return true
end

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