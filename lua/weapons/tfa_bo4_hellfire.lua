local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Purpose = "Assembled with Russian know-how from the scraps of war and inter-dimensional combat, the Hellfire flamethrower has incinerated legions of filthy hell-pigs."
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Hellfire | BO4" or "Hellfire"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/hellfire/c_hellfire.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/hellfire/w_hellfire.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "2"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1.2,
        Forward = 4,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_HELLFIRE.Start"
SWEP.Primary.LoopSound = "TFA_BO4_HELLFIRE.Loop"
SWEP.Primary.LoopSoundTail = "TFA_BO4_HELLFIRE.Stop"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1200
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 115 or 24
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 1
SWEP.Primary.ClipSize = 300
SWEP.Primary.DefaultClip = 300
SWEP.Primary.DryFireDelay = 0.35
SWEP.MuzzleFlashEffect	= ""
SWEP.MuzzleFlashEffectSilenced = "tfa_bo4_muzzleflash_hellfire_2"
SWEP.MuzzleFlashEnabled = false
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
SWEP.LowAmmoSoundThreshold = 0 --0.33
SWEP.LowAmmoSound = ""
SWEP.LastAmmoSound = ""

--[Range]--
SWEP.Primary.Range = 400
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = -0.2 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2.5 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.5 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.1
SWEP.Primary.KickDown			= 0
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 2

SWEP.ChangeStateAccuracyMultiplier = 1.5 --1.5
SWEP.CrouchAccuracyMultiplier = 1.0 --0.5
SWEP.JumpAccuracyMultiplier = 3.0 --2
SWEP.WalkAccuracyMultiplier = 1.35 --1.35

--[Projectile]--
SWEP.Secondary.Projectile		= "bo4_specialist_hellfire"
SWEP.Secondary.ProjectileModel	= "models/hunter/plates/plate.mdl"

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/tfa/rifleshell.mdl"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(11, -2, -3)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.ImpactDecal = "Dark"
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/ui_icon_equipment_zm_flamethrower_lvl3_dark.png", "unlitgeneric smooth")

SWEP.AmmoRegen = 3

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
	self:SetHasNuked(false)
end

