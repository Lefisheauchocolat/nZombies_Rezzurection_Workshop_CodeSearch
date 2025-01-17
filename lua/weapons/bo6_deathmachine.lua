local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = false
SWEP.Purpose = "BO1 Deathmachine with an updated look by JBird632. \nFrom the Black Ops 3 custom map 'Leviathan'"
SWEP.Author = "Hari, JBird632, FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = "Chopper Turret"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = true
SWEP.DrawWeaponInfoBox = true
SWEP.NZSpecialCategory = "misc"
SWEP.Type_Displayed = "Misc"
SWEP.AutoSwitchTo		= false		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom		= true		-- Auto switch from if you pick up a better weapon

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/deathmachine/c_deathmachine.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModel			= "models/weapons/tfa_bo3/deathmachine/w_deathmachine.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(-8, -5, 1)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5,
        Right = 2,
        Forward = -8,
        },
        Ang = {
		Up = 90,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("TFA_BO3_M134.Stop")
SWEP.Primary.LoopSound = Sound("TFA_BO3_M134.Loop")
SWEP.Primary.LoopSoundTail = Sound("TFA_BO3_M134.Stop")
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1200
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 100
SWEP.Primary.Knockback = 1
SWEP.Primary.NumShots = 3
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 1
SWEP.Primary.ClipSize = 999999
SWEP.Primary.DefaultClip = 999999
SWEP.Primary.DryFireDelay = 0.35
SWEP.Primary.HullSize = 64
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

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
SWEP.Primary.DisplayFalloff = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 15, damage = 1.0},
		{range = 45, damage = 0.666},
	}
}

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

--[Spread Related]--
SWEP.Primary.Spread		  = .06
SWEP.Primary.IronAccuracy = .06
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.15
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 2

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/tfa/rifleshell.mdl"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
SWEP.InspectPos = Vector(-1, -6, -3)
SWEP.InspectAng = Vector(20, 5, 0)
SWEP.MoveSpeed = 0.85
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.AmmoRegen = 3

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
end

if nzombies then
	SWEP.CustomBulletCallback = function(ply, tr, dmg)
		if CLIENT then return end
		local ent = tr.Entity
		if IsValid(ent) and ent:IsValidZombie() then
			local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
			local health = tonumber(nzCurves.GenerateHealthCurve(round))
			dmg:SetDamage(health / 3)

			if (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss")) then
				dmg:SetDamage(math.max(200, ent:GetMaxHealth() / 80))
			end
		end
	end
end

--[Tables]--
SWEP.StatusLengthOverride = {
}

SWEP.RunSightsPos = Vector(1, -3, 3)
SWEP.RunSightsAng = Vector(-15, 30, 5)

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_M134.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_M134.Raise") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.ViewModelBoneMods = {
	["tag_barrel_spin"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "SpinTime")

	self:NetworkVarTFA("Bool", "IsSpinning")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

function SWEP:PreDrawViewModel(vm)
	if self.Ispackapunched then
		vm:SetSubMaterial(2, self.nzPaPCamo)
		vm:SetSubMaterial(3, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
	else
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(4, nil)
	end
end

function SWEP:GetAmmoRicochetMultiplier()
	return 1
end

function SWEP:GetAmmoForceMultiplier()
	return 1
end

function SWEP:Deploy(...)
	if SERVER and self.IsFirstDeploy then
		local ply = self:GetOwner()
		local damage = DamageInfo()
		damage:SetAttacker(ply)
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_MISSILEDEFENSE)

		for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 200)) do
			if v:IsNPC() or v:IsNextBot() then
				if v == ply then continue end
				if nzombies and (v.NZBossType or string.find(v:GetClass(), "nz_zombie_boss")) then continue end

				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

				v:TakeDamageInfo(damage)
			end
		end
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:CanPrimaryAttack(...)
	local ply = self:GetOwner()
	
	if IsValid(ply) and ply:IsPlayer() then
		if self:GetSpinTime() < 1 then
			return false
		end
	end

	return BaseClass.CanPrimaryAttack(self,...)
end

function SWEP:CanSpinUp()
    stat = self:GetStatus()

    if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:IsSafety() then
		return false
	end

    return true
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()

	if CLIENT and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			self.SpinSpeed = math.Approach(self.SpinSpeed, 20, FrameTime()*60)
		end
		self:DoSpin()
	end

	if CLIENT and sp then
        return BaseClass.Think2(self,...)
	end

	if IsValid(ply) and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			if not self:GetIsSpinning() then
				if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_M134.SpinStart") end
			end

			self:SetIsSpinning(true) 
		else
			if l_CT() > self:GetNextPrimaryFire() or self.Primary.Automatic then
				if self:GetIsSpinning() then
					if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_M134.SpinStop") end
				end

				self:SetIsSpinning(false)
			end
		end

		if self:GetIsSpinning() then
			self:SetSpinTime(self:GetSpinTime() + (FrameTime() / 0.4))

			if self:GetSpinTime() >= 1 then
				self:EmitSoundNet("TFA_BO3_M134.SpinLoop")

				if not (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) then
					self:SetIsSpinning(false)
				end
			end 
		else
			self:SetSpinTime(0)
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:DoSpin()
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

	self.ViewModelBoneMods["tag_barrel_spin"].angle = Angle(0, 0, -self.SpinAng)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_BO3_M134.SpinLoop")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_M134.SpinLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSoundNet("TFA_BO3_M134.SpinLoop")
	return BaseClass.Holster(self,...)
end
