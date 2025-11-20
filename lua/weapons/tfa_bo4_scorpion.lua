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
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Death of Orion | BO4" or "Death of Orion"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/scorpion/c_scorpion.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/scorpion/w_scorpion.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 1.2,
        Forward = 3.5,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_SCORPION.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO4_SCORPION.Act"
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 181
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 115
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 45
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo4_muzzleflash_scorpion"
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
SWEP.Primary.Spread		  = .025
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.8
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1.5
SWEP.Primary.SpreadRecovery = 6

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
SWEP.Primary.Projectile         = "bo4_ww_scorpion" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {XBowBolt = "#tfa.ammo.bo4ww.scorp"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Serket's Kiss"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 45
SWEP.Ispackapunched = false

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
	end
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.MaxAmmo = 90
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
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
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Draw") },
{ ["time"] = 0, ["type"] = "lua", value = function(self) self:DoTheLights() end, client = true, server = true},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Draw") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self) self:DoTheLights() end, client = true, server = true},
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Raise") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Hissing") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
},
[ACT_VM_IDLE] = {
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Hissing") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
{ ["time"] = 120 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 120 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
{ ["time"] = 170 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 220 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
{ ["time"] = 220 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 240 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Hissing") },
{ ["time"] = 250 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
{ ["time"] = 250 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 270 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Chains") },
{ ["time"] = 280 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
{ ["time"] = 330 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_SCORPION.Movement") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5

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

SWEP.ChargeSound = "TFA_BO4_SCORPION.Charge"
SWEP.ChargeLoopSound = "TFA_BO4_SCORPION.ChargeLoop"
SWEP.HasPlayedChargeSound = false

SWEP.ChargeAnimations = {
	["idle_charged"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "charge_loop",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idle",
		["enabled"] = true --Manually force a sequence to be enabled
	},
}

DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(3, self.nzPaPCamo)
		vm:SetSubMaterial(7, self.nzPaPCamo)
		vm:SetSubMaterial(8, self.nzPaPCamo)
		vm:SetSubMaterial(9, self.nzPaPCamo)
		vm:SetSubMaterial(11, self.nzPaPCamo)
		vm:SetSubMaterial(15, self.nzPaPCamo)
		vm:SetSubMaterial(16, self.nzPaPCamo)
		vm:SetSubMaterial(17, self.nzPaPCamo)
	else
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(7, nil)
		vm:SetSubMaterial(8, nil)
		vm:SetSubMaterial(9, nil)
		vm:SetSubMaterial(11, nil)
		vm:SetSubMaterial(15, nil)
		vm:SetSubMaterial(16, nil)
		vm:SetSubMaterial(17, nil)
	end
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Int", "ChargeType")
	self:NetworkVarTFA("Float", "ChargeStart")
end

local sp = game.SinglePlayer()

function SWEP:DoTheLights()
	if not self:VMIV() then return true end
	timer.Simple(0, function()
		if IsValid(self) and self:VMIV() then
			if IsFirstTimePredicted() then
				ParticleEffectAttach("bo4_scorpion_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
				ParticleEffectAttach("bo4_scorpion_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 4)
				ParticleEffectAttach("bo4_scorpion_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
			end
		end
	end)
end

function SWEP:ResetCharge()
	if self:GetCurrentCharge() == 0 then return end
	self:SetChargeStart(0)
	self.HasPlayedChargeSound = false

	self:StopSound(self.ChargeSound)
	self:StopSound(self.ChargeLoopSound)

	self:DoTheLights()
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 255
			self.DLight.b = 50
			self.DLight.decay = 1000
			self.DLight.brightness = self:GetCharged() and 1 or 0.5
			self.DLight.size = self:GetCharged() and 64 or 32
			self.DLight.dietime = CurTime() + 1
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	if ply:IsPlayer() then
		if TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() then
			if self:GetCharged() and not self.HasPlayedChargeSound then
				self.HasPlayedChargeSound = true
				if IsFirstTimePredicted() then self:EmitSoundNet(self.ChargeLoopSound) end
				if IsValid(self) and self:VMIV() then
					if IsFirstTimePredicted() then ParticleEffectAttach("bo4_scorpion_charge", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2) end
				end
			end
			if self:GetCurrentCharge() > 0 and not ply:KeyDown(IN_ATTACK) then
				self:LaunchProjectile()
			end
		elseif self:GetCurrentCharge() > 0 then
			if self:GetSprinting() and CLIENT then
				self:CleanParticles()
			end
			self:ResetCharge()
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:LaunchProjectile()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	if self:GetCurrentCharge() == self.ChargeMaxTime then
		self:TakePrimaryAmmo(4)
	end

	self:PrePrimaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self:TriggerAttack("Primary", 1)

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)

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
		self:SendViewModelAnim(ACT_VM_PULLBACK)
		//self:ScheduleStatus(TFA.Enum.STATUS_PUMP , self:GetActivityLength())

		self:SetChargeStart(CurTime())
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp and self:GetCharged() then
		self:EmitGunfireSound(lyr1)
	end

	self:DoTheLights()
end

function SWEP:GetCurrentCharge()
	if self:GetChargeStart() == 0 then
		return 0
	else
		return math.min(CurTime() - self:GetChargeStart(), self.ChargeMaxTime)
	end
end

function SWEP:GetCharged()
	return self:GetCurrentCharge() == self.ChargeMaxTime
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetCharged(self:GetCharged())
end

local crosshair_crossbow = Material("vgui/overlay/reticle_crossbow.png", "smooth unlitgeneric")
local CMIX_MULT = 1
local c1t = {}
local c2t = {}

local function ColorMix(c1, c2, fac, t)
	c1 = c1 or color_white
	c2 = c2 or color_white
	c1t.r = c1.r
	c1t.g = c1.g
	c1t.b = c1.b
	c1t.a = c1.a
	c2t.r = c2.r
	c2t.g = c2.g
	c2t.b = c2.b
	c2t.a = c2.a

	for k, v in pairs(c1t) do
		if t == CMIX_MULT then
			c1t[k] = Lerp(fac, v, (c1t[k] / 255 * c2t[k] / 255) * 255)
		else
			c1t[k] = Lerp(fac, v, c2t[k])
		end
	end

	return Color(c1t.r, c1t.g, c1t.b, c1t.a)
end

local crosshair_cvar = GetConVar("cl_tfa_bo3ww_crosshair")
local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

function SWEP:DrawHUDBackground()
	if not crosshair_cvar:GetBool() then return end
	local self2 = self:GetTable()
	local x, y
	
	local ply = LocalPlayer()
	if not ply:IsValid() or self:GetOwner() ~= ply then return false end

	if not ply.interpposx then
		ply.interpposx = ScrW() / 2
	end

	if not ply.interpposy then
		ply.interpposy = ScrH() / 2
	end

	local tr = {}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 0x7FFF
	tr.filter = ply
	tr.mask = MASK_NPCSOLID
	local traceres = util.TraceLine(tr)
	local targent = traceres.Entity

	if self:GetOwner():ShouldDrawLocalPlayer() and not ply:GetNW2Bool("ThirtOTS", false) then
		local coords = traceres.HitPos:ToScreen()
		coords.x = math.Clamp(coords.x, 0, ScrW())
		coords.y = math.Clamp(coords.y, 0, ScrH())
		ply.interpposx = math.Approach(ply.interpposx, coords.x, (ply.interpposx - coords.x) * RealFrameTime() * 7.5)
		ply.interpposy = math.Approach(ply.interpposy, coords.y, (ply.interpposy - coords.y) * RealFrameTime() * 7.5)
		x, y = ply.interpposx, ply.interpposy
		-- Center of screen
	elseif sv_tfa_fixed_crosshair:GetBool() then
		x, y = ScrW() / 2, ScrH() / 2
	else
		tr.endpos = tr.start + self:GetAimAngle():Forward() * 0x7FFF
		local pos = util.TraceLine(tr).HitPos:ToScreen()
		x, y = pos.x, pos.y
	end

	local stat = self2.GetStatus(self)
	self2.clrelp = self2.clrelp or 0
	self2.clrelp = math.Approach(
		self2.clrelp,
		TFA.Enum.ReloadStatus[stat] and 0 or 1,
		((TFA.Enum.ReloadStatus[stat] and 0 or 1) - self2.clrelp) * RealFrameTime() * 7)

	local crossa = 255 * math.pow(math.min(1 - (((self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) and
		not self2.GetStatL(self, "DrawCrosshairIronSights")) and (self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) or 0),
		1 - self:GetSprintProgress(),
		1 - self:GetInspectingProgress(),
		self2.clrelp),
	2)

	teamcol = self2.GetTeamColor(self, targent)
	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa
	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_crossbow)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 64, y  - 64, 128, 128)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 64, ScrH() / 2 - 64, 128, 128)
	end
end