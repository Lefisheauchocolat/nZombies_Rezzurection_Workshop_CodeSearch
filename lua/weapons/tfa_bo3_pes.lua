local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Helmet"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "P.E.S."
SWEP.DrawCrosshair = false
SWEP.Purpose = "WIP, no thirdperson model yet"
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_bo3/pes/c_pes.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_bo3/pes/w_pes.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4,
        Right = 1,
        Forward = 5,
        },
        Ang = {
		Up = 0,
        Right = 0,
        Forward = 180
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
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.MoveSpeed = 1
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)

--[NZombies]--
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_helmet.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_pes_active.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_pes_active_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_pes_active_bw.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

function SWEP:NZSpecialHolster(wep)
	return false
end

function SWEP:IsSpecial()
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self) self.TakingOff = false end, client = true, server = true},
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PES.On") },
},
[ACT_VM_DRAW_SILENCED] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		ply:SetDSP(0, false) 
		ply:SetNW2Bool("PESEnabled", false)
		self.TakingOff = true
	end
end, client = true, server = true},
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PES.Off") },
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
SWEP.ProceduralHolsterTime = 0

SWEP.WorldModelBoneMods = {
}

SWEP.DamageTypes = bit.bor(DMG_POISON, DMG_ACID, DMG_NERVEGAS, DMG_DROWN, DMG_RADIATION)
SWEP.BO3PESEnabled = true

DEFINE_BASECLASS( SWEP.Base )

local sp = game.SinglePlayer()
local cl_defaultweapon = GetConVar("cl_defaultweapon")

function SWEP:SwitchToPreviousWeapon()
	local wep = LocalPlayer():GetPreviousWeapon()

	if IsValid(wep) and wep:IsWeapon() and wep:GetOwner() == LocalPlayer() then
		input.SelectWeapon(wep)
	else
		wep = LocalPlayer():GetWeapon(cl_defaultweapon:GetString())

		if IsValid(wep) then
			input.SelectWeapon(wep)
		else
			local _
			_, wep = next(LocalPlayer():GetWeapons())

			if IsValid(wep) then
				input.SelectWeapon(wep)
			end
		end
	end
end

function SWEP:Equip(ply, ...)
	self.LastChatter = CurTime()
	if IsValid(ply) and ply:IsPlayer() then
		ply:SetNW2Bool("PESEnabled", false)
		if nzombies then
			self.DamageTypes = bit.bor(DMG_POISON, DMG_ACID, DMG_NERVEGAS, DMG_DROWN, DMG_RADIATION, DMG_SHOCK)
		end
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:Think2(...)
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()
	local ply = self:GetOwner()

	if stat == TFA.Enum.STATUS_DRAW and statusend then
		if IsValid(ply) and ply:IsPlayer() and not self:GetSilenced() then
			ply:SetDSP(30, false) 
			ply:SetNW2Bool("PESEnabled", true)
		end
		self:SetSilenced(not self:GetSilenced())
		self.TakingOff = false

		timer.Simple(0, function()
			if CLIENT or not IsValid(self) or not self:OwnerIsValid() then return end
			if nzombies then
				ply:EquipPreviousWeapon()
				ply:SetUsingSpecialWeapon(false)
			end
		end)

		if not nzombies then
			if CLIENT and not sp then
				if IsFirstTimePredicted() then
					self:SwitchToPreviousWeapon()
				end
			elseif SERVER then
				self:CallOnClient("SwitchToPreviousWeapon", "")
			end
		end
	end
	
	return BaseClass.Think2(self, ...)
end

function SWEP:OnDrop(...)
	local ply = self:GetOwner()
	if IsValid(ply) then
		ply:SetNW2Bool("PESEnabled", false)
	end
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	if self:OwnerIsValid() then
		local ply = self:GetOwner()
		if IsValid(ply) then
			ply:SetNW2Bool("PESEnabled", false)
		end
	end
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	if self.TakingOff then return false end
	self:StopSound("TFA_BO3_PES.On")
	self:StopSound("TFA_BO3_PES.Off")
	return BaseClass.Holster(self, ...)
end

function SWEP:OnRemove(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		ply:SetDSP(0, false)
		ply:SetNW2Bool("PESEnabled", false)
	end
	return BaseClass.OnRemove(self,...)
end

-- Disable functions that should not be used
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

if SERVER and nzombies then
	hook.Add("PlayerCanPickupWeapon", "BO3.NZ.PESFIX", function(ply, wep)
		if not IsValid(ply) or not IsValid(wep) then return end

		if wep.NZSpecialCategory == "shield" and ply:HasWeapon("tfa_bo3_pes") then
			ply:SetDSP(0, false)
			ply:SetNW2Bool("PESEnabled", false)
		end
	end)
end
