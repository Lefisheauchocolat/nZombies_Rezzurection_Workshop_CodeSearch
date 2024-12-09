AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Laby"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.RedEyes = false

ENT.Models = {
	{Model = "models/zombies/alien.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/zombies/alien.mdl", Skin = 1, Bodygroups = {0,0}},
    {Model = "models/zombies/alien.mdl", Skin = 2, Bodygroups = {0,0}},
	
}

ENT.AttackRange = 70
ENT.DamageRange = 75
ENT.AttackDamage = 42
local spawn = {"Emerge1,Emerge2, Emerge3"}

ENT.DeathSequences = {
	"Flinch_Torso",
}


ENT.IdleSequence = "Idle_3"

local AttackSequences = {
	{seq = "Attack1"},
	{seq = "Attack2"},
	{seq = "Attack3"},
	{seq = "Attack4"},
	{seq = "Attack7"},
	{seq = "Attack13"},
}

local RunAttackSequences = {
	{seq = "Attack6"},
	{seq = "Attack8"},
	{seq = "Attack9"},
	{seq = "Runatk2"}
}


local JumpSequences = {
	{seq = "RunCrouch_2"}
}


	
	
local walksounds = {
	Sound("character/alien/vocals/alien_growl_short_01.mp3"),
	Sound("character/alien/vocals/alien_growl_short_02.mp3"),
	Sound("character/alien/vocals/alien_growl_short_03.mp3"),
	Sound("character/alien/vocals/alien_growl_short_04.mp3"),
	Sound("character/alien/vocals/alien_growl_short_05.mp3"),
	Sound("character/alien/vocals/alien_growl_short_06.mp3"),
	Sound("character/alien/vocals/alien_growl_short_07.mp3"),
	
	Sound("character/alien/vocals/alien_hiss_long_01.mp3"),
	Sound("character/alien/vocals/alien_hiss_long_02.mp3"),
	Sound("character/alien/vocals/alien_hiss_long_03.mp3"),
	Sound("character/alien/vocals/alien_hiss_long_04.mp3"),
}

local runsounds = {
	Sound("character/alien/vocals/aln_taunt_01.mp3"),
	Sound("character/alien/vocals/aln_taunt_02.mp3"),
	Sound("character/alien/vocals/aln_taunt_03.mp3"),
	Sound("character/alien/vocals/aln_taunt_04.mp3"),
	Sound("character/alien/vocals/aln_taunt_05.mp3"),
	Sound("character/alien/vocals/aln_taunt_06.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done. Except it isnt because these little fuckers don't have many animations :(
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Walk",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
		
	}},
	{Threshold = 140, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Run",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
		
	}},
	{Threshold = 190, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"RunCrouch",
				"RunCrouch_2",
			},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},

			PassiveSounds = {runsounds},
		},
		
	}}
}




ENT.DeathSounds = {
	"character/alien/vocals/alien_death_scream_iconic_elephant.mp3",
	"character/alien/vocals/aln_death_scream_20.mp3",
	"character/alien/vocals/aln_death_scream_21.mp3",
	"character/alien/vocals/aln_death_scream_22.mp3",
	"character/alien/vocals/aln_death_scream_23.mp3",
	"character/alien/vocals/aln_death_scream_24.mp3",
	"character/alien/vocals/aln_death_scream_25.mp3",
	"character/alien/vocals/aln_death_scream_26.mp3",
	"character/alien/vocals/aln_death_scream_27.mp3",
}

ENT.DeathSounds = {
	"character/alien/vocals/alien_death_scream_iconic_elephant.mp3",
	"character/alien/vocals/aln_death_scream_20.mp3",
	"character/alien/vocals/aln_death_scream_21.mp3",
	"character/alien/vocals/aln_death_scream_22.mp3",
	"character/alien/vocals/aln_death_scream_23.mp3",
	"character/alien/vocals/aln_death_scream_24.mp3",
	"character/alien/vocals/aln_death_scream_25.mp3",
	"character/alien/vocals/aln_death_scream_26.mp3",
	"character/alien/vocals/aln_death_scream_27.mp3",
}


