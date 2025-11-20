local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_bash_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Purpose = "BO3 Gravity Spike specialist hand animated, possibly by OffTh EWall. \nFrom the World at War custom map 'Project Viking' by RedSpace2000. \nParticle effects inspired by the Gravity Spike effects on the custom map Ragnarok. \nIncludes the DG4's Power Plant ability."
SWEP.Author = "RedSpace2000, OffTh EWall, FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "Gravity Spikes"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/grav_spike/c_grav_spike.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/grav_spike/w_grav_spike.mdl"
SWEP.HoldType = "duel"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, -1)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1,
        Forward = 3.5,
        },
        Ang = {
		Up = -180,
        Right = 180,
        Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 5
SWEP.Primary.AmmoRegen = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Delay = 0.35
SWEP.MuzzleFlashEffect = "tfa_waw_muzzleflash_gravspike"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.1

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

SWEP.ViewModelPunch_MaxVertialOffset				= 2 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .04
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1.0
SWEP.Primary.KickDown			= 1.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 6

--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 400
SWEP.Secondary.BashSound = Sound("TFA_WAW_SPIKE.Melee")
SWEP.Secondary.BashHitSound = Sound("TFA_BO3_MELEE.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_BO3_MELEE.Hit")
SWEP.Secondary.BashLength = 55
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = bit.bor(DMG_SLASH, DMG_CLUB)
SWEP.Secondary.BashInterrupt = false

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
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/gravity_spikes_codm.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t6 = Material("vgui/icon/hud_gravspike.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/t7_hud_zm_hud_ammo_icon_spike_ready_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7flash = Material("vgui/icon/t7_hud_zm_hud_ammo_icon_spike_readyflash.png", "unlitgeneric smooth")

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
end

--[Tables]--
SWEP.SequenceLengthOverride = {
	[ACT_VM_THROW] = 15 / 30,
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_DG4.Draw") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_WAW_SPIKE.Activate") },
},
[ACT_VM_HITCENTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_WAW_SPIKE.Start") },
},
[ACT_VM_DEPLOY] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_SPIKE.Plant") },
}
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.WElements = {
	["grav_dw"] = { type = "Model", model = "models/weapons/tfa_waw/grav_spike/w_grav_spike.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3, 1.2, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

SWEP.StatCache_Blacklist = {
	["WElements"] = true,
}

SWEP.Callback = {}
SWEP.BO3CanSlam = true
SWEP.DG4SlamFwd = 225
SWEP.DG4SlamUp = Vector(0,0,350)
SWEP.SlamAttackRange = 200

SWEP.WW3P_FX = "waw_gravspike_3p"
SWEP.WW3P_ATT = 1
SWEP.WW3P_CALLBACK = function(self, ply)
	local WorldModelElements = self:GetStatRaw("WorldModelElements", TFA.LatestDataVersion)
	if WorldModelElements and WorldModelElements['grav_dw'] and IsValid(WorldModelElements['grav_dw'].curmodel) then
		local wmodel = WorldModelElements['grav_dw'].curmodel
		if !self.CL_3PDrawFXb or !self.CL_3PDrawFXb:IsValid() then
			self.CL_3PDrawFXb = CreateParticleSystem(wmodel, "waw_gravspike_3p", PATTACH_POINT_FOLLOW, 1)
		end
	end
end
SWEP.WW3P_REMOVECALLBACK = function(self, ply)
	if self.CL_3PDrawFXb and self.CL_3PDrawFXb:IsValid() then
		self.CL_3PDrawFXb:StopEmissionAndDestroyImmediately()
	end
end

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local CurTime = CurTime
local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")

local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Bool", "DG4Slamming")
	self:NetworkVarTFA("Vector", "SlamNormal")
end

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self:Clip1() > 0 or TFA.Enum.HolsterStatus[self:GetStatus()] then
		if !self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid() then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, self:GetDG4Slamming() and "waw_gravspike_vm_trail" or "waw_gravspike_vm", PATTACH_POINT_FOLLOW, 2)
		end
		if !self.CL_FPDrawFX2 or !self.CL_FPDrawFX2:IsValid() then
			self.CL_FPDrawFX2 = CreateParticleSystem(self.OwnerViewModel, self:GetDG4Slamming() and "waw_gravspike_vm_trail" or "waw_gravspike_vm", PATTACH_POINT_FOLLOW, 3)
		end
	else
		if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
			self.CL_FPDrawFX:StopEmission()
			self.CL_FPDrawFX = nil
		end
		if self.CL_FPDrawFX2 and IsValid(self.CL_FPDrawFX2) then
			self.CL_FPDrawFX2:StopEmission()
			self.CL_FPDrawFX2 = nil
		end
	end
end

function SWEP:AttachVMEffects()
	if CLIENT then
		if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
			self.CL_FPDrawFX:StopEmission()
			self.CL_FPDrawFX = nil
		end
		if self.CL_FPDrawFX2 and IsValid(self.CL_FPDrawFX2) then
			self.CL_FPDrawFX2:StopEmission()
			self.CL_FPDrawFX2 = nil
		end

		if !self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid() then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, self:GetDG4Slamming() and "waw_gravspike_vm_trail" or "waw_gravspike_vm", PATTACH_POINT_FOLLOW, 2)
		end
		if !self.CL_FPDrawFX2 or !self.CL_FPDrawFX2:IsValid() then
			self.CL_FPDrawFX2 = CreateParticleSystem(self.OwnerViewModel, self:GetDG4Slamming() and "waw_gravspike_vm_trail" or "waw_gravspike_vm", PATTACH_POINT_FOLLOW, 3)
		end
	end
