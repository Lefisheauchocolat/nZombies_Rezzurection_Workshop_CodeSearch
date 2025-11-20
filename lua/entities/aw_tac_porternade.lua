AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Teleport Grenade"

--[Sounds]--

--[Parameters]--
ENT.Range = 64

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local SinglePlayer = game.SinglePlayer()

local function GetClearPaths(ply, pos, tiles)
	local clearPaths = {}
	local filter = player.GetAll()
	table.Add( filter, ents.FindByClass( "prop_physics" ) )
	table.Add( filter, ents.FindByClass( "prop_physics_multiplayer" ) )
	table.Add( filter, ents.FindByClass( "ph_prop" ) )

	for _, tile in pairs( tiles ) do
		local tr = util.TraceLine({
			start = pos,
			endpos = tile,
			filter = filter,
			mask = MASK_PLAYERSOLID
		})
		
		if not tr.Hit and util.IsInWorld(tile) then
			table.insert( clearPaths, tile )
		end
	end

	return clearPaths
end

local function GetSurroundingTiles(ply, pos, scaleForced)
	if scaleForced == nil or not isnumber(scaleForced) then
		scaleForced = 12
	end

	local tiles = {}
	local x, y, z
	local minBound, maxBound = ply:GetHull()
	local checkRange = math.max(scaleForced, maxBound.x, maxBound.y)

	for z = -1, 1, 1 do
		for y = -1, 1, 1 do
			for x = -1, 1, 1 do
				local testTile = Vector(x,y,z)
				testTile:Mul( checkRange )
				local tilePos = pos + testTile
				table.insert( tiles, tilePos )
			end
		end
	end

	return tiles
end

local function CollisionBoxClear(ply, pos, minBound, maxBound)
	local entFilter = {ply, self}
	local tr = util.TraceHull({
		start = pos,
		endpos = pos + ply:GetUp()*maxBound[3],
		maxs = maxBound,
		mins = minBound,
		filter = entFilter,
		mask = MASK_PLAYERSOLID
	})

	local corner1 = pos + Vector(minBound[1], minBound[2], 0)
	debugoverlay.Axis(corner1, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner1) then
		return false
	end

	local corner2 = pos + Vector(minBound[1], maxBound[2], 0)
	debugoverlay.Axis(corner2, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner2) then
		return false
	end

	local corner3 = pos + Vector(maxBound[1], maxBound[2], 0)
	debugoverlay.Axis(corner3, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner3) then
		return false
	end

	local corner4 = pos + Vector(maxBound[1], minBound[2], 0)
	debugoverlay.Axis(corner4, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner4) then
		return false
	end

	local corner5 = pos + Vector(minBound[1], minBound[2], maxBound[3])
	debugoverlay.Axis(corner5, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner5) then
		return false
	end

	local corner6 = pos + Vector(minBound[1], maxBound[2], maxBound[3])
	debugoverlay.Axis(corner6, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner6) then
		return false
	end

	local corner7 = pos + Vector(maxBound[1], maxBound[2], maxBound[3])
	debugoverlay.Axis(corner7, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner7) then
		return false
	end

	local corner8 = pos + Vector(maxBound[1], minBound[2], maxBound[3])
	debugoverlay.Axis(corner8, angle_zero, 5, 4, true)
	if !util.IsInWorld(corner8) then
		return false
	end

	return !tr.StartSolid
end

function ENT:SetupDataTables()
	self:NetworkVar("Vector", 0, "TelePos")
	self:NetworkVar("Bool", 0, "Impacted")
end