ENT.AttackSounds = {
	"character/alien/vocals/aln_pain_small_1.mp3",
	"character/alien/vocals/aln_pain_small_2.mp3",
	"character/alien/vocals/aln_pain_small_3.mp3",
	"character/alien/vocals/aln_pain_small_4.mp3",
	"character/alien/vocals/aln_pain_small_5.mp3",
	"character/alien/vocals/aln_pain_small_6.mp3",
	"character/alien/vocals/aln_pain_small_7.mp3",
	"character/alien/vocals/aln_pain_small_8.mp3",
	"character/alien/vocals/aln_pain_small_9.mp3",
	"character/alien/vocals/aln_pain_small_10.mp3",
}


ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("enemies/zombies/alien/vocals/aln_taunt_01"),
	Sound("enemies/zombies/alien/vocals/aln_taunt_02"),
	Sound("enemies/zombies/alien/vocals/aln_taunt_06")
}

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetRunSpeed( math.random(25, 220) )
			self:SetHealth( math.random(100, 1500) )
		else
			local speeds = nzRound:GetZombieCoDSpeeds()
			if speeds then
				self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
			else
				self:SetRunSpeed( 100 )
			end
			self:SetHealth( nzRound:GetZombieHealth() or 75 )
		end
		self.Exploded = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end


function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "Hit" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "Step" then
		self:EmitSound("character/alien/footsteps/walk/prd_fs_dirt_"..math.random(1,15)..".mp3", 65, math.random(95,105))
	end
	if e == "Claw" then
		self:EmitSound("nz_moo/zombies/fly/attack/whoosh/_og/swing_0"..math.random(0,2)..".mp3", 65, math.random(95,105))
	end
	if e == "Tail" then
		self:EmitSound("nz_moo/zombies/fly/attack/whoosh/_og/swing_0"..math.random(0,2)..".mp3", 65, math.random(95,105))
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if dirt then
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

		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
		self:EmitSound("character/alien/vocals/aln_trophy_struggle_0"..math.random(1,2)..".mp3", 500, 100, 1, 2)
	end

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		
		self:PlaySequenceAndMove(animation, {gravity = grav})

		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end


function ENT:PerformDeath(dmginfo)
	local damagetype = dmginfo:GetDamageType()
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathSounds then
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:EmitSound("enemies/zombies/former/explode"..math.random(1,3)..".ogg")
	if math.random(4) == 2 then
		if self.Exploded then return end
		self.Exploded = true -- Prevent a possible infinite loop that causes crashes.
		local fuckercloud = ents.Create("acid_puddle")
		fuckercloud:SetPos(self:GetPos())
		fuckercloud:SetAngles(Angle(0,0,0))
		fuckercloud:Spawn()
	end
	self:Remove(dmgInfo)
	end
	
	
end

ENT.PainSounds = {
	"nz_moo/zombies/vox/_zhd/pain/pain_00.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_01.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_02.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_03.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_04.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_05.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_06.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_07.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_08.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_09.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_10.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_11.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_12.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_13.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_14.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_15.mp3",
	"nz_moo/zombies/vox/_zhd/pain/pain_16.mp3",
}

