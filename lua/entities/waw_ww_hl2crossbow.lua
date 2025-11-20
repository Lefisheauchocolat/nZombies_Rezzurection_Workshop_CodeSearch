
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

//-- Credit to ValsdalV's Improved Crosssbow Bolt (2982704389) for converting valve's C++ code to lua
//-- and the code for how the entity moves (traces instead of VPhysics)

-------------------------------------------------------------------------------
//  Half-Life 2 'crossbow_bolt' entity remake
//
//  Faithful Lua-based recreation of the projectile fired by the Crossbow
//  weapon in Half-Life 2, with additional bonus features.
//  To overcome the limitations of Havok engine (the maximum movement speed
//  allowed for a physics based entity is 3500 Hammer Units per second) this
//  new projectile uses a trace-based approach, with short hitscan steps each
//  server tick.
//
//  * The default crossbow_bolt *
//  Movement speed is 3500 HU/s in the air and 1500 HU/s if fired while being
//  underwater (only the firing position matters); entering the water surface
//  does not slow down the bolt at all as the only way for the projectile to
//  lose speed is by hitting the world's geometry (this will also increase
//  gravity by 20 times the initial value).
//
//  * The improved_crossbowbolt *
//  The starting speed value is customizable via ConVar and is semi-uncapped.
//  As long as the projectile is underwater, a constant speed reduction is
//  applied, until a speed of 7000 HU/s or less is reached. Hitting the world
//  will instantly reduce the velocity by 25% and increase gravity by 10 times.
//
//  ValsdalV
-------------------------------------------------------------------------------

// Credit Source 2013 SDK for the code from the following

// tf_projectile_arrow.cpp -- piercing
// weapon_crossbow.cpp -- most of this
// prop_combine_ball.cpp -- projectile deflection toward enemies

AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Rebar Bolt"
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
ENT.RangePaP = 144

ENT.ArcRange = 128
ENT.ArcRangePaP = 144
ENT.ArcLife = 6
ENT.ArcLifePaP = 8

ENT.ArcCount = 0
ENT.MaxArcs = 10
ENT.MaxArcsPaP = 12

ENT.PierceCount = 0
ENT.MaxPierceCount = nzombies and 8 or 6
ENT.MaxPierceCountPaP = nzombies and 14 or 12

ENT.RicochetCount = 0

ENT.m_HitEntities = {}

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

local CurTime = CurTime
local IsValid = IsValid

local bit_AND = bit.band
local math_Max = math.max
local ents_Create = ents.Create
local ents_FindInBox = ents.FindInBox
local ents_FindInSphere = ents.FindInSphere
local game_GetWorld = game.GetWorld

local util_TraceLine = util.TraceLine
local util_TraceHull = util.TraceHull
local util_PointContents = util.PointContents
local util_ScreenShake = util.ScreenShake
local util_IntersectRayWithOBB = util.IntersectRayWithOBB

local MASK_SHOT = MASK_SHOT
local MAT_GLASS = MAT_GLASS
local CONTENTS_SLIME = CONTENTS_SLIME
local CONTENTS_LIQUID = bit.bor( CONTENTS_WATER, CONTENTS_SLIME )
local COLLISION_GROUP_BREAKABLE_GLASS = COLLISION_GROUP_BREAKABLE_GLASS
local MOVETYPE_NONE = MOVETYPE_NONE

local ParticleEffectAttach = ParticleEffectAttach
local ParticleEffect = ParticleEffect
local WorldToLocal = WorldToLocal
local EffectData = EffectData
local DispatchEffect = util.Effect
local PlaySound = sound.Play

local CLIENT_RAGDOLLS = {
	"class C_ClientRagdoll",
	"class C_HL2MPRagdoll",
}

local function IsRagdollOwner( owner, ragdoll )
   return ragdoll:GetOwner() == owner && ragdoll:GetClass() == "prop_ragdoll" && ragdoll:GetModel() == owner:GetModel()
end

// Source engine constants that are not GMod global variables
local DAMAGE_NO = 0
local DAMAGE_EVENTS_ONLY = 1 // call damage functions, but don't modify health
local LIFE_ALIVE = 0 // alive

// Cached constants
local BOLT_WATER_VELOCITY = 1000 // minimum speed while underwater
local BOLT_WATER_FRICTION = 2000 // speed lost per second while underwater
local BOLT_HULL_MAXS = Vector( 0.3, 0.3, 0.3 )
local BOLT_HULL_MINS = BOLT_HULL_MAXS:GetNegated()
local BOLT_SPRITE_OFFSET = Vector( 0, 0, 0 )
local BOLT_GRAVITY = 2.025
local BOLT_VELOCITY = 6000
local MAX_COORD_FLOAT = 16384.0

// Utility functions
local DoImpactEffect
local DoSparksEffect
local DoRicochetEffect
local DoWaterSplashEffect
local FindHullIntersection
local CreateGlowSprite

if SERVER then
	util.AddNetworkString("WW.Crossbow.Pin")
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Electrified")
	self:NetworkVar("Bool", 1, "Upgraded")
	self:NetworkVar("Bool", 2, "Impacted")
	self:NetworkVar("Int", 0, "BoltMode")
end

function ENT:Draw()
	if self:GetCreationTime() + 0.05 > CurTime() then return end
	self:DrawModel()

	if self:GetElectrified() and (self:IsRicochetBolt() or self:GetImpacted()) then
		if !self.pvsfx or !IsValid(self.pvsfx) then
			self.pvsfx = CreateParticleSystem(self, "waw_crossbow_shock", PATTACH_POINT_FOLLOW, 3)
		end
	elseif self.pvsfx and IsValid(self.pvsfx) then
		self.pvsfx:StopEmission()
	end