function ENT:Draw()
	if self:GetImpacted() then return end

	self:DrawModel()
	self:CreateShadow()

	if !self.pvslight1 or !IsValid(self.pvslight1) then
		self.pvslight1 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 2)
	end
	if !self.pvslight2 or !IsValid(self.pvslight2) then
		self.pvslight2 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 3)
	end
	if !self.pvslight3 or !IsValid(self.pvslight3) then
		self.pvslight3 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 4)
	end
	if !self.pvslight4 or !IsValid(self.pvslight4) then
		self.pvslight4 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 5)
	end
	if !self.pvslight5 or !IsValid(self.pvslight5) then
		self.pvslight5 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 6)
	end
	if !self.pvslight6 or !IsValid(self.pvslight6) then
		self.pvslight6 = CreateParticleSystem(self, "aw_porternade_accent", PATTACH_POINT_FOLLOW, 7)
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetImpacted() then return end
	self:SetImpacted(true)

	self.HitPos = data.HitPos
	self.HitNorm = data.HitNormal
	self.HitFloor = data.HitNormal:Dot(vector_up*-1) > 0.9

	// freeze
	phys:EnableMotion(false)
	phys:SetVelocityInstantaneous(vector_origin)
	phys:SetVelocity(vector_origin)

	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE) //fuck you it has to be this way

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:PhysicsDestroy()
	end)

	// bullet impact effect
	local trace = util.TraceLine({
		start = self:GetPos(),
		endpos = data.HitPos + data.OurOldVelocity:GetNormalized(),
		mask = MASK_SHOT,
		filter = {ply, self}
	})

	local fx = EffectData()
	fx:SetStart( trace.StartPos )
	fx:SetOrigin( trace.HitPos )
	fx:SetEntity( trace.Entity )
	fx:SetSurfaceProp( trace.SurfaceProps )
	fx:SetHitBox( trace.HitBox )

	util.Effect( "Impact", fx, false, true )

	sound.Play("weapons/tfa_aw/grenade/grenade_bounce_default_0"..math.random(9)..".wav", data.HitPos, SNDLVL_IDLE, math.random(97,103), 1)

	self:ActivateCustom(data.HitPos - (self.HitFloor and -vector_up or data.HitNormal), data.HitEntity)
end