end

function SWEP:WalkBob(pos, ang, ...)
	if self:GetDG4Slamming() then
		return pos, ang
	end

	return BaseClass.WalkBob(self, pos, ang, ...)
end

function SWEP:Deploy(...)
	if SERVER and self.IsFirstDeploy then
		self:KillInSphere(128)
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:KillInSphere(range)
	if CLIENT then return end
	range = range or 120

	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), range)) do
		if v:IsNPC() or v:IsNextBot() then
			if v == ply then continue end
			if nzombies and v.NZBossType then continue end

			damage:SetDamage(nzombies and 75 or 100)
			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			v:TakeDamageInfo(damage)
		end
	end
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChoosePullAnim then
		self.Callback.ChoosePullAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_JUMP)
	end

	self:SendViewModelAnim(ACT_VM_PULLPIN)

	if sp then
		self:CallOnClient("AnimForce", ACT_VM_PULLPIN)
	end

	return true, ACT_VM_PULLPIN
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChooseShootAnim then
		self.Callback.ChooseShootAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	local tanim = ACT_VM_THROW
	self:SendViewModelAnim(tanim)

	if sp then
		self:CallOnClient("AnimForce", tanim)
	end

	return true, tanim
end

function SWEP:ThrowStart()
	local ply = self:GetOwner()
	local success, tanim, animType = self:ChooseShootAnim()
	local range = self.SlamAttackRange

	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, self.Delay)

	self:ShootEffectsCustom()
	local qtr = util.QuickTrace(self:GetPos(), Vector(0,0,-32), {ply, self})
	util.Decal("Scorch", qtr.HitPos - qtr.HitNormal, qtr.HitPos + qtr.HitNormal)

	if shouldDisplayDebug() and qtr.Hit then
		DLib.debugoverlay.Sphere(qtr.HitPos, range, 5, Color(255, 0, 0, 255), true)
	end

	if SERVER then
		local tr = {
			start = self:GetPos(),
			filter = {self, ply},
			mask = MASK_SHOT_HULL
		}

		for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), range)) do
			if not v:IsWorld() and v:IsSolid() then
				if not pvp_bool:GetBool() and v:IsPlayer() then continue end
				if nzombies and v:IsPlayer() then continue end
				if v == ply then continue end
				if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

				tr.endpos = v:WorldSpaceCenter()
				local tr1 = util.TraceLine(tr)
				if tr1.HitWorld then continue end

				local damage = DamageInfo()
				damage:SetAttacker(ply)
				damage:SetInflictor(self)
				damage:SetDamage(nzombies and v:Health() + 666 or self:GetStat("Primary.Damage"))
				damage:SetDamageType(DMG_ENERGYBEAM)
				damage:SetDamageForce(v:GetUp()*20000 + (v:GetPos() - ply:GetPos()):GetNormalized() * 15000)
				damage:SetDamagePosition(tr1.Entity == v and tr1.HitPos or v:WorldSpaceCenter())

				if nzombies and (v.NZBossType or v.IsMooBossZombie or v.IsMiniBoss) then
					damage:SetDamage(math.max(1800, v:GetMaxHealth() / 8))
					damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
				end

				v.GravitySpiked = true
				v:TakeDamageInfo(damage)
				v.GravitySpiked = false
			end
		end

		util.ScreenShake(ply:GetPos(), 7, 255, 1, range*1.5)
	end

	//if IsFirstTimePredicted() then
		self:EmitGunfireSound("TFA_WAW_SPIKE.Explode")
		self:EmitGunfireSound("TFA_WAW_SPIKE.Shockwave")
		self:EmitGunfireSound("TFA_BO3_DG4.Hit")
	//end

	if success then
		self.LastNadeAnim = tanim
		self.LastNadeAnimType = animType
		self.LastNadeDelay = self.Delay
	end
