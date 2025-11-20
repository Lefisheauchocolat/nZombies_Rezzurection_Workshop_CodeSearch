local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Purpose = "Model of unknown origin, conceptualized and ported by Quizz. \nFrom the World at War custom map 'TMG Fun Too' by Quizz"
SWEP.Author = "TMG Nukem, Quizz, FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Airburst Nade | WAW" or "Airburst Nade"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/abnade/c_abnade.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_waw/abnade/w_abnade.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1.5,
        Right = 2,
        Forward = 7,
        },
        Ang = {
		Up = 0,
        Right = 0,
        Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 400 or 100
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = nzombies and 999 or 1
SWEP.Primary.DefaultClip = nzombies and 999 or 2
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.1

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Projectiles]--
SWEP.Primary.Round = nzombies and "nz_waw_nade_airburst" or "waw_nade_airburst"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_waw/abnade/projectile_abnade.mdl"
SWEP.Velocity = 750
SWEP.Underhanded = false
SWEP.AllowSprintAttack = nzombies and true or false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZHudIcon = Material("vgui/icon/hud_ab_nade.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/hud_abnade.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t6 = Material("vgui/icon/hud_abnade.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/hud_ab_nade_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/hud_ab_nade_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/hud_ab_nade_bw.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

--[Tables]--
SWEP.SequenceRateOverride = {
}
SWEP.SequenceLengthOverride = {
}

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_ABNADE.Pin") },
},
[ACT_VM_THROW] = {
{ ["time"] = 1 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_UBERNADE.Throw") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5
SWEP.ProceduralHolsterTime = 0.015

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	if nzombies then
		timer.Simple(engine.TickInterval(), function()
			if not IsValid(ply) then return end
			ply:SetAmmo(4, GetNZAmmoID("grenade"))
		end)
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	local ang = self:GetAimVector():Angle()
	ent:SetAngles(Angle(0, ang[2], 0))
end

function SWEP:PostSpawnProjectile(ent)
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(0,0,4000))
	end
end
