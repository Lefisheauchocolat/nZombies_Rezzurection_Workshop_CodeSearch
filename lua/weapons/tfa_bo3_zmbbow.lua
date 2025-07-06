local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_bow_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Fully charge to shoot a twice as powerfull shot, consumes 2 ammo"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = "Wrath of the Ancients"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/zmbbow/c_zmbbow.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/zmbbow/w_zmbbow.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5.5,
        Right = 10,
        Forward = 10,
        },
        Ang = {
		Up = 30,
        Right = 0,
        Forward = -80
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_ZMBBOW.Fire"
SWEP.Primary.Sound_Blocked = ""
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.Damage = nzombies and 1200 or 115
SWEP.Primary.Damage_Charge = {0.5, 1}
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Velocity = 2000 --velocity in m/s
SWEP.Primary.Velocity_Charge = {0.25, 1}
SWEP.Primary.DamageType = bit.bor(DMG_BLAST, DMG_AIRBOAT)
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Bow]--
SWEP.ChargeRate = 33 / 30 --1 is fully charged
SWEP.ChargeThreshold = 0.01 --minimum charge percent to fire

SWEP.Primary.Shake = false
SWEP.ShakeTime = math.huge
SWEP.Secondary.Cancel = true
SWEP.Secondary.IronSightsEnabled = false

SWEP.UseBallistics = true
SWEP.BulletModel = "models/weapons/tfa_bo3/zmbbow/zmbbow_projectile.mdl"
SWEP.BulletTracer = ""

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread = 0.001
SWEP.Primary.SpreadShake = 0.05 --when shaking

SWEP.Primary.KickUp				= 0.3
SWEP.Primary.KickDown 			= 0.3
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor = 0.4

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 4
SWEP.Primary.SpreadRecovery = 3

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

--[Projectile]--
SWEP.Primary.Projectile			= "bo3_ww_zmbbow"
SWEP.Primary.ProjectileVelocity = 4000
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo3/zmbbow/zmbbow_projectile.mdl"

--[Misc]--
SWEP.AmmoTypeStrings = {xbowbolt = "Explosive Arrows"}
SWEP.InspectPos = Vector(3, -2, -3)
SWEP.InspectAng = Vector(24, 5, 12)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.TracerCount = 1

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 4
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 5

--[NZombies]--
SWEP.NZPaPName = "Mirroc Lu Kreemahogra" //Solar Eclipse (literally "Light of Eclipse")
SWEP.NZWonderWeapon = false
SWEP.NZUniqueWeapon = true
SWEP.Primary.MaxAmmo = 60

function SWEP:NZMaxAmmo()

	local ammo_type = self:GetPrimaryAmmoType() or self.Primary_TFA.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
	end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.Damage = 3000
self.Primary_TFA.MaxAmmo = 75
self.Primary_TFA.DamageType = bit.bor(DMG_BURN, DMG_DISSOLVE)
self.MoveSpeed = 1.0
self:ClearStatCache()
return true
end

--[Animations]--
SWEP.BowAnimations = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "fire",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["cancel"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "draw_cancel",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["draw"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "draw",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["idle_charged"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "draw_loop",
		["enabled"] = true
	},
}

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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZMBBOW.Draw") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZMBBOW.Reload") },
},
[ACT_VM_PULLBACK_HIGH] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZMBBOW.Pullback") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZMBBOW.DrawLoop") },
},
[ACT_VM_PULLBACK_LOW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZMBBOW.Cancel") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.WW3P_FX = "bo3_zmbbow_3p"
SWEP.WW3P_ATT = 1

--[Sauce]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Shoot()
	if self:GetStatL("Primary.Sound") and IsFirstTimePredicted() and not (sp and CLIENT) then
		if self:GetStatL("Primary.SilencedSound") and self:GetSilenced() then
			self:EmitSound(self:GetStatL("Primary.SilencedSound"))
		else
			self:EmitSound(self:GetStatL("Primary.Sound"))
		end
	end

	self:StopSound("TFA_BO3_ZMBBOW.Pullback")
	self:StopSound("TFA_BO3_ZMBBOW.DrawLoop")

	self:TakePrimaryAmmo(self:GetStatL("Primary.AmmoConsumption") + math.Clamp(self:GetCharge(), 0, 1))
	self:PlayAnimation(self.BowAnimations.shoot)
	self:ShootBulletInformation()
	self:SetCharge(0)
	self:SetShaking(false)
	self:ScheduleStatus(TFA.Enum.STATUS_BOW_SHOOT, self:GetActivityLength())
end

local multdmg, num_bullets, aimcone
function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone, disablericochet, bulletoverride)
	if not IsFirstTimePredicted() and not game.SinglePlayer() then return end
	local chargeTable = self:GetStatL("Primary.Damage_Charge")
	local chargeTable2 = self:GetStatL("Primary.Velocity_Charge")
	local multvel = Lerp(math.Clamp(self:GetCharge() - self.ChargeThreshold, 0, 1 - self.ChargeThreshold) / (1 - self.ChargeThreshold), chargeTable2[1], chargeTable2[2])
	local mult = 1 - math.Clamp(self:GetCharge() - self.ChargeThreshold, 0, 1 - self.ChargeThreshold) / (1 - self.ChargeThreshold)

	if self:GetCharge() < 1 then
		multdmg = chargeTable[1]
	else
		multdmg = chargeTable[2]
	end

	num_bullets = num_bullets or 1
	aimcone = aimcone or 0

	self:SetLastGunFire(CurTime())

	if SERVER then
		for _ = 1, num_bullets do
			local ent = ents.Create(self:GetStatL("Primary.Projectile"))
			local ang = self:GetOwner():GetAimVector():Angle()

			ent:SetPos(self:GetOwner():GetShootPos())
			ent:SetOwner(self:GetOwner())
			ent:SetAngles(ang)

			ent:SetCharge(self:GetCharge())

			ent.damage = self:GetStatL("Primary.Damage") * multdmg
			ent.mydamage = self:GetStatL("Primary.Damage") * multdmg
			ent.damagetypes = self:GetStatL("Primary.DamageType")

			ent:SetMult(multdmg)

			ent:SetModel(self:GetStatL("Primary.ProjectileModel"))

			self:PreSpawnProjectile(ent)
			ent:Spawn()

			local dir = ang:Forward()
			dir:Mul(self:GetStatL("Primary.ProjectileVelocity"))
			dir:Mul(multvel)

			ent:SetVelocity(dir)

			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(dir + (VectorRand(-80,80) * mult))
			end

			ent:SetOwner(self:GetOwner())
			self:PostSpawnProjectile(ent)
		end
		return
	end
end

local tpfx_cvar = GetConVar("cl_tfa_fx_wonderweapon_3p")
function SWEP:DrawWorldModel(...)
	if tpfx_cvar:GetBool() then
		if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX = CreateParticleSystem(self, tostring(self.WW3P_FX), PATTACH_POINT_FOLLOW, tonumber(self.WW3P_ATT))
		end
		if self.WW3P_CALLBACK then
			self:WW3P_CALLBACK(self, ply)
		end
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_BO3_ZMBBOW.DrawLoop")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_ZMBBOW.DrawLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster( ... )
	self:StopSoundNet("TFA_BO3_ZMBBOW.DrawLoop")
	return BaseClass.Holster(self,...)
end