end

function ENT:IsTranslucent()
	return true
end

function ENT:IsSkewerBolt()
	return self:GetBoltMode() <= 1
end

function ENT:IsExplosiveBolt()
	return self:GetBoltMode() == 2
end

function ENT:IsRicochetBolt()
	return self:GetBoltMode() == 3
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel(self.DefaultModel)
	end

	self:DrawShadow( true )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE )
	self:SetSolid( SOLID_NONE )
	self:SetSkin( 1 )

	ParticleEffectAttach( "waw_crossbow_trail", PATTACH_POINT_FOLLOW, self, 1 )

	self:EmitSound( "Weapon_Crossbow.BoltFly" )

	if self:GetUpgraded() then
		self.MaxPierceCount = self.MaxPierceCountPaP
		self.Range = self.RangePaP
		self.ArcRange = self.ArcRangePaP
		self.ArcLife = self.ArcLifePaP
		self.MaxArcs = self.MaxArcsPaP
	end

	if CLIENT then return end
	self.killtime = CurTime() + self.Delay

	local ply = self:GetOwner()
	if not self.Inflictor and ply:IsValid() and ply:GetActiveWeapon():IsValid() then
		self.Inflictor = ply:GetActiveWeapon()
	end

	self.Damage = self.mydamage or self.Damage
	self.Speed = BOLT_VELOCITY
	self.Gravity = BOLT_GRAVITY
	self.FrameTime = engine.TickInterval()
	self.Direction = self:GetAngles():Forward()

	// Entity water level
	if bit_AND(util_PointContents(self:GetPos()), CONTENTS_LIQUID) != 0 then
		self.IsUnderwater = true
	else
		self.IsUnderwater = false
	end

	self:NextThink( CurTime() )
end