end

function SWEP:PrimaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if nzombies and not ply:GetNotDowned() then return end

	local _, tanim = self:ChoosePullAnim()

	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, self:GetActivityLength(tanim))
	self:TakePrimaryAmmo(self:GetStatL("Primary.AmmoConsumption"))

	local ang = self:GetAimVector():Angle()
	local fwd = Angle(0,ang.yaw,ang.roll):Forward()

	if shouldDisplayDebug() and self:Clip1()%5 == 0 then
		local end_pos = ply:GetShootPos() + (fwd*120) + ply:OBBCenter()*2

		DLib.debugoverlay.Line(ply:GetShootPos(), end_pos, 5, Color(0, 0, 255, 255), true)
	end

	if SERVER then
		if not ply:IsPlayer() then
			ply:EmitSound("TFA_WAW_SPIKE.Activate")
			ply:SetLocalVelocity(fwd*1000 + Vector(0,0,250))
		end
	end

	self:KillInSphere(60)
	self:SetSlamNormal(fwd)
	self:SetDG4Slamming(true)

	if CLIENT then
		self:AttachVMEffects()
	elseif SERVER and game.SinglePlayer() then
		self:CallOnClient("AttachVMEffects", "")
	end

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if self:IsFirstPerson() then
			filter:RemovePlayer(ply)
		else
			filter:AddPlayer(ply)
		end

		util.Effect( "tfa_waw_gravspike_3p", fx, nil, filter)
	end
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end

	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight then
			self.DLight.pos = ply:GetShootPos() - (ply:OBBCenter() * 1/3)
			self.DLight.r = 255
			self.DLight.g = 200
			self.DLight.b = 100
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5
			self.DLight.size = 64
			self.DLight.dietime = CurTime() + 1
		end
	end

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end
	end

	if stat == TFA.Enum.STATUS_GRENADE_PULL then
		if statusend then
			self:SetStatus(TFA.Enum.STATUS_GRENADE_READY, math.huge)
		end
	end

	if stat == TFA.Enum.STATUS_GRENADE_READY then
		if ply:WaterLevel() > 2 then
			self:SendViewModelAnim(ACT_VM_THROW)
			self:SetStatus(TFA.GetStatus("idle"))
			self:SetSlamNormal(vector_origin)
			self:SetDG4Slamming(false)
		end

		if SERVER then
			for k, v in pairs(ents.FindInSphere(ply:GetPos(), 80)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == ply then continue end
					if nzombies and v.NZBossType then continue end
					v:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
				end
			end
		end
		if ply:IsOnGround() then
			self:ThrowStart()
		end
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW and statusend then
		if self.LastNadeAnim then
			local len = self:GetActivityLength(self.LastNadeAnim, true, self.LastNadeAnimType)
			self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW_WAIT, len - (self.LastNadeDelay or len))
		end
		if CLIENT then
			self:AttachVMEffects()
		elseif SERVER and game.SinglePlayer() then
			self:CallOnClient("AttachVMEffects", "")
		end
	end

	if stat == TFA.Enum.STATUS_RAGNAROK_DEPLOY and statusend then
		self:PlantDG4()
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW_WAIT and statusend then
		self:SetStatus(TFA.GetStatus("idle"))
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:CanSecondaryAttack()
	local tr = util.QuickTrace(self:GetOwner():GetShootPos(), Vector(0,0,-128), {self:GetOwner(), self})
	return tr.HitWorld and self:CanPrimaryAttack() and self:Clip1() >= self:GetStatL("Primary.AmmoConsumption")
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end
	if nzombies and not self:GetOwner():GetNotDowned() then return end

	self:SendViewModelAnim(ACT_VM_DEPLOY)
	self:ScheduleStatus(TFA.Enum.STATUS_RAGNAROK_DEPLOY, self:GetActivityLength())
	self:SetNextPrimaryFire(self:GetStatusEnd())
