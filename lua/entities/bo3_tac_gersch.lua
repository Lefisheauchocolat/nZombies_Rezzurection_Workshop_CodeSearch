
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

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Black Hole"

--[Sounds]--
ENT.BlackHoleStartSND = "TFA_BO3_GERSCH.BHStart"

ENT.BlackHoleLoopFarSND = Sound("TFA_BO3_GERSCH.BHLoopFar")
ENT.BlackHoleLoopCloseSND = Sound("TFA_BO3_GERSCH.BHLoopClose")

ENT.BlackHoleEndingSND = "TFA_BO3_GERSCH.BHPrePop"
ENT.BlackHoleCollapseSND = "TFA_BO3_GERSCH.BHPop"

--[Parameters]--
ENT.Delay = 8
ENT.DelayPaP = 16
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Dying")
	self:NetworkVar("Bool", 2, "Activated")

	self:NetworkVar("Vector", 2, "TelePos")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self:EmitSound("TFA_BO3_GERSCH.Bounce")
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

function ENT:ActivateCustom(phys)
	if CLIENT then return end
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	util.ScreenShake(self:GetPos(), 10, 255, 1, 512)

	self:MonkeyBomb()

	self:CreateCore()
	self:CreateExitCore()

	self.killtime = CurTime() + (self:GetUpgraded() and self.DelayPaP or self.Delay)
	self:SetActivated(true)

	/*if game.GetMap() == "nz_moon" then //i dont know how to do this, and why it wont work
		local plate = ents.FindByName("plates_urt_trigger")[1]
		local filter = ents.FindByName('gersh_filter')[1]
		if IsValid(plate) and IsValid(filter) then
			plate:Fire("OnTrigger", "", 2.5, filter, filter)
		end
	end*/
end

function ENT:CreateCore()
	local core = ents.Create("prop_physics")
	core:SetModel("models/dav0r/hoverball.mdl")
	core:SetModelScale(0.4, 0)
	core:SetPos(self:GetPos() + Vector(0,0,64))
	core:SetAngles(angle_zero)
	core:SetParent(self)
	core:SetMoveType(MOVETYPE_NONE)

	core:Spawn()

	timer.Simple(0, function()
		core:SetCollisionGroup(COLLISION_GROUP_NONE)
		core:SetSolid(SOLID_NONE)
	end)
	core:SetMaterial("models/weapons/tfa_bo3/gersch/lambert1")

	local phys = core:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.CoreMDL = core

	self.CoreMDL:EmitSound(self.BlackHoleStartSND)
	self.CoreMDL:EmitSound(self.BlackHoleLoopFarSND)
	self.CoreMDL:EmitSound(self.BlackHoleLoopCloseSND)

	ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_loop_pap" or "bo3_gersch_loop", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL, 0)
end