function ENT:ActivateCustom(hitPosition, hitEntity)
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:Remove()
		return
	end

	if hitPosition == nil or not isvector(hitPosition) or hitPosition:IsZero() then
		hitPosition = self:GetPos()
	end

	// impact effects
	ParticleEffect("aw_porternade_impact", self.HitPos, self.HitNorm:Angle() - Angle(90,0,0))

	util.Decal("FadingScorch", self.HitPos, self.HitPos + self.HitNorm*4)

	util.ScreenShake(self:GetPos(), 10, 255, 0.5, 128)

	sound.Play("weapons/tfa_aw/grenade/emp/wpn_emp_grenade_exp_v2_0"..math.random(3)..".wav", self:GetPos(), SNDLVL_NORM, math.random(97,103), 1)
	sound.Play("weapons/tfa_aw/grenade/emp/wpn_emp_grenade_sub_01.wav", self:GetPos(), SNDLVL_NORM, math.random(97,103), 1)

	if ply:IsPlayer() then
		// in ulx jail
		if ply.jail then
			self.bHasFailed = true
			self:Remove()
			return
		end
		// in vehicle
		if ply:GetVehicle() ~= NULL then
			self.bHasFailed = true
			self:Remove()
			return
		end
		// frozen or should not be able to move
		if ply:GetMoveType() ~= MOVETYPE_WALK or ply:IsFrozen() or ply:GetWalkSpeed() < 1 then
			self.bHasFailed = true
			self:Remove()
			return
		end
	end

	// dont worry about players or NPCs for finding the starting point
	local hitFilter = {ply, self}
	if hitEntity and IsValid(hitEntity) and (hitEntity:IsNPC() or hitEntity:IsNextBot() or hitEntity:IsPlayer()) then
		table.insert(hitFilter, hitEntity)
	end

	local minBound, maxBound = ply:GetHull()
	local startPos = hitPosition
	local checkRange = math.max(12, maxBound.x, maxBound.y)

	// pull back away from point of impact by the width of the player (incase we hit a wall)
	local test = util.TraceLine({
		start = startPos,
		endpos = startPos - self.HitNorm*checkRange,
		mask = MASK_PLAYERSOLID_BRUSHONLY,
		filter = hitFilter,
	})

	if test.Hit then
		// if we hit something start from the midway between it and our original start
		startPos = startPos - self.HitNorm*(checkRange*(test.Fraction*0.5))

		debugoverlay.Axis(startPos, self.HitNorm:Angle(), 10, 4, true)
	else
		// else use the end point of the trace
		startPos = test.HitPos
	end

	// trace down to find the floor (incase we hit a wall)
	local trace = util.TraceLine({
		start = startPos,
		endpos = startPos - vector_up*288,
		mask = MASK_PLAYERSOLID,
		filter = hitFilter,
	})

	if trace.Hit then
		// offset by 1 in the direction the floor is facing (up usually)
		self:SetTelePos(trace.HitPos + trace.HitNormal)
	else
		// no floor to teleport to (or too high up)
		self.bHasFailed = true
		self:Remove()
		return
	end

	// were in a playerclip (check after finding a suitable starting point incase we hit a wall high up where theres a playerclip)
	if ply:IsPlayer() then
		if bit.band(util.PointContents(self:GetTelePos()), CONTENTS_PLAYERCLIP) == CONTENTS_PLAYERCLIP then
			self.bHasFailed = true
			self:Remove()
			return
		end
	end

	debugoverlay.Line(self:GetTelePos(), startPos, 4, Color(255, 0, 0, 255), false)

	local bSuccess = true
	local nAttempts = 0

	// hull trace check, increasing check range each time it fails up to 4x players hull width
	if not CollisionBoxClear( ply, self:GetTelePos(), minBound, maxBound ) then
		bSuccess = false

		ply:PrintMessage(2, "// Teleport Location Blocked //")

		for i = 1, 4 do
			local surroundingTiles = GetSurroundingTiles( ply, self:GetTelePos(), checkRange*i )
			local clearPaths = GetClearPaths( ply, self:GetTelePos(), surroundingTiles )	

			for _, tile in pairs( clearPaths ) do
				nAttempts = nAttempts + 1

				if CollisionBoxClear( ply, tile, minBound, maxBound ) then
					bSuccess = true

					self:SetTelePos( tile )
					break
				end
			end

			if bSuccess then
				break
			end
		end
	end

	if nAttempts > 0 then
		ply:PrintMessage(2, "// Teleport Retry Count : "..nAttempts.." //")
	end

	if not bSuccess then
		ply:PrintMessage(2, "// Total Failure //")

		self.bHasFailed = true
		self:Remove()
		return
	end

	// damage enemies at teleport point
	self:Explode(self:GetTelePos())

	// pre teleport player effect
	ParticleEffectAttach("aw_porternade_player", PATTACH_ABSORIGIN_FOLLOW, ply, 0)

	// delay teleport
	timer.Simple(0.15, function()
		if not IsValid(self) then return end
		if not IsValid(ply) then return end

		util.Decal("Scorch", self:GetTelePos(), self:GetTelePos() - vector_up*4)

		local phys = ply:GetPhysicsObject()
		if phys:IsValid() then
			if ply:IsPlayer() then
				ply:SetLocalVelocity(vector_origin)
				ply:SetVelocity(vector_origin)
			end
			phys:SetVelocity(vector_origin)
		end

		ply:ViewPunch(Angle(-5, math.Rand(-10, 10), 0))
		ply:SetPos(self:GetTelePos())

		// post teleport effects

		ply:SetNW2Float("TFA.PorternadeFade", CurTime() + 0.5) //screen visuals
		ply:SetNW2Float("TFA.PorternadeDuration", 0.5)

		ParticleEffect("aw_porternade_teleport", ply:GetPos(), vector_up:Angle())

		util.ScreenShake(self:GetTelePos(), 10, 255, 1, 256)

		local sndFilter = RecipientFilter()
		sndFilter:AddPAS(self:GetTelePos())
		sndFilter:RemovePlayer(ply)

		// thirdperson sound
		if sndFilter:GetCount() > 0 then
			EmitSound("weapons/tfa_aw/grenade/teleport/player_teleport_thirdperson_"..math.random(5)..".wav", self:GetTelePos(), 0, CHAN_AUTO, 1, SNDLVL_NORM, 0, math.random(97,103), 0, sndFilter)
		end

		sndFilter:RemoveAllPlayers()
		sndFilter:AddPlayer(ply)

		// firstperson sound
		EmitSound("weapons/tfa_aw/grenade/teleport/player_teleport_"..math.random(5)..".wav", ply:GetPos(), ply:EntIndex(), CHAN_AUTO, 1, SNDLVL_NORM, 0, math.random(97,103), 0, sndFilter)

		self:Remove()
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:PhysicsInitSphere(2, "default")
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:DrawShadow(true)

	if !SinglePlayer or (SinglePlayer and SERVER) then
		ParticleEffectAttach("aw_porternade_trail", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 24)
end

function ENT:Think()
	if CLIENT and self:GetImpacted() and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 105
			self.DLight.g = 230
			self.DLight.b = 255
			self.DLight.brightness = 1
			self.DLight.Decay = 1000
			self.DLight.Size = 256
			self.DLight.dietime = CurTime() + 1
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect()
end

function ENT:Explode(pos)
	if not pos or isvector(pos) or pos:IsZero() then
		pos = self:GetPos()
	end

	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = {ply, self},
		mask = MASK_SHOT_HULL
	}

	self.Damage = self.mydamage or self.Damage

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_DISSOLVE)
	damage:SetDamage(self.Damage)

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not (v:IsNPC() or v:IsNextBot() or v:IsVehicle()) then continue end
		if IsValid(ply) and v:IsNPC() and ply:IsNPC() and v:Disposition(ply) == D_LI then continue end

		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end

		local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

		damage:SetDamagePosition(hitpos)
		damage:SetDamageForce(tr1.Normal*8000)

		v:TakeDamageInfo(damage)
	end
end

function ENT:OnRemove()
end