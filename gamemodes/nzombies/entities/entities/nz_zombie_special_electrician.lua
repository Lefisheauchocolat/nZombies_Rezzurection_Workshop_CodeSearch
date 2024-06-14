AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "The Octogonal Robber"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 

	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then
				self.Draw_FX = CreateParticleSystem(self, "thief_smog", PATTACH_POINT_FOLLOW, 1)

			end
		end
	end

	return 
end -- Client doesn't really need anything beyond the basics

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
--ENT.IsMooBossZombie = true
--ENT.IsMiniBoss = true

ENT.AttackRange = 60
ENT.DamageRange = 150 
ENT.AttackDamage = 1
ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/bo1/octogonal_robber.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

ENT.DeathSequences = {
	"nz_pentagonthief_death_f",
	"nz_pentagonthief_death_b"
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

local walksounds = {
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_03.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_04.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_05.mp3"),
	Sound("wavy_zombie/octogonal_robber/ambient/ambient_06.mp3"),
}

local runsounds = {
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_03.mp3"),
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_04.mp3"),
	Sound("wavy_zombie/octogonal_robber/sprint/sprint_05.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_pentagonthief_walk",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 70, Sequences = {
		{
			MovementSequence = {
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run2",
				"nz_pentagonthief_run",
				"nz_gm_sprint",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/octogonal_robber/death/death_00.mp3",
	"wavy_zombie/octogonal_robber/death/death_01.mp3",
	"wavy_zombie/octogonal_robber/death/death_02.mp3",
	"wavy_zombie/octogonal_robber/death/death_03.mp3"
}

ENT.AngerSounds = {
	"wavy_zombie/octogonal_robber/anger/anger_00.mp3",
	"wavy_zombie/octogonal_robber/anger/anger_01.mp3",
	"wavy_zombie/octogonal_robber/anger/anger_02.mp3",
	"wavy_zombie/octogonal_robber/anger/anger_03.mp3"
}

ENT.StealSounds = {
	"wavy_zombie/octogonal_robber/steal/steal_00.mp3",
	"wavy_zombie/octogonal_robber/steal/steal_01.mp3",
	"wavy_zombie/octogonal_robber/steal/steal_02.mp3",
	"wavy_zombie/octogonal_robber/steal/steal_03.mp3"
}

ENT.CustomWalkFootstepsSounds = {
	"nz_moo/zombies/vox/_astro/fly_step/step_00.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_01.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_02.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_03.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_04.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_05.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_06.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_07.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_08.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_09.mp3"
}

ENT.CustomRunFootstepsSounds = {
	"nz_moo/zombies/vox/_astro/fly_step/step_00.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_01.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_02.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_03.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_04.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_05.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_06.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_07.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_08.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_09.mp3"
}

ENT.CustomAttackImpactSounds = {
	"nz_moo/zombies/vox/mute_00.wav"
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local round = nzRound:GetNumber()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(10000)
			self:SetMaxHealth(10000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(round * 2000 + (4000 * count), 10000, 60000))
				self:SetMaxHealth(math.Clamp(round * 2000 + (4000 * count), 10000, 60000))
			else
				self:SetHealth(10000)
				self:SetMaxHealth(10000)	
			end
		end

		self:SetRunSpeed(35)

		self.criminal = false
		malding = false
		self.SprintCooldown = CurTime() + 4
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:EmitSound("nz_moo/effects/teleport_in_00.mp3", 100)
	if IsValid(self) then ParticleEffect("panzer_spawn_tp", self:WorldSpaceCenter(), Angle(0,0,0), self) end
end

function ENT:PerformDeath(dmginfo)

	local damagetype = dmginfo:GetDamageType()
	
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
	if self.criminal then
		nzPowerUps:SpawnPowerUp(self:GetPos(), "firesale")
		local class
		if dmginfo:GetAttacker():IsPlayer() then
			class = nzRandomBox.DecideWep(dmginfo:GetAttacker())
		else
			class = nzRandomBox.DecideWep(self:GetTarget())
		end
	local wep = ents.Create("nz_powerup_drop_weapon")
		wep:SetGun(class)
		wep:SetPos(self:GetPos() + Vector(0,0,48))
		wep:Spawn()
	else
		local chance = math.random(100)
		if chance < 50 then
			nzPowerUps:SpawnPowerUp(self:GetPos(), "bonfiresale")
		elseif chance >= 50 then
			nzPowerUps:SpawnPowerUp(self:GetPos(), "firesale")
		end
	end
	self:StopParticles()
end

function ENT:OnRemove()
	self:StopParticles()
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:OnThink()
	if self:TargetInAttackRange() then
		if SERVER then
		end
	end
end

function ENT:Attack()
	print("RUN YO SHIT")
	if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
		self:GetTarget():NZAstroSlow(1.5)
	end

	self:PlaySequenceAndWait("nz_pentagonthief_grab", 1, self.FaceEnemy)
	if malding then
		--print("He's no longer malding.")
		self:SetRunSpeed(35)
		self:SpeedChanged()
		malding = false
		self.SprintCooldown = CurTime() + 6
	end
end

function ENT:AI()
	local tar = self:GetTarget()
	if IsValid(tar) then
		if self:TargetInRange(950) and !self:IsAttackBlocked() and CurTime() > self.SprintCooldown and !malding then
			
			malding = true
			self:SetRunSpeed(70)
			self:SpeedChanged()
			self:EmitSound(self.AngerSounds[math.random(#self.AngerSounds)], 500, math.random(95, 105), 1, 2)
		end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "crawl_hand" then
		if self.CustomCrawlImpactSounds then
			self:EmitSound(self.CrawlImpactSounds[math.random(#self.CrawlImpactSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepCrawl")
		end
	end
	if e == "melee" or e == "melee_heavy" then
		if self:BomberBuff() and self.GasAttack then
			self:EmitSound(self.GasAttack[math.random(#self.GasAttack)], 100, math.random(95, 105), 1, 2)
		else
			if self.AttackSounds then
				self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			end
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end
	if e == "base_ranged_rip" then
		ParticleEffectAttach("ins_blood_dismember_limb", 4, self, 5)
		self:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(0,3)..".mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/gibs/head/head_explosion_0"..math.random(4)..".mp3", 65, math.random(95,105))
	end
	if e == "base_ranged_throw" then
		self:EmitSound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_0"..math.random(0,2)..".mp3", 95)

		local larmfx_tag = self:LookupBone("j_wrist_le")

		self.Guts = ents.Create("nz_gib")
		self.Guts:SetPos(self:GetBonePosition(larmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			--[[if target:IsPlayer() then
				movementdir = target:GetVelocity():Normalize()
				print(movementdir)
			end]]
			phys:SetVelocity(self.Guts:getvel(target:EyePos() - Vector(0,0,7), self:EyePos(), 0.95))
		end
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
	if e == "pull_plank" then
		if IsValid(self) and self:Alive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
		end
	end

	if e == "pentagon_steal" then
	local guygettingrobbed = self:GetTarget()
	if IsValid(self) and guygettingrobbed:IsPlayer() and guygettingrobbed:GetPos():Distance( self:GetPos()) < 150 then
	self:EmitSound(self.StealSounds[math.random(#self.StealSounds)], 500, math.random(95, 105), 1, 2)
	guygettingrobbed:Give("tfa_bo3_wepsteal")
	guygettingrobbed:SelectWeapon("tfa_bo3_wepsteal")
	self.criminal = true
	print("give me your wallet")
	end
	end
	
	if e == "pentagon_teleport" then
		local available = ents.FindByClass("nz_spawn_zombie_special")
		local pos = self:GetPos()
		local spawns = {}

		if IsValid(available[1]) then
			for k, v in ipairs(available) do
				if v.link == nil or nzDoors:IsLinkOpened(v.link) then
					if v:IsSuitable() then
						table.insert(spawns, v)
					end
				end
			end
			if !IsValid(spawns[1]) then
				local pspawns = ents.FindByClass("nz_spawn_zombie_normal")
				if !IsValid(pspawns[1]) then
					print("Octogonal Robber couldn't find an escape for some reason.")
				else
					pos = pspawns[math.random(#pspawns)]:GetPos()
				end
			else
				pos = spawns[math.random(#spawns)]:GetPos()
			end
		else
			local pspawns = ents.FindByClass("player_spawns")
			if IsValid(pspawns[1]) then
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		end

		self:SetPos(pos)
		self:EmitSound("nz_moo/effects/teleport_in_01.mp3", 500, 100, 1, 0)
		ParticleEffectAttach("bo3_qed_explode_3", 4, self, 1)
	end
end