function ENT:Think()
	if CLIENT then
		if dlight_cvar:GetBool() and DynamicLight then
			local dlight = DynamicLight( self:EntIndex() )

			if (dlight) then
				dlight.pos = self:GetImpacted() and self:GetAttachment(3).Pos or self:GetPos()
				dlight.r = 255
				dlight.g = 120
				dlight.b = 0
				dlight.brightness = self:GetImpacted() and 0.5 or 2
				dlight.Decay = 1000
				dlight.Size = self:GetImpacted() and 64 or 256
				dlight.DieTime = CurTime() + 1
			end
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

		local speed = self.Speed
		local gravity = self.Gravity
		local direction = self.Direction
		local isUnderwater = self.IsUnderwater

		local ricochetMode = self:IsRicochetBolt()
		local deathmatchMode = self:IsExplosiveBolt()
		local upgradedBolt = self:GetUpgraded()
		local shockmineEnabled = self:GetElectrified()

		local curTime = CurTime()

		if self.TimeToStopParticles and self.TimeToStopParticles < curTime then
			self.TimeToStopParticles = math.huge
			self:StopParticles()

			ParticleEffectAttach("waw_crossbow_bolt", PATTACH_POINT_FOLLOW, self, 3)
		end

		direction:Mul( speed )
		direction[ 3 ] = direction[ 3 ] - gravity
		speed = direction:Length()
		direction:Normalize()

		local position = self:GetPos()
		local owner = self:GetOwner()
		local distance = speed * self.FrameTime
		local myfilter = nzombies and table.Copy(player.GetAll()) or {owner, self}

		local trace = {} //-- movement trace
		local trace2 = {} //-- for finding accurate hit position on hull based entities
		local trace3 = {} //-- for pinning serverside ragdolls on ricochet
		local trace4 = {} //-- for water surface trace
		local hitEntity
		local hitCharacter = false
		local hitRagdoll = false
		local isMarked = false //-- for marking if an enemy has already been pierced this move cycle
		local hitDot = 0
		local takeDamage = 0
		local hitsPerFrame = 0 // limit the maximum number of loops per frame

		if !self:GetImpacted() then
			repeat // keep tracing until the max movement distance is reached
				util_TraceHull( {
					start = position,
					endpos = distance * direction + position,
					filter = myfilter,
					mask = MASK_SHOT,
					maxs = BOLT_HULL_MAXS,
					mins = BOLT_HULL_MINS,
					output = trace,
				} )

				// Interactions with water
				if bit_AND( util_PointContents( trace.HitPos ), CONTENTS_LIQUID ) != 0 then
					if isUnderwater then
						// Underwater and slowing down
						if speed > BOLT_WATER_VELOCITY then
							speed = math_Max( speed - ( BOLT_WATER_FRICTION * self.FrameTime ), BOLT_WATER_VELOCITY )
						end
					else
						// On first water entry
						isUnderwater = true

						util_TraceLine({
							start = position,
							endpos = trace.HitPos,
							mask = CONTENTS_LIQUID,
							output = trace4,
						})

						DoWaterSplashEffect( trace4 )
					end
		     	 elseif isUnderwater then
		     	 	// On water exit
					isUnderwater = false

					util_TraceLine({
						start = trace.HitPos,
						endpos = position,
						mask = CONTENTS_LIQUID,
						output = trace4,
					})

					DoWaterSplashEffect( trace4 )
				end

				// Collision
				if trace.Hit then
					if trace.Fraction == 0 then
						// The normal vector is wrongly set to (0, 0, 1) in this case
						trace.Normal:Set( direction )
					end

					if !nzombies and trace.HitSky then
						// Bolt hit the skybox, remove
						position:Set( trace.HitPos )

						self:Remove()
						return
					end

					hitEntity = trace.Entity
					takeDamage = hitEntity:GetInternalVariable( "m_takedamage" )

					//-- Check if entity was hit in a previous iteration
					if self.m_HitEntities[ hitEntity:EntIndex() ] and self.m_HitEntities[ hitEntity:EntIndex() ] >= curTime then
						isMarked = true

						if not table.HasValue( myfilter, hitEntity ) then
							table.insert( myfilter, hitEntity )
						end //-- This sucks but it 'works'
					end

					hitCharacter = hitEntity:IsNPC() || hitEntity:IsPlayer() || hitEntity:IsNextBot()

					if hitCharacter then
						// Since the bolt's collision is hull-based, these kind of entities will
						// report an inaccurate hit position (in midair, where the hulls intersected)
						if FindHullIntersection( hitEntity, trace, trace2 ) then
							trace.HitPos:Set( trace2.HitPos )
							trace.HitBox = trace2.HitBox
							trace.PhysicsBone = trace2.PhysicsBone
							trace.HitGroup = trace2.HitGroup // no longer reported as HIHITGROUP_GENERIC, allows further damage scaling
						else
							trace.UnreliableHitPos = true
						end
					end

					// Deal damage to the entity hit
					if takeDamage != DAMAGE_NO then
						if !isMarked then
							self:InflictDamage( hitEntity, trace.HitPos, trace.HitGroup, trace.Normal*8000, nzombies and DMG_MISSILEDEFENSE or DMG_NEVERGIB )

							if hitCharacter and ricochetMode then
								//-- Limit amount of pierces for ricochet bolts

								self.PierceCount = self.PierceCount + 1
								if self.PierceCount >= self.MaxPierceCount then
									//-- Remove after piercing max amount of enemies

									position:Set( trace.HitPos )

									ParticleEffect( "waw_crossbow_shatter", trace.HitPos, -trace.Normal:Angle() )

									PlaySound( "physics/metal/metal_box_break"..math.random(2)..".wav", trace.HitPos, SNDLVL_TALKING, math.random(97,103), 0.5 )

									self:Remove()
									return
								end
							end
						end

						// Move through breakable glass, with no speed penalty
						if hitEntity:GetCollisionGroup() == COLLISION_GROUP_BREAKABLE_GLASS then
							position:Set( trace.HitPos )
							hitEntity:Input( "Break" )
							break // window is now broken, pass through on the next tick
						end

						if trace.MatType == MAT_GLASS && hitEntity:GetInternalVariable( "m_lifeState" ) != LIFE_ALIVE then
							position:Set( trace.HitPos )
							break // stop moving for this tick, wait for the glass prop to despawn
						end
					end

					// Ricochet or stick to the entity hit
					hitDot = trace.HitNormal:Dot( -direction )
					hitRagdoll = hitEntity:GetClass() == "prop_ragdoll" // Entity:IsRagdoll() can sometimes return true for NPCs (death blow with 'Keep Corpses' off)

					if (takeDamage <= DAMAGE_EVENTS_ONLY or 
						(hitCharacter and ricochetMode)) and 
						(hitDot < 0.5 or ricochetMode) and 
						speed >= 1000 and !hitRagdoll and 
						(!shockmineEnabled or ricochetMode) and 
						(!deathmatchMode or upgradedBolt) then

						// Hit an unbreakable entity at an acute enough angle and with the necessary speed to bounce off of it
						PlaySound( "Weapon_Crossbow.BoltHitWorld", trace.HitPos )

						DoRicochetEffect( trace )

						direction:Add( 2 * hitDot * trace.HitNormal )
						direction:Normalize()

						self.RicochetCount = self.RicochetCount + 1

						if ricochetMode then
							local redirect = self:DeflectTowardEnemy( trace, direction )
							if redirect then
								direction:Set(redirect)

								//debugoverlay.Line( trace.HitPos, trace.HitPos + (redirect * 92), 10, Color(255, 255, 255), true )
							end
						end

						//-- Reduce speed on ricochet (or increase)
						if upgradedBolt and ricochetMode then
							speed = math.min(1.05 * speed, 30000)
						else
							speed = 0.75 * speed
						end

						if ricochetMode then
							//-- Set gravity to default x 10
							gravity = (BOLT_GRAVITY * 10)
						else
							//-- Decrease gravity after each bounce
							gravity = self.Gravity + (BOLT_GRAVITY * 10)
						end

						//-- Explode after each ricochet if upgraded
						if upgradedBolt and deathmatchMode then
							self:Explode( trace.HitPos , self.RicochetCount < 5 )
						end

						//-- Cast potential ragdoll pin
						self:PinClientsideRagdolls( trace )

						//-- Check for serverside ragdoll
						util_TraceLine({
							start = position,
							endpos = trace.HitPos,
							mask = MASK_SOLID,
							filter = {hitEntity},
							output = trace3,
						})

						local traceEntity = trace3.Entity
						if IsValid(traceEntity) and traceEntity:GetClass() == "prop_ragdoll" and (!traceEntity.PinnedCrossbowBolt or traceEntity.PinnedCrossbowBolt ~= self) and IsValid( traceEntity:GetPhysicsObjectNum( trace3.PhysicsBone ) ) and traceEntity:GetPhysicsObjectNum( trace3.PhysicsBone ):IsMotionEnabled() then
							self:PinServersideRagdoll( traceEntity, self, trace3.HitPos, trace3.Normal, trace3.PhysicsBone )
						end
					else
						// Hit an entity dead on //-- pass through it
						if !self.StruckEntity then
							speed = 0.75 * speed
							self.StruckEntity = true
						end //-- Slowdown from the first pierce only

						if !isMarked then
							DoImpactEffect( trace )

							if ( hitCharacter || hitRagdoll ) then
								PlaySound( "Weapon_Crossbow.BoltHitBody", trace.HitPos )
							else
								PlaySound( "Weapon_Crossbow.BoltHitWorld", trace.HitPos )
							end

							if not ricochetMode then
								gravity = self.Gravity + (BOLT_GRAVITY * 10)
							end

							if not deathmatchMode then
								//-- Clientside ragdoll pin
								self:PinClientsideRagdolls( trace )

								//-- Serverside ragdoll pin
								if hitEntity:GetShouldServerRagdoll() then
									local rag = hitEntity.RagdollEntity

									if !IsValid( rag ) then
										// More complex search is needed
										local ent_position = hitEntity:GetPos()
										local hullMins, hullMaxs = hitEntity:GetCollisionBounds()
										hullMins:Add( ent_position )
										hullMaxs:Add( ent_position )

										for _, ent in ipairs( ents_FindInBox( hullMins, hullMaxs ) ) do
											if IsRagdollOwner( hitEntity, ent ) then
												// Found the victim's ragdoll
												rag = ent
												break
											end
										end
						            else
						               // For players and other respawning entities it will be set again when needed
						               hitEntity.RagdollEntity = nil
						            end

									if IsValid( rag ) and hitEntity:GetInternalVariable( "m_lifeState" ) ~= LIFE_ALIVE then
										// A valid ragdoll entity, the corpse was found
										self:PinServersideRagdoll( rag, self, trace.HitPos, trace.Normal, trace.PhysicsBone )
									end
								end
							end
						end

						position:Set( trace.HitPos )

						if deathmatchMode then
							//-- Explosive bolt will instantly destroy it self on direct contact
							local sprite = CreateGlowSprite( 1 )
							if sprite then
								sprite:SetPos( trace.HitPos )
							end

							self:SetImpacted( true )

							self:SetPos( position )
							self:SetAngles( -trace.HitNormal:Angle() )

							self:Explode( trace.HitPos )

							self.NextZapThink = curTime //-- Stop effect from playing

							speed = 0
							break
						elseif hitEntity:GetMaxHealth() > 0 and hitEntity:Health() < 0 then
							//-- Do nothing if we hit something destructible and killed it
						elseif not hitCharacter and not hitRagdoll and (hitEntity:GetCollisionGroup() == 0 or hitEntity:GetCollisionGroup() > 2) then
							//-- Parent if we hit a prop, freeze if we hit the world

							self.TimeToStopParticles = curTime + 0.1

							DoSparksEffect( trace )

							speed = 0

							if not trace.HitWorld and hitEntity:GetInternalVariable( "m_lifeState" ) == LIFE_ALIVE then
								self:SetParentFromTrace( trace )
							else
								self:SetPos( position )

								if shockmineEnabled then
									//-- Stick verticaly aligned to world
									self:SetAngles( -trace.HitNormal:Angle() )

									if deathmatchMode then
										self:Explode( trace.HitPos , true )
									end
								else
									self:SetAngles( direction:Angle() )
								end
							end

							local sprite = CreateGlowSprite( 3 )
							if sprite then
								if ricochetMode then
									sprite:SetPos(trace.HitPos)
								else
									sprite:SetParent(self)
									sprite:SetLocalPos(BOLT_SPRITE_OFFSET)
								end
							end

							if ricochetMode then
								//-- Shatter ricochet bolts when they run out of speed
								ParticleEffect("waw_crossbow_shatter", trace.HitPos, trace.HitNormal:Angle())

								self:SetImpacted( true )

								self:SetPos( position )
								self:SetAngles( -trace.Normal:Angle() )

								PlaySound("physics/metal/metal_box_break"..math.random(2)..".wav", trace.HitPos, SNDLVL_NORM, math.random(97,103), 0.5)

								self:Remove()

								break
							else
								self:SetImpacted( true )

								self.killtime = curTime + (shockmineEnabled and self.ArcLife or 6)

								/*ParticleEffectAttach("waw_crossbow_bolt", PATTACH_POINT_FOLLOW, self, 3)
								if shockmineEnabled then
									ParticleEffectAttach("waw_crossbow_shock", PATTACH_POINT_FOLLOW, self, 3)
								end*/

								break
							end
						end
					end
				end

				position:Set( trace.HitPos )
				distance = distance * ( 1 - trace.Fraction )

				hitsPerFrame = 1 + hitsPerFrame
			until ( distance <= 0 || hitsPerFrame > 3 ) // Stop tracing

			if !self:GetImpacted() then
				self:SetPos( position )
				self:SetAngles( direction:Angle() )
			end

			self.Speed = speed
			self.Gravity = gravity
			self.IsUnderwater = isUnderwater
		end

		if shockmineEnabled and (self:GetImpacted() or ricochetMode) then
			//-- Arc only when impacted or mid flight if ricochet type bolt
			if !self.NextAttack or self.NextAttack < curTime then
				for _, ent in pairs( ents_FindInSphere( self:GetPos(), self.ArcRange ) ) do
					if ent:IsNPC() or ent:IsNextBot() then
						if ent:BO3IsShockStun() then continue end
						if ent:Health() <= 0 then continue end
						if ent.NZBossType then continue end

						local fx = EffectData()
						fx:SetStart(self:GetAttachment(3).Pos)
						fx:SetOrigin(ent:EyePos())
						DispatchEffect( "tfa_waw_crossbow_tether", fx )

						ent:BO3ShockStun(ricochetMode and math.Rand(1,2) or ((self.killtime - CurTime()) + math.Rand(-0.2,0.25)), self:GetOwner(), self.Damage*0.1 )

						self.NextAttack = curTime + (ricochetMode and 0.1 or math.Rand(0.05,0.15))

						self.ArcCount = self.ArcCount + 1
						if self.ArcCount > self.MaxArcs then
							self:SetElectrified(false)
						end
						break
					end
				end
			end

			//-- Misc zapping visuals
			if !self.NextZapThink or self.NextZapThink < curTime then
				local foundBolt = false

				for _, ent in RandomPairs( ents_FindInSphere( self:GetPos(), self.ArcRange*2 ) ) do
					if ent == self then continue end
					if ent:GetClass() ~= self:GetClass() then continue end
					if not ent:VisibleVec(self:GetAttachment(3).Pos) then continue end

					if ent:GetElectrified() and ent:GetImpacted() then
						local fx = EffectData()
						fx:SetStart(self:GetAttachment(3).Pos)
						fx:SetOrigin(ent:GetAttachment(3).Pos)
						DispatchEffect( "tfa_waw_crossbow_tether", fx )

						foundBolt = true
						break
					end
				end

				if !foundBolt then
					local fx = EffectData()
					fx:SetStart(self:GetAttachment(2).Pos)
					fx:SetOrigin(self:GetAttachment(3).Pos)
					DispatchEffect( "tfa_waw_crossbow_tether", fx )
				end

				self.NextZapThink = curTime + math.Rand(0.1,1)
				PlaySound("weapons/physcannon/superphys_small_zap"..math.random(4)..".wav", self:GetPos(), SNDLVL_IDLE, 100, 1)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode( pos, dontremove )
	if not pos then
		pos = self:GetPos()
	end

	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	local hurtTypes = DMG_BLAST
	if self:GetElectrified() then
		hurtTypes = bit.bor(DMG_SHOCK, DMG_DISSOLVE)
	end

	for k, v in pairs( ents_FindInSphere(pos, self.Range) ) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end
			if v:IsNPC() and v:Health() <= 0 then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			local own = v:GetOwner()
			if IsValid(own) and (own == ply or (nzombies and own:IsPlayer())) then continue end
			if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			local hitted = tr1.Entity == v
			self:InflictDamage( v, hitted and tr1.HitPos or tr.endpos, hitted and tr1.HitGroup or nil, v:GetUp()*math.random(2000,9000) + tr1.Normal*math.random(9000,14000), hurtTypes, self.Damage*0.5 )
		end
	end

	util_ScreenShake( pos, 4, 10, 1.4, 256 )

	local effectdata = EffectData()
	effectdata:SetOrigin( pos )
	effectdata:SetNormal( -self:GetAngles():Forward() )

	DispatchEffect( "HelicopterMegaBomb", effectdata )
	DispatchEffect( "Explosion", effectdata )

	PlaySound( "BaseGrenade.Explode", pos )

	if not dontremove then
		ParticleEffect( "waw_crossbow_shatter", pos, -self:GetAngles() )

		self:Remove()
	end
