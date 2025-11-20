AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Trident Projectile"
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

ENT.nBounceCount = 0
ENT.nMaxBounces = 16
ENT.nMaxBouncesPaP = 24
ENT.nDesiredSpeed = 1200

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

local CurTime = CurTime
local IsValid = IsValid

local bit_AND = bit.band
local ents_FindInBox = ents.FindInBox
local game_GetWorld = game.GetWorld

local util_TraceLine = util.TraceLine
local util_TraceHull = util.TraceHull
local util_PointContents = util.PointContents
local util_ScreenShake = util.ScreenShake

local MASK_SHOT = MASK_SHOT
local MAT_GLASS = MAT_GLASS
local CONTENTS_SLIME = CONTENTS_SLIME
local CONTENTS_LIQUID = bit.bor( CONTENTS_WATER, CONTENTS_SLIME )
local COLLISION_GROUP_BREAKABLE_GLASS = COLLISION_GROUP_BREAKABLE_GLASS

local WorldToLocal = WorldToLocal
local EffectData = EffectData
local DispatchEffect = util.Effect
local PlaySound = sound.Play
local SinglePlayer = game.SinglePlayer()

// Cached constants
local HULL_MAXS = Vector( 2, 2, 2 )
local HULL_MINS = HULL_MAXS:GetNegated()
local MAX_COORD_FLOAT = 16384.0
local WHIZBY_DISTANCE = 200^2
local WHIZBY_BOX_MAXS = Vector( 100, 100, 100 )
local WHIZBY_BOX_MINS = WHIZBY_BOX_MAXS:GetNegated()

// Utility functions
local DoWaterSplashEffect
local FindHullIntersection
local PointOnSegmentNearestToPoint
local CollisionEventToTrace

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:Draw()
end

function ENT:IsTranslucent()
	return true
end

