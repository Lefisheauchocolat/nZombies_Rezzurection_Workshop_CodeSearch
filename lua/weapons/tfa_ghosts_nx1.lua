local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Ghosts"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Slowly regenerates ammo over time"
SWEP.Author = "FlamingFox, Deika"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "NX-1 Disruptor | GHOSTS" or "NX-1 Disruptor"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSight = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_ghosts/nx1/c_nx1.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_ghosts/nx1/w_nx1.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 1.2,
        Forward = 13,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA.GHOSTS.NX1.Shoot"
SWEP.Primary.Sound_DryFire = "TFA.GHOSTS.NX1.Empty"
SWEP.Primary.Sound_Blocked = "TFA.GHOSTS.NX1.Empty"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 240
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 4000 or 400
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect  = "tfa_ghosts_muzzleflash_nx1"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

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

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.09 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2.0 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.25 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Projectile]--
SWEP.Primary.Projectile         = "ghosts_ww_nx1" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1200 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Spread Related]--
SWEP.Primary.Spread		  = .001
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.75

SWEP.Primary.KickUp				= 0.75
SWEP.Primary.KickDown 			= 0.75
SWEP.Primary.KickHorizontal		= 0.25
SWEP.Primary.StaticRecoilFactor = 0.4

SWEP.Primary.SpreadMultiplierMax = 100
SWEP.Primary.SpreadIncrement = 100
SWEP.Primary.SpreadRecovery = 85

SWEP.ChangeStateAccuracyMultiplier = 1.5 --1.5
SWEP.CrouchAccuracyMultiplier = 1.0 --0.5
SWEP.JumpAccuracyMultiplier = 3.0 --2
SWEP.WalkAccuracyMultiplier = 1.35 --1.35

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {gravity = "Zip Zaps"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "NX-2 Disassembler"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 10

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.MuzzleFlashEffectPAP = "tfa_ghosts_muzzleflash_nx1_pap"

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.MuzzleFlashEffect = "tfa_ghosts_muzzleflash_nx1_pap"
self.ChargeDelay = 4.5
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
}

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
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA.GHOSTS.NX1.Raise") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA.GHOSTS.NX1.Charge") },
}
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5

