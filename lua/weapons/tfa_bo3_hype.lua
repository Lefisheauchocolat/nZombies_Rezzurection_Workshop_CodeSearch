local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Conceptualized by AwesomePieMan. \nFrom the World at War custom map 'Ragnarok' by AwesomePieMan & HexZombies"
SWEP.Author = "FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "High Yield Proton Eviscerator | WAW" or "High Yield Proton Eviscerator"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/hypecannon/c_hypecannon.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/hypecannon/w_hypecannon.mdl"
SWEP.HoldType = "rpg"
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
SWEP.Primary.Sound = "TFA_BO3_HYPE.FireIn"
SWEP.Primary.LoopSound = "TFA_BO3_HYPE.FireLoop"
SWEP.Primary.LoopSoundTail = "TFA_BO3_HYPE.FireOut"
SWEP.Primary.Sound_DryFire = "TFA.GHOSTS.NX1.Empty"
SWEP.Primary.Sound_Blocked = "TFA.GHOSTS.NX1.Empty"
SWEP.Primary.Ammo = "Uranium"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1200
SWEP.Primary.Damage = nzombies and 40 or 8
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = 115
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 4
SWEP.Primary.Knockback = 0
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect = "tfa_bo3_muzzleflash_hype"
SWEP.TracerName = ""
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
		{range = 1000, damage = 0.2},
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
SWEP.Primary.Spread		  = .00
SWEP.Primary.IronAccuracy = .00
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
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(0, -2, -2)
SWEP.InspectAng = Vector(10, 2, 0)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "H.Y.P.E."
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 345

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.SoundPAP = "TFA_BO3_HYPE.FireInUpg"
SWEP.Primary.DamagePAP = 12
SWEP.Primary.ClipSizePAP = 300
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_hype_pap"
SWEP.MoveSpeedPAP = 0.95

function SWEP:OnPaP()
self.Ispackapunched = true

self.Primary_TFA.Sound = "TFA_BO3_HYPE.FireInUpg"
self.Primary_TFA.Damage = 115
self.Primary_TFA.ClipSize = 300
self.Primary_TFA.MaxAmmo = 600

self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_hype_pap"
self.MoveSpeed = 0.95

self.BeamSize = 50
self.BeamDistance = nzombies and 4096*8 or 2000
self.BeamFalloff = 400

self.Primary_TFA.RangeFalloffLUT = {
	bezier = false,
	range_func = "linear",
	units = "hu",
	lut = {
		{range = 400, damage = 1.0},
		{range = 2000, damage = 0.2},
	}
}

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 75 / 35,
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
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 25 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HYPE.Raise") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HYPE.SlideOut") },
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HYPE.MagOut") },
{ ["time"] = 65 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HYPE.MagIn") },
{ ["time"] = 85 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HYPE.SlideIn") },
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
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.BeamRaySize = Vector(8,8,8)
SWEP.BeamSize = 20
SWEP.BeamDistance = nzombies and 4096*8 or 1000
SWEP.BeamFalloff = 200

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
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(2, self.nzPaPCamo)
			vm:SetSubMaterial(3, self.nzPaPCamo)
			vm:SetSubMaterial(4, self.nzPaPCamo)
			vm:SetSubMaterial(6, self.nzPaPCamo)
			vm:SetSubMaterial(9, self.nzPaPCamo)
			vm:SetSubMaterial(13, self.nzPaPCamo)
		end
		vm:SetSubMaterial(15, "models/weapons/tfa_bo3/hypecannon/mtl_wpn_t7_launch_blackcell_viewfinder_pap.vmt")
	else
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(6, nil)
		vm:SetSubMaterial(9, nil)
		vm:SetSubMaterial(13, nil)
		vm:SetSubMaterial(15, nil)
	end
end

local col_blu = Color(0, 0, 255, 255)
local col_red = Color(255, 0, 0, 255)

function SWEP:TestVisible(ent, pos)
	if not IsValid(ent) then return false end

	local epos = ent:WorldSpaceCenter()
	local ang = (epos - pos):Angle()
	local fwd = Angle(0,ang.yaw,ang.roll):Forward()

	local tr = {}
	tr.start = pos
	tr.filter = {self, self:GetOwner()}
	tr.mask = MASK_SHOT_HULL
	tr.endpos = pos + fwd*self.BeamSize

	local tr1 = util.TraceLine(tr)

	if shouldDisplayDebug() then
		DLib.debugoverlay.Line(pos, tr1.HitPos, 5, tr1.Entity == ent and col_red or col_blu, true)
	end

	return tr1.Entity == ent, tr1.HitPos
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if !IsValid(ply) then return end
	if !self:CanPrimaryAttack() then return end

	if !self:GetHasEmitSound() and ply:IsPlayer() then
		self:SetHasEmitSound(true)
		self:StopSound("TFA_BO3_HYPE.Overheat")
		if self:VMIV() and self:IsFirstPerson() then
			self.OwnerViewModel:StopParticles()
		end

		if IsFirstTimePredicted() then
			local tr = util.QuickTrace(ply:GetShootPos(), self:GetAimVector()*self.BeamDistance, {ply, self})

			local fx = EffectData()
			fx:SetStart(ply:GetShootPos())
			fx:SetOrigin(tr.HitPos)
			fx:SetEntity(self)
			fx:SetAttachment(1)
			fx:SetFlags(self.Ispackapunched and 2 or 1)

			TFA.Effects.Create("tfa_bo3_hype_tractorbeam", fx)

			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))

			if not game.SinglePlayer() and not self:IsFirstPerson() then
				ParticleEffectAttach(self.Ispackapunched and "bo3_hype_3p_2" or "bo3_hype_3p", PATTACH_POINT_FOLLOW, self, 2)
				ParticleEffectAttach("bo3_hype_exhaust", PATTACH_POINT_FOLLOW, self, 3)
			end
		end

		if SERVER then
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetAttachment(3)
			fx:SetFlags(self.Ispackapunched and 2 or 1)

			local filter = RecipientFilter()
			filter:AddPVS(ply:GetShootPos())
			if IsValid(ply) and self:IsFirstPerson() then
				filter:RemovePlayer(ply)
			end

			if filter:GetCount() > 0 then
				util.Effect("tfa_bo3_hype_exhaust", fx, true, filter)
			end
		end
	elseif ply:IsNPC() then
		local tr = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector()*self.BeamDistance, {ply, self})

		local fx = EffectData()
		fx:SetStart(ply:GetShootPos())
		fx:SetOrigin(tr.HitPos)
		fx:SetEntity(self)
		fx:SetAttachment(1)
		fx:SetFlags(self.Ispackapunched and 2 or 1)
		fx:SetMagnitude((tr.Hit and !tr.HitSky) and 2 or 1)
		fx:SetNormal(tr.HitNormal)

		TFA.Effects.Create("tfa_bo3_hype_tractorbeam_npc", fx)
	end
