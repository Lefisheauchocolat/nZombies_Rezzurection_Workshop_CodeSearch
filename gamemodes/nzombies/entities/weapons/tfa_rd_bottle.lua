SWEP.Base 			= "tfa_gun_base"
SWEP.Category = "nZombies Bottles"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Latte"
SWEP.Slot = 0
SWEP.PrintName = "Perk Bottle (RD)"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/nz/perks/vm_rd_bottle.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/nzr/2022/perks/w_perk_bottle.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, -2, -1)
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
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	if self:GetOwner():HasUpgrade("speed") then
		self.SequenceRateOverride[ACT_VM_DRAW] = 85 / 60
	else
		self.SequenceRateOverride[ACT_VM_DRAW] = 60 / 60
	end
end, client = true, server = true},
{ ["time"] = 0, ["type"] = "lua", value = function(self) self:GetOwner():SetUsingSpecialWeapon(true) end, client = false, server = true},
{ ["time"] = 1 / 60, ["type"] = "sound", ["value"] = Sound("Perks_RD.Raise") },
{ ["time"] = 34 / 60, ["type"] = "sound", ["value"] = Sound("Perks_RD.Open") },
{ ["time"] = 85 / 60, ["type"] = "sound", ["value"] = Sound("Perks_RD.Drink") },
{ ["time"] = 133 / 60, ["type"] = "lua", value = function(self) self:GetOwner():PerkBlur(0.8) end, client = false, server = true},
{ ["time"] = 139 / 60, ["type"] = "sound", ["value"] = Sound("Perks_RD.Break") },
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
	if self:VMIV() and self.GetPerk then
		self.Skin = tonumber(nzPerks:Get(self:GetPerk()).material)
	end

	return BaseClass.PreDrawViewModel(self, ...)
end

function SWEP:Think2(...)
	if IsFirstTimePredicted() and self.GetPerk and self:GetPerk() ~= "" and self.Skin ~= nzPerks:Get(self:GetPerk()).material then
		self.Skin = tonumber(nzPerks:Get(self:GetPerk()).material)
		self:ClearStatCache("Skin")

		if SERVER and IsValid(self:GetOwner()) then
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetFlags(nzPerks:Get(self:GetPerk()).material)

			local filter = RecipientFilter()
			filter:AddPVS(self:GetOwner():GetShootPos())
			if filter:GetCount() > 0 then
				util.Effect("tfa_perkbottle_3p_fix", fx, true, filter)
			end
		end
	end

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