SWEP.ViewModelBoneMods = {
	["j_maintube"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["j_tube1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.CenterGlow = Color(50, 150, 255)
SWEP.ChargeDelay = 5

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

SWEP.SpinAltSpeed = 0.5
SWEP.SpinAltAng = 0

SWEP.StatCache_Blacklist = {
	["Primary.Projectile"] = true,
	["Primary.ProjectileVelocity"] = true,

	["Primary.AmmoConsumption"] = true,

	["Primary.KickUp"] = true,
	["Primary.KickDown"] = true,
	["Primary.KickHorizontal"] = true,
	["Primary.StaticRecoilFactor"] = true,
}

--[Chargeup]-- Credit to DBot
DEFINE_BASECLASS( SWEP.Base )

local sp = game.SinglePlayer()
local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local pvp_bool = GetConVar("sbox_playershurtplayers")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Bool", "GunChargedUp")
	self:NetworkVarTFA("Float", "NextAmmoRegen")
end

function SWEP:Deploy(...)
	self:SetGunChargedUp(false)
	local ply = self:GetOwner()
	if SERVER and IsValid(ply) and ply:IsPlayer() then
		timer.Create("nx1_reload"..self:GetClass()..ply:EntIndex(), (self.Ispackapunched and 1 or 2), 0, function()
			if not IsValid(self) then return end
			if self:GetNextAmmoRegen() > CurTime() then return end
			if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then return end

			if self:Clip1() < self.Primary_TFA.MaxAmmo then
				self:SetClip1(math.min(self:Clip1() + 1, self.Primary_TFA.MaxAmmo))
			else
				return
			end

			if self:Clip1() == self.Primary_TFA.MaxAmmo then
				self:EmitSound("TFA.GHOSTS.NX1.Empty")
			end
		end)
	end

	return BaseClass.Deploy(self, ...)
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm)
	if self.Ispackapunched then
		if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
			vm:SetSubMaterial(0, self.nzPaPCamo)
		end
		vm:SetSubMaterial(4, "models/weapons/tfa_ghosts/nx1/mtl_weapon_cortex_launcher_energy_pap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(4, nil)
	end
end

function SWEP:AltAttack()
	if self:GetSprinting() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	if not self:CanPrimaryAttack() then return end
	if self:GetStatus() == TFA.Enum.STATUS_CHARGE_UP then return end
	if self:Clip1() < self.Primary_TFA.ClipSize then return end

	if self:GetStatus() ~= TFA.Enum.STATUS_CHARGE_UP then
		self:SendViewModelAnim(ACT_VM_PULLBACK)
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_UP, self:GetActivityLength() - 0.45)
		self:SetNextPrimaryFire(CurTime())
	end
end

function SWEP:PrePrimaryAttack()
	if self:GetStatus() == TFA.Enum.STATUS_CHARGE_UP then
		self.ChargedUp = true

		self:StopSound("TFA.GHOSTS.NX1.Charge")
		self:StopSoundNet("TFA.GHOSTS.NX1.Charge")

		self.LastAmmoConsumption = self.Primary_TFA.AmmoConsumption

		self.Primary_TFA.KickUp = 1.5
		self.Primary_TFA.KickDown = 1.5
		self.Primary_TFA.KickHorizontal = 0.5

		self.Primary_TFA.AmmoConsumption = math.min(self.Primary_TFA.ClipSize, 10)
		self.Primary_TFA.ProjectileVelocity = 500
	end
end

function SWEP:PostPrimaryAttack()
	self:EmitGunfireSound("TFA.GHOSTS.NX1.Shoot.Big")

	if self.ChargedUp then
		self.ChargedUp = nil

		local ply = self:GetOwner()
		local mult = 1
		if nzombies and IsValid(ply) and ply:IsPlayer() and ply:HasPerk("time") then
			mult = 0.8
		end

		self:SetNextAmmoRegen(CurTime() + (self.ChargeDelay*mult))
		self:EmitGunfireSound("TFA.GHOSTS.NX1.Lfe.Big")
		self:EmitSound("TFA.GHOSTS.NX1.ChargeDown")

		self.Primary_TFA.KickUp = 0.75
		self.Primary_TFA.KickDown = 0.75
		self.Primary_TFA.KickHorizontal = 0.25

		self.Primary_TFA.AmmoConsumption = self.LastAmmoConsumption or 1
		self.Primary_TFA.ProjectileVelocity = 1400

		self:ClearStatCache()
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetCharged(tobool(self.ChargedUp))
	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight then
			local attpos = (self:IsFirstPerson() and self.OwnerViewModel or self):GetAttachment(2)
			local mult = 1
			if self:GetStatus() == TFA.Enum.STATUS_CHARGE_UP then
				mult = 2 * math.max(0.5, self:GetStatusProgress())
			end

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or ply:GetShootPos()
			self.DLight.r = self.CenterGlow.r
			self.DLight.g = self.CenterGlow.g
			self.DLight.b = self.CenterGlow.b
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5 * mult
			self.DLight.size = 64 * mult
			self.DLight.dietime = CurTime() + 0.5
		end
	end

	if nzombies and ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) ~= self.Primary_TFA.DefaultClip then
			ply:SetAmmo(self.Primary_TFA.DefaultClip, self:GetPrimaryAmmoType())
		end
	end

	if status == TFA.Enum.STATUS_CHARGE_UP then
		//self.SpinSpeed = self:GetStatusProgress() * 15
		self.SpinAltSpeed = math.Clamp(self:GetStatusProgress() * 15, math.max(self.SpinAltSpeed, 1), 15)
	elseif self.SpinAltSpeed > 0.5 then
		self.SpinAltSpeed = math.Approach(self.SpinAltSpeed, 0.5, FrameTime()*8)
	end

	//self:DoSpin()
	self:DoAltSpin()

	if status == TFA.Enum.STATUS_CHARGE_UP and self:GetStatusEnd() <= CurTime() then
		self:PrimaryAttack()
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:Reload()
	return false
end

function SWEP:DoAltSpin()
	if not sp and not IsFirstTimePredicted() then return end

	self.SpinAltAng = self.SpinAltAng or 0
	self.SpinAltSpeed = self.SpinAltSpeed or 10
		
	if self.SpinAltAng > 7200 then
		self.SpinAltAng = -7200
	end
	
	self.SpinAltAng = self.SpinAltAng - self.SpinAltSpeed

	self.ViewModelBoneMods["j_maintube"].angle = Angle(0, 0, -self.SpinAltAng)
end

/*function SWEP:DoSpin()
	if not CLIENT then return end
	if not sp and not IsFirstTimePredicted() then return end

	self.SpinAng = self.SpinAng or 0
	self.SpinSpeed = self.SpinSpeed or 10
		
	if self.SpinAng > 7200 then
		self.SpinAng = -7200
	end
	
	self.SpinAng = self.SpinAng - self.SpinSpeed

	if self.SpinSpeed > 0 then
		self.SpinSpeed = self.SpinSpeed * 0.98
	elseif self.SpinSpeed < 0 then
		self.SpinSpeed = 0
	end

	self.ViewModelBoneMods["j_maintube"].angle = Angle(0, 0, -self.SpinAng)
end*/
