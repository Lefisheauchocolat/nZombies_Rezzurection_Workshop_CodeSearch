AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Jumping Jack"
ENT.Category = "Brainz"
ENT.Author = "Loonicity"

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.MooSpecialZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.AttackRange = 80

ENT.Models = {
	{Model = "models/kate/_codz_ports/t6/leaper/labys_arch_enemy.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_leaper_spawn"}

local AttackSequences = {
	{seq = "nz_leaper_attack_v1"},
	{seq = "nz_leaper_attack_v2"},
}

local JumpSequences = {
	{seq = "nz_leaper_barricade"},
}


ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence = "nz_leaper_idle_v1"
ENT.IdleSequenceAU = "nz_leaper_idle_v2"

ENT.ZombieLandSequences = {
	"nz_leaper_jump_land", -- Will only ever be one, for easy overridding.
}

ENT.DeathSequences = {
	"nz_leaper_death_v1",
	"nz_leaper_death_v2",
}

ENT.ElectrocutionSequences = {
	"nz_leaper_death_elec_v1",
	"nz_leaper_death_elec_v2",
	"nz_leaper_death_elec_v3",
	"nz_leaper_death_elec_v4",
}

ENT.LeftLeapSequences = {
	"nz_leaper_death_elec_v1",
	"nz_leaper_death_elec_v2",
}

ENT.RightLeapSequences = {
	"nz_leaper_death_elec_v1",
	"nz_leaper_death_elec_v2",
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/ambient/ambient_05.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_leaper/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/attack/attack_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_leaper/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/death/death_04.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_leaper/spawn/spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/spawn/spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/spawn/spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/spawn/spawn_03.mp3"),
}

ENT.StepSounds = {
	Sound("nz_moo/zombies/vox/_leaper/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/step/step_03.mp3"),
}

ENT.LandSounds = {
	Sound("nz_moo/zombies/vox/_leaper/land/land_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/land/land_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/land/land_02.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/land/land_03.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/land/land_04.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/land/land_05.mp3"),
}

ENT.SwipeSounds = {
	Sound("nz_moo/zombies/vox/_leaper/swipe/swipe_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/swipe/swipe_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/swipe/swipe_02.mp3"),
}

ENT.ZapSounds = {
	Sound("nz_moo/zombies/vox/_leaper/zap/leaper_zap.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/zap/leaper_zap2.mp3"),
}

ENT.BlackHoleDeathSequences = {
    "nz_leaper_vortex_death_v1",
    "nz_leaper_vortex_death_v2",
}

ENT.LowCeilingDropSpawnSequences = {
    "nz_leaper_spawn_dropdown",
}

ENT.HighCeilingDropSpawnSequences = {
    "nz_leaper_spawn_dropdown",
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_leaper/close/close_00.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/close/close_01.mp3"),
	Sound("nz_moo/zombies/vox/_leaper/close/close_02.mp3"),
}

ENT.MicrowaveSequences = {
    "nz_leaper_death_microwave_v1",
    "nz_leaper_death_microwave_v2",
    "nz_leaper_death_microwave_v3",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_leaper_run_v1",
				"nz_leaper_run_v2",
			},
			BlackholeMovementSequence = {
				"nz_leaper_vortex_walk_v1",
				"nz_leaper_vortex_walk_v2",
				"nz_leaper_vortex_walk_v3",
				"nz_leaper_vortex_walk_v4",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

function ENT:PostDeath(dmginfo)
self:EmitSound(self.ZapSounds[math.random(#self.ZapSounds)], 75, math.random(85, 105))
if IsValid(self) then ParticleEffectAttach("hcea_shield_impact", 3, self, 2) end
end

function ENT:StatsInitialize()
	if SERVER then
		self.Sprinting = false
		self.IgnitedFoxy = false
	end
	self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 41))
	self:SetSurroundingBounds(Vector(-20, -20, 0), Vector(20, 20, 100))
end

function ENT:OnSpawn(animation, grav, dirt)
	local spawn
	local types = {
		["nz_spawn_zombie_normal"] = true,
		["nz_spawn_zombie_special"] = true,
		["nz_spawn_zombie_extra1"] = true,
		["nz_spawn_zombie_extra2"] = true,
		["nz_spawn_zombie_extra3"] = true,
		["nz_spawn_zombie_extra4"] = true,
	}
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 10)) do
		if types[v:GetClass()] then
			if !v:GetMasterSpawn() then
				spawn = v
			end
		end
	end
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

			ParticleEffect("zmb_zombie_spawn_dirt",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
			self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
		end

	if IsValid(spawn) and spawn:GetSpawnType() == 1 then
		if IsValid(self) then
			self:EmitSound(self.ZapSounds[math.random(#self.ZapSounds)], 75, math.random(85, 105))
			if IsValid(self) then ParticleEffect("hcea_shield_impact", self:GetPos() + Vector(0,0,20), Angle(0,0,0), self) end
		end
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:CollideWhenPossible()
	else

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
end


function ENT:AI()
	if IsValid(self:GetTarget()) then
			if self:GetSpecialAnimation() then return end
			if nzPowerUps:IsPowerupActive("timewarp") then return end -- OR! If Time Distortion:tm: is active

			if self:TargetInRange(500) and !self.AttackIsBlocked and math.random(15) <= 15 and CurTime() > self.LastSideStep then
				if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
					local seq = self.SideStepSequences[math.random(#self.SideStepSequences)]
					-- By default, try to sidestep.
					
					local chance = math.random(3)
					
					local animation
					debugoverlay.BoxAngles(self:GetPos() + self:GetUp()*150 + self:GetForward()*95, Vector(-1,-15,0), Vector(10,10,5), self:GetAngles(), 3, Color( 255, 0, 0, 10))
					
					local parkour = {
						[1] = function()
							seq = "nz_leaper_ceiling"
							local tr = util.TraceHull({
								start = self:GetPos() + self:GetUp()*150 + self:GetForward()*95,
								endpos = self:GetPos(),
								filter = self,
								mask = MASK_SOLID_BRUSHONLY,
								ignoreworld = false,
								mins = Vector(-1,-15,0),
								maxs = Vector(10,10,5),
							})

							if tr.HitWorld then 
							--print("gay")
							return seq
							end
							return false
						end, 
						[2] = function()
							seq = "nz_leaper_wall_left_long"
							local tr = util.TraceHull({
								start = self:GetPos() + self:GetUp()*50 + self:GetForward()*75,
								endpos = self:GetPos(),
								filter = self,
								mask = MASK_SOLID_BRUSHONLY,
								ignoreworld = false,
								mins = Vector(-1,-15,0),
								maxs = Vector(1,200,5),
							})

							if tr.HitWorld then 
							--print("gay")
							return seq
							end
							return false
						end, 
						[3] = function()
							seq = "nz_leaper_wall_right_long"
							local tr = util.TraceHull({
								start = self:GetPos() + self:GetUp()*50 + self:GetForward()*75,
								endpos = self:GetPos(),
								filter = self,
								mask = MASK_SOLID_BRUSHONLY,
								ignoreworld = false,
								mins = Vector(-1,-200,0),
								maxs = Vector(1,5,5),
							})

							if tr.HitWorld then 
							--print("gay")
							return seq
							end
							return false
						end, 
					}
					
					
					
					
					
					animation = parkour[chance](seq)
					
					if animation then
						self:DoSpecialAnimation(animation, true, true)
						 --If there isn't space at all, don't dodge.
					end
					self.LastSideStep = CurTime() + 2.5
				end
			end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "melee" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "death_ragdoll" then
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
	if e == "leaper_step" then
		self:EmitSound(self.StepSounds[math.random(#self.StepSounds)], 75, math.random(95,105))
	end
	if e == "leaper_land" then
		self:EmitSound(self.LandSounds[math.random(#self.LandSounds)], 75, math.random(95,105))
	end
	if e == "leaper_whoosh" then
		self:EmitSound(self.SwipeSounds[math.random(#self.SwipeSounds)], 75, math.random(95,105))
	end
end