local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = nzombies and "Chomps off zombies legs, halving their health, 24 max uses" or "Traps enemies and immobilizes them, can be shot to deactivate"
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Author = "FlamingFox"
SWEP.Slot = 5
SWEP.PrintName = nzombies and "Animal Trap | BO2" or "Animal Trap"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= nzombies and "models/weapons/tfa_bo2/beartrap/c_beartrap_nz.mdl" or "models/weapons/tfa_bo2/beartrap/c_beartrap.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/beartrap/w_beartrap.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 10,
        Forward = 4,
        },
        Ang = {
		Up = -90,
        Right = 180,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 240
SWEP.Primary.Damage = nzombies and 115 or 35
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = nzombies and 999 or 1
SWEP.Primary.DefaultClip = nzombies and 999 or 2
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.Delay = 0.2
SWEP.Delay_Underhand = 0.2

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Projectiles]--
SWEP.Primary.Round = nzombies and "nz_bo2_tac_beartrap" or "bo2_tac_beartrap"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo2/beartrap/beartrap_prop.mdl"
SWEP.Velocity = 20
SWEP.Underhanded = false
SWEP.AllowSprintAttack = nzombies and true or false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

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
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0
SWEP.Primary.MaxAmmo = 3

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZHudIcon = Material("vgui/icon/hud_beartrap.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/hud_bear_trap_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/hud_bear_trap_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/hud_bear_trap_bw.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
}

function SWEP:NZSpecialHolster()
	self.nzThrowTime = nil
	self.nzHolsterTime = nil
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

/*SWEP.SequenceLengthOverride = {
	[ACT_VM_PULLPIN] = 55 / 30,
}*/

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
{ ["time"] = nzombies and 10 / 45 or 1 / 30, ["type"] = "sound", ["value"] = Sound(nzombies and "TFA_BO2_BEARTRAP.Arm" or "TFA_BO2_BEARTRAP.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_CLOTH.Short") },
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_GEAR.Rattle") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BEARTRAP.Arm") },
},
[ACT_VM_THROW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BEARTRAP.Plant") },
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

--[Sauce]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	if nzombies then
		ply:SetAmmo(3, GetNZAmmoID("specialgrenade"))
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetPos(self:GetOwner():GetShootPos())

	local angle = self:GetAimVector():Angle()
	angle = Angle(0, angle.y, angle.z)
	angle:RotateAroundAxis(angle:Up(), -90)

	ent:SetAngles(angle)
end

function SWEP:PostSpawnProjectile(ent)
	local dir = (Vector(0,0,-90))
	dir:Mul(self:GetStatL("Primary.ProjectileVelocity"))

	ent:SetVelocity(dir)
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(dir)
	end
end
