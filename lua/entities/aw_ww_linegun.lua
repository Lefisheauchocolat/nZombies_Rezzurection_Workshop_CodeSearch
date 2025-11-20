AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Line Gun Laser"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

--[Parameters]--
ENT.DefaultModel = Model("models/weapons/w_eq_fraggrenade.mdl")

ENT.Damage = 100
ENT.Delay = 10
ENT.Range = 128
ENT.Impacted = false
ENT.m_HitEnemies = {}
ENT.n_ZedsHit = 0

local nZombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

local util_TraceLine = util.TraceLine
local table_Copy = table.Copy
local table_Merge = table.Merge
local table_insert = table.insert
local util_Effect = util.Effect

local MASK_SHOT = MASK_SHOT

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded" )
	self:NetworkVar( "Vector", 0, "HitPos" )
end

function ENT:PhysicsCollide( data, physObject )
	if self.Impacted then return end
	self.Impacted = true

	self:StopSound( "TFA_AW_LIMBO.Loop.Hi" )
	self:StopSound( "TFA_AW_LIMBO.Loop.Lo" )

	self:StopParticles()

	local fx = EffectData();
	fx:SetOrigin( data.HitPos )
	fx:SetNormal( -data.HitNormal )
	fx:SetScale( 2 )
	fx:SetMagnitude( 2 )

	util_Effect( "ElectricSpark", fx )

	self:SetHitPos( data.HitPos )

	if IsValid( physObject ) then
		physObject:EnableMotion( false )
		physObject:Sleep()
	end

	sound.Play( "weapons/tfa_aw/linegun/wpn_linegun_spark_0"..math.random(3)..".wav", data.HitPos, SNDLVL_TALKING, math.random(97,103), 1 )
	sound.Play( "weapons/tfa_aw/linegun/wpn_linegun_exp_0"..math.random(3)..".wav", data.HitPos, SNDLVL_TALKING, math.random(97,103), 1 )
	sound.Play( "weapons/tfa_aw/linegun/wpn_linegun_chirp_"..math.random(11)..".wav", data.HitPos, SNDLVL_TALKING, math.random(97,103), 0.5 )

	self:Remove()
end

function ENT:Initialize()
	local model = self:GetModel();
	if not model or model == "" or model == "models/error.mdl" then
		self:SetModel( self.DefaultModel )
	end

	self:DrawShadow( true )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self:UseTriggerBounds( true )
	self:SetAutomaticFrameAdvance( true )

	local physObject = self:GetPhysicsObject();
	if IsValid( physObject ) then
		physObject:EnableDrag( false )
		physObject:EnableGravity( false )
		physObject:SetBuoyancyRatio( 0 )
	end

	ParticleEffectAttach( self:GetUpgraded() and "aw_limbo_trail_2" or "aw_limbo_trail", PATTACH_POINT_FOLLOW, self, 4 )

	self:EmitSound( "TFA_AW_LIMBO.Loop.Hi" )
	self:EmitSound( "TFA_AW_LIMBO.Loop.Lo" )

	self.killtime = CurTime() + self.Delay

	self:NextThink( CurTime() )

	self:SetSkin( self:GetUpgraded() and 1 or 0 )

	if CLIENT then return end

	self.Damage = self.mydamage or self.Damage

	local playerEntity = self:GetOwner();
	if not self.Inflictor and IsValid( playerEntity ) and IsValid( playerEntity:GetActiveWeapon() ) then
		self.Inflictor = playerEntity:GetActiveWeapon()
	end

	self:SetTrigger( true )
end