end

function ENT:InflictDamage(ent, hitPos, hitGroup, hitForce, damageType, damageAmount)
	if nzombies and ent:IsPlayer() then return end

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ent:IsNPC() and ent:Disposition(ply) == D_LI then
		self.m_HitEntities[ ent:EntIndex() ] = CurTime()
		return
	end

	local damage = DamageInfo()
	damage:SetDamage(damageAmount or self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or game.GetWorld())
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(hitForce)
	damage:SetDamageType(damageType)
	damage:SetDamagePosition(hitPos or ent:WorldSpaceCenter())

	if (hitGroup and hitGroup == HITGROUP_HEAD) then
		damage:SetDamage(self.Damage*7)
	end

	if ent:IsNPC() and bit.band(ent:GetCurrentSchedule(), SCHED_NPC_FREEZE) ~= 0 then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent.CrossbowAttacker = self
	ent:TakeDamageInfo(damage)
	ent.CrossbowAttacker = nil

	self.m_HitEntities[ ent:EntIndex() ] = CurTime()
end

function ENT:SetParentFromTrace( trace )
	local origin = -8 * trace.Normal // adjust the bolt position
	origin:Add( trace.HitPos )

	local hitEntity = trace.Entity
	local bone = hitEntity:TranslatePhysBoneToBone( trace.PhysicsBone )

	if bone && bone >= 0 then
		// A multi-bone skeleton (a ragdoll, player, NPC...)
		local boneMatrix = hitEntity:GetBoneMatrix( bone )

		if !boneMatrix then
			// Bone ID is out of bounds or the entity has no model (how did it manage to get hit?)
			self:Remove()
			return false
		end

		// Have to manually set local position/angle in this case
		local position, angles = WorldToLocal( origin, trace.Normal:Angle(), boneMatrix:GetTranslation(), boneMatrix:GetAngles() )

		self:FollowBone( hitEntity, bone )
		self:SetLocalPos( position )
		self:SetLocalAngles( angles )

		if hitEntity:IsPlayer() then
			// Save bandwidth, this player will not draw this bolt anyway
			self:SetPreventTransmit( hitEntity, true )
		end
	else
		// A zero- or mono-bone skeleton, most likely a prop
		self:SetPos( origin )
		self:SetAngles( trace.Normal:Angle() )

		self:SetParent( hitEntity )
	end

	self:SetTransmitWithParent( true )

	return true
