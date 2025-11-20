local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_melee_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Advanced Warfare"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Cut Wonder Weapon from Advanced Warfare."
SWEP.Author = "FlamingFox, Charlotte"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Energy Sword | AW" or "Energy Sword"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_aw/sword/c_sword.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_aw/sword/w_sword.mdl"
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
		Up = 90,
		Right = 180,
		Forward = 0
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_AW_SWORD.Swing"
SWEP.Primary.Ammo = ""
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = nzombies and 2500 or 250
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Delay = 0.35
SWEP.Primary.DamageType = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE)

SWEP.Primary.MaxCombo = -1
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-60,0,-60), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 2500 or 250,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(2,4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
	{
		["act"] = ACT_VM_SECONDARYATTACK,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(72,20,-40), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 2500 or 250,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(2,-4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
	{
		["act"] = ACT_VM_HITCENTER,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-72,20,20), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 2500 or 250,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(-2,4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
}

SWEP.MuzzleFlashEffect = ""
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true
SWEP.Delay = 0.1

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Misc]--
SWEP.InspectPos = Vector(0, 0, 4)
SWEP.InspectAng = Vector(0, 15, 45)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-12, 0, -1)
SWEP.SafetyAng = Vector(0, -20, -45)
SWEP.SmokeParticle = ""
SWEP.AllowSprintAttack = false
SWEP.Secondary.CanBash = false

--[NZombies]--
SWEP.NZWonderWeapon = true
SWEP.NZHudIcon = Material("vgui/icon/Atlas_Sword_Front_AW.png", "unlitgeneric smooth")
SWEP.NZPaPName = "Energy Sword MK2"
SWEP.Ispackapunched = false

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:SetClip1(100)
end


function SWEP:OnPaP()
self.Ispackapunched = true

self.Primary_TFA.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-60,0,-60), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 5000 or 500,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(2,4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
	{
		["act"] = ACT_VM_SECONDARYATTACK,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(72,20,-40), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 5000 or 500,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(2,-4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
	{
		["act"] = ACT_VM_HITCENTER,
		["len"] = 72,
		["src"] = Vector(0,0,0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-72,20,20), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = nzombies and 5000 or 500,
		["dmgtype"] = nzombies and DMG_DISSOLVE or bit.bor(DMG_SLASH, DMG_DISSOLVE),
		["delay"] = 0.07,
		["snd"] = "TFA_AW_SWORD.Swing",
		["viewpunch"] = Angle(-2,4,0),
		["hitflesh"] = "TFA_AW_SWORD.HitFlesh",
		["hitworld"] = "TFA_AW_SWORD.Hit",
		["end"] = 0.52,
		["hull"] = 10,
		["maxhits"] = 666,
	},
}

if CLIENT then
	if self.CL_FPChargeFX and IsValid(self.CL_FPChargeFX) then
		self.CL_FPChargeFX:StopEmissionAndDestroyImmediately()
		self.CL_FPChargeFX = nil
	end
	if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
		self.CL_FPDrawFX:StopEmission()
		self.CL_FPDrawFX = nil
	end
	if self.CL_3PDrawFX2 and self.CL_3PDrawFX2:IsValid() then
		self.CL_3PDrawFX2:StopEmissionAndDestroyImmediately()
	end
	if self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
		self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
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
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_SWORD.Draw") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_THROW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_AW_SWORD.Swing") },
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

