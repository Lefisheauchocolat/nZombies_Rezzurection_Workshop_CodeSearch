local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_bash_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = false
SWEP.UseHands = true
//SWEP.Type_Displayed = "None"
SWEP.Purpose = "W@W Lantern model animated by pauladam316, originally scripted by JJ173[Apex] & YaPhi1l. \nFrom the World at War custom map 'Zombie Crash' by chromastone10"
SWEP.Author = "chromastone10, JJ173[Apex], YaPhi1l, pauladam316, FlamingFox"
SWEP.Slot = 5
SWEP.PrintName = nzombies and "Lantern | WAW" or "Lantern"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true
SWEP.DrawAmmo = false

--[Model]--
SWEP.ViewModel = "models/weapons/tfa_waw/lantern/c_lantern.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/weapons/tfa_waw/lantern/w_lantern.mdl"
SWEP.CarryModel = "models/weapons/tfa_waw/lantern/carry_lantern.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 4,
        Right = 2,
        Forward = 4,
        },
        Ang = {
		Up = -180,
        Right = -180,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false

--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = nzombies and 600 or 15
SWEP.Secondary.BashSound = "TFA_WAW_LANTERN.Attack"
SWEP.Secondary.BashHitSound = "TFA_WAW_LANTERN.Hit"
SWEP.Secondary.BashHitSound_Flesh = "TFA_WAW_LANTERN.Slash"
SWEP.Secondary.BashLength = 55
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashEnd = 0.7
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = false

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = 0.0

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.VMOffsetWalk = Vector(-1.4, -1.6, -1.4)
SWEP.RunSightsPos = Vector(-1, -1, -0.5)
SWEP.RunSightsAng = Vector(-15, 0, 0)
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/zom_hud_icon_buildable_gen_lamp.png", "unlitgeneric smooth")

function SWEP:NZSpecialHolster()
	self:StopSound("TFA_WAW_LANTERN.Burn")
	return true
end

--[Tables]--
SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
}

SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = "TFA_WAW_GEAR.Cloth" },
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = "TFA_WAW_GEAR.Rattle" },
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = "TFA_WAW_LANTERN.Burn" },
},
[ACT_VM_IDLE] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = "TFA_WAW_LANTERN.Burn" },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = "TFA_WAW_GEAR.Cloth" },
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = "TFA_WAW_GEAR.Rattle" },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.IsLantern = true

SWEP.WorldModelBoneMods = {
}

SWEP.VElements = {
	["sprite"] = { type = "Sprite", sprite = "sprites/animglow01-", bone = "j_gun", rel = "", pos = Vector(0,0,-1.4), size = {x = 1, y = 1}, color = Color(255, 165, 0, 25), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true, active = true },
}
SWEP.WElements = {
	["sprite"] = { type = "Sprite", sprite = "sprites/animglow01-", bone = "j_gun", rel = "", pos = Vector(0,0,-1.4), size = {x = 1, y = 1}, color = Color(255, 165, 0, 45), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = true },
}

SWEP.StatCache_Blacklist = {
	["VElements"] = true,
	["WElements"] = true,
}

DEFINE_BASECLASS( SWEP.Base )

//thats right were gonna cheat
function SWEP:DrawHUDBackground()
	local size = math.Rand(14,16)
	self.VElements["sprite"].size = {x = size, y = size}

	if DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if self.DLight then
			local attpos = (self:IsFirstPerson() and self:GetOwner():GetViewModel() or self):GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 235
			self.DLight.g = 125
			self.DLight.b = 35
			self.DLight.decay = 2000
			self.DLight.brightness = 0.5
			self.DLight.size = 256
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end
end

function SWEP:DrawWorldModel(...)
	local size = math.Rand(14,18)
	self.WElements["sprite"].size = {x = size, y = size}

	if DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if self.DLight then
			local attpos = (IsValid(self:GetOwner()) and self:IsFirstPerson() and self:GetOwner():GetViewModel() or self):GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 235
			self.DLight.g = 125
			self.DLight.b = 35
			self.DLight.decay = 2000
			self.DLight.brightness = 0.5
			self.DLight.size = 256
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:CreateCarryLantern(ply)
	self.Lantern = ents.Create("cod_carrylantern")
	self.Lantern:SetModel("models/weapons/tfa_waw/lantern/carry_lantern.mdl")
	self.Lantern:SetOwner(ply)
	self.Lantern:SetWeapon(self)
	self.Lantern:Spawn()
	self.Lantern:SetOwner(ply)
end

function SWEP:Equip(ply)
	if ply:IsPlayer() and !self.Lantern or !IsValid(self.Lantern) then
		self:CreateCarryLantern(ply)
	end

	return BaseClass.Equip(self, ply)
end

function SWEP:Think2(...)
	if SERVER and self:GetStatus() == TFA.Enum.STATUS_HOLSTER and CurTime() >= self:GetStatusEnd() then
		if self.Lantern and IsValid(self.Lantern) then
			self.Lantern:SetNoDraw(false)
		else
			self:Remove()
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:Deploy(...)
	if SERVER then
		if self.Lantern and IsValid(self.Lantern) then
			self.Lantern:SetNoDraw(true)
		else
			self:Remove()
		end
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:OnRemove(...)
	self:StopSound("TFA_WAW_LANTERN.Burn")
	if SERVER then
		if self.Lantern and IsValid(self.Lantern) then
			self.Lantern:Remove()
		end
	end

	return BaseClass.OnRemove(self,...)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_WAW_LANTERN.Burn")
	if SERVER then
		if self.Lantern and IsValid(self.Lantern) then
			self.Lantern:Remove()
		end
	end

	return BaseClass.OnDrop(self, ...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_WAW_LANTERN.Burn")
	if SERVER then
		if self.Lantern and IsValid(self.Lantern) then
			self.Lantern:Remove()
		end
	end

	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("TFA_WAW_LANTERN.Burn")
	self:StopSoundNet("TFA_WAW_LANTERN.Burn")

	return BaseClass.Holster(self,...)
end

function SWEP:PrimaryAttack()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end
