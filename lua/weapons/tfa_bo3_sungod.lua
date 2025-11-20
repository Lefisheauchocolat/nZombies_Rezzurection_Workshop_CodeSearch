local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Conceptualized by AwesomePieMan. \nFrom the World at War custom map 'Abandoned Rocket Base' by AwesomePieMan"
SWEP.Author = "AwesomePieMan, FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Solar Flare | BO3" or "Solar Flare"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/zapgun/c_wavegun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/zapgun/w_wavegun.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
        Right = 1,
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
SWEP.Primary.Sound = "TFA_BO3_SUNGOD.Shoot"
SWEP.Primary.Ammo = "SLAM"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 2000 or 200
SWEP.Primary.Knockback = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffectSilenced	= "tfa_bo3_muzzleflash_sungod"
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
SWEP.Primary.DisplayFalloff = false

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
SWEP.Primary.Spread		  = .06
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.85
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-4, -4, 0.8)
SWEP.IronSightsAng = Vector(0, -1.2, 0)
SWEP.IronSightTime = 0.45

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_sungod" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 2600 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Sun God"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 15

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 6

function SWEP:OnPaP()
self.Silenced = true
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 6
self.Primary_TFA.MaxAmmo = 30
self.Primary_TFA.Damage = 4000
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD_SILENCED] = 75 / 30,
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
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_RELOAD_SILENCED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleStart") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleMagOut") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleFutz") },
{ ["time"] = 70 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleMagIn") },
{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RiflePower") },
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

SWEP.Silenced = true
SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1},
}

SWEP.ChargeTime = 2
SWEP.ChargeDownTime = 9

SWEP.ChargeSound = "TFA_BO3_SUNGOD.Charge.Start"
SWEP.ChargeSoundSweet = "TFA_BO3_SUNGOD.Charge.Sweet"

SWEP.ChargeLoopSound = "TFA_BO3_SUNGOD.Charge.Loop"

SWEP.ChargeDownSound = "TFA_BO3_SUNGOD.Charge.Down"
SWEP.ChargeDownSoundSweet = "TFA_BO3_SUNGOD.Charge.Fail"

SWEP.HasPlayedChargeSound = false

DEFINE_BASECLASS( SWEP.Base )

local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Float", "ChargeStart")
end

function SWEP:Equip(ply, ...)
	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.miscww.sungod.hint")
		ply._TFA_LastJamMessage = RealTime() + 1
	end
	return BaseClass.Equip(self, ply, ...)
end

function SWEP:ResetCharge(playsound)
	if self:GetCurrentCharge() == 0 then return end

	if IsFirstTimePredicted() and playsound then
		self:EmitSound(self.ChargeDownSound)
		self:EmitSound(self.ChargeDownSoundSweet)
	end

	self:SetChargeStart(0)
	self.HasPlayedChargeSound = false

	self:StopSound(self.ChargeSound)
	self:StopSound(self.ChargeSoundSweet)
	self:StopSound(self.ChargeLoopSound)
end

function SWEP:AltAttack()
	if self:GetSprinting() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	if self:GetChargeStart() > 0 then return end

	local ply = self:GetOwner()
	if IsValid(ply) and (not ply._TFA_LastAltAttack or ply._TFA_LastAltAttack < RealTime()) then
		self:EmitSound("TFA_BO3_SUNGOD.Foley")
		ply._TFA_LastAltAttack = RealTime() + 0.5
	end

	if self:Clip1() < 3 then
		if not dryfire_cvar:GetBool() then
			self:Reload(true)
		end
	return end

	if IsFirstTimePredicted() then
		self:EmitSound(self.ChargeSound)
		self:EmitSound(self.ChargeSoundSweet)

		if self:VMIV() then
			ParticleEffectAttach(self:IsFirstPerson() and "bo3_sungod_vm" or "bo3_sungod_3p", PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 1)
		end
	end

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if IsValid(ply) then
			filter:RemovePlayer(ply)
		end

		if filter:GetCount() > 0 then
			util.Effect("tfa_bo3_sungod_ult", fx, true, filter)
		end
	end

	self:SetChargeStart(CurTime())
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex())

		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 70
			self.DLight.b = 100
			self.DLight.decay = 2000
			self.DLight.brightness = 1
			self.DLight.size = 64 * self:GetCurrentCharge()
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	if ply:IsPlayer() then
		if TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() and self:GetChargeStart() + self.ChargeDownTime > CurTime() then
			if self:GetCharged() and not self.HasPlayedChargeSound then
				self.HasPlayedChargeSound = true
				if IsFirstTimePredicted() then
					self:EmitSound(self.ChargeLoopSound)
				end
			end
		elseif self:GetCurrentCharge() > 0 then
			self:CleanParticles()
			self:ResetCharge(true)
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PrePrimaryAttack()
	self:CleanParticles()
	if self:GetCurrentCharge() == self.ChargeTime then
		self:TakePrimaryAmmo(2)
	end
end

function SWEP:PrimaryAttack(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsNPC() then
		if self:GetChargeStart() > 0 and !self:GetCharged() then
			return
		end
		if self:Clip1() >= 3 and math.random(9) <= (1*math.max(GetConVar("skill"):GetInt(), 1)) then
			self:AltAttack()
			return
		end
	end

	BaseClass.PrimaryAttack(self, ...)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	if ply:IsPlayer() and IsFirstTimePredicted() and nzombies and self:HasNZModifier("pap") then
		nzSounds:PlayEnt("UpgradedShoot", ply)
	end
	self:ResetCharge()
end

function SWEP:GetCurrentCharge()
	if self:GetChargeStart() == 0 then
		return 0
	else
		return math.min(CurTime() - self:GetChargeStart(), self.ChargeTime)
	end
end

function SWEP:GetCharged()
	return self:GetCurrentCharge() == self.ChargeTime
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
	ent.Charged = self:GetCharged()
end

function SWEP:OnRemove(...)
	self:StopSound(self.ChargeLoopSound)
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound(self.ChargeLoopSound)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound(self.ChargeLoopSound)
	self:StopSoundNet(self.ChargeLoopSound)
	return BaseClass.Holster(self,...)
end

local crosshair_cross = Material("vgui/overlay/reticle_incendiary_cross.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_cross)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
end
