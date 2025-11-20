local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.trap"
SWEP.Purpose = "Animated by SajeOne(?). \nFrom the World at War mod 'UGX 1.1' by UGX Team \n\nDeploy 2 Electrip Wires near eachother for them to connect. 180hu radius."
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Electrip Wire | WAW" or "Electrip Wire"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/electrip/c_electrip.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/electrip/w_electrip.mdl"
SWEP.HoldType = "melee"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -14,
        Right = 4,
        Forward = 7,
        },
        Ang = {
		Up = -180,
        Right = -190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Sound_DryFire = ""
SWEP.Primary.Sound_Blocked = ""
SWEP.Primary.Ammo = nzombies and "tripmine" or "slam"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 115 or 200
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 2
SWEP.Primary.Delay = 0.15
SWEP.MuzzleFlashEnabled = false
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.15

SWEP.Secondary.ClipSize = 100
SWEP.Secondary.DefaultClip = 100
SWEP.Secondary.AmmoConsumption = 0
SWEP.Secondary.Ammo = "none"

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

--[Projectiles]--
SWEP.Primary.Round = "waw_trap_electrip"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_waw/electrip/w_electrip.mdl"
SWEP.Velocity = 0

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
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZUniqueWeapon = true
SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/hud_icon_electrip.png", "smooth unlitgeneric")
SWEP.NZNoLowAmmo = true
SWEP.Primary.MaxAmmo = 1

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

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
}

SWEP.RunSightsPos = Vector(0, -1, -0.5)
SWEP.RunSightsAng = Vector(-10, 0, 0)

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local cl_defaultweapon = GetConVar("cl_defaultweapon")
local sp = game.SinglePlayer()

function SWEP:Equip(ply, ...)
	local ammo = self:GetPrimaryAmmoType()
	if ply:GetAmmoCount(ammo) + self:Clip1() > 2 then
		ply:SetAmmo(1, self:GetPrimaryAmmoType())
	end
	return BaseClass.Equip(self, ply, ...)
end

function SWEP:NotifyPlaceMessage(bool)
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "COULD NOT FIND AREA TO PLACE")
		ply._TFA_LastJamMessage = RealTime() + 1
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if nzombies then
		if status == TFA.Enum.STATUS_THROW_WAIT and self:GetStatusEnd() < CurTime() and ply:GetAmmoCount(self:GetPrimaryAmmoType()) <= 0 and self:Clip1() <= 0 then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			if SERVER then
				local class = self:GetClass()
				timer.Simple(0, function()
					if not IsValid(ply) then return end
					ply:StripWeapon(class)
				end)
			end
		end

		local ply = self:GetOwner()
		if IsValid(ply) and ply:IsPlayer() and self:Clip1() > 0 and ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 1 then
			ply:SetAmmo(1, self:GetPrimaryAmmoType())
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:Throw(...)
	local ply = self:GetOwner()
	local tr = util.QuickTrace(ply:GetPos(), vector_up*-64, {ply, self})
	if not tr.Hit then
		self:NotifyPlaceMessage()
		return
	end
	return BaseClass.Throw(self,...)
end

function SWEP:PreSpawnProjectile(ent)
	local ply = self:GetOwner()
	local tr = util.QuickTrace(ply:GetPos(), vector_up*-64, {ply, self})
	ent:SetPos(tr.HitPos)

	local ang = self:GetAimVector():Angle()
	ent:SetAngles(Angle(0, ang[2], 0))

	local ratio = (self:Clip2() / self.Secondary_TFA.ClipSize) * 100
	ent:SetMaxHealth(nzombies and 500 or 100)
	ent:SetHealth(math.Round(ratio * (nzombies and 5 or 1)))
	ent:SetTrapClass(self:GetClass())
end