if SERVER then
	function ENT:ResetMovementSequence()
			self:ResetSequence(self.MovementSequence)
			self.CurrentSeq = self.MovementSequence
		
		if self.UpdateSeq ~= self.CurrentSeq then -- Moo Mark 4/19/23: Finally got a system where the speed actively updates when the movement sequence set is changed.
			--print("update")
			self.UpdateSeq = self.CurrentSeq
			--self.loco:SetDesiredSpeed(  math.random( 90, 350 ) )
		end
	end
	
	-- This function is full of stench
	function ENT:OnBarricadeBlocking( barricade, dir )
		if not self:GetSpecialAnimation() then
			if (IsValid(barricade) and barricade:GetClass() == "breakable_entry" ) then

				local warppos

				--[[ This allows the zombie to know which side of the barricade is which when climbing over it ]]--
				local normal = (self:GetPos() - barricade:GetPos()):GetNormalized()
				local fwd = barricade:GetForward()
				local dot = fwd:Dot(normal)
				if 0 < dot then
					warppos = (barricade:WorldSpaceCenter() + fwd*32)
				else
					warppos = (barricade:WorldSpaceCenter() + fwd*-32)
				end

				local bpos = barricade:ReserveAvailableTearPosition(self) or warppos

				if barricade:GetNumPlanks() > 0 then
					local currentpos

					-- If for some reason the position is nil... Just idle until further notice.
					if !bpos then
						self:TimeOut(2)
						return
					end

					if !self:GetIsBusy() and bpos then -- When the zombie initially comes in contact with the barricade.
						self:SetIsBusy(true)
						self:MoveToPos(bpos, { lookahead = 20, tolerance = 20, draw = false, maxage = 1, repath = 1, })

						self:TimeOut(0.5) -- An intentional and W@W authentic stall.
						self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)
					end

					currentpos = self:GetPos()
					if bpos and currentpos ~= bpos then
						self:SetPos(Vector(bpos.x,bpos.y,currentpos.z))
					end
					
					self:SetAngles(Angle(0,(barricade:GetPos()-self:GetPos()):Angle()[2],0))

					if IsValid(barricade.ZombieUsing) then -- Moo Mark 3/15/23: Trying out something where only one zombie can actively attack a barricade at a time.
						self:TimeOut(1)
						if barricade then
							self:OnBarricadeBlocking(barricade, dir)
							return
						end
					else
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
					
						if not self.IsMooSpecial and not self:GetCrawler() then -- Don't let special zombies use the tear anims.
							if type(teartarget) == "table" then
								seq, dur = self:LookupSequenceAct(teartarget.seq)
							elseif teartarget then -- It is a string or ACT
								seq, dur = self:LookupSequenceAct(teartarget)
							else
								seq, dur = self:LookupSequence("Attack_4")
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

						local planktopull = barricade:BeginPlankPull(self)
						local planknumber -- fucking piece of shit
						if planktopull then
							planknumber = planktopull:GetFlags()
						end

						if !IsValid(barricade.ZombieUsing) then
							barricade:HasZombie(self) -- Blocks any other zombie from attacking the barricade.
						end

						if self.AttackSounds then self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2) end
						if self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial then
							if planknumber ~= nil then
								if !self:GetCrawler() then
									self:PlaySequenceAndWait("Attack_4")
									if IsValid(self) and self:Alive() then
										if IsValid(planktopull) then
											barricade:RemovePlank(planktopull)
										end
									end
									self:PlaySequenceAndWait("Attack_4")
								else
									self:PlaySequenceAndWait("Attack_4")
									if IsValid(self) and self:Alive() then
										if IsValid(planktopull) then
											barricade:RemovePlank(planktopull)
										end
									end
									self:PlaySequenceAndWait("Attack_4")
								end
							end
						else
							timer.Simple(dur/2, function() -- Moo Mark. This is very sinful but my dumbass can't think of anything else rn.
								if IsValid(self) and self:Alive() and IsValid(planktopull) then -- This is just so the plank being pulled looks nicer and will look like the zombie is actually pulling that bitch.
									barricade:RemovePlank(planktopull)
								end
							end)

							self:PlaySequenceAndWait("Attack_4")
						end

						if barricade then
							self:OnBarricadeBlocking(barricade, dir)
							return
						end
					end
				elseif barricade:GetTriggerJumps() and self.TriggerBarricadeJump then
					self:SetIsBusy(true)
					self:ResetMovementSequence()
					self:MoveToPos(warppos, { lookahead = 20, tolerance = 5, draw = false, maxage = 1, repath = 1, })
					self:SetPos(Vector(warppos.x,warppos.y,self:GetPos().z))
					self:SetAngles(Angle(0,(barricade:GetPos()-self:GetPos()):Angle()[2],0))
					self:TimeOut(0.5)

					self:TriggerBarricadeJump(barricade, dir)
				else
					self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)
					local pos = barricade:GetPos() - dir * 50 -- Moo Mark
						self:MoveToPos(pos, { -- Zombie will move through the barricade.
						lookahead = 20,
						tolerance = 20,
						draw = false,
						maxage = 3,
						repath = 3,
					})
					self:CollideWhenPossible()
					self:SetIsBusy(false)
				end
			end
		end
	end
end
