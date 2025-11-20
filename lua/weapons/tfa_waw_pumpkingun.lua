local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "BO1 Wavegun retextured by Reaper. \nFrom the World at War custom map 'TACO HELL' by Reaper"
SWEP.Author = "Reaper, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Pumpkin Gun | WAW" or "Pumpkin Gun"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/pumpkingun/c_pumpkingun.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_waw/pumpkingun/w_pumpkingun.mdl"
SWEP.HoldType = "rpg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 2,
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
SWEP.Primary.Sound = "TFA_BO1_MICROWAVE.Rifle.Shoot"
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.Damage = nzombies and 2200 or 105
SWEP.Primary.PenetrationPower = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 10
SWEP.Primary.ClipSize = 4
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 4
SWEP.Primary.Delay = 0.25
SWEP.MuzzleFlashEffect = "tfa_waw_muzzleflash_pumpkingun"
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
SWEP.MainBullet.Distance = 4096 //overwrites TFA bullet range

SWEP.Primary.Range = 4096
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .001
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 1
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.4
SWEP.Primary.StaticRecoilFactor	= 0.4

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-3.25, -2, 0.46)
SWEP.IronSightsAng = Vector(0, -1.4, 0)
SWEP.IronSightTime = 0.25

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "waw_ww_pumpkingun" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_waw/pumpkingun/pumpkingun_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.TracerCount = 1

--[NZombies]--
SWEP.NZPaPName = "Jack-o-Attack"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 24

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo(self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType())
	self:SetClip1(self.Primary_TFA.ClipSize)
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 7
SWEP.Primary.DamagePAP = 175
SWEP.MuzzleFlashEffectPAP = "tfa_waw_muzzleflash_pumpkingun_pap"

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 7
self.Primary_TFA.MaxAmmo = 42
self.Primary_TFA.Damage = 6200
self.MuzzleFlashEffect = "tfa_waw_muzzleflash_pumpkingun_pap"
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
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 15 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Putaway") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.Start") },
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.MagOut") },
{ ["time"] = 30 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.Futz") },
{ ["time"] = 70 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.MagIn") },
{ ["time"] = 100 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.End") },
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

--[Attachments]--
SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.BeamRaySize = Vector(12,12,12)
SWEP.BeamSize = 80
SWEP.BeamDistance = 140

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, ...)

	if self.Ispackapunched then
		if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
		end
		vm:SetSubMaterial(2, "models/weapons/tfa_waw/pumpkingun/mtl_zombie_teleporter_glow_pap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
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
	return tr1.Entity == ent, tr1.HitPos
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	if IsFirstTimePredicted() then
		if ply:IsPlayer() and nzombies and self:HasNZModifier("pap") then
			nzSounds:PlayEnt("UpgradedShoot", ply)
		end
		if self:VMIV() then
			ParticleEffectAttach(self.Ispackapunched and "waw_pumpkingun_vm_arcs_2" or "waw_pumpkingun_vm_arcs", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
		end
	end
	if CLIENT then return end
	local fx = EffectData()
	fx:SetEntity(self)
	fx:SetFlags(self.Ispackapunched and 2 or 1)
	fx:SetAttachment(3)

	local filter = RecipientFilter()
	filter:AddPVS(ply:GetShootPos())
	if IsValid(ply) and self:IsFirstPerson() then
		filter:RemovePlayer(ply)
	end

	if filter:GetCount() > 0 then
		util.Effect("tfa_waw_pumpkingun_3p", fx, true, filter)
	end

	local aim_vec = ply:GetAimVector()
	local start_pos = ply:GetShootPos()
	local end_pos = start_pos - aim_vec*self.BeamSize

	local size = self.BeamRaySize
	local maxkills = 6
	local kills = 0

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
		local radial_origin = PointOnSegmentNearestToPoint(start_pos, end_pos, test_origin)

		local b_visible, hitpos = self:TestVisible(ent, radial_origin)
		if !b_visible then continue end

		self:InflictDamage(ent, hitpos)

		kills = kills + 1
		if kills >= maxkills then
			break
		end
	end
end

function SWEP:InflictDamage(ent, hitpos)
	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(ply:GetAimVector()*-12000 + (ent:GetPos() - ply:GetPos()):GetNormalized()*8000 + ent:GetUp()*8000)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(2400*self:GetStatL("Primary.NumShots"), ent:GetMaxHealth() / 9))
	end

	if ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
		ent:SetHealth(1)
	end

	ent:TakeDamageInfo(damage)
end

local crosshair_flamethrower = Material("vgui/overlay/flechette_reticle_t6.png", "smooth unlitgeneric")
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
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 21, y  - 21, 42, 42)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 21, ScrH() / 2 - 21, 42, 42)
	end
end
