local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "TFA Zombies Buildables"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.trap"
SWEP.Purpose = "#tfa.weaponinfo.miscbuild.drone.desc"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Maxis Drone | BO2" or "Maxis Drone"
SWEP.Purpose = "Work In Progress, very basic functionality and not actually and AI"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/drone/c_drone.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/drone/w_drone.mdl"
SWEP.HoldType = "slam"
SWEP.SprintHoldTypeOverride = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
	Up = 0,
	Right = 0,
	Forward = 0,
	},
	Ang = {
	Up = -180,
	Right = -180,
	Forward = 0
	},
	Scale = 0.9
}

--[Gun Related]--
SWEP.Primary.Automatic = false
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "none"
SWEP.Primary.RPM = 90
SWEP.Primary.Damage = 115
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.AmmoConsumption = 0
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.7

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .00
SWEP.Primary.IronAccuracy = .00
SWEP.IronRecoilMultiplier = 0.8

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown 			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor = 0.0

SWEP.Primary.SpreadMultiplierMax = 5
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 5

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellScale = 0
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo2_trap_drone"
SWEP.Primary.ProjectileVelocity = 0
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo2/drone/w_drone.mdl"
SWEP.Velocity = 0

--[Stuff]--
SWEP.InspectPos = Vector(2, 0, -2)
SWEP.InspectAng = Vector(15, -5, 0)
SWEP.AllowSprintAttack = true
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)
SWEP.DoMuzzleFlash = false
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/hud_quadrotor_tomb.png", "unlitgeneric smooth")

SWEP.TrapCanBePlaced = true
SWEP.TrapUseShootPos = true
SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

function SWEP:NZSpecialHolster(wep)
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
[ACT_VM_THROW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_ZMDRONE.Takeoff") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

DEFINE_BASECLASS(SWEP.Base)

function SWEP:NotifyPlaceMessage()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.miscbuild.drone.hint")
		ply._TFA_LastJamMessage = RealTime() + 1
	end
end

function SWEP:CanPrimaryAttack(...)
	local ply = self:GetOwner()
	if IsValid(ply) and IsValid(ply.MaxisDrone) then
		self:NotifyPlaceMessage()
		return false
	end

	return BaseClass.CanPrimaryAttack(self, ...)
end

function SWEP:Equip(ply, ...)
	if SERVER and IsValid(ply) and ply:IsPlayer() then
		timer.Create("bo2_drone_reload"..self:EntIndex(), 2, 0, function()
			if not IsValid(self) then return end
			if self:Clip1() < self.Primary.DefaultClip then self:SetClip1(math.min(self:Clip1() + 1, self.Primary.DefaultClip)) else return end
		end)
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	local ratio = (self:Clip1() / self.Primary_TFA.ClipSize) * 100
	ent:SetMaxHealth(500)
	ent:SetHealth(math.Round(ratio * 5))
	ent:SetTrapClass(self:GetClass())

	local ply = self:GetOwner()
	if IsValid(ply) then
		ply.MaxisDrone = ent
	end
end

function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	if nzombies then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
	end
	if SERVER then
		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(self) then return end
			ply:StripWeapon(self:GetClass())
		end)
	end
end

function SWEP:OnDrop(...)
	timer.Remove("bo2_drone_reload" ..self:EntIndex())
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	timer.Remove("bo2_drone_reload" ..self:EntIndex())
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:OnRemove(...)
	if SERVER and nzombies and nzWeps and nzWeps.Updated and not IsValid(ents.FindByClass("bo2_trap_drone")[1]) then
		for k, v in pairs(ents.FindByClass("nz_buildtable")) do
			if v:GetNW2Bool("MaxisDeployed", false) then
				local ratio = (self:Clip1() / self.Primary_TFA.ClipSize) * 100
				v:SetNW2Float("MaxisCooldown", CurTime() + ratio)
				break
			end
		end
		hook.Call("RespawnMaxisDrone")
	end
	timer.Remove("bo2_drone_reload" ..self:EntIndex())
	return BaseClass.OnRemove(self,...)
end