local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.trap"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = "Spikemore (Equipment) | BO1"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo1/spikemore/c_spikemore.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo1/spikemore/w_spikemore.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 4,
        Right = 6,
        Forward = 3,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = -10
        },
		Scale = 0.9
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "TripMine"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = 666
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 2
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true
SWEP.Delay = 0.15

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .04

--[Projectiles]--
SWEP.Primary.Round = "nz_bo1_tac_spikemore"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo1/spikemore/w_spikemore.mdl"
SWEP.Velocity = 1200
SWEP.Underhanded = false
SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 2, AmmoType = "tripmine"}

SWEP.NZHudIcon = Material("vgui/icon/hud_t5_claymore.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/hud_t5_claymore.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/hud_t5_claymore_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/hud_t5_claymore_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/hud_t5_claymore_bw.png", "unlitgeneric smooth")

SWEP.NZTrapRegen = true
SWEP.NZTrapRegenAmount = 2
SWEP.NZRegenTakeClip = true

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
SWEP.SequenceLengthOverride = {
	[ACT_VM_DRAW] = 15/35
}

SWEP.RunSightsPos = Vector(0, -1, -0.5)
SWEP.RunSightsAng = Vector(-10, 0, 0)

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_WAW_BBETTY.Pin") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1
SWEP.ProceduralHolsterTime = 0.015

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	local ammo = self:GetPrimaryAmmoType()
	if ammo + self:Clip1() > 2 then
		ply:SetAmmo(1, self:GetPrimaryAmmoType())
	end
	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	local ang = self:GetAimVector():Angle()
	ent:SetAngles(Angle(0, ang[2], 0))
	ent.DesiredAng = ent:GetAngles()
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and self:Clip1() > 0 and ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 1 then
		ply:SetAmmo(1, self:GetPrimaryAmmoType())
	end

	local status = self:GetStatus()
	if SERVER and status == TFA.Enum.STATUS_GRENADE_THROW_WAIT and self:GetStatusEnd() <= CurTime() and ply:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PostSpawnProjectile(ent)
	local phys = ent:GetPhysicsObject()
	ent:SetVelocity(vector_up*-self:GetStatL("Velocity"))
	if IsValid(phys) then
		phys:SetVelocity(vector_up*-self:GetStatL("Velocity"))
	end
	if ent.DesiredAng then
		ent:SetAngles(ent.DesiredAng)
	end
end