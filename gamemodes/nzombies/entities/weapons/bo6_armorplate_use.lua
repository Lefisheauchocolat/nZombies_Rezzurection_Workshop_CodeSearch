SWEP.Base = "tfa_gun_base"
SWEP.Category = "Other"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Hari & Latte"
SWEP.Slot = 0
SWEP.PrintName = "Armor Plate"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.NZSpecialCategory = "misc"

--[Model]--
SWEP.ViewModel = "models/nzr/2024/plate/vm_iw9_plate.mdl"
SWEP.ViewModelFOV = 75
SWEP.WorldModel = "models/nzr/2024/plate/world/wm_iw9_plate.mdl"
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

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "lua", value = function(self)
			if self:GetOwner():HasPerk("speed") then
				self.SequenceRateOverride[ACT_VM_DRAW] = 80 / 55
			else
				self.SequenceRateOverride[ACT_VM_DRAW] = 55 / 55
			end
		end, client = true, server = true},
		{ ["time"] = 0, ["type"] = "lua", value = function(self) self:GetOwner():SetUsingSpecialWeapon(true) end, client = false, server = true},
		{ ["time"] = 0 / 55, ["type"] = "sound", ["value"] = Sound("Latte_Armor.Open") },
		{ ["time"] = 10 / 55, ["type"] = "sound", ["value"] = Sound("Latte_Armor.Insert") },
		{ ["time"] = 55 / 55, ["type"] = "lua", value = function(self)
			local ply = self:GetOwner() 
			ply:SetActiveWeapon(nil)
			timer.Simple(0, function() 
				if not IsValid(ply) then return end
				ply:StripWeapon("bo6_armorplate_use")
				ply:SetUsingSpecialWeapon(false)
				ply:SetNWInt("ArmorPlates", ply:GetNWInt("ArmorPlates")-1)
				ply:EquipPreviousWeapon()
				nzArmor:AddHealth(ply)
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

-- Disable functions that should not be used
function SWEP:IsSpecial()
	return true
end

function SWEP:Holster()
	return false
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

function SWEP:Equip(ply, ...)
	ply:SelectWeapon("bo6_armorplate_use")

	return BaseClass.Equip(self, ply, ...)
end