end

function SWEP:PostPrimaryAttack()
	if CLIENT then return end

	local ply = self:GetOwner()
	local aim = self:GetAimVector()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local n_range_squared = self.BeamDistance*self.BeamDistance
	local n_range_inner_squared = self.BeamFalloff*self.BeamFalloff

	local start_pos = ply:GetShootPos()
	local aim_vec = ply:IsPlayer() and self:GetAimVector() or ply:GetAimVector()

	local tr = util.TraceLine({
		start = start_pos,
		endpos = start_pos + (aim_vec*self.BeamDistance),
		filter = {ply, self},
		mask = MASK_SHOT_HULL,
	})

	local end_pos = tr.HitPos
	local size = self.BeamRaySize
	local trEnt = tr.Entity

	for i, ent in pairs(ents.FindAlongRay(start_pos, end_pos, -size, size)) do
		if ent == self then continue end
		if ent == ply then continue end

		if ent.Alive and !ent:Alive() then continue end
		if ent:Health() <= 0 then continue end

		local isplayer = ent:IsPlayer()

		if nzombies and isplayer then continue end
		if isplayer and !pvp_bool:GetBool() then continue end
		if isplayer and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

		local test_origin = ent:WorldSpaceCenter()
		local radial_origin = PointOnSegmentNearestToPoint(start_pos, end_pos, test_origin )

		local b_visible, hitpos
		if IsValid(trEnt) and ent:EntIndex() == trEnt:EntIndex() then
			b_visible, hitpos = true, end_pos
		else
			b_visible, hitpos = self:TestVisible(ent, radial_origin)
		end
		if !b_visible then continue end

		local test_range_squared = start_pos:DistToSqr(test_origin)
		local ratio = math.Clamp((n_range_squared - test_range_squared) / (n_range_squared - n_range_inner_squared), 0.2, 1)

		self:InflictDamage(ent, ratio, radial_origin, hitpos)
	end
end

function SWEP:InflictDamage(ent, ratio, pos, hitpos)
	local mult = math.Rand(0.8,1.2)*ratio
	local mydamage = (self:GetStatL("Primary.Damage")*mult)

	if nzombies and ent:IsValidZombie() then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))
		local rand = self.Ispackapunched and math.random(8,9) or math.random(20,22)

		mydamage = math.max(mydamage, health / rand)
		if !(ent.NZBossType or ent.IsMooBossZombie) then
			ent:BO1BurnSlow(3*ratio)
		end
	end

	mydamage = mydamage*self:GetStatL("Primary.NumShots")

	local damage = DamageInfo()
	damage:SetDamageType(nzombies and DMG_ENERGYBEAM or bit.bor(DMG_ENERGYBEAM, DMG_AIRBOAT))
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(mydamage)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce((hitpos - pos):GetNormalized())

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max((66*ratio)*self:GetStatL("Primary.NumShots"), ent:GetMaxHealth() / 120))
	end

	if !nzombies then
		local death = math.floor(ent:Health() - mydamage) <= 0
		if death then
			ent:Extinguish()
			damage:SetDamage(ent:Health() + 666)
			if !ent:IsPlayer() then
				ent:SetHealth(1)
			end
		else
			ent:Ignite(3*ratio)
		end
	end

	ent:TakeDamageInfo(damage)
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if ply:IsPlayer() and self:GetHasEmitSound() and self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING then
		self:SetHasEmitSound(false)
		if IsFirstTimePredicted() then
			self:CleanParticles()
			if self:VMIV() then
				self:EmitSound("TFA_BO3_HYPE.Overheat")
				if self:IsFirstPerson() then
					ParticleEffectAttach("bo3_hype_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
					ParticleEffectAttach("bo3_hype_vm_xsmoke", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
				end
			end
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:Reload(...)
	if self:Clip1() > 0 then 
		return
	end
	return BaseClass.Reload(self, ...) 
end

function SWEP:ShootBulletInformation()
end

function SWEP:OnRemove(...)
	self:StopSound("TFA_BO3_HYPE.FireLoop")
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_HYPE.FireLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("TFA_BO3_HYPE.FireLoop")
	self:StopSoundNet("TFA_BO3_HYPE.FireLoop")
	return BaseClass.Holster(self,...)
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
	if IsValid(targent) and tr.start:Distance(traceres.HitPos) < self.BeamDistance then
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