end

function ENT:IsAttractiveTarget( ent )
	if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
		return false
	end
	if ent:Health() <= 0 then
		return false
	end
	if ent:GetNoDraw() then
		return false
	end
	if ent:IsNPC() and self:GetOwner():IsNPC() and ent:Disposition(self:GetOwner()) == D_LI then
		return false
	end
	if nzombies and ent:IsPlayer() then
		return false
	end
	if ent == self:GetOwner() then
		return false
	end

	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = ent:WorldSpaceCenter(),
		filter = {self, self:GetOwner()},
		mask = MASK_SOLID
	}) 

	if ( tr.Fraction < 1 and tr.Entity ~= ent) then
		return false
	end

	return true
end

function ENT:DeflectTowardEnemy( trace, vecVelDir )
	local bestTarget
	local vecStartPoint = trace.HitPos
	
	local bSeekKill = self.StruckEntity
	local flBestDist = MAX_COORD_FLOAT
	local vecDelta
	local flDot

	if bSeekKill then
		local entList = ents.FindInSphere(trace.HitPos, 1024)

		for i=1, #entList do
			local ent = entList[i]
			if not IsValid(ent) then continue end
			if not self:IsAttractiveTarget( ent ) then continue end

			local vecDelta = ent:WorldSpaceCenter()
			vecDelta:Sub(trace.HitPos)

			local flDistance = vecDelta:GetNormalized():Length()
			if flDistance < flBestDist then
				if vecDelta:Dot(vecVelDir) > 0.0 then
					bestTarget = ent
					flBestDist = flDistance
				end
			end
		end
	else
		local flMaxDot = self:GetUpgraded() and 30 or 15
		local flGuideFactor = 0.5

		for i=1, self.PierceCount do
			flMaxDot = flMaxDot * flGuideFactor
		end

		flMaxDot = math.Clamp(math.cos(flMaxDot * math.pi / 180), 0, 1)

		local extents = Vector(256, 256, 256)
		local entList = ents.FindAlongRay(trace.HitPos, trace.HitPos + (vecVelDir * 2048), -extents, extents)

		for i=1, #entList do
			local ent = entList[i]
			if not IsValid(ent) then continue end
			if not self:IsAttractiveTarget( ent ) then continue end

			local vecDelta = ent:WorldSpaceCenter()
			vecDelta:Sub(trace.HitPos)
			vecDelta:Normalize()

			local flDistance = vecDelta:GetNormalized():Length()
			flDot = vecDelta:Dot(vecVelDir)

			if flDot > flMaxDot then
				if flDistance < flBestDist then
					bestTarget = ent
					flBestDist = flDistance
				end
			end
		end
	end

	if IsValid(bestTarget) then
		local vecDelta = bestTarget:WorldSpaceCenter()
		vecDelta:Sub(vecStartPoint)
		vecDelta:Normalize()

		return vecDelta
	end
