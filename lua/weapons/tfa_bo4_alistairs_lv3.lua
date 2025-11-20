local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Alistair's Annihilator | BO4" or "Alistair's Annihilator"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/alistairs/c_alistairs_lvl3.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/alistairs/w_alistairs_lvl3.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1.5,
        Forward = 3,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_ALISTAIR.Shoot.Upg"
SWEP.Primary.SoundLyr1 = "TFA_BO4_RAYGUN.Lfe.Upg"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 181
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 900 or 150
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo4_muzzleflash_alistairs_anni"
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
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .02
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.6
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1.5
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 45
SWEP.IronSightsPos = Vector(-5.227, -5, -1.142)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_alistair" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {battery = "Goop"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZPaPName = "Alistair's Annihilator"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 96
SWEP.Ispackapunched = false

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
	end
end

function SWEP:OnPaP()
self.Ispackapunched = true
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 70 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerDown") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerUp") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerUp") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.Open") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.MagOut") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.MagIn") },
{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.Close") },
{ ["time"] = 95 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerDown") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.VElements = {
	["sprite"] = { type = "Sprite", sprite = "sprites/animglow01-", bone = "tag_fx_light", rel = "", pos = Vector(0,0,0), size = {x = 0.5, y = 0.5}, color = Color(155, 100, 255, 150), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true, active = true },
}

SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "idle",
	},
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "fire",
	}
}

SWEP.ChargeMaxTime = 1.5 --1 is fully charged

SWEP.ChargeSound = "TFA_BO4_ALISTAIR.Charge"
SWEP.ChargeSound2 = "TFA_BO4_ALISTAIR.Charge.Start"
SWEP.ChargeLoopSound = "TFA_BO4_ALISTAIR.Charge.Loop"
SWEP.HasPlayedChargeSound = false

SWEP.ChargeAnimations = {
	["idle_charged"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "charged_loop",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idle",
		["enabled"] = true --Manually force a sequence to be enabled
	},
}

SWEP.StatCache_Blacklist = {
	["Primary.Projectile"] = true,
	["Primary.Sound"] = true,
	["VElements"] = true,
}

DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
		vm:SetSubMaterial(5, self.nzPaPCamo)
		vm:SetSubMaterial(6, self.nzPaPCamo)
	else
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(5, nil)
		vm:SetSubMaterial(6, nil)
	end
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Int", "ChargeType")

	self:NetworkVarTFA("Float", "ChargeStart")
	self:NetworkVarTFA("Float", "TotalCharge")
end

local sp = game.SinglePlayer()
local ft

function SWEP:ResetCharge()
	if self:GetCurrentCharge() == 0 then return end
	self:SetChargeStart(0)
	self:SetTotalCharge(0)
	self.HasPlayedChargeSound = false
	self:StopSound(self.ChargeSound)
	self:StopSound(self.ChargeSound2)
	self:StopSound(self.ChargeLoopSound)
end

function SWEP:DrawHUDBackground()
	local mult = math.Clamp(self:GetCurrentCharge()*2, 1, 2)
	self.VElements["sprite"].size = { x = 1*mult, y = 1*mult }
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	ft = FrameTime()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(3)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 100
			self.DLight.g = 75
			self.DLight.b = 255
			self.DLight.decay = 1000
			self.DLight.brightness = math.Clamp(self:GetCurrentCharge(), 0.1, 1)
			self.DLight.size = 64 * math.Clamp(self:GetCurrentCharge(), 0.5, 1)
			self.DLight.dietime = CurTime() + 1
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	if ply:IsPlayer() then
		if self:GetIronSightsProgress() >= 0.9 then
			self.Bodygroups_V = {[1] = 1}
		else
			self.Bodygroups_V = {[1] = 0}
		end

		if self:GetCurrentCharge() > 0 and (not TFA.Enum.ReadyStatus[self:GetStatus()] and self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING) or self:GetSprinting() then
			self:CleanParticles()
		end

		if TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() then
			if self:GetCurrentCharge() == self.ChargeMaxTime and not self.HasPlayedChargeSound then
				self.HasPlayedChargeSound = true
				if IsFirstTimePredicted() then self:EmitSoundNet(self.ChargeLoopSound) end
				if IsValid(self) and self:VMIV() then
					if IsFirstTimePredicted() then ParticleEffectAttach("bo4_alistairs_vm_light", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3) end
				end
			end
			if self:GetCurrentCharge() > 0 and not ply:KeyDown(IN_ATTACK) then
				self:LaunchProjectile()
			end
		elseif self:GetCurrentCharge() > 0 then
			self:ResetCharge()
		end
	end

	BaseClass.Think2(self, ...)
end

function SWEP:LaunchProjectile()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	if self:GetCurrentCharge() == self.ChargeMaxTime then
		self:TakePrimaryAmmo(2)
		self:SetChargeType(self:GetChargeType()+1)

		if self:GetChargeType() == 1 then
			self.Primary_TFA.Projectile = "bo4_ww_alistair_toxic"
		elseif self:GetChargeType() == 2 then
			self.Primary_TFA.Projectile = "bo4_ww_alistair_storm"
		elseif self:GetChargeType() == 3 then
			self.Primary_TFA.Projectile = "bo4_ww_alistair_fireball"
		elseif self:GetChargeType() == 4 then
			self.Primary_TFA.Projectile = "bo4_ww_alistair_shrink"
		end

		self.Primary_TFA.Sound = "TFA_BO4_ALISTAIR.Shoot.Charged"
	end

	self:PrePrimaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self:TriggerAttack("Primary", 1)

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)

	if self:GetCurrentCharge() == self.ChargeMaxTime then
		if self:GetChargeType() >= 4 then self:SetChargeType(0) end

		self.Primary_TFA.Projectile = "bo4_ww_alistair"
		self.Primary_TFA.Sound = "TFA_BO4_ALISTAIR.Shoot.Upg"
	end

	self:ResetCharge()
end

function SWEP:ChooseIdleAnim(...)
	if self:GetCurrentCharge() > 0 and self.ChargeAnimations["idle_charged"] then
		return self:PlayAnimation(self.ChargeAnimations.idle_charged)
	end

	return BaseClass.ChooseIdleAnim(self, ...)
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not self:CanPrimaryAttack() then return end

	if not ply:IsPlayer() then
		return BaseClass.PrimaryAttack(self)
	end

	if self:GetChargeStart() <= 0 then
		if IsFirstTimePredicted() then self:EmitSoundNet(self.ChargeSound) end
		if IsFirstTimePredicted() then self:EmitSoundNet(self.ChargeSound2) end
		self:SendViewModelAnim(ACT_VM_PULLBACK_HIGH_BAKE)
		//self:ScheduleStatus(TFA.Enum.STATUS_PUMP , self:GetActivityLength())
		if IsValid(self) and self:VMIV() then
			if IsFirstTimePredicted() then ParticleEffectAttach("bo4_alistairs_vm_glow", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 5) end
		end

		self:SetChargeStart(CurTime())
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end
end

function SWEP:GetCurrentCharge()
	if self:GetChargeStart() == 0 then
		return 0
	else
		return math.min(CurTime() - self:GetChargeStart(), self.ChargeMaxTime)
	end
end

function SWEP:PreSpawnProjectile(ent)
	if self.Primary_TFA.Projectile == "bo4_ww_alistair" then
		ent:SetUpgrade(2)
	end
end
