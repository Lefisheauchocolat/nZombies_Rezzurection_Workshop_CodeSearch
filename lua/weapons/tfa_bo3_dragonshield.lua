local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_backshield_base"
SWEP.Category = "TFA Zombies Buildables"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.shield"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Guard of Fafnir | BO3" or "Guard of Fafnir"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/dragonshield/c_dragonshield.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/dragonshield/w_dragonshield.mdl"
SWEP.HoldType = "melee2"
SWEP.SprintHoldTypeOverride = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 6,
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
SWEP.Primary.ShootSound = "TFA_BO3_DRAGONSHIELD.Shoot"
SWEP.Primary.Sound = "TFA_BO3_SHIELD.Swing"
SWEP.Primary.Sound_Hit = "TFA_BO3_SHIELD.Hit"
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_PREVENT_PHYSICS_FORCE)
SWEP.Primary.RPM = 60
SWEP.Primary.Damage = 115
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 115
SWEP.Secondary.MaxCombo = 0

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.AmmoConsumption = 0
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = 3
SWEP.Secondary.DefaultClip = 3
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 1
SWEP.Secondary.Ammo = "none"

SWEP.ShieldEnabled = true
SWEP.ShieldModel = "models/weapons/tfa_bo3/dragonshield/w_dragonshield_back.mdl"

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

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_special_dragonshield" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 2500 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(0, 3, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AltAttack = false
SWEP.AllowSprintAttack = false

--[NZombies]--
SWEP.NZPaPName = "Tiamat's Maw"
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.Ispackapunched = false

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.PrintName = "Tiamat's Maw"
self:SetNW2String("PrintName", "Tiamat's Maw")

self.Secondary_TFA.ClipSize = 4
self.Secondary_TFA.DefaultClip = 4
self:SetClip2(self.Secondary_TFA.ClipSize)

self.Primary_TFA.ClipSize = 200
self.Primary_TFA.DefaultClip = 200
self:SetClip1(self.Primary_TFA.ClipSize)

local ply = self:GetOwner()
if IsValid(ply) then
	ply.DragonShieldPAP = true
	if SERVER and self.Shield and IsValid(self.Shield) then
		self.Shield:SetMaxHealth(self.Shield:GetMaxHealth()*2)
		self.Shield:SetHealth(self.Shield:GetMaxHealth())
	end
end

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HITCENTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SHIELD.SwingCloth") },
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

SWEP.ShieldFireBlock = true

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

if nzombies then
function SWEP:Equip(ply)
	if SERVER and ply.DragonShieldPAP then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:ApplyNZModifier("pap")
			if IsValid(ply) and ply.PLEASEFIXNZSAWFULWEAPONSYSTEM2 then
				ply.PLEASEFIXNZSAWFULWEAPONSYSTEM2 = nil
			end
		end)
	end

	return BaseClass.Equip(self, ply)
end
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end
	if self:Clip2() < self:GetStatL("Secondary.AmmoConsumption") then return end

	self:SetNextPrimaryFire(self2.GetNextCorrectedPrimaryFire(self, self2.GetFireDelay(self)))
	self:SetStatus(TFA.Enum.STATUS_SHOOTING, self:GetNextPrimaryFire(self))

	local ifp = IsFirstTimePredicted()

	local _, tanim = self:ChooseShootAnim(ifp)

	self:BashAnim()
	if sp and SERVER then self:CallOnClient("BashAnim", "") end

	if SERVER and self:GetStatL("Primary.SoundHint_Fire") then
		sound.EmitHint(bit.bor(SOUND_COMBAT, SOUND_CONTEXT_GUNFIRE), self:GetPos(), self:GetSilenced() and 500 or 1500, 0.2, self:GetOwner())
	end

	self2.TakeSecondaryAmmo(self, self:GetStatL("Secondary.AmmoConsumption"))

	self:EmitGunfireSound(self:GetStatL("Primary.ShootSound"))
	self:ShootBulletInformation()
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:PostSpawnProjectile(ent)
	local aimcone = 1
	local dir
	local ang = self:GetOwner():GetAimVector():Angle()
	ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
	ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
	dir = ang:Forward()

	ent:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetAngles(ang)
		phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	end
end
