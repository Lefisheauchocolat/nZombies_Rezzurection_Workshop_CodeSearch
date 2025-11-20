AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Quizz Teslanade"

--[Sounds]--
ENT.BounceSound = Sound("TFA_WAW_QUIZZTESLA.Bounce")

--[Parameters]--
ENT.Delay = 1.8
ENT.Life = 8
ENT.Range = 200
ENT.Rate = 0.1
ENT.Kills = 0
ENT.TPRange = 42^2

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Angle", 0, "Roll")
end

local hasdunit = false
function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()

	if !self.pvslight1 or !IsValid(self.pvslight1) then
		self.pvslight1 = CreateParticleSystem(self, "waw_teslanade_wm1", PATTACH_POINT_FOLLOW, 1)
	end
	if !self.pvslight2 or !IsValid(self.pvslight2) then
		self.pvslight2 = CreateParticleSystem(self, "waw_teslanade_wm2", PATTACH_POINT_FOLLOW, 2)
	end
	if !self.pvslight3 or !IsValid(self.pvslight3) then
		self.pvslight3 = CreateParticleSystem(self, "waw_teslanade_wm2", PATTACH_POINT_FOLLOW, 3)
	end
	if !self.pvslight4 or !IsValid(self.pvslight4) then
		self.pvslight4 = CreateParticleSystem(self, "waw_teslanade_wm3", PATTACH_POINT_FOLLOW, 4)
	end

	if self:GetActivated() and (!self.pvsfx or !IsValid(self.pvsfx)) then
		self.pvsfx = CreateParticleSystem(self, "waw_teslanade_loop", PATTACH_ABSORIGIN_FOLLOW, 0)
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	if data.Speed > 60 then
		self:EmitSound(self.BounceSound)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)
	
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(0.2, "metal_bouncy")
	self:SetRoll(self:GetAngles())
	self:DrawShadow(true)

	self.killtime = nil

	self:NextThink(CurTime())

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:ConstructTeleportPos()
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 24)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight and self:GetActivated() then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 220
			self.DLight.g = 250
			self.DLight.b = 255
			self.DLight.brightness = 1
			self.DLight.Decay = 2000
			self.DLight.Size = 300
			self.DLight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()
		if self.collapsing then
			self:SetPos(self:GetPos() - vector_up*0.2)
		end

		if self:GetActivated() then
			if self.killtime and self.killtime < CurTime() and !self.collapsing then
				self:SetActivated(false)
				self.collapsing = true

				self:StopParticles()
				self:StopSound("TFA_WAW_QUIZZTESLA.Loop")
				self:EmitSound("TFA_WAW_QUIZZTESLA.Flux")
				self:EmitSound("TFA_WAW_QUIZZTESLA.End")

				ParticleEffect("waw_teslanade_end", self:GetPos(), Angle(0,0,0))

				util.Decal("Scorch", self:GetPos() - vector_up, self:GetPos() + vector_up)

				SafeRemoveEntityDelayed(self, 1.8)
			end

			for k, v in RandomPairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == ply then continue end
					if v.Alive and not v:Alive() then continue end
					if v:Health() <= 0 then continue end
					if v:WAWTeslaWarping() then continue end

					v:WAWTeslaWarp(math.Rand(1.8,2.4), ply, self.Inflictor)
					break
				end
				if v:IsPlayer() and v:GetPos():DistToSqr(self:GetPos()) < self.TPRange then
					local spawnpos = self:GetRandomSpawnerPos(v)
					if spawnpos then
						ParticleEffect("waw_teslanade_warpout", v:WorldSpaceCenter(), angle_zero)

						v:ViewPunch(Angle(-4, math.random(-6, 6), 0))
						v:SetPos(spawnpos)
						v:EmitSound("TFA_WAW_QUIZZTESLA.Teleport")

						ParticleEffect("nz_perks_chuggabud_tp", spawnpos, angle_zero)
					end
				end
			end
		end

		if not self:GetActivated() and self.killtime and self.killtime < CurTime() and !self.collapsing then
			self:SetActivated(true)

			self.killtime = CurTime() + self.Life
			self:EmitSound("TFA_WAW_QUIZZTESLA.Loop")
			self:StopParticles()
			//ParticleEffectAttach("waw_teslanade_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetAngles(angle_zero)
	self:EmitSound("TFA_WAW_QUIZZTESLA.Warmup")
	self.killtime = CurTime() + self.Delay
	ParticleEffectAttach("waw_teslanade_start", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:GetRandomSpawnerPos(ply)
	if not IsValid(ply) then return end
	local count = table.Count(self.SpawnPoints)
	local spawn = nil

	-- Try to work out the best, random spawnpoint
	for i = 1, count do
		spawn = table.Random(self.SpawnPoints)
		if IsValid(spawn) and spawn:IsInWorld() then
			if spawn == self.LastSpawnPoint and count > 1 then continue end
			if hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, spawn, i == count) then
				self.LastSpawnPoint = spawn
				return spawn:GetPos()
			end
		end
	end
end

function ENT:ConstructTeleportPos()
	if !IsTableOfEntitiesValid(self.SpawnPoints) then
		self.LastSpawnPoint = 0
		self.SpawnPoints = ents.FindByClass( "info_player_start" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )

		-- CS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_counterterrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_terrorist" ) )

		-- DOD Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_axis" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_allies" ) )

		-- (Old) GMod Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "gmod_player_start" ) )

		-- TF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_teamspawn" ) )

		-- INS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "ins_spawnpoint" ) )

		-- AOC Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "aoc_spawnpoint" ) )

		-- Dystopia Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "dys_spawn_point" ) )

		-- PVKII Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_pirate" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_viking" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_knight" ) )

		-- DIPRIP Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_red" ) )

		-- OB Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_blue" ) )

		-- SYN Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_coop" ) )

		-- ZPS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_human" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombie" ) )

		-- ZM Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombiemaster" ) )

		-- FOF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_fof" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_desperado" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_vigilante" ) )

		-- L4D Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_survivor_rescue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_survivor_position" ) )
	end
end