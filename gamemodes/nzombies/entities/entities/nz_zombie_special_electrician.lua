AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "The Octogonal Robber"
ENT.PrintName = "Pentagon Thief"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 

	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
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
ENT.IsMiniBoss = true

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

local AttackSequences = {
	{seq = "nz_legacy_attack_v3"},
	{seq = "nz_legacy_attack_v6"},
	{seq = "nz_legacy_attack_v4"},
	{seq = "nz_legacy_attack_v11"},
	{seq = "nz_legacy_attack_v12"},
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
	{Threshold = 71, Sequences = {
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
	}},
	{Threshold = 155, Sequences = {
		{
			MovementSequence = {
				"nz_pentagonthief_run2",
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
	Sound("wavy_zombie/octogonal_robber/death/death_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/death/death_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/death/death_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/death/death_03.mp3")
}

ENT.AngerSounds = {
	Sound("wavy_zombie/octogonal_robber/anger/anger_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_03.mp3")
}

ENT.StealSounds = {
	Sound("wavy_zombie/octogonal_robber/steal/steal_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/steal/steal_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/steal/steal_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/steal/steal_03.mp3")
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_07.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_08.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_09.mp3")
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_07.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_08.mp3"),
	Sound("nz_moo/zombies/vox/_astro/fly_step/step_09.mp3")
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("wavy_zombie/octogonal_robber/anger/anger_00.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_01.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_02.mp3"),
	Sound("wavy_zombie/octogonal_robber/anger/anger_03.mp3")
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav")
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

		self:SetTargetCheckRange(60000)
		self:SetRunSpeed(35)

		self.criminal = false
		malding = false

		self.SprintCooldown = CurTime() + 4


		self.RobbedPlayers = {}
		self.RobbedEveryone = false
		self.FleeingToSpecialSpawn = false
		self.LeaveCountdown = 5
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
	
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()
	
	if damagetype == DMG_REMOVENORAGDOLL then
		if IsValid(dmginfo) then
			self:Remove(dmginfo)
		else
			self:Remove()
		end
	end

	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)

	if self.criminal and !self.RemovedSelf then
		nzPowerUps:SpawnPowerUp(self:GetPos(), "firesale")
		for k,v in pairs(self.RobbedPlayers) do
			PrintTable(self.RobbedPlayers)
			if IsValid(k) and k.GotRobbed then
				local ply = k
				local weapon = self.RobbedPlayers[ply].gun
				local packapunch = self.RobbedPlayers[ply].pap

				ply.GotRobbed = false
				--print("Unrob this person")
				--print(weapon)
				--print(packapunch)
				ply:Give(weapon)

				--[[if packapunch then
					ply:GetActiveWeapon().NZPaPME = true
				end]]
			end
		end
		for k,v in pairs(player.GetAll()) do
			if IsValid(v) and v.GotRobbed then
				v.GotRobbed = false
				table.remove(self.RobbedPlayers, k)
			end
		end
	elseif self.criminal and self.RemovedSelf then
		self.FoundPlayer = false
		for k,v in pairs(player.GetAll()) do
			if IsValid(v) and !self.FoundPlayer then
				self.FoundPlayer = true
				nzPowerUps:SpawnPowerUp(v:GetPos(), "firesale")
			end
		end
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

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY and !ent.GotRobbed
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:OnThink()
	if self:TargetInAttackRange() then
		if SERVER then
		end
	end
end

function ENT:Attack()
	if self:GetTarget():IsPlayer() then
		print("RUN YO SHIT")
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
			self:GetTarget():NZAstroSlow(1.5)
		end

		if malding then
			self:SetRunSpeed(35)
			self:SpeedChanged()
			malding = false
			self.SprintCooldown = CurTime() + 6
		end

		self:PlaySequenceAndWait("nz_pentagonthief_grab", 1, self.FaceEnemy)
	else
		self:TimeOut(1)
	end
end

function ENT:AI()
	local tar = self:GetTarget()
	if IsValid(tar) and tar:IsPlayer() then
		if self:TargetInRange(950) and !self:IsAttackBlocked() and CurTime() > self.SprintCooldown and !malding then	
			malding = true

			self:DoSpecialAnimation("nz_taunt_v3")

			self:SetRunSpeed(71)
			self:SpeedChanged()
		end
	end
end

function ENT:TeleportToSpecialSpawn()

	local pos = self:FindSpecialSpawn()

	self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)

	self:SetPos(pos)
	self:EmitSound("nz_moo/effects/teleport_in_01.mp3", 500, 100, 1, 0)
	ParticleEffectAttach("bo3_qed_explode_3", 4, self, 1)

	self:FleeToSpecialSpawn()
end

function ENT:FleeToSpecialSpawn()
	if !self.WasAbleToSteal then return end
	self:TempBehaveThread(function(self)
		if !self.FleeingToSpecialSpawn then
			local pos = self:FindSpecialSpawn()
			self.FleeingToSpecialSpawn = true

			self:SetRunSpeed(155)
			self:SpeedChanged()

			self:MoveToPos(pos, {
				lookahead = 1,
				tolerance = 10,
				draw = false,
				maxage = 8,
				repath = 3,
			})

			ParticleEffect("bo3_qed_explode_3", pos, Angle(0,0,0), nil)

			self:Goodbye()
			self.FleeingToSpecialSpawn = false
			self:TeleportToSpecialSpawn()
		end

	end)
end

function ENT:Goodbye()
	if self.LeaveCountdown < 1 then
		self.RemovedSelf = true

		local dmginfo = DamageInfo()
		dmginfo:SetAttacker( self )
		dmginfo:SetDamage( self:Health() + 666 )
		dmginfo:SetDamageType( DMG_REMOVENORAGDOLL )

		self:TakeDamageInfo(dmginfo)
	else
		self.LeaveCountdown = self.LeaveCountdown - 1
	end
end

function ENT:FindSpecialSpawn()
	local available = ents.FindByClass("nz_spawn_zombie_special")
	local pos = self:GetPos()
	local spawns = {}

	if IsValid(available[1]) then
		for k, v in ipairs(available) do
			if (v.link == nil or nzDoors:IsLinkOpened(v.link) or nzDoors:IsLinkOpened(v.link2) or nzDoors:IsLinkOpened(v.link3)) and !v:GetMasterSpawn() then
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
	return pos
end

function ENT:OnNoTarget()
	if !self.FleeingToSpecialSpawn and self.RobbedEveryone then
		self:TimeOut(0.1) -- Instead of being brain dead for a second, just search for a new target sooner.
		self:FleeToSpecialSpawn()
	elseif !self.FleeingToSpecialSpawn and !self.RobbedEveryone then
		self:TimeOut(0.1)
		local newtarget = self:Retarget()
		if self:IsValidTarget(newtarget) then
			self.CancelCurrentPath = true
		else
			if !self:IsInSight() and nzRound:InProgress() and !nzRound:InState( ROUND_GO ) then
				self:RespawnZombie()
			else
				if nzRound:InState( ROUND_GO ) then
					self:OnGameOver()
				end
			end
		end
	else
		self:TimeOut(1)
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	
	if e == "pentagon_steal" then
		local guygettingrobbed = self:GetTarget()
		if IsValid(self) and !guygettingrobbed.GotRobbed and guygettingrobbed:IsPlayer() and guygettingrobbed:GetPos():Distance( self:GetPos()) < 150 and !self:IsAttackBlocked() then
			local wep = guygettingrobbed:GetActiveWeapon()

			if !wep:IsSpecial() and !guygettingrobbed:GetUsingSpecialWeapon() then
				guygettingrobbed.GotRobbed = true

				self.WasAbleToSteal = true

				-- Store the target's current gun and if it was upgraded or not.
				self.RobbedPlayers[guygettingrobbed] = {gun = wep:GetClass(), pap = wep:HasNZModifier("pap")}

				if nzRound:InState(ROUND_CREATE) then
					guygettingrobbed:StripWeapon(wep:GetClass())
				end

				self.criminal = true
				print("give me your wallet")

				PrintTable(self.RobbedPlayers)
				print(table.Count(self.RobbedPlayers))

				guygettingrobbed:Give("tfa_bo3_wepsteal")
				guygettingrobbed:SelectWeapon("tfa_bo3_wepsteal")

				self:EmitSound(self.StealSounds[math.random(#self.StealSounds)], 500, math.random(95, 105), 1, 2)

				if !self.RobbedEveryone and table.Count(self.RobbedPlayers) >= #player.GetAllPlaying() then 
					self.RobbedEveryone = true
				end
			else
				self.WasAbleToSteal = false
				print("Not allowed to steal this weapon or it isn't a weapon at all.")
			end
		end
	end
	
	if e == "pentagon_teleport" then
		self:TeleportToSpecialSpawn()
	end
end

function ENT:OnRemove()
	self:StopParticles()
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) and v.GotRobbed then
			v.GotRobbed = false
			table.remove(self.RobbedPlayers, k)
		end
	end
end
