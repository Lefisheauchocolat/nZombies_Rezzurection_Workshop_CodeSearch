SWEP.Base 			= "tfa_gun_base"
SWEP.Category = "nZombies"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Latte"
SWEP.Slot = 0
SWEP.PrintName = "Bubble"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/bubble_camera.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/nzr/2024/perks/bo3/gum/world/wm_bo3_gum.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 3, -4)
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
local draw_mult = .8 / .5
local blow_on = 18 / 30
local bubble_erase_on = blow_on + 6.1 / 30
local blow_dur = blow_on + 20 / 30
--[Tables]--
SWEP.SequenceRateOverride = {
	[ACT_VM_DRAW] = 1,
}


SWEP.SequenceLengthOverride = {
	[ACT_VM_DRAW] = blow_dur,
}

SWEP.SprintAnimation = {
}

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

SWEP.VElements = {
	["bubble"] = {
		type = "Model",
		model = "models/bubble.mdl",
		bone = "tag_camera",
		pos = Vector(0, 0, 0),
		angle = Angle(0, -90, 0),
		size = Vector(.1, .1, .1),
		color = Color(255, 255, 255, 50),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {},
		active = true,
		translucent = true
	},
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
		{ ["time"] = 0, ["type"] = "lua", value = function(self)
			self.blow_start = CurTime()
		end, client = true, server = false},
		
		{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("gummachine/bgb_blow.wav") },
	},
}

hook.Add("InitPostEntity", "nzRegisterSpecialWeps_Gums", function()
	nzSpecialWeapons:AddDisplay( "tfa_bo3_bubble", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 1.5
	end)
	
	nzSpecialWeapons:AddDisplay( "tfa_bo3_gum", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 2.5
	end)
end)

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

	self:NetworkVarTFA("String", "Gum")
end

SWEP.BobScale = 0
SWEP.BobScaleCustom =  0
SWEP.SwayScale = 0
SWEP.SprintBobMult = 0
SWEP.IronBobMult = 0.0
SWEP.IronBobMultWalk = 0
SWEP.WalkBobMult = 0
SWEP.SprintViewBobMult = 0

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
	
	if CLIENT then
		if !self.blow_start then
			self.blow_start = CurTime()
		end
		local dif = CurTime() - self.blow_start
		if dif > bubble_erase_on then
			if self.VElements.bubble.active then
				self.VElements.bubble.active = false
				self:ClearStatCache()
			end
		elseif dif > blow_on then
			local dif_blow_on = (bubble_erase_on - blow_on)
			local ease = .7 + math.ease.OutCirc( (dif - dif_blow_on) / dif_blow_on ) * .15
			self.VElements.bubble.size = Vector(ease, ease, ease)
		else
			local ease = math.ease.OutCirc( dif / blow_on ) * .7
			self.VElements.bubble.size = Vector(ease, ease, ease)
		end
	end
	
	BaseClass.Think2(self, ...)

	return 
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