end

function ENT:OnRemove()
	self:StopParticles()
end

function FindHullIntersection( entity, trace, trace2 )
	// Equivalent to enginetrace->ClipRayToEntity()
	local ray = {
		start = trace.HitPos,
		endpos = 48 * trace.Normal + trace.HitPos,
		mask = MASK_SHOT,
		ignoreworld = true,
		output = trace2,
		whitelist = true,
		filter = entity,
	}

	util_TraceLine( ray )

	if trace2.Hit then
		// Best case scenario, the target entity was on the bolt's trajectory
		return true
	end

	// Find a possible hit location at the same height
	local endPos = ray.endpos
	endPos:Set( entity:GetPos() )
	endPos[ 3 ] = trace.HitPos[ 3 ]

	util_TraceLine( ray )

	if trace2.Hit then
		// Found a suitable point
		return true
	end

	// Last attempt, aim towards the center of mass
	endPos:Set( entity:WorldSpaceCenter() )
	endPos[ 3 ] = 0.5 * ( endPos[ 3 ] + trace.HitPos[ 3 ] ) // limit the vertical excursion

	util_TraceLine( ray )

	return trace2.Hit
end

// Bullet impact
function DoImpactEffect( trace )
	local data = EffectData()
	data:SetStart( trace.StartPos )
	data:SetOrigin( trace.HitPos )
	data:SetEntity( trace.Entity )
	data:SetSurfaceProp( trace.SurfaceProps )
	data:SetHitBox( trace.HitBox )

	DispatchEffect( "Impact", data, false, true )
end

// Impact sparks
function DoSparksEffect( trace )
	local data = EffectData()
	data:SetOrigin( trace.HitPos )
	data:SetNormal( trace.HitNormal )
	data:SetScale( 1 )
	data:SetMagnitude( 2 )

	DispatchEffect( "ElectricSpark", data, false, true )

	util_ScreenShake( trace.HitPos, 4, 10, 0.65, 128 )
end

// Ricochet
function DoRicochetEffect( trace )
	local data = EffectData()
	data:SetOrigin( trace.HitPos )
	data:SetNormal( trace.HitNormal )

	DispatchEffect( "MetalSpark", data, false, true )

	util_ScreenShake( trace.HitPos, 4, 10, 0.65, 128 )
end

