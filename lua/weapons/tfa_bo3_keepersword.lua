local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_melee_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Keeper Sword | BO3" or "Keeper Sword"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/keepersword/c_keepersword.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/keepersword/w_keepersword.mdl"
SWEP.HoldType = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1.2,
        Forward = 3,
        },
        Ang = {
		Up = 180,
        Right = 180,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_KPRSWORD.Swing"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 5
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 10
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Delay = 0.35
SWEP.Primary.DamageType = bit.bor(DMG_SLASH, DMG_SLOWBURN)

SWEP.Primary.MaxCombo = 0
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK,
		["len"] = 90,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-72,36,-24), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 115,
		["dmgtype"] = DMG_SLASH,
		["delay"] = 0.2,
		["snd"] = "TFA_BO3_ZODSWORD.Swing",
		["viewpunch"] = Angle(2,4,0),
		["viewpunchb"] = Angle(-2,-4,0),
		["hitflesh"] = "TFA_BO3_ZODSWORD.Impact",
		["hitworld"] = "TFA_BO3_STAFFS.MeleeHit",
		["end"] = 0.95,
		["hull"] = 10,
		["maxhits"] = 666,
	}
}

SWEP.Secondary.MaxCombo = 0
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK,
		["len"] = 90,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(72,36,24), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 115,
		["dmgtype"] = DMG_SLASH,
		["delay"] = 0.2,
		["snd"] = "TFA_BO3_ZODSWORD.Swing",
		["viewpunch"] = Angle(2,4,0),
		["viewpunchb"] = Angle(-2,-4,0),
		["hitflesh"] = "TFA_BO3_ZODSWORD.Impact",
		["hitworld"] = "TFA_BO3_STAFFS.MeleeHit",
		["end"] = 0.95,
		["hull"] = 10,
		["maxhits"] = 666,
	}
}

SWEP.MuzzleFlashEffect = "tfa_bo3_muzzleflash_zodsword"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true
SWEP.Delay = 0.1
SWEP.AmmoRegen = 1

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

/*--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 800
SWEP.Secondary.BashSound = Sound("TFA_BO3_KPRSWORD.Swing")
SWEP.Secondary.BashHitSound = Sound("TFA_BO3_GAUNTLET.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_BO3_GAUNTLET.Hit")
SWEP.Secondary.BashLength = 55
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = bit.bor(DMG_SLASH, DMG_CLUB)
SWEP.Secondary.BashInterrupt = false*/

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Misc]--
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(0, 10, 10)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""
SWEP.AllowSprintAttack = false

--[Projectile]--
SWEP.Secondary.Projectile         = "bo3_special_keepersword" -- Entity to shoot
SWEP.Secondary.ProjectileVelocity = 1000 -- Entity to shoot's velocity
SWEP.Secondary.ProjectileModel    = "models/weapons/tfa_bo3/keepersword/keepersword_projectile.mdl" -- Entity to shoot's model

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/uie_t7_zm_hud_ammo_dpadicnswrdkpr_weapon_ready.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/uie_t7_zm_hud_ammo_dpadicnswrd_new.png", "unlitgeneric smooth")

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
SWEP.SequenceRateOverride = {
}
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.Raise") },
},
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DEPLOY] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_KPRSWORD.Throw") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.SwingFoly") },
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.SwingFoly") },
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.Swing") },
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

