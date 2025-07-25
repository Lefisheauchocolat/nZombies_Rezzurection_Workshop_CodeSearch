AddCSLuaFile()

CreateConVar( "nz_zombie_debug", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_CHEAT } )

ENT.Base = "base_nextbot"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Lolle, Zet0r, GhostlyMoo(Primarily), FlamingFox, Chtidino, Wavy" -- A lot of people have touched this fairly large base... Except Laby... He's too afraid.
ENT.Spawnable = true

--[[-------------------------------------------------------------------------
Localization/optimization
---------------------------------------------------------------------------]]
local CurTime 	= CurTime
local type 		= type
local Path 		= Path
local IsValid 	= IsValid
local GetPos 	= GetPos
local pairs 	= pairs

local coroutine 	= coroutine
local ents 			= ents
local math 			= math
local hook 			= hook
local util 			= util
local self 			= self
local ENT 			= ENT
local SERVER 		= SERVER
local CLIENT 		= CLIENT

local util_traceline 	= util.TraceLine
local util_tracehull 	= util.TraceHull
local recycletracetbl = {}
--[[-------------------------------------------------------------------------
Localization/optimization
---------------------------------------------------------------------------]]

-- Can be overridden.
ENT.MaxYawRate 				= 360				-- Limits how fast the zombie can turn.(Higher numbers work well for enemies that move at high speeds.)
ENT.DeathDropHeight 		= 99999999999 		-- Limits the height zombies can drop from.
ENT.StepHeight 				= 24 				-- Limits the height zombies can climb up.
ENT.JumpHeight 				= 90 				-- Limits the height zombies can jump.
ENT.AttackRange 			= 80 				-- Limits the range the zombies have to be in to attack.
ENT.CrawlAttackRange 		= 70 				-- Limits the range the zombies have to be in to attack when crawling.
ENT.DamageRange 			= 80 				-- Limits the range the zombies have to be in in order for their attack hit.
ENT.AttackDamage 			= 50 				-- Limits the amount of damage a zombies attack will do.
ENT.HeavyAttackDamage 		= 90 				-- Limits the amount of damage a zombies heavy attack will do.
ENT.PlankPullAmount 		= 1 				-- Limits the amount of planks the zombie can remove at once.

ENT.MinSoundPitch 			= 75 				-- Limits the minimum pitch for passive sounds the zombie can make.
ENT.MaxSoundPitch 			= 115 				-- Limits the maximum pitch for passive sounds the zombie can make.
ENT.SoundVolume 			= 80 				-- Limits the volume for passive sounds the zombie can make.

ENT.TraversalCheckRange 	= 50 				-- Limits the range on how far the zombies can trace when looking for jump traversals.(Done after checking for interactables.)
ENT.InteractCheckRange 		= 45 				-- Limits the range on how far the zombies can check when looking for barricades or jump traversals.

ENT.ResistWW 				= false 			-- Decided if the nextbot can resist Wonder Weapons or not.
ENT.WWResistDamage 			= 0.5 				-- Decides how much damage the nextbot should scale Wonder Weapon damage by.

ENT.BloodType 				= "Human" 			-- What kind of blood should the zombies have. Currently has: Human, Robot

ENT.CanCutoff 				= false 			-- Decides if the nextbot is allowed to attempt cut offs.

--WORK IN PROGRESS
--ENT.IsNZAlly 				= false 			-- Decides if the nextbot is considered friendly or not.

-- Don't Override.
ENT.RunSpeed 		= 200
ENT.WalkSpeed 		= 100
ENT.Acceleration 	= 500
ENT.Deceleration 	= 900
ENT.Gravity 		= 1000

ENT.Blood = {
	["Human"] = {
		DismemberFX 		= "ins_blood_dismember_limb",
		HeadGibFX 			= "ins_blood_impact_headshot",
		ExplodeFX 			= "zmb_monster_explosion",
	},
	["Robot"] = {
		DismemberFX 		= "zmb_cyborg_dismember_limb",
		HeadGibFX 			= "zmb_cybord_impact_headshot",
		ExplodeFX 			= "zmb_cyborg_hound_explosion",
	},
}

--The Accessors will be partially shared, but should only be used serverside
AccessorFunc( ENT, "fWalkSpeed", "WalkSpeed", FORCE_NUMBER)
AccessorFunc( ENT, "fRunSpeed", "RunSpeed", FORCE_NUMBER)
AccessorFunc( ENT, "fAttackRange", "AttackRange", FORCE_NUMBER)
AccessorFunc( ENT, "fLastLand", "LastLand", FORCE_NUMBER)
AccessorFunc( ENT, "fLastTargetCheck", "LastTargetCheck", FORCE_NUMBER)
AccessorFunc( ENT, "fLastAtack", "LastAttack", FORCE_NUMBER)
AccessorFunc( ENT, "fLastHurt", "LastHurt", FORCE_NUMBER)
AccessorFunc( ENT, "fLastTargetChange", "LastTargetChange", FORCE_NUMBER)
AccessorFunc( ENT, "fTargetCheckRange", "TargetCheckRange", FORCE_NUMBER)

AccessorFunc( ENT, "fTraversalCheckRange", "TraversalCheckRange", FORCE_NUMBER)


--Stuck prevention
AccessorFunc( ENT, "fLastPostionSave", "LastPostionSave", FORCE_NUMBER)
AccessorFunc( ENT, "fLastPush", "LastPush", FORCE_NUMBER)
AccessorFunc( ENT, "iStuckCounter", "StuckCounter", FORCE_NUMBER)
AccessorFunc( ENT, "vStuckAt", "StuckAt")
AccessorFunc( ENT, "bTimedOut", "TimedOut")
AccessorFunc( ENT, "bTargetUnreachable", "TargetUnreachable", FORCE_BOOL)

AccessorFunc( ENT, "bFleeing", "Fleeing", FORCE_BOOL)
AccessorFunc( ENT, "fLastFlee", "LastFlee", FORCE_NUMBER)

-- spawner accessor
AccessorFunc(ENT, "hSpawner", "Spawner")

AccessorFunc( ENT, "bJumping", "Jumping", FORCE_BOOL)
AccessorFunc( ENT, "bAttacking", "Attacking", FORCE_BOOL)
AccessorFunc( ENT, "bStandingAttack", "StandingAttack", FORCE_BOOL)
AccessorFunc( ENT, "bClimbing", "Climbing", FORCE_BOOL)
AccessorFunc( ENT, "bWandering", "Wandering", FORCE_BOOL)
AccessorFunc( ENT, "bStop", "Stop", FORCE_BOOL)
AccessorFunc( ENT, "bSpecialAnim", "SpecialAnimation", FORCE_BOOL)
AccessorFunc( ENT, "bBlockAttack", "BlockAttack", FORCE_BOOL)
AccessorFunc( ENT, "bCrawler", "Crawler", FORCE_BOOL)
AccessorFunc( ENT, "bTeleporting", "Teleporting", FORCE_BOOL)
AccessorFunc( ENT, "bShouldDie", "SpecialShouldDie", FORCE_BOOL)
AccessorFunc( ENT, "bIsBusy", "IsBusy", FORCE_BOOL)
AccessorFunc( ENT, "bShouldCount", "ShouldCount", FORCE_BOOL)

AccessorFunc( ENT, "m_bTargetLocked", "TargetLocked", FORCE_BOOL) -- Stops the Zombie from retargetting and keeps this target while it is valid and targetable
AccessorFunc( ENT, "iActStage", "ActStage", FORCE_NUMBER)

if CLIENT then
	ENT.RedEyes = true
end

local eyetrails 	= GetConVar("nz_zombie_eye_trails")
local comedyday 	= os.date("%d-%m") == "01-04"
local miricalday 	= os.date("%m") == "12"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Decapitated")
	self:NetworkVar("Bool", 1, "IsAlive")
	self:NetworkVar("Bool", 2, "MooSpecial")
	self:NetworkVar("Bool", 3, "WaterBuff")
	self:NetworkVar("Bool", 4, "BomberBuff")
	self:NetworkVar("Bool", 5, "ShadowBuff")
	self:NetworkVar("String", 0, "ZCTFlameColor")

	-- Use InitDataTables instead of trying to override SetupDataTables, it makes life easier.
	if self.InitDataTables then self:InitDataTables() end
end

function ENT:Precache() end