function ENT:PhysicsCollide(data, phys)
	// hit sky
	local hitSurf = util.GetSurfacePropName(data.TheirSurfaceProps)
	if hitSurf and hitSurf == "default_silent" then
		self:Remove()
		return
	end

	self:DoImpactEffect(data)

	// Make sure we don't slow down
	local vecFinalVelocity = data.OurNewVelocity:GetNormalized()
	phys:SetVelocity(vecFinalVelocity*self.nDesiredSpeed)

	self:DeflectTowardEnemy(data, vecFinalVelocity)
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel(self.DefaultModel)
	end

	self:DrawShadow(false)
	self:SetNoDraw(true)

	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(2, "metal_bouncy")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(true)

		phys:SetMass(25)
		phys:EnableGravity(false)
		phys:EnableDrag(false)

		phys:SetBuoyancyRatio(0)
		phys:SetDamping(0, 0.5)

		phys:AddGameFlag(FVPHYSICS_NO_NPC_IMPACT_DMG)
	end

	if !SinglePlayer or (SinglePlayer and SERVER) then
		ParticleEffectAttach(self:GetUpgraded() and "aw_trident_trail_2" or "aw_trident_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	self:EmitSound("TFA_AW_TRIDENT.Loop")

	if self:GetUpgraded() then
		self.nMaxBounces = self.nMaxBouncesPaP
	end

	if CLIENT then return end
	self.killtime = CurTime() + self.Delay

	local ply = self:GetOwner()
	if not self.Inflictor and ply:IsValid() and ply:GetActiveWeapon():IsValid() then
		self.Inflictor = ply:GetActiveWeapon()
	end

	self.Damage = self.mydamage or self.Damage

	// Entity water level
	if bit_AND(util_PointContents(self:GetPos()), CONTENTS_LIQUID) != 0 then
		self.IsUnderwater = true
	else
		self.IsUnderwater = false
	end

	self.FrameTime = engine.TickInterval()

	self:NextThink(CurTime())
end

function ENT:Think()
	if CLIENT then
		if dlight_cvar:GetBool() and DynamicLight then
			local dlight = DynamicLight(self:EntIndex())

			if (dlight) then
				dlight.pos = self:GetPos()
				dlight.r = self:GetUpgraded() and 255 or 120
				dlight.g = self:GetUpgraded() and 255 or 170
				dlight.b = self:GetUpgraded() and 120 or 255
				dlight.brightness = 2
				dlight.Decay = 1000
				dlight.Size = 64
				dlight.DieTime = CurTime() + 1
			end
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

		local phys = self:GetPhysicsObject()
		if not IsValid(phys) then
			self:Remove()
			return false
		end

		local ply = self:GetOwner()

		local speed = self.nDesiredSpeed
		local position = self:GetPos()
		local direction = phys:GetVelocity():GetNormalized()
		local distance = speed * self.FrameTime

		local trace = {}
		local myfilter = {self, ply}
		if nzombies and !self:GetUpgraded() then
			table.Merge(myfilter, table.Copy(player.GetAll()))
		end

		util_TraceHull({
			start = position,
			endpos = distance * direction + position,
			filter = myfilter,
			mask = MASK_SHOT,
			maxs = HULL_MAXS,
			mins = HULL_MINS,
			output = trace,
		})

		self:WaterLevelThink(trace)

		self:WhizSoundThink(position, (speed * (self.FrameTime * 2)) * direction + position, direction)

		if trace.Hit then
			local hitEntity = trace.Entity
			if hitEntity:GetCollisionGroup() == COLLISION_GROUP_BREAKABLE_GLASS then
				hitEntity:Input( "Break" )
			end

			if !nzombies and trace.HitSky then
				self:Remove()
				return false
			end

			local trace2 = {}
			local hitEntity = trace.Entity
			local hitCharacter = hitEntity:IsNPC() or hitEntity:IsPlayer() or hitEntity:IsNextBot()
			local hitHealTarget = (self:GetUpgraded() and hitEntity:IsPlayer())
			local takeDamage = hitEntity:GetInternalVariable("m_takedamage") or 0

			if hitCharacter and (takeDamage ~= DAMAGE_NO or hitHealTarget) then
				if FindHullIntersection(hitEntity, trace, trace2) then
					trace.HitPos:Set(trace2.HitPos)
					trace.HitBox = trace2.HitBox
					trace.PhysicsBone = trace2.PhysicsBone
					trace.HitGroup = trace2.HitGroup
				end

				if hitHealTarget then
					if hitEntity:Health() < hitEntity:GetMaxHealth() then
						hitEntity:SetHealth(math.Clamp(hitEntity:Health() + 50, hitEntity:Health(), hitEntity:GetMaxHealth()))

						ParticleEffectAttach("aw_trident_heal", PATTACH_POINT_FOLLOW, hitEntity, 2)
					end
				else
					local fx = EffectData()
					fx:SetStart(trace.StartPos)
					fx:SetOrigin(trace.HitPos)
					fx:SetEntity(trace.Entity)
					fx:SetSurfaceProp(trace.SurfaceProps)
					fx:SetHitBox(trace.HitBox)

					DispatchEffect("Impact", fx)

					self:InflictDamage(hitEntity, trace.HitPos, trace.HitGroup, trace.Normal*8000, nzombies and bit.bor(DMG_BULLET, DMG_PLASMA) or bit.bor(DMG_AIRBOAT, DMG_NEVERGIB))

					self.nBounceCount = self.nBounceCount + 1
					if self.nBounceCount >= self.nMaxBounces then
						ParticleEffect(self:GetUpgraded() and "aw_trident_impact_2" or "aw_trident_impact", trace.HitPos, -trace.Normal:Angle())
						self:EmitSound("TFA_AW_TRIDENT.Spark")
						self:Remove()
						return false
					end

					PlaySound("weapons/tfa_aw/trident/wpn_trident_spark_0"..math.random(3)..".wav", trace.HitPos, hitCharacter and SNDLVL_NORM or SNDLVL_65db, math.random(97,103), 1)

					self:DoImpactEffect(trace)

					local hitDot = trace.HitNormal:Dot(-direction)

					direction:Add(2 * hitDot * trace.HitNormal)
					direction:Normalize()

					local inverted = direction[3] < 0
					direction[3] = math.max(math.Rand(0,0.75), math.abs(direction[3]))
					if inverted then
						direction[3] = -direction[3]
					end

					self:SetAngles(direction:Angle())
					phys:SetVelocity(direction*speed)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitPos, hitGroup, hitForce, damageType, damageAmount)
	if nzombies and ent:IsPlayer() then return end

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ent:IsNPC() and ent:Disposition(ply) == D_LI then
		return
	end

	local damage = DamageInfo()
	damage:SetDamage(damageAmount or self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or game_GetWorld)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(hitForce)
	damage:SetDamageType(damageType)
	damage:SetDamagePosition(hitPos or ent:WorldSpaceCenter())

	if (hitGroup and hitGroup == HITGROUP_HEAD) then
		damage:SetDamage(self.Damage*4)
	end

	ent:TakeDamageInfo(damage)
end

function ENT:DoImpactEffect(trace)
	PlaySound("weapons/tfa_aw/trident/wpn_trident_prj_bounce_0"..math.random(9)..".wav", trace.HitPos, SNDLVL_65db, math.random(97,103), 1)
	PlaySound("weapons/tfa_aw/trident/wpn_trident_prj_bounce_lyr_"..math.random(12)..".wav", trace.HitPos, SNDLVL_65db, math.random(97,103), 1)

	self:EmitSound("weapons/tfa_aw/trident/wpn_trident_sub.wav", SNDLVL_IDLE, 100, 0.5)

	ParticleEffect(self:GetUpgraded() and "aw_trident_impact_2" or "aw_trident_impact", trace.HitPos, trace.HitNormal:Angle())

	local fx = EffectData()
	fx:SetOrigin(trace.HitPos)
	fx:SetNormal(-trace.HitNormal)
	fx:SetScale(1)
	fx:SetMagnitude(2)

	DispatchEffect("ElectricSpark", fx, false, true)

	util_ScreenShake(trace.HitPos, 4, 10, 0.5, 128)
