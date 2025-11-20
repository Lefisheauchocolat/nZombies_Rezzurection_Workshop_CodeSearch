local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_melee_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.specialist"
SWEP.Purpose = "Carried by Takeo Masaki through both victory and sacrifice, the Path of Sorrows is a tragic blade with many more tales to tell."
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Path of Sorrows | BO4" or "Path of Sorrows"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/katana/c_katana.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/katana/w_katana.mdl"
SWEP.HoldType = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 0.5,
		Right = 1.5,
		Forward = 3,
	},
	Ang = {
		Up = -180,
		Right = 180,
		Forward = 0
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_KATANA.Slash"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = inf_cvar:GetBool() and 0 or 5
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Delay = 0.35
SWEP.Primary.DamageType = bit.bor(DMG_SLASH, DMG_SLOWBURN)

SWEP.Primary.MaxCombo = 0
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSLEFT,
		["len"] = 90,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-72,36,0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 115,
		["dmgtype"] = DMG_SLASH,
		["delay"] = 0.2,
		["snd"] = "TFA_BO4_KATANA.Slash",
		["viewpunch"] = Angle(2,4,0),
		["viewpunchb"] = Angle(2,-4,0),
		["hitflesh"] = "TFA_BO3_ZODSWORD.Impact",
		["hitworld"] = "TFA_BO3_STAFFS.MeleeHit",
		["end"] = 0.9,
		["hull"] = 10,
		["maxhits"] = 666,
	}
}

SWEP.Secondary.MaxCombo = 0
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_MISSLEFT,
		["len"] = 90,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(72,36,0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 115,
		["dmgtype"] = DMG_SLASH,
		["delay"] = 0.2,
		["snd"] = "TFA_BO4_KATANA.Slash",
		["viewpunch"] = Angle(2,4,0),
		["viewpunchb"] = Angle(2,-4,0),
		["hitflesh"] = "TFA_BO3_ZODSWORD.Impact",
		["hitworld"] = "TFA_BO3_STAFFS.MeleeHit",
		["end"] = 0.95,
		["hull"] = 10,
		["maxhits"] = 666,
	}
}

SWEP.Secondary.Sound = "TFA_BO4_KATANA.Dash"
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 10

SWEP.MuzzleFlashEffect = ""
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true
SWEP.Delay = 0.1
SWEP.AmmoRegen = 1

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Misc]--
SWEP.InspectPos = Vector(4, 0, 1)
SWEP.InspectAng = Vector(0, 15, 15)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-12, 0, -1)
SWEP.SafetyAng = Vector(0, -20, -45)
SWEP.SmokeParticle = ""
SWEP.AllowSprintAttack = false
SWEP.Secondary.CanBash = false

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/ui_icon_equipment_zm_katana_lvl3_dark.png", "unlitgeneric smooth")

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

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Draw") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Holster") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_OVERKILL.Deploy") },
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Deploy") },
},
[ACT_VM_MISSLEFT] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Slash") },
},
[ACT_VM_MISSRIGHT] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Slash") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Grab") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_KATANA.Ult") },
},
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

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.BO3CanDash = true
SWEP.BO3DashMult = 3

SWEP.DTapActivities = {
	[ACT_VM_PRIMARYATTACK] = true,
	[ACT_VM_PRIMARYATTACK_EMPTY] = true,
	[ACT_VM_PRIMARYATTACK_SILENCED] = true,
	[ACT_VM_PRIMARYATTACK_1] = true,
	[ACT_VM_SECONDARYATTACK] = true,
	[ACT_VM_MISSLEFT] = true,
}

SWEP.WW3P_FX = "bo4_katana_3p"
SWEP.WW3P_ATT = 2

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local pvp_bool = GetConVar("sbox_playershurtplayers")
local l_CT = CurTime

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Dashing")
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

	return BaseClass.Deploy(self, ...)
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()

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
			ParticleEffectAttach("bo4_katana_trail", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
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

function SWEP:CanSecondaryAttack()
	return BaseClass.CanPrimaryAttack(self) and self:Clip1() >= self:GetStatL("Secondary.AmmoConsumption")
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanSecondaryAttack() then return end
	if not ply:OnGround() then return end
	if nzombies and not ply:GetNotDowned() then return end
	
	self:EmitSoundNet(self:GetStatL("Secondary.Sound"))

	self:SendViewModelAnim(ACT_VM_MISSRIGHT)
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, 25/30 / self:GetAnimationRate())
	self:SetNextPrimaryFire(CurTime() + self:GetActivityLength())
	self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))

	if IsFirstTimePredicted() and self:VMIV() then
		ParticleEffectAttach("bo4_katana_trail", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
	end

	self:SetDashing(true)
end

function SWEP:CanAltAttack()
	local stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if l_CT() < self:GetNextPrimaryFire() then return false end

	return true
end

function SWEP:AltAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanAltAttack() then return end
	if nzombies and not ply:GetNotDowned() then return end
	if nzombies and self:GetHasNuked() then return end
	if ply:BO4IsStealth() then return end

	self:SendViewModelAnim(ACT_VM_PULLBACK)
	self:ScheduleStatus(TFA.Enum.STATUS_BLOCKING , self:GetActivityLength())
	self:SetNextPrimaryFire(self:GetStatusEnd())
	if nzombies then self:SetHasNuked(true) end

	if SERVER then
		self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))
		ply:BO4KatanaStealth(30)
	end
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

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

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

	if status == TFA.Enum.STATUS_GRENADE_PULL and self:GetDashing() then
		self:KatanaDash()
		if statusend then
			ply:SetAnimation(PLAYER_ATTACK1)
			ply:ViewPunch(Angle(6,2,0))
			self:SetDashing(false)
			if IsFirstTimePredicted() then
				self:Strike(self:GetStatL("Primary.Attacks")[1], self.Precision)
			end
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:ProcessHoldType(...)
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_PULL then
		self:SetHoldType("melee")
		return "melee"
	else
		return BaseClass.ProcessHoldType(self, ...)
	end
end

function SWEP:KatanaDash()
	if CLIENT then return end
	local ply = self:GetOwner()

	local damage = DamageInfo()
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(ply:WorldSpaceCenter(), 42)) do
		if not v:IsWorld() and v:IsSolid() then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end
			if v == ply then continue end
			if v:GetOwner() == ply then continue end
			if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			damage:SetDamagePosition(v:EyePos())
			damage:SetDamage(v:Health() + 666)
			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 12000)

			if nzombies and (v.NZBossType or v.IsMooBossZombie) then
				damage:SetDamage(12)
			end

			v:Ignite(4)
			v:TakeDamageInfo(damage)

			if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
				v:EmitSound("TFA_BO3_ZODSWORD.Impact")
				util.ScreenShake(v:GetPos(), 10, 255, 0.5, 90)
			end

			ply:SetLocalVelocity(vector_origin)
			break
		end
	end
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
	self:SetDashing(false)
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:SetDashing(false)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster( ... )
	self:SetDashing(false)
	return BaseClass.Holster(self,...)
end
