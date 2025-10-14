local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_backshield_base"
SWEP.Category = "TFA Zombies Buildables"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.shield"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Tranzit Shield | BO2" or "Tranzit Shield"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/tranzitshield/c_tranzitshield.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/tranzitshield/w_tranzitshield.mdl"
SWEP.HoldType = "melee2"
SWEP.SprintHoldTypeOverride = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 5,
		Right = 12,
		Forward = 4,
	},
	Ang = {
		Up = 170,
		Right = 180,
		Forward = -12
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO2_SHIELD.Swing"
SWEP.Primary.Sound_Hit = "TFA_BO2_SHIELD.Hit"
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_PREVENT_PHYSICS_FORCE)
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 115
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 115
SWEP.Secondary.MaxCombo = 0
SWEP.Secondary.Automatic = false
SWEP.Delay = 0.35

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.AmmoConsumption = 0
SWEP.Primary.Ammo = "none"

SWEP.ShieldEnabled = true
SWEP.ShieldModel = "models/weapons/tfa_bo2/tranzitshield/w_tranzitshield_back.mdl"

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 70, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(65, 0, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 4 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 10, --Hullsize
	}
}

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(0, 3, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AllowSprintAttack = false

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/zm_riotshield_icon.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

function SWEP:NZSpecialHolster(wep)
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
{ ["time"] = 25 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Press") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
},
[ACT_VM_HITCENTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Cloth") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_SHIELD.Recover") },
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

SWEP.StatCache_Blacklist = {
	["Bodygroups_V"] = true,
}

DEFINE_BASECLASS(SWEP.Base)

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	self:SendViewModelAnim(ACT_VM_PULLPIN)
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, self:GetActivityLength())
	self:SetNextPrimaryFire(self:GetStatusEnd())
end

function SWEP:Reload()
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY and self:GetOwner():KeyDown(IN_ATTACK2) then
		self:SendViewModelAnim(ACT_VM_DEPLOY)
		self:ScheduleStatus(TFA.Enum.STATUS_BASHING, self:GetActivityLength())
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end
end

function SWEP:Think2(...)
	if self:GetOwner():IsPlayer() then
		local stat = self:GetStatus()
		local statusend = CurTime() >= self:GetStatusEnd()
		local ply = self:GetOwner()

		if stat == TFA.Enum.STATUS_GRENADE_PULL and statusend then
			self:SetStatus(TFA.Enum.STATUS_GRENADE_READY, math.huge)
		end

		if stat == TFA.Enum.STATUS_GRENADE_READY and not ply:KeyDown(IN_ATTACK2) then
			self:ThrowStart()
		end

		if stat == TFA.Enum.STATUS_GRENADE_READY and self:GetSprinting() then
			self:SendViewModelAnim(ACT_VM_DEPLOY)
			self:ScheduleStatus(TFA.Enum.STATUS_BASHING, self:GetActivityLength())
			self:SetNextPrimaryFire(self:GetStatusEnd())
		end

		if stat == TFA.Enum.STATUS_GRENADE_THROW and statusend then
			if SERVER then
				self:PlantShield()
			end
			self:SetStatus(TFA.Enum.STATUS_IDLE)
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:ThrowStart()
	local ply = self:GetOwner()
	local success, tanim, animType = self:ChooseShootAnim()
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, self.Delay)

	if success then
		self.LastNadeAnim = tanim
		self.LastNadeAnimType = animType
		self.LastNadeDelay = self.Delay
	end
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

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

function SWEP:NotifyShieldMessage()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "COULD NOT FIND AREA TO PLACE")
		ply._TFA_LastJamMessage = RealTime() + 1
	end
end

function SWEP:PlantShield()
	local ply = self:GetOwner()
	local ang = self:GetAimVector():Angle()
	ang = Angle(0, ang.yaw, ang.roll)

	local offset = Vector(0, 0, ply:IsPlayer() and ply:GetStepSize()*0.5 or 12)
	local pos = ply:GetShootPos() + (ang:Forward() * 15)
	local tr = util.QuickTrace(pos, Vector(0,0,-128), {ply, self})
	local tr1 = util.QuickTrace(ply:GetPos() + offset, ply:GetForward() * 40, {ply, self})

	if not tr.HitWorld then self:NotifyShieldMessage() return end
	if tr1.Hit then self:NotifyShieldMessage() return end

	local ent = ents.Create("cod_plantedshield")
	ent:SetModel(self.WorldModel)
	ent:SetPos(tr.HitPos + tr.HitNormal*27)
	ent:SetAngles(ang)
	ent:SetOwner(ply)

	ent:SetMaxHealth(ply:GetShield():GetMaxHealth())
	ent:SetHealth(ply:GetShield():Health())
	ent:SetShieldClass(self:GetClass())
	ent.ElectricHitsMax = self.ElectricHitsMax or 6
	ent.ElectricHitDamage = self.ElectricHitDamage or 15

	ent:Spawn()
	ent:SetOwner(ply)
	ent.Inflictor = self:GetClass()

	if self.GetElectrified and self:GetElectrified() and ent.Electrify then
		ent:Electrify(self.GetElectricHits and self:GetElectricHits() or 0)
	end

	if nzombies then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
	end

	SafeRemoveEntity(ply:GetShield())
	timer.Simple(0, function()
		if not IsValid(ply) or not IsValid(self) then return end
		ply:StripWeapon(self:GetClass())
	end)
end
