local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)
SWEP.Category = "nZombies Powerups"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 0
SWEP.PrintName = "Berzerk"
SWEP.Purpose = "Rip & Tear, until it is done."
SWEP.DrawCrosshair = true

--[Model]--
SWEP.ViewModel = "models/weapons/bo3_melees/fists/c_fists.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel = "models/weapons/bo3_melees/fists/w_fists.mdl"
SWEP.HoldType = "fist"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 0
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("Weapon_BO3_FISTS.Swing")
SWEP.Primary.Sound_Hit = Sound("Weapon_BO3_FISTS.Hit")
SWEP.Primary.DamageType = bit.bor(DMG_MISSILEDEFENSE)
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 9999
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 9999
SWEP.Secondary.MaxCombo = 0

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 80, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(20, 25, -5), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 8 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 20, --Hullsize
	},
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 80, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-20, 25, -5), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 8 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 20, --Hullsize
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 100, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 35, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Secondary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 6 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 20, --Hullsize
	},
	{
		["act"] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 100, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 35, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Secondary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 6 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 20, --Hullsize
	}
}

--[Stuff]--
SWEP.ImpactDecal = ""
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AltAttack = false
SWEP.AllowSprintAttack = false

--[Tables]--
SWEP.SequenceRateOverride = {
	["showcase_in"] = 60 / 30,
	["showcase_out"] = 60 / 30,
	[ACT_VM_MISSCENTER] = 75 / 30,
	[ACT_VM_DRAW] = 60 / 30,
	[ACT_VM_HOLSTER] = 60 / 30,
	[ACT_VM_MISSRIGHT] = 75 / 30,
	[ACT_VM_HITCENTER] = 60 / 30,
	[ACT_VM_HITRIGHT] = 60 / 30,
	["sprint_loop"] = 45 / 30
}

SWEP.EventTable = {
	["draw_first"] = {
		{time = 7 / 30, type = "sound", value = "Weapon_BO3_FISTS.Crack"},
	},
	["taunt"] = {
		{time = 1 / 30, type = "sound", value = "Weapon_BO3_FISTS.Taunt"},
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

SWEP.CustomizeAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_in",
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_idle",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_out",
	}
}

SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "display"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}

function SWEP:NZSpecialHolster(wep)
	local ply = self:GetOwner()
	if SERVER and IsValid(ply) then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
		ply:RemovePowerUp("berzerk")
	end
	return true
end

function SWEP:Deploy(...)
	if SERVER and self.IsFirstDeploy then
		local ply = self:GetOwner()
		local damage = DamageInfo()
		damage:SetAttacker(ply)
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_MISSILEDEFENSE)

		for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 150)) do
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

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Customize_Mode = TFA.Enum.LOCOMOTION_HYBRID