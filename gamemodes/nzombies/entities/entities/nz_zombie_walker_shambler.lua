AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Laby"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true



ENT.Models = {
	{Model = "models/enemies/wolfenstein/nz_shambler.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"alert_idle","alert_idle2","alert_idle3"}
local spawnsuperfast = {"ragdoll"}


ENT.IdleSequence = "idle","idle2","idle3", "idle4"


local AttackSequences = {
	{seq = "melee1"},
	{seq = "melee2"}
}

local AttackSequencesRUN = {
	{seq = "melee3"},
	{seq = "melee1"},
	{seq = "melee2"}
}

local walksounds = {
	Sound("shambler/idle/idle_lp_01.wav"),
	Sound("shambler/idle/idle_lp_02.wav"),
	Sound("shambler/idle/idle_lp_03.wav"),
	Sound("shambler/idle/idle_lp_04.wav"),
	Sound("shambler/idle/idle_lp_05.wav"),
	Sound("shambler/idle/idle_lp_06.wav"),

}
local runsounds = {
	Sound("shambler/alert/alert_01.wav"),
	Sound("shambler/alert/alert_02.wav"),
	Sound("shambler/alert/alert_03.wav"),
	Sound("shambler/alert/alert_04.wav"),
	Sound("shambler/alert/alert_05.wav"),
	Sound("shambler/alert/alert_06.wav"),
	Sound("shambler/alert/alert_07.wav"),
	Sound("shambler/alert/alert_08.wav"),
	Sound("shambler/alert/alert_09.wav"),
	Sound("shambler/alert/alert_10.wav"),

}



-- This is a very large and messy looking table... But it gets the job done. Except it isnt because these little fuckers don't have many animations :(
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"walk"
			},
			AttackSequences = {AttackSequences},

			PassiveSounds = {walksounds},
		},
		
	}},
	{Threshold = 60, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"combat_walk",
			},
			AttackSequences = {AttackSequences},

			PassiveSounds = {walksounds},
		},
		
	}},
	{Threshold = 110, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"run",
			},
			AttackSequences = {AttackSequencesRUN},

			PassiveSounds = {runsounds},
		},
		
	}},
}



ENT.DeathSounds = {
	"shambler/death/shambler_vo_death_001.wav",
	"shambler/death/shambler_vo_death_002.wav",
	"shambler/death/shambler_vo_death_003.wav",
	"shambler/death/shambler_vo_death_004.wav",
	"shambler/death/shambler_vo_death_005.wav",
	"shambler/death/shambler_vo_death_006.wav",
	"shambler/death/shambler_vo_death_007.wav",
	"shambler/death/shambler_vo_death_008.wav",
}

ENT.NukeDeathSounds = {
	"nz_moo/zombies/vox/nuke_death/soul_00.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_01.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_02.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_03.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_04.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_05.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_06.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_07.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_08.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_09.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_10.mp3"
}

