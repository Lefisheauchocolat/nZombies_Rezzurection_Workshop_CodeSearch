local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Conceptualized by ZCTxCHAOSx. \nFrom the World at War custom map '420 Laboratory' by ZCTxCHAOSx"
SWEP.Author = "ZCTxCHAOSx, FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Laser Colt | WAW" or "Laser Colt"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/laser/c_laser45.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/laser/w_laser45.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -4.5,
		Right = 1.2,
		Forward = 14,
	},
	Ang = {
		Up = -180,
		Right = 190,
		Forward = 0
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_LASER45.Shoot"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1400
SWEP.Primary.Damage = nzombies and 40 or 4
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Knockback = 0
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect = "tfa_waw_muzzleflash_lasercolt"
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
SWEP.MainBullet = SWEP.MainBullet or {}
SWEP.MainBullet.Distance = 1000 //overwrites TFA bullet range

SWEP.Primary.Range = 1000
SWEP.Primary.DisplayFalloff = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "hu", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 200, damage = 1.0},
		{range = 1000, damage = 0.5},
	}
}

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
SWEP.Primary.Spread		  = .001
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 1
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 1

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-3.21, -1, 1.62)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.VMOffsetWalk = Vector(-1.4, -1, -1)
SWEP.RunSightsPos = Vector(0, -4, -3)
SWEP.RunSightsAng = Vector(0, 0, 0)
SWEP.InspectPos = Vector(6, -4, 0)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.MaxPenetrationCounter = 0
SWEP.SmokeParticle = nil
SWEP.TracerName = nil
SWEP.TracerCount = 0
SWEP.ImpactDecal = "FadingScorch"

--[NZombies]--
SWEP.NZPaPName = "Dirty Harry"
SWEP.NZWonderWeapon = true
SWEP.NZDontRegen = true
SWEP.Primary.MaxAmmo = 0

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.DamagePAP = 12
SWEP.Primary.ClipSizePAP = 250
SWEP.MuzzleFlashEffectPAP = "tfa_waw_muzzleflash_lasercolt_pap"

function SWEP:OnPaP()
self.Ispackapunched = true

self.MuzzleFlashEffect = "tfa_waw_muzzleflash_lasercolt_pap"
self.Primary_TFA.Damage = 115
self.Primary_TFA.ClipSize = 250
self.Primary_TFA.RangeFalloffLUT = {
	bezier = false,
	range_func = "linear",
	units = "hu",
	lut = {
		{range = 400, damage = 1.0},
		{range = 1000, damage = 0.5},
	}
}

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
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

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.OverheatTime = 6

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "HasEmitSound")
	self:NetworkVarTFA("Bool", "OverHeating")
end

function SWEP:Deploy(...)
	if SERVER and self:GetOwner():IsPlayer() then
		local time = 0.1
		if nzombies and self:GetOwner():HasPerk('time') then
			time = 0.08
		end

		timer.Create("waw_lasercolt_reload" ..self:EntIndex(), time, 0, function()
			if not IsValid(self) then return end
			if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then return end

			if self:Clip1() < self.Primary_TFA.ClipSize then self:SetClip1(math.min(self:Clip1() + 1, self.Primary_TFA.ClipSize)) else return end
		end)
	end

	return BaseClass.Deploy(self,...)
end

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !self:CanPrimaryAttack() then return end

	if !self:GetHasEmitSound() and ply:IsPlayer() then
		self:SetHasEmitSound(true)

		if self:VMIV() and self:IsFirstPerson() then
			self:EmitSound("TFA_WAW_LASER45.Trigger")
			self.OwnerViewModel:StopParticles()
		end

		if IsFirstTimePredicted() then
			local tr = util.QuickTrace(ply:GetShootPos(), self:GetAimVector()*self.Primary.Range, {ply, self})

			local fx = EffectData()
			fx:SetStart(ply:GetShootPos())
			fx:SetOrigin(tr.HitPos)
			fx:SetEntity(self)
			fx:SetAttachment(1)
			fx:SetFlags(self.Ispackapunched and 2 or 1)

			TFA.Effects.Create("tfa_waw_lasercolt_beam", fx)

			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))

			/*if self:VMIV() and self:IsFirstPerson() then
				ParticleEffectAttach("waw_lasercolt_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
				ParticleEffectAttach("waw_lasercolt_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
			end*/
		end
	elseif ply:IsNPC() then
		local tr = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector()*self.Primary.Range, {ply, self})

		local fx = EffectData()
		fx:SetStart(ply:GetShootPos())
		fx:SetOrigin(tr.HitPos)
		fx:SetEntity(self)
		fx:SetAttachment(1)
		fx:SetFlags(self.Ispackapunched and 2 or 1)
		fx:SetMagnitude((tr.Hit and !tr.HitSky) and 2 or 1)
		fx:SetNormal(tr.HitNormal)

		TFA.Effects.Create("tfa_waw_lasercolt_beam_npc", fx)
	end

	if nzombies and self:HasNZModifier("pap") then
		self.IsKnife = true
	end
end

function SWEP:PostPrimaryAttack()
	if self:Clip1() <= 0 then
		self:EmitSound("TFA_BO3_HYPE.Overheat")
		self:SetOverHeating(true)
		self:SetNextPrimaryFire(self:GetNextCorrectedPrimaryFire(self.OverheatTime))
	end

	if nzombies and self:HasNZModifier("pap") then
		self.IsKnife = false
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) ~= self.Primary.ClipSize then
			ply:SetAmmo(self.Primary.ClipSize, self:GetPrimaryAmmoType())
		end

		if self:GetOverHeating() and self:GetNextPrimaryFire() < CurTime() then
			self:SetOverHeating(false)
		end

		if self:GetHasEmitSound() and self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING then
			self:SetHasEmitSound(false)
			if IsFirstTimePredicted() then
				self:CleanParticles()
				if self:VMIV() and self:IsFirstPerson() then
					self:EmitSound("TFA_WAW_LASER45.Slide")
				end
			end
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:GetAmmoForceMultiplier()
	return 0.5
end

function SWEP:Reload()
	return false
end

local crosshair_flechette = Material("vgui/overlay/hud_flamethrower_reticle_t5.png", "smooth unlitgeneric")
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
local color_red = Color(255, 0, 0, 255)

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

	local teamcol = Color(255,255,255)
	if IsValid(targent) and tr.start:Distance(traceres.HitPos) < self:GetStatL("Primary.Range") then
		teamcol = self2.GetTeamColor(self, targent)
	end

	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa
	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	if self:GetOverHeating() then
		crosscol = ColorAlpha(color_red, crossa)
	end

	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_flechette)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
end