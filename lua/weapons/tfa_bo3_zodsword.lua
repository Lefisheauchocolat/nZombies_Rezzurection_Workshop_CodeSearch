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
SWEP.PrintName = "Apothicon Sword"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/zodsword/c_zodsword.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/zodsword/w_zodsword.mdl"
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
SWEP.Primary.Sound = "TFA_BO3_ZODSWORD.Swing"
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
SWEP.Primary.DamageType = bit.bor(DMG_SLASH, DMG_SHOCK)

SWEP.Primary.MaxCombo = 0
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK,
		["len"] = 90,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-72,36,-24), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 115,
		["dmgtype"] = bit.bor(DMG_SLASH, DMG_SHOCK),
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
		["dmgtype"] = bit.bor(DMG_SLASH, DMG_SHOCK),
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
SWEP.Secondary.BashSound = Sound("TFA_BO3_ZODSWORD.Swing")
SWEP.Secondary.BashHitSound = Sound("TFA_BO3_GAUNTLET.Hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("TFA_BO3_GAUNTLET.Impact")
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

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "specialist"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/uie_t7_zm_hud_ammo_dpadicnswrd_weapon_ready.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/uie_t7_zm_hud_ammo_dpadicnswrd_electric_ready.png", "unlitgeneric smooth")

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnSpecialistRecharged()
	if CLIENT then
		self.NZPickedUpTime = CurTime()
	end
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
[ACT_VM_PULLPIN] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.Jump") },
},
[ACT_VM_THROW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.GroundStrike") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZODSWORD.SparkExplode") },
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

SWEP.Callback = {}
SWEP.BO3CanSlam = true

SWEP.WW3P_FX = "bo3_zodsword_3p"
SWEP.WW3P_ATT = 2

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local CurTime = CurTime
local pvp_bool = GetConVar("sbox_playershurtplayers")
local sp = game.SinglePlayer()
local aimvec

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Bool", "DG4Slamming")
	self:NetworkVarTFA("Vector", "SlamNormal")
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

function SWEP:WalkBob(pos, ang, ...)
	if self:GetDG4Slamming() then
		return pos, ang
	end

	return BaseClass.WalkBob(self, pos, ang, ...)
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
		ParticleEffectAttach("bo3_zodsword_trail", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
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

	if nzombies then
		dmginfo:SetDamageType(DMG_MISSILEDEFENSE)

		local ent = trace.Entity
		if IsValid(ent) and string.find(ent:GetClass(), "nz_zombie_boss") then
			dam = math.max(800, ent:GetMaxHealth() / 12)
			dmginfo:SetDamage(dam)
		else
			dam = math.huge
			dmginfo:SetDamage(dam)
		end
	end

	trace.Entity:DispatchTraceAttack(dmginfo, trace, self:GetOwner():EyeAngles():Forward())

	dmginfo:SetDamage(dam)

	self:ApplyForce(trace.Entity, dmginfo:GetDamageForce(), trace.HitPos)
	self:SetMelAttackID(1)
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
	local success, tanim, animType = self:ChooseShootAnim()
	local ply = self:GetOwner()

	local delay = self.Delay
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, delay)

	self:ShootEffectsCustom()
	local qtr = util.QuickTrace(self:GetPos(), Vector(0,0,-32), {self:GetOwner(), self})
	util.Decal("Scorch", qtr.HitPos - qtr.HitNormal, qtr.HitPos + qtr.HitNormal)

	local tr = {
		start = self:GetPos(),
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 150)) do
		if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

			local damage = DamageInfo()
			damage:SetDamage(nzombies and v:Health() + 666 or self:GetStatL("Primary.Damage"))
			damage:SetAttacker(IsValid(ply) and ply or self)
			damage:SetInflictor(self)
			damage:SetDamageType(DMG_SHOCK)
			damage:SetDamageForce(v:GetUp()*6000 + (tr.endpos - tr.start):GetNormalized()*math.random(8000,12000))
			damage:SetDamagePosition(hitpos)

			if damage:GetDamage() >= v:Health() then
				if sp or (!sp and IsFirstTimePredicted()) then
					ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, v, 2)
					if v:OnGround() then
						ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, v, 0)
					end
				end
			end

			if SERVER then
				v:TakeDamageInfo(damage)
			end
		end
	end

	if success then
		self.LastNadeAnim = tanim
		self.LastNadeAnimType = animType
		self.LastNadeDelay = delay
	end
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if not ply:OnGround() then return end
	if nzombies and not self:GetOwner():GetNotDowned() then return end
	
	local _, tanim = self:ChoosePullAnim()

	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, self:GetActivityLength(tanim))
	self:TakePrimaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))

	local ang = self:GetAimVector():Angle()
	local fwd = Angle(0,ang.yaw,ang.roll):Forward()
					
	self:SetSlamNormal(fwd)
	self:SetDG4Slamming(true)
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end

	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()
	local progress = self:GetStatusProgress()
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)
		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(3)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 20
			self.DLight.g = 255
			self.DLight.b = 255
			self.DLight.decay = 1000
			self.DLight.brightness = 1
			self.DLight.size = 64
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

	if stat == TFA.Enum.STATUS_GRENADE_PULL then
		if statusend then
			self:SetStatus(TFA.Enum.STATUS_GRENADE_READY, math.huge)
		end
	end

	if stat == TFA.Enum.STATUS_GRENADE_READY and ply:IsOnGround() then
		self:ThrowStart()
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW and statusend then
		if self.LastNadeAnim then
			local len = self:GetActivityLength(self.LastNadeAnim, true, self.LastNadeAnimType)
			self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW_WAIT, len - (self.LastNadeDelay or len))
		end
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW_WAIT and statusend then
		self:SetStatus(TFA.GetStatus("idle"))
	end

	return BaseClass.Think2(self, ...)
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

function SWEP:OnDrop(...)
	self:SetDG4Slamming(false)
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:SetDG4Slamming(false)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster( ... )
	self:SetDG4Slamming(false)
	return BaseClass.Holster(self,...)
end

function SWEP:IsSpecial()
	return true
end