ENT.AttackSounds = {
	"shambler/attack/shamber_vo_attack_012.wav",
	"shambler/attack/shamber_vo_attack_013.wav",
	"shambler/attack/shamber_vo_attack_014.wav",
	"shambler/attack/shamber_vo_attack_015.wav",
	"shambler/attack/shamber_vo_attack_016.wav",
	"shambler/attack/shamber_vo_attack_017.wav",
	"shambler/attack/shamber_vo_attack_018.wav",
	"shambler/attack/shamber_vo_attack_019.wav",
	"shambler/attack/shamber_vo_attack_020.wav",
	"shambler/attack/shamber_vo_attack_021.wav",
}


ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("shambler/alert/alert_01.wav"),
	Sound("shambler/alert/alert_02.wav"),
	Sound("shambler/alert/alert_03.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end

		self:SetHealth( nzRound:GetZombieHealth() or 75 )
		self.AttackDamage = nzRound:GetZombieDamage() or 50
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "atk_hit" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	
	if e == "left_step" then
		self:EmitSound("shambler/steps/foot_ai_shambler_metalsolid_step_left"..math.random(1,3)..".wav", 65, math.random(95,105))
	end
	if e == "right_step" then
		self:EmitSound("shambler/steps/foot_ai_shambler_metalsolid_step_right"..math.random(1,3)..".wav", 65, math.random(95,105))
	end
end

function ENT:OnSpawn()
	local nav = navmesh.GetNavArea(self:GetPos(), 50)
	if IsValid(nav) and nav:HasAttributes(NAV_MESH_NO_JUMP) then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:CollideWhenPossible()
	else
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

		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

		--ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		--self:EmitSound("nz/zombies/spawn/zm_spawn_dirt"..math.random(1,2)..".wav",80,math.random(95,105))
	
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		local seq = self:SelectSpawnSequence()


		local navtypes = {
			[NAV_MESH_OBSTACLE_TOP] = true,
			[NAV_MESH_DONT_HIDE] = true,
		}



			if tr.Hit then
				local finalsound = SpawnMatSound[tr.MatType] or SpawnMatSound[0]
				self:EmitSound(finalsound)
			end
			ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
		
		if seq then
			if IsValid(nav) and (nav:HasAttributes(NAV_MESH_OBSTACLE_TOP) or nav:HasAttributes(NAV_MESH_DONT_HIDE)) then
				self:PlaySequenceAndMove(seq, {gravity = false})
			else
				self:PlaySequenceAndMove(seq, {gravity = true})
			end
			self:SetSpecialAnimation(false)
			self:SetIsBusy(false)
			self:CollideWhenPossible()
		end
	end
end

function ENT:PerformDeath(dmgInfo)
	
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:EmitSound("enemies/zombies/former/explode"..math.random(1,3)..".ogg")
	ParticleEffect("bo3_annihilator_blood", self:GetPos(), angle_zero)
			self:Remove()
		end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound("enemies/zombies/former/explode"..math.random(1,3)..".ogg")
	ParticleEffect("bo3_annihilator_blood", self:GetPos(), angle_zero)
			self:Remove()
		end
	end)
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
	
function ENT:OnRemove()
	self:StopSound("shambler/idle/idle_lp_01.wav")
	self:StopSound("shambler/idle/idle_lp_02.wav")
	self:StopSound("shambler/idle/idle_lp_03.wav")
	self:StopSound("shambler/idle/idle_lp_04.wav")
	self:StopSound("shambler/idle/idle_lp_05.wav")
	self:StopSound("shambler/idle/idle_lp_06.wav")
end

if SERVER then

function ENT:UpdateModel()
		local models = self.Models
		local choice = models[math.random(#models)]
		util.PrecacheModel( choice.Model )
		self:SetModel(choice.Model)
		if choice.Skin then self:SetSkin(choice.Skin) end
	self:SetBodygroup(0,math.random(0,2))
	self:SetBodygroup(3,math.random(0,18))
	end

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
								seq, dur = self:LookupSequence("attack")
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
									self:PlaySequenceAndWait("attack")
									if IsValid(self) and self:IsAlive() then
										if IsValid(planktopull) then
											barricade:RemovePlank(planktopull)
										end
									end
									self:PlaySequenceAndWait("attack")
								else
									self:PlaySequenceAndWait("attack")
									if IsValid(self) and self:IsAlive() then
										if IsValid(planktopull) then
											barricade:RemovePlank(planktopull)
										end
									end
									self:PlaySequenceAndWait("attack")
								end
							end
						else
							timer.Simple(dur/2, function() -- Moo Mark. This is very sinful but my dumbass can't think of anything else rn.
								if IsValid(self) and self:IsAlive() and IsValid(planktopull) then -- This is just so the plank being pulled looks nicer and will look like the zombie is actually pulling that bitch.
									barricade:RemovePlank(planktopull)
								end
							end)

							self:PlaySequenceAndWait("attack")
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