function ENT:CreateExitCore()
	local core2 = ents.Create("prop_physics")
	core2:SetModel("models/dav0r/hoverball.mdl")
	core2:SetModelScale(0.4, 0)
	core2:SetPos(self:GetTelePos() + Vector(0,0,64))
	core2:SetAngles(angle_zero)
	core2:SetParent(self)
	core2:SetMoveType(MOVETYPE_NONE)
	
	core2:Spawn()

	timer.Simple(0, function()
		core2:SetCollisionGroup(COLLISION_GROUP_NONE)
		core2:SetSolid(SOLID_NONE)
	end)
	core2:SetMaterial("models/weapons/tfa_bo3/gersch/lambert1")

	local phys = core2:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.CoreMDL2 = core2

	self.CoreMDL2:EmitSound(self.BlackHoleLoopCloseSND)

	ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_loop_2_pap" or "bo3_gersch_loop_2", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL2, 0)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	if CLIENT then return end
	self:ConstructTeleportPos()

	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if self:GetActivated() and (dlight) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = 185
			dlight.g = 70
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.2
		end
	end

	if SERVER then
		local core = self.CoreMDL
		if self:GetActivated() and IsValid(core) then
			local pos = self:GetPos()
			for k, v in pairs(ents.FindInSphere(core:GetPos(), 1024)) do
				if v == self:GetOwner() then continue end

				if v:IsNPC() then
					v:SetGroundEntity(nil)
					v:SetVelocity((pos - v:GetPos()):GetNormalized() * 10)
				end

				if v:IsNextBot() then
					if v:GetCollisionGroup() ~= 2 then
						v:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
					end
					v:SetGroundEntity(nil)

					v.loco:SetVelocity((pos - v:GetPos()):GetNormalized() * 200)
				end
			end

			if self:GetActivated() then
				self:MonkeyBombNXB()
				self:MonkeyBomb()
				util.ScreenShake(core:GetPos(), 2, 255, 0.4, 120)
			end

			local killtrigger = ents.FindInSphere(core:GetPos(), 42)
			for k, v in pairs(killtrigger) do
				if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
					self:InflictDamage(v)
				end

				if v:IsPlayer() and not v:IsOnGround() and math.abs(v:GetVelocity()[3]) > 0 then //fix for... something
					local vel = v:GetVelocity()
					v:SetPos(self:GetTelePos() + Vector(0,0,4))
					v:SetGroundEntity(nil)
					v:SetLocalVelocity(vel)

					self:EmitSound("TFA_BO3_GERSCH.Teleport")
					v:EmitSound("TFA_BO3_GERSCH.TeleOut")

					ParticleEffectAttach("bo3_gersch_player_insanity", PATTACH_ABSORIGIN_FOLLOW, v, 0)
				end
			end
		end

		if self:GetDying() and self.CoreMDL and IsValid(self.CoreMDL) then
			self:SetPos(self:GetPos() + vector_up*0.7)
		end

		if self:GetActivated() and self.killtime < CurTime() and !self:GetDying() then
			self:EmitSound("TFA_BO3_GERSCH.BHPrePop")

			if self.CoreMDL and IsValid(self.CoreMDL) then
				self.CoreMDL:StopSound(self.BlackHoleLoopFarSND)
				self.CoreMDL:StopSound(self.BlackHoleLoopCloseSND)
				self.CoreMDL:StopParticles()
				self.CoreMDL:SetParent(nil)
			end

			if self.CoreMDL2 and IsValid(self.CoreMDL2) then
				self.CoreMDL2:SetParent(nil)
			end

			ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_end_pap" or "bo3_gersch_end", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL, 0)

			SafeRemoveEntityDelayed(self, 1.4)
			self:SetModelScale(0.1, 1.4)

			self:SetDying(true)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)

	ParticleEffect("bo3_gersch_kill", ent:WorldSpaceCenter(), angle_zero)
	
	ent:EmitSound("TFA_BO3_GERSCH.Suck")
	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)

	if (ent:IsNPC() or ent:IsNextBot()) then
		self.Kills = self.Kills + 1
		if self.Kills == 6 and IsValid(ply) and ply:IsPlayer() then
			if not ply.bo3gerschachievement then
				TFA.BO3GiveAchievement("They are going THROUGH!", "vgui/overlay/achievment/blackhole.png", ply)
				ply.bo3gerschachievement = true
			end
		end
	end

	local gib = ents.Create("bo3_misc_gib")
	gib:SetPos(self.CoreMDL2:GetPos())
	gib:Spawn()

	local phys = gib:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(0,math.random(1000,2000),0))
		phys:SetVelocity(Vector(math.random(-100,100), math.random(-100,100), math.random(50,150)))
	end
end

function ENT:MonkeyBomb()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNPC() then
			if v:GetEnemy() ~= self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetEnemy(self)
			end

			v:UpdateEnemyMemory(self, self:GetPos())
			v:SetSaveValue("m_vecLastPosition", self:GetPos())
			v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function ENT:MonkeyBombNXB()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNextBot() then
			v.loco:FaceTowards(self:GetPos())
			v.loco:Approach(self:GetPos(), 99)
			if v.SetEnemy then
				v:SetEnemy(self)
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

	local count = table.Count(self.SpawnPoints)
	local spawn = nil

	-- Try to work out the best, random spawnpoint
	for i = 1, count do
		spawn = table.Random(self.SpawnPoints)
		if IsValid(spawn) and spawn:IsInWorld() then
			if spawn == self.LastSpawnPoint and count > 1 then continue end
			if hook.Call("IsSpawnpointSuitable", GAMEMODE, self:GetOwner(), spawn, i == count) then
				self.LastSpawnPoint = spawn
				self:SetTelePos(spawn:GetPos())
				break
			end
		end
	end
end

function ENT:OnRemove()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 2000)) do
			if v:IsNPC() and v:GetEnemy() == self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())
				v:SetSchedule(SCHED_ALERT_STAND)
			end
		end

		if IsValid(self.CoreMDL) and IsValid(self.CoreMDL2) then
			ParticleEffect(self:GetUpgraded() and "bo3_gersch_explode_pap" or "bo3_gersch_explode", self.CoreMDL:GetPos(), angle_zero)

			util.ScreenShake(self:GetPos(), 10, 255, 1, 512)

			self.CoreMDL:StopSound(self.BlackHoleLoopFarSND)
			self.CoreMDL:StopSound(self.BlackHoleLoopCloseSND)
			self.CoreMDL:EmitSound(self.BlackHoleCollapseSND)

			self.CoreMDL2:StopSound(self.BlackHoleLoopFarSND)
			self.CoreMDL2:StopSound(self.BlackHoleLoopCloseSND)
			self.CoreMDL2:EmitSound(self.BlackHoleCollapseSND)

			SafeRemoveEntity(self.CoreMDL)
			SafeRemoveEntity(self.CoreMDL2)
		end
	end
end