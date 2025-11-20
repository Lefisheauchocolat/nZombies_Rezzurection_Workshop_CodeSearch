local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Half-Life 2 crossbow re-animated, port is credited to JohnDoe. \nFrom the World at War custom map 'The Compound v1.1' by ElTitoPricus"
SWEP.Author = "JohnDoe, Bluntstuffy, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Resistance Crossbow | WAW" or "Resistance Crossbow"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/hl2_crossbow/c_hl2_crossbow.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/hl2_crossbow/w_hl2_crossbow.mdl"
SWEP.HoldType = "crossbow"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4,
        Right = -0.5,
        Forward = 15,
        },
        Ang = {
		Up = -170,
        Right = 180,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "Weapon_Crossbow.Single"
SWEP.Primary.Sound_DryFire = "Weapon_IRifle.Empty"
SWEP.Primary.Sound_Blocked = "Weapon_IRifle.Empty"
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 120
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 5500 or 500
SWEP.Primary.Knockback = 15
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 7
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_waw_muzzleflash_crossbow"
SWEP.MuzzleFlashEnabled = true
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode =  1
SWEP.FireModeName = "Skewer"

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .01
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.8
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0.8
SWEP.Primary.KickDown			= 0.8
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 1

--[Iron Sights]--
SWEP.Scoped = true
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 12
SWEP.IronSightsPos = Vector(-2.78, -6.5, 0.8)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4
SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.5

if CLIENT then
	SWEP.Secondary.ScopeTable = {
		scopetex = surface.GetTextureID("vgui/overlay/hl2mmod_scopes_crossbow"),
	}
end

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "waw_ww_hl2crossbow" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 0 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_waw/hl2_crossbow/hl2_crossbow_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Freeman's Revenger"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 40

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
	self:SetGlowHack( true )
end

SWEP.Ispackapunched = false
SWEP.Primary.DamagePaP = 1000

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.Damage = 8000
self.Primary_TFA.MaxAmmo = 60
self.BoltModes = {
	[1] = "Skewer",
	[2] = "Explosive 2",
	[3] = "Ricochet 2",
}
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 40 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_in_empty",
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_loop_empty",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_out_empty",
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 15 / 30, ["type"] = "lua", value = function(self)
	if self.CL_FPDrawFX and self.CL_FPDrawFX:IsValid() then
		self.CL_FPDrawFX:StopEmissionAndDestroyImmediately()
		self.CL_FPDrawFX = nil
	end
	self:StopSound("ambient/machines/electric_machine.wav")
	self:CleanParticles()
end, client = true, server = true},
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 0, ["type"] = "lua", value = function(self)
	if self:Clip1() <= 0 then
		self.Skin = 0
		self:SetSkin(0)
	end
	self:StopSound("ambient/machines/electric_machine.wav")
end, client = true, server = true},
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("Weapon_Crossbow.Reload") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("Weapon_Crossbow.BoltElectrify") },
{ ["time"] = 40 / 30, ["type"] = "lua", value = function(self)
	self.Skin = 1
	self:SetSkin(1)

	if CLIENT then
		self:CleanParticles()
		if self:VMIV() then
			ParticleEffectAttach("waw_crossbow_attach", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
		end
		if not self:IsFirstPerson() then
			ParticleEffectAttach("waw_crossbow_attach_3p", PATTACH_POINT_FOLLOW, self, 1)
		end
	end

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(self:GetOwner():GetShootPos())
		filter:RemovePlayer(self:GetOwner())

		util.Effect("tfa_waw_crossbow_3p", fx, nil, filter)
	end

	self:SetGlowHack(true)
end, client = true, server = true},
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("Weapon_Crossbow.Reload") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("Weapon_Crossbow.BoltElectrify") },
{ ["time"] = 37 / 30, ["type"] = "lua", value = function(self)
	self.Skin = 1
	self:SetSkin(1)

	if CLIENT then
		self:CleanParticles()
		if self:VMIV() then
			ParticleEffectAttach("waw_crossbow_attach", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
		end
		if not self:IsFirstPerson() then
			ParticleEffectAttach("waw_crossbow_attach_3p", PATTACH_POINT_FOLLOW, self, 1)
		end
	end

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(self:GetOwner():GetShootPos())
		filter:RemovePlayer(self:GetOwner())

		util.Effect("tfa_waw_crossbow_3p", fx, nil, filter)
	end
end, client = true, server = true},
},
}