end

function ENT:IsAttractiveTarget(ent)
	local ply = self:GetOwner()

	if nzombies and ent:IsPlayer() then
		return false
	end
	if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() or ent:IsVehicle()) then
		return false
	end
	if ent:Health() <= 0 then
		return false
	end
	if ent:GetNoDraw() then
		return false
	end
	if IsValid(ply) and ent:IsNPC() and ply:IsNPC() and ent:Disposition(ply) == D_LI then
		return false
	end
	if IsValid(ply) and ent == ply then
		return false
	end

	local tr = util_TraceLine({
		start = self:GetPos(),
		endpos = ent:WorldSpaceCenter(),
		filter = {self, ply},
		mask = MASK_SOLID
	}) 

	if (tr.Fraction < 1 and tr.Entity ~= ent) then
		return false
	end

	return true
end

function ENT:DeflectTowardEnemy( trace, vecVelDir )
	if self.fl_LastDeflect and self.fl_LastDeflect + 0.2 > CurTime() then
		self.fl_LastDeflect = 0
		return
	end

	local bestTarget
	local vecStartPoint = trace.HitPos
	local flBestDist = MAX_COORD_FLOAT
	local vecDelta
	local flDot

	local entList = ents.FindInSphere(trace.HitPos, 2048)

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

	if IsValid(bestTarget) then
		local vecDelta = bestTarget:WorldSpaceCenter()
		vecDelta:Sub(vecStartPoint)
		vecDelta:Normalize()

		self.fl_LastDeflect = CurTime()

		local phys = self:GetPhysicsObject()

		self:SetAngles(vecDelta:Angle())
		phys:SetVelocity(vecDelta*self.nDesiredSpeed)
	end
end

function ENT:WaterLevelThink(trace)
	local trace2 = {}

	if bit_AND(util_PointContents(trace.HitPos), CONTENTS_LIQUID) != 0 then
		if not self.IsUnderwater then
			self.IsUnderwater = true

			util_TraceLine({
				start = trace.StartPos,
				endpos = trace.HitPos,
				mask = CONTENTS_LIQUID,
				output = trace2,
			})

			DoWaterSplashEffect(trace2)
		end
	 elseif self.IsUnderwater then
		self.IsUnderwater = false

		util_TraceLine({
			start = trace.HitPos,
			endpos = trace.StartPos,
			mask = CONTENTS_LIQUID,
			output = trace2,
		})

		DoWaterSplashEffect(trace2)
	end
end

function ENT:WhizSoundThink( start, endpos, direction )
	if self:GetCreationTime() + 0.2 > CurTime() then return end

	for _, ent in pairs( ents_FindInBox( self:LocalToWorld( WHIZBY_BOX_MAXS ), self:LocalToWorld( WHIZBY_BOX_MINS ) ) ) do
		if not ent:IsPlayer() then continue end
		if ent.NextTridentWhizby and ent.NextTridentWhizby > CurTime() then continue end

		local playerPos = ent:GetPos()

		local vecDelta = Vector()
		vecDelta:Set(start)
		vecDelta:Sub(playerPos)
		vecDelta:Normalize()

		if vecDelta:DotProduct(direction) > 0.5 then
			local radial_origin = PointOnSegmentNearestToPoint( start, endpos, playerPos )
			if playerPos:DistToSqr(radial_origin) < WHIZBY_DISTANCE then
				local filter = RecipientFilter()
				filter:AddPlayer(ent)

				ent.NextTridentWhizby = CurTime() + 0.5
				self:EmitSound("weapons/tfa_aw/trident/wpn_trident_prj_zip_0"..math.random(6)..".wav", SNDLVL_80db, 100, 1, CHAN_ITEM, 0, 0, filter)
			end
		end
	end
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

function DoWaterSplashEffect(trace)
	local data = EffectData()
	data:SetOrigin( trace.HitPos )
	data:SetNormal( trace.Normal )
	data:SetScale( 6 )
	data:SetFlags( bit_AND( trace.Contents, CONTENTS_SLIME ) != 0 && 1 || 0 ) // FX_WATER_IN_SLIME = 1

	DispatchEffect( "gunshotsplash", data, false, true )
end

function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function CollisionEventToTrace(data)
	local trace = util_TraceLine({
		start = self:GetPos(),
		endpos = data.HitPos,
		mask = MASK_SHOT,
		ignoreworld = true,
		whitelist = true,
		filter = data.HitEntity,
	})

	return trace
end

function ENT:OnRemove()
	self:StopSound("TFA_AW_TRIDENT.Loop")
end