--[Tables]--
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
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_OVERKILL.Deploy") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_HELLFIRE.Raise") },
{ ["time"] = 15 / 30, ["type"] = "lua", value = function(self) self:StartFirstPersonParticles() end, client = true, server = false},
},
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_HELLFIRE.Draw") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:StartFirstPersonParticles() end, client = true, server = false},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_HELLFIRE.Holster") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:StopFirstPersonParticles() end, client = true, server = false},
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_HELLFIRE.Ult") },
},
[ACT_VM_SECONDARYATTACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_HELLFIRE.Charge") },
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

SWEP.Secondary.RPM = 120
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 20
SWEP.Secondary.Sound = "TFA_BO4_HELLFIRE.AirBlast"

SWEP.CylinderRadius = 100
SWEP.CylinderRange = 250
SWEP.CylinderKillRange = 150

SWEP.StatCache_Blacklist = {
	["MuzzleFlashEffect"] = true,
}

SWEP.ViewModelBoneMods = {
	["tag_dial_animate"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.Glow = Material("models/weapons/tfa_bo4/hellfire/xmaterial_a290e21cf1a3fee.vmt")
SWEP.FlameSize = Vector(1,1,1)
SWEP.FlameDistance = 24

SWEP.WW3P_FX = "bo4_hellfire_3p"
SWEP.WW3P_ATT = 4
SWEP.WWFP_FX = nil

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")

local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "GlowLevel")

	self:NetworkVarTFA("Bool", "HasEmitSound")
	self:NetworkVarTFA("Bool", "HasNuked")

	self:NetworkVarTFA("Entity", "FireTornado")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self:VMIV() then
		local clip = self:Clip1() - self.Primary.ClipSize
		self.ViewModelBoneMods["tag_dial_animate"].angle = Angle(0,0,math.Truncate(clip*0.9) - 90)
	end
end

function SWEP:CanPrimaryAttack(...)
	return not TFA.Enum.ChargeStatus[self:GetStatus()] and BaseClass.CanPrimaryAttack(self, ...)
end

function SWEP:StartFirstPersonParticles()
	if SERVER then return end
	if not self:VMIV() then return end
	if !self.WWFP_FX or !IsValid(self.WWFP_FX) then
		self.WWFP_FX = CreateParticleSystem(self.OwnerViewModel, "bo4_hellfire_vm", PATTACH_POINT_FOLLOW, 4)
	end
end

function SWEP:StopFirstPersonParticles()
	if SERVER then return end
	if not self:VMIV() then return end
	if self.WWFP_FX and IsValid(self.WWFP_FX) then
		self.WWFP_FX:StopEmissionAndDestroyImmediately()
	end
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
				if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then continue end

				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

				v:TakeDamageInfo(damage)
			end
		end
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:GetSecondaryDelay()
	local rpm2 = self:GetStat("Secondary.RPM")
	if rpm2 and rpm2 > 0 then
		return 60 / rpm2
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if self:GetGlowLevel() > 0 and status ~= TFA.Enum.STATUS_SHOOTING then
		self:SetGlowLevel(math.Approach(self:GetGlowLevel(), 0, 0.005))
		self.Glow:SetFloat("$emissiveblendstrength", self:GetGlowLevel())
	end

	if status == TFA.Enum.STATUS_CHARGE_UP and statusend then
		self:PreSecondaryAttack()

		self.Silenced = true
		self:SetSilenced(self.Silenced)
		self.DoMuzzleFlash = true

		self:ShootEffectsCustom()
		self.Silenced = false
		self:SetSilenced(self.Silenced)

		self:EmitGunfireSound(self:GetStatL("Secondary.Sound"))

		if hook.Run("TFA_SecondaryAttack", self) then return end
		if SERVER then
			self:Airblast()
		end

		self:SetNextPrimaryFire(self:GetActivityLength())
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_DOWN, self:GetSecondaryDelay())
	end

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end

		if self:GetHasEmitSound() and status ~= TFA.Enum.STATUS_SHOOTING then
			self:SetHasEmitSound(false)
			if IsFirstTimePredicted() then
				self:StopFirstPersonParticles()
				self:CleanParticles()
				self:EmitSound("TFA_BO4_HELLFIRE.CoolDown")

				if sp then
					timer.Simple(0, function()
						if not IsValid(self) then return end
						if not self:VMIV() then return end
						ParticleEffectAttach("bo4_hellfire_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 4)
					end)
				end
			end
		end

		if not sp and CLIENT and self:VMIV() then
			self:StartFirstPersonParticles()
		end
	end

	return BaseClass.Think2(self,...)
end

local col_blu = Color(0, 0, 255, 255)
local col_red = Color(255, 0, 0, 255)

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:TestVisible(ent, pos)
	if not IsValid(ent) then return false end

	local epos = ent:WorldSpaceCenter()
	local ang = (epos - pos):Angle()
	local fwd = Angle(0,ang.yaw,ang.roll):Forward()

	local tr = {}
	tr.start = pos
	tr.filter = {self, self:GetOwner()}
	tr.mask = MASK_SHOT_HULL
	tr.endpos = pos + fwd*self.FlameDistance

	local tr1 = util.TraceLine(tr)

	if shouldDisplayDebug() then
		DLib.debugoverlay.Line(pos, tr1.HitPos, 5, tr1.Entity == ent and col_red or col_blu, true)
	end

	return tr1.Entity == ent, tr1.HitPos
end

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if !ply:IsPlayer() then return end

	if self:CanPrimaryAttack() and !self:GetHasEmitSound() then
		self:StopSound("TFA_BO4_HELLFIRE.CoolDown")
		self:SetHasEmitSound(true)
		if IsFirstTimePredicted() then
			local fx = EffectData()
			fx:SetStart(ply:GetShootPos())
			fx:SetNormal(self:GetOwner():EyeAngles():Forward())
			fx:SetEntity(self)
			fx:SetAttachment(self:GetMuzzleAttachment())

			TFA.Effects.Create("tfa_bo4_muzzleflash_hellfire", fx)

			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))
		end
	end
end

function SWEP:PostPrimaryAttack()
	self:SetGlowLevel(math.Approach(self:GetGlowLevel(), 1, 0.05))
	self.Glow:SetFloat("$emissiveblendstrength", self:GetGlowLevel())
	if CLIENT then return end

	local ply = self:GetOwner()
	local aim = self:GetAimVector()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local n_range_squared = self:GetStatL("Primary.Range")*self:GetStatL("Primary.Range")
	local n_range_inner_squared = n_range_squared*0.5

	local start_pos = ply:GetShootPos()
	local aim_vec = ply:IsPlayer() and self:GetAimVector() or ply:GetAimVector()

	local tr = util.TraceLine({
		start = start_pos,
		endpos = start_pos + (aim_vec*self:GetStatL("Primary.Range")),
		filter = {ply, self},
		mask = MASK_SHOT_HULL,
	})

	local end_pos = tr.HitPos
	local size = self.FlameSize
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

		local ratio = 1 - math.Clamp((n_range_squared - n_range_squared + n_range_inner_squared) / n_range_inner_squared, 0, 0.5)
		self:InflictDamage(ent, ratio, radial_origin, hitpos)
	end
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	if self:GetStatus() ~= TFA.Enum.STATUS_CHARGE_UP then
		self:SendViewModelAnim(ACT_VM_SECONDARYATTACK)
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_UP, 0.25)
		self:SetNextPrimaryFire(self:GetActivityLength())

		self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))
	end
end

