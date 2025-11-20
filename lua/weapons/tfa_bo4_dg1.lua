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
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Wunderwaffe DG-Scharfschütze | BO4" or "Wunderwaffe DG-Scharfschütze"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/dg1/c_dg1.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/dg1/w_dg1.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 1,
        Forward = 3.5,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_DG1.Shoot"
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.DamageType = DMG_SHOCK
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 300
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.HullSize = 5
SWEP.MuzzleFlashEffect = "tfa_bo4_muzzleflash_dg1"
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
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .0001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 4
SWEP.Primary.SpreadRecovery = 8

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.IronInSound = "weapon_bo3_gear.rattle"
SWEP.IronOutSound = "weapon_bo3_gear.rattle"
SWEP.Secondary.IronFOV = 40
SWEP.IronSightsPos = Vector(-3.93, -5, 0.873)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.45

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {ar2altfire = "#tfa.ammo.bo4ww.dg1"}
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""
SWEP.ImpactEffect = "tfa_bo4_impact_dg1"

--[NZombies]--
SWEP.NZPaPName = "Wunderwaffe DG-Funkenschütze"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 40

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 16
SWEP.Primary.MaxAmmoPAP = 80
SWEP.MuzzleFlashEffectPAP = "tfa_bo4_muzzleflash_dg1_2"
SWEP.ImpactEffectPAP = "tfa_bo4_impact_dg1_2"

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 16
self.Primary_TFA.MaxAmmo = 80
self.ImpactEffect = "tfa_bo4_impact_dg1_2"
self.MuzzleFlashEffect = "tfa_bo4_muzzleflash_dg1_2"
self:ClearStatCache()
return true
end

SWEP.CustomBulletCallback = function(ply, trace, dmginfo)
	local enemy = trace.Entity
	dmginfo:SetDamage(1)
	if SERVER and IsValid(enemy) and ((not nzombies and enemy:IsPlayer()) or enemy:IsNPC() or enemy:IsNextBot()) and enemy:Health() > 0 then
		local orb = ents.Create("bo4_ww_dg1")
		orb:SetModel("models/dav0r/hoverball.mdl")
		orb:SetPos(enemy:GetPos())
		orb:SetOwner(ply)
		orb:SetTarget(enemy)
		orb:SetAttacker(dmginfo:GetAttacker())
		orb:SetInflictor(dmginfo:GetInflictor())
		orb:SetAngles(Angle(0,0,0))
		orb:SetUpgraded(dmginfo:GetInflictor().Ispackapunched)

		if (enemy:IsPlayer() or enemy:IsNPC() or enemy:IsNextBot()) and trace.HitGroup == HITGROUP_HEAD then
			orb:SetHeadShot(true)
		end

		orb:Spawn()
		orb:SetOwner(ply)
	end
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 50 / 35,
	[ACT_VM_RELOAD_EMPTY] = 80 / 35,
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
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.Raise") },
{ ["time"] = 20 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.MagOut") },
{ ["time"] = 10 / 35, ["type"] = "lua", value = function(self) self:CleanParticles() end, client = true, server = false},
{ ["time"] = 40 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.MagIn") },
{ ["time"] = 50 / 35, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.MagOut") },
{ ["time"] = 10 / 35, ["type"] = "lua", value = function(self) self:CleanParticles() end, client = true, server = false},
{ ["time"] = 50 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.MagIn") },
{ ["time"] = 75 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO4_DG1.Raise") },
{ ["time"] = 80 / 35, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
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
	["scope"] = { type = "Model", model = "models/weapons/tfa_bo4/dg1/c_dg1_scope.mdl", bone = "tag_scope", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = true, bodygroup = {}},
}
SWEP.ViewModelBoneMods = {
	["tag_barrel_spin"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.Lights = {
	[4] = 3,
	[3] = 4,
	[2] = 5,
	[1] = 6,
}
SWEP.FP_FX = {}
SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

SWEP.StatCache_Blacklist = {
	["VElements"] = true,
}

--[Effects]--
DEFINE_BASECLASS( SWEP.Base )

local _sp = game.SinglePlayer()

function SWEP:Sway(pos, ang, ftv, ...)
	local spos, sang = BaseClass.Sway(self, pos * 1, ang * 1, ftv, ...)

	if self.IronSightsProgress > .01 then
		spos = Lerp(self.IronSightsProgress * .85, spos, pos)
		sang = Lerp(self.IronSightsProgress * .85, sang, ang)
	end

	return spos, sang
end

function SWEP:PostPrimaryAttack()
	if not self:VMIV() then return end

	if IsFirstTimePredicted() then
		ParticleEffectAttach(self.Ispackapunched and "bo4_dg1_vm_2" or "bo4_dg1_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
	end

	if _sp then
		if SERVER then
			self:CallOnClient("DisableLights", "")
		end
	else
		if CLIENT then
			self:DisableLights()
		end
	end
end

function SWEP:EnableLights()
	if SERVER then return end
	if not self:VMIV() then return end

	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		if self:CalcAmmoPap() >= keys[i] then
			if !self.FP_FX[i] or !IsValid(self.FP_FX[i]) then
				self.FP_FX[i] = CreateParticleSystem(self.OwnerViewModel, self.Ispackapunched and "bo4_dg1_bulbs_2" or "bo4_dg1_bulbs", PATTACH_POINT_FOLLOW, light[keys[i]])
			end
		end
	end
end

function SWEP:DisableLights()
	if SERVER then return end
	if not self:VMIV() then return end

	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		if self:CalcAmmoPap(self.Ispackapunched) < keys[i] then
			if self.FP_FX[i] and self.FP_FX[i]:IsValid() then
				self.FP_FX[i]:StopEmissionAndDestroyImmediately()
				break
			end
		end
	end
end

function SWEP:CalcAmmoPap(pap)
	if self.Ispackapunched then
		return math.Round((self:Clip1() + (pap and 1 or 0))/4)
	end
	return math.Round((self:Clip1() + (pap and 1 or 0))/2)
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)
		if self:Clip1() > 0 and self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(3)
			local up = self.Ispackapunched

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = up and 200 or 255
			self.DLight.g = up and 60 or 250
			self.DLight.b = up and 255 or 90
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5
			self.DLight.size = 80
			self.DLight.dietime = CurTime() + 1
		end
	end

	if self:GetIronSightsProgress() >= 0.9 then
		self.VElements["scope"].bodygroup = {[0] = 1}
	else
		self.VElements["scope"].bodygroup = {[0] = 0}
	end

	if CLIENT and self:VMIV() then
		self:DoSpin()
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:DoSpin()
	if not _sp and not IsFirstTimePredicted() then return end

	self.SpinAng = self.SpinAng or 0
	self.SpinSpeed = self.SpinSpeed or 10
		
	if self.SpinAng > 7200 then
		self.SpinAng = -7200
	end
	
	self.SpinAng = self.SpinAng - self.SpinSpeed

	self.ViewModelBoneMods["tag_barrel_spin"].angle = Angle(0, 0, -self.SpinAng)
end