SWEP.RunSightsPos = Vector(0, -1, -2)
SWEP.RunSightsAng = Vector(0, 0, 0)

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.WElements = {
	["sprite"] = { type = "Sprite", sprite = "sprites/orangeflare1", bone = "tag_flash", rel = "", pos = Vector(-5,0,0), size = {x = 6, y = 6}, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = true },
}

SWEP.BoltModes = {
	[1] = "Skewer",
	[2] = "Explosive",
	[3] = "Ricochet",
}

SWEP.AttachmentTableOverride = {
	["bo3_packapunch"] = {
		["BoltModes"] = {
			[1] = "Skewer",
			[2] = "Explosive 2",
			[3] = "Ricochet 2",
		}
	}
}

SWEP.StatCache_Blacklist = {
	["FireModeName"] = true,
	["WElements"] = true,
}

SWEP.NPCLastSecondaryAttack = 0
SWEP.NPCSecondaryAttackCooldown = 10

util.PrecacheModel("models/weapons/tfa_waw/hl2_crossbow/c_hl2_crossbow.mdl")

DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")
local cvar_skill = GetConVar("skill")

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Bool", "Electrified")
	self:NetworkVarTFA("Bool", "GlowHack")
	self:NetworkVarTFA("Int", "BoltMode")

	self:SetBoltMode(1)
	self:SetElectrified(false)
	self:SetGlowHack(false)
end

function SWEP:AltAttack()
	if self:Clip1() <= 0 then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	if self:GetNextSecondaryFire() > CurTime() then return end

	self:SetElectrified(!self:GetElectrified())
	self:SetNextSecondaryFire(CurTime() + 0.75)

	if IsFirstTimePredicted() then
		self:EmitSound("TFA_BO3_SUNGOD.Foley")

		if self:GetElectrified() then
			self:EmitSound("ambient/machines/electric_machine.wav", SNDLVL_IDLE, 100, 0.5, CHAN_WEAPON)
		else
			self:StopSound("ambient/machines/electric_machine.wav")
		end

		if CLIENT then
			self:AttachVMEffects()
		elseif SERVER and game.SinglePlayer() then
			self:CallOnClient("AttachVMEffects", "")
		end
	end
end

