local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Manufacturer = "Springfield Armory"
SWEP.Type_Displayed = "#tfa.weapontype.buildable.trap"
SWEP.Author = "Wavy"
SWEP.Slot = 4
SWEP.PrintName = "Claymore (Equipment) | BO1"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/wavy_ports/bo1/c_bo1_claymore.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/wavy_ports/bo1/w_bo1_claymore.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 3,
        Right = 5,
        Forward = 2,
        },
        Ang = {
		Up = -90,
        Right = 180,
        Forward = -20
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "nil"
SWEP.Primary.Ammo = "TripMine"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 2000
SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 2
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.Delay = 0.1

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Projectiles]--
SWEP.Primary.Round = ("nz_bo1_claymore_planted")
SWEP.Primary.ProjectileModel = "models/weapons/wavy_ports/bo1/w_bo1_claymore.mdl"
SWEP.Velocity = 100
SWEP.Underhanded = false
SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false
SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.FireModeSound = "TFA_CODWW2_GEN.Switch"
SWEP.Primary.PickupSound = "TFA_CODWW2_PICKUP.Grenade"
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(15, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0
SWEP.Primary.MaxAmmo = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 2
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 2

SWEP.NZHudIcon = Material("vgui/hud/hud_claymore.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/hud/hud_claymore.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icons/hud_claymore_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icons/hud_claymore_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icons/hud_claymore_t7.png", "unlitgeneric smooth")
SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 2, AmmoType = "tripmine"}
SWEP.NZTrapRegen = true
SWEP.NZTrapRegenAmount = 2
SWEP.NZRegenTakeClip = true

function SWEP:NZSpecialHolster()
	self.nzThrowTime = nil
	self.nzHolsterTime = nil
	return true
end

--[Tables]--

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1.CLAYMORE.PULLOUT") },
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

--[Sauce]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	local ammo = self:GetPrimaryAmmoType()
	if ammo + self:Clip1() > 2 then
		ply:SetAmmo(1, self:GetPrimaryAmmoType())
	end
	return BaseClass.Equip(self, ply, ...)
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

function SWEP:PreSpawnProjectile(ent)
	ent:SetPos(self:GetOwner():GetShootPos() + (self:GetOwner():GetForward() * 15))
	ent:SetAngles(self:GetOwner():GetForward():Angle() + Angle(0,-90,0))
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