SWEP.Attachments = {
	[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.DTapActivities = {
	[ACT_VM_PRIMARYATTACK] = true,
	[ACT_VM_SECONDARYATTACK] = true,
	[ACT_VM_HITCENTER] = true,
}

SWEP.WW3P_FX = "aw_sword_3p"
SWEP.WW3P_FXPaP = "aw_sword_3p_2"
SWEP.WW3P_ATT = 2

--[Coding]--

DEFINE_BASECLASS( SWEP.Base )

local angle_fix = Angle(90,0,0)
local pvp_bool = GetConVar("sbox_playershurtplayers")
local l_CT = CurTime
local _sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Bool", "GlowHack")
	self:NetworkVarTFA("Bool", "Charging")

	if SERVER then
		self:SetClip1(100)
		self:SetGlowHack(true)
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetClip1(100)
		end)
	end
end

function SWEP:Equip(...)
	if SERVER then
		local ourtimer = "aw_sword_charge"..self:EntIndex()
		if timer.Exists(ourtimer) then timer.Remove(ourtimer) end
		timer.Create(ourtimer, 0.1, 0, function()
			if not IsValid(self) then return end
			if self:GetCharging() then return end

			if self:Clip1() < 100 then
				self:SetClip1(math.Clamp(self:Clip1() + 1, 0, 100))

				local ply = self:GetOwner()
				if self:Clip1() == 100 and not IsValid(ply) and !self:GetGlowHack() then
					// backup if we dont have an owner to run Think2 (called from player Move hooks)
					self:SetGlowHack(true)
					ParticleEffectAttach(self.Ispackapunched and "aw_sword_start_3p_2" or "aw_sword_start_3p", PATTACH_POINT_FOLLOW, self, 2)
				end
			else
				return
			end
		end)

		// somehow fell out of sync without an owner
		if self:Clip1() < 100 and self:GetGlowHack() then
			self:SetGlowHack(false)
		end
	end

	return BaseClass.Equip(self, ...)
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)
	else
		self.Skin = 0
		self:SetSkin(0)
	end

	if self:GetGlowHack() then
		if self:GetCharging() then
			if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
				self.CL_FPDrawFX:StopEmissionAndDestroyImmediately()
				self.CL_FPDrawFX = nil
			end

			if (!self.CL_FPChargeFX or !self.CL_FPChargeFX:IsValid()) and not TFA.Enum.HolsterStatus[self:GetStatus()] then
				self.CL_FPChargeFX = CreateParticleSystem(vm, (self.Ispackapunched and "aw_sword_vm_charged_2" or "aw_sword_vm_charged"), PATTACH_POINT_FOLLOW, 2)
			end
		else
			if self.CL_FPChargeFX and IsValid(self.CL_FPChargeFX) then
				self.CL_FPChargeFX:StopEmissionAndDestroyImmediately()
				self.CL_FPChargeFX = nil
			end

			if (!self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid()) and not TFA.Enum.HolsterStatus[self:GetStatus()] then
				self.CL_FPDrawFX = CreateParticleSystem(vm, (self.Ispackapunched and "aw_sword_vm_2" or "aw_sword_vm"), PATTACH_POINT_FOLLOW, 2)
			end
		end
	else
		if self.CL_FPChargeFX and IsValid(self.CL_FPChargeFX) then
			self.CL_FPChargeFX:StopEmissionAndDestroyImmediately()
			self.CL_FPChargeFX = nil
		end
		if self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
			self.CL_FPDrawFX:StopEmission()
			self.CL_FPDrawFX = nil
		end
	end
end

function SWEP:CanSecondaryAttack()
	local stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if l_CT() < self:GetNextPrimaryFire() then
		return false
	end

	if self:Clip1() < 100 then
		return false
	end

	if self:GetOwner():IsPlayer() and not self:VMIV() then
		return false
	end

	if self:GetCharging() then
		return false
	end

	return true
end

function SWEP:SecondaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not self:CanSecondaryAttack() then return end

	self:SendViewModelAnim(ACT_VM_PULLPIN)
	self:ScheduleStatus(TFA.Enum.STATUS_SWORD_SLAM_IN, (40/30) / self:GetAnimationRate())
	self:SetNextPrimaryFire(CurTime() + self:GetActivityLength())
	self:SetCharging(true)

	if IsFirstTimePredicted() then
		self:EmitSound("TFA_AW_SWORD.Charge")
	end
end