SWEP.WW3P_FX = "bo3_keepersword_3p"
SWEP.WW3P_ATT = 2

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local CurTime = CurTime
local pvp_bool = GetConVar("sbox_playershurtplayers")

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Bool", "HasNuked")
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

	return BaseClass.Deploy(self,...)
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if IsValid(ply) and ply:IsNPC() then
		local _, attk = self:ChoosePrimaryAttack()
		if not attk then return end
		local owv = self:GetOwner()

		timer.Simple(0.5, function()
			if IsValid(self) and IsValid(owv) and owv:IsCurrentSchedule(SCHED_MELEE_ATTACK1) then
				self:Strike(attk, 5)
			end
		end)

		self:SetNextPrimaryFire(CurTime() + attk["end"] or 1)

		timer.Simple(self:GetNextPrimaryFire() - CurTime(), function()
			if IsValid(owv) then
				owv:ClearSchedule()
			end
		end)

		self:GetOwner():SetSchedule(SCHED_MELEE_ATTACK1)
		return
	end

	if self:GetSprinting() and not self:GetStatL("AllowSprintAttack", false) then return end
	if self:IsSafety() then return end
	if not self:VMIV() then return end
	if !self:CanPrimaryAttack() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end

	local maxcombo = self:GetStatL("Primary.MaxCombo", 0)
	if maxcombo > 0 and self:GetComboCount() >= maxcombo then return end

	local ind, attack = self:ChoosePrimaryAttack()
	if not attack then return end

	--We have attack isolated, begin attack logic
	self:PlaySwing(attack.act)

	self:TakePrimaryAmmo(self:GetStatL("Primary.AmmoConsumption"))
	if IsFirstTimePredicted() then
		if self:VMIV() then
			ParticleEffectAttach("bo3_keepersword_trail_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
		end
		self:EmitSound(attack.snd)
		if ply.Vox then
			ply:Vox("bash", 4)
		end
	end

	self:SetVP(true)
	self:SetVPPitch(attack.viewpunch.p)
	self:SetVPYaw(attack.viewpunch.y)
	self:SetVPRoll(attack.viewpunch.r)
	self:SetVPTime(CurTime() + 0.05 / self:GetAnimationRate(attack.act))

	self.up_hat = false
	self:ScheduleStatus(TFA.Enum.STATUS_SHOOTING, attack.delay / self:GetAnimationRate(attack.act))
	self:SetMelAttackID(ind)
	self:SetNextPrimaryFire(CurTime() + attack["end"] / self:GetAnimationRate(attack.act))

	ply:SetAnimation(PLAYER_ATTACK1)

	self:SetNextSecondaryFire(CurTime() + 12/30 / self:GetAnimationRate())
end

function SWEP:ApplyDamage(trace, dmginfo, attk)
	local dam, force = dmginfo:GetBaseDamage(), dmginfo:GetDamageForce()
	dmginfo:SetDamagePosition(trace.HitPos)
	dmginfo:SetReportedPosition(trace.StartPos)
	dmginfo:SetDamageForce(force*6)

	local ent = trace.Entity
	if nzombies then
		dmginfo:SetDamageType(DMG_MISSILEDEFENSE)

		if IsValid(ent) and string.find(ent:GetClass(), "nz_zombie_boss") then
			dam = math.max(800, ent:GetMaxHealth() / 12)
			dmginfo:SetDamage(dam)
		else
			dam = math.huge
			dmginfo:SetDamage(dam)
		end
	end

	if IsValid(ent) and (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or ent:IsRagdoll()) then
		if ent.GetBloodColor then
			local badblood = {
				[DONT_BLEED] = true,
				[BLOOD_COLOR_MECH] = true,
			}

			if badblood[ent:GetBloodColor()] then
				ParticleEffect("bo3_keepersword_hit", trace.HitPos, force:Angle())
			else
				ParticleEffect("bo3_keepersword_hit_flesh", trace.HitPos, force:Angle())
			end
		else
			ParticleEffect("bo3_keepersword_hit_flesh", trace.HitPos, force:Angle())
		end
	else
		ParticleEffect("bo3_keepersword_hit", trace.HitPos, force:Angle())
	end

	if SERVER and ent.Ignite then
		if nzombies then
			if IsValid(ent) and ent:IsValidZombie() then
				ent:Ignite(3)
			end
		else
			ent:Ignite(3)
		end
	end

	trace.Entity:DispatchTraceAttack(dmginfo, trace, self:GetOwner():EyeAngles():Forward())

	dmginfo:SetDamage(dam)

	self:ApplyForce(trace.Entity, dmginfo:GetDamageForce(), trace.HitPos)
	self:SetMelAttackID(1)
end

function SWEP:ChooseThrowAnim()
	local tanim = ACT_VM_DEPLOY
	self:SendViewModelAnim(tanim)

	return true, tanim
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if self:GetHasNuked() then return end

	self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))

	local _, tanim = self:ChooseThrowAnim()
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, self:GetActivityLength(tanim))

	self:ThrowSword()
	self:SetHasNuked(true)

	self:SetNextPrimaryFire(self2.GetNextCorrectedPrimaryFire(self, self:GetActivityLength(tanim)))
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end

	local ply = self:GetOwner()
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)
		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(3)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 30
			self.DLight.b = 10
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5
			self.DLight.size = 128
			self.DLight.dietime = CurTime() + 1
		end
	end

	if self.up_hat and self:GetNextSecondaryFire() ~= 0 and self:GetNextSecondaryFire() < CurTime() then
		self:SetMelAttackID(-1)
		self.up_hat = false
		self:ScheduleStatus(TFA.Enum.STATUS_SHOOTING, 5/30)
		ply:SetAnimation(PLAYER_ATTACK1)

		local attack = self:GetStatL("Primary.Attacks")[1]

		self:SetVP(true)
		self:SetVPPitch(attack.viewpunchb.p)
		self:SetVPYaw(attack.viewpunchb.y)
		self:SetVPRoll(attack.viewpunchb.r)
		self:SetVPTime(CurTime() + attack.delay / self:GetAnimationRate(attack.act))

		self:SetNextSecondaryFire(0)
	end

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:ThrowSword()
	if CLIENT then return end
	local ent = ents.Create(self:GetStatL("Secondary.Projectile"))
	local ang = self:GetAimVector():Angle()

	ent:SetPos(self:GetOwner():GetShootPos())
	ent:SetOwner(self:GetOwner())
	ent:SetAngles(Angle(0,ang[2],0))

	ent:SetAttacker(self:GetOwner())
	ent:SetInflictor(self)

	ent.damage = self:GetStatL("Secondary.Damage")
	ent.mydamage = self:GetStatL("Secondary.Damage")

	if self:GetStatL("Secondary.ProjectileModel") then
		ent:SetModel(self:GetStatL("Secondary.ProjectileModel"))
	end

	ent:Spawn()

	if self.ProjectileModel then
		ent:SetModel(self:GetStatL("Secondary.ProjectileModel"))
	end

	ent:SetOwner(self:GetOwner())
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

function SWEP:CycleSafety()
end

function SWEP:IsSpecial()
	return true
end