local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Mortar | BO2" or "Mortar"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/mortar/c_mortar.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_bo2/mortar/w_mortar.mdl"
SWEP.HoldType = "grenade"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 2,
        Forward = 3,
        },
        Ang = {
		Up = 0,
        Right = 195,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "tripmine"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 600 or 160
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.Delay = 0.2

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Projectiles]--
SWEP.Primary.Round = nzombies and "nz_waw_nade_mortar" or "waw_nade_mortar"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo2/mortar/w_mortar.mdl"
SWEP.Velocity = 750
SWEP.Underhanded = false
SWEP.AllowSprintAttack = false
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
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZHudIcon = Material("vgui/icon/hud_t5_mortarshell.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/hud_t5_mortarshell.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t6 = Material("vgui/icon/hud_t5_mortarshell.png", "unlitgeneric smooth")

SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 1, AmmoType = "tripmine"}
SWEP.NZTrapRegen = true
SWEP.NZTrapRegenAmount = 1
SWEP.NZRegenTakeClip = true

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_MORTAR.Arm") },
},
[ACT_VM_THROW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_GRENADE.Throw") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

--[Sauce]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	if nzombies then
		timer.Simple(engine.TickInterval(), function()
			if not IsValid(ply) then return end
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end)
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end
	local ply = self:GetOwner()

	if nzombies and SERVER and IsValid(ply) then
		if ply:IsPlayer() and ply:GetAmmoCount(self:GetPrimaryAmmoType()) + self:Clip1() > self.NZSpecialWeaponData.MaxAmmo then
			ply:SetAmmo(self.NZSpecialWeaponData.MaxAmmo - self:Clip1(), self:GetPrimaryAmmoType())
		end

		local status = self:GetStatus()
		if status == TFA.Enum.STATUS_GRENADE_THROW_WAIT and self:GetStatusEnd() <= CurTime() and ply:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PreSpawnProjectile(ent)
	ent.Range = 220
	ent.Overpowered = true
	ent.ExplosionEffect = "doi_mortar_explosion"
	ent.ExplosionSound ="TFA_BO2_MORTAR.Expl"
	ent.ExplosionSoundCL = "TFA_BO2_MORTAR.Dist"
	ent.FluxSound = "TFA_BO2_MORTAR.Flux"
end

function SWEP:PostSpawnProjectile(ent)
	local angvel = Vector(math.random(-2000,-500),math.random(-500,-2000),math.random(-500,-2000)) //The positive z coordinate emulates the spin from a right-handed overhand throw
	angvel:Rotate(-1*ent:EyeAngles())
	angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(angvel)
	end
end