// Shooting the water
function DoWaterSplashEffect( trace )
	local data = EffectData()
	data:SetOrigin( trace.HitPos )
	data:SetNormal( trace.Normal )
	data:SetScale( 6 )
	data:SetFlags( bit_AND( trace.Contents, CONTENTS_SLIME ) != 0 && 1 || 0 ) // FX_WATER_IN_SLIME = 1

	DispatchEffect( "gunshotsplash", data, false, true )
end

//-- Sprite
function CreateGlowSprite( dietime )
	dietime = ( dietime ~= nil ) and ( dietime ) or ( 3 )

	local sprite = ents_Create( "env_sprite" )

	if !sprite:IsValid() then return false end

	sprite:SetKeyValue( "spawnflags", 1 ) // start on
	sprite:SetKeyValue( "model", "sprites/light_glow02_noz.vmt" )

	sprite:SetKeyValue( "rendermode", 3 ) // glow
	sprite:SetKeyValue( "renderfx", 14 ) // constant glow
	sprite:SetKeyValue( "rendercolor", "255 255 255" )
	sprite:SetKeyValue( "renderamt", 128 )
	sprite:SetKeyValue( "scale", 0.2 )

	sprite:Spawn()

	SafeRemoveEntityDelayed( sprite, dietime + 1 )

	// Fade the sprite in the next X seconds
	local SpriteFadeTime = CurTime() + ( dietime + 1 )
	local SpriteFade = "crossbow_sprite_fade" .. sprite:EntIndex()

	timer.Simple( dietime, function() //-- Yeah,
		timer.Create( SpriteFade, 0, 0, function() //-- I fucking hate my self
			if not IsValid( sprite ) then timer.Remove( SpriteFade ) return end

			local deltaTime = SpriteFadeTime - CurTime()
			if deltaTime > 0 then
				sprite:SetKeyValue( "renderamt", 128 * deltaTime )
			else
				sprite:Remove()
				timer.Remove( SpriteFade )
			end
		end )
	end )

	return sprite
end

if SERVER then
	local sv_ragdollpinning = GetConVar("sv_waw_crossbow_pinning")
	local sv_ragdolltime = GetConVar("sv_waw_crossbow_pin_duration")

	function ENT:PinClientsideRagdolls( trace )
		local direction = trace.Normal
		local origin = trace.HitPos - direction

		timer.Simple(engine.TickInterval(), function() // must give clients the time to spawn ragdolls
			if !IsValid( self ) then
				return
			end

			net.Start( "WW.Crossbow.Pin" )

			//-- Attach ragdolls to bolt so they can travel with the projectile
			net.WriteEntity( self )

			// net.WriteVector() and net.WriteNormal() have precision issues that become relevant in bigger maps
			net.WriteFloat( origin[ 1 ] )
			net.WriteFloat( origin[ 2 ] )
			net.WriteFloat( origin[ 3 ] )

			net.WriteFloat( direction[ 1 ] )
			net.WriteFloat( direction[ 2 ] )
			net.WriteFloat( direction[ 3 ] )

			net.Broadcast()
		end)
	end

	local t_RagdollMovers = {}

	function ENT:PinServersideRagdoll( ragdoll, target, origin, normal, physicsBone )
		if not sv_ragdollpinning:GetBool() then return end

		ragdoll.PinnedCrossbowBolt = self
		// A frame of pause to wait for ragdoll's physics init and to avoid overloading the server
		timer.Simple(engine.TickInterval(), function()
			if !IsValid( ragdoll ) or !IsValid( self ) then
				return
			end

			local physicsObject = ragdoll:GetPhysicsObjectNum( physicsBone )

			if IsValid( physicsObject ) then
				// Place the ragdoll bone as close to the target as possible without intersecting too much
				local bonePos = physicsObject:GetPos()
				local mins, maxs = physicsObject:GetAABB()

				local hitPos = util_IntersectRayWithOBB( origin, 96 * normal, bonePos, physicsObject:GetAngles(), mins, maxs )

				if hitPos then
					origin:Sub( hitPos ) // overlap the hit position with the origin when moving the physics object
					origin:Add( bonePos )
				else
					origin:Add( -3 * normal ) // just move an arbitrary short distance away from the target
				end

				// Teleport the ragdoll bone and immediately lock it in place
				physicsObject:Wake()
				physicsObject:EnableMotion( true )
				physicsObject:SetPos( origin, true )

				local data = {entity = ragdoll, bone = physicsBone, bolt = self, start = CurTime()}
				table.insert(t_RagdollMovers, data)

				ragdoll:EmitSound("Weapon_Crossbow.BoltSkewer")
				ragdoll.OldCollisionGroup = ragdoll:GetCollisionGroup()
				ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			end
		end)
	end

	//-- The awfullness
	hook.Add("Tick", "ragdollpusherfromhell", function()
		for i, data in pairs( t_RagdollMovers ) do
			local ragdoll = data.entity
			local bone = data.bone
			local bolt = data.bolt

			if not IsValid( ragdoll ) or not IsValid( bolt ) then
				if IsValid( ragdoll ) then
					if ragdoll.OldCollisionGroup then
						ragdoll:SetCollisionGroup( ragdoll.OldCollisionGroup )
						ragdoll.OldCollisionGroup = nil
					end

					for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
						local phys = ragdoll:GetPhysicsObjectNum( i )

						if IsValid( phys ) then
							phys:Wake()
							phys:EnableMotion( true )
							phys:ApplyForceCenter( Vector(0, 0, -GetConVar("sv_gravity"):GetFloat()) )
						end
					end
				end

				t_RagdollMovers[i] = nil
				continue
			end

			local physObj = ragdoll:GetPhysicsObjectNum( bone )
			if not IsValid( physObj ) then
				t_RagdollMovers[i] = nil
				continue
			end

			//debugoverlay.Box( physObj:GetPos(), Vector(-2,-2,-2), Vector(2,2,2), 7, Color(255, 120, 0, 60), true )
			if ( physObj:IsMotionEnabled() or IsValid( bolt:GetParent() ) ) then
				physObj:SetPos( bolt:GetPos() - bolt:GetForward(), true )
			end
			//debugoverlay.Box( physObj:GetPos(), Vector(-2,-2,-2), Vector(2,2,2), 7, Color(255, 0, 255, 60), true )

			if bolt:GetImpacted() and physObj:IsMotionEnabled() then
				physObj:EnableMotion( false )
			end

			//-- let go if we dont stick to a wall in time
			if data.start + sv_ragdolltime:GetFloat() < CurTime() and physObj:IsMotionEnabled() then
				if ragdoll.OldCollisionGroup then
					ragdoll:SetCollisionGroup(ragdoll.OldCollisionGroup)
					ragdoll.OldCollisionGroup = nil
				end
				t_RagdollMovers[i] = nil
				continue
			end
		end
	end)
