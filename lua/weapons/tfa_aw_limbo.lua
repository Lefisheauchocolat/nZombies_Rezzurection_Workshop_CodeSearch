local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Advanced Warfare"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "Bluntstuffy, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "LZ-52 Limbo | AW" or "LZ-52 Limbo"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_aw/linegun/c_linegun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_aw/linegun/w_linegun.mdl"
SWEP.HoldType = "crossbow"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -5,
		Right = 1,
		Forward = 13,
	},
	Ang = {
		Up = 180,
		Right = 185,
		Forward = 0
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_AW_LIMBO.Arc"
SWEP.Primary.SoundLyr1 = "TFA_AW_LIMBO.Glitch"
SWEP.Primary.SoundLyr2 = "TFA_AW_LIMBO.Burst"
SWEP.Primary.Ammo = "Gravity"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 120
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_Displayed = 60
SWEP.Primary.Damage = nzombies and 1500 or 350
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 12
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect  = "tfa_aw_muzzleflash_limbo"
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
SWEP.IronRecoilMultiplier = 0.75
SWEP.CrouchAccuracyMultiplier = 1.0

SWEP.Primary.KickUp				= 0.8
SWEP.Primary.KickDown			= 0.8
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 60
SWEP.IronSightsPos = Vector(-5.242, 0, 0.435)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.35

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "aw_ww_linegun" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 300 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_aw/linegun/linegun_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {gravity = "Spheres"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "LZR"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 16

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary_TFA.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.DamagePAP = 700
SWEP.MuzzleFlashEffectPAP = "tfa_aw_muzzleflash_limbo_pap"

function SWEP:OnPaP()
self.Ispackapunched = true

self.Primary_TFA.Damage = 2500
self.Primary_TFA.MaxAmmo = 32

self.MoveSpeed = 0.975

self.MuzzleFlashEffect = "tfa_aw_muzzleflash_limbo_pap"

self.Skin = 1
self:SetSkin(1)

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 65 / 30,
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
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Lift") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	self:CallOnClient("ResetToothFX", "")
end, client = false, server = true},
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Lift") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Open") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Motor") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Eject") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Mag") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.MagIn") },
{ ["time"] = 70 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Close") },
{ ["time"] = 75 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_LIMBO.Reload.Charge") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.Attachments = {
	[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.NextSparkCycle = 0
SWEP.NextWorldSparkCycle = 0
SWEP.CurrentCycle = 0
SWEP.MaxSparkCycles = 3
SWEP.CurrentTooth = 0

SWEP.LastFireAlt = false
SWEP.RotateVelocity = Vector(10,0,0)
SWEP.ReticleTexture = Material("models/weapons/tfa_aw/linegun/mtl_zom_line_gun_ret.vmt")
SWEP.ReticleColor = Vector(1, 0, 0)
SWEP.ReticleColorPaP = Vector(0, 1, 0)

DEFINE_BASECLASS( SWEP.Base )

local _sp = game.SinglePlayer()

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)

		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(2, self.nzPaPCamo)
	else
		self.Skin = 0
		self:SetSkin(0)

		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
	end

	if self:GetIronSightsProgress() > 0.8 then
		self.ReticleTexture:SetVector("$color2", self.Ispackapunched and self.ReticleColorPaP or self.ReticleColor)
	else
		self.ReticleTexture:SetVector("$color2", vector_origin)
	end

	if self:GetNextPrimaryFire() > CurTime() or (self.NextSparkCycle < CurTime() and not TFA.Enum.ReadyStatus[self:GetStatus()]) then
		self.NextSparkCycle = CurTime() + 0.5
	end

	if self.NextSparkCycle < CurTime() then
		self:EmitSound("weapons/tfa_aw/linegun/wpn_linegun_coil_buzz_0"..math.random(9)..".wav", SNDLVL_IDLE, math.random(97,103), 0.1, CHAN_STATIC)

		self.NextSparkCycle = CurTime() + 0.05
		self.CurrentTooth = self.CurrentTooth + 1

		if self.CurrentTooth > 12 then
			self.CurrentCycle = self.CurrentCycle + 1
			self.CurrentTooth = 0
			self.NextSparkCycle = CurTime() + 0.2

			if self.CurrentCycle >= self.MaxSparkCycles then
				self.NextSparkCycle = CurTime() + math.Rand(3,6)
				self.MaxSparkCycles = math.random(2,4)
				self.CurrentCycle = 0
			end
			return
		end

		if DynamicLight then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

			if self.DLight then
				local attpos = vm:GetAttachment(self.CurrentTooth + 2)
				if attpos and attpos.Pos then
					self.DLight.pos = attpos.Pos
					self.DLight.r = self.Ispackapunched and 40 or 255
					self.DLight.g = self.Ispackapunched and 255 or 40
					self.DLight.b = 0
					self.DLight.decay = 1000
					self.DLight.brightness = 1
					self.DLight.size = 128
					self.DLight.dietime = CurTime() + 1
				end
			end
		elseif self.DLight then
			self.DLight.dietime = -1
		end

		self.ToothPCF = CreateParticleSystem(vm, self.Ispackapunched and "aw_limbo_tooth_2" or "aw_limbo_tooth", PATTACH_POINT_FOLLOW, self.CurrentTooth + 2)
	end
end

function SWEP:DrawWorldModel(...)
	BaseClass.DrawWorldModel(self, ...)

	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)
	elseif self.Skin == 1 then
		self.Skin = 0
		self:SetSkin(0)
	end

	if (!self.NextWorldSparkCycle or self.NextWorldSparkCycle < CurTime()) and (!self:IsCarriedByLocalPlayer() or !self:IsFirstPerson()) then
		if self.NextSparkCycle < CurTime() then
			self:EmitSound("weapons/tfa_aw/linegun/wpn_linegun_coil_buzz_0"..math.random(9)..".wav", SNDLVL_45dB, math.random(97,103), 0.5, CHAN_STATIC)
		end

		self.NextWorldSparkCycle = CurTime() + 0.06

		if DynamicLight then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

			if self.DLight then
				local attpos = self:GetAttachment(1)
				if attpos and attpos.Pos then
					local finalpos = attpos.Pos

					self.DLight.pos = finalpos
					self.DLight.r = self.Ispackapunched and 25 or 255
					self.DLight.g = self.Ispackapunched and 255 or 25
					self.DLight.b = 0
					self.DLight.decay = 2000
					self.DLight.brightness = 1
					self.DLight.size = 64
					self.DLight.dietime = CurTime() + 1
				end
			end
		elseif self.DLight then
			self.DLight.dietime = -1
		end
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
	ent:SetSkin(self.Ispackapunched and 1 or 0)
end

function SWEP:PostSpawnProjectile(ent)
	if self:GetIronSightsProgress() > 0.8 then return end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(self.LastFireAlt and -self.RotateVelocity or self.RotateVelocity)
	end

	self.LastFireAlt = !self.LastFireAlt
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	if ifp and ply:IsPlayer() and nzombies and self:HasNZModifier("pap") then
		nzSounds:PlayEnt("UpgradedShoot", ply)
	end
	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end
	local lyr2 = self:GetStatL("Primary.SoundLyr2")
	if lyr2 and ifp then
		self:EmitGunfireSound(lyr2)
	end

	if CLIENT then
		self.CurrentTooth = 0
	elseif SERVER and _sp then
		self:CallOnClient("ResetToothFX", "")
	end
end

function SWEP:ResetToothFX()
	self.CurrentTooth = 0
	if self.ToothPCF and IsValid(self.ToothPCF) then
		self.ToothPCF:StopEmission()
	end
end

function SWEP:OwnerChanged(...)
	if CLIENT then
		self.CurrentTooth = 0
	elseif SERVER and _sp then
		self:CallOnClient("ResetToothFX", "")
	end
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	if CLIENT then
		self.CurrentTooth = 0
	elseif SERVER and _sp then
		self:CallOnClient("ResetToothFX", "")
	end
	return BaseClass.Holster(self,...)
end

local crosshair_limbo = Material("vgui/overlay/linegun_reticle.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_limbo)

	local scale = ScreenScale(16)
	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - scale, y  - scale, scale*2, scale*2)
	else
		surface.DrawTexturedRect(ScrW() / 2 - scale, ScrH() / 2 - scale, scale*2, scale*2)
	end
end