function ENT:Think()
	if CLIENT then
		if dlight_cvar:GetBool() and DynamicLight then
			local dlight = DynamicLight( self:EntIndex() );
			if ( dlight ) then
				dlight.pos = self:GetPos()
				dlight.r = self:GetUpgraded() and 45 or 255
				dlight.g = self:GetUpgraded() and 255 or 25
				dlight.b = 0
				dlight.brightness = 1
				dlight.Decay = 4000
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		end
	end

	if SERVER then
		local physObject = self:GetPhysicsObject();
		if not IsValid( physObject ) then
			self:Remove()
			return false
		end

		local position = self:GetPos();
		local attData = self:GetAttachment(4);
		if attData and attData.Pos then
			position = attData.Pos
		end

		local direction = physObject:GetAngles():Right();

		self:TraceForEnemies(position, direction)

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:TraceForEnemies(position, direction)
	local playerEntity = self:GetOwner();

	local trace1 = {};
	local trace2 = {};

	util_TraceLine( {
		start = position,
		endpos = position - direction*self.Range,
		mask = MASK_SHOT,
		filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
		output = trace1,
	} )

	local hitEntity = trace1.Entity;

	if trace1.Hit and !trace1.HitSky then
		if IsValid( hitEntity ) and hitEntity:IsSolid() then
			local damage = DamageInfo();
			damage:SetDamage( self.Damage )
			damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
			damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
			damage:SetDamageType( nZombies and bit.bor(DMG_BULLET, DMG_PLASMA) or bit.bor(DMG_NEVERGIB, DMG_ENERGYBEAM) )
			damage:SetDamageForce( trace1.Normal*(hitEntity:Health() > 0 and 1250 or 250) )
			damage:SetDamagePosition( trace1.HitPos )
			damage:SetReportedPosition( trace1.StartPos )

			if hitEntity:GetMaxHealth() > 0 and hitEntity:Health() > 0 then
				hitEntity:EmitSound( "weapons/tfa_aw/linegun/wpn_linegun_chirp_"..math.random(11)..".wav", SNDLVL_NORM, math.random(97,103), 0.5, CHAN_STATIC )
			end

			// Achievement
			if !self.m_HitEnemies[ hitEntity:EntIndex() ] then
				self.m_HitEnemies[ hitEntity:EntIndex() ] = true
				self.n_ZedsHit = 1 + self.n_ZedsHit
			end

			hitEntity:DispatchTraceAttack( damage, trace1, trace1.Normal )
		end

		ParticleEffect( "aw_limbo_hit", trace1.HitPos, -trace1.Normal:Angle() )
	end

	util_TraceLine( {
		start = position,
		endpos = position + direction*self.Range,
		mask = MASK_SHOT,
		filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
		output = trace2,
	} )

	local hitEntity = trace2.Entity;

	if trace2.Hit and !trace2.HitSky then
		if IsValid( hitEntity ) and hitEntity:IsSolid() then
			local damage = DamageInfo();
			damage:SetDamage( self.Damage )
			damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
			damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
			damage:SetDamageType( nZombies and bit.bor(DMG_BULLET, DMG_PLASMA) or bit.bor(DMG_NEVERGIB, DMG_ENERGYBEAM) )
			damage:SetDamageForce( trace2.Normal*1000 )
			damage:SetDamagePosition( trace2.HitPos )
			damage:SetReportedPosition( trace2.StartPos )

			if hitEntity:GetMaxHealth() > 0 and hitEntity:Health() > 0 then
				hitEntity:EmitSound( "weapons/tfa_aw/linegun/wpn_linegun_chirp_"..math.random(11)..".wav", SNDLVL_NORM, math.random(97,103), 0.5, CHAN_STATIC )
			end

			// Achievement
			if !self.m_HitEnemies[ hitEntity:EntIndex() ] then
				self.m_HitEnemies[ hitEntity:EntIndex() ] = true
				self.n_ZedsHit = 1 + self.n_ZedsHit
			end

			hitEntity:DispatchTraceAttack( damage, trace2, trace2.Normal )
		end

		ParticleEffect( "aw_limbo_hit", trace2.HitPos, -trace2.Normal:Angle() )
	end

	// Achievement
	if self.n_ZedsHit >= 18 and IsValid( ply ) and ply:IsPlayer() then
		if not ply.awlimboachievement then
			TFA.BO3GiveAchievement( "How Low Can You Go?", "vgui/overlay/achievment/how_low_can_you_go.png", ply )
			ply.awlimboachievement = true
		end
	end
end

function ENT:IsAttractiveTarget( hitEntity )
	local playerEntity = self:GetOwner()

	if hitEntity:GetNoDraw() then
		return false
	end

	if hitEntity:GetClass() == self:GetClass() then
		return false
	end

	if hitEntity == playerEntity then
		return false
	end

	// owner is NPC and hit entity is ally
	if IsValid( playerEntity ) and hitEntity:IsNPC() and playerEntity:IsNPC() and hitEntity:Disposition( playerEntity ) == D_LI then
		return false
	end

	// owner is player and hit player is (potentially) an ally
	if IsValid( playerEntity ) and hitEntity:IsPlayer() and playerEntity:IsPlayer() and !hook.Run( "PlayerShouldTakeDamage", ent, playerEntity ) then
		return false
	end

	if nZombies and hitEntity:IsPlayer() then
		return false
	end

	if nZombies and hitEntity:GetOwner() == playerEntity then
		return false
	end

	if hitEntity:IsPlayer() and not pvp_bool:GetBool() then
		return false
	end

	return true
end

function ENT:OnRemove()
	self:StopSound( "TFA_AW_LIMBO.Loop.Hi" )
	self:StopSound( "TFA_AW_LIMBO.Loop.Lo" )

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight( self:EntIndex() );
		if ( dlight ) then
			dlight.pos = self:GetHitPos()
			dlight.r = self:GetUpgraded() and 45 or 255
			dlight.g = self:GetUpgraded() and 255 or 25
			dlight.b = 0
			dlight.brightness = 2
			dlight.Decay = 4000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
end