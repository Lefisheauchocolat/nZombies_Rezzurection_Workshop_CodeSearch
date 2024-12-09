AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "breakable_entry"
ENT.Author			= "GhostlyMoo and FlamingFox"
ENT.Contact			= "No fuck off"
ENT.Purpose			= ""
ENT.Instructions	= ""


function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "NumPlanks" )
	self:NetworkVar( "Bool", 0, "HasPlanks" )
	self:NetworkVar( "Bool", 1, "TriggerJumps" )
	self:NetworkVar( "Bool", 2, "PlayerCollision" )
	self:NetworkVar( "Int", 1, "BoardType" )
	self:NetworkVar( "Int", 2, "Prop" )
	self:NetworkVar( "Int", 3, "JumpType" )
    self:NetworkVar("String", 0, "InitialTarget")
end

-- What positions the barricade can possibly use
ENT.BarricadeTearPositions = {
	Front = {
		Vector(-31,0,0),
		Vector(-31,27,0),
		Vector(-31,-27,0),
	},
	Back = {
		Vector(31,0,0),
		Vector(31,27,0),
		Vector(31,-27,0),
	}
}

function ENT:Initialize()

	self:SetModel("models/moo/barricade/barricade.mdl")
	self:SetSubMaterial(0, "models/wireframe")

	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetCustomCollisionCheck(true)
	self.NextPlank = CurTime()

	self:SetBodygroup(1,self:GetProp())

	self.ZombieUsing = nil

	self.Planks = {}
	self.ClassicNumsPlanks = {}

	self:SetBoardType(self:GetBoardType())

	self:UpdateBarricadePos()

	if SERVER then
		self:ResetPlanks(true)
	end
end

function ENT:ReserveAvailableTearPosition(z)
	local tbl = (z:GetPos() - self:GetPos()):Dot(self:GetAngles():Forward()) < 0 and self.m_tReservedSpots.Front or self.m_tReservedSpots.Back
	for k,v in pairs(tbl) do
		if not IsValid(v) or v == z then
			tbl[k] = z
			return k
		end
	end
end

function ENT:InitPlankSetup()
	if !self:GetHasPlanks() then return end
	self.NextPlank = CurTime() + 4
	for i=1, 6 do
		timer.Simple(i * 0.1, function()
			if IsValid(self) then
				if self:GetNumPlanks() < 6 then
					self:CreatePlank() 
				end
			end
		end)
	end
end

function ENT:CreatePlank(nosound)
	if !self:GetHasPlanks() then return end
	if self:GetNumPlanks() < 6 then
		--self:SetNumPlanks( (self:GetNumPlanks() or 0) + 1 )
		self:SpawnPlank()
	end
end

function ENT:FullRepair()
	if !self:GetHasPlanks() then return end
	self.NextPlank = CurTime() + 4
	for i=1, 6 do
		timer.Simple(i * 0.1, function()
			if IsValid(self) then
				if self:GetNumPlanks() < 6 then
					local plank = self:GetTornPlank()
					if IsValid(plank) then
						self:AddPlank(plank) 
					end
				end
			end
		end)
	end
end

function ENT:FullBreak()
	if !self:GetHasPlanks() then return end
	self.NextPlank = CurTime() + 4
	self.ZombieUsing = nil
	for i=1, 6 do
		timer.Simple(i * 0.1, function()
			if IsValid(self) then
				local plank = self:GetCurrentPlank()
				if IsValid(plank) then
					self:RemovePlank(plank)
				end
			end
		end)
	end
end

function ENT:AddPlank(plank, ent)
	if !self:GetHasPlanks() then return end
	if self:GetNumPlanks() < 6 then
		--self:SetNumPlanks( (self:GetNumPlanks() or 0) + 1 )
		self:PlankCheck(plank, ent)
	end
end