end

function SWEP:PlantDG4()
	if CLIENT then return end
	local ply = self:GetOwner()
	local ang = self:GetAimVector():Angle()
	ang = Angle(0, ang.yaw, ang.roll)

	local pos = ply:GetShootPos()
	local tr = util.QuickTrace(pos, Vector(0,0,-128), {ply, self})
	if not tr.HitWorld then return end

	local ent = ents.Create("waw_special_gravspike")
	ent:SetModel("models/hunter/blocks/cube05x1x05.mdl")
	ent:SetPos(tr.HitPos + tr.HitNormal*15)
	ent:SetAngles(ang)
	ent:SetOwner(ply)

	ent:SetTarget(self)
	ent:SetAmmoCount(self:Clip1())
	ent.Damage = self.mydamage
	ent.mydamage = self.mydamage

	ent:Spawn()

	ent:SetOwner(ply)
	ent.WeaponClass = self:GetClass()

	if nzombies then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
	else
		ply:StripWeapon(self:GetClass())
	end
end

local tpfx_cvar = GetConVar("cl_tfa_fx_wonderweapon_3p")
function SWEP:DrawWorldModel(...)
	if tpfx_cvar:GetBool() then
		if TFA.Enum.HolsterStatus[self:GetStatus()] then
			if self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
				self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
			end
			if self.WW3P_REMOVECALLBACK then
				self:WW3P_REMOVECALLBACK(self, self:GetOwner())
			end
		else
			if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
				self.CL_3PDrawFX = CreateParticleSystem(self, tostring(self.WW3P_FX), PATTACH_POINT_FOLLOW, tonumber(self.WW3P_ATT))
			end
			if self.WW3P_CALLBACK then
				self:WW3P_CALLBACK(self, self:GetOwner())
			end
		end
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:CycleSafety()
end

function SWEP:OnDrop(...)
	self:SetDG4Slamming(false)
	if CLIENT and self.WW3P_REMOVECALLBACK then
		self:WW3P_REMOVECALLBACK(self, self:GetOwner())
	end
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:SetDG4Slamming(false)
	if CLIENT and self.WW3P_REMOVECALLBACK then
		self:WW3P_REMOVECALLBACK(self, self:GetOwner())
	end
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster( ... )
	if self:GetDG4Slamming() then
		return false
	end
	return BaseClass.Holster(self,...)
end

function SWEP:IsSpecial()
	return true
end