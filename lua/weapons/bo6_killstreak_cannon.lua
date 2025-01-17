SWEP.Base				= "tfa_gun_base"
SWEP.Category			= "nZombies Killstreaks" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer		= "Janus Research Inc." --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "Hari, Izaak, TFA" --Author Tooltip
SWEP.Contact			= "" --Contact Info Tooltip
SWEP.Purpose			= "" --Purpose Tooltip
SWEP.Instructions		= "" --Instructions Tooltip
SWEP.Spawnable			= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable		= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair		= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS	= false --Draw the crosshair in ironsights?
SWEP.PrintName			= "Hand Cannon"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 1				-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos			= 54			-- Position in the slot
SWEP.AutoSwitchTo		= false		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom		= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 60			-- This controls how "good" the weapon is for autopickup.
SWEP.NZSpecialCategory = "killstreak"
SWEP.Type_Displayed = "Killstreak"
SWEP.CanChangeWeapon = true

--SWEP.MuzzleFlashEffect = ( TFA and TFA.YanKys_Realistic_Muzzleflashes ) and "tfa_muzzleflash_deagle" or "tfa_muzzleflash_revolver"

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("TFA_CUSTOM_DEAGLE.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.Sound50 = Sound("TFA_CUSTOM_DEAGLE.50")
--SWEP.Primary.SilencedSound = Sound("") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.PenetrationPower = 400
SWEP.Primary.Damage = 500 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 100
SWEP.Primary.HullSize = 4 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 200 -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false
--Miscelaneous Sounds
SWEP.IronInSound = nil --Sound("TFA_CUSTOM_DEAGLE.IronIn")
SWEP.IronOutSound = nil --Sound("TFA_CUSTOM_DEAGLE.IronIn")
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
--Ammo Related
SWEP.Primary.ClipSize = 10 -- This is the size of a clip
SWEP.Primary.DefaultClip = 999 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "StriderMinigun" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.5 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.5 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = 0 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 0 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 0 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 16 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.8 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.95 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.9 --Multiply the player's movespeed by this when sighting.
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/tfa_custom_deagle/c_custom_deagle.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 70		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(-2, 2, -1) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(-2, 0, -25) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = {
	[1] = 0,
	[2] = 1
}
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/tfa_custom_deagle/w_custom_deagle.mdl" -- Weapon world model path
SWEP.Bodygroups_W = {
	[1] = 0,
	[2] = 1
}
SWEP.HoldType = "revolver" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -5,
		Right = 3,
		Forward = -8
	},
	Ang = {
		Up = 90,
		Right = 0,
		Forward = 180
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SPRINTING]]--
SWEP.RunSightsPos = SWEP.VMPos
SWEP.RunSightsAng = SWEP.VMAng
SWEP.SafetyPos = Vector(1, -10, -7)
SWEP.SafetyAng = Vector(60, 0, 0)
SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_TO_LOWERED --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_LOWERED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_LOWERED_TO_IDLE --Number for act, String/Number for sequence
	}
}
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 80 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-1.649, 5, 0.81)
SWEP.IronSightsAng = Vector(0, 0, 0)

--[[INSPECTION]]--
SWEP.InspectPos = Vector(10, -7, -2)
SWEP.InspectAng = Vector(24, 42, 16)
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0
--Shell eject override
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.ShellModel = "models/hdweapons/shell.mdl"
SWEP.ShellScale = math.pow(.5 / 0.955581, 1 / 3)

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 43 / 30,
	[ACT_VM_RELOAD_EMPTY] = 43 / 30,
}
SWEP.SequenceTimeOverride = {
	--[ACT_VM_PRIMARYATTACK] = 0.35,
	--[ACT_VM_PRIMARYATTACK_1] = 0.35,
}

--[[EVENT TABLE]]--
SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{time = 0, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Draw")},
	},
	[ACT_VM_DRAW_EMPTY] = {
		{time = 0, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Draw")},
	},
	[ACT_VM_HOLSTER] = {
		{time = 0, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Holster")},
	},
	[ACT_VM_HOLSTER_EMPTY] = {
		{time = 0, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Holster")},
	},
	[ACT_VM_RELOAD] = {
		{time = 1 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Lift")},
		{time = 6 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.ClipOut")},
		{time = 34 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.ClipIn")},
	},
	[ACT_VM_RELOAD_EMPTY] = {
		{time = 1 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Lift")},
		{time = 6 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.ClipOut")},
		{time = 34 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.ClipIn")},
		{time = 45 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Chamber")},
	},
	[ACT_VM_FIDGET] = {
		{time = 1 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Look")},
		{time = 52 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Look")},
		{time = 103 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Pull")},
		{time = 111 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Release")}
	},
	[ACT_VM_FIDGET_EMPTY] = {
		{time = 1 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Look")},
		{time = 52 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Look")},
		{time = 103 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Pull")},
		{time = 111 / 30, type = "sound", value = Sound("TFA_CUSTOM_DEAGLE.Release")}
	}
}
--[[ATTACHMENTS]]--

SWEP.ViewModelBoneMods = {
}

SWEP.VElements = {

}

SWEP.WElements = nil
SWEP.Attachments = {
	[1] = {atts = {"custom_deagle_extbarrel", "custom_deagle_rail"}},
	[2] = {atts = {"custom_deagle_50ae"}}
}

SWEP.MuzzleAttachmentSilenced = 3

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}

function SWEP:Think() 
	if CLIENT then return end
	if not self.CantUseClip then
		if self:Clip1() == 0 then
			self:SetClip1(self.Primary.ClipSize)
		end
		self.CantUseClip = true
	end
	if self:Clip1() <= 0 then
		local ow = self.Owner
		if IsValid(ow) then
			local wep = ""
			if IsValid(ow:GetPreviousWeapon()) then
				wep = ow:GetPreviousWeapon():GetClass()
			end

			local w = ents.Create("prop_physics")
			w:SetModel("models/weapons/w_pist_deagle.mdl")
			w:SetPos(ow:EyePos()+ow:GetRight()*4+ow:GetForward()*8-ow:GetUp()*4)
			w:SetAngles(ow:EyeAngles())
			w:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			w:Spawn()
			w:PhysicsInit(SOLID_VPHYSICS)
			local p = w:GetPhysicsObject()
			if IsValid(p) then
				p:EnableMotion(true)
				p:SetVelocity(ow:GetForward()*256)
				p:SetAngleVelocity(VectorRand(-512,512))
			end
			SafeRemoveEntityDelayed(w, 15)

			self:Remove()
			timer.Simple(0, function()
				ow:SetUsingSpecialWeapon(false)
				ow:SelectWeapon(wep)
			end)
		end
	else
		local ow = self.Owner
		if IsValid(ow) then
			ow:SetAmmo(0, "StriderMinigun")
		end
	end
end

DEFINE_BASECLASS(SWEP.Base)