function ENT:GetCurrentPlank()
	local tbl = {}
	for k,v in pairs(self.Planks) do
		if !IsValid(self.ZombieUsing) and !IsValid(v.ZombieUsing) and !v.Torn then
			table.insert(tbl, v)
		end
	end
	return tbl[math.random(#tbl)]
end

function ENT:GetTornPlank()
	local tbl = {}
	for k,v in pairs(self.Planks) do
		if !IsValid(self.ZombieUsing) and v.Torn then
			table.insert(tbl, v)
		end
	end
	return tbl[math.random(#tbl)]
end

function ENT:BeginPlankPull(ent)
	local plank = self:GetCurrentPlank()
	if IsValid(plank) then
		plank.ZombieUsing = ent
		return plank
	end
end

function ENT:RemovePlank(plank)
	if plank == nil then return end

	local sequence, duration = plank:LookupSequence("o_zombie_board_"..plank:GetFlags().."_pull")
	plank:ResetSequence(sequence)
	plank.Torn = true
	plank.ZombieUsing = nil

	timer.Simple(duration, function()
		if IsValid(self) and IsValid(plank) then
			if !plank:GetNoDraw() and plank.Torn then
				plank:SetNoDraw(true)
			end
		end
	end)

	self:SetNumPlanks( self:GetNumPlanks() - 1 )
	
	self.ZombieUsing = nil
	
	self.NextPlank = CurTime() + 1

	hook.Run("BarricadePlankRemoved", self, plank, sequence, duration)
end

function ENT:ResetPlanks(nosoundoverride)
	for i=1, table.Count(self.Planks) do
		local plank = self:GetCurrentPlank()
		if IsValid(plank) then
			self:RemovePlank(plank)
		end
	end

	table.Empty(self.ClassicNumsPlanks)
	table.insert(self.ClassicNumsPlanks, 1)
	table.insert(self.ClassicNumsPlanks, 2)
	table.insert(self.ClassicNumsPlanks, 3)
	table.insert(self.ClassicNumsPlanks, 4)
	table.insert(self.ClassicNumsPlanks, 5)
	table.insert(self.ClassicNumsPlanks, 6)

	self.Planks = {}
	self:SetNumPlanks(0)
	if self:GetHasPlanks() then
		self:InitPlankSetup()
	end
end

function ENT:Use(ply, caller)
	if not self:GetHasPlanks() or self:GetNumPlanks() >= 6 then return end
	if self.NextPlank and self.NextPlank > CurTime() then return end

	if IsValid(ply) and ply:IsPlayer() then
		if not ply:Alive() then return end
		if ply.GetUsingSpecialWeapon and ply:GetUsingSpecialWeapon() then return end

		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep:IsSpecial() then return end

		local isamish = ply:HasUpgrade("amish")
		local oncrack = ply:HasPerk("speed")
		local time = oncrack and 0.5 or 1

		if isamish and oncrack then
			time = 0.4
		elseif isamish then
			time = 0.75
		end

		local plank = self:GetTornPlank()
		if IsValid(plank) then
			if ply:HasPerk("amish") then
				plank.Enhanced = true
				if self:GetBoardType() == 1 then
					plank:SetBodygroup(1, 1)
				end
			else
				plank.Enhanced = false
				if self:GetBoardType() == 1 then
					plank:SetBodygroup(1, 0)
				end
			end

			self:AddPlank(plank, ply)

			timer.Simple(time, function()
				if not IsValid(ply) then return end
				ply:GivePoints(ply:HasPerk("amish") and (math.random(1,5) * 10) or 10, false, true)
			end)

			self.NextPlank = CurTime() + time
		end
	else
		local plank = self:GetTornPlank()
		if IsValid(plank) then
			plank.Enhanced = false
			if self:GetBoardType() == 1 then
				plank:SetBodygroup(1, 0)
			end

			self:AddPlank(plank)
			self.NextPlank = CurTime() + 1
		end
	end
end

function ENT:GetPlankPositionAvailable(plank)

	local rplank = self.ClassicNumsPlanks[ math.random( #self.ClassicNumsPlanks ) ]

	table.RemoveByValue(self.ClassicNumsPlanks, rplank)
	return rplank
end

function ENT:PlankCheck(plank, ent)
	--print(ent)
	if !IsValid(plank) then plank = self:GetTornPlank() end

	hook.Run("BarricadePlankCheck", self, plank, ent)

	--print(plank.Torn)
	if plank.Torn then
		self:SetNumPlanks( (self:GetNumPlanks() or 0) + 1 )

		local sequence, duration = plank:LookupSequence("o_zombie_board_"..plank:GetFlags().."_repair")
		plank:ResetSequence(sequence)
		plank.Torn = false

		if plank:GetNoDraw() and !plank.Torn then
			plank:SetNoDraw(false)
		end

		timer.Simple(duration, function()
			if IsValid(self) and IsValid(plank) then
				local bone = plank:GetBonePosition(plank:LookupBone("tag_origin"))
				util.ScreenShake(self:GetPos(), 5, 15, 0.3, 200)

				if plank.Enhanced then
					self:EmitSound("nz_moo/barricade/slam/board_upgrd_0"..math.random(0,3)..".mp3", 85, math.random(95,105))
					for k,v in nzLevel.GetZombieArray() do
						if IsValid(v) and (!v.IsMooSpecial or !v.IsMooBossZombie or !v.NZBossType) then
							if v:GetPos():DistToSqr(self:GetPos()) <= 2000 then
								if IsValid(ent) and ent:IsPlayer() and (ent:HasPerk("amish") and math.random(100) < 15 or ent:HasUpgrade("amish") and math.random(100) < 50) then
									v:EmitSound("weapons/tfa_bo2/raketrap/rake_hit_0"..math.random(0,2)..".wav", 85, math.random(95,105))
									v:TakeDamage(v:Health() + 666, ent, ent)
								end
							end
						end
					end
				end

				for i = 1, 3 do
					ParticleEffect(self:GetBoardType() == 2 and self:GetBoardType() == 3 and"impact_metal" or "impact_wood", bone, Angle(0,0,0))
				end
			end
		end)
	end
end

function ENT:SpawnPlank()
	local plank = self:GetBoardType() == 1 and ents.Create("breakable_entry_plank") or self:GetBoardType() == 2 and ents.Create("breakable_entry_bar") or self:GetBoardType() == 3 and ents.Create("breakable_entry_ventslat") or self:GetBoardType() == 4 and ents.Create("breakable_entry_plank_zhd")
	plank:SetParent(self)
	if self:GetBoardType() == 1 or self:GetBoardType() == 4 then
		plank:SetLocalPos( Vector(32,0,34))
		plank:SetLocalAngles( Angle(0,180,0))
	elseif self:GetBoardType() == 2 or self:GetBoardType() == 3 then
		plank:SetLocalPos( Vector(32,0,29))
		plank:SetLocalAngles( Angle(0,90,0))
	end
	plank:Spawn()
	plank:SetCollisionGroup( COLLISION_GROUP_DEBRIS )

	local nums = self:GetPlankPositionAvailable(plank)
	plank:AddFlags(nums)
	table.insert(self.Planks, plank)

	hook.Run("BarricadePlankCreated", self, plank)

	self:PlankCheck(plank)

	if IsValid(plank) and (self:GetBoardType() == 1 or self:GetBoardType() == 4) then
		plank:SetBodygroup(0, plank:GetFlags() - 1)
	end

	return plank
end

function ENT:GetOpenSpots()
	return self.Spots
end

function ENT:HasZombie(ent)
	self.ZombieUsing = ent
	self.CurrentlyInUse = true
end

function ENT:UpdateBarricadePos()
	-- Determine what positions are available
	local t = {}

	local ms,mx = Vector(-15,-15,10), Vector(15,15,70)
	for k,v in pairs(self.BarricadeTearPositions) do
		local t2 = {}
		for k2,v2 in pairs(v) do
			local pos = self:LocalToWorld(v2)
			local tr = util.TraceHull({
				start = pos,
				endpos = pos,
				mins = ms,
				maxs = mx,
				filter = self
			})
			if not tr.Hit then
				t2[pos] = NULL
			end
		end
		t[k] = t2
	end
	self.m_tReservedSpots = t
end

function ENT:Touch(ent) end

local function CollidableEnt(ent)
	if (ent:Health() > 0) then return true end -- This entity is an organism of some type
	if (!IsValid(ent:GetPhysicsObject())) then return true end -- This entity is not a physics object
	return false
end

function IsStuck(ply)
	local Maxs = Vector(ply:OBBMaxs().X / ply:GetModelScale(), ply:OBBMaxs().Y / ply:GetModelScale(), ply:OBBMaxs().Z / ply:GetModelScale())
	local Mins = Vector(ply:OBBMins().X / ply:GetModelScale(), ply:OBBMins().Y / ply:GetModelScale(), ply:OBBMins().Z / ply:GetModelScale())

	local tr = util.TraceHull({
		start = ply:GetPos(),
		endpos = ply:GetPos(),
		maxs = Maxs, -- Exactly the size the player uses to collide with stuff
		mins = Mins, -- ^
		collisiongroup = COLLISION_GROUP_PLAYER, -- Collides with stuff that players collide with
		filter = ply
	})

	return tr.Hit
end

hook.Add("ShouldCollide", "zCollisionHook", function(ent1, ent2)
	if IsValid(ent1) and ent1:GetClass() == "breakable_entry" and ent2:IsPlayer() and !ent1:GetPlayerCollision() then return false end
	if IsValid(ent1) and ent1:GetClass() == "breakable_entry" and !ent2:IsPlayer() and ent2.Type != "nextbot" then return false end
	if IsValid(ent1) and ent1:GetClass() == "breakable_entry_plank" and !ent2:IsPlayer() and ent2.Type != "nextbot" then return false end
	if IsValid(ent1) and (ent1:GetClass() == "invis_wall"
						or ent1:GetClass() == "wall_block"
						or ent1:GetClass() == "invis_wall_zombie"
						or ent1.Base == "wall_block") and !ent2:IsPlayer() and ent2.Type != "nextbot" then return false end

-- 	-- Barricade glitch fixed by Ethorbit:
	if IsValid(ent1) and ent1:GetClass() == "breakable_entry" and nzConfig.ValidEnemies[ent2:GetClass()] and !ent1:GetTriggerJumps() and ent1.NoPlanks then
		if !ent2:GetTarget() then return end

		if !ent1.CollisionResetTime then
			if !IsValid(ent2:GetTarget()) then return end
			if ent1:GetPos():Distance(ent2:GetTarget():GetPos()) > 80 then
				--return false
				ent1:SetSolid(SOLID_NONE)
				ent1.CollisionResetTime = CurTime() + 0.1
			end
		end
	end

	if IsValid(ent2) and ent2:GetClass() == "breakable_entry" and nzConfig.ValidEnemies[ent1:GetClass()] and !ent2:GetTriggerJumps() and ent2.NoPlanks then
		if !ent1:GetTarget() then return end

		if !ent2.CollisionResetTime then
			if !IsValid(ent1:GetTarget()) then return end
			if ent2:GetPos():Distance(ent1:GetTarget():GetPos()) > 80 then
				--return false
				ent2:SetSolid(SOLID_NONE)
				ent2.CollisionResetTime = CurTime() + 0.1
			end
		end
	end
end)

if CLIENT then
	function ENT:Draw()
		local mat = Material("cable/redlaser")
		local vaultheight = 42
		local col = Color(255,255,255)
		self:DrawModel()
		if ConVarExists("nz_creative_preview") and !GetConVar("nz_creative_preview"):GetBool() and nzRound:InState( ROUND_CREATE ) then
			render.SetMaterial(mat)
			render.DrawBeam(
				self:LocalToWorld(Vector(0,-30,vaultheight)),
				self:LocalToWorld(Vector(0,30,vaultheight)),
				10,
				0,
				1,
				col
			)
		end
		self:SetBodygroup(1,self:GetProp())
		if nzRound:InState( ROUND_CREATE ) and !GetConVar("nz_creative_preview"):GetBool() then
			self:SetBodygroup(0,0)
		else
			self:SetBodygroup(0,1)
			self:SetSubMaterial(0, "invisible")
		end
	end
else
	local player = player
	local generator0, generator1

	local function updateGenerator()
		generator0 = player.GetAll()
		generator1 = 1
	end

	local function generate()
		local next = generator0[generator1]
		generator1 = generator1 + 1
		return next
	end

	local function nextPlayer()
		if player.GetCount() == 0 then return nil end

		if generator0 == nil then
			updateGenerator()
		end

		local next = generate()

		if next == nil then
			updateGenerator()
			return generate()
		end

		return next
	end

	function ENT:Think()
		if self:GetHasPlanks() and self:GetNumPlanks() < 6 then
			local p = nextPlayer()
			if IsValid(p) and p:HasUpgrade("amish") and self.NextPlank < CurTime() and p:Alive() and p:GetPos():DistToSqr(self:GetPos()) < 5000 then
				self:Use(p, p, USE_ON, 1)
			end
		end

		if self.CollisionResetTime and self.CollisionResetTime < CurTime() then
			self:SetSolid(SOLID_VPHYSICS)
			self.CollisionResetTime = nil
		end

		if self.ZombieUsing and !IsValid(self.ZombieUsing) then
			self.ZombieUsing = nil
		end

		--print(self.ZombieUsing)

		self:NextThink(CurTime())
		return true
	end
end

hook.Add("PhysgunDrop", "UpdatePositions", function()
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "breakable_entry" then
			v:UpdateBarricadePos()
		end
	end
end)