end

if CLIENT then
	local cl_ragdollpinning = GetConVar("cl_waw_crossbow_pinning")
	local cl_ragdolltime = GetConVar("cl_waw_crossbow_pin_duration")

	local t_RagdollMovers = {}

	net.Receive( "WW.Crossbow.Pin", function()
		if not cl_ragdollpinning:GetBool() then return end

		local bolt = net.ReadEntity()
		if not IsValid(bolt) then return end

		local origin = Vector()
		origin[ 1 ] = net.ReadFloat()
		origin[ 2 ] = net.ReadFloat()
		origin[ 3 ] = net.ReadFloat()

		local normal = Vector()
		normal[ 1 ] = net.ReadFloat()
		normal[ 2 ] = net.ReadFloat()
		normal[ 3 ] = net.ReadFloat()

		normal:Mul( 96 )
		//debugoverlay.Line( origin + vector_up, origin + normal + vector_up, 10, Color(0, 0, 255, 255), true )

		// Look for clientside ragdolls. Hull traces are better suited for this task,
		// but it seems that, at the time of writing this, they cannot hit clientside ragdolls
		timer.Simple(engine.TickInterval(), function()
			if not IsValid(bolt) then return end

			local trace = util_TraceLine({
				start = origin,
				endpos = origin + normal,
				mask = MASK_SHOT,
				ignoreworld = true,

				hitclientonly = true,
				whitelist = true,
				filter = CLIENT_RAGDOLLS,
			})

			if !trace.Hit then return end

			// Pin the ragdoll to the origin point, but instead of using a constraint like 'c_stickybolt'
			// does (we can't do that in Lua clientside), the physics object gets simply motion-disabled

			local ragdoll = trace.Entity
			local physicsObject = ragdoll:GetPhysicsObjectNum( trace.PhysicsBone )

			if !IsValid( physicsObject ) then return end

			physicsObject:Wake()

			// probably already pinned, don't move it
			if !physicsObject:IsMotionEnabled() then return end

			ragdoll:EmitSound("Weapon_Crossbow.BoltSkewer")

			for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
				local phys = ragdoll:GetPhysicsObjectNum( i )

				if IsValid( phys ) then
					phys:SetMass( 1 )
				end
			end

			//-- The evil deed begins
			local data = {entity = ragdoll, bone = trace.PhysicsBone, bolt = bolt, start = CurTime()}
			table.insert(t_RagdollMovers, data)

			origin:Sub( trace.HitPos ) // overlap the trace hit position with the origin when moving the physics object
			origin:Add( physicsObject:GetPos() )

			physicsObject:SetPos( origin, true )
		end)
	end)

	//-- Awfullness
	hook.Add("Tick", "ragdollpusherfromhell", function()
		for i, data in pairs( t_RagdollMovers ) do
			local ragdoll = data.entity
			local bone = data.bone
			local bolt = data.bolt

			if not IsValid( ragdoll ) or not IsValid( bolt ) then
				if IsValid( ragdoll ) then
					for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
						local phys = ragdoll:GetPhysicsObjectNum( i )

						if IsValid( phys ) then
							phys:Wake()
							phys:EnableMotion( true )
							phys:ApplyForceCenter( Vector(0, 0, -GetConVar("sv_gravity"):GetFloat()) )
						end
					end
				end

				t_RagdollMovers[i] = nil
				continue
			end

			local physObj = ragdoll:GetPhysicsObjectNum( bone )
			if not IsValid( physObj ) then
				t_RagdollMovers[i] = nil
				continue
			end

			physObj:SetPos( bolt:GetPos() - bolt:GetForward(), true )
			physObj:SetAngles( bolt:GetAngles() )
			physObj:SetVelocity( bolt:GetForward() * 6000 )

			if bolt:GetImpacted() and physObj:IsMotionEnabled() then
				physObj:EnableMotion( false )
			end

			//-- let go if we dont stick to a wall in time
			if data.start + cl_ragdolltime:GetFloat() < CurTime() and physObj:IsMotionEnabled() then
				local direction = bolt:GetForward()
				for i = 0, ragdoll:GetPhysicsObjectCount() - 1 do
					local phys = ragdoll:GetPhysicsObjectNum( i )

					if IsValid( phys ) then
						phys:ApplyForceCenter( direction * 6000 )
					end
				end

				t_RagdollMovers[i] = nil
				continue
			end
		end
	end)
end