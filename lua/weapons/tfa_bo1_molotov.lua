local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Purpose = nzombies and "Ignites area for 10s, 20s when PaP'd" or "Ignites area for 8s, 16s when PaP'd"
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Molotov | BO1" or "Molotov"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo1/molotov/c_molotov.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo1/molotov/w_molotov.mdl"
SWEP.HoldType = "grenade"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 6, 1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
        Right = 2,
        Forward = 3,
        },
        Ang = {
		Up = 0,
        Right = 195,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "nil"
SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 240
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.Damage = nzombies and 50 or 18
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = nzombies and 999 or 1
SWEP.Primary.DefaultClip = nzombies and 999 or 2
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.2

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false

--[Projectiles]--
SWEP.Primary.Round = nzombies and "nz_bo1_tac_molotov" or "bo1_tac_molotov"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo1/molotov/w_molotov.mdl"
SWEP.Velocity = 750
SWEP.Underhanded = false
SWEP.AllowSprintAttack = nzombies and true or false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0
SWEP.Primary.MaxAmmo = 3

--[NZombies]--
SWEP.NZPaPName = "Wraith Fire"
SWEP.Ispackapunched = false
SWEP.NZTacticalPaP = true
SWEP.NZHudIcon = Material("vgui/icon/molotov_tp.png", "unlitgeneric smooth")
SWEP.NZHudIcon_cod5 = Material("vgui/icon/molotov_icon.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/molotov_tp.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/molotov_icon_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/molotov_icon_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/molotov_icon_t7.png", "unlitgeneric smooth")

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

SWEP.Primary.DamagePAP = 32

function SWEP:OnPaP()
self.Ispackapunched = true
self.PrintName = "Wraith Fire"
self.Primary_TFA.Damage = 666
self:ClearStatCache()
return true
end

function SWEP:NZSpecialHolster()
	self:ResetGlow()
	self.nzThrowTime = nil
	self.nzHolsterTime = nil
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self) self.Light1:SetInt("$emissiveblendstrength", 0) end, client = true, server = false},
{ ["time"] = 1 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MOLOTOV.Light") },
{ ["time"] = 20 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MOLOTOV.Ignite") },
{ ["time"] = 20 / 35, ["type"] = "lua", value = function(wep, vm) wep:ResetGlow() wep:MolotovFX(wep:GetOwner()) wep:SetGlow(true) end},
{ ["time"] = 25 / 35, ["type"] = "lua", value = function(self) self.Light1:SetInt("$emissiveblendstrength", 1) end, client = true, server = false},
},
[ACT_VM_THROW] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self) self.Light1:SetInt("$emissiveblendstrength", 0) end, client = true, server = false},
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_GRENADE.Throw") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(wep, vm) wep:CleanParticles() wep:ResetGlow() end},
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MOLOTOV.Throw") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5
SWEP.ProceduralHolsterTime = 0.3

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.Light1 = Material("models/weapons/tfa_bo1/molotov/mtl_weapon_molotov_wick.vmt")

--[Sauce]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Bool", "Glow")
end

function SWEP:Equip(ply, ...)
	if nzombies then
		self:GetOwner():SetAmmo(3, GetNZAmmoID("specialgrenade"))
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:Think2(...)
	if DynamicLight then
		if self:GetGlow() and dlight_cvar:GetBool() then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

			if self.DLight then
				local attpos = (self:IsFirstPerson() and self:GetOwner():GetViewModel() or self):GetAttachment(1)
				local upg = self.Ispackapunched

				self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
				self.DLight.r = upg and 90 or 235
				self.DLight.g = upg and 230 or 75
				self.DLight.b = upg and 255 or 15
				self.DLight.decay = 2000
				self.DLight.brightness = 1.5
				self.DLight.size = 128
				self.DLight.dietime = CurTime() + 0.5
			end
		elseif self.DLight then
			self.DLight.dietime = -1
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:MolotovFX(ply)
	if self:VMIV() then
		ParticleEffectAttach(self:IsFirstPerson() and (self.Ispackapunched and "bo1_molotov_fp_2" or "bo1_molotov_fp") or (self.Ispackapunched and "bo1_molotov_trail_2" or "bo1_molotov_trail"), PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 1)
	end

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)
		fx:SetFlags(self.Ispackapunched and 2 or 1)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if IsValid(ply) then
			filter:RemovePlayer(ply)
		end

		if filter:GetCount() > 0 then
			util.Effect("tfa_bo1_molotov_tp", fx, true, filter)
		end
	end
end

function SWEP:ResetGlow()
	self:StopParticles()
	self:SetGlow(false)

	if self.DLight then
		self.DLight.dietime = -1
	end
end

function SWEP:OnDrop(...)
	self:ResetGlow()
	return BaseClass.OnDrop(self, ...)
end

function SWEP:OwnerChanged(...)
	self:ResetGlow()
	return BaseClass.OwnerChanged(self, ...)
end

function SWEP:Holster(...)
	self:CleanParticles()
	self:ResetGlow()
	return BaseClass.Holster(self, ...)
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:PostSpawnProjectile(ent)
	local angvel = Vector(math.random(-2000,-500),math.random(-500,-2000),math.random(-500,-2000)) //The positive z coordinate emulates the spin from a right-handed overhand throw
	angvel:Rotate(-1*ent:EyeAngles())
	angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))
	
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(angvel)
	end
end