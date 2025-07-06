local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_bash_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "Gauntlet of Siegfried"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/gauntlet/c_gauntlet.mdl"
SWEP.ViewModel_Alt		= "models/weapons/tfa_bo3/115punch/c_115punch.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/gauntlet/w_gauntlet.mdl"
SWEP.WorldModel_Alt		= "models/weapons/tfa_bo3/gauntlet/w_gauntlet.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1,
        Forward = 4,
        },
        Ang = {
		Up = 180,
        Right = 185,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_GAUNTLET.ShootIn"
SWEP.Primary.LoopSound = "TFA_BO3_GAUNTLET.ShootLoop"
SWEP.Primary.LoopSoundTail = "TFA_BO3_GAUNTLET.ShootOut"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 700
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 20
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 1
SWEP.Primary.ClipSize = 200
SWEP.Primary.DefaultClip = 200
SWEP.Primary.DryFireDelay = 0.5
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 10
SWEP.MuzzleFlashEffect = "tfa_bo3_muzzleflash_gauntlet"
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
SWEP.Primary.Range = 400
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 1 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 0.2 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.2 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.4 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.15 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .03
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.2
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.15
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0
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

--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 4000
SWEP.Secondary.BashSound = Sound("TFA_BO3_GAUNTLET.ShootShort")
SWEP.Secondary.BashHitSound = Sound("TFA_BO3_GAUNTLET.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_BO3_GAUNTLET.Hit")
SWEP.Secondary.BashLength = 55
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = bit.bor(DMG_SLASH, DMG_CLUB)
SWEP.Secondary.BashInterrupt = false

--[Misc]--
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/uie_t7_zm_dragon_gauntlet_ammo_icon_gun_ready.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/uie_t7_zm_dragon_gauntlet_ammo_icon_gun_ready_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7flash = Material("vgui/icon/uie_t7_zm_dragon_gauntlet_ammo_icon_gun_readyflash.png", "unlitgeneric smooth")

SWEP.AmmoRegen = 2

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
end

SWEP.CustomBulletCallback = function(ply, tr, dmg)
	local ent = tr.Entity
	local wep = dmg:GetInflictor()

	if SERVER then
		if tr.HitPos:Distance(ply:GetShootPos()) > 400 then return end

		if IsValid(ent) and ent.Ignite then
			if nzombies and ent:IsPlayer() then return end

			if nzombies and ent:IsValidZombie() then
				local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
				local health = nzCurves.GenerateHealthCurve(round)

				if isnumber(health) then
					dmg:SetDamage(health / 3)
				end

				if ent.NZBossType then
					dmg:SetDamage(math.max(400, ent:GetMaxHealth() / 24))
					dmg:ScaleDamage(math.Round(nzRound:GetNumber()/12))
				end
			end

			dmg:SetDamageType(DMG_SLOWBURN)
			ent:Ignite(4)
		end
	end
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
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GAUNTLET.Shake") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GAUNTLET.Attach") },
},
[ACT_VM_DETACH_SILENCER] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GAUNTLET.Attach") },
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

SWEP.Attachments = {
[1] = {atts = {"bo3_115punch_att"}, order = 1, hidden = true},
}

SWEP.WElements = {
	["armthingy"] = { type = "Model", model = "models/weapons/tfa_bo3/gauntlet/w_gauntlet_elbow.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "", pos = Vector(1, 1, 1), angle = Angle(-5, 10, 10), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

SWEP.WorldModelBoneMods = {
	["tag_dragon_world"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.StatCache_Blacklist = {
	["Secondary.BashDelay"] = true,
	["HoldType"] = true,
	["InspectPos"] = true,
	["InspectAng"] = true,
}

SWEP.up_hat = true
SWEP.BO3CanDash = true
SWEP.BO3DashMult = 1

DEFINE_BASECLASS( SWEP.Base )

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Dashing")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")

function SWEP:CycleSafety()
end

function SWEP:Deploy(...)
	if SERVER and self.IsFirstDeploy then
		local ply = self:GetOwner()
		local damage = DamageInfo()
		damage:SetAttacker(ply)
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_MISSILEDEFENSE)

		for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 120)) do
			if v:IsNPC() or v:IsNextBot() then
				if v == ply then continue end
				if nzombies and v.NZBossType then continue end

				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

				v:TakeDamageInfo(damage)
			end
		end
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:AdjustMouseSensitivity()
	if self:GetDashing() then
		return 0.25
	end

	if self:GetStatus() == TFA.Enum.STATUS_BASHING_WAIT then
		return math.max(0.25, self:GetStatusProgress())
	end
end

function SWEP:AttachWaveGun()
	self.ViewModelKitOld = self.ViewModelKitOld or self.ViewModel
	self.WorldModelKitOld = self.WorldModelKitOld or self.WorldModel
	self.ViewModel = self:GetStat("ViewModel_Alt") or self.ViewModel
	self.WorldModel = self:GetStat("WorldModel_Alt") or self.WorldModel
	if IsValid(self.OwnerViewModel) then
		self.OwnerViewModel:SetModel(self.ViewModel)
		timer.Simple(0, function()
			self:SendViewModelAnim(ACT_VM_DRAW)
		end)
	end

	self:SetSilenced(false) --inverted for some reason
	self.Silenced = self:GetSilenced()

	self.Secondary_TFA.BashDelay = 0.65
	self.BO3DashMult = 2
	
	self.up_hat = false
	self.HoldType = "fist"
	self.PrintName = "115 Punch"

	self.InspectPos = Vector(0, -1, -1)
	self.InspectAng = Vector(15, 0, 0)

	self.WorldModelBoneMods["tag_dragon_world"].scale = Vector(0,0,0)

	self:SetModel(self.WorldModel)
	self:SetNextIdleAnim(-1)