function SWEP:PostPrimaryAttack()
	if self:VMIV() and IsFirstTimePredicted() and self:Clip1() >= 100 then
		ParticleEffectAttach(self.Ispackapunched and "aw_sword_trail_2" or "aw_sword_trail", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
	end

	if CLIENT then return end
	if self:Clip1() < 100 then return end

	local ply = self:GetOwner()

	local fx = EffectData()
	fx:SetEntity(self)
	fx:SetAttachment(2)
	fx:SetFlags(self.Ispackapunched and 2 or 1)

	local filter = RecipientFilter()
	filter:AddPVS(ply:GetShootPos())
	if self:IsFirstPerson() then
		filter:RemovePlayer(ply)
	else
		filter:AddPlayer(ply)
	end

	util.Effect("tfa_aw_sword_3p", fx, nil, filter)
end

function SWEP:CreateGlowSprite( dietime )
	dietime = ( dietime ~= nil ) and ( dietime ) or ( 1 )

	local sprite = ents.Create( "env_sprite" )

	if !sprite:IsValid() then return false end

	sprite:SetKeyValue( "spawnflags", 1 ) // start on
	sprite:SetKeyValue( "model", "sprites/light_glow02_noz.vmt" )

	sprite:SetKeyValue( "rendermode", 3 ) // glow
	sprite:SetKeyValue( "renderfx", 14 ) // constant glow
	sprite:SetKeyValue( "rendercolor", self.Ispackapunched and "255 100 0" or "30 170 255" )
	sprite:SetKeyValue( "renderamt", 200 )
	sprite:SetKeyValue( "scale", 0.1 )

	sprite:Spawn()

	SafeRemoveEntityDelayed( sprite, dietime + 1 )

	// Fade the sprite in the next X seconds
	local SpriteFadeTime = CurTime() + ( dietime + 1 )
	local SpriteFade = "aw_sword_sprite" .. sprite:EntIndex()

	timer.Simple( dietime, function() //-- Yeah,
		timer.Create( SpriteFade, 0, 0, function() //-- I fucking hate my self
			if not IsValid( sprite ) then timer.Remove( SpriteFade ) return end

			local deltaTime = SpriteFadeTime - CurTime()
			if deltaTime > 0 then
				sprite:SetKeyValue( "renderamt", 200 * deltaTime )
			else
				sprite:Remove()
				timer.Remove( SpriteFade )
			end
		end )
	end )

	return sprite
end

function SWEP:SmackEffect(trace, dmginfo)
	local vSrc = trace.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(trace.HitPos), MASK_WATER) == 0

	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = trace.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = trace.HitPos,
		mask = MASK_WATER
	})

	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)

		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1) --FX_WATER_IN_SLIME
		end

		util.Effect("watersplash", data)
	end

	local dam, force, dt = dmginfo:GetBaseDamage(), dmginfo:GetDamageForce(), dmginfo:GetDamageType()

	if (trace.Hit and bFirstTimePredicted and (not trSplash) and self:DoImpactEffect(trace, dt) ~= true) then
		local data = EffectData()
		data:SetOrigin(trace.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(trace.SurfaceProps)
		data:SetDamageType(dt)
		data:SetHitBox(trace.HitBox)
		data:SetEntity(trace.Entity)

		util.Effect("Impact", data)

		if self:Clip1() >= 100 and trace.HitWorld then
			local sprite = self:CreateGlowSprite( 0 )
			if sprite then
				sprite:SetPos( trace.HitPos )
			end
		end
	end

	if trace.Hit and not trSplash and self:Clip1() >= 100 then
		if _sp then
			if IsFirstTimePredicted() then
				ParticleEffect(self.Ispackapunched and "aw_sword_hit_2" or "aw_sword_hit", trace.HitPos, trace.HitNormal:Angle() + angle_fix, trace.Entity)
				sound.Play("weapons/tfa_aw/cel3/wpn_cauterizer_zap_0"..math.random(5)..".wav", trace.HitPos + trace.HitNormal, SNDLVL_IDLE, math.random(97,103), 0.25)
			end
		else
			ParticleEffect(self.Ispackapunched and "aw_sword_hit_2" or "aw_sword_hit", trace.HitPos, trace.HitNormal:Angle() + angle_fix, trace.Entity)
			sound.Play("weapons/tfa_aw/cel3/wpn_cauterizer_zap_0"..math.random(5)..".wav", trace.HitPos + trace.HitNormal, SNDLVL_IDLE, math.random(97,103), 0.25)
		end
	end

	dmginfo:SetDamage(dam)
	dmginfo:SetDamageForce(force)
end

function SWEP:ApplyDamage(trace, dmginfo, ...)
	if self:Clip1() < 100 then
		dmginfo:SetDamageType(nzombies and DMG_GENERIC or DMG_SLASH)
		dmginfo:ScaleDamage(0.5)
	elseif trace.HitGroup == HITGROUP_HEAD then
		dmginfo:ScaleDamage(2)
	end

	BaseClass.ApplyDamage(self, trace, dmginfo, ...)
end

function SWEP:StartThrow()
	self:SendViewModelAnim(ACT_VM_THROW)
	self:ScheduleStatus(TFA.Enum.STATUS_SWORD_SLAM_OUT, (25/30) / self:GetAnimationRate())
	self:SetNextPrimaryFire(CurTime() + self:GetActivityLength())

	local ply = self:GetOwner()

	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(2)
		fx:SetFlags(self.Ispackapunched and 2 or 1)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if self:IsFirstPerson() then
			filter:RemovePlayer(ply)
		else
			filter:AddPlayer(ply)
		end

		util.Effect("tfa_aw_sword_3p", fx, nil, filter)
	end

	ply:SetAnimation(PLAYER_ATTACK1)
end

local function TraceHitFlesh(b)
	return b.MatType == MAT_FLESH or b.MatType == MAT_ALIENFLESH or (IsValid(b.Entity) and b.Entity.IsNPC and (b.Entity:IsNPC() or b.Entity:IsPlayer() or b.Entity:IsRagdoll()))
end

function SWEP:ThrowDown()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsPlayer() then
		ply:LagCompensation(true)
	end

	local ftrace = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector()*52, {self, ply})
	local dtrace = util.QuickTrace(ftrace.HitPos, vector_up*-(ply:GetViewOffset():Length() + 8), {self, ply})

	if ply:IsPlayer() then
		ply:LagCompensation(false)
	end

	self:StopSound("TFA_AW_SWORD.Charge")

	local finalTrace = ftrace.Hit and ftrace or dtrace
	if finalTrace.Hit then
		local finalpos = finalTrace.HitPos
		local finaldir = finalTrace.HitNormal
		local hitFlesh = TraceHitFlesh(finalTrace)

		if IsFirstTimePredicted() then
			ParticleEffect("ghosts_nx1_impact", finalpos, -finaldir:Angle())

			if _sp or (!_sp and SERVER) then
				sound.Play("weapons/tfa_aw/vulcan/vulcan_shot_snap.wav", finalpos, SNDLVL_TALKING, math.random(97,103), 1)
				sound.Play("weapons/tfa_aw/vulcan/vulcan_shot_tail_npc.wav", finalpos + vector_up, SNDLVL_TALKING, math.random(97,103), 1)
			end

			if hitFlesh then
				self:EmitSound("TFA_AW_SWORD.HitFlesh")
			else
				self:EmitSound("TFA_AW_SWORD.Hit")
			end
		end

		if SERVER then
			for k, v in pairs(ents.FindInSphere(finalpos, 200)) do
				if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) or v:IsVehicle() then
					if v == ply then continue end
					if v:Health() <= 0 then continue end
					if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
					if !ply:VisibleVec(v:GetPos()) then continue end
					if nzombies and IsValid(v:GetOwner()) and v:GetOwner():IsPlayer() then continue end

					self:InflictDamage(v)
				end
			end
 
			util.ScreenShake(finalpos, 10, 5, 1.2, 300)

			util.Decal("Scorch", finalpos + finaldir, finalpos - finaldir)

			self:SetGlowHack(false)
			self:SetClip1(0)
		end
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) > 0 then
			ply:SetAmmo(0, self:GetPrimaryAmmoType())
		end
	end

	if status == TFA.Enum.STATUS_SWORD_SLAM_IN and statusend then
		self:StartThrow()
	end

	if status == TFA.Enum.STATUS_SWORD_SLAM_OUT then
		if self:GetStatusProgress() > ((5/30) / self:GetAnimationRate()) and !self.bHasSlammed then
			self:ThrowDown()
			self:SetCharging(false)

			self.bHasSlammed = true
		end
		if statusend and self.bHasSlammed then
			self.bHasSlammed = false
		end
	elseif self.bHasSlammed then
		//fallback if interupted before animation finishes
		if self:GetCharging() then
			self:SetCharging(false)
		end
		self.bHasSlammed = false
	end

	if SERVER then
		if self:Clip1() >= 100 and !self:GetGlowHack() then
			self:SetGlowHack(true)

			if (_sp and !self:IsFirstPerson()) or !_sp then
				ParticleEffectAttach(self.Ispackapunched and "aw_sword_start_3p_2" or "aw_sword_start_3p", PATTACH_POINT_FOLLOW, self, 2)
			end

			if _sp then
				if self:VMIV() and self:IsFirstPerson() then
					ParticleEffectAttach(self.Ispackapunched and "aw_sword_start_2" or "aw_sword_start", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
				end
			else
				self:CallOnClient("StartGlowClient")
			end
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:StartGlowClient()
	if SERVER then return end
	if self:VMIV() and self:IsFirstPerson() then
		ParticleEffectAttach(self.Ispackapunched and "aw_sword_start_2" or "aw_sword_start", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
	end
end

function SWEP:InflictDamage(ent)
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self

	local damage = DamageInfo()
	damage:SetDamage(self.Primary_TFA.Damage)
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamageForce((ent:GetPos() - ply:GetPos())*6000 + vector_up*math.random(18000,22000))
	damage:SetDamagePosition(ent:WorldSpaceCenter() + (ent:OBBCenter()*math.Rand(-0.25,0.25)))
	damage:SetDamageType(DMG_DISSOLVE)

	if ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent:TakeDamageInfo(damage)
end

local tpfx_cvar = GetConVar("cl_tfa_fx_wonderweapon_3p")
function SWEP:DrawWorldModel(...)
	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)
	else
		self.Skin = 0
		self:SetSkin(0)
	end

	if tpfx_cvar:GetBool() and not TFA.Enum.HolsterStatus[self:GetStatus()] and (!self:IsCarriedByLocalPlayer() or !self:IsFirstPerson()) and self:GetGlowHack() then
		if self:GetCharging() then
			if self.CL_3PDrawFX and IsValid(self.CL_3PDrawFX) then
				self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
				self.CL_3PDrawFX = nil
			end

			if (!self.CL_3PDrawFX2 or !self.CL_3PDrawFX2:IsValid()) then
				self.CL_3PDrawFX2 = CreateParticleSystem(self, self.Ispackapunched and "aw_sword_3p_charged_2" or "aw_sword_3p_charged", PATTACH_POINT_FOLLOW, tonumber(self.WW3P_ATT))
			end
		else
			if self.CL_3PDrawFX2 and IsValid(self.CL_3PDrawFX2) then
				self.CL_3PDrawFX2:StopEmissionAndDestroyImmediately()
				self.CL_3PDrawFX2 = nil
			end

			if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
				self.CL_3PDrawFX = CreateParticleSystem(self, self.Ispackapunched and tostring(self.WW3P_FXPaP) or tostring(self.WW3P_FX), PATTACH_POINT_FOLLOW, tonumber(self.WW3P_ATT))
			end
		end
	else
		if self.CL_3PDrawFX2 and self.CL_3PDrawFX2:IsValid() then
			self.CL_3PDrawFX2:StopEmissionAndDestroyImmediately()
		end
		if self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
		end
	end

	local ply = self:GetOwner()
	if DynamicLight and (!IsValid(ply) or (ply:IsPlayer() and !self:IsFirstPerson())) and self:GetGlowHack() then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

		if self.DLight then
			local attpos = self:GetAttachment(2)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 40
			self.DLight.g = 200
			self.DLight.b = 255
			self.DLight.decay = 2500
			self.DLight.brightness = 1
			self.DLight.size = 72
			self.DLight.dietime = CurTime() + 0.5
		end
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:OnDrop(...)
	self:CleanParticles()
	self:SetCharging(false)
	self:StopSound("TFA_AW_SWORD.Charge")

	return BaseClass.OnDrop(self, ...)
end

function SWEP:OwnerChanged(...)
	self:CleanParticles()
	self:SetCharging(false)
	self:StopSound("TFA_AW_SWORD.Charge")

	return BaseClass.OwnerChanged(self, ...)
end

function SWEP:Holster(...)
	self:CleanParticles()
	self:SetCharging(false)
	self:StopSound("TFA_AW_SWORD.Charge")

	return BaseClass.Holster(self, ...)
end

function SWEP:OnRemove( ... )
	if self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
		self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
	end
	if self.CL_3PDrawFX2 and self.CL_3PDrawFX2:IsValid() then
		self.CL_3PDrawFX2:StopEmissionAndDestroyImmediately()
	end

	return BaseClass.OnRemove(self, ...)
end

local crosshair_flamethrower = Material("vgui/overlay/hud_flamethrower_reticle.png", "smooth unlitgeneric")
local CMIX_MULT = 1
local c1t = {}
local c2t = {}

local function ColorMix(c1, c2, fac, t)
	c1 = c1 or color_white
	c2 = c2 or color_white
	c1t.r = c1.r
	c1t.g = c1.g
	c1t.b = c1.b
	c1t.a = c1.a
	c2t.r = c2.r
	c2t.g = c2.g
	c2t.b = c2.b
	c2t.a = c2.a

	for k, v in pairs(c1t) do
		if t == CMIX_MULT then
			c1t[k] = Lerp(fac, v, (c1t[k] / 255 * c2t[k] / 255) * 255)
		else
			c1t[k] = Lerp(fac, v, c2t[k])
		end
	end

	return Color(c1t.r, c1t.g, c1t.b, c1t.a)
end

local crosshair_cvar = GetConVar("cl_tfa_bo3ww_crosshair")
local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)
local emptycol = Color(255, 0, 0, 255)