if SERVER then
	function ENT:UpdateModel()
		local models = self.Models
		local choice = models[math.random(#models)]
		util.PrecacheModel( choice.Model )
		self:SetModel(choice.Model)
		if choice.Skin then self:SetSkin(choice.Skin) end
		for i,v in ipairs(self:GetBodyGroups()) do
			self:SetBodygroup( i-1, math.random(0, self:GetBodygroupCount(i-1) - 1))
		end
	end
	--Init
	function ENT:Initialize()

		-- You will give your soul to the all mighty bool gods.

		self:Precache()
		self:UpdateModel()

		self:SetLastHurt(0)
		self:SetJumping( false )
		self:SetLastLand( CurTime() + 1 ) --prevent jumping after spawn
		self:SetLastTargetCheck( CurTime() )
		self:SetLastTargetChange( CurTime() )
		self.InAirTime = 0

		self.RepathTimeCheck = CurTime() + 2
		self.RepathTimeMod = 0

		--stuck prevetion
		self:SetLastPush( CurTime() )
		self:SetLastPostionSave( CurTime() )
		self:SetStuckAt( self:GetPos() )
		self:SetStuckCounter( 0 )
		self:SetTargetUnreachable(false)
		self:SetAttacking( false )
		self:SetStandingAttack( false )

		self:SetWandering(false)
		self.LastWanderTargetCheck = CurTime() + 0.75

		self.UseSequenceSpeed = true

		self.ShouldWalk = false
		self.ShouldCrawl = false

		self.CanBleed = true -- Theres some instances where a zombie shouldn't have blood... It can be a robot for all you know.
		self.AttackSimian = math.random(5) -- If you know you know.

		self.LastTurn = CurTime() + 1

		self.Climbing = false
		self.NextClimb = 0

		self.TestForBigJump = false 			-- Should the bot look for a nav square with a jump attribute to use for a big jump?
		self.BigJumpCooldown = CurTime() + 0.1 	-- How long the bot can wait before trying another big jump.
		self.BigJumpTime = 0 					-- The time a bot is currently jumping.

		self.ApproachBigJumpTime = 0
		self.FailedBigJumpApproach = false

		self.AttackRangeUpdate = 0
		self.FailedAttack = 0
		self.HeavyAttack = false

		self.LastStatusUpdate = 0
		self.LastSideStep = 0

		self.BarricadeArmReach = false
		self.BarricadeSide = false
		self.BarricadeTearing = false
		self.BarricadePosition = nil

		self.Barricade = nil
		self.BarricadePlankPull = nil

		self:SetWaterBuff( false )
		self:SetBomberBuff( false )

		--[[Gib Related]]--
		self.CanGib = true

		self:SetCrawler( false )
		self.LlegOff = false
		self.RlegOff = false
		--[[Gib Related]]--

		self.LastStun = CurTime() + 8 -- Cooldown in between stuns on the zombie
		self.IsBeingStunned = false -- Here so zobies don't stumble twice in a row... I hope.
		self.LastFlinch = CurTime() + 0.25 -- Cooldown in between flinches on the zombie.

		self.Dying = false -- To know if a zombie is currently dying.
		self.IsIdle = false

		self.SpawnProtection = true -- Zero Health Zombies tend to be created right as they spawn.
		self.SpawnProtectionTime = CurTime() + 1 -- So this is an experiment to see if negating any damage they take for a second will stop this.

		self.InLowGravZone = false -- Override that allows the zombies to use low gravity movement anims.

		-- [[ Zombie Chicken Taco ]] --
		self.ZCTPersonality = nil -- If ZCT is enabled, this determines the type of zombie it is.

		self.ZCTCloaked = false
		self.ZCTOrangeDash = false

		self.ZCTTraitActive = false
		self.ZCTTraitUpdate = CurTime() + 1
		self.ZCTTraitCoolDown = CurTime() + 1

		self:SetZCTFlameColor("")
		-- [[ Zombie Chicken Taco ]] --


		-- Say you have the Bot stop it's coroutine(Such as using a TempBehaveThread) and during that time, they move to a new position. During this, their path does not update. So you'd use this to generate a new one.
		self.CancelCurrentPath = false -- Tells the Bot to stop using it's current path and generate a new one. This bool will be set back to false once the new path is generated.

		self.LerpingToPos = false
		self.LerpPosition = false

		self:SetLastAttack( CurTime() )
		self:SetAttackRange( self.AttackRange )
		self:SetTraversalCheckRange( self.TraversalCheckRange )

		if nzMapping.Settings.range then
			self:SetTargetCheckRange(nzMapping.Settings.range)
			if nzMapping.Settings.range <= 0 or nzMapping.Settings.range > 60000 then
				self:SetTargetCheckRange(60000) -- A map can't go bigger than 60,000.
			end
		else
			self:SetTargetCheckRange(2000)
		end	-- 0 for no distance restriction (infinite)

		self:ResetIgnores()

		self:SetHealth( 75 )
		self:SetRunSpeed( self.RunSpeed )
		self:SetWalkSpeed( self.WalkSpeed )

		-- You should keep the Collisin Bounds as is for normal sized enemies.
		-- Use "SetSurroundingBounds" for your bot's hitbox detection.
		self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-32, -32, 0), Vector(32, 32, 74)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		self.ExtraTriggerBounds = Vector(24,24,2) 							-- Nextbots Modifier for defining the size of the collsion trigger.

		self:SetSpecialAnimation(false)
		self:SetSpecialShouldDie(false) -- Used for anims where the zombie reacts to something and they should die after the anim finishes. 
		self.CanCancelSpecial = false
		self:SetIsBusy(false) -- Used for shit like the barricades
		self.TraversalAnim = false

		self.IsTornado = false
		self.IsXbowSpinning = false
		self.IsTurned = false
		self.BecomeTurned = false

		self:SetShouldCount(true) -- Determines if the zombie should add to the amount killed for the round.

		self.SameSquare = true
		self.AttemptCutoff = false

		self:SetNextRetarget(0)
		self:SetFleeing(false)
		self:SetLastFlee(0)

		self.HasSTaunted = false -- Zombies should only ever Super Taunt once.
		self.ArmsUporDown = math.random(2)
		self.AttackIsBlocked = false
		self.CanCancelAttack = false -- Allows the nextbot to cancel their attack animation if their target is no longer in their attack range.
		self.CancelCurrentAction = false -- Set to true to force the nextbot to stop playing their current sequence.(Will reset back to false on its own once passed.)
		self.UseCustomAttackDamage = false -- If set to true, the nextbot will call a function that lets you modify the damage type a bot does.


		self.ThrowGuts = false -- Zombies will commence comedy and harm you with their guts.

		self.CurrentSeq = self.IdleSequence -- allows for the speed of the nextbot to updated automatically when using 1:1 movement speeds
		self.UpdateSeq = self.IdleSequence

		self.FacialGesture = "none" -- Name is pretty obvious.
		self.FacialUpdateTime = CurTime() + 0.1

		self:StatsInitialize()
		self:SpecialInit()
		--self:CreateTrigger() -- Moved to RunBehaviour

		self.Unstuckbound = 0

		if SERVER then

			self.loco:SetDeathDropHeight( self.DeathDropHeight )
			self.loco:SetDesiredSpeed( self:GetRunSpeed() )
			self.loco:SetAcceleration( self.Acceleration )
			self.loco:SetDeceleration( self.Deceleration )
			self.loco:SetJumpHeight( self.JumpHeight )
			self.loco:SetMaxYawRate( self.MaxYawRate )
			self.loco:SetGravity(self.Gravity)
			--self.loco:SetClimbAllowed( false )

			self.DesiredSpeed = self:GetRunSpeed()
			self:SpeedChanged()
			if GetConVar("nz_zombie_lagcompensated"):GetBool() then
				self:SetLagCompensated(true)
			end
			self.BarricadeJumpTries = 0

			self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
			self:SetIsAlive(true)

			self:SetTargetPriority(TARGET_PRIORITY_MONSTERINTERACT) -- This inserts the zombie into the target array.

			--[[ EYE TRAILS ]]--

			-- These look cool but will bring your game to it's knees if you got a pc of the wooden variety.
			local defaultColor = Color(255, 75, 0, 255)
			local eyeColor = !IsColor(nzMapping.Settings.zombieeyecolor) and defaultColor or nzMapping.Settings.zombieeyecolor
			local latt = self:LookupAttachment("lefteye")
			local ratt = self:LookupAttachment("righteye")

			local rand = math.Rand(0.1,0.25)
			if latt and ratt then
				if eyetrails ~= nil and eyetrails:GetInt() == 1 and !self.IsMooSpecial then
					if math.random(2) == 1 then
						self.spritetrail = util.SpriteTrail(self, latt, eyeColor, true, 5, 0, 0.2, 0.1, "effects/laser_citadel1.vmt")
						self.spritetrail2 = util.SpriteTrail(self, ratt, eyeColor, true, 5, 0, 0.2, 0.1, "effects/laser_citadel1.vmt")
					end
				end
			end
			--[[ EYE TRAILS ]]--

			-- [[ Christmas Hat ]]--
			if miricalday == true and math.random(100) < 1 and !self.xmas and !self.IsMooSpecial then

				local headpos = self:GetBonePosition(self:LookupBone("j_head"))

				if headpos then
					self.xmas = ents.Create("nz_prop_effect_attachment")
					self.xmas:SetPos(headpos)
					self.xmas:SetAngles(self:GetAngles() - Angle(90,0,0))
					self.xmas:SetParent(self, 2)
					self.xmas:SetModel("models/moo/holidays/xmas/santa_hat.mdl")
					self.xmas:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
					self.xmas:SetModelScale(0.99, 0)
					self.xmas:Spawn()

					self:DeleteOnRemove( self.xmas )
				end
			end
			-- [[ Christmas Hat ]]--

			--[[ Duck Floats ]]--
			if !self.IsMooSpecial and !self.IsMooBossZombie then

				if (nzGum.QuacknarokActive) then
					self.DUCKS = true
				end
				
				if !self.DUCKS then return end

	            self.quack = ents.Create("nz_prop_effect_attachment")
	            local mainroot = self:LookupBone("j_mainroot")

	            if !isnumber(mainroot) then return end

	            local pos = self:GetBonePosition(mainroot)

	            self.quack:SetPos(pos)
	            self.quack:SetAngles(self:GetAngles())
	            self.quack:SetParent(self, 9)
	            self.quack:SetModel("models/moo/_codz_ports_props/t8/zm_red/p8_zm_red_floatie_duck.mdl")
	            self.quack:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	            self.quack:SetModelScale(1, 0)
	            self.quack:Spawn()

	            self:DeleteOnRemove( self.quack )
	        end
			--[[ Duck Floats ]]--
		end
	end

	function ENT:SpecialInit() end
	
	function ENT:StatsInit() end

	function ENT:SpeedChanged()
		if self.SpeedBasedSequences then
			self:UpdateMovementSequences()
		end
	end

	function ENT:UpdateMovementSpeed() -- This is what allows zombies to use the movement speed from their movement anim as a posed to just using the one given to them by code.
		if !self.UseSequenceSpeed then return end -- Back out if the enemy wants use a set speed instead of the sequence speed.

		local speed = self:GetSequenceGroundSpeed( self:GetSequence() )
		self:SetRunSpeed( speed )
		self.loco:SetDesiredSpeed( self:GetRunSpeed() )

		self.loco:SetMaxYawRate( self.MaxYawRate + speed * 0.85 )
		self.DesiredSpeed = self:GetRunSpeed()

		return speed -- Return the speed incase we wanna check it later.
	end
end

function ENT:CreateTrigger()
	if CLIENT then return end

	self:RemoveTrigger()

	self.CollisionTrigger = ents.Create("nz_trigger")
	self.CollisionTrigger:SetPos(self:GetPos())
	self.CollisionTrigger:SetAngles(self:GetAngles())
	self.CollisionTrigger:SetParent(self, 0)

	-- No idea if this positioning will work for all entities, I know it works with Zombie, Nova Crawler, Panzer and Dogs.
	--local mini, maxi = self:GetSurroundingBounds()
	--local wtl = self:WorldToLocal(maxi) -- Have to make it local to the nextbot, other wise it returns a vector in the world space.

	local max = self:OBBMaxs() + (self.ExtraTriggerBounds or Vector(0,0,0))
	self.CollisionTrigger:SetLocalPos(Vector(-max[1] / 2, -max[2] / 2, 0))
	self.CollisionTrigger:SetMaxBound(max)

	self.CollisionTrigger:Spawn()

	self.ForcedCollisions = {}
	self.CollisionTrigger:ListenToTriggerEvent(function(event, ent)
		if event != "Touch" then return end
		if ent:IsPlayer() then return end

		if !self.ForcedCollisions[ent] or CurTime() > self.ForcedCollisions[ent] then
			local phys_obj = ent:GetPhysicsObject()
			
			-- Simulate PhysicsCollide if it's defined (So projectiles actually hit us)
			if ent.PhysicsCollide then
				self.ForcedCollisions[ent] = CurTime() - 0.1

				if !IsValid(phys_obj) then
					phys_obj = ent
				end

				local ent_speed = ent:GetVelocity():Length2D()
				local ents_dir = (ent:GetPos() - self:GetPos()):GetNormalized()

				ent:PhysicsCollide({ -- Simulate PhysicsCollide (This is what most projectiles rely on)
					["HitPos"] = ent:GetPos(),
					["HitEntity"] = self,
					["OurOldVelocity"] = ent:GetVelocity(),
					["TheirOldVelocity"] = self:GetVelocity(),
					["Speed"] = ent_speed, -- Is this right?
					["HitSpeed"] = ent_speed, -- Is this right?
					["DeltaTime"] = CurTime(), -- Is this right??
					["HitNormal"] = ents_dir
				}, phys_obj)
			end
		end
	end)

	return self.CollisionTrigger
end

function ENT:RemoveTrigger()
	if CLIENT then return end
	if IsValid(self:GetTrigger()) then
		self:GetTrigger():Remove()
	end
end

function ENT:GetTrigger()
	if CLIENT then return end
	return self.CollisionTrigger
end

function ENT:OnSpawn() end

if SERVER then
	-- Select a spawn sequence and sound to play. This is called after everything is initialized
	function ENT:SelectSpawnSequence()
		local s
		if self.SpawnSounds then s = self.SpawnSounds[math.random(#self.SpawnSounds)] end
		return type(self.SpawnSequence) == "table" and self.SpawnSequence[math.random(#self.SpawnSequence)] or self.SpawnSequence, s
	end

	-- Collide When Possible
	local collidedelay = 0.25
	local bloat = Vector(5,5,0)

	function ENT:Think()
		if (self:IsOnGround() and !self:GetJumping() and !self:GetSpecialAnimation() and !self:GetIsBusy() and !self:GetCrawler() 
		and self.SameSquare and self.loco:GetCurrentAcceleration():Length2D() < self:GetRunSpeed() and --[[self.loco:GetVelocity():Length2D() >= 125 and]] !nzPowerUps:IsPowerupActive("timewarp")) then -- Moo Mark
			local velocity = self:GetGroundSpeedVelocity()
			self.loco:SetVelocity(velocity)
        end
        if CurTime() > self.SpawnProtectionTime and self.SpawnProtection and !self.DisableSpawnProtection then
        	self.SpawnProtection = false
        	--print("Can be hurt")
        end
        if self:GetIsBusy() then
        	self.loco:SetAvoidAllowed(false)
        else
        	self.loco:SetAvoidAllowed(true)
        end

		if nzPowerUps:IsPowerupActive("timewarp") and !self.NZBossType and !self.IsMooBossZombie and !self.IsTurned and !self:GetSpecialAnimation() then -- eugh i know how to indente ougghhghhghghghhhghghghggh
			self.loco:SetDesiredSpeed(20)
		elseif !nzPowerUps:IsPowerupActive("timewarp") and self.loco:GetDesiredSpeed() ~= self:GetRunSpeed() and !self:IsZombSlowed() then
			self.loco:SetDesiredSpeed(self:GetRunSpeed())
		end

		if CurTime() > self.LastWanderTargetCheck and self:GetWandering() then
			self.LastWanderTargetCheck = CurTime() + 0.75
			for k,v in nzLevel.GetTargetableArray() do
				if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) and (self:GetRangeTo(v) <= 750 and self:IsFacingEnt(v) or self:GetRangeTo(v) <= 175) then
					self.CancelCurrentPath = true
					self.IsIdle = true
					self:SetWandering(false)
					self:RemoveTarget()
					self:Retarget()
				end
			end
		end

		if self:IsJumping() then
			if !self.HasCollisionDuringJump then
				self:SolidMaskDuringEvent(MASK_PLAYERSOLID, false) 
			end
			self.InAirTime = self.InAirTime + 0.1
		end

		if self.IsNZAlly and self:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT then
			self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end

		if self.DoCollideWhenPossible then
			if not self.NextCollideCheck or self.NextCollideCheck < CurTime() then
				local mins,maxs = self:GetCollisionBounds()
				local tr = util_tracehull({
					start = self:GetPos(),
					endpos = self:GetPos(),
					filter = self,
					mask = MASK_NPCSOLID,
					mins = mins - bloat,
					maxs = maxs + bloat,
					ignoreworld = true
				})

				local b = tr.Entity
				if !IsValid(b) then 
					self:SetSolidMask(MASK_NPCSOLID)
					self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
					self.DoCollideWhenPossible = nil
					self.NextCollideCheck = nil
				else
					self.NextCollideCheck = CurTime() + collidedelay
				end
			end
		end

		-- Moo Mark 6/21/24: Very experimental feature where the amount of enemies have a hand in affecting repath times. Hopefully this would reduce stress in calculating paths by a little when mass amounts of enemies are alive at one time.
		if CurTime() > self.RepathTimeCheck then
			self.RepathTimeMod = 0
			for k,v in nzLevel.GetZombieArray() do
				self.RepathTimeMod = self.RepathTimeMod + 0.05
				--print(self.RepathTimeMod)
			end
			self.RepathTimeCheck = CurTime() + 2
		end

		-- Zero Health Zombies tend to be created when they take damage as they spawn.
		-- Same thing as the RunBehaviour one, but is here incase the RunBehaviour finishes.
		if (self:IsAlive() or !self:IsAlive()) 
			and (self:Health() <= 0 and !self.Dying) then
			self:FakeKillZombie() -- YOU ARE DEAD, YOUR HP IS 0!!!! YA DEAD, YA DIED, YA BODY FELL TO PIECES!!!!!
			print("Zero Health Fucker located!!! YOU'RE DEAD, YOU DIED, YOUR BODY FELL TO PIECES!!!")
		end

		self:StuckPrevention()
		self:ZombieStatusEffects()

		self:RemoveAllDecals() -- Lol, Lmao even...

		if not self.NextSound or self.NextSound < CurTime() then
			self:Sound()
		end

		self:SleepingZombieThink()
		self:LerpThink()
		self:BigJumpThink()

		self:DebugThink()
		self:OnThink()
	end

	function ENT:SleepingZombieThink()

		if (CurTime() > self.LastWanderTargetCheck and self.IsENVZombie) then
			local radius = self.ENVZombieRadius
			if !isnumber(radius) then radius = 175 end

			self.LastWanderTargetCheck = CurTime() + 1.75
			for k,v in nzLevel.GetTargetableArray() do
				if (self.ENVZombieInstantAwake or IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) and (self:GetRangeTo(v) <= radius)) then
					self.CancelCurrentPath = true
					self.ENVZombieDisturbed = true
					self:RemoveTarget()
					self:Retarget()
				end
			end
		end
		if isstring(self.VignLoopAnimation) and (self.IsENVZombie or self.ENVZombieAwoken) then
			local spawn = self.ENVSpawnIndex
			self.loco:SetVelocity(Vector(0,0,0))
			if IsValid(spawn) then
				self:SetPos(spawn:GetPos())
				self:SetAngles(spawn:GetAngles())
			end
		end

	end
	
	function ENT:LerpThink()
		if !self.LerpingToPos then return end
		if !self.LerpPosition then return end
		if self.LerpingToPos and isvector(self.LerpPosition) then
			--print("Currently Lerping to Position.")
			self:SetPos(LerpVector( 1, self:GetPos(), self.LerpPosition ))
			if self:GetRangeSquaredTo(self.LerpPosition) <= 10^2 then
				self.LerpingToPos = false
			end
		end
	end

	function ENT:StuckPrevention()

		if (self.Big_Jump_area_start and !self.On_Big_Jump or !self:GetIsBusy() and !self:GetSpecialAnimation() and !self:GetAttacking()) and self:GetLastPostionSave() + 0.5 < CurTime() then
		--if (self.Big_Jump_area_start and !self.On_Big_Jump or !self:GetIsBusy() and !self:GetSpecialAnimation() and !self:GetAttacking()) then

			if (IsValid(self.Target) and self.Target:GetTargetPriority() == TARGET_PRIORITY_SPECIAL) or (self.IsENVZombie) then return end

			if self:GetPos() == self:GetStuckAt() then
				self:SetStuckCounter( self:GetStuckCounter() + 1)
			else
				self:SetStuckCounter( 0 )
			end

			-- Allowing the stuck prevention code to run while approaching a jump square allows us to back out of it if we're stuck trying to approach it.
			if self.Big_Jump_area_start and !self.On_Big_Jump then
				if nzNav.Reserved[self.Big_Jump_area_start:GetID()] and nzNav.Reserved[self.Big_Jump_area_start:GetID()] == self then
					nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
				end
				self.Big_Jump_area_start = nil
				self:SetBlockAttack(false)
				if self.current_speed then
					self.loco:SetDesiredSpeed(self.current_speed)
					self.current_speed = nil
				end
			end

			-- Code Credit: Sorell(From the Addon: PlayerModel Zombies)
			-- Teleports zombies to an open nav square using traces. Will respawn if the zombie is still stuck after 3 seconds.(Very aggressive but we'll see in future instances how this plays.)
	        if self:GetStuckCounter() > 1 and self:GetStuckCounter() < 8 then
	            
	            local rndpoint = self:GetPos() + VectorRand( -self.Unstuckbound, self.Unstuckbound )
	            rndpoint[ 3 ] = 0

	            local area = navmesh.GetNearestNavArea( rndpoint )

	            if IsValid( area ) then
	            	print(area)
	                
	                local closest = area:GetClosestPointOnArea( rndpoint )

	                local mins, maxs = self:GetCollisionBounds()
	                mins[ 1 ] = mins[ 1 ] - 2
	                mins[ 2 ] = mins[ 2 ] - 2
	                maxs[ 1 ] = maxs[ 1 ] + 2
	                maxs[ 2 ] = maxs[ 2 ] + 2

	                recycletracetbl.start = closest + Vector( 0, 0, 5)
	                recycletracetbl.endpos = closest + Vector( 0, 0, 5)
	                recycletracetbl.mins = mins
	                recycletracetbl.maxs = maxs
	                recycletracetbl.filter = self

	                local hulltest = util_tracehull( recycletracetbl )

	                debugoverlay.Box( closest + Vector( 0, 0, 5), mins, maxs, 5, Color( 255, 255, 255, 100 ) )

	                if !hulltest.Hit then

	                    self.Unstuckbound = 0

	                    self:SetPos( closest )
	                    
	                    self.loco:ClearStuck()
	                else
	                    self.Unstuckbound = self.Unstuckbound + 30
	                end
	            end
	        elseif self:GetStuckCounter() > 5 then
	        	self:RespawnZombie(true)
	        end


			--[[if self:GetStuckCounter() > 1 then

				local tr = util_tracehull({
					start = self:GetPos(),
					endpos = self:GetPos(),
					maxs = self:OBBMaxs(),
					mins = self:OBBMins(),
					filter = self
				})

				self:FleeTarget(1)

				if self:GetStuckCounter() > 5 then
					self:RespawnZombie()
					self:SetStuckCounter( 0 )
				end
			end]]

			self:SetLastPostionSave( CurTime() )
			self:SetStuckAt( self:GetPos() )
		end
	end

	function ENT:DebugThink()
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			local spacing = Vector(0,0,64)
			local target = self:GetTarget()
			if target then
				debugoverlay.Text( self:GetPos() + spacing, tostring(target), FrameTime() * 2 )
			else
				debugoverlay.Text( self:GetPos() + spacing, "NO_TARGET", FrameTime() * 2 )
			end
			spacing = spacing + Vector(0,0,8)
			local attacking = self:IsAttacking()
			if attacking then
				debugoverlay.Text( self:GetPos() + spacing, "IN_ATTACK", FrameTime() * 2 )
			elseif self:IsTimedOut() then
				debugoverlay.Text( self:GetPos() + spacing, "TIMED_OUT", FrameTime() * 2 )
			elseif target then
				debugoverlay.Text( self:GetPos() + spacing, "MOVING_TO_TARGET", FrameTime() * 2 )
			else
				debugoverlay.Text( self:GetPos() + spacing, "ERROR", FrameTime() * 2 )
			end
			spacing = spacing + Vector(0,0,8)
			debugoverlay.Text( self:GetPos() + spacing, "HitPoints: " .. tostring(self:Health()), FrameTime() * 2 )
			spacing = spacing + Vector(0,0,8)
			debugoverlay.Text( self:GetPos() + spacing, "Speed: " .. tostring(self:GetRunSpeed()), FrameTime() * 2 )
			spacing = spacing + Vector(0,0,8)
			debugoverlay.Text( self:GetPos() + spacing, tostring(self), FrameTime() * 2 )

			
			local minsB, maxsB = self:OBBMins(), self:OBBMaxs()
			local minsA, maxsA = self:GetSurroundingBounds()

			debugoverlay.Box( vector_origin, minsA, maxsA, 0.05, Color( 255, 0, 255, 1 ) )
		end
	end
end

------- Fields -------
ENT.SoundDelayMin = 5
ENT.SoundDelayMax = 6
ENT.BehindSoundDistance = 0 -- The distance to a target where we will play "behind sounds" instead (0 = disable). This requires ENT.BehindSounds to be set

function ENT:PlaySound(s, lvl, pitch, vol, chan, delay) --Moo Mark This part is a port of the nZu zombie base sound functions.
	local delay = delay or math.Rand(self.SoundDelayMin, self.SoundDelayMax)
	if s then
		--local dur = SoundDuration(s)
		self:EmitSound(s, lvl, pitch, vol, chan)
		--delay = delay + dur
	end
	self.NextSound = CurTime() + delay
end

function ENT:Sound()
	if self:GetAttacking() or !self:IsAlive() or self:IsDecapitated() or (self.IsENVZombie and !self.ENVZombieAwoken) then return end

	local vol = self.SoundVolume

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = self.SoundVolume end
	end

	if self.BehindSoundDistance > 0 -- We have enabled behind sounds
		and IsValid(self.Target)
		and self.Target:IsPlayer() -- We have a target and it's a player within distance
		and self:GetRangeTo(self.Target) <= self.BehindSoundDistance
		and (self.Target:GetPos() - self:GetPos()):GetNormalized():Dot(self.Target:GetAimVector()) >= 0 then -- If the direction towards the player is same 180 degree as the player's aim (away from the zombie)
			self:PlaySound(self.BehindSounds[math.random(#self.BehindSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2) -- Play the behind sound, and a bit louder!
	
	--[[ A big "if then" thingy for playing other sounds. ]]--
	elseif self.ElecSounds and (self.Stunned or self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning() or self.BeingDissolved) then
		self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif IsValid(self.Target) and self.Target.MonkeyBomb and self.MonkeySounds and !self.IsMooSpecial then
		if self.CustomMonkeySounds then
			self:PlaySound(self.CustomMonkeySounds[math.random(#self.CustomMonkeySounds)], vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		else
			self:PlaySound(self.MonkeySounds[math.random(#self.MonkeySounds)], vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		end
	elseif self:GetCrawler() and self.CrawlerSounds then
		self:PlaySound(self.CrawlerSounds[math.random(#self.CrawlerSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif (self:BomberBuff() or self.IsTurned ) and self.GasVox and !self.IsMooSpecial then
		self:PlaySound(self.GasVox[math.random(#self.GasVox)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif self.PassiveSounds then
		self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	else


		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end

-- Moo Mark 4/14/23: The function below this is one of two things I've found out about since using DrgBase for the first time and HOLY shit this function is useful.

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.

	self:CustomAnimEvent(a,b,c,d,e)

	if e == "step_left_small" and !self.OverrideLsmall then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 70, math.random(95,105))
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 70, math.random(95,105))
		end
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_right_small" and !self.OverrideRsmall then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 70, math.random(95,105))
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 70, math.random(95,105))
		end
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_left_large" and !self.OverrideLLarge then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 70)
		end
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_right_large" and !self.OverrideRLarge then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 70)
		end
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "crawl_hand" then
		if self.CustomCrawlImpactSounds then
			self:EmitSound(self.CustomCrawlImpactSounds[math.random(#self.CustomCrawlImpactSounds)], 70)
		else
			self:EmitSound(self.CrawlImpactSounds[math.random(#self.CrawlImpactSounds)], 70)
		end
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "melee_whoosh" then
		if self.CustomMeleeWhooshSounds then
			self:EmitSound(self.CustomMeleeWhooshSounds[math.random(#self.CustomMeleeWhooshSounds)], 80)
		else
			self:EmitSound(self.MeleeWhooshSounds[math.random(#self.MeleeWhooshSounds)], 80)
		end
	end
	if (e == "melee" or e == "melee_heavy") and !self.OverrideAttack then
		if self:BomberBuff() and self.GasAttack then
			self:PlaySound(self.GasAttack[math.random(#self.GasAttack)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		else
			if self.AttackSounds then
				self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			end
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end

	if e == "base_ranged_rip" then
		ParticleEffectAttach(self.Blood[self.BloodType].DismemberFX, 4, self, 5)
		self:EmitSound(self.GibSounds[math.random(#self.GibSounds)], 100, math.random(95,105))
	end
	if e == "base_ranged_throw" then
		self:EmitSound("nz_moo/zombies/fly/attack/gut_throw/throw/zmb_ai_meat_throw_00"..math.random(0,3)..".mp3", 95)

		local larmfx_tag = self:LookupBone("j_wrist_le")

		self.Guts = ents.Create("nz_proj_gib")
		self.Guts:SetPos(self:GetBonePosition(larmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			phys:SetVelocity(self.Guts:getvel(target:EyePos() - Vector(0,0,7), self:EyePos(), 0.95))
		end
	end

	if e == "base_ranged_rip_left" then
		local larmfx_tag = self:LookupBone("j_wrist_le")

		self:EmitSound("nz_moo/zombies/fly/attack/gut_throw/grab/zmb_ai_meat_grab_0"..math.random(0,3)..".mp3", 95)

		self.PropGut = ents.Create("nz_prop_effect_attachment")
		self.PropGut:SetModel("models/props_junk/watermelon01_chunk02a.mdl")
		self.PropGut:SetMaterial("models/flesh")
		self.PropGut:SetModelScale(1)
		self.PropGut:SetParent(self, 5)
		self.PropGut:SetPos(self:GetBonePosition(larmfx_tag))
		self.PropGut:SetAngles(self:GetAngles(larmfx_tag))
		self.PropGut:Spawn()

		ParticleEffect(self.Blood[self.BloodType].HeadGibFX,self:GetBonePosition(larmfx_tag),self:GetAngles(),nil) 
	end
	if e == "base_ranged_throw_left" then
		self:EmitSound("nz_moo/zombies/fly/attack/gut_throw/throw/zmb_ai_meat_throw_0"..math.random(0,3)..".mp3", 95)

		if self.PropGut then self.PropGut:Remove() end

		local larmfx_tag = self:LookupBone("j_wrist_le")

		self.Guts = ents.Create("nz_proj_gib")
		self.Guts:SetPos(self:GetBonePosition(larmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			phys:SetVelocity(self.Guts:getvel(target:WorldSpaceCenter() - Vector(0,0,0), self:EyePos(), 0.75))
		end
	end
	if e == "base_ranged_rip_right" then
		local rarmfx_tag = self:LookupBone("j_wrist_ri")

		self:EmitSound("nz_moo/zombies/fly/attack/gut_throw/grab/zmb_ai_meat_grab_0"..math.random(0,3)..".mp3", 95)

		self.PropGut = ents.Create("nz_prop_effect_attachment")
		self.PropGut:SetModel("models/props_junk/watermelon01_chunk02a.mdl")
		self.PropGut:SetMaterial("models/flesh")
		self.PropGut:SetModelScale(1)
		self.PropGut:SetParent(self, 6)
		self.PropGut:SetPos(self:GetBonePosition(rarmfx_tag))
		self.PropGut:SetAngles(self:GetAngles(rarmfx_tag))
		self.PropGut:Spawn()

		ParticleEffect(self.Blood[self.BloodType].HeadGibFX,self:GetBonePosition(rarmfx_tag),self:GetAngles(),nil) 
	end
	if e == "base_ranged_throw_right" then
		self:EmitSound("nz_moo/zombies/fly/attack/gut_throw/throw/zmb_ai_meat_throw_0"..math.random(0,3)..".mp3", 95)

		if self.PropGut then self.PropGut:Remove() end

		local rarmfx_tag = self:LookupBone("j_wrist_ri")

		self.Guts = ents.Create("nz_proj_gib")
		self.Guts:SetPos(self:GetBonePosition(rarmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			phys:SetVelocity(self.Guts:getvel(target:WorldSpaceCenter() - Vector(0,0,0), self:EyePos(), 0.75))
		end
	end

	if e == "pull_plank" then
		if IsValid(self) and self:IsAlive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
		end
	end
	if e == "anim_catalyst_start" then
		self:EmitSound(self.ZombieMutateSounds[math.random(#self.ZombieMutateSounds)], 85, math.random(95,105))
	end
	if e == "anim_catalyst_blood" then
		for i = 1, 5 do 
			ParticleEffect(self.Blood[self.BloodType].HeadGibFX,self:WorldSpaceCenter(),self:GetAngles(),nil) 
		end
		self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
		self:EmitSound(self.HeadGibSounds[math.random(#self.HeadGibSounds)], 100, math.random(95,105))
	end
	if e == "anim_catalyst_bloodsplosion" then
		for i = 1, 5 do 
			ParticleEffect(self.Blood[self.BloodType].HeadGibFX,self:WorldSpaceCenter(),self:GetAngles(),nil) 
		end
		self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
		self:EmitSound(self.HeadGibSounds[math.random(#self.HeadGibSounds)], 100, math.random(95,105))
	end
	if e == "bodyfall_light" then
		self:EmitSound(self.BodyfallLightSounds[math.random(#self.BodyfallLightSounds)], 85, math.random(95,105))
	end
	if e == "bodyfall_heavy" then
		self:EmitSound(self.BodyfallHeavySounds[math.random(#self.BodyfallHeavySounds)], 85, math.random(95,105))
	end

	if e == "death_ragdoll" and !self.OverrideDDoll then

		if IsValid(self.GibStumpHead) then self.GibStumpHead:Remove() end
		
		self:BecomeRagdoll(DamageInfo())
	end
	if e == "start_traverse" then
		--print("starttraverse")
		self.TraversalAnim = true
	end
	if e == "finish_traverse" then
		--print("finishtraverse")
		self.TraversalAnim = false
	end

	if e == "riser_death_low_v1" then
		self.RiserDeathAnimation = "nz_spawn_ground_v1_deathinside"
	end
	if e == "riser_death_high_v1" then
		self.RiserDeathAnimation = "nz_spawn_ground_v1_deathoutside"
	end
	if e == "riser_death_low_v2" then
		self.RiserDeathAnimation = "nz_spawn_ground_v2_deathinside"
	end
	if e == "riser_death_high_v2" then
		self.RiserDeathAnimation = "nz_spawn_ground_v2_deathoutside"
	end

	if e == "zombie_spawn_dust_sfx" then
		self:DoZombieSpawnDust()
	end

	if e == "env_zombie_awaken" then
		if self.TauntSounds then
			self:PlaySound(self.TauntSounds[math.random(#self.TauntSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
		if self.IsENVZombie then
			self:SetDecapitated(false)
		end
	end

	-- Taunt Sounds, theres alot of these

	if e == "elec_vox" then
		if self.ElecSounds then
			self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "generic_taunt" then
		if self.TauntSounds then
			self:PlaySound(self.TauntSounds[math.random(#self.TauntSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "special_taunt" then
		if self.CustomSpecialTauntSounds then
			self:PlaySound(self.CustomSpecialTauntSounds[math.random(#self.CustomSpecialTauntSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound("nz_moo/zombies/vox/_classic/taunt/spec_taunt.mp3", 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v1" then
		if self.CustomTauntAnimV1Sounds then
			self:PlaySound(self.CustomTauntAnimV1Sounds[math.random(#self.CustomTauntAnimV1Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV1Sounds[math.random(#self.TauntAnimV1Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v2" then
		if self.CustomTauntAnimV2Sounds then
			self:EmitSound(self.CustomTauntAnimV2Sounds[math.random(#self.CustomTauntAnimV2Sounds)], 100, math.random(85, 105), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV2Sounds[math.random(#self.TauntAnimV2Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v3" then
		if self.CustomTauntAnimV3Sounds then
			self:PlaySound(self.CustomTauntAnimV3Sounds[math.random(#self.CustomTauntAnimV3Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV3Sounds[math.random(#self.TauntAnimV3Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v4" then
		if self.CustomTauntAnimV4Sounds then
			self:PlaySound(self.CustomTauntAnimV4Sounds[math.random(#self.CustomTauntAnimV4Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV4Sounds[math.random(#self.TauntAnimV4Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v5" then
		if self.CustomTauntAnimV5Sounds then
			self:PlaySound(self.CustomTauntAnimV5Sounds[math.random(#self.CustomTauntAnimV5Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV5Sounds[math.random(#self.TauntAnimV5Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v6" then
		if self.CustomTauntAnimV6Sounds then
			self:PlaySound(self.CustomTauntAnimV6Sounds[math.random(#self.CustomTauntAnimV6Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV6Sounds[math.random(#self.TauntAnimV6Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v7" then
		if self.CustomTauntAnimV7Sounds then
			self:PlaySound(self.CustomTauntAnimV7Sounds[math.random(#self.CustomTauntAnimV7Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV7Sounds[math.random(#self.TauntAnimV7Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v8" then
		if self.CustomTauntAnimV8Sounds then
			self:PlaySound(self.CustomTauntAnimV8Sounds[math.random(#self.CustomTauntAnimV8Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV8Sounds[math.random(#self.TauntAnimV8Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "anim_taunt_v9" then
		if self.CustomTauntAnimV9Sounds then
			self:PlaySound(self.CustomTauntAnimV9Sounds[math.random(#self.CustomTauntAnimV9Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		else
			self:PlaySound(self.TauntAnimV9Sounds[math.random(#self.TauntAnimV9Sounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "remove_zombie" then
		self:Remove()
	end
end

-- Instead of making a copy of the function above, use this.
function ENT:CustomAnimEvent(a,b,c,d,e) 
	--[[
	-- Say you wanted to override some the existing events, use one of these bool below when doing so.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large
	self.OverrideAttack = true 		-- Overrides melee and melee_heavy
	self.OverrideDDoll = true 		-- Overrides death_ragdoll


	if e == "CUSTOM_EVENT_NAME(DEFINED IN MODELS QC)" then
		-- INSERT CODE HERE --
	end
	]]
end

if SERVER then

	
	function ENT:AI() end -- Called at the end of the RunBehaviour. Use this for additional abilities/functions an enemy may have.

	function ENT:PostAdditionalZombieStuff() end -- Called in the AdditionalZombieStuff func. Use this for enemies that closely mimic normal zombies.

	function ENT:TempBehaveThread(callback) -- Moo Mark 4/14/23: My little project with DrgBase showed me the light, like holy fuck...
		local CurrentThread = self.BehaveThread
		self.BehaveThread = coroutine.create(function()
			callback(self)
			self.BehaveThread = CurrentThread
		end)
	end

	function ENT:GetFleeDestination(target) -- Get the place where we are fleeing to
		return self:GetPos() + (self:GetPos() - target:GetPos()):GetNormalized() * (self.FleeDistance or 300)
	end

	function ENT:RunBehaviour()

		self:Retarget()
		self:SpawnZombie()
		self:CreateTrigger() -- Though this means the trigger isn't created until after the bot spawns... It does mean the Trigger's size is always correct.

		if isstring(self.RiserDeathAnimation) then self.RiserDeathAnimation = nil end

		while (true) do

			self:ZombieGestureSequences()

			if !self:GetStop() then
				if self.EventMask and not self.DoCollideWhenPossible then
					self:SetSolidMask(MASK_NPCSOLID)
				end

				-- Sleeping Zombie Logic(Wake up)
				if !self:GetStop() and self.IsENVZombie and self.ENVZombieDisturbed then

					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
					self:PlaySequenceAndMove(self.VignAwakeAnimation)
					self.DoCollideWhenPossible = true
					self:SetSpecialAnimation(false)
					if !isstring(self.VignLoopAnimation) then
						self.IsENVZombie = false
						self:SetShouldCount(true)
					else
						self.ENVZombieAwoken = true
					end
				end
				if !self:GetStop() and self.ENVZombieAwoken then
					self:TimeOut(666)
				end

				if !self:GetStop() and self:GetWandering() then
					self:MoveToPos(self:GetPos() + Vector(math.random(-512, 512), math.random(-512, 512), 0), {repath = 3, maxage = 5})
					if self:GetWandering() then
						self:TimeOut(math.Rand(2.25, 6.5))
					else
						self:TimeOut(0.1)
					end
				end
				if !self:GetStop() and self:GetFleeing() then -- Admittedly this was rushed, I took no time to understand how this can be achieved with nextbot pathing so I just made a short navmesh algorithm for fleeing. Sorry.
					local age = 3
					if self:GetStuckCounter() > 0 then age = 1 end

					self:SetTimedOut(false)

					local target = self:GetTarget()
					if IsValid(target) then
						self:SetLastFlee(CurTime())
						self:ResetMovementSequence() -- They'll comically slide away if this isn't here.
						self:MoveToPos(self:GetFleeDestination(target), {lookahead = 0, maxage = age})
						self:SetLastFlee(CurTime())
					end
				end
				if !self:GetFleeing() and !self:GetWandering() and !self.IsENVZombie and !self:GetStop() and CurTime() > self:GetLastFlee() + 0.25 then
					self:SetTimedOut(false)
					local ct = CurTime()
					if ct >= self.NextRetarget then
						local oldtarget = self.Target
						self:Retarget() --The overall process of looking for targets is handled much like how it is in nZu. While it may not save much fps in solo... Turns out this can vastly help the performance of multiplayer games.
					end
					if (!IsValid(self:GetTarget()) or !self:HasTarget()) then
						self:OnNoTarget()
					else
						if self:TargetInRange(250) then
							self:UpdateAttackRange()
						end

						local path = self:ChaseTarget()
						if path == "ok" then
							if self:TargetInAttackRange() then
								self:OnTargetInAttackRange()
							else
								self:TimeOut(0.1)
							end
						elseif path == "timeout" then
							self:OnPathTimeOut()
						else
							self:TimeOut(0.1)
						end
					end
				else
					self:TimeOut(0.1)
				end


				-- Zero Health Zombies tend to be created when they take damage as they spawn.
				if (self:IsAlive() or !self:IsAlive()) 
					and (self:Health() <= 0 and !self.Dying) then
					self:FakeKillZombie() -- YOU ARE DEAD, YOUR HP IS 0!!!! YA DEAD, YA DIED, YA BODY FELL TO PIECES!!!!!
					print("Zero Health Fucker located!!! YOU'RE DEAD, YOU DIED, YOUR BODY FELL TO PIECES!!!")
				end

				self:CheckForBigJump()

				self:AI()
				self:AdditionalZombieStuff()
			else
				self:TimeOut(0.1)
			end
		end
	end

	function ENT:TraversalCheck() end -- Just here so older enemies that still call this function don't error.

	function ENT:CheckForBigJump()
		if isnumber(self.GoalType) then
			local nav = navmesh.GetNearestNavArea(self:GetPos(), false, 15, false, true)
			if IsValid(nav) and self.GoalType >= 1 then
				if nav:HasAttributes(NAV_MESH_JUMP) and !self.Big_Jump_area_start and self.TestForBigJump and CurTime() > self.BigJumpCooldown then
					self.Big_Jump_area_start = nav
					nzNav.Reserved[nav:GetID()] = self
					self:SetBlockAttack(true)
					self:SetIsBusy(true)

					self.current_speed = self.loco:GetDesiredSpeed()
					self.loco:SetDesiredSpeed(self.loco:GetDesiredSpeed()*0.25)
				end
			end
		end
	end

	function ENT:ZombieStatusEffects()
		if CurTime() > self.LastStatusUpdate then

			if self.IsTurned or !self:IsAlive() then return end

			if !self.IsMooSpecial and !self.ShouldCrawl and !self.Big_Jump_area_start and (self.LlegOff or self.RlegOff) then -- Moved the crawler creation calls here because the zombie missing any of their legs should count.
				self.ShouldCrawl = true
				self:CreateCrawler()
			end

			if self:GetSpecialAnimation() and !self.CanCancelSpecial then return end	
			
			if self:GetCrawler() then
				if self.BO3IsCooking and self:BO3IsCooking() then
					--print("Uh oh Mario, I'm about to fucking inflate lol.")
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.CrawlMicrowaveSequences[math.random(#self.CrawlMicrowaveSequences)])
				end
				if self.BO4IsFrozen and self:BO4IsFrozen() or self.BO3IsSpored and self:BO3IsSpored() then
					--print("Uh oh Mario, I'm frozen lol.")
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.CrawlFreezeDeathSequences[math.random(#self.CrawlFreezeDeathSequences)])
				end
			else
				if self.BO3IsSlipping and self:BO3IsSlipping() and !self.IsTurned then
					--print("Uh oh Luigi, I've been played for a fool lol.")
					self:DoSpecialAnimation(self.SlipGunSequences[math.random(#self.SlipGunSequences)])
				end
				if self.BO3IsPulledIn and self:BO3IsPulledIn() and !self.IsTurned then
					--print("Uh oh Mario, I'm getting pulled to my doom lol.")
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.IdGunSequences[math.random(#self.IdGunSequences)])
				end
				if self.BO3IsSkullStund and self:BO3IsSkullStund() and !self.IsTurned then
					--print("Uh oh Mario, I'm ASCENDING lol.")
					self:DoSpecialAnimation(self.SoulDrainSequences[math.random(#self.SoulDrainSequences)])
				end
				if self.BO3IsCooking and self:BO3IsCooking() and !self.IsTurned then
					--print("Uh oh Mario, I'm about to fucking inflate lol.")
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.MicrowaveSequences[math.random(#self.MicrowaveSequences)])
				end
				if (self.BO3IsSpored and self:BO3IsSpored() or self.BO4IsFrozen and self:BO4IsFrozen()) and !self:GetSpecialAnimation() and !self.IsTurned then
					--print("Uh oh Mario, I'm frozen lol.")
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.FreezeSequences[math.random(#self.FreezeSequences)])
				end
				if self.BO4IsShrunk and self:BO4IsShrunk() and !self.IsTurned then
					self:DoSpecialAnimation(self.ShrinkSequences[math.random(#self.ShrinkSequences)])
				end
				if self.BO4IsTornado and self:BO4IsTornado() and !self.IsTurned then
					self:SetSpecialShouldDie(true)
					if !self.IsTornado then
						self:DoSpecialAnimation("nz_alistairs_tornado_lift")
						self.IsTornado = true
					end
				end
				if self.BO4IsSpinning and self:BO4IsSpinning() and !self.IsTurned then
					self:SetSpecialShouldDie(true)
					if !self.IsXbowSpinning then
						self:DoSpecialAnimation("nz_dth_ww_xbow_intro")
						self.IsXbowSpinning = true
					end
				end
				if self.IsAATTurned and self:IsAATTurned() then
					if self.IsTurned then -- TURNED
						if !self.BecomeTurned then
							self:SetRunSpeed(200)
							self:SpeedChanged()
							self:Retarget()
							self:TimeOut(0.2)
							self.BecomeTurned = true
							self.CanCancelAttack = true
						end
					else -- TURNT
						local seq = self.DanceSequences[math.random(#self.DanceSequences)]
						if self:HasSequence(seq) then
							self:PlaySound(self.DanceSounds[math.random(#self.DanceSounds)], 511, 100, 1, 2)
							self.NextSound = CurTime() + 30
							self:DoSpecialAnimation(seq)
						end
					end
				end
				if self.IsATTCryoFreeze and self:IsATTCryoFreeze() and !self.IsTurned then 
					self:SetSpecialShouldDie(true)
					self:DoSpecialAnimation(self.IceStaffSequences[math.random(#self.IceStaffSequences)])
				end
			end
			self.LastStatusUpdate = CurTime() + 0.25
		end
	end

	-- ulx luarun "Entity(1):GetEyeTrace().Entity:ATTCryoFreeze(3, Entity(1), Entity(1):GetActiveWeapon())"
	-- ulx luarun "Entity(1):GetEyeTrace().Entity:AATTurned(10, Entity(1), true)"
	--  
	-- ulx luarun "Entity(1):GetEyeTrace().Entity:BO4Tornado(5, Entity(1), Entity(1):GetActiveWeapon())"

	function ENT:AdditionalZombieStuff()
		
		self:PostAdditionalZombieStuff()

		if self:GetSpecialAnimation() or self.IsENVZombie or self.IsMooSpecial or self.IsTurned then return end
		if self:IsAlive() and self:Health() <= 0 then return end

		if self.BO4IsToxic and self:BO4IsToxic() then
			self:SetRunSpeed(1)
			self:SpeedChanged()
			self:FleeTarget(3)
		end

		-- Feature returns in the form of a map setting.
		if tobool(nzMapping.Settings.supertaunting) == true then
			if !self.HasSTaunted and !self:GetCrawler() and self:GetRunSpeed() < 60 and math.Rand(2.5, 100) <= 3.5 then
				self.NextSound = CurTime() + self.SoundDelayMax
				self.HasSTaunted = true
				self:DoSpecialAnimation(self.SuperTauntSequences[math.random(#self.SuperTauntSequences)])

				self:SetRunSpeed(36)
				self:SpeedChanged()
			end
		end
		if self:GetRunSpeed() < 145 and !self.IsMooSpecial and nzRound:InProgress() and nzRound:GetNumber() >= 4 and !nzRound:IsSpecial() and nzRound:GetZombiesKilled() >= nzRound:GetZombiesMax() - tonumber(nzMapping.Settings.lastzombiesprint) then
			if self:GetCrawler() then return end
			self.LastZombieMomento = true
		end
		if self.LastZombieMomento and !self:GetSpecialAnimation() --[[and !self.ZCTGiveGreenStats]] then
			--print("Uh oh Mario, I'm about to beat your fucking ass lol.")
			self.LastZombieMomento = false
			self:SetRunSpeed(100)
			self:SpeedChanged()
		end
        if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() and self.IsIdle then
			-- THAT FUCKER GOT THEM FAKE J'S ON!!!
			self.IsIdle = false
			if self:GetCrawler() then return end
			if self:IsAttackBlocked() then return end
			if self:GetRunSpeed() > 0 then
				local seq = self.ReactTauntSequences[math.random(#self.ReactTauntSequences)]
        		local normal = (self:GetPos() - self:GetTarget():GetPos()):GetNormalized()
				local fwd = self:GetForward()
				local right = self:GetRight()
				local dot = fwd:Dot(normal)
				local dot2 = right:Dot(normal)

				-- This looks like dog water, but until I can find a better way to write this... This is how it'll stay.

				--The zombie will turn to face the general direction their new target is in... If they aren't walking.
				if dot2 < -0.5 and dot >= -0.5 then
        			seq = self.NormalRightReactSequences[math.random(#self.NormalRightReactSequences)]
				elseif dot2 > 0.5 and dot <= 0.5 then
        			seq = self.NormalLeftReactSequences[math.random(#self.NormalLeftReactSequences)]
				else
        			if dot < 0 then
        				seq = self.NormalForwardReactSequences[math.random(#self.NormalForwardReactSequences)]
        			else
        				seq = self.NormalBackwardReactSequences[math.random(#self.NormalBackwardReactSequences)]
        			end
        		end
				if self:SequenceHasSpace(seq) then
					self:DoSpecialAnimation(seq, true, true)
				end
        	else
				self:DoSpecialAnimation(self.ReactTauntSequences[math.random(#self.ReactTauntSequences)], true, true)
			end
        end
		if nzMapping.Settings.zct == 1 then
			self:ZCTAbilities()
		end
		if nzMapping.Settings.mutated == 1 then
			-- Why does Time Warp cause Catalysts to experience mass Mitosis?
			if nzPowerUps:IsPowerupActive("timewarp") then return end
			if self.MutatedType and isstring(self.MutatedType) then
				local evilperson = ents.Create(self.MutatedType)
				local pos = self:GetPos()
				local ang = self:GetAngles()
				evilperson:SetPos(pos)
				evilperson:SetAngles(ang)
				evilperson:Spawn()
				evilperson.SpawnedFromZombie = true

				self:DoSpecialAnimation("nz_zombie_transform_into_catalyst")
			end
		end
		if nzMapping.Settings.sidestepping == 1 then -- Commence thy tomfoolery.
			if self:GetCrawler() then return end -- But not if you're a cripple :man_in_manual_wheelchair:
			if !self:IsAimedAt() then return end
			if self.IsMooBossZombie or self.NZBossType then return end
			if nzPowerUps:IsPowerupActive("timewarp") then return end -- OR! If Time Distortion:tm: is active

			if self:TargetInRange(500) and !self.AttackIsBlocked and math.random(15) <= 10 and CurTime() > self.LastSideStep then
				if !self:IsFacingEnt(self:GetTarget()) then return end
				if !self:IsAimedAt() then return end
				if self:TargetInRange(70) then return end
				if self:GetRunSpeed() > 200 then return end
				if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
					local seq = self.SideStepSequences[math.random(#self.SideStepSequences)]
					-- By default, try to sidestep.


					if !self:SequenceHasSpace(seq) then
						seq = self.DodgeRollSequences[math.random(#self.DodgeRollSequences)]
						-- Only roll if there isn't space for a sidestep.
					end
						
					if self:SequenceHasSpace(seq) and self:LookupSequence(seq) > 0 then
						self:DoSpecialAnimation(seq, true, true)
						-- If there isn't space at all, don't dodge.
					end
					self.LastSideStep = CurTime() + 3
				end
			end
		end
		if IsValid(self.Target) and self.Target:IsPlayer() then
			
			local nav = navmesh.GetNearestNavArea(self:GetTarget():GetPos(), false, 65, false, true, -2) -- Check for a nav square, if theres one near by.
			local ply = self.Target:IsOnGround() -- Also make sure the target is on the ground. People who are in the air are probably falling, diving with phd, or are trying to be an action hero. So we don't wanna accidentally think they're unreachable because of that.

			if IsValid(nav) then
				self.ThrowGuts = false -- If theres a nav found then we stop or do nothing.
			else
				if ply and !self:IsAttackBlocked() then -- Otherwise, if the target is no where near a nav square and is on the ground...
					self.ThrowGuts = true -- THROW SHIT AT THEM
				end
			end

			if self.ThrowGuts then
				self:TempBehaveThread(function(self)
					if self:GetCrawler() then
						self:SetSpecialAnimation(true)
						self:PlaySequenceAndMove("nz_base_attack_crawl_ranged_react_right_01", 1, self.FaceEnemy)
						self:PlaySequenceAndMove("nz_base_attack_crawl_ranged_throw_right_01", 1, self.FaceEnemy)
						self:SetSpecialAnimation(false)
					else
						self:SetSpecialAnimation(true)
						self:PlaySequenceAndMove(self.TomatoThrowSequences[math.random(#self.TomatoThrowSequences)], 1, self.FaceEnemy)
						self:SetSpecialAnimation(false)
					end
				end)
			end
		end
	end

	function ENT:BurningInit()
		if nzMapping.Settings.burning == 1 then
			if self.IsMooSpecial or self.IsMooBossZombie or self.NZBossType or self.IsCatalyst then return end
			if !self.ZombieIgnited then
				local roll = math.Rand(0, 100)

				local rndprog = nzRound:InProgress()
				local rndnumb = nzRound:GetNumber()

				local chance = nzMapping.Settings.burningchance
				local rnd = nzMapping.Settings.burningrnd

				if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
					self:Flames(true)
				end
			end
		end
	end

	function ENT:CatalystInit()
		if nzMapping.Settings.mutated == 1 then
			if self.IsMooSpecial or self.IsMiniBoss or self.IsMooBossZombie or self.NZBossType or self.IsCatalyst then return end

			if !self.SetMutatedZombie then

				local catalysttype = math.random(4)
				local roll = math.Rand(0,100)

				local rndprog = nzRound:InProgress()
				local rndnumb = nzRound:GetNumber()

				local chosentype
				local catalyst

				local CatalystTbl = {
					[1] = function(round)
						chance = nzMapping.Settings.poisonchance
						rnd = nzMapping.Settings.poisonrnd
						catalyst = "nz_zombie_special_catalyst_decay"
						
						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return catalyst
						else
							return false
						end
					end, 
					[2] = function(round)
						chance = nzMapping.Settings.electricchance
						rnd = nzMapping.Settings.electricrnd
						catalyst = "nz_zombie_special_catalyst_electric"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return catalyst
						else
							return false
						end
					end, 
					[3] = function(round)
						chance = nzMapping.Settings.firechance
						rnd = nzMapping.Settings.firernd
						catalyst = "nz_zombie_special_catalyst_plasma"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return catalyst
						else
							return false
						end
					end, 
					[4] = function(round)
						chance = nzMapping.Settings.waterchance
						rnd = nzMapping.Settings.waterrnd
						catalyst = "nz_zombie_special_catalyst_water"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return catalyst
						else
							return false
						end
					end, 
				}

				chosentype = CatalystTbl[catalysttype](catalyst)

				if isstring(chosentype) then
					self.MutatedType = chosentype
					self.SetMutatedZombie = true
				end
			end
		end
	end

	-- [[ Zombie Chicken Taco(ZCT) ]] --

	function ENT:ZCTInit()

		-- [[ Zombie Chicken Taco(ZCT) ]] --
		if nzMapping.Settings.zct == 1 then
			if !self.SetZCTacoZombie then
				if self.BlockZCTAbility or self.IsMooSpecial or self.IsMooBossZombie or self.IsCatalyst or self.NZBossType then return end

				local zcttype = math.random(0,5)
				local roll = math.Rand(0,100)

				local possibletype
				local particle

				local rndprog = nzRound:InProgress()
				local rndnumb = nzRound:GetNumber()

				local ZCTTbl = {
					[0] = function(round) -- Red(Heavy Hitter)
						chance = nzMapping.Settings.redchance
						rnd = nzMapping.Settings.redrnd
						particle = "zmb_zct_fire_red"
						
						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					[1] = function(round) -- Blue(Phaze Shifter)
						chance = nzMapping.Settings.bluechance
						rnd = nzMapping.Settings.bluernd
						particle = "zmb_zct_fire_blue"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					[2] = function(round) -- Yellow(Teleporter)
						chance = nzMapping.Settings.yellowchance
						rnd = nzMapping.Settings.yellowrnd
						particle = "zmb_zct_fire_yellow"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					[3] = function(round) -- Purple(Hybrid)
						chance = nzMapping.Settings.purplechance
						rnd = nzMapping.Settings.purplernd
						particle = "zmb_zct_fire_purple"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					[4] = function(round) -- Green(Slowey)
						chance = nzMapping.Settings.greenchance
						rnd = nzMapping.Settings.greenrnd
						particle = "zmb_zct_fire_green"
						
						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					[5] = function(round) -- Pink(Resistance)
						chance = nzMapping.Settings.pinkchance
						rnd = nzMapping.Settings.pinkrnd
						particle = "zmb_zct_fire_pink"

						if roll < chance and rndprog and (rndnumb >= rnd and rnd ~= -1 or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, 
					--[[[6] = function(round) -- Orange(Flash)
						speedmin = 135
						speedmax = -1
						particle = "zmb_zct_fire_orange"

						if roll < chance and rndprog and (rndnumb >= rnd or nzElec:IsOn() and rnd == -1) then
							return particle
						else
							return false
						end
					end, ]]
				}

				possibletype = ZCTTbl[zcttype](particle)

				if isstring(possibletype) then
					self:SetZCTFlameColor(possibletype)
					self.ZCTPersonality = zcttype
					self.SetZCTacoZombie = true


					if self.ZCTPersonality == 0 then
						if !self.ZCTGiveRedStats then
							self.ZCTGiveRedStats = true

							self:SetHealth( self:Health() * 2.25 )

							self.AttackDamage = 50
							self.HeavyAttackDamage = 90
						end
					end
					if self.ZCTPersonality == 1 then
						if !self.ZCTGiveBlueStats then
							self.ZCTGiveBlueStats = true

							self:SetHealth( self:Health() * 2 )
						end
					end
					if self.ZCTPersonality == 2 then
						if !self.ZCTGiveYellowStats then
							self.ZCTGiveYellowStats = true

							self:SetHealth( self:Health() * 1.2 )
						end
					end
					if self.ZCTPersonality == 4 then
						if !self.ZCTGiveGreenStats then
							self.ZCTGiveGreenStats = true

							self:SetHealth( self:Health() * 4 )
							self:SetRunSpeed(1)
							self:SpeedChanged()
						end
					end
					if self.ZCTPersonality == 5 then
						if !self.ZCTGivePinkStats then
							self.ZCTGivePinkStats = true

							self:SetHealth( self:Health() * 1.15 )
						end
					end
					if self.ZCTPersonality == 6 then
						if !self.ZCTGiveOrangeStats then
							self.ZCTGiveOrangeStats = true

							self:SetHealth( self:Health() * 0.5 )
							if self:GetRunSpeed() < 100 then
								self:SetRunSpeed(71)
								self:SpeedChanged()
							end

							self.AttackDamage = 25
							self.HeavyAttackDamage = 35
						end
					end
				end

			end
		end
	end

	function ENT:ZCTAbilities()
		if CurTime() > self.ZCTTraitUpdate then
			local target = self.Target
			if !IsValid(target) then return end

			if !isnumber(self.ZCTPersonality) then return end

			local hybridchoice = math.random(2)
			local traitchance = math.random(100)

			if hybridchoice == 2 and self.ZCTTraitActive then
				hybridchoice = 1
			end

			-- Cloak --
			if CurTime() > self.ZCTTraitCoolDown and hybridchoice == 1 then
				self:ZCTPhazeShift()
			end

			-- Teleport --
			if CurTime() > self.ZCTTraitCoolDown and hybridchoice == 2 and !self:TargetInRange(415) and !self.ZCTTraitActive and (self.ZCTPersonality == 2 or self.ZCTPersonality == 3)  then
				self:ZCTTeleport()
			end

			-- Flash --
			if CurTime() > self.ZCTTraitCoolDown then
				self:ZCTFlashAction()
			end

			self.ZCTTraitUpdate = CurTime() + 1
		end
	end

	function ENT:ZCTPhazeShift()
		if self.ZCTPersonality == 1 or self.ZCTPersonality == 3 then
			if !self.ZCTTraitActive and !self.ZCTCloaked then

				self.ZCTCloaked = true
				self.ZCTTraitActive = true
				self:SetMaterial( "invisible" )

				self:EmitSound("nz_moo/effects/zct_phaze.mp3", 90)
				ParticleEffect("bo3_dg4_slam_glow",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
				ParticleEffect("bo3_dg4_slam_distort",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
			elseif self.ZCTTraitActive and self.ZCTCloaked then
				self.ZCTCloaked = false
				self.ZCTTraitActive = false
				self:SetMaterial( "" )

				self:EmitSound("nz_moo/effects/zct_phaze.mp3", 90)
				ParticleEffect("bo3_dg4_slam_glow",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
				ParticleEffect("bo3_dg4_slam_distort",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
			end
			self.ZCTTraitCoolDown = CurTime() + math.Rand(1, 4)
		end
	end

	function ENT:ZCTTeleport()
		local target = self.Target
		if self:IsAttackBlocked() or !target:IsPlayer() or !IsValid(target) then return end
		local pos = self:FindSpotBehindPlayer(target:GetPos(), 15, 85)
		local prepos = self:GetPos()

		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

		self:SetPos(pos)

		self:EmitSound("nz_moo/effects/zct_teleport.mp3", 90)	
		ParticleEffect("bo3_jgb_impact",prepos+Vector(0,0,5),self:GetAngles(),self)
		ParticleEffect("bo3_scavenger_explosion_fade",prepos+Vector(0,0,5),self:GetAngles(),self)

		ParticleEffect("bo3_jgb_impact",pos+Vector(0,0,5),self:GetAngles(),self)
		ParticleEffect("bo3_scavenger_explosion_fade",pos+Vector(0,0,5),self:GetAngles(),self)

		self:CollideWhenPossible()
		self.ZCTTraitCoolDown = CurTime() + math.Rand(3, 12)
	end

	function ENT:ZCTFlashAction()
		if self.ZCTPersonality == 6 then
			if self:GetCrawler() then return end -- But not if you're a cripple :man_in_manual_wheelchair:
			if !self:IsAimedAt() then return end
			if nzPowerUps:IsPowerupActive("timewarp") then return end -- OR! If Time Distortion:tm: is active

			if self:TargetInRange(750) and !self.AttackIsBlocked and CurTime() > self.ZCTTraitCoolDown then
				if !self:IsFacingEnt(self:GetTarget()) then return end
				if !self:IsAimedAt() then return end
				if self:TargetInRange(70) then return end
				if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
					local seq = self.ZCTDodgeSequences[math.random(#self.ZCTDodgeSequences)]
					-- By default, try to sidestep.
		
					if !self:SequenceHasSpace(seq) then
						seq = self.DodgeRollSequences[math.random(#self.DodgeRollSequences)]
						-- Only roll if there isn't space for a sidestep.
					end
							
					if self:SequenceHasSpace(seq) and self:LookupSequence(seq) > 0 then
						self:DoSpecialAnimation(seq, true, true)
						-- If there isn't space at all, don't dodge.
						self.ZCTTraitCoolDown = CurTime() + math.Rand(0.5, 2.75)	
					end
				end
			end
		end
	end

	-- [[ Zombie Chicken Taco(ZCT) ]] --


	function ENT:PlayTurnAround( goal )
		
		if goal and CurTime() > self.LastTurn and !self:GetCrawler() then

			local pos = goal.pos
			local seq = "nil"
        	local normal = (self:GetPos() - pos):GetNormalized()
			local fwd = self:GetForward()
			local dot = fwd:Dot(normal)

			--PrintTable(goal)
			--print(goal.pos)

			local range = self:GetRangeTo(pos)

			--if range <= 100 and range > self.AttackRange then
			if range > self.AttackRange + 75 then
				--print(dot)
        		if dot > 0.5 then
        			if self:GetRunSpeed() < 140 then
        				if self.CustomSlowTurnAroundSequences then
        					seq = self.CustomSlowTurnAroundSequences[math.random(#self.CustomSlowTurnAroundSequences)]
        				else
        					seq = "nz_walk_turn_180_r"
        				end
        			else
        				if self.CustomFastTurnAroundSequences then
        					seq = self.CustomFastTurnAroundSequences[math.random(#self.CustomFastTurnAroundSequences)]
        				else
        					seq = "nz_sprint_turn_180_r"
        				end
        			end
        		end
				if self:HasSequence(seq) and self:SequenceHasSpace(seq) then
					self:DoSpecialAnimation(seq, true, true)
					self.LastTurn = CurTime() + 5
				end
			end
		end
	end

	function ENT:DissolveEffect() -- Places a disintegration effect on us
		local e = 0
		local dissolver

		self:SetName( "nz_rb655_dissolve" .. e )

		if ( !IsValid( dissolver ) ) then
			dissolver = ents.Create( "env_entity_dissolver" )
			dissolver:SetPos( self:GetPos() )
			dissolver:Spawn()
			dissolver:Activate()
			dissolver:SetKeyValue( "magnitude", 100 )
			dissolver:SetKeyValue( "dissolvetype", 0 )
		end
		dissolver:Fire( "Dissolve", "nz_rb655_dissolve" .. e )

		timer.Create( "nz_rb655_ep_cleanupDissolved", 60, 1, function()
			if ( IsValid( dissolver ) ) then dissolver:Remove() end
		end )

		e = e + 1

		local effect = EffectData()
		effect:SetScale(1)
		effect:SetMagnitude(1)
		effect:SetScale(3)
		effect:SetRadius(1)
		effect:SetStart(self:GetPos())
		effect:SetOrigin(self:GetPos())
		effect:SetEntity(self)
		effect:SetMagnitude(100)
		util.Effect("TeslaHitboxes", effect)

		self:EmitSound("ambient/energy/spark" .. math.random(1, 6) .. ".wav")


		if !self.BeingDissolved then
			self.BeingDissolved = true
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		local attacker = dmginfo:GetAttacker()
		local inflictor = dmginfo:GetInflictor()

		local dmgtype = dmginfo:GetDamageType()

		local hitpos = dmginfo:GetDamagePosition()
		local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
		local hitforce = dmginfo:GetDamageForce()

		if (self.SpawnProtection) and !self.BeingNuked then
			dmginfo:ScaleDamage(0) -- Stop zombies from taking damage if they're being spawnprotected.
			return 				   -- A humble surprise is that this seems to stop Zero Health Zombies from appearing like 90% of the time. I'm being optimistic with the 90%.
		end

		if self.ResistWW and !self.BeingNuked and !nzPowerUps:IsPowerupActive("insta") then
			-- This may anger god but we shall see...
			if inflictor and inflictor.NZWonderWeapon then
				dmginfo:ScaleDamage(self.WWResistDamage)
				self:OnResistWonderWeapon(dmginfo)
			end
		end

		if self.ZCTCloaked and !self.BeingNuked and !nzPowerUps:IsPowerupActive("insta") then
			dmginfo:ScaleDamage(0.25)
		end

		if self.ZCTGivePinkStats and !self.BeingNuked and !nzPowerUps:IsPowerupActive("insta") then
			if inflictor and inflictor.NZWonderWeapon then
				dmginfo:ScaleDamage(self.WWResistDamage)
			else
				dmginfo:ScaleDamage(1.5)
			end
		end

		if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_BURN, DMG_SLOWBURN)) ~= 0 and (!self.IsMooBossZombie and !self.NZBossType) then
			-- Zombies will handle taking flame damage themselves. It allows for them to always be killed.
			if attacker and inflictor then -- This is how 3arc made the Flamethower always kill, by doing damage with the Zombie's max health * numbers 0.1 to 0.15
				self:TakeDamage(self:GetMaxHealth() * math.Rand(0.1, 0.15), attacker, inflictor) -- Granted this changes depending on the round in the actual game, I just included the multipliers that are used past round 11.
			end
		end

		if dmginfo:GetDamage() == 75 and dmginfo:IsDamageType(DMG_MISSILEDEFENSE) and !self:GetSpecialAnimation() and !self.IsENVZombie then
			local seq = self.ThunderGunSequences[math.random(#self.ThunderGunSequences)]
			--print("Uh oh Luigi, I'm about to commit insurance fraud lol.")
			if --[[!self.IsMooSpecial]] self:HasSequence(seq) then
				self:DoSpecialAnimation(seq)
			end
			if inflictor and inflictor:GetClass() == "nz_zombie_boss_hulk" then dmginfo:ScaleDamage(0) return end
		end

		if IsValid(self) and !self.IsMooSpecial then
			local lowhealthpercent = (self:Health() / self:GetMaxHealth()) * 100 -- Copied one of 3arcs many checks for head gibbing.
			local head = self:LookupBone("j_head")
			local headpos
			
			if head then 
				headpos = self:GetBonePosition(head)
			else
				headpos = self:EyePos() 
			end
			

			if lowhealthpercent <= 10 and !self:IsDecapitated() then
				if (hitpos:DistToSqr(headpos) < 15^2) then -- Only do the check if the lowhealthpercent check goes through.
					self:GibHead()
				end
			end
		end

		self:PostTookDamage(dmginfo)

		self:SetLastHurt(CurTime())
	end

	function ENT:PostTookDamage(dmginfo) end -- Use this if you want things to happen after the enemy takes damage.

	function ENT:OnResistWonderWeapon(dmginfo) end -- Use this if the enemy can resist Wonder Weapons.(This is called upon them taking WW damage.)

	function ENT:Stop()
		self:SetStop(true)
		self:SetTarget(nil)
	end

	function ENT:SpawnZombie()
		-- BAIL if no navmesh is near

		-- 3/3/24: THE FUCKING MARCH UPDATE MAKES THE GAME CRASH IF THE NEXTBOT ISN'T ON A NAVSQUARE UPON SPAWNING!!!
		--[[local nav = navmesh.GetNearestNavArea( self:GetPos() )
		if !IsValid(nav) or nav:GetClosestPointOnArea( self:GetPos() ):DistToSqr( self:GetPos() ) >= 10000 then
			ErrorNoHalt("Zombie ["..self:GetClass().."]["..self:EntIndex().."] spawned too far away from a navmesh! (at: " .. tostring(self:GetPos()) .. ")")
			self:RespawnZombie()
		end]]

		-- EXAMPLE TABLE, Put in your enemies lua in "if CLIENT then (PUT HERE!!!) return end"
		-- You could also use this for materials other than eyes of course, thats just it's main purpose.
		--[[
			ENT.EyeColorTable = {
				[0] = Material("models/moo/codz/t4_zombies/common/mtl_char_ger_nazizombie_eyes.vmt"),
			}
		]]

		--[[ SPAWN ANIMATION ]]--

		local seq = self:SelectSpawnSequence()

		local spawn -- Get the spawn
		local animation -- Final selection
		local spawnanimtype = 0

		local dirt
		local gravity

		local types = {
			["nz_spawn_zombie_normal"] = true,
			["nz_spawn_zombie_special"] = true,
		}

		local spawnanim = {
			[0] = function(type) 
				seq = seq 
				dirt = true
				gravity = true
				return seq 
			end,

			[1] = function(type) 
				seq = "idle" 
				dirt = false
				gravity = true
				return seq 
			end,

			[3] = function(type) 
				seq = self.UndercroftSequences[math.random(#self.UndercroftSequences)] 
				dirt = false
				gravity = false
				return seq 
			end,
			
			[4] = function(type) 
				seq = self.WallSpawnSequences[math.random(#self.WallSpawnSequences)] 
				dirt = false
				gravity = false
				return seq 
			end,
			
			[5] = function(type) 
				seq = self.DugUpSpawnSequences[math.random(#self.DugUpSpawnSequences)] 
				dirt = true
				gravity = true
				return seq 
			end,
			
			[6] = function(type) 
				seq = self.BarrelSpawnSequences[math.random(#self.BarrelSpawnSequences)] 
				dirt = false
				gravity = false
				return seq 
			end,
			
			[7] = function(type) 
				seq = self.LowCeilingDropSpawnSequences[math.random(#self.LowCeilingDropSpawnSequences)] 
				dirt = false
				gravity = true
				return seq 
			end,
			
			[8] = function(type) 
				seq = self.HighCeilingDropSpawnSequences[math.random(#self.HighCeilingDropSpawnSequences)] 
				dirt = false
				gravity = true
				return seq 
			end,
			
			[9] = function(type) 
				seq = self.GroundWallSpawnSequences[math.random(#self.GroundWallSpawnSequences)] 
				dirt = false
				gravity = false
				return seq 
			end,

			[10] = function(type) 
				seq = self.DimensionalWallSpawnSequences[math.random(#self.DimensionalWallSpawnSequences)] 
				dirt = false
				gravity = false
				return seq 
			end,

			[11] = function(type) 
				seq = self.JumpSpawnSequences[math.random(#self.JumpSpawnSequences)] 
				dirt = false
				gravity = true

				ParticleEffect("zmb_trickster_portal",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
				self:EmitSound("nz_moo/zombies/spawn/portal/zmb_spawn_portal_0"..math.random(6)..".mp3",100,math.random(95,105))

				return seq 
			end,

			[12] = function(type) 
				seq = self.ElevatorFloorSpawnSequences[math.random(#self.ElevatorFloorSpawnSequences)] 
				dirt = false
				gravity = true
				return seq 
			end,

			[13] = function(type) 
				seq = self.ElevatorCeilingSpawnSequences[math.random(#self.ElevatorCeilingSpawnSequences)] 
				dirt = false
				gravity = true
				return seq 
			end,

			[14] = function(type)
				seq = self.ProneCrawlSequences[math.random(#self.ProneCrawlSequences)]
				dirt = false
				gravity = true
				return seq 
			end,

			[15] = function(type)
				seq = self.UnderbedSequences[math.random(#self.UnderbedSequences)]
				dirt = false
				gravity = true
				return seq 
			end,

			[16] = function(type)
				seq = self.Alcove40Sequences[math.random(#self.Alcove40Sequences)]
				dirt = false
				gravity = true
				return seq 
			end,

			[17] = function(type)
				seq = self.Alcove56Sequences[math.random(#self.Alcove56Sequences)]
				dirt = false
				gravity = true
				return seq 
			end,

			[18] = function(type)
				seq = self.Alcove96Sequences[math.random(#self.Alcove96Sequences)]
				dirt = false
				gravity = true
				return seq 
			end,

			[19] = function(type) 
				seq = {
					"nz_iw7_cp_zom_spawn_ground_walk_01",
					"nz_iw7_cp_zom_spawn_ground_walk_03",
					"nz_iw7_cp_zom_spawn_ground_walk_04",
				}
				dirt = false
				gravity = true

				ParticleEffect("zmb_iw_spawn_portal",self:GetPos()+Vector(0,0,0.1),self:GetAngles(),self)
				self:EmitSound("nz_moo/zombies/spawn/iw_portal/zmb_ground_spawn_0"..math.random(3)..".mp3",75,math.random(95,105))

				for i=1, 3 do
					timer.Simple(i*0.5, function()
						if IsValid(self) then
							self:EmitSound("nz_moo/zombies/spawn/iw_portal/zmb_ground_spawn_lightning_0"..math.random(3)..".mp3",75,math.random(95,105))
						end
					end)
				end

				return seq[math.random(#seq)]
			end,

			[20] = function(type)
				seq = self.CrawlOutSequences[math.random(#self.CrawlOutSequences)]
				dirt = false
				gravity = true
				return seq 
			end,
		}

		for k,v in pairs(ents.FindInSphere(self:GetPos(), 10)) do
			if types[v:GetClass()] then
				if !v:GetMasterSpawn() then
					spawn = v
					break
				end
			elseif v:GetClass() == "nz_spawn_zombie_vign" then
				self.IsENVZombie = true
				self.ENVSpawnIndex = v
			end
		end

		if IsValid(spawn) and !self.IsENVZombie then
			spawnanimtype = spawn:GetSpawnType()
            self.SpawnIndex = spawn -- Index the spawn the zombie comes from for later.
        else
        	if self.IsENVZombie or nzRound:InState(ROUND_CREATE) then
        		spawnanimtype = 1
        	else
        		spawnanimtype = 0
        	end
		end

		animation = spawnanim[spawnanimtype](seq)

		hook.Call("OnEnemySpawn", GAMEMODE, self)

		self:OnSpawn(animation, gravity, dirt)

		self:ZCTInit()
		self:CatalystInit()
		self:BurningInit()

		if self.IsENVZombie then
			self:VignZombieInit()
		end
	end

	function ENT:VignZombieInit()
		if IsValid(self.ENVSpawnIndex) then
			local spawn 	= self.ENVSpawnIndex
			local var 		= spawn.Types[spawn:GetSpawnType()]

			self.VignSleepAnimation = var.inactive
			self.VignAwakeAnimation = var.activate

			if var.loop ~= nil then self.VignLoopAnimation = var.loop end
			if var.death ~= nil then self.VignDeathAnimation = var.death end

			-- Init some variables
			self:SetDecapitated(true)
			self:SetShouldCount(false)
			self:SetTargetPriority(TARGET_PRIORITY_MONSTERINTERACT)

			self.ENVZombieRadius = spawn:GetAwakeRadius()

			if isstring(self.VignLoopAnimation) then
				self.loco:SetGravity(0)
				self:SetPos(spawn:GetPos())
				self:SetAngles(spawn:GetAngles())
			end

			if spawn:GetInstantAwake() then self.ENVZombieInstantAwake = true end
		end
	end

	-- Moo Mark 3/27/23: The two functions below this comment are functions to stop zombies from attacking you through the world and entities(minus other zombies and players).
	function ENT:UpdateAttackRange()
		--if CurTime() > self.AttackRangeUpdate and IsValid(self.Target) then

			if self:IsAttackBlocked() and self.Target:IsPlayer() then
				self.AttackIsBlocked = true
				if self.FailedAttack < 6 then
					self:SetAttackRange(1) -- For as long as the trace is hitting something, the attack range will be 1.
				else
					self:SetAttackRange(self.AttackRange)
				end
				if self:TargetInRange(self.DamageRange) then -- But the player is in range... They may be trying to exploit but we don't know for sure, hence the delay.
					self.FailedAttack = self.FailedAttack + 1 
				end
			else
				self.AttackIsBlocked = false
				self.FailedAttack = 0
				if self:GetCrawler() then
					self:SetAttackRange(self.CrawlAttackRange)
				elseif self.IsTurned then -- This one only affects turned zombies.
					self:SetAttackRange(self.AttackRange)
					self.DamageRange = self.DamageRange + 75
				elseif IsValid(self.Target) and self.Target.BHBomb or self.BO3IsWebbed and self:BO3IsWebbed() then
					self:SetAttackRange(1) -- So the zombie can as close as possible to the gersch.
				else
					self:SetAttackRange(self.AttackRange) -- Revert the range back to normal if theres nothing blocking the trace.
				end
			end

			if self:GetBlockAttack() or self:GetWandering() then 
				self:SetAttackRange(1)
			end
			--print("Attack Range changed, new range is "..self:GetAttackRange()..".")
			--self.AttackRangeUpdate = CurTime() + 1
		--end
	end

	function ENT:IsAttackBlocked()
		if IsValid(self.Target) and self.Target:IsPlayer() then
			local tr = util_traceline({
				start = self:EyePos(),
				endpos = self.Target:EyePos(),
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_WORLD, -- This is what allows zombies to ignore each other.
				ignoreworld = false
			})

			-- Runs a trace from the zombie to the player to make sure theres nothing in between them.

			local ent = tr.Entity

			if IsValid(ent) and ent:IsPlayer() then return false end

			return tr.Hit
		end
	end

	function ENT:IsAttackEntBlocked(ent) -- 4/24/23: Same as above but allows use of an inserted Entity rather than the bot's current target.
		if IsValid(ent) then
			local pos = self:EyePos()

			local tr = util_traceline({
				start = pos,
				endpos = ent:WorldSpaceCenter(),
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_WORLD, -- This is what allows zombies to ignore each other.
				ignoreworld = false
			})

			-- Runs a trace from the zombie to the player to make sure theres nothing in between them.

			local ent = tr.Entity

			if IsValid(ent) and ent:IsPlayer() then return false end

			return tr.Hit
		end
	end

	function ENT:IsEntBlocked(startpos, endpos) -- 10/20/24: This one allows the bot to test two entities to check if they can see each other.
		if isvector(startpos) and isvector(endpos) then

			local tr = util_traceline({
				start = startpos,
				endpos = endpos,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_WORLD, -- This is what allows zombies to ignore each other.
				ignoreworld = false
			})

			local ent = tr.Entity

			debugoverlay.Line(startpos, endpos, 3, Color( 255, 0, 255 ), false)

			--if IsValid(ent) and ent:IsPlayer() then return false end

			--print("fuck")

			return tr.Hit
		end
	end

	-- Moo Mark 6/26/23: A function that allows you to check the end destination of a sequence.
	-- You'd use this before doing a PlaySequenceAndMove to see if the sequence would end up putting the bot somewhere undesirable like falling off a ledge or moving into a wall.
	function ENT:SequenceHasSpace(seq)


		--[[if !IsValid(seq) then -- An error would happen if there was a nil sequence, but the error wouldn't directly tell you the sequence was nil.
			ErrorNoHalt("Zombie ["..self:GetClass().."]["..self:EntIndex().."] SequenceHasSpace: missing sequence!")
			return
		end]]

		local spos = self:GetPos()
		local comedy = true -- A bool that does nothing other than allow the GetSequenceMovement data to go through.

		if !self:HasSequence(seq) then return end -- Back out, the entity doesn't have a given sequence.

		local comedy, vec, angles = self:GetSequenceMovement(self:LookupSequence(seq), 0, 1) -- Get the sequence's postion data
		if isvector(vec) then
			vec = Vector(vec.x, vec.y, vec.z)
		end
		vec = self:LocalToWorld(vec) -- Make the Vector local to the bot itself

		--debugoverlay.Sphere(vec, 15, 5, Color( 255,255,255), false) -- Shows a debug sphere at the selected sequences destination
		local minBound, maxBound = self:OBBMins(), self:OBBMaxs()
        if self:CollisionBoxClear(self, vec, minBound, maxBound) then -- Check if theres space
        	--print("Collision Clear")
            local qtr = util.QuickTrace(vec, vector_up*-12, self) -- Check if theres a floor

			local tr2 = util_traceline({ -- Should've done this sooner, trace a line from the bot to the vector position.
				start = self:EyePos(),
				endpos = vec,
				filter = self,
				ignoreworld = false
			})
			local a = tr2.Entity

			--debugoverlay.Line(self:EyePos(), vec, 5, Color( 255, 255, 255 ), false)

    		if qtr.Hit and !tr2.Hit then -- Makes sure theres ground and theres nothing in the bots way.
        		return true -- Returned true, we can play the sequence without having problems.
   			end
        end
	end

	-- Moo Mark 3/23/24: A helper function to make testing for if a entity has a specified sequence simpler.
	function ENT:HasSequence(seq)
		if !isstring(seq) then return false end
		
		if self:LookupSequence(seq) > 0 then 
			return true 
		else
			return false
		end
	end


	--[[function ENT:IsEntBlocked(ent) 
		if IsValid(ent) then
			local pos = ent:GetPos()
			local tr = util_traceline({
				start = self:EyePos(),
				endpos = Vector(pos.x,pos.y+50,pos.z),
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_WORLD,
				ignoreworld = false
			})

		
			local ent = tr.Entity

			if IsValid(ent) and ent:IsPlayer() then return false end
			if IsValid(ent) and ent:GetClass() == "random_box" then return false end
			if IsValid(ent) and ent:GetClass() == "perk_machine" then return false end

			return tr.Hit
		end
	end]]

	function ENT:OnTargetInAttackRange()
		if (self.IsMooBossZombie and !self:GetBlockAttack() or self.IsNZAlly and !self.Target:IsPlayer() or self.IsTurned or self.Target:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and !self:GetBlockAttack() and !nzPowerUps:IsPowerupActive("timewarp")) then
			self:Attack()
		else
			self:TimeOut(0.1)
		end
	end

	-- This function is full of stench. 2/24/24: Its slightly less stinky now.
	function ENT:OnBarricadeBlocking( barricade, dir )
		local mantleposmods = {
			[0] = {
				positive = 31,
				negative = -31,
			},
			[1] = {
				positive = 55,
				negative = -55,
			},
			[2] = {
				positive = 55,
				negative = -55,
			},
			[3] = {
				positive = 55,
				negative = -55,
			},
			[4] = {
				positive = 55,
				negative = -55,
			},
			[5] = {
				positive = 31,
				negative = -31,
			},
			[6] = {
				positive = 31,
				negative = -31,
			},
			[7] = {
				positive = 31,
				negative = -31,
			},
			[8] = {
				positive = 31,
				negative = -31,
			},
			[9] = {
				positive = 31,
				negative = -31,
			},
			[10] = {
				positive = 31,
				negative = -31,
			},
			[11] = {
				positive = 31,
				negative = -31,
			},
			[12] = {
				positive = 55,
				negative = -55,
			},
			[13] = {
				positive = 55,
				negative = -55,
			},
		}

		if !self:GetSpecialAnimation() then
			if (IsValid(barricade) and barricade:GetClass() == "breakable_entry" ) then

				self.Barricade = barricade

				local warppos
				local side

				--[[ This allows the zombie to know which side of the barricade is which when climbing over it ]]--
				local normal = (self:GetPos() - barricade:GetPos()):GetNormalized()
				local fwd = barricade:GetForward()
				local dot = fwd:Dot(normal)
				if 0 < dot then
					warppos = (barricade:GetPos() + fwd*mantleposmods[barricade:GetJumpType()].positive)
				else
					warppos = (barricade:GetPos() + fwd*mantleposmods[barricade:GetJumpType()].negative)
				end

				local bpos = barricade:ReserveAvailableTearPosition(self) or warppos

				-- Index the bpos so when a spot opens up for the barricade, a zombie doesn't suddenly warp to that open spot.
				if !isvector(self.BarricadePosition) then self.BarricadePosition = bpos end

				-- If for some reason the position is nil... Just idle until further notice.
				if !self.BarricadePosition then
					self:TimeOut(1)
					return
				end

				if !self:GetIsBusy() and self.BarricadePosition then -- When the zombie initially comes in contact with the barricade.
					self:SetIsBusy(true)

					if (barricade:GetNumPlanks() <= 0 and !self.JumpSequencesLeft and !self.JumpSequencesRight) or !barricade:GetHasPlanks() then
						self.BarricadePosition = warppos
					end

					self:ApproachPosAndWait(self.BarricadePosition, 15, 2, true, true)

					self:TimeOut(0.1) -- An intentional and W@W authentic stall.
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
				end

				currentpos = self:GetPos()
				if self.BarricadePosition and currentpos ~= self.BarricadePosition then
					self:SetPos(Vector(self.BarricadePosition.x,self.BarricadePosition.y,currentpos.z))
				end
					
				self:FaceTowards(barricade:LocalToWorld(Vector(0,barricade:WorldToLocal(self.BarricadePosition).y,0)))

				-- Determine which position of the barricade the zombie chose. It could be the left, right, or middle.
				local diff = self:WorldToLocal(warppos)
				if diff.y < -20 then
					side = "l"
				end
				if diff.y > 25 then
					side = "r"
				end

				-- If the zombie wasn't on either side, it defaults to the middle.
				if !isstring(side) then side = "m" end

				-- For when the zombie has to re-run this function and already has chosen a position.
				if !isstring(self.BarricadeSide) then self.BarricadeSide = side end

				if barricade:GetNumPlanks() > 0 then
					local currentpos
					--[[
					-- If for some reason the position is nil... Just idle until further notice.
					if !self.BarricadePosition then
						self:TimeOut(1)
						return
					end

					if !self:GetIsBusy() and self.BarricadePosition then -- When the zombie initially comes in contact with the barricade.
						self:SetIsBusy(true)

						self:ApproachPosAndWait(self.BarricadePosition, 15, 2, true, true)

						self:TimeOut(0.25) -- An intentional and W@W authentic stall.
						self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
					end

					currentpos = self:GetPos()
					if self.BarricadePosition and currentpos ~= self.BarricadePosition then
						self:SetPos(Vector(self.BarricadePosition.x,self.BarricadePosition.y,currentpos.z))
					end
					
					self:FaceTowards(barricade:LocalToWorld(Vector(0,barricade:WorldToLocal(self.BarricadePosition).y,0)))
					]]

					--[[Attack animations on Barricade]]--
					local seq, dur

					local attacktbl = self.AttackSequences
					if self:GetCrawler() then
						attacktbl = self.CrawlAttackSequences
					elseif self.StandAttackSequences and !self:GetCrawler() then
						attacktbl = self.StandAttackSequences
					end

					local target = type(attacktbl) == "table" and attacktbl[math.random(#attacktbl)] or attacktbl
					local teartbl = self.BarricadeTearSequences[math.random(#self.BarricadeTearSequences)]
					local teartarget = type(teartbl) == "table" and teartbl[math.random(#teartbl)] or teartbl
						
					if !self.IsMooSpecial and !self:GetCrawler() then -- Don't let special zombies use the tear anims.
						if type(teartarget) == "table" then
							seq, dur = self:LookupSequenceAct(teartarget.seq)
						elseif teartarget then -- It is a string or ACT
							seq, dur = self:LookupSequenceAct(teartarget)
						else
							seq, dur = self:LookupSequence("swing")
						end
					else
						if type(target) == "table" then
							seq, dur = self:LookupSequenceAct(target.seq)
						elseif target then -- It is a string or ACT
							seq, dur = self:LookupSequenceAct(target)
						else
							seq, dur = self:LookupSequence("swing")
						end
					end
					--[[Attack animations on Barricade]]--

					--[[
					-- Determine which position of the barricade the zombie chose. It could be the left, right, or middle.
					local diff = self:WorldToLocal(warppos)
					if diff.y < -20 then
						side = "l"
					end
					if diff.y > 25 then
						side = "r"
					end

					-- If the zombie wasn't on either side, it defaults to the middle.
					if !isstring(side) then side = "m" end

					-- For when the zombie has to re-run this function and already has chosen a position.
					if !isstring(self.BarricadeSide) then self.BarricadeSide = side end
					]]

					local planktopull = barricade:BeginPlankPull(self)
					local planknumber -- fucking piece of shit(There was anger when making this.)

					if !planktopull then
						self:TimeOut(1)
						if barricade then
							self:OnBarricadeBlocking(barricade, dir)
							return
						end
					else
						planknumber = planktopull:GetFlags()
					end

					if planknumber ~= nil then
						self.BarricadePlankPull = planktopull
					end

					-- Determine the Board Tear animation.
					local anim = "nz_win_boardtear_"..self.BarricadeSide.."_"
					local result

					if self:GetCrawler() then
						anim = "nz_win_crawl_boardtear_"..self.BarricadeSide.."_"
					end

					result = ""..anim..""..planknumber..""

					local speed = 1

					if planktopull.Enhanced then speed = 0.75 else speed = 1 end

					if self.AttackSounds then self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2) end
					
					-- Check if the enemy in question even has the selected animation. If not, use an attack/barricade attack animation.
					if self:LookupSequence(result) > 0 and (self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial) then
						self.BarricadeTearing = true

						self:SetPos(Vector(self.BarricadePosition.x,self.BarricadePosition.y,self.BarricadePosition.z + 5))
						self:PlaySequenceAndMove(result, {gravity = false, rate = speed})
						self.BarricadeTearing = false
					else
						timer.Simple(dur/2, function() -- TIMER SPOTTED!!!
							if IsValid(self) and self:IsAlive() and IsValid(planktopull) then 
								if self.IsMooBossZombie or self.NZBossType then
									barricade:RemovePlank(planktopull)
									barricade:FullBreak()
								else
									barricade:RemovePlank(planktopull)
								end
							end
						end)

						self.BarricadeTearing = true
						self:SetPos(Vector(self.BarricadePosition.x,self.BarricadePosition.y,self.BarricadePosition.z))
						self:PlaySequenceAndWait(seq)
						self.BarricadeTearing = false
					end

					self:Retarget()

					--[[ Arm reaching and Taunting ]]--

					local attackside = {
						["r"] = function() 
							seq = self.LeftWindowAttackSequences[math.random(#self.LeftWindowAttackSequences)]
							return seq 
						end,
						["l"] = function() 
							seq = self.RightWindowAttackSequences[math.random(#self.RightWindowAttackSequences)]
							return seq 
						end,
						["m"] = function() 
							seq = self.MiddleWindowAttackSequences[math.random(#self.MiddleWindowAttackSequences)]
							return seq 
						end,
					}

					local attackresult = attackside[self.BarricadeSide](seq)

					if self:LookupSequence(attackresult) > 0 and self:TargetInRange(self.AttackRange + 15) and math.random(100) > 50 and !self:GetCrawler() and !self.IsMooSpecial then
						self.BarricadeArmReach = true
						self:SetStuckCounter( 0 ) --This is just to make sure a zombie won't despawn at a barricade.
						self:PlaySequenceAndWait(attackresult)
						self.BarricadeArmReach = false
					else
						if math.random(100) <= 25 and !self:GetCrawler() and !self.IsMooSpecial then -- The higher the number, the more likely a zombie will taunt.
							self:SetStuckCounter( 0 ) --This is just to make sure a zombie won't despawn at a barricade.
							self:PlaySequenceAndWait(self.TauntSequences[math.random(#self.TauntSequences)])
						end
					end
					--[[ Arm reaching and Taunting ]]--

					if barricade then
						self:OnBarricadeBlocking(barricade, dir) -- Re-check the barricade.
						return
					end
				elseif barricade:GetTriggerJumps() and self.TriggerBarricadeJump then

					self.BarricadeTearing = false

					if !self.JumpSequencesLeft and !self.JumpSequencesRight or barricade:GetJumpType() ~= 0 then
						self:SetIsBusy(true)
						self:ResetMovementSequence()
						self:ApproachPosAndWait(warppos, 15, 2, true, true)
						self:SetPos(Vector(warppos.x,warppos.y,self:GetPos().z))
						self:FaceTowards(barricade:LocalToWorld(Vector(0,barricade:WorldToLocal(warppos).y,0)))
						self:TimeOut(0.05)

						self:SetPos(Vector(warppos.x,warppos.y,warppos.z))
					end

					self:TriggerBarricadeJump(barricade, dir, self.BarricadeSide)

					if isstring(self.BarricadeSide) then self.BarricadeSide = false end
					self.BarricadePosition = nil
				else
					if isstring(self.BarricadeSide) then self.BarricadeSide = false end

					self.BarricadeTearing = false
					self.BarricadePosition = nil
					
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

					local pos = barricade:GetPos() - dir * 50
					self:ResetMovementSequence()
					self:ApproachPosAndWait(pos, 8, 2, true, true)

					self:CollideWhenPossible()
					self:SetIsBusy(false)
				end
			end
		end
	end
end


function ENT:TimeOut(time)
	self:SetTimedOut(true)
	if !self:GetSpecialShouldDie() or self.IsTornado or self.IsXbowSpinning then
		self:PerformIdle()
	end
	if coroutine.running() then
		coroutine.wait(time)
	end
end

function ENT:OnPathTimeOut()
	self:CustomOnPathTimeOut()
end

function ENT:CustomOnPathTimeOut() end

function ENT:OnNoTarget()
	self:TimeOut(0.1) -- Instead of being brain dead for a second, just search for a new target sooner.

	local newtarget = self:Retarget()
	if self:IsValidTarget(newtarget) then
		self.CancelCurrentPath = true
	else
		if !self:IsInSight() and nzRound:InProgress() and !nzRound:InState( ROUND_GO ) then
			self:RespawnZombie(true)
		else
			if nzRound:InState( ROUND_GO ) then
				self:OnGameOver()
			end
		end
	end
end

-- If you want your enemy to do something once everyone dies.(Feel free to override if need be.)
function ENT:OnGameOver() 

	-- Since theres a such thing as a gameover camera and its been suggested twice, Zombies will randomly have their heads explode and die during the gameover sequence.
	if !self.IsMooSpecial and !self.IsMiniBoss and !self.IsMooBossZombie and !self.NZBossType then
		if math.random(100) < 25 then
			self:GibHead()
			self:TakeDamage(self:Health() + 666, Entity(0), Entity(0))
		end
	end
end 

-- This doesn't affect anything if its overridden, so feel free to do so if you need to.
function ENT:OnThink()

	if not IsValid(self) then return end

	if self:GetSpecialAnimation() and self.ZCTTraitActive and self.ZCTCloaked then
		self:ZCTPhazeShift()
	end

	if SERVER and self:IsAlive() and self:IsDecapitated() then // Decapitation bleedout
		if not self.nextbleedtick then
			self.nextbleedtick = CurTime() + 0.25
			self.bleedtickcount = 0
		end

		if self.nextbleedtick and self.nextbleedtick < CurTime() then
			ParticleEffectAttach(self.Blood[self.BloodType].HeadGibFX, 4, self, 10)

			self.nextbleedtick = CurTime() + math.Rand(0.15, 0.4)
			self.bleedtickcount = self.bleedtickcount + 1
		end

		if self.bleedtickcount and self.bleedtickcount > 10 then
			print("Goodbye Luigi.")
			self:TakeDamage(self:Health() + 666, Entity(0), Entity(0))
		end
	end
end

function ENT:ZombieGestureSequences()
	-- For zombies that have the sequences, they have the ability to flap their jaws at you.
	-- ... And now also flinch from taking damage.

	if self.CanFlinch and self.CanFlinch == true then
		self.CanFlinch = false

		self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
		self:AddGesture(ACT_GESTURE_FLINCH_HEAD, true)
	end

	if self.DisableFacial and self.DisableFacial == true then return end
	
	-- These gestures are what cause zombies to very breifly t-pose before playing an attack anim in multiplayer.(Cause multiplayer is just stinky like that.)
	if self:IsAttacking() and !self.Dying and !self.IsBeingStunned then
		local face_attack = self:LookupSequence("a_zombie_face_attack")
		if self.FacialGesture ~= face_attack then
			self.FacialGesture = face_attack
			self:RemoveAllGestures()
			self:AddGestureSequence(face_attack, false)
	    end
	end

	if !self:IsAttacking() and self.IsBeingStunned and !self.Dying then
		local face_pain = self:LookupSequence("a_zombie_face_pain")
		if !self:HasSequence(face_pain) then face_pain = self:LookupSequence("a_zombie_face_attack") end
		if self.FacialGesture ~= face_pain then
			self.FacialGesture = face_pain
			self:RemoveAllGestures()
			self:AddGestureSequence(face_pain, false)
	    end
	end

	if !self:IsAttacking() and !self.IsBeingStunned and self.Dying then
		local face_death = self:LookupSequence("a_zombie_face_death")
		if !self:HasSequence(face_death) then face_death = self:LookupSequence("a_zombie_face_attack") end
		if self.FacialGesture ~= face_death then
			self.FacialGesture = face_death
			self:RemoveAllGestures()
			self:AddGestureSequence(face_death, false)
	    end
	end

	if !self:IsAttacking() and !self.Dying and !self.IsBeingStunned then
		local face_idle = self:LookupSequence("a_zombie_face_idle")
		if self.FacialGesture ~= face_idle then
			self.FacialGesture = face_idle
			self:RemoveAllGestures()
			self:AddGestureSequence(face_idle, false)
	    end
	end
end

-- A function that just allows you to play the spawn dust effect easily.
function ENT:DoZombieSpawnDust()
	if self.AllowDustParticle then
		self.AllowDustParticle = false

		local SpawnMatSound = {
			[MAT_DIRT] = "nz_moo/zombies/spawn/dirt/pfx_zm_spawn_dirt_0"..math.random(0,1)..".mp3",
			[MAT_SNOW] = "nz_moo/zombies/spawn/snow/pfx_zm_spawn_snow_0"..math.random(0,1)..".mp3",
			[MAT_SLOSH] = "nz_moo/zombies/spawn/mud/pfx_zm_spawn_mud_00.mp3",
			[0] = "nz_moo/zombies/spawn/default/pfx_zm_spawn_default_00.mp3",
		}
		SpawnMatSound[MAT_GRASS] = SpawnMatSound[MAT_DIRT]
		SpawnMatSound[MAT_SAND] = SpawnMatSound[MAT_DIRT]

		local norm = (self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = SpawnMatSound[tr.MatType] or SpawnMatSound[0]
			self:EmitSound(finalsound)
		end

		ParticleEffect("zmb_zombie_spawn_dirt",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	end
end

-- Like one above, but does the generic portal effect alot of enemies use.
function ENT:DoZombiePortal(height)
	height = height or 50

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, height)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)
end

--Default NEXTBOT Events
function ENT:OnLandOnGround(ent)
	if self.IsENVZombie then return end

	if self.Big_Jump_area_start then
		if nzNav.Reserved[self.Big_Jump_area_start:GetID()] and nzNav.Reserved[self.Big_Jump_area_start:GetID()] == self then
			nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
		end
		self.Big_Jump_area_start = nil
		self:SetBlockAttack(false)
		if self.current_speed then
			self.loco:SetDesiredSpeed(self.current_speed)
			self.current_speed = nil
		end
	end
	if self.Big_Jump_area_end then
		if nzNav.Reserved[self.Big_Jump_area_end:GetID()] and nzNav.Reserved[self.Big_Jump_area_end:GetID()] == self then
			nzNav.Reserved[self.Big_Jump_area_end:GetID()] = nil
		end
		self.Big_Jump_area_end = nil

	end
	if self.On_Big_Jump then
		self.On_Big_Jump = nil
	end
	
	if self.On_Jump then
		self.On_Jump = false
		self:SetBlockAttack(false)
		self:SetJumping( false )
		self:SetIsBusy(false)
		self.SameSquare = true
		self.loco:SetVelocity( Vector(0,0,0) )
	end

	if self:IsAlive() then
		self:SetBlockAttack(false)
		self:SetJumping( false )
		self:SetIsBusy(false)
		self.SameSquare = true

		self.CancelCurrentPath = true

		self:CollideWhenPossible()

		if self.InAirTime > 2 and !self:GetSpecialAnimation() then
			local seq = self.ZombieLandSequences[math.random(#self.ZombieLandSequences)]
			if self:HasSequence(seq) and !self:GetCrawler() then
				self:DoSpecialAnimation(seq, false, true, true, MASK_PLAYERSOLID) 
			end
		end

		if self.InAirTime > 0.5 then
			self.BigJumpCooldown = CurTime() + 2
		else
			self.BigJumpCooldown = CurTime() + 0.1
		end


		self.InAirTime = 0
		if !self:GetSpecialAnimation() then
			self:ResetMovementSequence()
		end
	end

	self:OnLandOnGroundCustom(ent)
end

function ENT:OnLeaveGround(ent)
	--print("fuck")
	self:SetJumping(true)
	self:OnLeaveGroundCustom(ent)
end

function ENT:OnLeaveGroundCustom(ent)
end

function ENT:OnLandOnGroundCustom(ent) 
	-- Feel free to override this to fit your current enemy.
end

function ENT:OnNavAreaChanged(old, new)
	if IsValid(new) then
		if new:HasAttributes(NAV_MESH_JUMP) and !self.Big_Jump_area_start and self.TestForBigJump and CurTime() > self.BigJumpCooldown then
			self.Big_Jump_area_start = new
			nzNav.Reserved[new:GetID()] = self
			self:SetBlockAttack(true)
			self:SetIsBusy(true)

			self.current_speed = self.loco:GetDesiredSpeed()
			self.loco:SetDesiredSpeed(self.loco:GetDesiredSpeed()*0.25)
		end
		if (new:HasAttributes(NAV_MESH_WALK) and !new:HasAttributes(NAV_MESH_STAND) or new:HasAttributes(NAV_MESH_WALK) and new:HasAttributes(NAV_MESH_STAND) and !nzElec:IsOn()) then
			self.InLowGravZone = true
		else
			self.InLowGravZone = false
		end
		if !self.IsMooSpecial and !self.ShouldCrawl and IsValid(new) then
			if bit.band(new:GetAttributes(), NAV_MESH_CROUCH) ~= 0 then
				if !self:GetCrawler() then
					self:BecomeCrawler()
				end
			else
				if self:GetCrawler() then
					self:BecomeNormal()
				end
			end
		end
	end
end

function ENT:Jump(dir) -- Chtidino's Jump Function.

	if !self:IsOnGround() then return end
	
	self.On_Jump = true
	self:SetJumping(true)
	self.loco:Jump()
	self:SetBlockAttack(true)
	
	timer.Simple(0.5, function()
		if IsValid(self) and self:IsAlive() then
			if dir.x < math.huge and dir.y < math.huge then
				self.loco:SetVelocity( (dir * (self.AttackRange*0.35)) )
			else
				self.loco:SetVelocity( (self:GetForward() * (self.AttackRange*0.35)) )
			end
		end
	end)
end

function ENT:OnContact( ent )

	if ( ent:GetClass() == "prop_physics_multiplayer" or ent:GetClass() == "prop_physics" ) then
		--self.loco:Approach( self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 2000,1000)
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			local force = -physenv.GetGravity().z * phys:GetMass() / 12 * ent:GetFriction()
			local dir = ent:GetPos() - self:GetPos()
			dir:Normalize()
			phys:ApplyForceCenter( dir * force )
		end
	end

	--[[if (ent:IsValidZombie() or ent:IsPlayer()) and self.On_Big_Jump then
		if nzNav.Reserved[self.Big_Jump_area_start:GetID()] and nzNav.Reserved[self.Big_Jump_area_start:GetID()] == self then
			nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
		end
		if nzNav.Reserved[self.Big_Jump_area_end:GetID()] and nzNav.Reserved[self.Big_Jump_area_end:GetID()] == self then
			nzNav.Reserved[self.Big_Jump_area_end:GetID()] = nil
		end
		self.Big_Jump_area_start = nil
		self.Big_Jump_area_end = nil
		self.On_Big_Jump = nil
		self:SetBlockAttack(false)
		self:SetIsBusy(false)
		if self.current_speed then
			self.loco:SetDesiredSpeed(self.current_speed)
			self.current_speed = nil
		end
	end]]

	if self:IsTarget( ent ) then
		self:OnContactWithTarget()
	end
end

function ENT:IsAlive() return self:GetIsAlive() end

if SERVER then
	ENT.DeathRagdollForce = 9000
	ENT.CrawlerForce = 7500
	ENT.GibForce = 200
	ENT.StunForce = 1250
	ENT.HasGibbed = false

	function ENT:RagdollForceTest(force)
		if force == nil then return nil end
		return self.DeathRagdollForce^2 <= force:LengthSqr()
	end

	function ENT:CrawlerForceTest(force)
		if force == nil then return nil end
		return self.CrawlerForce^2 <= force:LengthSqr()
	end

	function ENT:GibForceTest(force)
		if force == nil then return nil end
		return self.GibForce^2 <= force:LengthSqr()
	end

	function ENT:StunForceTest(force)
		if force == nil then return nil end
		return self.StunForce^2 <= force:LengthSqr()
	end

	function ENT:CrawlerDamageTest(dmginfo)
		if not dmginfo then return nil end
		return self:CrawlerForceTest(dmginfo:GetDamageForce()) and dmginfo:IsExplosionDamage() and !self.IsMooSpecial and !self.IsTurned
	end

	-- This function is really only used for normal zombies a lot, so this can be overridden without problems.
	function ENT:OnInjured(dmginfo)
		local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
		local hitforce 		= dmginfo:GetDamageForce()
		local hitpos 		= dmginfo:GetDamagePosition()
		local inflictor 	= dmginfo:GetInflictor()

		if self.IsENVZombie then
			self.ENVZombieInstantAwake = true
		end

		if !self.SpawnProtection and !self.IsMooSpecial and self.CanGib and !self.IsENVZombie then

			--[[ CRAWLER CREATION FROM DAMAGE ]]--
			if (self:CrawlerDamageTest(dmginfo)) and self:IsAlive() then
				local lleg = self:LookupBone("j_ball_le")
				local rleg = self:LookupBone("j_ball_ri")

				if !lleg then return end
				if !rleg then return end

				local llegpos = self:GetBonePosition(lleg)
				local rlegpos = self:GetBonePosition(rleg)

				if (lleg and !self.LlegOff) and (hitpos:DistToSqr(llegpos) < 35^2) then
					self:GibLegL()
				end
				if (rleg and !self.RlegOff) and (hitpos:DistToSqr(rlegpos) < 35^2) then
					self:GibLegR()
				end
			end

			--[[ GIBBING SYSTEM ]]--
			if self:GibForceTest(hitforce) then
				local head = self:LookupBone("j_head")
				local larm = self:LookupBone("j_elbow_le")
				local rarm = self:LookupBone("j_elbow_ri")
				
				if (larm and hitgroup == HITGROUP_LEFTARM) and !self.IsMooSpecial and !self.HasGibbed then
					self:GibArmL()
				end

				if (rarm and hitgroup == HITGROUP_RIGHTARM) and !self.IsMooSpecial and !self.HasGibbed then
					self:GibArmR()
				end
			end

			--[[ FLINCHING ]]--
			if !self:GetSpecialAnimation() and !self.Dying and !self:IsAttacking() and !self.IsBeingStunned and CurTime() > self.LastFlinch then
				-- Just plays an additive that makes the zombie look like they flinch whenever they take damage.
				-- Fuck you multiplayer... IT DECIDES WHEN THIS SHOULD WORK.
				self.CanFlinch = true
				self.LastFlinch = CurTime() + 0.1
				--self:RestartGesture(ACT_GESTURE_FLINCH_HEAD, true, true)
			end

			--[[ STUMBLING/STUN ]]--
			if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
				-- Moo Mark 7/17/23: Alright... We're gonna try again.
				if self.Dying then return end
				if !self:IsAlive() then return end
				if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
					or self:GetSpecialAnimation() 
					or self:GetCrawler() 
					or self:GetIsBusy() 
					or self.ShouldCrawl 
					then return end

				-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
				if !self.IsBeingStunned and !self:GetSpecialAnimation() then
					if nzMapping.Settings.stumbling == true then
						if hitgroup == HITGROUP_HEAD and self:RagdollForceTest(hitforce) and CurTime() > self.LastStun and !self:GetCrawler() then
							if self.PainSounds and !self:IsDecapitated() then
								self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
								self.NextSound = CurTime() + self.SoundDelayMax
							end
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.HeadPainSequences[math.random(#self.HeadPainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end

						if hitgroup == HITGROUP_LEFTARM and CurTime() > self.LastStun and !self:GetCrawler() then
							if self.PainSounds and !self:IsDecapitated() then
								self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
								self.NextSound = CurTime() + self.SoundDelayMax
							end
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.LeftPainSequences[math.random(#self.LeftPainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end

						if hitgroup == HITGROUP_RIGHTARM and CurTime() > self.LastStun and !self:GetCrawler() then
							if self.PainSounds and !self:IsDecapitated() then
								self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
								self.NextSound = CurTime() + self.SoundDelayMax
							end
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.RightPainSequences[math.random(#self.RightPainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end
						if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun and !self:GetCrawler() then
							if self.PainSounds and !self:IsDecapitated() then
								self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
								self.NextSound = CurTime() + self.SoundDelayMax
							end
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end
					end
					if (self.LlegOff or self.RlegOff) and !self.HasBeenCrippled then
						if self.PainSounds and !self:IsDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.HasBeenCrippled = true
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.CrawlerPainSequences[math.random(#self.CrawlerPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

		end
	end

	function ENT:CreateCrawler()
		timer.Simple(0, function() -- Need to delay it till next tick otherwise it doesn't work. //its like 3arcs 'waitnetworkedframe'
			if !IsValid(self) then return end
			if !self:IsAlive() then return end
			if self:Health() <= 0 then return end
			if self.Dying then return end

			if self.CanBleed then
				self:EmitSound("nz_moo/zombies/gibs/bodyfall/fall_0"..math.random(2)..".mp3",100)
			end

			if !self:GetSpecialAnimation() and !self:GetCrawler() and !self.HasBeenCrippled then
				if self.PainSounds and !self:IsDecapitated() then
					self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
					self.NextSound = CurTime() + self.SoundDelayMax
				end
				self.HasBeenCrippled = true
				self.IsBeingStunned = true
				self:DoSpecialAnimation(self.CrawlerPainSequences[math.random(#self.CrawlerPainSequences)], true, true)
				self.IsBeingStunned = false
				self.LastStun = CurTime() + 8

				self:ResetMovementSequence()
			end
			self:BecomeCrawler() -- Is it's own separate function for ease of doing other things.
		end)
	end

	function ENT:GibArmL()
		if not IsValid(self) then return end
		if self.LArmOff then return end
		self.LArmOff = true
		self.HasGibbed = true

		local lelbone = self:LookupBone("j_elbow_le")
		if lelbone then
			self:DeflateBones({
				"j_elbow_le",
				"j_wrist_le",
				"j_wristtwist_le",
				"j_thumb_le_1",
				"j_thumb_le_2",
				"j_thumb_le_3",
				"j_index_le_1",
				"j_index_le_2",
				"j_index_le_3",
				"j_mid_le_1",
				"j_mid_le_2",
				"j_mid_le_3",
				"j_ring_le_1",
				"j_ring_le_2",
				"j_ring_le_3",
				"j_pinky_le_1",
				"j_pinky_le_2",
				"j_pinky_le_3",
			})

			if not self.MarkedForDeath and self.CanBleed then
				self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
				ParticleEffectAttach(self.Blood[self.BloodType].DismemberFX, 4, self, 5)
			end
		end
		self:OnGib(1)
	end

	function ENT:GibArmR()
		if not IsValid(self) then return end
		if self.RArmOff then return end
		self.RArmOff = true
		self.HasGibbed = true

		local relbone = self:LookupBone("j_elbow_ri")
		if relbone then
			self:DeflateBones({
				"j_elbow_ri",
				"j_wrist_ri",
				"j_wristtwist_ri",
				"j_thumb_ri_1",
				"j_thumb_ri_2",
				"j_thumb_ri_3",
				"j_index_ri_1",
				"j_index_ri_2",
				"j_index_ri_3",
				"j_mid_ri_1",
				"j_mid_ri_2",
				"j_mid_ri_3",
				"j_ring_ri_1",
				"j_ring_ri_2",
				"j_ring_ri_3",
				"j_pinky_ri_1",
				"j_pinky_ri_2",
				"j_pinky_ri_3",
			})

			if not self.MarkedForDeath and self.CanBleed then
				self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
				ParticleEffectAttach(self.Blood[self.BloodType].DismemberFX, 4, self, 6)
			end
		end
		self:OnGib(2)
	end

	function ENT:GibLegL()
		if not IsValid(self) then return end
		if self.LlegOff then return end
		self.LlegOff = true
		self.HasGibbed = true

		local lleg = self:LookupBone("j_knee_le")
		if lleg then
			self:DeflateBones({
				"j_knee_le",
				"j_knee_bulge_le",
				"j_ankle_le",
				"j_ball_le",
			})

			if not self.MarkedForDeath and self.CanBleed then
				self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
				ParticleEffectAttach(self.Blood[self.BloodType].DismemberFX, 4, self, 7)
			end
		end
		self:OnGib(3)
	end

	function ENT:GibLegR()
		if not IsValid(self) then return end
		if self.RlegOff then return end
		self.RlegOff = true
		self.HasGibbed = true

		local rleg = self:LookupBone("j_knee_ri")
		if rleg then
			self:DeflateBones({
				"j_knee_ri",
				"j_knee_bulge_ri",
				"j_ankle_ri",
				"j_ball_ri",
			})

			if not self.MarkedForDeath and self.CanBleed then
				self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
				ParticleEffectAttach(self.Blood[self.BloodType].DismemberFX, 4, self, 8)
			end
		end
		self:OnGib(4)
	end

	function ENT:GibRandom()
		if not IsValid(self) then return end
		if self.HasGibbed then return end

		local gib = math.random(4)
		if gib == 1 then
			self:GibArmL()
		elseif gib == 2 then
			self:GibArmR()
		elseif gib == 3 then
			self:GibLegL()
		elseif gib == 4 then
			self:GibLegR()
		end
	end

	function ENT:GibHead()
		if self:IsDecapitated() then return end
		self:SetDecapitated(true)

		if !self.IsMooSpecial and self.CanGib then
			if IsValid(self.spritetrail) and IsValid(self.spritetrail2) then
				SafeRemoveEntity(self.spritetrail)
				SafeRemoveEntity(self.spritetrail2)
			end

			if IsValid(self.xmas) then self.xmas:Remove() end

			local head = self:LookupBone("ValveBiped.Bip01_Head1")
			if !head then head = self:LookupBone("j_head") end

			if head and !self.IsMooSpecial then

				self:DeflateBones("j_head")

				if self.CanBleed then
					local neck = self:LookupBone("j_neck")

					self:EmitSound(self.HeadGibSounds[math.random(#self.HeadGibSounds)], 100, math.random(95,105))
					--self:EmitSound("nz_moo/zombies/gibs/death_nohead/death_nohead_0"..math.random(2)..".mp3", 85, math.random(95,105))
					ParticleEffectAttach(self.Blood[self.BloodType].HeadGibFX, 4, self, 10)

					--[[if neck then
						self.GibStumpHead = ents.Create("nz_prop_effect_attachment")
				        self.GibStumpHead:SetModel("models/moo/_codz_ports_props/t10/c_zmb_dismembered_gib_cap/p10_c_zmb_dismembered_gib_cap.mdl")
				        self.GibStumpHead:SetPos(self:GetBonePosition(neck))
						self.GibStumpHead:SetAngles(self:GetAngles() + Angle(0,0,0))
				        self.GibStumpHead:SetParent(self, 10)
						self.GibStumpHead:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
						self.GibStumpHead:SetModelScale(1, 0)
						self.GibStumpHead:Spawn()
					end]]
				end
			end
		end

		self:OnGib(5)
	end

	function ENT:OnGib(gib) -- Called when a zombie is gibbed in any way.
		//1 = Left Arm
		//2 = Right Arm
		//3 = Left Leg
		//4 = Right Leg
		//5 = Head
	end

	function ENT:IsDecapitated()
		if self:GetDecapitated() and !self.IsENVZombie then
			return true
		elseif self.IsENVZombie or !self:GetDecapitated() then
			return false
		end
	end

	function ENT:OnKilled(dmginfo)
		-- Moo Mark 5/16/23: Trying something where the Kill func is dead died body fell to pieces :nerd:
		--if dmginfo and self:IsAlive() then -- Only call once!
			-- self:TimeOut(0) -- This consistently makes zero health zombies!!! Thats actually a good thing believe it or not.
			-- Actually gonna keep the TimeOut above to consistently make zero health zombies for testing.

			if IsValid(self.spritetrail) and IsValid(self.spritetrail2) then
				SafeRemoveEntity(self.spritetrail)
				SafeRemoveEntity(self.spritetrail2)
			end

			if self.NZBossType or self.IsMooBossZombie then
				self:SetShouldCount(false) -- Bosses never count towards the round when they're alive, so why should they when they are killed.
			end

			if dmginfo:IsDamageType(DMG_SHOCK) and math.random(100) > 50 then //Random head-pop
				self:GibHead()
				self:EmitSound("TFA_BO3_WAFFE.Pop")
			end

			if (nzPowerUps:IsPowerupActive("insta")) then
				self:GibHead()
			end

			if IsValid(self) then
				local lowhealthpercent = (self:Health() / self:GetMaxHealth()) * 100 -- Copied one of 3arcs many checks for head gibbing.
				local hitpos = dmginfo:GetDamagePosition()
				local head = self:LookupBone("j_head")
				local headpos

				if head then 
					headpos = self:GetBonePosition(head)
				else
					headpos = self:EyePos() 
				end
					
				if lowhealthpercent <= 50 and !self:IsDecapitated() then
					if (hitpos:DistToSqr(headpos) < 15^2) then -- Only do the check if the lowhealthpercent check goes through.
						self:GibHead()
					end
				end
			end

			self:SetIsAlive(false)
		
			if (self.NZBossType or self.IsMooBossZombie) then
                hook.Call("OnBossKilled", nil, self, dmginfo)
            end

			if self:GetShouldCount() then
				hook.Call("OnZombieKilled", GAMEMODE, self, dmginfo)
			end

			if self:GetShouldCount() then
				nzEnemies:OnEnemyKilled(self, dmginfo:GetAttacker(), dmginfo, 0)
			end

            if self.NZBossType then
                local data = nzRound:GetBossData(self.NZBossType)
                if data then
                    local shitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
                    if data.deathfunc then data.deathfunc(self, dmginfo:GetAttacker(), dmginfo, shitgroup) end
                end
            end
            
			-- 5/15/24: Burning Zombie death moved here.
			if self.ZombieIgnited and !self.Dying and !self.IsMooSpecial and !self.IsMooBossZombie and !self.NZBossType then
    			self:Explode( math.random( 25, 50 ))
			end

			if self:GetShadowBuff() and !self.Dying and !self.IsMooSpecial and !self.IsMooBossZombie and !self.NZBossType and !self.Exploded then
				self.Exploded = true

				local fuckercloud = ents.Create("nz_ent_shadow_trap")
				fuckercloud:SetPos(self:GetPos())
				fuckercloud:SetAngles(self:GetAngles())
				fuckercloud:Spawn()
			end

			if self.DUCKS then
				self:EmitSound(self.QuacknarokPopSounds[math.random(#self.QuacknarokPopSounds)], 85, math.random(95,105))
				self:EmitSound(self.QuacknarokDeflateSounds[math.random(#self.QuacknarokDeflateSounds)], 85, math.random(95,105))
				self:EmitSound(self.QuacknarokQuackSounds[math.random(#self.QuacknarokQuackSounds)], 85, math.random(95,105))
			end

			self:ClearBigJumpNav()

			self:RemoveTrigger()
			self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self:PerformDeath(dmginfo)
		--end
	end

	function ENT:PostDeath(dmginfo) end -- Called when you want something to happen after the zombie dies...

	function ENT:PerformDeath(dmginfo)
		
		self.Dying = true

		local damagetype = dmginfo:GetDamageType()
		local damageforce = dmginfo:GetDamageForce()
		local damagetotal = dmginfo:GetDamage()

		local specialanimation = self:GetSpecialAnimation()

		-- I was literally watching a decino video on how Doom's enemy AI worked, and he mentioned how the health determines if the enemy should gib or not.
		local doom = self:GetMaxHealth() - (self:GetMaxHealth() * 2)

		local specialdeath
		if self.RiserDeathAnimation and isstring(self.RiserDeathAnimation) then
			specialdeath = self.RiserDeathAnimation
		elseif self.VignDeathAnimation and (self.IsENVZombie or self.ENVZombieAwoken) then
			specialdeath = self.VignDeathAnimation
		end

		self:PostDeath(dmginfo)

		if damagetype == DMG_DISSOLVE then
			self:DissolveEffect()
		end

		-- Sleeping/Riser Zombie specific death animations.
		if isstring(specialdeath) and self:HasSequence(specialdeath) then
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			end
			self:DoDeathAnimation(specialdeath)
			return
		end

		if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
			if self.LaunchSounds then
				self:PlaySound(self.LaunchSounds[math.random(#self.LaunchSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
				self.Launched = true
			end
			self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
		end
		if damagetype == DMG_REMOVENORAGDOLL then
			self:Remove(dmginfo)
		end
		
		-- Doom logic and high force can cause them to evaporate.
		if damagetype == DMG_ALWAYSGIB --[[or (self:RagdollForceTest(dmginfo:GetDamageForce()) and self:Health() <= doom)]] then
			self:EmitSound(self.BloodExplodeSounds[math.random(#self.BloodExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect(self.Blood[self.BloodType].ExplodeFX, self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
			self:Remove(dmginfo)
		end

		if IsValid(self.Target) and self.Target.BHBomb and !self.IsMooSpecial then
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			end
			if self:GetCrawler() then
				self:DoDeathAnimation(self.CrawlBlackHoleDeathSequences[math.random(#self.CrawlBlackHoleDeathSequences)])
			else
				self:DoDeathAnimation(self.BlackHoleDeathSequences[math.random(#self.BlackHoleDeathSequences)])
			end
		end
		if specialanimation or self.DeathRagdollForce == 0 or !self.DeathSequences then
			if self.DeathSounds and !self.Launched then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			end
			self:BecomeRagdoll(dmginfo)
		else
			if self:GetCrawler() then
				if self:RagdollForceTest(dmginfo:GetDamageForce()) then
					if self.DeathSounds then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:BecomeRagdoll(dmginfo)
				elseif damagetype == DMG_SHOCK or damagetype == DMG_DISSOLVE then
					if self.ElecSounds then	
						self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.CrawlTeslaDeathSequences[math.random(#self.CrawlTeslaDeathSequences)])
				else
					if self.DeathSounds then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.CrawlDeathSequences[math.random(#self.CrawlDeathSequences)])
				end
			else
				if self:RagdollForceTest(dmginfo:GetDamageForce()) and !dmginfo:IsExplosionDamage() then
					if self.DeathSounds and !self.Launched then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.HeavyDeathSequences[math.random(#self.HeavyDeathSequences)])
				elseif self:RagdollForceTest(dmginfo:GetDamageForce()) and dmginfo:IsExplosionDamage() then
					if self.DeathSounds then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.BlastDeathSequences[math.random(#self.BlastDeathSequences)])
				elseif damagetype == DMG_SHOCK or damagetype == DMG_DISSOLVE then
					if self.ElecSounds then
						self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.ElectrocutionSequences[math.random(#self.ElectrocutionSequences)])
				elseif self:IsOnFire() then
					if self.FireDeathSounds then
						self:PlaySound(self.FireDeathSounds[math.random(#self.FireDeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					elseif self.ElecSounds then
						self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.FireStaffDeathSequences[math.random(#self.FireStaffDeathSequences)])
				elseif damagetype == DMG_SLASH then
					if self.DeathSounds then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.MeleeDeathSequences[math.random(#self.MeleeDeathSequences)])
				else
					if self.DeathSounds and !self.Launched then
						self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
					end
					self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
				end
			end
		end
	end

	function ENT:OnNuke() end -- Called when a Nuke powerup goes off.

	function ENT:DoDeathAnimation(seq,noragdoll,triggerfakekill)
		self.BehaveThread = coroutine.create(function()
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove(seq, 1)

			if !triggerfakekill then
				if !noragdoll then
					self:BecomeRagdoll(DamageInfo())
				else
					self.NoRagdoll = true
					self:Remove(DamageInfo())
				end
			else
				self:FakeKillZombie(true)
			end
		end)
	end


	--[[ 
		The DoSpecialAnimation function is probably one of the most important functions in this whole base.
		Instead of doing something like PlaySequenceAndWait, you could use this function instead.
		This function pauses the main coroutine and creates a temporary one.
		You can also have the bot keep their collision or allow them to be able to cancel the anim.
		By default, bots lose their collision and can't cancel the anim. 
		Allowing them to cancel their anim or not can be a touchy one though so becareful how you use it.
	]]--

	function ENT:DoSpecialAnimation(seq, collision, cancancel, hasgravity, mask, facetarget)
		if !self:IsAlive() then return end
		collision = collision or false -- Works in conjunction with "SolidMaskDuringEvent" so you can decide if the zombie should keep their collision or not during the special anim.
		cancancel = cancancel or false -- Did this so zombies don't appear to be "Stuck in time" when trying to play a special anim while they're currently playing one.
		hasgravity = hasgravity or true
		mask = mask or MASK_PLAYERSOLID
		facetarget = facetarget or false

		if !self:HasSequence(seq) then return end -- Back out, the entity doesn't have a given sequence.

		self:TempBehaveThread(function(self)
			--self:TimeOut(0)
			self:SetSpecialAnimation(true)
			if cancancel then
				self.CanCancelSpecial = true
			else
				self.CanCancelSpecial = false
			end

			self:SolidMaskDuringEvent(mask, collision)
			self:PlaySequenceAndMove(seq, false)
			if !self:GetSpecialShouldDie() and IsValid(self) and self:IsAlive() or (self.ZCTGivePinkStats and IsValid(self) and self:IsAlive()) then -- COMMON NZ VALID W
				self:CollideWhenPossible()
				self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				self.CanCancelSpecial = false
			else
				self:TimeOut(666)
			end
		end)
	end

	function ENT:BecomeCrawler() -- For turning into Crawlers.
		if !self:IsAlive() then return end
		if self.Dying then return end
		self:SetCrawler(true) -- CRIPPLE THEIR SORRY ASSES!!!
		self:SetCollisionBounds(Vector(-10,-10, 0), Vector(10, 10, 26))
	end

	function ENT:BecomeNormal() -- For turning back to normal, i.e they get their legs back.
		if !self:IsAlive() then return end
		if self.Dying then return end
		self:SetCrawler(false) -- Uncripple them, they may just be doing something funny.
		self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 72))
	end

	function ENT:DeflateBones(tbl,ent)
		if !IsValid(self) then return end

		if istable(tbl) then
			for i,b in pairs(tbl) do
				if self:LookupBone(b) then
					self:ManipulateBoneScale(self:LookupBone(b),Vector(0.0000001,0.0000001,0.0000001))
				end
			end
		elseif isstring(tbl) then
			local bone = self:LookupBone(tbl)
			local childs = self:GetChildBones(bone)


			self:ManipulateBoneScale(bone,Vector(0.0000001,0.0000001,0.0000001))
			if istable(childs) then
				for i,b in pairs(childs) do
					if isnumber(b) then
						self:ManipulateBoneScale(b,Vector(0.0000001,0.0000001,0.0000001))
					end
				end
			end
		end
	end
end

function ENT:FakeKillZombie(respawn)

	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:SetIsAlive(false)
	self:SetShouldCount(false)

	if self.DeathSounds then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	end

	self:Remove()
	print("Uh oh Mario, I've suffered a fatal heart attack!")

	if respawn then
		if self:GetSpawner() then
			self:GetSpawner():IncrementZombiesToSpawn()
			self:GetSpawner():DecrementZombiesToSpawn()
		end
	end
end


-- A standard attack you can use it or create something fancy yourself
function ENT:Attack( data )

	self:OnAttack()

	self:SetStuckCounter(0)
	local useswalkframes = false

	data = data or {}
			
	data.attackseq = data.attackseq
	if !data.attackseq then

		local attacktbl = self.AttackSequences

		if nzMapping.Settings.badattacks == 1 and self.Bo3AttackSequences or self.IsTurned and self.Bo3AttackSequences then
			attacktbl = self.Bo3AttackSequences
		end

		self:SetStandingAttack(false)

		if self:GetCrawler() then
			attacktbl = self.CrawlAttackSequences
		end

		if self:GetTarget():GetVelocity():LengthSqr() < 15 and self:TargetInRange( self.AttackRange - 15 ) and !self:GetCrawler() and !self.IsTurned then
			if self.StandAttackSequences then -- Incase they don't have standing attack anims.
				attacktbl = self.StandAttackSequences
			end
			self:SetStandingAttack(true)
		end

		local target = type(attacktbl) == "table" and attacktbl[math.random(#attacktbl)] or attacktbl

		
		if type(target) == "table" then
			local id, dur = self:LookupSequenceAct(target.seq)
			if target.dmgtimes then
				data.attackseq = {seq = id, dmgtimes = target.dmgtimes }
				useswalkframes = false
			else
				data.attackseq = {seq = id} -- Assume that if the selected sequence isn't using dmgtimes, its probably using notetracks.
				useswalkframes = true
			end
			data.attackdur = dur
		elseif target then -- It is a string or ACT
			local id, dur = self:LookupSequenceAct(attacktbl)
			data.attackseq = {seq = id, dmgtimes = {dur/2}}
			data.attackdur = dur
		else
			local id, dur = self:LookupSequence("swing")
			data.attackseq = {seq = id, dmgtimes = {1}}
			data.attackdur = dur
		end
	end
	
	self:SetAttacking( true )
	if IsValid(self:GetTarget()) and self:GetTarget():Health() and self:GetTarget():Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
		if data.attackseq.dmgtimes then
			for k,v in pairs(data.attackseq.dmgtimes) do
				self:TimedEvent( v, function()
					if self.AttackSounds then self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2) end
					self:EmitSound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_0"..math.random(0,2)..".mp3", 75)
					self:DoAttackDamage()
				end)
			end
		end
	end

	self:TimedEvent(data.attackdur, function()
		self:SetAttacking(false)
	end)

	if useswalkframes then
		self:PlaySequenceAndMove(data.attackseq.seq, 1, self.FaceEnemy)
		self:SetAttacking(false)
	else
		self:PlayAttackAndWait(data.attackseq.seq, 1)
		self:SetAttacking(false)
	end

	self:CollideWhenPossible()
	self:PostAttack()
end

-- Do something when attack is started.
function ENT:OnAttack() end

-- Do something when attack is finished.
function ENT:PostAttack() end

function ENT:DoAttackDamage() -- Moo Mark 4/14/23: Made the part that does damage during an attack its own function.
	local ct = CurTime()

	local target = self:GetTarget()

	-- Don't do damage to the target if they're timing out, that ain't fair.
	if IsValid(target) and target:IsPlayer() and target:IsTimingOut() then 
		self:Retarget()
		return 
	end

	local damage = self.AttackDamage
	local dmgrange = self.DamageRange
	local range = self.AttackRange

	local impsnd = self.AttackImpactSounds

	if self.CustomAttackImpactSounds then
		impsnd = self.CustomAttackImpactSounds
	end

	if self.HeavyAttack then
		damage = self.HeavyAttackDamage
		self.HeavyAttack = false

		if self.HeavyAttackImpactSounds then
			impsnd = self.HeavyAttackImpactSounds
		end
	end

	-- Don't do damage if it isn't an arm reach, the nextbot could be using attack anims for the barricades.
	if self:GetIsBusy() and !self.BarricadeArmReach then return end

	-- This is for arm reaching, its large enough to hit the player MOST of the times.
	if self:GetIsBusy() then
		range = self.AttackRange + 45
		dmgrange = self.DamageRange + 45
	else
		range = self.AttackRange + 25
	end

	if self:WaterBuff() and self:BomberBuff() then
		damage = damage * 3
	elseif self:WaterBuff() then
		damage = damage * 2
	end

	if ct > self:GetLastAttack() then

		self:SetLastAttack(CurTime() + 0.05)
		if IsValid(target) and target:Health() and target:Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
			
			if self:TargetInRange( range ) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetAttacker( self )
				dmgInfo:SetDamage( damage )
				dmgInfo:SetDamageType( DMG_SLASH )

				if self:TargetInRange( dmgrange ) then
					if self.UseCustomAttackDamage then
						self:CustomAttackDamage(target, damage)
					else
						target:TakeDamageInfo(dmgInfo)
					end

					if self.ZCTPersonality == 0 then
						if target:IsPlayer() then
							target:ViewPunch( VectorRand():Angle() * 0.05 )
							if target:IsOnGround() then
								target:SetVelocity( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 30 ) )
							end
						end
					end

					if comedyday or math.random(500) == 1 then
						if self.GoofyahAttackSounds then target:EmitSound(self.GoofyahAttackSounds[math.random(#self.GoofyahAttackSounds)], SNDLVL_GUNFIRE, math.random(95,105)) end
					else
						target:EmitSound(impsnd[math.random(#impsnd)], SNDLVL_GUNFIRE, math.random(95,105))
					end
				end
			end
		end
	end
end

-- function ENT:CustomAttackDamage(target, dmg) end

function ENT:PlayAttackAndWait( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed )

	local endtime = CurTime() + len / speed

	while ( true ) do

		if ( endtime < CurTime() ) then
			if !self:GetStop() then
			if !self:GetCrawler() then
					self.loco:SetDesiredSpeed( self:GetRunSpeed() )
				end
			end
			return
		end
		if self:IsValidTarget( self:GetTarget() ) then
			if !self:IsStandingAttack() and !self:GetCrawler() then
				self.loco:SetDesiredSpeed( self:GetRunSpeed() )
				self.loco:Approach( self:GetTarget():GetPos(), 10 )
				self.loco:FaceTowards( self:GetTarget():GetPos() )
			end
		end
		coroutine.yield()
	end
end


if SERVER then
	function ENT:Retarget() -- Causes a retarget
		if self:GetTargetLocked() and self:IsValidTarget(self.Target) then return end

		local target, dist = self:GetPriorityTarget()
		self.Target = target
		self:SetNextRetarget(self:CalculateNextRetarget(target, dist))
	end

	-- Lets your determine what target to go for next upon retargeting
	function ENT:GetPriorityTarget() -- We're using a modified version of the nZu targetting code... This mainly improves performance in multiplayer games.
		self:SetLastTargetCheck( CurTime() )

		local target = nil
		local highestPriority = TARGET_PRIORITY_NONE
		local mindist = self:GetTargetCheckRange()
		local zobie = self


		for k,v in nzLevel.GetTargetableArray() do
			if !IsValid(v) then continue end
			if IsValid(v) and v == zobie then continue end -- Ignore self during targetting, I highly doubt you'd ever wanna have the zombie target themself.

			-- Ignore a player who might be timing out. They may come back from it so leave them alone as to not unfairly kill them.
			if v:IsPlayer() and v:IsTimingOut() then continue end 
			if v:IsPlayer() and !v:Alive() then continue end

			--[[
			-- Having this commented out for, it drops fps slightly more when enabled. So for now, I'm just gonna leave it here for later.
			if v:IsPlayer() and v:Alive() and !v:IsTimingOut() then
				local nav = navmesh.GetNearestNavArea(v:GetPos(), false, 65, false, true, -2) -- Check for a nav square, if theres one near by.
				local ply = v:IsOnGround()

				if IsValid(nav) then
					local zone = nzNav.NavGroups[nav:GetID()]
					if zone == "notarget" then continue end
				end
			end
			]]

			local d = self:GetRangeTo(v)

			if v:GetTargetPriority() == TARGET_PRIORITY_ALWAYS then 
				target = v
				mindist = d
				return target, mindist
			end

			if v:GetTargetPriority() == TARGET_PRIORITY_SPECIAL and (self.IsMooSpecial and self.MooSpecialZombie or self.IsMooSpecial and self.IsMooCryptid or !self.IsMooSpecial) and !self.IsMooBossZombie or d < mindist and self:IsValidTarget(v) then
				target = v
				mindist = d
				--print(target, mindist)
			end
		end

		return target, mindist
	end

	function ENT:FleeTarget(time) -- instead of pathing TO a player, it paths AWAY from them
		local target = self:GetTarget()
		if !IsValid(target) then return end

		--[[local tr = util_traceline({
			start = self:GetPos() + Vector(0,0,50),
			endpos = self:GetFleeDestination(target) + Vector(0,0,50),
			filter = self,
			collisiongroup = COLLISION_GROUP_DEBRIS
		})

		if tr.Hit then return end]]

		self:SetFleeing(true)

		timer.Create(self:GetClass() .. "FleeingTarget" .. self:EntIndex(), time, 1, function()
			if IsValid(self) and self:GetFleeing() then
				self:SetFleeing(false)
			end
		end)
	end

	function ENT:StopFleeing() -- Cancel the fleeing
		--self:SetLastFlee(CurTime())
		self:SetFleeing(false)
	end

	-- Code Credit: Dragoteryx
	function ENT:ShouldCompute(self, path, pos)
		if not IsValid(path) then return true end
		local path_length = path:GetLength()
		local cursor_pos = path:GetCursorPosition()
		local remaining_length = path_length - cursor_pos
		return self.PathLastSegment.pos:Distance(pos)
			> remaining_length / 2
	end

	function ENT:ChaseTarget( options )

		local options = options or {}

		local path = self:ChaseTargetPath()	-- Compute the path towards the enemy's position
		local distToTarget = self:GetPos():DistToSqr(self:GetTargetPosition())

		local slowpth = 1.5 + self.RepathTimeMod
		local quickpth = 0.5 + self.RepathTimeMod

		if ( !path:IsValid() ) then return "failed" end

		while ( path:IsValid() and self:HasTarget() and !self:TargetInAttackRange() and !self.Big_Jump_area_start ) do
			local goal = path:GetCurrentGoal()

			self.PathAllSegments = path:GetAllSegments()
			self.PathLength = path:GetLength()
			self.PathLastSegment = path:LastSegment()
		
			path:Update( self )
			self:SetTargetUnreachable( false )

			if path:IsValid() and !self.CancelCurrentPath then -- This is pulled from Ba2 for distance based repathing.	

				local slowequa = distToTarget / 1000^2
				local quickequa = distToTarget / 295^2

				-- This is allows bots to pass through squares with a jump attribute without having to interact with them and treat them as normal squares.
				if goal then
					--PrintTable(goal)
					--print(0.25 + self.RepathTimeMod)

					--self:PlayTurnAround(goal)
					if goal.type >= 1 then
						self.TestForBigJump = true
					elseif goal.type < 1 then
						self.TestForBigJump = false
					end
					self.GoalType = goal.type
				end

				if (distToTarget > 850^2) then
					if path:GetAge() > math.Clamp(slowequa,slowpth,15) then
						return "timeout"
					end
				else
					if path:GetAge() > math.Clamp(quickequa,quickpth,2) then -- We're closing in, let's start repathing sooner!
						if quickequa < 0.75 then
							self.AttemptCutoff = true
						else
							self.AttemptCutoff = false
						end
						return "timeout"
					end
				end
			else
				if self.CancelCurrentPath then
					self.CancelCurrentPath = false -- Reset the bool for future use.
				end
				return "timeout"
			end

			if (!self:GetAttacking() and !self:GetSpecialAnimation() and self:IsOnGround() and !self:GetJumping()) or (!self:IsOnGround() and self:GetJumping()) then
				self:ResetMovementSequence() -- This is the main point that starts the movement anim. Moo Mark
			end
			
			if self:IsMovingIntoObject() then
            	--self:ApplyRandomPush(100)
            	--self.SameSquare = false
        	end

			-- If we're stuck, then call the HandleStuck function and abandon
			if ( self.loco:IsStuck() ) then
				self:HandleStuck()
				return "stuck"
			end

			coroutine.yield()

		end

		return "ok"

	end

	function ENT:ChaseTargetPath()

		local path = Path( "Follow" )
		self.Path = path

		local target = self:GetTargetPosition()
		local lookahead = 2000
		local tolerance = 25

		-- They turn into common infected and can attempt to predict where their target will be and try to cut them off.
		if self.CanCutoff and self.AttemptCutoff then
			target = self:GetTargetPosition() + self.Target:GetVelocity() * math.Clamp(self.Target:GetVelocity():Length2D(),0,0.35)
		end

		local nav = navmesh.GetNavArea(self:GetPos(), 15)
		if IsValid(nav) then
			-- Lets you control if bots should have "snap" movement, good for navigating tight spaces when disabled.
			if nav:HasAttributes(NAV_MESH_PRECISE) then
				self.SameSquare = false
			else
				self.SameSquare = true
			end
		end

		path:SetMinLookAheadDistance( lookahead )
		path:SetGoalTolerance( tolerance ) -- Don't let this be near or higher than the attack range...

		--path:Compute(self, target, self.ComputePath) -- The normal path generator.

		path:Compute( self, target, function( area, fromArea, ladder, elevator, length )
			if ( !IsValid( fromArea ) ) then
				// first area in path, no cost
				return 0
			else
				if ( !self.loco:IsAreaTraversable( area ) ) then return -1 end
				// compute distance traveled along path so far
				local dist = 0
				local cost = dist + fromArea:GetCostSoFar()

				// check height change
				local deltaZ = fromArea:ComputeAdjacentConnectionHeightChange( area )
				if deltaZ >= self.loco:GetStepHeight() then
					if deltaZ >= self.loco:GetMaxJumpHeight() then
						if !fromArea:HasAttributes(NAV_MESH_JUMP) then
							return -1
						end
					end
					// jumping is slower than flat ground
					local jumpPenalty = 5
					cost = cost + jumpPenalty * 0
				elseif deltaZ < -self.loco:GetDeathDropHeight() then
					// too far to drop
					return -1
				end
				return cost
			end
		end )

		return path
	end

	function ENT:BigJumpThink()
		-- [[Big Jump Code By: Chtidino]] --

		if !self.Big_Jump_area_start and CurTime() < self.BigJumpCooldown then return end
		if self.Dying then return end

		-- There can be rare times where a bot is doing something weird with their movement and get softlocked at a jump nav.(I.e Wustling or Abom charge.)
		if self.BlockBigJumpThink then self:FinishBigJumpClimb() return end

		local seq = self.ZombieLedgeClimbSequences[math.random(#self.ZombieLedgeClimbSequences)]
		local seq2 = self.ZombieLedgeClimbLoopSequences[math.random(#self.ZombieLedgeClimbLoopSequences)]
		local seq3 = self.ZombieLedgeClimbMantleOverSequences[math.random(#self.ZombieLedgeClimbMantleOverSequences)]

		-- If the bot is caught on anything during the jump(Most commonly the world), just force them to their destination after 5 seconds.
		if self.Big_Jump_area_start and self.Big_Jump_area_end and self.On_Big_Jump and CurTime() > self.BigJumpTime then
			self.BigJumpTime = 0

			self:SetPos(LerpVector( 1, self:GetPos(), self.Big_Jump_area_end:GetCenter()))
			self.On_Big_Jump = "down" -- Force the jump to complete.
		end

		if self.Big_Jump_area_start and !self.Big_Jump_area_end and !self.On_Big_Jump then
		
			self:SetIsBusy(true)
			self.SameSquare = false

			self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

			self:ResetMovementSequence()

			self.loco:Approach( self.Big_Jump_area_start:GetCenter(), 1000)
			local min,max = self:GetCollisionBounds()
				
			if self.PathAllSegments then
				
				local dir = self.Big_Jump_area_start:ComputeDirection(self:GetPos() + (self:GetForward()*10))
				local tblnextnav = self.Big_Jump_area_start:GetAdjacentAreas()
				--local tblnextnav = self.Big_Jump_area_start:GetAdjacentAreasAtSide(dir)
				local validnav = nil
				
				local dir_oppose = {
					[0] = 2,
					[1] = 3,
					[2] = 0,
					[3] = 1
				}
				
				for k,v in pairs(tblnextnav) do
					
					local same = false
					for k2,v2 in pairs(self.PathAllSegments) do
						if v == v2.area then
							same = true
						end
					end

					if table.HasValue(self.Big_Jump_area_start:GetAdjacentAreas(),v) and table.HasValue(v:GetIncomingConnections(),self.Big_Jump_area_start) and same then
					--if table.HasValue(self.Big_Jump_area_start:GetAdjacentAreas(),v) and table.HasValue(v:GetIncomingConnectionsAtSide(dir_oppose[dir]),self.Big_Jump_area_start) and same then
						validnav = v
					end
				end
				
				if validnav then
					self.Big_Jump_area_end = validnav
					nzNav.Reserved[validnav:GetID()] = self
				end
				
			end
			
		elseif self.Big_Jump_area_start and self.Big_Jump_area_end and !self.On_Big_Jump then
			
			self:SetIsBusy(true)
			self.SameSquare = false

			self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

			self.loco:Approach( self.Big_Jump_area_start:GetCenter(), 1000)
			
			if self.Big_Jump_area_start:GetCenter():Distance(self:GetPos()) <= 25 then
				
				local jumpstartseq = self.ZombieJumpStartSequences[math.random(#self.ZombieJumpStartSequences)]

				local hasledge = self.Big_Jump_area_end:HasAttributes(NAV_MESH_OBSTACLE_TOP)
				local smldist = self.Big_Jump_area_end:GetCenter():Distance(self:GetPos())
				local hasrail = self.Big_Jump_area_end:HasAttributes(NAV_MESH_STAND)
				local hasnojump = self.Big_Jump_area_start:HasAttributes(NAV_MESH_NO_JUMP)
			
				--print(smldist)
				if !hasnojump then
					if smldist <= 90 and self:HasSequence(self.ZombieLedgeClimbSmallLoopSequences[math.random(#self.ZombieLedgeClimbSmallLoopSequences)]) then
						self.Big_Jump_area_ledge_small = true
						seq2 = self.ZombieLedgeClimbSmallLoopSequences[math.random(#self.ZombieLedgeClimbSmallLoopSequences)]
					end

					--Do special ledge animation for ledge climbs or jump normally.
					if hasledge and self:HasSequence(seq2) then
						self.loco:Jump()
						self:ResetSequence(seq2)
						self:FaceTowards(self.Big_Jump_area_end:GetCenter())
					else
						self:StartActivity(ACT_JUMP)
						self.loco:Jump()
					end
					self.On_Big_Jump = "up"
				else

					--Teleport from the start square to the destination square instead of actually jumping to it.
					local disappearseq = self.ZombieDespawnSequences[math.random(#self.ZombieDespawnSequences)]
					local appearseq = self.SpawnSequence

					if !istable(self.SpawnSequence) then 
						appearseq = "idle"
					else
						appearseq = self.SpawnSequence[math.random(#self.SpawnSequence)]
					end

					if self:HasSequence(disappearseq) and self:HasSequence(appearseq) then
						self:TempBehaveThread(function(self)
							self.On_Big_Jump = "up"

							--Burrow into the ground.
							self.AllowDustParticle = true
							self:SetSpecialAnimation(true)
							self:PlaySequenceAndMove(disappearseq, {gravity = true})
							self:SetSpecialAnimation(false)

							--Teleport to destination.
							self:SetPos(self.Big_Jump_area_end:GetCenter())

							--Appear at new location.
							self.AllowDustParticle = true
							self:DoZombieSpawnDust()
							self:PlaySequenceAndMove(appearseq, {gravity = true})
							self:SetSpecialAnimation(false)

							--Finish jump behaviour.
							self.On_Big_Jump = "down"
							self.Big_Jump_area_ledge = "reached"
							self:CollideWhenPossible()
							self:FinishBigJumpClimb()
						end)
					else
						self.On_Big_Jump = "up"

						--Play portal effect at current location(from position)
						self:DoZombiePortal()

						--Teleport to destination.
						self:SetPos(self.Big_Jump_area_end:GetCenter())
						self:DoZombiePortal()

						--Finish jump behaviour.
						self.On_Big_Jump = "down"
						self.Big_Jump_area_ledge = "reached"
						self:CollideWhenPossible()
						self:FinishBigJumpClimb()
					end
				end

				self.BigJumpTime = CurTime() + 5
				self.FailedBigJumpApproach = false
			end
		
		elseif self.Big_Jump_area_start and self.Big_Jump_area_end and self.On_Big_Jump then
			
			local distance_xy = math.Distance(self.Big_Jump_area_end:GetCenter().x,self.Big_Jump_area_end:GetCenter().y,self.Big_Jump_area_start:GetCenter().x,self.Big_Jump_area_start:GetCenter().y)

			if self.On_Big_Jump == "up" then
			
				local xy_point = self.Big_Jump_area_end:GetCenter() + ((self.Big_Jump_area_start:GetCenter() - self.Big_Jump_area_end:GetCenter()) * (0.2 + ((self:OBBMaxs().x*(50/(distance_xy*0.5)))/(distance_xy*0.5))))
				local z_point = self.Big_Jump_area_end:GetCenter().z + (math.Clamp(self:OBBMaxs().z*2, 144, math.huge))
				
				if self.Big_Jump_area_end:GetCenter().z < self.Big_Jump_area_start:GetCenter().z then
					xy_point = self.Big_Jump_area_end:GetCenter() + ((self.Big_Jump_area_start:GetCenter() - self.Big_Jump_area_end:GetCenter()) * (0.2 + ((self:OBBMaxs().x*(-35/(distance_xy*0.5)))/(distance_xy*0.5))))
					z_point = self.Big_Jump_area_start:GetCenter().z + (math.Clamp(self:OBBMaxs().z*2, 144, math.huge)) 
				end

				local calc1 = xy_point.x * (((xy_point.x - self:GetPos().x))/xy_point.x)
				local calc2 = xy_point.y * (((xy_point.y - self:GetPos().y))/xy_point.y)
				local calc3 = z_point * (((z_point - self:GetPos().z))/z_point)
				
				local result = Vector(calc1,calc2,calc3)
				
				self.loco:SetVelocity(result/0.5)

				local hasledge = self.Big_Jump_area_end:HasAttributes(NAV_MESH_OBSTACLE_TOP) and !self:GetCrawler()

				if self:GetPos().z >= math.max(self.Big_Jump_area_end:GetCenter().z,self.Big_Jump_area_start:GetCenter().z) + (self:OBBMaxs().z*0.5) and (!hasledge or !self:HasSequence(seq)) 
				or self:GetPos().z >= math.max(self.Big_Jump_area_end:GetCenter().z,self.Big_Jump_area_start:GetCenter().z) - (self:OBBMaxs().z*0.1) and hasledge and self:HasSequence(seq) and self.Big_Jump_area_ledge_small
				or self:GetPos().z >= math.max(self.Big_Jump_area_end:GetCenter().z,self.Big_Jump_area_start:GetCenter().z) - (self:OBBMaxs().z*0.95) and hasledge and self:HasSequence(seq) and !self.Big_Jump_area_ledge_small then
					self.On_Big_Jump = "down"
				end
				
			elseif self.On_Big_Jump == "down" then

				-- For mantle over anim at ledge.
				local hasrail = self.Big_Jump_area_end:HasAttributes(NAV_MESH_STAND)
			
				local xy_point = self.Big_Jump_area_end:GetCenter()
				local z_point = self.Big_Jump_area_end:GetCenter().z + (self:OBBMaxs().z*0.25)

				local z_pointledge = self.Big_Jump_area_end:GetCenter().z + (self:OBBMaxs().z*0.11)
				local hasledge = self.Big_Jump_area_end:HasAttributes(NAV_MESH_OBSTACLE_TOP) and !self:GetCrawler()

				local calc1 = xy_point.x * (((xy_point.x - self:GetPos().x))/xy_point.x)
				local calc2 = xy_point.y * (((xy_point.y - self:GetPos().y))/xy_point.y)
				local calc3 = (z_point * (((z_point - self:GetPos().z))/z_point))
				
				local result = Vector(calc1,calc2,calc3)

				-- Small heights use a faster ledge climb anim
				if self.Big_Jump_area_ledge_small  then
					seq = self.ZombieLedgeClimbSmallSequences[math.random(#self.ZombieLedgeClimbSmallSequences)]
				end

				-- If defined, play a mantle over when at specified ledge.
				if hasrail and self:HasSequence(seq3) then
					local crawlanim = self.ZombieLedgeCrawlClimbMantleOverSequences[math.random(#self.ZombieLedgeCrawlClimbMantleOverSequences)]
					seq = seq3

					-- If a crawler and has the crawler version of the anim, use that instead.
					if self:GetCrawler() and self:HasSequence(crawlanim) then
						seq = crawlanim
					end
				end

				-- Play normal ledge climb when specified ledge is reached... Or just do the normal Big Jump behaviour if told or if the bot doesn't have a ledge climb animation.
				if hasledge and self:HasSequence(seq) then
					self:TempBehaveThread(function(self)
						self.Big_Jump_area_ledge = "reached"
 
						self:FaceTowards(xy_point)
						self:SetPos(Vector(self:GetPos().x,self:GetPos().y,z_pointledge) + (Vector(self:OBBMaxs().x,self:OBBMaxs().y,0) + self:GetForward() * 2))
						self:SetIsBusy(true)
						self:SetSpecialAnimation(true)
						self:PlaySequenceAndMove(seq, {gravity = false})
						self:SetSpecialAnimation(false)
						self:SetIsBusy(false)
						self.SameSquare = true

						self:FinishBigJumpClimb()
					end)
				else
					self.loco:SetVelocity(((self.loco:GetVelocity()) + (result))*0.925)

					-- If the jump was a ledge climb but the bot didn't have a ledge climb anim, we'll wait a second before moving again(Just so they have an easier time when jumps have to be chained together.)
					--[[if hasledge and !self:HasSequence(seq) then
						self:TempBehaveThread(function(self)
							self:TimeOut(1)
						end)
					end]]
				end
				
				local min,max = self:GetCollisionBounds()

				if self:GetPos().z <= self.Big_Jump_area_end:GetCenter().z + (self:OBBMaxs().z*0.2) then
					nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
					nzNav.Reserved[self.Big_Jump_area_end:GetID()] = nil
					self.Big_Jump_area_start = nil
					self.Big_Jump_area_end = nil
					self.On_Big_Jump = nil
					self:SetBlockAttack(false)
					self:SetIsBusy(false)
					self.SameSquare = true

					if self.current_speed then
						self.loco:SetDesiredSpeed(self.current_speed)
						self.current_speed = nil
					end
				end
			end
		end

		-- [[Big Jump Code By: Chtidino]] --
	end

	function ENT:ClearBigJumpNav()
		if self.Big_Jump_area_start then
			if nzNav.Reserved[self.Big_Jump_area_start:GetID()] and nzNav.Reserved[self.Big_Jump_area_start:GetID()] == self then
				nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
			end
		end
		if self.Big_Jump_area_end then
			if nzNav.Reserved[self.Big_Jump_area_end:GetID()] and nzNav.Reserved[self.Big_Jump_area_end:GetID()] == self then
				nzNav.Reserved[self.Big_Jump_area_end:GetID()] = nil
			end
		end
	end

	function ENT:FinishBigJumpClimb()
			if self.Big_Jump_area_ledge == "reached" then

				if self.current_speed then
					self.loco:SetDesiredSpeed(self.current_speed)
					self.current_speed = nil
				end

				if self.Big_Jump_area_start then
					if nzNav.Reserved[self.Big_Jump_area_start:GetID()] and nzNav.Reserved[self.Big_Jump_area_start:GetID()] == self then
						nzNav.Reserved[self.Big_Jump_area_start:GetID()] = nil
					end
					self.Big_Jump_area_start = nil
					self:SetBlockAttack(false)
					if self.current_speed then
						self.loco:SetDesiredSpeed(self.current_speed)
						self.current_speed = nil
					end
				end
				if self.Big_Jump_area_end then
					if nzNav.Reserved[self.Big_Jump_area_end:GetID()] and nzNav.Reserved[self.Big_Jump_area_end:GetID()] == self then
						nzNav.Reserved[self.Big_Jump_area_end:GetID()] = nil
					end
					self.Big_Jump_area_end = nil

				end
				if self.On_Big_Jump then
					self.On_Big_Jump = nil
				end

				if self.Big_Jump_area_ledge then
					self.Big_Jump_area_ledge = nil
					self.Big_Jump_area_ledge_small = nil
					self:SetSpecialAnimation(false)
					self:SetIsBusy(false)
					self.SameSquare = true
				end
						
				if self.On_Jump then
					self.On_Jump = false
					self:SetBlockAttack(false)
					self:SetJumping( false )
					self:SetIsBusy(false)
					self.SameSquare = true
					self.loco:SetVelocity( Vector(0,0,0) )
				end

				if self:IsAlive() then
					self:SetBlockAttack(false)
					self:SetJumping( false )
					self:SetIsBusy(false)
					self.SameSquare = true

					self:CollideWhenPossible()

					if self.InAirTime > 2 and !self:GetSpecialAnimation() then
						local seq = self.ZombieLandSequences[math.random(#self.ZombieLandSequences)]
						if self:HasSequence(seq) and !self:GetCrawler() then
							self:DoSpecialAnimation(seq, false, true, true, MASK_PLAYERSOLID) 
						end
					end

					if self.InAirTime > 0.5 then
						self.BigJumpCooldown = CurTime() + 2
					else
						self.BigJumpCooldown = CurTime() + 0.1
					end
					
					self.InAirTime = 0
					if !self:GetSpecialAnimation() then
					self:ResetMovementSequence()
				end
			end
		end
	end

	function ENT:IsAllowedToMove()
		if self:GetIsBusy() then
			return false
		end
    	if !self:IsOnGround() then
        	return false
    	end
		if self:GetSpecialAnimation() then
			return false
		end	
    	if self:GetJumping() then
    		return false
    	end
    	if self:GetTargetUnreachable() then
        	return false
    	end
    	if self:GetTimedOut() then
        	return false
    	end
		if self:GetSpecialShouldDie() then
			return false
		end	
    	if self.FrozenTime and CurTime() < self.FrozenTime then
        	return false
    	end

    	return true
	end

	function ENT:TargetInAttackRange()
		return self:TargetInRange( self:GetAttackRange() )
	end

	function ENT:TargetInRange( range )
		local target = self:GetTarget()
		if !IsValid(target) then return false end
		return self:GetRangeTo( target:GetPos() ) < range
	end

	local function PointOnSegmentNearestToPoint(a, b, p)
    	local ab = b - a
    	local ap = p - a

    	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
        	t = math.Clamp(t, 0, 1)
    	return a + t*ab
	end

	function ENT:CheckForBarricade()
		--we try a line trace first since its more efficient
		local dataL = {}
		dataL.start = self:GetPos() + Vector( 0, 0, self:OBBCenter().z )
		dataL.endpos = self:GetPos() + Vector( 0, 0, self:OBBCenter().z ) + self.BarricadeCheckDir * 7
		dataL.filter = function( ent ) if ( ent:GetClass() == "breakable_entry" ) then return true end end
		dataL.ignoreworld = true
		local trL = util_traceline( dataL )

		debugoverlay.Line(self:GetPos() + Vector( 0, 0, self:OBBCenter().z ), self:GetPos() + Vector( 0, 0, self:OBBCenter().z ) + self.BarricadeCheckDir * 7)
		debugoverlay.Cross(self:GetPos() + Vector( 0, 0, self:OBBCenter().z ), 1)

		if IsValid( trL.Entity ) and trL.Entity:GetClass() == "breakable_entry" then
			return trL.Entity, trL.HitNormal
		end

		-- Perform a hull trace if line didnt hit just to make sure
		local dataH = {}
		dataH.start = self:GetPos()
		dataH.endpos = self:GetPos() + self.BarricadeCheckDir * 7
		dataH.filter = function( ent ) if ( ent:GetClass() == "breakable_entry" ) then return true end end
		dataH.mins = self:OBBMins() * 0.65
		dataH.maxs = self:OBBMaxs() * 0.65
		dataH.ignoreworld = true
		local trH = util_tracehull(dataH )

		if IsValid( trH.Entity ) and trH.Entity:GetClass() == "breakable_entry" then
			return trH.Entity, trH.HitNormal
		end

		return nil

	end

	--[[-------------------------------------------------------------------------
	1/4/24: New function that allows you to pause the bot's coroutine and approach a given position.
			This is here in case you don't want to use "MoveToPos", while this function has a similar purpose.
			The bot doesn't move to the given position via navmesh and will literally move in a straight line towards the given position.
			Using this in certain instances can probably be better than MoveToPos.
			Though you shouldn't use this as a replacement for "MoveToPos" as that function still has very meaningful uses.
	---------------------------------------------------------------------------]]

	function ENT:ApproachPosAndWait( pos, tolerance, time, face, slowdown )

		pos = pos or self:GetPos() 		-- Position the Bot will Approach
		tolerance = tolerance or 50 	-- How the close the Bot will get to the position to consider it reached.
		time = time or 5 				-- How long the Bot should try and reach the given position before giving up.
		face = face or true 			-- Should the Bot face the point its trying to approach.


		duration = CurTime() + time

		debugoverlay.Sphere(pos, 5, 5, Color( 255,255,255), false)
		
		while ( true ) do

			getpos = self:GetPos()
			botposition = Vector(getpos.x,getpos.y,0) -- Height should not determine if the position is reached or not, so we only use the "x" and "y".
			position = Vector(pos.x,pos.y,0)

			distancetopos = botposition:DistToSqr(position)

			if (CurTime() > duration) or ( distancetopos <= tolerance^2) then
				return
			else
				if face then
					self.loco:FaceTowards( pos )
				end

				if slowdown then
					self.loco:SetDesiredSpeed( self.loco:GetDesiredSpeed()*0.1 )
				else
					self.loco:SetDesiredSpeed( self:GetRunSpeed() )
				end
				self.loco:Approach( pos, 1 ) -- Even when approaching, the Bot still slides around... Who allowed that?
			end
			coroutine.yield()
		end
	end

	function ENT:Flames( state )
		if state then
			self.FlamesEnt = ents.Create("env_fire")
			if IsValid( self.FlamesEnt ) then
				self.FlamesEnt:SetParent(self)
				self.FlamesEnt:SetOwner(self)
				self.FlamesEnt:SetPos(self:WorldSpaceCenter())
				--no glow + delete when out + start on + last forever
				self.FlamesEnt:SetKeyValue("spawnflags", tostring(128 + 32 + 4 + 2 + 1))
				self.FlamesEnt:SetKeyValue("firesize", (1 * math.Rand(0.7, 1.1)))
				self.FlamesEnt:SetKeyValue("fireattack", 0)
				self.FlamesEnt:SetKeyValue("health", 0)
				self.FlamesEnt:SetKeyValue("damagescale", "-10") -- only neg. value prevents dmg

				self.FlamesEnt:Fire("setparentattachment","chest_fx_tag")
				self.FlamesEnt:Spawn()
				self.FlamesEnt:Activate()

				self.ZombieIgnited = true
			end
		elseif IsValid( self.FlamesEnt )  then
			self.FlamesEnt:Remove()
			self.FlamesEnt = nil
		end
	end

	function ENT:Explode(dmg, suicide)

    	suicide = suicide or true
    	dmg = dmg or 50

    	if SERVER and !self.HasExplodeIsd then
			self.HasExploded = true
        	local pos = self:WorldSpaceCenter()
        	local targ = self:GetTarget()

        	local attacker = self
        	local inflictor = self

        	if IsValid(targ) and targ.GetActiveWeapon then
            	attacker = targ
            	if IsValid(targ:GetActiveWeapon()) then
                	inflictor = targ:GetActiveWeapon()
            	end
        	end

        	local tr = {
            	start = pos,
            	filter = self,
            	mask = MASK_PLAYERSOLID
        	}

        	for k, v in pairs(ents.FindInSphere(pos, 200)) do
            	if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
                	if v:GetClass() == self:GetClass() then continue end
                	if v == self then continue end
                	if v:EntIndex() == self:EntIndex() then continue end
                	if v:Health() <= 0 then continue end
                	--if !v:Alive() then continue end
                	tr.endpos = v:WorldSpaceCenter()
                	local tr1 = util_traceline(tr)
                	if tr1.HitWorld then continue end

                	local expdamage = DamageInfo()
                	expdamage:SetAttacker(attacker)
                	expdamage:SetInflictor(inflictor)
                	expdamage:SetDamageType(DMG_BLAST)

                	local distfac = pos:Distance(v:WorldSpaceCenter())
                	distfac = 1 - math.Clamp((distfac/200), 0, 1)
                	expdamage:SetDamage(dmg * distfac)

                	expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

                	v:TakeDamageInfo(expdamage)
            	end
        	end

        	local effectdata = EffectData()
        	effectdata:SetOrigin(self:GetPos())

        	util.Effect("HelicopterMegaBomb", effectdata)
        	util.Effect("Explosion", effectdata)

        	util.ScreenShake(self:GetPos(), 20, 255, 1.5, 400)
    	end

    	-- Hate.
    	if suicide and self:IsAlive() then self:TakeDamage(self:Health() + 666, self, self) end
	end

	function ENT:RespawnZombie(playanim)

		if self.IsTurned then return end -- Don't respawn them if they're Turned
		if self.IsENVZombie then return end -- Don't respawn them if they're a Environmental Zombie either.
		if nzRound:InProgress() or nzRound:InState(ROUND_CREATE) then -- Only do this if theres a round in progress. Or Creative mode for testing.
			if self.NZBossType or self.IsMooBossZombie then
				local ply = {}
				local possibleply
				local sspawn
				for k,v in pairs(player.GetAll()) do
					table.insert(ply, v)
				end
				possibleply = ply[math.random(#ply)]
				sspawn = self:FindNearestSpawner(possibleply:GetPos())
				if self.IsMooSpecial then
					sspawn = self:FindNearestSpecialSpawner(possibleply:GetPos())
				end
				if self.NZBossType or self.IsMooBossZombie then
					sspawn = self:FindNearestBossSpawner(possibleply:GetPos())
				end
				if sspawn then
					self:SetPos(sspawn:GetPos())
					self:SetAngles(sspawn:GetAngles())
					self:TempBehaveThread(function(self)	
						self:OnSpawn() -- Call the spawn function once more. This is all one big trick to make it seem like they've respawned.
					end)
				else
					return -- In case for whatever reason there wasn't a spawn around... Just return and try again.
				end
			else
				local seq = self.ZombieDespawnSequences[math.random(#self.ZombieDespawnSequences)]
				if self:HasSequence(seq) and playanim then
					self.AllowDustParticle = true
					self:DoDeathAnimation(seq, true, true)
				else
					self:Remove()
				end
			end
		end
		print("Enemy despawned, was probably stuck. (Location: " .. tostring(self:GetPos()) .. ")")

		-- I keep you here for old times... But I think its time to finally better describe whats happening here.
		--print("Uh oh Mario, I've been mildly inconvenienced. (at: " .. tostring(self:GetPos()) .. ")")
	end

	function ENT:Freeze(time)
		--self:TimeOut(time)
		self:SetStop(true)
		self.FrozenTime = CurTime() + time
	end

	function ENT:IsInSight()
		for _, ply in pairs( player.GetAll() ) do
			if ply:Alive() and ply:IsLineOfSightClear( self ) then
				if ply:GetAimVector():Dot((self:GetPos() - ply:GetPos()):GetNormalized()) > 0 then
					return true
				end
			end
		end
	end

	-- Like IsInSight but it only returns true if the player's crosshair is right next to or on top of the Nextbot.
	function ENT:IsAimedAt()
		for _, ply in pairs( player.GetAll() ) do
			if ply:Alive() and ply:IsLineOfSightClear( self ) then
				if ply:GetAimVector():Dot((self:GetPos() - ply:GetPos()):GetNormalized()) > 0.985 then
					--print("Being aimed at.")
					return true
				end
			end
		end
	end

	-- Like IsInSight but the Nextbot checks if their target is in their sight.
	function ENT:IsFacingTarget()
		local target = self:GetTarget()
		if IsValid(target) then
			if self:GetForward():Dot((target:GetPos() - self:GetPos()):GetNormalized()) > 0 then
				return true
			end
		end
	end
	
	function ENT:IsFacingEnt(ent)
		if IsValid(ent) then
			if self:GetForward():Dot((ent:GetPos() - self:GetPos()):GetNormalized()) > 0 then
				return true
			end
		end
	end

	function ENT:BodyUpdate()

		if !self:GetSpecialAnimation() 
			and !self:IsAttacking() 
			and !self:IsJumping() 
			and !self:IsTimedOut() then
			if !self.FrozenTime then
				self:BodyMoveXY()
			end
		end

		if self:GetSpecialAnimation() or self:IsAttacking() then
			self:SetStuckCounter(0)
		end

		if self.FrozenTime then 
			if self.FrozenTime < CurTime() then
				self.FrozenTime = nil
				self:SetStop(false)
			end
			self:BodyMoveXY()
		else
			self:FrameAdvance()
		end
	end

	function ENT:UpdateSequence()
		self:BodyUpdate()
		self:ResetMovementSequence()
	end

	function ENT:TriggerBarricadeJump( barricade, dir, side )
		if !self:GetSpecialAnimation() then

			local useswalkframes = false

			self:SetSpecialAnimation(true)
			self:SetBlockAttack(true)

			local sides = {
				["m"] = {
					animation = self.JumpSequences,
				},
				["l"] = {
					animation = self.JumpSequencesLeft,
				},
				["r"] = {
					animation = self.JumpSequencesRight,
				},
			}

			local id, dur, speed
			local save
			local animtbl = sides[side].animation

			if !istable(animtbl) then 
				animtbl = self.JumpSequences 
			end

			if self:GetCrawler() then
				animtbl = self.CrawlJumpSequences
			end
 
 			if self.JumpSequences then
				if type(animtbl) == "number" then -- ACT_ is a number, this is set if it's an ACT
					id = self:SelectWeightedSequence(animtbl)
					save = self:SelectWeightedSequence(animtbl)
					dur = self:SequenceDuration(id)
					speed = self:GetSequenceGroundSpeed(id)
					if speed < 10 then
						speed = 20
					end
				else
					local targettbl = animtbl and animtbl[math.random(#animtbl)] or self.JumpSequences
					if targettbl then -- It is a table of sequences
						id, dur = self:LookupSequenceAct(targettbl.seq) -- Whether it's an ACT or a sequence string
						save, dur = self:LookupSequenceAct(targettbl.seq) -- Whether it's an ACT or a sequence string
						speed = targettbl.speed
						if speed then
							useswalkframes = false
						else
							useswalkframes = true
						end
					else
						id = self:SelectWeightedSequence(ACT_JUMP)
						save = self:SelectWeightedSequence(ACT_JUMP)
						dur = self:SequenceDuration(id)
						speed = 30
					end
				end
			end

			self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

			if useswalkframes then

				local jumptype = barricade:GetJumpType() or 0
				local final

				local barricadejumptypes = { -- No more else if pyramid.
					[0] = function(type) 
						id = id
						return id
					end,
					[1] = function(type) 
						if !self.CustomMantleOver128 then
							id = self.NormalMantleOver128[math.random(#self.NormalMantleOver128)]
						else
							id = self.CustomMantleOver128[math.random(#self.CustomMantleOver128)]
						end
						return id
					end,

					[2] = function(type) 
						if !self.CustomMantleOver96 then
							id = self.NormalMantleOver96[math.random(#self.NormalMantleOver96)]
						else
							id = self.CustomMantleOver96[math.random(#self.CustomMantleOver96)]
						end
						return id
					end,

					[3] = function(type) 
						if !self.CustomMantleOver72 then
							id = self.NormalMantleOver72[math.random(#self.NormalMantleOver72)]
						else
							id = self.CustomMantleOver72[math.random(#self.CustomMantleOver72)]
						end
						return id
					end,

					[4] = function(type) 
						if !self.CustomMantleOver48 then
							id = self.NormalMantleOver48[math.random(#self.NormalMantleOver48)]
						else
							id = self.CustomMantleOver48[math.random(#self.CustomMantleOver48)]
						end
						return id
					end,

					[5] = function(type) 
						if !self.CustomNormalJumpUp128 then
							id = self.NormalJumpUp128[math.random(#self.NormalJumpUp128)]
						else
							id = self.CustomNormalJumpUp128[math.random(#self.CustomNormalJumpUp128)]
						end
						return id
					end,

					[6] = function(type) 
						if !self.CustomNormalJumpUp128Quick then
							id = self.NormalJumpUp128Quick[math.random(#self.NormalJumpUp128Quick)]
						else
							id = self.CustomNormalJumpUp128Quick[math.random(#self.CustomNormalJumpUp128Quick)]
						end
						return id
					end,

					[7] = function(type) 
						if !self.CustomNormalJumpDown128 then
							id = self.NormalJumpDown128[math.random(#self.NormalJumpDown128)]
						else
							id = self.CustomNormalJumpDown128[math.random(#self.CustomNormalJumpDown128)]
						end
						return id
					end,

					[8] = function(type) 
						if !self.CustomJumpThroughClosetDoor then
							id = self.JumpThroughClosetDoor[math.random(#self.JumpThroughClosetDoor)]
						else
							id = self.CustomJumpThroughClosetDoor[math.random(#self.CustomJumpThroughClosetDoor)]
						end
						return id
					end,

					[9] = function(type) 
						if !self.CustomCrawlThroughCarSlow then
							id = self.CrawlThroughCarSlow[math.random(#self.CrawlThroughCarSlow)]
						else
							id = self.CustomCrawlThroughCarSlow[math.random(#self.CustomCrawlThroughCarSlow)]
						end
						return id
					end,

					[10] = function(type) 
						if !self.CustomCrawlThroughCarFast then
							id = self.CrawlThroughCarFast[math.random(#self.CrawlThroughCarFast)]
						else
							id = self.CustomCrawlThroughCarFast[math.random(#self.CustomCrawlThroughCarFast)]
						end
						return id
					end,

					[11] = function(type) 
						if !self.CustomCrawlThroughCarSuperFast then
							id = self.CrawlThroughCarSuperFast[math.random(#self.CrawlThroughCarSuperFast)]
						else
							id = self.CustomCrawlThroughCarSuperFast[math.random(#self.CustomCrawlThroughCarSuperFast)]
						end
						return id
					end,

					[12] = function(type) 
						if !self.CustomMantleOver36 then
							if self:HasSequence(self.NormalMantleOver36[math.random(#self.NormalMantleOver36)]) then
								id = self.NormalMantleOver36[math.random(#self.NormalMantleOver36)]
							else
								id = id
							end
						else
							id = self.CustomMantleOver36[math.random(#self.CustomMantleOver36)]
						end
						return id
					end,

					[13] = function(type) 
						if !self.CustomFastMantleOver48 then
							id = self.NormalFastMantleOver48[math.random(#self.NormalFastMantleOver48)]
						else
							id = self.CustomFastMantleOver48[math.random(#self.CustomFastMantleOver48)]
						end
						return id
					end,

				}

				final = barricadejumptypes[jumptype](id)

				-- Perform a normal jump if the selected sequence isn't valid.
				if !self:HasSequence(final) then final = save end

				self:PlaySequenceAndMove(final, {gravity = false})

				local pos = barricade:GetPos() - dir * 50
				self:CollisionInWorld(pos, MASK_NPCWORLDSTATIC, true)

				self:ResetMovementSequence()
			else
				if self.JumpSequences then
					self.loco:SetDesiredSpeed(speed)
					self:SetVelocity(self:GetForward() * speed)
					self:ResetSequence(id)
					self:SetCycle(0)
					self:SetPlaybackRate(1)
				end

				local pos = barricade:GetPos() - dir * 50
				self:MoveToPos(pos, { -- Zombie will move through the barricade.
					lookahead = 1,
					tolerance = 10,
					draw = false,
					maxage = dur, -- 12/7/22: Using the current mantle anim's duration allows for more consistent mantling and lessens the zombie's chances of getting stuck.
					repath = dur,
				})
				self:SetPos(pos)
				self.loco:SetAcceleration( self.Acceleration )
				self.loco:SetDesiredSpeed(self:GetRunSpeed())
			end
			self:SetBlockAttack(false)
			self:SetSpecialAnimation(false)
			self:SetIsBusy(false)
			self:CollideWhenPossible() -- Remove the mask as soon as we can
			--self:TimeOut(0.1)
		end
	end

	function ENT:CollisionInWorld(position, solidmask, move)
		-- Give a Position
		-- Give a Solid Mask
		-- Should the bot's position be moved if the trace is hit?

		local maxs = Vector(self:OBBMaxs().x,self:OBBMaxs().y,12)
		local mins = Vector(self:OBBMins().x,self:OBBMins().y,-12)

		local startpos = self:WorldSpaceCenter() - (self:OBBCenter() * 0.5)

		local tr = util_tracehull({
			start = startpos,
			endpos = startpos,
			maxs = maxs,
			mins = mins,
			mask = solidmask,
			filter = self
		})

		debugoverlay.Box(startpos, mins, maxs, 2, Color(100, 100, 255, 100))
		--local tr = self:NZDrG_TraceHull(position, {mask = solidmask})

		if tr.Hit and move and isvector(position) then
			self:SetPos(position)
			return true
		end
		return false
	end

	function ENT:GetAimVector()
		return self:GetForward()
	end

	function ENT:GetShootPos()
		return self:EyePos()
	end

	function ENT:LookupSequenceAct(id)
		if type(id) == "number" then
			local id = self:SelectWeightedSequence(id)
			local dur = self:SequenceDuration(id)
			return id, dur
		else
			return self:LookupSequence(id)
		end
	end

	--Helper function
	function ENT:TimedEvent(time, callback)
		timer.Simple(time, function()
			if (IsValid(self) and self:Health() > 0) then
				callback()
			end
		end)
	end

	function ENT:Push(vec)
    	if CurTime() < self:GetLastPush() + 0.2 or !self:IsOnGround() then return end

    	self.GettingPushed = true
    	self.loco:SetVelocity( vec )

    	self:TimedEvent(0.5, function()
        	self.GettingPushed = false
    	end)

    	self:SetLastPush( CurTime() )
	end

	function ENT:ApplyRandomPush( power )
    	power = power or 100
    
    	local vec = self.loco:GetVelocity() + VectorRand() * power
    	vec.z = math.random( 100 )
    	self:Push(vec)
	end

	function ENT:IsGettingPushed() -- this is a new method
    	return self.GettingPushed
	end

	function ENT:GetCenterBounds()
    	local mins = self:OBBMins()
    	local maxs = self:OBBMaxs()
    	mins[3] = mins[3] / 2
    	maxs[3] = maxs[3] / 2

    	return {["mins"] = mins, ["maxs"] = maxs}
	end

	function ENT:TraceSelf(start, endpos, dont_adjust, line_trace) -- Creates a hull trace the size of ourself, handy if you'd want to know if we'd get stuck from a position offset
    	local bounds = self:GetCenterBounds()

    	if !dont_adjust then
        	start = start and start + self:OBBCenter() / 1.01 or self:GetPos() + self:OBBCenter() / 2
    	end

    	debugoverlay.Box(start, bounds.mins, bounds.maxs, 0, Color(255,0,0,55))

    	if endpos then
        	if !dont_adjust then
            	endpos = endpos + self:OBBCenter() / 1.01
        	end

        	debugoverlay.Box(endpos, bounds.mins, bounds.maxs, 0, Color(255,0,0,55))
    	end

    	local tbl = {
        	start = start,
        	endpos = endpos or start,
        	filter = self,
        	mins = bounds.mins,
        	maxs = bounds.maxs,
        	collisiongroup = self:GetCollisionGroup(),
        	mask = MASK_NPCSOLID
    	}

    	return !line_trace and util_tracehull(tbl) or util_traceline(tbl)
	end

	function ENT:IsMovingIntoObject() -- this can be helpful to know
    
    	local bounds = self:GetCenterBounds()
    	local stuck_tr = self:TraceSelf()
    	local startpos = self:GetPos() + self:OBBCenter() / 2
    	local endpos = startpos + self:GetForward() * 10
    	local tr = stuck_tr.Hit and stuck_tr or util_tracehull({
        	["start"] = startpos,
        	["endpos"] = endpos,
        	["filter"] = self,
        	["mins"] = bounds.mins,
        	["maxs"] = bounds.maxs,
        	["collisiongroup"] = self:GetCollisionGroup(),
        	["mask"] = MASK_ALL
    	})

    	local ent = tr.Entity
		if tr.Hit then -- Moo Mark 1/8/23: Got rid of the second trace since I thought that it could be more taxing to have two traces for every tick the zombie is moving into something.
			--[[for k,v in pairs(ents.FindInSphere(self:GetPos(), self.AttackRange)) do
				if IsValid(v) and (v:GetClass() == "func_breakable" or v:GetClass() == "func_breakable_surf")then
					v:TakeDamage(v:Health(),self,self) -- Just fucking kill it
					timer.Simple(engine.TickInterval(), function() 
						if IsValid(v) then -- Wait next tick and if the entity is still valid, fire the Break input on it(Its probably a surf.).
							v:Fire("Break")
						end
					end)
					--self:Attack()
				end
			end]]
			for k,v in nzLevel.GetBarricadeArray() do
				if IsValid(v) and self:GetRangeTo( v:GetPos() ) < self.InteractCheckRange then
					local CurrentDirection = self:GetForward() * 10
					self.BarricadeCheckDir = CurrentDirection or Vector(0,0,0)
					local barricade, dir = self:CheckForBarricade()
					if barricade then
						self:OnBarricadeBlocking( barricade, dir )
					end
				end
			end
		end
    	if IsValid(ent) and (ent:IsPlayer() or ent:IsScripted() or ent:IsValidZombie()) then return false end

    	return tr.Hit
	end

	function ENT:ZombieWaterLevel()
		local pos1 = self:GetPos()
		local halfSize = self:OBBCenter()
		local pos2 = pos1 + halfSize
		local pos3 = pos2 + halfSize
		if bit.band( util.PointContents( pos3 ), CONTENTS_WATER ) == CONTENTS_WATER or bit.band( util.PointContents( pos3 ), CONTENTS_SLIME ) == CONTENTS_SLIME then
			return 3
		elseif bit.band( util.PointContents( pos2 ), CONTENTS_WATER ) == CONTENTS_WATER or bit.band( util.PointContents( pos2 ), CONTENTS_SLIME ) == CONTENTS_SLIME then
			return 2
		elseif bit.band( util.PointContents( pos1 ), CONTENTS_WATER ) == CONTENTS_WATER or bit.band( util.PointContents( pos1 ), CONTENTS_SLIME ) == CONTENTS_SLIME then
			return 1
		end

		return 0
	end

	function ENT:SolidMaskDuringEvent(mask, collision)  -- Changes the zombie's mask until the end of the event. If nil is passed, it immediately removes the mask
		if collision then
			self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
		else
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		end
		if mask then
			self:SetSolidMask(mask)
			self.EventMask = true
		else
			self:SetSolidMask(MASK_NPCSOLID)
			self.EventMask = nil
		end
	end

	function ENT:CollideWhenPossible() 
		if self:IsAlive() then 
			self.DoCollideWhenPossible = true -- Make the zombie solid again as soon as there is space
		end
	end

	ENT.IdleSequence = "nz_idle_ad"

	ENT.IdleSequenceAU = "nz_idle_au" -- Same as the one above but the zombie's arms are raised instead of being down at their sides.

	ENT.CrawlIdleSequence = "nz_idle_crawl"

	ENT.NoTargetIdle = "nz_base_idle_unaware_01"

	ENT.TornadoSequence = "nz_alistairs_tornado_loop"

	ENT.XbowWWSequence = "nz_dth_ww_xbow_loop"

	-- ulx luarun "Entity(1):GetEyeTrace().Entity:PerformStun(10)"
	
	-- By default these aren't used by normal zombies. But can be used if your enemy has the animations for it.
	--ENT.ZombieStunInSequence = "nil"
	--ENT.ZombieStunOutSequence = "nil"

	-- Glorified TimeOut function that has makes the bot play a start, loop, and end animation.
	function ENT:PerformStun(time)

		if !IsValid(self) then return end
		if self.Stunned then return end -- No need to run again if its already running from something else.
		if !isnumber(time) then time = 1 end

		local stunin = self.ZombieStunInSequence
		local stunout = self.ZombieStunOutSequence

		self:TempBehaveThread(function(self)
			self.Stunned = true
			self:OnStunIn()
			if isstring(stunin) and self:HasSequence(stunin) then self:PlaySequenceAndMove(stunin) end

			self:TimeOut(time)

			self.Stunned = false
			self:OnStunOut()
			if isstring(stunout) and self:HasSequence(stunout) then self:PlaySequenceAndMove(stunout) end
		end)
	end

	function ENT:OnStunIn() end		-- Both functions here should be pretty obvious what they do.
	function ENT:OnStunOut() end

	-- Called when the zombie wants to idle. Play an animation here
	function ENT:PerformIdle()
		--if self:GetSpecialAnimation() and !self.IsTornado and !self.IsXbowSpinning then return end

		-- Sleeping Zombies(Looping animations)
		if self.IsENVZombie and !self.ENVZombieDisturbed then
			if !isstring(self.VignLoopAnimation) or !self.ENVZombieAwoken then
				self:ResetSequence(self.VignSleepAnimation)
				return
			end
		end
		if self.ENVZombieAwoken then
			if isstring(self.VignLoopAnimation) then
				self:ResetSequence(self.VignLoopAnimation)
				return
			end
		end

		if self:GetCrawler() and !self.IsMooSpecial then
			self:ResetSequence(self.CrawlIdleSequence)
		elseif (self.Stunned or self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning() or self:GetNW2Bool("OnAcid") or self.BeingDissolved) and self:GetCrawler() and self:HasSequence(self.SparkyCrawlAnim) then
			self:ResetSequence(self.SparkyCrawlAnim)
		elseif (self.Stunned or self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self:GetNW2Bool("OnAcid") or self.BeingDissolved) and !self:GetCrawler() and self:HasSequence(self.SparkyAnim) then
			self:ResetSequence(self.SparkyAnim)
		elseif self.BO3IsMystified and self:BO3IsMystified() then
			if self.Target.IsAATTurned and self.Target:IsAATTurned() and IsValid(self.ElectricDanceSequences) then
				self:ResetSequence(self.ElectricDanceAnim)
			else
				self:ResetSequence(self.IdleSequence)
			end
		elseif self:GetJumping() then
			if !self:GetCrawler() then
				self:GetSequenceActivity(ACT_JUMP)
			else
				self:GetSequenceActivity(ACT_HOP)
			end
		elseif self.AttackSimian == 1 and IsValid(self.Target) and self.Target.MonkeyBomb and self:HasSequence(self.IncapAttackAnim) then
			self:ResetSequence(self.IncapAttackAnim)
		elseif self.BO4IsTornado and self:BO4IsTornado() and self.IsTornado and (self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial) then
			self:ResetSequence(self.TornadoSequence)
		elseif self.BO4IsSpinning and self:BO4IsSpinning() and self.IsXbowSpinning and (self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial) then
			self:ResetSequence(self.XbowWWSequence)
		elseif self:LookupSequence(self.NoTargetIdle) > 0 and (!self:HasTarget() and !nzRound:InState( ROUND_GO ) or self:GetWandering()) then
			self:ResetSequence(self.NoTargetIdle)
			if !self.IsIdle and !IsValid(self:GetTarget()) then
				self.IsIdle = true
			end
		elseif self.ArmsUporDown == 1 and !self:GetCrawler() and !self.IsMooSpecial then
			self:ResetSequence(self.IdleSequenceAU)
			if !self.IsIdle and !IsValid(self:GetTarget()) then
				self.IsIdle = true
			end
		else
			self:ResetSequence(self.IdleSequence)
			if !self.IsIdle and !IsValid(self:GetTarget()) then
				self.IsIdle = true
			end
		end
	end

	-- Returns to normal movement sequence. Call this in events where you want to MoveToPos after an animation
	function ENT:ResetMovementSequence()

		if self.UseMovementSequenceOverride then
			self:MovementSequenceOverride()
		elseif self:GetCrawler() and self.CrawlMovementSequence then
			self:ResetSequence(self.CrawlMovementSequence)
			self.CurrentSeq = self.CrawlMovementSequence
		elseif self:GetJumping() then
			if !self:GetCrawler() then
				self:GetSequenceActivity(ACT_JUMP)
			else
				self:GetSequenceActivity(ACT_HOP)
			end
		elseif self:GetWandering() and self.PatrolMovementSequence then
			self:ResetSequence(self.PatrolMovementSequence)
			self.CurrentSeq = self.PatrolMovementSequence
		elseif IsValid(self.Target) and self.Target.BHBomb and self.BlackholeMovementSequence then
			self:ResetSequence(self.BlackholeMovementSequence)
			self.CurrentSeq = self.BlackholeMovementSequence
		elseif (nzMapping.Settings.gravity <= 300 or self:ZombieWaterLevel() >= 2 or self.InLowGravZone) and self.LowgMovementSequence then
			self:ResetSequence(self.LowgMovementSequence)
			self.CurrentSeq = self.LowgMovementSequence
		elseif self.IsTurned and self.TurnedMovementSequence then
			self:ResetSequence(self.TurnedMovementSequence)
			self.CurrentSeq = self.TurnedMovementSequence
		elseif (self.AATIsBlastFurnace and self:AATIsBlastFurnace() or self.BO4IsMagmaIgnited and self:BO4IsMagmaIgnited()) and self.FireMovementSequence then
			self:ResetSequence(self.FireMovementSequence)
			self.CurrentSeq = self.FireMovementSequence
		else
			self:ResetSequence(self.MovementSequence)
			self.CurrentSeq = self.MovementSequence
		end
		if self:GetSequenceGroundSpeed(self:GetSequence()) ~= self:GetRunSpeed() or self.UpdateSeq ~= self.CurrentSeq then -- Moo Mark 4/19/23: Finally got a system where the speed actively updates when the movement sequence set is changed.
			--print("update")
			self.UpdateSeq = self.CurrentSeq
			self:UpdateMovementSpeed()
		end
	end

	-- If you wanna have a special condition be met to play a different movement animation(Without having to override the function above.)
	-- You would just use "self.UseMovementSequenceOverride = true" to enable it.
	function ENT:MovementSequenceOverride() end

	-- ulx luarun "Entity(1):GetEyeTrace().Entity:AATBlastFurnace(3, Entity(1), Entity(1):GetActiveWeapon())"

	function ENT:UpdateMovementSequences()
		-- Select a random anim to perform so a zombie doesn't switch constantly.
		if self.SparkySequences and self.CrawlSparkySequences then
			self.SparkyAnim = self.SparkySequences[math.random(#self.SparkySequences)]
			self.SparkyCrawlAnim = self.CrawlSparkySequences[math.random(#self.CrawlSparkySequences)]
		end
		if self.UnawareSequences then
			self.UnawareAnim = self.UnawareSequences[math.random(#self.UnawareSequences)]
		end
		if self.ElectricDanceSequences then
			self.ElectricDanceAnim = self.ElectricDanceSequences[math.random(#self.ElectricDanceSequences)]
		end
		if self.IncapAttackSequences then
			self.IncapAttackAnim = self.IncapAttackSequences[math.random(#self.IncapAttackSequences)]
		end

		if self.SequenceTables then
				local t
			if self.SpeedBasedSequences then
				for k,v in pairs(self.SequenceTables) do
					if v.Threshold and v.Threshold > self:GetRunSpeed() then break end
					t = v
				end
			else
				t = self.SequenceTables[math.random(#self.SequenceTables)]
			end

			if t then
				local seqs = t.Sequences[1] and t.Sequences[math.random(#t.Sequences)] or t.Sequences -- If Sequences is a numerical table, pick a random one (supports random selection)
				for k,v in pairs(seqs) do
					self[k] = v[math.random(#v)] -- Pick a random entry
				end
			end
		end
	end

	-- Now contains the modified path generator so this functions navigating sucks ass less.
	function ENT:MoveToPos( pos, options )

		local options = options or {}

		local path = Path( "Follow" )
		path:SetMinLookAheadDistance( options.lookahead or 300 )
		path:SetGoalTolerance( options.tolerance or 20 )
		path:Compute( self, pos, function( area, fromArea, ladder, elevator, length )
			if ( !IsValid( fromArea ) ) then
				// first area in path, no cost
				return 0
			else
				if ( !self.loco:IsAreaTraversable( area ) ) then
					// our locomotor says we can't move here
					return -1
				end
				// compute distance traveled along path so far
				local dist = 0

				--[[
				if ( IsValid( ladder ) ) then
					dist = ladder:GetLength()
				elseif ( length > 0 ) then
					// optimization to avoid recomputing length
					dist = length
				else
					dist = (area:GetCenter() - fromArea:GetCenter()):GetLength()
				end]]

				local cost = dist + fromArea:GetCostSoFar()

				// check height change
				local deltaZ = fromArea:ComputeAdjacentConnectionHeightChange( area )
				if deltaZ >= self.loco:GetStepHeight() then
					if deltaZ >= self.loco:GetMaxJumpHeight() then
					
						if !fromArea:HasAttributes(NAV_MESH_JUMP) then
							return -1
						end
					
					end

					// jumping is slower than flat ground
					local jumpPenalty = 5
					cost = cost + jumpPenalty * 0
				elseif deltaZ < -self.loco:GetDeathDropHeight() then
					// too far to drop
					return -1
				end
				return cost
			end
		end )

		if ( !path:IsValid() ) then return "failed" end

		while ( path:IsValid() ) and !self.CancelCurrentPath do

			path:Update( self )

			self:ResetMovementSequence()

			-- Draw the path (only visible on listen servers or single player)
			if ( options.draw ) then
				path:Draw()
			end

			-- If we're stuck then call the HandleStuck function and abandon
			if ( self.loco:IsStuck() ) then
				self:HandleStuck()
				return "stuck"
			end

			-- If they set maxage on options then make sure the path is younger than it
			if ( options.maxage ) then
				if ( path:GetAge() > options.maxage ) then return "timeout" end
			end

			-- If they set repath then rebuild the path every x seconds
			if ( options.repath ) then

				self:CheckForBigJump()

				if ( path:GetAge() > options.repath ) then 	
					path:Compute( self, pos, function( area, fromArea, ladder, elevator, length )
						if ( !IsValid( fromArea ) ) then
							// first area in path, no cost
							return 0
						else
							if ( !self.loco:IsAreaTraversable( area ) ) then
								// our locomotor says we can't move here
								return -1
							end
							// compute distance traveled along path so far
							local dist = 0

							--[[
							if ( IsValid( ladder ) ) then
								dist = ladder:GetLength()
							elseif ( length > 0 ) then
								// optimization to avoid recomputing length
								dist = length
							else
								dist = (area:GetCenter() - fromArea:GetCenter()):GetLength()
							end]]

							local cost = dist + fromArea:GetCostSoFar()

							// check height change
							local deltaZ = fromArea:ComputeAdjacentConnectionHeightChange( area )
							if deltaZ >= self.loco:GetStepHeight() then
								if deltaZ >= self.loco:GetMaxJumpHeight() then
								
									if !fromArea:HasAttributes(NAV_MESH_JUMP) then
										return -1
									end
								
								end

								// jumping is slower than flat ground
								local jumpPenalty = 5
								cost = cost + jumpPenalty * 0
							elseif deltaZ < -self.loco:GetDeathDropHeight() then
								// too far to drop
								return -1
							end
							return cost
						end
					end )
				end
			end

			coroutine.yield()
		end

		return "ok"
	end

	--Targets
	function ENT:HasTarget()
		return self:IsValidTarget( self:GetTarget() )
	end

	function ENT:GetTargetNavArea()
		return self:HasTarget() and navmesh.GetNearestNavArea( self:GetTarget():GetPos(), false, 100)
	end

	function ENT:SetTarget( target )
		self.Target = target
		if self.Target ~= target then
			self:SetLastTargetChange(CurTime())
		end
	end

	function ENT:IsTarget( ent )
		return self.Target == ent
	end

	function ENT:RemoveTarget()
		self:SetTarget( nil )
	end

	function ENT:IsValidTarget( ent )
		if not ent then return false end

		-- Ignore a player who might be timing out. They may come back from it so leave them alone as to not unfairly kill them.
		if ent:IsPlayer() and ent:IsTimingOut() then return false end 
		if ent:IsPlayer() and !ent:Alive() then return false end

		-- Turned Zombie/Ally Targetting
		if self.IsTurned or self.IsNZAlly then
			return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and !ent.IsNZAlly and ent:IsAlive() 
		end

		-- Special Enemy and Boss Targetting
		if (self.IsMooSpecial and !self.MooSpecialZombie) or self.IsMooBossZombie or self.NZBossType then
			return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
		end

		return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY -- This is really funny.
	end

	function ENT:GetIgnoredTargets()
		return self.tIgnoreList
	end

	function ENT:IgnoreTarget( target )
		table.insert(self.tIgnoreList, target)
	end

	function ENT:IsIgnoredTarget( ent )
		table.HasValue(self.tIgnoreList, ent)
	end

	function ENT:ResetIgnores()
		self.tIgnoreList = {}
	end

	-- Lets you determine how long until the next retarget
	-- This is called after a retarget. You can use the distance, it is known to be the smallest distance to all players
	function ENT:CalculateNextRetarget(target, dist)
		return math.Clamp(dist/200, 3, 15) -- 1 second for every 100 units to the closet player
	end

	function ENT:GetTargetPosition() return self.LockedTargetPosition or self:SelectTargetPosition() end -- Get the current goal location. Supports locked goal locations

	function ENT:SetNextRetarget(time) self.NextRetarget = CurTime() + time end -- Sets the next time the Zombie will repath to its target --Moo Mark Target

	-- Here you can do things such as determine your own locations that might not be right on the target
	function ENT:SelectTargetPosition()
		return self.Target:GetPos()
	end


	local function GetClearPaths(ent, pos, tiles)
		local clearPaths = {}
		local filter = player.GetAll()
		for _, tile in pairs( tiles ) do
			local tr = util_traceline({
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

	local function GetSurroundingTiles(ent, pos)
		local tiles = {}
		local x, y, z
		local minBound, maxBound = ent:OBBMins(), ent:OBBMaxs()
		local checkRange = math.max(12, maxBound.x, maxBound.y)
	
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

	function ENT:CollisionBoxClear(ent, pos, minBound, maxBound)
		local filter = {ent}
		local tr = util.TraceEntity({
			start = pos,
			endpos = pos,
			filter = filter,
			mask = MASK_PLAYERSOLID
		}, ent)

		return !tr.StartSolid || !tr.AllSolid
	end

	function ENT:FindSpotBehindPlayer(pos, count, range, stepd, stepu)
		local targ = self:GetTarget()
		pos = pos or targ:GetPos()
		range = range or 100
		stepd = stepd or 25
		stepu = stepu or 25
		count = count or 6

		if navmesh.IsLoaded() then
			local tab = navmesh.Find(pos, range, stepd, stepu)
			local postab = {}

			for i=1, count do
				for _, nav in RandomPairs(tab) do
					if IsValid(nav) and not nav:IsUnderwater() then
						local testpos = nav:GetRandomPoint()
						local norm = (testpos - pos):GetNormal()

						if IsValid(targ) and targ:GetAimVector():Dot(norm) < 0 then
							table.insert(postab, testpos)
							break
						end
					end
				end
			end

			if not table.IsEmpty(postab) then
				table.sort(postab, function(a, b) return a:DistToSqr(pos) < b:DistToSqr(pos) end)
				pos = postab[1]
			end
		end

		local minBound, maxBound = self:OBBMins(), self:OBBMaxs()
		if not self:CollisionBoxClear( self, pos, minBound, maxBound ) then
			local surroundingTiles = GetSurroundingTiles( self, pos )
			local clearPaths = GetClearPaths( self, pos, surroundingTiles )	
			for _, tile in pairs( clearPaths ) do
				if self:CollisionBoxClear( self, tile, minBound, maxBound ) then
					pos = tile
					break
				end
			end
		end

		return pos
	end

	function ENT:FindNearestSpawner(pos)
    	local nearbyents = {}
    	for k, v in nzLevel.GetZombieSpawnArray() do
        	if v.GetSpawner and v:GetSpawner() then
            	if (v.link == nil or nzDoors:IsLinkOpened( v.link ) or nzDoors:IsLinkOpened( v.link2 ) or nzDoors:IsLinkOpened( v.link3 )) and v:IsSuitable() and !v:GetMasterSpawn() then
                	table.insert(nearbyents, v)
            	end
        	end
    	end

    	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
    	return nearbyents[1]
	end

	function ENT:FindNearestSpecialSpawner(pos)
    	local nearbyents = {}
    	for k, v in nzLevel.GetSpecialSpawnArray() do
        	if v.GetSpawner and v:GetSpawner() then
            	if (v.link == nil or nzDoors:IsLinkOpened( v.link ) or nzDoors:IsLinkOpened( v.link2 ) or nzDoors:IsLinkOpened( v.link3 )) and v:IsSuitable() and !v:GetMasterSpawn() then
                	table.insert(nearbyents, v)
            	end
        	end
    	end

    	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
    	return nearbyents[1]
	end

	function ENT:FindNearestBossSpawner(pos)
    	local nearbyents = {}
    	for k, v in nzLevel.GetZombieBossArray() do
        	if v.GetSpawner and v:GetSpawner() then
            	if (v.link == nil or nzDoors:IsLinkOpened( v.link ) or nzDoors:IsLinkOpened( v.link2 ) or nzDoors:IsLinkOpened( v.link3 )) and v:IsSuitable() and !v:GetMasterSpawn() then
                	table.insert(nearbyents, v)
            	end
        	end
    	end

    	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
    	return nearbyents[1]
	end

	--Below function credited to CmdrMatthew
	function ENT:getvel(pos, pos2, time)	-- target, starting point, time to get there
    	local diff = pos - pos2 --subtract the vectors
     
    	local velx = diff.x/time -- x velocity
    	local vely = diff.y/time -- y velocity
 
    	local velz = (diff.z - 0.5*(-GetConVarNumber( "sv_gravity"))*(time^2))/time --  x = x0 + vt + 0.5at^2 conversion
     
    	return Vector(velx, vely, velz)
	end	
	
	function ENT:LaunchArc(pos, pos2, time, t)	-- target, starting point, time to get there, fraction of jump
		local v = self:getvel(pos, pos2, time).z
		local a = (-GetConVarNumber( "sv_gravity"))
		local z = v*t + 0.5*a*t^2
		local diff = pos - pos2
		local x = diff.x*(t/time)
    	local y = diff.y*(t/time)
	
		return pos2 + Vector(x, y, z)
	end
end

	function ENT:GetTarget()
		if !IsValid(self.Target) then return false end
		return self.Target
	end

--[[
self.funny = Material("the_cage.png"), "unlitgeneric smooth")

local function Draw3DText( pos, ang, scale, flipView, material )
    if ( flipView ) then
        ang:RotateAroundAxis( vector_up, 180 )
    end

    cam.Start3D2D(pos, ang, scale)
        surface.SetMaterial(material)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(-16, -16, 48,48)
    cam.End3D2D()
end

function ENT:Draw()
    local pos = self:EyePos()
    local ang = however you get the zombies looking angle, maybe their forward:Angle()?

    ang = Angle(ang.x, ang.y, 0)
    ang:RotateAroundAxis(ang:Up(), -90)
    ang:RotateAroundAxis(ang:Forward(), 90)

    Draw3DText( pos, ang, 0.2, false, self.funny)
    Draw3DText( pos, ang, 0.2, true, self.funny)

    self:DrawModel()
end
]]


-- Moo Mark 4/14/23: ROBBERY!!! EVERYTHING IN THIS is pulled from Drgbase, I mainly did this just so I can use "PlaySequenceAndMove" and have no actual know how of doing this from scratch. 

-- Code Credit: Dragoteryx

function ENT:FaceTowards(pos) -- This is the nZU one, plus DRGBase stuff.
	if isentity(pos) then pos = pos:GetPos() end
	self.loco:FaceTowards(pos)
	local ang = (pos - self:GetPos()):Angle()
	local ang2 = self:GetAngles()
	ang.p = ang2.p
	ang.r = ang2.r

	self:SetAngles(ang)
end

function ENT:FaceEnemy()
	if IsValid(self:GetTarget()) then self:FaceTowards(self:GetTarget()) end
end

-- Name changed to avoid conflicts with the real drgbase.
function ENT:NZDrG_TraceHull(vec, data)
	if not isvector(vec) then vec = Vector(0, 0, 0) end
	local bound1, bound2 = self:GetCollisionBounds()
	local scale = self:GetModelScale()
	if scale > 1 then
		bound1 = bound1 * (1 + 0.5 * scale) -- 0.01 was too small
		bound2 = bound2 * (1 + 0.5 * scale)
	end
	if bound1.z < bound2.z then
		local temp = bound1
		bound1 = bound2
		bound2 = temp
	end
	local trdata = {}
	data = data or {}
	if data.step then
		bound2.z = self.loco:GetStepHeight()
	end
	trdata.start = data.start or self:GetPos()
	trdata.endpos = data.endpos or trdata.start + vec
	trdata.collisiongroup = data.collisiongroup or self:GetCollisionGroup()
	trdata.mask = data.mask or self:GetSolidMask()
	trdata.ignoreworld = false
	trdata.filter = data.filter or self
	trdata.maxs = data.maxs or bound1
	trdata.mins = data.mins or bound2

	local trace = util_tracehull(trdata) -- The one line fix in question

	return trace
end

local function ResetSequence(self, seq)
	local len = self:SetSequence(seq)
	self:SetCycle(0)
	self:ResetSequenceInfo()
	return len
end

function ENT:OnAnimChange() end

function CallOnAnimChange(self, old, new)
	return self:OnAnimChange(self:GetSequenceName(old), self:GetSequenceName(new))
end

function ENT:PlaySequenceAndWait(seq, rate, callback)
	rate = rate or 1
	if isstring(seq) then 
		seq = self:LookupSequence(seq)
	elseif not isnumber(seq) then 
		return 
	end
	if seq == -1 then return end

	local current = self:GetSequence()
	if seq == self:GetSequence() or CallOnAnimChange(self, current, seq) ~= false then
		ResetSequence(self, seq)
		self:SetPlaybackRate(rate or 1)
		local now = CurTime()
		local lastCycle = -1
		while seq == self:GetSequence() do
			local cycle = self:GetCycle()
			if lastCycle >= cycle then break end
			if lastCycle >= cycle and cycle >= 1 then break end

			-- A janky modification that allows the nextbot to cancel their attack sequence if the criteria is met.
			if (!self:TargetInRange(self.AttackRange + 35) or !IsValid(self.Target)) and self:GetAttacking() and self.CanCancelAttack or self.CancelCurrentAction then 
				self:SetAttacking(false) 
				if self.CancelCurrentAction then
					self.CancelCurrentAction = false
				end
				break 
			end

			lastCycle = cycle
			if isfunction(callback) then
				local res = callback(self, cycle)
				if res then break end
			end
			coroutine.yield()
		end
		return CurTime() - now
	end
end

function ENT:PlaySequenceAndMove(seq, options, callback)
	if isstring(seq) then 
		seq = self:LookupSequence(seq)
	elseif not isnumber(seq) then 
		return 
	end

	if seq == -1 then return end

	if isnumber(options) then 
		options = {rate = options}
	elseif not istable(options) then 
		options = {} 
	end

	if options.gravity == nil then options.gravity = true end
	if options.collisions == nil then options.collisions = true end

		local previousCycle = 0
		local previousPos = self:GetPos()
		local res = self:PlaySequenceAndWait(seq, options.rate, function(self, cycle)
			local success, vec, angles = self:GetSequenceMovement(seq, previousCycle, cycle)
			if success then
				if isvector(options.multiply) then
					vec = Vector(vec.x*options.multiply.x, vec.y*options.multiply.y, vec.z*options.multiply.z)
				end
				
				vec:Rotate(self:GetAngles() + angles)
				self:SetAngles(self:LocalToWorldAngles(angles))
				
				local qtr = util.QuickTrace(self:GetPos(), vector_up*-19, self) -- Make sure theres a floor, we don't wanna accidentally fall off the ledge.
				local tr = self:NZDrG_TraceHull(vec, {step = self:IsOnGround()})

				debugoverlay.Sphere(previousPos, 5, 0.03, Color( 100,255,100), false)

				--if tr.Hit and tr.Entity:IsPlayer() and self:CollisionInWorld(tr.Entity:GetPos(), MASK_ALL, false) then self:SolidMaskDuringEvent(MASK_PLAYERSOLID) end

				if (self.Big_Jump_area_ledge == "reached" and !tr.Hit) or (self:GetIsBusy() and (self.TraversalAnim or tr.HitNoDraw)) or (!tr.Hit and qtr.Hit) then
					if not options.gravity then
						previousPos = previousPos + vec * self:GetModelScale()
						self:SetPos(previousPos)
						--print("move")
					elseif not vec:IsZero() and qtr.Hit then
						previousPos = self:GetPos() + vec * self:GetModelScale()
						self:SetPos(previousPos)
						--print("move2")
					else
						previousPos = self:GetPos() 
						--print("move3")
					end
				elseif options.stoponcollide then 
					return true
				elseif not options.gravity then
					self:SetPos(previousPos)
				end
			end
			previousCycle = cycle
			if isfunction(callback) then return callback(self, cycle) end
		end)

		if not options.gravity then
			self:SetPos(previousPos)
			self:SetVelocity(Vector(0,0,0))
			--print("move5")
		end
	return res
end

if SERVER then
	function ENT:OnContactWithTarget() end
	function ENT:OnStuck() end
	function ENT:OnRemoveCustom() end

	function ENT:OnRemove() 
		self:ClearBigJumpNav()
		self:OnRemoveCustom()
	end
end

--AccessorFuncs
function ENT:IsJumping()
	return self:GetJumping()
end

function ENT:IsClimbing()
	return self:GetClimbing()
end

function ENT:IsAttacking()
	return self:GetAttacking()
end

function ENT:IsStandingAttack()
	return self:GetStandingAttack()
end

function ENT:IsTimedOut()
	return self:GetTimedOut()
end

function ENT:SetInvulnerable(bool)
	self.Invulnerable = bool
end

function ENT:IsInvulnerable()
	return self.Invulnerable
end

function ENT:EyePos()

	local eyepos = self:LookupBone("j_head") -- If the model of the enemy has a 'j_head' bone, just use that for the eye pos.

	if !eyepos then return self:WorldSpaceCenter() + (self:OBBCenter()*0.7) end

	return eyepos:GetPos()
end

function ENT:WaterBuff() return self:GetWaterBuff() end

function ENT:BomberBuff() return self:GetBomberBuff() end

function ENT:TripleBuff() return self:GetTripleBuff() end

if CLIENT then
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")
	--local eyeglow = Material("nz_moo/sprites/hud_particle_glow_04")

	local defaultColor = Color(255, 75, 0, 255)

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()
		if self.RedEyes == true and self:IsAlive() and !self:GetDecapitated() and !self:GetMooSpecial() and !self.IsMooSpecial then
			self:DrawEyeGlow() 
		end

		if self:GetShadowBuff() and !self:GetBomberBuff() and !self:GetWaterBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 50
				elight.g = 0
				elight.b = 50
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:WaterBuff() and !self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 50
				elight.b = 255
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:BomberBuff() and !self:WaterBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 150
				elight.g = 255
				elight.b = 75
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:WaterBuff() and self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 0
				elight.b = 0
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end

		self:ZCTFire()
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			local min, max = self:GetCollisionBounds()
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), min, max, Color(255,0,0), true)
		end
	end

	function ENT:ZCTFire()
		if self:IsAlive() and self:GetShadowBuff() then
			if !IsValid(self) then return end
			if (!self.Draw_SHDWFX or !IsValid(self.Draw_SHDWFX)) then
				self.Draw_SHDWFX = CreateParticleSystem(self, "zmb_zombie_shadow_marked", PATTACH_POINT_FOLLOW, 10)
			end
		end
		if self:IsAlive() and self:GetZCTFlameColor() ~= "" then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self.Draw_FX = CreateParticleSystem(self, self:GetZCTFlameColor(), PATTACH_POINT_FOLLOW, 10)
			end
		end
	end

	function ENT:PostDraw() end -- Is called within the "Draw" function, added for easier adjusting/tweaking.

	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

		--[[if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()
			
			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end]]
		
		if eyeColor == nocolor then return end


		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 5, 5, eyeColor)
			render.DrawSprite(righteyepos, 5, 5, eyeColor)
		end
	end

	hook.Add("CreateClientsideRagdoll", "nzZCTragdollfire", function(ent, ragdoll)
        if not IsValid(ent) or not IsValid(ragdoll) then return end
        if not ent:IsValidZombie() then return end
        
        if nzGum.NewtonianNegation then
        	--local phys = ragdoll:GetPhysicsObject()
        	local bones = ragdoll:GetPhysicsObjectCount()
        	for i = 0, bones - 1 do

				local phys = ragdoll:GetPhysicsObjectNum( i )
				if ( IsValid( phys ) ) then
					phys:EnableGravity( false )
					phys:Wake()
				end
			end
        end
        --
        if IsValid(ent) and ent.GetZCTFlameColor and ent:GetZCTFlameColor() then 
        	if ent:GetZCTFlameColor() == "" then
        		return 
        	end
        end

        if ent.Draw_FX and IsValid(ent.Draw_FX) then
            ent.Draw_FX:StopEmissionAndDestroyImmediately()
        end
    end)
end


-- Below is a BUNCH and I mean a BUNCH of tables, consisting of both sequences and sounds.
-- Its important to note that you should refrain from using tables with the exact names these have.
-- For example, you use the "MeleeDeathSequences" table and you only have one sequence in it. It would still try and use the other ones, but would possibly error due to your model not having the sequences.

-- You can override these ones. Using ACTS just kinda suck.
ENT.ZombieLandSequences = {
	"nz_base_traverse_procedural_land", -- Will only ever be one, for easy overridding.
}
ENT.ZombieJumpStartSequences = {
	"nz_base_traverse_procedural_start",
}
ENT.ZombieLedgeClimbLoopSequences = {
	"nz_base_zombie_jump_up_loop",
}
ENT.ZombieLedgeClimbSequences = {
	"nz_base_zombie_jump_up_finish", -- Will only ever be one, for easy overridding.
}
ENT.ZombieLedgeClimbMantleOverSequences = {
	"nz_base_zombie_jump_2_mantle_finish", -- Will only ever be one, for easy overridding.
}
ENT.ZombieLedgeCrawlClimbMantleOverSequences = {
	"nz_base_zombie_crawl_jump_2_mantle_finish", -- Will only ever be one, for easy overridding.
}
ENT.ZombieLedgeClimbSmallLoopSequences = {
	"nz_base_zombie_jump_up_small_loop",
}
ENT.ZombieLedgeClimbSmallSequences = {
	"nz_base_zombie_jump_up_small_finish", -- Will only ever be one, for easy overridding.
}
ENT.ZombieDespawnSequences = {
	"nz_base_zombie_stand_despawn_01",
}


ENT.MeleeDeathSequences = {
	"nz_death_falltoknees_1",
	"nz_death_falltoknees_2",
	"nz_death_nerve",
	"nz_death_neckgrab",
	"nz_bayonet_thrust_death",
	"nz_exposed_death_twist"
}
ENT.CrawlBlackHoleDeathSequences = {
	"nz_blackhole_crawl_death_v1",
	"nz_blackhole_crawl_death_v2",
	"nz_blackhole_crawl_death_v3"
}
ENT.BlackHoleDeathSequences = {
	"nz_blackhole_death_v1",
	"nz_blackhole_death_v2",
}
ENT.HeavyDeathSequences = {
	"nz_t9_dth_f_chest_hvy_00",
	"nz_t9_dth_f_chest_hvy_01",
	"nz_t9_dth_f_chest_hvy_02",
	"nz_t9_dth_f_head_hvy_01",
	"nz_t9_dth_f_head_hvy_02",
	"nz_t9_dth_f_head_hvy_03",
	"nz_t9_dth_f_larm_hvy_00",
	"nz_t9_dth_f_larm_hvy_01",
}
ENT.BlastDeathSequences = {
	"nz_death_blast_1",
	"nz_death_blast_2",

	"nz_l4d_death_shotgun_03",
	"nz_l4d_death_shotgun_04",
	"nz_l4d_death_shotgun_05",
	"nz_l4d_death_shotgun_06",
	"nz_l4d_death_shotgun_07",
	"nz_l4d_death_shotgun_08",
	"nz_l4d_death_shotgun_09",
	
	"nz_mixamo_dead4",
	
	"nz_death_explosion_run_b_v2", --they fly away really far with these two lmao
	"nz_death_explosion_stand_b_v3",
}
ENT.BlastDeathLeftSequences = {
	"nz_death_blast_from_right",
}
ENT.BlastDeathRightSequences = {
	"nz_death_blast_from_left",
}
ENT.BlastDeathBackSequences = {
	"nz_death_blast_from_back",
}

ENT.ReactTauntSequences = {
	"nz_legacy_taunt_v1",
	"nz_legacy_taunt_v2",
}

ENT.SuperTauntSequences = {
	"nz_legacy_taunt_v11",
	"nz_legacy_taunt_v12",
}

ENT.SlipGunSequences = {
	"nz_slipslide_collapse",
	"nz_sprint_slipslide",
	"nz_sprint_slipslide_a",
}
ENT.ThunderGunSequences = {
	"nz_margwa_smash_react_a",
	"nz_l4d_shoved_backward_04o",

	"nz_tgun_react_blend_1",
	"nz_tgun_react_blend_2",
	"nz_tgun_react_blend_3",
	"nz_tgun_react_blend_4",
	"nz_tgun_react_blend_5",
}
ENT.MicrowaveSequences = {
	"nz_dth_microwave_1",
	"nz_dth_microwave_2",
	"nz_dth_microwave_3",
}
ENT.FreezeSequences = {
	"nz_dth_freeze_1",
	"nz_dth_freeze_2",
	"nz_dth_freeze_3",
}
ENT.DeathRaySequences = {
	"nz_dth_deathray_2",
	"nz_dth_deathray_3",
	"nz_dth_deathray_4",
}
ENT.SoulDrainSequences = {
	"nz_dth_soul_drain_loop",
}

ENT.IdGunSequences = {
	"nz_idgunhole",
}
ENT.AcidStunSequences = {
	"nz_acid_stun_1",
	"nz_acid_stun_2",
	"nz_acid_stun_3",
}
ENT.IceStaffSequences = {
	"nz_icestaff_death_a",
	"nz_icestaff_death_b",
	"nz_icestaff_death_c",
	"nz_icestaff_death_d",
	"nz_icestaff_death_e",
}
ENT.FireStaffDeathSequences = {
	"nz_firestaff_death_collapse_a",
	"nz_firestaff_death_collapse_b",
	
	"nz_flame_death_f",
	"nz_flame_death_g",
	"nz_flame_death_h",
}
ENT.SparkySequences = {
	"nz_sparky_a",
	"nz_sparky_b",
	"nz_sparky_c",
	"nz_sparky_d",
	"nz_sparky_e",
}
ENT.ShrinkSequences = {
	"nz_alistairs_shrunk",
}
ENT.UnawareSequences = {
	"nz_unaware_idle",
	"nz_unaware_idle_2",
}
ENT.CrawlDeathSequences = {
	"nz_crawl_death_v1",
	"nz_crawl_death_v2",
}
ENT.CrawlTeslaDeathSequences = {
	"nz_crawl_tesla_death_v1",
	"nz_crawl_tesla_death_v2",
}
ENT.CrawlFreezeDeathSequences = {
	"nz_crawl_freeze_death_v1",
	"nz_crawl_freeze_death_v2",
}
ENT.CrawlMicrowaveSequences = {
	"nz_crawl_dth_microwave_1",
	"nz_crawl_dth_microwave_2",
	"nz_crawl_dth_microwave_3",
}
ENT.CrawlSparkySequences = {
	"nz_crawl_sparky_a",
	"nz_crawl_sparky_b",
	"nz_crawl_sparky_c",
	"nz_crawl_sparky_d",
	"nz_crawl_sparky_e",
}
ENT.DanceSequences = {
	"nz_goofyah_v1",
	"nz_goofyah_v2",
	"nz_goofyah_v3",
	"nz_goofyah_v4",
	"nz_goofyah_v5",
	"nz_goofyah_v6",
	"nz_goofyah_v7",
	"nz_goofyah_v8",
	"nz_goofyah_v9",
	"nz_goofyah_v10",
	"nz_goofyah_v11",
	"nz_goofyah_v12",
	"nz_goofyah_v13",
	"nz_goofyah_v14",
	"nz_goofyah_v15",
	"nz_goofyah_v16",

	"nz_actmod_dance_californiagirls",
	"nz_actmod_dance_quagmire",
	"nz_fartnut_dance_griddy",
	"nz_fartnut_dance_jumpingjoy",
	"nz_fartnut_dance_nevergonna",
	"nz_fartnut_dance_sunburst",
	"nz_fartnut_dance_sunlit",
	"nz_fartnut_dance_twistdaytona",
	"nz_fartnut_dance_twisteternity_teo",
	"nz_fartnut_dance_distraction",
	"nz_actmod_dance_gangnamstyle",
	"nz_fartnut_dance_alien",
	"nz_fartnut_dance_backflip",
	"nz_fartnut_dance_bbd",
	"nz_fartnut_dance_behere",
	"nz_fartnut_dance_birdword",
	"nz_fartnut_dance_breakdance",
	"nz_fartnut_dance_coolrobot",
	"nz_fartnut_dance_dancemoves",
	"nz_fartnut_dance_fancyfeet",
	"nz_fartnut_dance_flippnsexy",
	"nz_fartnut_dance_floppy",
	"nz_fartnut_dance_fresh",
	"nz_fartnut_dance_goth",
	"nz_fartnut_dance_groovejam",
	"nz_fartnut_dance_hillbilly",
	"nz_fartnut_dance_hiphop",
	"nz_fartnut_dance_hula",
	"nz_fartnut_dance_pumpkin",
	"nz_fartnut_dance_runningman",
	"nz_fartnut_dance_securityguard",
	"nz_fartnut_dance_skeleton",
	"nz_fartnut_dance_smoothride",
	"nz_fartnut_dance_swim",
	"nz_fartnut_dance_taichi",
	"nz_fartnut_dance_technozombie",
	"nz_fartnut_dance_texting",
	"nz_fartnut_dance_thighslapper",
	"nz_fartnut_dance_tpose",
	"nz_fartnut_dance_wiggle",
	"nz_mixamo_dance4",
	"nz_mixamo_dance5",
	
	"nz_gm_dance",
	"nz_gm_dance_muscle",
	"nz_gm_dance_robot",
}
ENT.ElectricDanceSequences = {
	"nz_base_vign_zombie_electric_dance_01",
	"nz_base_vign_zombie_electric_dance_02",
	"nz_base_vign_zombie_electric_dance_03",
	"nz_base_vign_zombie_electric_dance_04",
	"nz_base_vign_zombie_electric_dance_05",
	"nz_base_vign_zombie_electric_dance_06",
	"nz_base_vign_zombie_electric_dance_08",
	"nz_base_vign_zombie_electric_dance_09",
	"nz_base_vign_zombie_electric_dance_11",
	"nz_base_vign_zombie_electric_dance_12",
	"nz_base_vign_zombie_electric_dance_13",
	
	"nz_fartnut_dance_walkywalk",
	"nz_fartnut_dance_littleegg",

	"nz_iw7_cp_zom_headspin_01",
	"nz_iw7_cp_zom_headspin_02",
	"nz_iw7_cp_zom_poplock_01",
	"nz_iw7_cp_zom_poplock_02",
	"nz_iw7_cp_zom_poplock_03",
	"nz_iw7_cp_zom_poplock_04",
	"nz_iw7_cp_zom_poplock_05",
	"nz_iw7_cp_zom_poplock_06",
}
ENT.SideStepSequences = {
	"nz_dodge_sidestep_left_a",
	"nz_dodge_sidestep_left_b",
	
	"nz_dodge_sidestep_right_a",
	"nz_dodge_sidestep_right_b",

	"nz_t8_walk_dodge_sidestep_left_a",
	"nz_t8_walk_dodge_sidestep_left_b",
	"nz_t8_walk_dodge_sidestep_left_c",

	"nz_t8_walk_dodge_sidestep_right_a",
	"nz_t8_walk_dodge_sidestep_right_b",
	"nz_t8_walk_dodge_sidestep_right_c",
}
ENT.DodgeRollSequences = {
	"nz_dodge_roll_a",
	"nz_dodge_roll_b",
	"nz_dodge_roll_c",
	"nz_l4d_run_stumble", -- They fall and eat shit.
}
ENT.ZCTDodgeSequences = {
	"nz_zom_exo_dodge_left",
	"nz_zom_exo_dodge_right",
}
ENT.ExoLungeSequences = {
	"nz_zom_exo_lunge_atk_2h_01",
	"nz_zom_exo_lunge_atk_l_01",
	"nz_zom_exo_lunge_atk_r_01",
}
ENT.TomatoThrowSequences = {
	"nz_base_attack_ranged_left_blend_01",
	"nz_base_attack_ranged_right_blend_01",
}
ENT.PainSequences = {
	"nz_base_react_knockdown_b_1",
	"nz_base_react_knockdown_b_2",
	"nz_base_react_knockdown_f_1",
	"nz_base_react_knockdown_f_2",
	"nz_base_react_knockdown_l_1",
	"nz_base_react_knockdown_l_2",
	"nz_base_react_knockdown_r_1",
	"nz_base_react_knockdown_r_2",
}
ENT.HeadPainSequences = {
	"nz_pain_head_v1",
	"nz_pain_head_v2",
}
ENT.LeftPainSequences = {
	"nz_pain_left_v1",
	"nz_pain_left_v2",
	"nz_pain_dismem_larm_1",
	"nz_pain_dismem_larm_2",
	"nz_pain_dismem_larm_3",
}
ENT.RightPainSequences = {
	"nz_pain_right_v1",
	"nz_pain_right_v2",
	"nz_pain_dismem_rarm_1",
	"nz_pain_dismem_rarm_2",
	"nz_pain_dismem_rarm_3",
}
ENT.CrawlerPainSequences = {
	"nz_pain_rleg",
	"nz_pain_dismem_lleg_1",
	"nz_pain_dismem_lleg_2",
	"nz_pain_dismem_lleg_3",
	"nz_pain_dismem_lleg_4",
	"nz_pain_dismem_rleg_1",
	"nz_pain_dismem_rleg_2",
	"nz_pain_dismem_rleg_3",
	"nz_pain_dismem_rleg_4",
}

ENT.LeftWindowAttackSequences = {
	"nz_win_attack_arm_L_down",
	"nz_win_attack_arm_L_out",
	"nz_win_attack_body_L",
	"nz_win_attack_body_L_down",
	"nz_win_attack_body_L_out",
}
ENT.RightWindowAttackSequences = {
	"nz_win_attack_arm_R_down",
	"nz_win_attack_arm_R_out",
	"nz_win_attack_body_R",
	"nz_win_attack_body_R_down",
	"nz_win_attack_body_R_out",
}
ENT.MiddleWindowAttackSequences = {
	"nz_win_attack_body_out_01",
	"nz_win_attack_body_out_02",
	"nz_win_attack_body_out_03",
	"nz_win_attack_body_out_04",
	"nz_win_attack_arm_L_down",
	"nz_win_attack_arm_L_out",
	"nz_win_attack_body_L",
	"nz_win_attack_body_L_down",
	"nz_win_attack_body_L_out",
	"nz_win_attack_arm_R_down",
	"nz_win_attack_arm_R_out",
	"nz_win_attack_body_R",
	"nz_win_attack_body_R_down",
	"nz_win_attack_body_R_out",
}
ENT.GreenSlamSequences = {
	"nz_adorabolf_slam",
}

ENT.UndercroftSequences = {
	"nz_undercroft_spawn_v2",
	"nz_undercroft_spawn_v3",
}

ENT.WallSpawnSequences = {
	"nz_moo_wall_emerge_quick",
}

ENT.DimensionalWallSpawnSequences = {
	"nz_ent_dimensional_rift_sngl",
}

ENT.JumpSpawnSequences = {
	"nz_spawn_ground_jumpout",
}

ENT.ElevatorFloorSpawnSequences = {
	"nz_base_riser_elevator_from_floor",
}

ENT.ElevatorCeilingSpawnSequences = {
	"nz_base_riser_elevator_from_ceiling",
}

ENT.ProneCrawlSequences = {
	"nz_s4_3arc_traverse_ground_crawl",
}

ENT.UnderbedSequences = {
	"nz_base_ent_under_bed_01",
	"nz_base_ent_under_bed_02",
	"nz_base_ent_under_bed_03",
}

ENT.Alcove40Sequences = {
	"nz_base_zombie_alcove_traverse_40",
}

ENT.Alcove56Sequences = {
	"nz_base_zombie_alcove_traverse_56",
}

ENT.Alcove96Sequences = {
	"nz_base_zombie_alcove_traverse_96",
}

ENT.DugUpSpawnSequences = {
	"nz_s4_3arc_traverse_ground_dugup",
}

ENT.BarrelSpawnSequences = {
	"nz_ent_barrel_44",
}

ENT.LowCeilingDropSpawnSequences = {
	"nz_ent_ceiling_112",
}

ENT.HighCeilingDropSpawnSequences = {
	"nz_ent_ceiling_144",
}

ENT.GroundWallSpawnSequences = {
	"nz_ent_ground_wall_01",
	"nz_ent_ground_wall_03",
}

ENT.NormalMantleOver36 = {
	"nz_base_zombie_run_mantle_over_36",
}

ENT.NormalMantleOver48 = {
	"nz_mantle_over_48",
}

ENT.NormalFastMantleOver48 = {
	"nz_base_zombie_run_mantle_over_48",
}

ENT.NormalMantleOver72 = {
	"nz_mantle_over_72",
}

ENT.NormalMantleOver96 = {
	"nz_mantle_over_96",
}

ENT.NormalMantleOver128 = {
	"nz_mantle_over_128",
}

ENT.NormalJumpDown128 = {
	"nz_trav_run_jump_down_128",
}

ENT.NormalJumpUp128 = {
	"nz_trav_run_jump_up_128",
}

ENT.NormalJumpUp128Quick = {
	"nz_trav_run_jump_up_128_quick",
}

ENT.JumpThroughClosetDoor = {
	"nz_zom_core_spawn_closet_door_v1",
	"nz_zom_core_spawn_closet_door_v2",
	"nz_zom_core_spawn_closet_door_v3",
	"nz_zom_core_spawn_closet_door_v4",
}

ENT.CrawlThroughCarSlow = {
	"nz_base_zombie_traverse_car",
}

ENT.CrawlThroughCarFast = {
	"nz_base_zombie_traverse_car_run",
}

ENT.CrawlThroughCarSuperFast = {
	"nz_base_zombie_traverse_car_sprint",
}

ENT.NormalForwardReactSequences = {
	"nz_stn_idle_react_f_v1",
	"nz_stn_idle_react_f_v2",
	"nz_stn_idle_react_f_v3",
	"nz_stn_idle_react_f_v4",
	--"nz_l4d_violentalert_f",
}

ENT.NormalLeftReactSequences = {
	"nz_stn_idle_react_l_v1",
	--"nz_l4d_violentalert_l",
}

ENT.NormalRightReactSequences = {
	"nz_stn_idle_react_r_v1",
	--"nz_l4d_violentalert_r",
}

ENT.NormalBackwardReactSequences = {
	"nz_stn_idle_react_b_v1",
}

ENT.IncapAttackSequences = {
	"nz_l4d_attackincap_01",
	"nz_l4d_attackincap_02",
}

ENT.BarricadeTearSequences = {} -- These are anims that enemies can use specifically when attacking barricades.

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_05.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/monkey/groan_00.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_01.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_02.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_03.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_04.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_05.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_06.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_07.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_classic/taunt/taunt_06.mp3"),
}

ENT.MeleeWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_02.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_03.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_04.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_05.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_06.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_t10/heavy/zmb_swipe_heavy_07.mp3"),
}

ENT.AttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_00.mp3"),
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_05.mp3"),
}

ENT.GoofyahAttackSounds = {
	Sound("nz_moo/zombies/plr_impact/_goofy/punch_boxing_bodyhit03.wav"),
	Sound("nz_moo/zombies/plr_impact/_goofy/punch_boxing_facehit1.wav"),
	Sound("nz_moo/zombies/plr_impact/_goofy/punch_boxing_facehit2.wav"),
	Sound("nz_moo/zombies/plr_impact/_goofy/punch_boxing_facehit3.wav"),
	Sound("nz_moo/zombies/plr_impact/_goofy/punch_boxing_facehit4.wav"),
}

ENT.DanceSounds = {
	Sound("nz_moo/effects/aats/turned/gallery_music_1.mp3"),
	Sound("nz_moo/effects/aats/turned/gallery_music_2.mp3"),
	Sound("nz_moo/effects/aats/turned/disco_of_the_dead_shorter_1.mp3"),
	Sound("nz_moo/effects/aats/turned/disco_of_the_dead_shorter_2.mp3"),
	Sound("nz_moo/effects/aats/turned/low_quality_funky_town.mp3"),
	Sound("nz_moo/effects/aats/turned/goofy_ah_sounds.mp3"),
	Sound("nz_moo/effects/aats/turned/turned_up_1.mp3"),
	Sound("nz_moo/effects/aats/turned/turned_up_2.mp3"),
	Sound("nz_moo/effects/aats/turned/turned_up_3.mp3"),
	Sound("nz_moo/effects/aats/turned/turned_up_4.mp3"),
	Sound("nz_moo/effects/aats/turned/low_quality_19_2000_instrumental.mp3"),
	Sound("nz_moo/effects/aats/turned/roblose.mp3"),
	Sound("nz_moo/effects/aats/turned/the_penis_EEK.mp3"),
	Sound("nz_moo/effects/aats/turned/testicular_tango.mp3"),
	Sound("nz_moo/effects/aats/turned/fnaf1_ambience.mp3"),
	Sound("nz_moo/effects/aats/turned/fnaf2_hallway_ambience.mp3"),
	Sound("nz_moo/effects/aats/turned/aheh_a_very_groovy_song.mp3"),
	Sound("nz_moo/effects/aats/turned/dancing_around_in_circles_until_my_little_feet_fall_off.mp3"),
	Sound("nz_moo/effects/aats/turned/hl1_song25_remix3.mp3"),
	Sound("nz_moo/effects/aats/turned/hl1_song11.mp3"),
	Sound("nz_moo/effects/aats/turned/goofy_ah_sounds2.mp3"),
	Sound("nz_moo/effects/aats/turned/loonboon.mp3"),
	Sound("nz_moo/effects/aats/turned/winds_of_fjords.mp3"),
	Sound("nz_moo/effects/aats/turned/chasing_nightmares.mp3"),
	Sound("nz_moo/effects/aats/turned/back_in_reverse.mp3"),
}

ENT.BloodExplodeSounds = {
	Sound("nz_moo/zombies/gibs/explode/explode_00.mp3"),
	Sound("nz_moo/zombies/gibs/explode/explode_01.mp3"),
	Sound("nz_moo/zombies/gibs/explode/explode_02.mp3"),
	Sound("nz_moo/zombies/gibs/explode/explode_03.mp3"),
}

ENT.CrawlImpactSounds = {
	Sound("nz_moo/zombies/footsteps/crawl/crawl_00.mp3"),
	Sound("nz_moo/zombies/footsteps/crawl/crawl_01.mp3"),
	Sound("nz_moo/zombies/footsteps/crawl/crawl_02.mp3"),
	Sound("nz_moo/zombies/footsteps/crawl/crawl_03.mp3"),
}

ENT.WaterFootstepsSounds = {
	Sound("player/footsteps/slosh1.wav"),
	Sound("player/footsteps/slosh2.wav"),
	Sound("player/footsteps/slosh3.wav"),
	Sound("player/footsteps/slosh4.wav"),
}

ENT.GibSounds = {
	Sound("nz_moo/zombies/gibs/gib_00.mp3"),
	Sound("nz_moo/zombies/gibs/gib_01.mp3"),
	Sound("nz_moo/zombies/gibs/gib_02.mp3"),
	Sound("nz_moo/zombies/gibs/gib_03.mp3"),
}

ENT.HeadGibSounds = {
	Sound("nz_moo/zombies/gibs/head/_og/zombie_head_00.mp3"),
	Sound("nz_moo/zombies/gibs/head/_og/zombie_head_01.mp3"),
	Sound("nz_moo/zombies/gibs/head/_og/zombie_head_02.mp3"),
}

ENT.NormalWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/walk/walk_00.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_01.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_02.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_03.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_04.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_05.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_06.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_07.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_08.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_09.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_10.mp3"),
	Sound("nz_moo/zombies/footsteps/walk/walk_11.mp3"),
}

ENT.NormalRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/run/run_00.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_01.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_02.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_03.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_04.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_05.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_06.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_07.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_08.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_09.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_10.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_11.mp3"),
	Sound("nz_moo/zombies/footsteps/run/run_12.mp3"),
}

ENT.ZombieMutateSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_vox/zmb_transform_vox_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_vox/zmb_transform_vox_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_vox/zmb_transform_vox_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_vox/zmb_transform_vox_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_vox/zmb_transform_vox_04.mp3"),
}

ENT.QuacknarokPopSounds = {
	Sound("nz_moo/bgb/quacknarok/pop_00.mp3"),
	Sound("nz_moo/bgb/quacknarok/pop_01.mp3"),
	Sound("nz_moo/bgb/quacknarok/pop_02.mp3"),
	Sound("nz_moo/bgb/quacknarok/pop_03.mp3"),
	Sound("nz_moo/bgb/quacknarok/pop_04.mp3"),
	Sound("nz_moo/bgb/quacknarok/pop_05.mp3"),
}

ENT.QuacknarokDeflateSounds = {
	Sound("nz_moo/bgb/quacknarok/deflate_00.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_01.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_02.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_03.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_04.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_05.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_06.mp3"),
	Sound("nz_moo/bgb/quacknarok/deflate_07.mp3"),
}

ENT.QuacknarokQuackSounds = {
	Sound("nz_moo/bgb/quacknarok/quack_00.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_01.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_02.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_03.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_04.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_05.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_06.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_07.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_08.mp3"),
	Sound("nz_moo/bgb/quacknarok/quack_09.mp3"),
}

ENT.BodyfallLightSounds = {
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_00.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_01.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_02.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_03.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_04.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_05.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_06.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_07.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_08.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_09.mp3"),
}

ENT.BodyfallHeavySounds = {
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_00.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_01.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_02.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_03.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_04.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_05.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_06.mp3"),
	Sound("nz_moo/zombies/fly/bodyfall/heavy/fly_bodyfall_heavy_07.mp3"),
}

ENT.TauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v1_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v1_02.mp3"),
}

ENT.TauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v2_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v2_02.mp3"),
}

ENT.TauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v3_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v3_02.mp3"),
}

ENT.TauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v4_01.mp3"),
}

ENT.TauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v5_01.mp3"),
}

ENT.TauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v6_01.mp3"),
}

ENT.TauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v7_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v7_02.mp3"),
}

ENT.TauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v8_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v8_02.mp3"),
}

ENT.TauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v9_01.mp3"),
	Sound("nz_moo/zombies/vox/taunt_anims/taunt_anim_v9_02.mp3"),
}

-- God I love Roxanne, she's such a bad bitch tho!!!
-- The ELECTRIC SLIDE