end

function SWEP:DetachWaveGun()
	if self.ViewModelKitOld then
		self.ViewModel = self.ViewModelKitOld
		if IsValid(self.OwnerViewModel) then
			self.OwnerViewModel:SetModel(self.ViewModel)
		end
		self.ViewModelKitOld = nil
	end
	if self.WorldModelKitOld then
		self.WorldModel = self.WorldModelKitOld
		self:SetModel(self.WorldModel)
		self.ViewModelKitOld = nil
	end

	self:SetSilenced(true) --inverted for some reason
	self.Silenced = self:GetSilenced()

	self.Secondary_TFA.BashDelay = 0.2
	self.BO3DashMult = 1
	
	self.up_hat = true
	self.HoldType = "pistol"
	self.PrintName = "Gauntlet of Siegfried"

	self.InspectPos = Vector(8, -5, -1)
	self.InspectAng = Vector(20, 30, 16)

	self.WorldModelBoneMods["tag_dragon_world"].scale = Vector(1,1,1)

	local _, tanim, ttype = self:PlayAnimation(self:GetStat("BaseAnimations.silencer_detach"))

	self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim))
	self:SetNextPrimaryFire(self.GetNextCorrectedPrimaryFire(self, self:GetActivityLength(tanim, true)+0.1))
end

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	if self:GetSilenced() then return end

	if self:CanPrimaryAttack() and !self:GetHasEmitSound() then
		self:SetHasEmitSound(true)
		if IsFirstTimePredicted() then
			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))
		end
	end
end

function SWEP:PrimaryAttack()
	if self:GetSilenced() then
		self:AltAttack()
		return
	end

	return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not self:CanPrimaryAttack() and not self:GetSilenced() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] or self:GetSprinting() then return end

	local _, tanim = self:ChooseSilenceAnim(not self:GetSilenced())
	self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim, true))
	self:SetNextPrimaryFire(self2.GetNextCorrectedPrimaryFire(self, self:GetActivityLength(tanim, true)+0.1))
end

function SWEP:AltAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not self:CanPrimaryAttack() then return end
	if not ply:IsOnGround() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] or self:GetSprinting() then return end
	if nzombies and not self:GetOwner():GetNotDowned() then return end

	self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))
	if self:GetSilenced() and self:VMIV() then
		if IsFirstTimePredicted() then
			ParticleEffectAttach("bo3_gauntlet_dash", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 6)
		end
	end
	self:SetDashing(true)

	return BaseClass.AltAttack(self)
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)
		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(2)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 45
			self.DLight.g = 255
			self.DLight.b = 45
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5
			self.DLight.size = 32
			self.DLight.dietime = CurTime() + 1
		end
	end

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end

		if self:GetHasEmitSound() and stat ~= TFA.Enum.STATUS_SHOOTING then
			self:SetHasEmitSound(false)
		end
	end

	if stat == TFA.Enum.STATUS_SILENCER_TOGGLE then
		if not self.up_hat and self:GetSilenced() then
			self:DetachWaveGun()
			if sp and SERVER then
				self:CallOnClient("DetachWaveGun", "")
			end
		end
		if CurTime() > self:GetStatusEnd() and not self:GetSilenced() then
			self:AttachWaveGun()
			if sp and SERVER then
				self:CallOnClient("AttachWaveGun", "")
			end
		end
	end

	if stat == TFA.Enum.STATUS_BASHING then
		if self:GetSilenced() then
			self:Dash()
		end
		if statusend then
			self:SetDashing(false)
		end
	end

	if stat == TFA.Enum.STATUS_BASHING_WAIT then
		if self:GetSilenced() then
			self:Dash()
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:Dash()
	local ply = self:GetOwner()

	local damage = DamageInfo()
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamageType(DMG_DIRECT)

	for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 48)) do
		if not v:IsWorld() and v:IsSolid() then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end
			if v == ply then continue end
			if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if nzombies and v.NZBossType then continue end

			damage:SetDamage(v:Health())
			damage:SetDamageForce(v:GetUp()*15000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)
			if SERVER then
				v:TakeDamageInfo(damage)
			end
		end
	end
end

function SWEP:DoImpactEffect()
	return true
end

local bul = {}
function SWEP:ShootBullet()
	local ply = self:GetOwner()

	bul.Attacker = ply
	bul.Distance = self.Primary_TFA.Range
	bul.HullSize = self.Primary_TFA.HullSize
	bul.Num = 1
	bul.Damage = self.Primary_TFA.Damage
	bul.Tracer = 0
	bul.Callback = self.CustomBulletCallback
	bul.Src = ply:GetShootPos()
	bul.Dir = self:GetAimVector()
	self:FireBullets(bul)
end

function SWEP:Holster(...)
	if self:GetDashing() then
		return false
	end
	return BaseClass.Holster(self, ...)
end

local crosshair_flamethrower = Material("vgui/overlay/hud_flamethrower_reticle.png", "smooth unlitgeneric")
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

function SWEP:DrawHUDBackground() //copy pasting entire fuctions for a single line change B)
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
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end
end