// i love writing awful code
local flashcol = Color(30, 200, 255, 255)
local chargeflash = false
local chargefade = 0

function SWEP:DrawHUDBackground()
	if not crosshair_cvar:GetBool() then return end
	local self2 = self:GetTable()
	local x, y
	
	local ply = LocalPlayer()
	if not ply:IsValid() or self:GetOwner() ~= ply then return false end

	if not ply.interpposx then
		ply.interpposx = ScrW() / 2
	end

	if not ply.interpposy then
		ply.interpposy = ScrH() / 2
	end

	local tr = {}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 0x7FFF
	tr.filter = ply
	tr.mask = MASK_NPCSOLID
	local traceres = util.TraceLine(tr)
	local targent = traceres.Entity

	if self:GetOwner():ShouldDrawLocalPlayer() and not ply:GetNW2Bool("ThirtOTS", false) then
		local coords = traceres.HitPos:ToScreen()
		coords.x = math.Clamp(coords.x, 0, ScrW())
		coords.y = math.Clamp(coords.y, 0, ScrH())
		ply.interpposx = math.Approach(ply.interpposx, coords.x, (ply.interpposx - coords.x) * RealFrameTime() * 7.5)
		ply.interpposy = math.Approach(ply.interpposy, coords.y, (ply.interpposy - coords.y) * RealFrameTime() * 7.5)
		x, y = ply.interpposx, ply.interpposy
		-- Center of screen
	elseif sv_tfa_fixed_crosshair:GetBool() then
		x, y = ScrW() / 2, ScrH() / 2
	else
		tr.endpos = tr.start + self:GetAimAngle():Forward() * 0x7FFF
		local pos = util.TraceLine(tr).HitPos:ToScreen()
		x, y = pos.x, pos.y
	end

	local stat = self2.GetStatus(self)
	self2.clrelp = self2.clrelp or 0
	self2.clrelp = math.Approach(
		self2.clrelp,
		TFA.Enum.ReloadStatus[stat] and 0 or 1,
		((TFA.Enum.ReloadStatus[stat] and 0 or 1) - self2.clrelp) * RealFrameTime() * 7)

	local crossa = 255 * math.pow(math.min(1 - (((self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) and
		not self2.GetStatL(self, "DrawCrosshairIronSights")) and (self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) or 0),
		1 - self:GetSprintProgress(),
		1 - self:GetInspectingProgress(),
		self2.clrelp),
	2)

	local rechargeratio = 1 - math.Clamp(self:Clip1() / 100, 0, 1)
	local charged = self:Clip1() >= 100

	teamcol = self2.GetTeamColor(self, targent)
	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa

	// :DDDDDDDD i wish i knew how to code
	if !charged then
		if !chargeflash then
			chargeflash = true
		end

		crosscol = crosscol:Lerp(emptycol, rechargeratio)
	elseif chargeflash then
		chargeflash = false
		chargefade = 1
	end

	if chargefade > 0 then
		crosscol = crosscol:Lerp(flashcol, chargefade)

		chargefade = math.max(chargefade - FrameTime()*2, 0)
	end

	local mult = 1
	if chargefade > 0 then
		mult = mult + (chargefade*0.25)
	end

	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_flamethrower)

	local halfsize = ScreenScale(8)*mult
	local size = ScreenScale(16)*mult

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - halfsize, y  - halfsize, size, size)
	else
		surface.DrawTexturedRect(ScrW() / 2 - halfsize, ScrH() / 2 - halfsize, size, size)
	end
end