function SWEP:CycleFireMode()
	local ct = CurTime()
	local fm = self:GetBoltMode()
	fm = fm + 1

	if fm > #self.BoltModes then
		fm = 1
	end

	self:SetBoltMode(fm)
	local success, tanim, ttype = self:ChooseROFAnim()

	if success then
		self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
	else
		self:EmitSound("weapons/ar2/ar2_empty.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
		self:SetNextPrimaryFire(ct + math.max(self:GetFireDelay(), 0.25))
	end

	self.BurstCount = 0
	self:SetIsCyclingSafety(false)
	self:SetStatus(TFA.Enum.STATUS_FIREMODE, self:GetNextPrimaryFire())

	self.FireModeName = self.BoltModes[fm]
	self:ClearStatCache("FireModeName")

	self:CallOnClient("UpdateFireModeName", tostring(self.FireModeName))
end

function SWEP:UpdateFireModeName(name)
	self.FireModeName = name
	self:ClearStatCache("FireModeName")

	if self.FireModeName == "Explosive" then
		self.StoredClientDamage = self.Primary_TFA.Damage
		self.Primary.Damage = self.Primary_TFA.Damage*0.5
		self.Primary_TFA.Damage = self.Primary.Damage
		self:ClearStatCache("Primary.Damage")
	elseif self.StoredClientDamage then
		self.Primary.Damage = self.StoredClientDamage
		self.Primary_TFA.Damage = self.StoredClientDamage
		self:ClearStatCache("Primary.Damage")

		self.StoredClientDamage = nil
	end
end

function SWEP:AttachVMEffects()
	if CLIENT then
		if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
			self.CL_FPDrawFX:StopEmissionAndDestroyImmediately()
			self.CL_FPDrawFX = nil
		end

		if !self.CL_FPDrawFX then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, self:GetElectrified() and "waw_crossbow_vm_charged" or "waw_crossbow_vm", PATTACH_POINT_FOLLOW, 1)
		end
	end
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self:GetGlowHack() and self:GetStatus() ~= TFA.Enum.STATUS_HOLSTER then
		if (!self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid()) then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, self:GetElectrified() and "waw_crossbow_vm_charged" or "waw_crossbow_vm", PATTACH_POINT_FOLLOW, 1)
		end
	elseif self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
		self:StopSound("ambient/machines/electric_machine.wav")
		self.CL_FPDrawFX:StopEmission()
		self.CL_FPDrawFX = nil
	end

	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(0, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(4, nil)
	end
end

function SWEP:DrawWorldModel(...)
	BaseClass.DrawWorldModel(self, ...)

	if self:GetGlowHack() then
		local size = math.Rand(5,6)
		self.WElements["sprite"].size = {x = size, y = size}
		self.WElements["sprite"].active = true
	elseif self.WElements["sprite"].active then
		self.WElements["sprite"].active = false
	end

	if !self:IsCarriedByLocalPlayer() and !self.Ispackapunched then
		if self:GetGlowHack() then
			self.Skin = 1
			self:SetSkin(1)
		else
			self.Skin = 0
			self:SetSkin(0)
		end
	end

	local ply = self:GetOwner()
	if DynamicLight and (!IsValid(ply) or !self:IsFirstPerson()) then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if self.DLight and self:GetGlowHack() then
			local attpos = self:GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 128
			self.DLight.b = 0
			self.DLight.decay = 2000
			self.DLight.brightness = 1
			self.DLight.size = 64
			self.DLight.dietime = CurTime() + 1
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end
end

function SWEP:CompleteReload(...)
	BaseClass.CompleteReload(self, ...)

	if self:Clip1() > 0 then
		self:SetGlowHack(true)
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	if ifp and ply:IsPlayer() and nzombies and self:HasNZModifier("pap") then
		nzSounds:PlayEnt("UpgradedShoot", ply)
	end

	self.Skin = 0
	self:SetSkin(0)

	self:SetElectrified(false)
	self:StopSound("ambient/machines/electric_machine.wav")

	if self:Clip1() <= 0 then
		if ifp then
			if self:VMIV() then
				ParticleEffectAttach("waw_crossbow_muzzleflash_aftersmoke", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
			end

			if game.SinglePlayer() then
				if !self:IsFirstPerson() then
					ParticleEffectAttach("waw_crossbow_muzzleflash_aftersmoke_3p", PATTACH_POINT_FOLLOW, self, 1)
				end
			else
				if SERVER then
					ParticleEffectAttach("waw_crossbow_muzzleflash_aftersmoke_3p", PATTACH_POINT_FOLLOW, self, 1)
				end
				if CLIENT and !self:IsFirstPerson() then
					ParticleEffectAttach("waw_crossbow_muzzleflash_aftersmoke_3p", PATTACH_POINT_FOLLOW, self, 1)
				end
			end
		end

		self:SetGlowHack(false)
	end
end

function SWEP:PreSpawnProjectile(ent)
	local ply = self:GetOwner()

	ent:SetUpgraded(self.Ispackapunched)
	ent:SetElectrified(self:GetElectrified())
	ent:SetBoltMode(self:GetBoltMode())

	local skill = cvar_skill:GetInt()
	if IsValid(ply) and ply:IsNPC() and skill > 1 and math.random((skill > 2) and 3 or 6) == 1 and (self.NPCLastSecondaryAttack + self.NPCSecondaryAttackCooldown) < CurTime() then
		ent:SetBoltMode(3) // force npcs to randomly shoot richochette every so often
		self.NPCLastSecondaryAttack = CurTime()
	end
end

function SWEP:OnRemove(...)
	self:StopSound("ambient/machines/electric_machine.wav")
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("ambient/machines/electric_machine.wav")
	self:SetElectrified(false)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("ambient/machines/electric_machine.wav")
	self:StopSoundNet("ambient/machines/electric_machine.wav")
	self:SetElectrified(false)
	return BaseClass.Holster(self,...)
end

function SWEP:DrawScopeOverlay(...)
	BaseClass.DrawScopeOverlay(self, ...)

	local w, h = ScrW(), ScrH()
	if w > h then
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w * .5 - h * .5, h)
		surface.DrawRect(w * .5 + h * .5, 0, w * .5 - h * .5, h)
	end
end