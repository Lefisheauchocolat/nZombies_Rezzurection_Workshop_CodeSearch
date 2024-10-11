SWEP.Base 			= "tfa_gun_base"
SWEP.Category = "nZombies Bottles"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Latte"
SWEP.Slot = 0
SWEP.PrintName = "Perk Can (BOCW)"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/nzr/2024/perks/bocw/vm_t9_can.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/nzr/2024/perks/bocw/world/wm_t9_can.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 1,
        Right = 2.5,
        Forward = 3,
        },
        Ang = {
		Up = -15,
        Right = 10,
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
["draw"] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	if self:GetOwner():HasUpgrade("speed") then
		self.SequenceRateOverride[ACT_VM_DRAW] = 45 / 30
	else
		self.SequenceRateOverride[ACT_VM_DRAW] = 30 / 30
	end
end, client = true, server = true},
{ ["time"] = 0, ["type"] = "lua", value = function(self) self:GetOwner():SetUsingSpecialWeapon(true) end, client = false, server = true},
{ ["time"] = 17 / 30, ["type"] = "sound", ["value"] = Sound("Perks_CW.Open") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("Perks_CW.Grab") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("Perks_CW.Drink") },
{ ["time"] = 65 / 30, ["type"] = "lua", value = function(self) self:GetOwner():PerkBlur(0.8) end, client = false, server = true},
{ ["time"] = 85 / 30, ["type"] = "sound", ["value"] = Sound("Perks_CW.Toss") },
},

["draw_roblox"] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	if self:GetOwner():HasUpgrade("speed") then
		self.SequenceRateOverride[ACT_VM_DRAW] = 45 / 40
	else
		self.SequenceRateOverride[ACT_VM_DRAW] = 30 / 40
	end
end, client = true, server = true},
{ ["time"] = 0, ["type"] = "lua", value = function(self) self:GetOwner():SetUsingSpecialWeapon(true) end, client = false, server = true},
{ ["time"] = 13 / 30, ["type"] = "sound", ["value"] = Sound("Perks_RB.Open") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("Perks_RB.Drink") },
{ ["time"] = 65 / 30, ["type"] = "lua", value = function(self) self:GetOwner():PerkBlur(0.8) end, client = false, server = true},
{ ["time"] = 85 / 30, ["type"] = "sound", ["value"] = Sound("Perks_CW.Toss") },
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

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("String", "Perk")
end

function SWEP:PreDrawViewModel(...)
	local vm = self.OwnerViewModel

	local perk = self.GetPerk and self:GetPerk() or ""
	if perk and perk ~= "" then
		local mattable = nzPerks:GetBottleTextures(self:GetClass())
		if mattable then
			for id, mat in pairs(mattable) do
				vm:SetSubMaterial(id, mat..perk)
			end
		end
	end

	return BaseClass.PreDrawViewModel(self, ...)
end

function SWEP:DrawWorldModel(...)
	local perk = self.GetPerk and self:GetPerk() or ""
	if perk and perk ~= "" then
		local mattable = nzPerks:GetBottleTextures(self:GetClass())
		if mattable then
			for id, mat in pairs(mattable) do
				self:SetSubMaterial(id, mat..perk)
			end
		end
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:Think2(...)
	if SERVER then
		local stat = self:GetStatus()
		local statusend = CurTime() >= self:GetStatusEnd()
		local ply = self:GetOwner()

		if stat == TFA.Enum.STATUS_DRAW and statusend then
			ply:EquipPreviousWeapon()
			ply:SetUsingSpecialWeapon(false)
			timer.Simple(0, function() ply:StripWeapon(self:GetClass()) end)
		end
	end

	return BaseClass.Think2(self, ...)
end

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