function SWEP:AltAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if TFA.Enum.ReadyStatus[self:GetStatus()] then
		local tornado = self:GetFireTornado()
		if not self:GetHasNuked() and not IsValid(tornado) then
			if (not nzombies and not self:CanPrimaryAttack()) then return end
			if nzombies then
				self:SetHasNuked(true)
			end
			self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))

			if SERVER then
				local ent = ents.Create(self:GetStatL("Secondary.Projectile"))
				ent:SetModel(self:GetStatL("Secondary.ProjectileModel"))
				ent:SetPos(ply:WorldSpaceCenter())
				ent:SetOwner(ply)
				ent:SetAngles(ply:GetForward():Angle())

				ent.damage = self:GetStatL("Primary.Damage")
				ent.mydamage = self:GetStatL("Primary.Damage")

				ent:Spawn()

				ent:SetOwner(ply)

				self:SetFireTornado(ent)
			end
		elseif IsValid(tornado) then
			tornado:SetActivated(not tornado:GetActivated())
			tornado:SetLocalVelocity(vector_origin)
		end

		self:SendViewModelAnim(ACT_VM_PULLBACK)
		self:ScheduleStatus(TFA.Enum.STATUS_BASHING , self:GetActivityLength())
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end
end

function SWEP:Airblast()
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		ply:SetAnimation(PLAYER_ATTACK1)
	end

	local outer_range = self.CylinderRange
	local cylinder_radius = self.CylinderRadius
	local kill_range = self.CylinderKillRange

	local view_pos = ply:GetShootPos()
	local forward_view_angles = self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * outer_range)

	for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
		//if not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then continue end
		if not ent:IsSolid() then continue end
		if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
		if ent == ply then continue end
		if nzombies and ent:IsPlayer() then continue end
		if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end
		//if ent:Health() <= 0 then continue end

		local outer_range_squared = outer_range * outer_range
		local cylinder_radius_squared = cylinder_radius * cylinder_radius
		local kill_range_squared = kill_range * kill_range

		local test_origin = ent:WorldSpaceCenter()
		local test_range_squared = view_pos:DistToSqr(test_origin)
		if test_range_squared > outer_range_squared then
			continue // everything else in the list will be out of range
		end

		local normal = (test_origin - view_pos):GetNormalized()
		local dot = forward_view_angles:Dot(normal)
		if 0 > dot then
			continue // guy's behind us
		end

		local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
		if test_origin:DistToSqr(radial_origin) > cylinder_radius_squared then
			continue // guy's outside the range of the cylinder of effect
		end

		local tr1 = util.TraceLine({
			start = view_pos,
			endpos = test_origin,
			filter = {self, ply},
			mask = MASK_SOLID_BRUSHONLY,
		})

		if tr1.HitWorld then
			continue // guy can't actually be hit from where we are
		end

		self:AirblastDamage(ent, test_range_squared < kill_range_squared)
	end
end

function SWEP:AirblastDamage(ent, kill)
	local ply = self:GetOwner()
	local norm = self:GetAimVector()

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(kill and ent:Health() + 666 or 75)
	damage:SetDamageForce(vector_up*6000 + norm*12000)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(1400, ent:GetMaxHealth() / 12))
	end

	ent:SetGroundEntity(nil)
	if (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or ent:IsVehicle()) then
		damage:SetDamageForce(vector_up*6000 + norm*12000)
		ent:SetVelocity(vector_up*200 + norm*400)
	else
		damage:SetDamageForce(norm*600)
	end

	ent:TakeDamageInfo(damage)
end

function SWEP:InflictDamage(ent, ratio, pos, hitpos)
	local mydamage = (self:GetStatL("Primary.Damage")*ratio)

	if nzombies and ent:IsValidZombie() then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))

		mydamage = (health*ratio / 2) + 115
		if !(ent.NZBossType or ent.IsMooBossZombie) then
			ent:BO1BurnSlow(4*ratio)
		end
	end

	local damage = DamageInfo()
	damage:SetDamageType(bit.bor(DMG_BULLET, DMG_SLOWBURN))
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(mydamage*self:GetStatL("Primary.NumShots"))
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce((hitpos - pos):GetNormalized())

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max((60*ratio), ent:GetMaxHealth() / 120))
	end

	if !nzombies then
		ent:Ignite(4*ratio)
	end

	ent:TakeDamageInfo(damage)
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
	self:StopSound("TFA_BO4_HELLFIRE.Loop")
	self:StopSound("TFA_BO4_HELLFIRE.CoolDown")
	self.Glow:SetFloat("$emissiveblendstrength", 0)
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO4_HELLFIRE.Loop")
	self:StopSound("TFA_BO4_HELLFIRE.CoolDown")
	self.Glow:SetFloat("$emissiveblendstrength", 0)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("TFA_BO4_HELLFIRE.Loop")
	self:StopSound("TFA_BO4_HELLFIRE.CoolDown")
	self:StopSoundNet("TFA_BO4_HELLFIRE.Loop")
	self:StopSoundNet("TFA_BO4_HELLFIRE.CoolDown")
	self.Glow:SetFloat("$emissiveblendstrength", 0)
	return BaseClass.Holster(self,...)
end

function SWEP:ShootBulletInformation()
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
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end
end
