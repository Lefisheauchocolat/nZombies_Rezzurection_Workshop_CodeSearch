AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Thrasher aka The Cheekeater"
ENT.PrintName = "Thrasher"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("Entity", 	5, "CurrentZombie")
	self:NetworkVar("Entity", 	6, "CurrentPlayer")
	self:NetworkVar("Bool", 	7, "IsEnraged")
end

if CLIENT then 
	local eyeglow =  Material("nz/zlight")
	function ENT:Draw() //Runs every frame
		self:DrawModel()
		if self.RedEyes and self:IsAlive() and !self:GetDecapitated() then
			self:DrawEyeGlow() 
		end
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
		
		self:EffectsAndSounds()

		self:HideSelfFromVictim()
		--self:HideVictimFromClients()
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if self:GetIsEnraged() and (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self.Draw_FX = CreateParticleSystem(self, "bo3_thrasher_aura", PATTACH_POINT_FOLLOW, 1)
			end
		end
	end

	function ENT:DrawEyeGlow()
		local eyeColor = Color(255, 100, 0, 255)
		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.5
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.5

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 6, 6, eyeColor)
			render.DrawSprite(righteyepos, 6, 6, eyeColor)
		end
	end

	function ENT:HideSelfFromVictim()
		-- Get the Thrasher's player and the client.

		local currentply = self:GetCurrentPlayer()
		local ply = LocalPlayer()

		-- If they are equal, hide the thrasher from the client(victim)
		if self:IsAlive() and IsValid(currentply) and IsValid(ply) then
			if currentply:IsPlayer() and currentply == ply then
				self:SetNoDraw(true)
			else
				self:SetNoDraw(false)
			end
		else
			self:SetNoDraw(false)
		end
	end

	--[[function ENT:HideVictimFromClients()
		local currentply = self:GetCurrentPlayer()
		local ply = LocalPlayer()
		if IsValid(self) then
			if IsValid(currentply) and IsValid(ply) then
				if currentply:IsPlayer() and (currentply ~= ply or currentply == ply) then
					currentply:SetNoDraw(true)
				else
					currentply:SetNoDraw(false)
				end
			end
		else
			if IsValid(currentply) then
				currentply:SetNoDraw(false)
			end
		end
	end]]

	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.RedEyes = true

ENT.AttackRange = 100
ENT.AttackDamage = 90
ENT.HeavyAttackDamage = 150

ENT.TraversalCheckRange = 80

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/island/moo_codz_t7_island_thrasher.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_thrasher_transform"}

ENT.DeathSequences = {
	"nz_thrasher_death_v1",
	"nz_thrasher_death_v2"
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local AttackSequences = {
	{seq = "nz_thrasher_attack_swing_swipe"},
	{seq = "nz_thrasher_attack_swipe"},
}

local JumpSequences = {
	{seq = "nz_thrasher_mantle_over_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_07.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/ambient/ambient_08.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_03.mp3"),
}

ENT.IdleSequence = "nz_thrasher_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_thrasher_walk_f_v1",
				"nz_thrasher_walk_f_v2",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_thrasher_run_f_v1",
				"nz_thrasher_run_f_v2",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
}

ENT.ZombieLandSequences = {
	"nz_thrasher_jump_land",
}

ENT.CustomMantleOver48 = {
	"nz_thrasher_mantle_over_48"
}

ENT.CustomMantleOver72 = {
	"nz_thrasher_mantle_over_72"
}

ENT.CustomMantleOver96 = {
	"nz_thrasher_mantle_over_96"
}

ENT.CustomNormalJumpUp128 = {
	"nz_thrasher_jump_up_128"
}

ENT.CustomNormalJumpDown128 = {
	"nz_thrasher_jump_down_128"
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/attack/attack_03.mp3"),
}

ENT.EnrageSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/enrage/enrage_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/enrage/enrage_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/enrage/enrage_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/enrage/enrage_03.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/pain/pain_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/death/death_03.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/spawn/spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/spawn/spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/spawn/spawn_02.mp3"),
}

ENT.RoarSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/vox/roar/roar_03.mp3"),
}

ENT.BiteSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_04.mp3"),
}

ENT.StompSounds = {
	Sound("nz_moo/zombies/vox/_margwa/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_06.mp3"),
}

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.SporeExplodeSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_03.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_04.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_05.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_06.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/swing/swing_07.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(3500)
			self:SetMaxHealth(3500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 900 + (700 * count), 3500, 8700 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 900 + (700 * count), 3500, 8700 * count))
			else
				self:SetHealth(3500)
				self:SetMaxHealth(3500)	
			end
		end
		
		-- Instead of being random, it will now always be 15 to 30 seconds before a Thrasher becomes enraged.
		self.EnrageTime = CurTime() + math.random(15, 30)
		self.Enraged = false
		self:SetIsEnraged(false)

		self.TeleportCooldown = CurTime() + 1

		self.LegSpore = true
		self.ChestSpore = true
		self.BackSpore = true

		self.RegenCount = 0

		self:SetCurrentZombie(nil)
		self:SetCurrentPlayer(nil)

		self.Acting = false
		self.ActTime = CurTime() + 1

		self.SporeCount = 0
		self.RegenCooldown = CurTime() + 5

		self.IFrames = CurTime() + 3

		self:SetRunSpeed( 60 )
		self.loco:SetDesiredSpeed( 60 )
	end
end

function ENT:OnSpawn()
	local comedyday = os.date("%d-%m") == "01-04"
	if math.random(10000) == 1 or comedyday then
		self.Smog = ents.Create("nz_zombie_boss_smelly")
		self.Smog:SetPos(self:GetPos())
		self.Smog:SetAngles(self:GetAngles())
		self.Smog:Spawn()
		self:Remove()
	end

	self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
	self:SetSurroundingBounds(Vector(-26, -26, 0), Vector(26, 26, 75))
	
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:EmitSound(self.SpawnSounds[math.random(#self.SpawnSounds)],577)

	self:CreateVinesIn()

	self:SetSpecialAnimation(true)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	if self.ChestSpore then
		self:PopChestSporeEffect()
	elseif self.LegSpore then
		self:PopLegSporeEffect()
	elseif self.BackSpore then
		self:PopBackSporeEffect()
	end

	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			self:Remove()
		end
	else
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:AI()
	-- ENRAGE
	if !self.Enraged and CurTime() > self.EnrageTime then
		self.Enraged = true
		self:SetIsEnraged(true)

		self:EmitSound("nz_moo/zombies/vox/_thrasher/vox/spawn/spawn_0"..math.random(0,2)..".mp3",677)
		self:EmitSound("nz_moo/zombies/vox/_thrasher/enrage_imp_00.mp3",577)
		ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
		
		self:DoSpecialAnimation("nz_thrasher_enrage")
		self:SetRunSpeed(150)
		self:SpeedChanged()
	end

	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 8^2 then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() and self:GetRunSpeed() > 36 then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end

	-- SPORE REGENERATION
	if self.SporeCount ~= 0 and CurTime() > self.RegenCooldown and self.RegenCount < 3 then
		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.IsMooSpecial and v ~= self then
				if self:GetRangeTo( v:GetPos() ) < 85 then
					local seq = "nz_thrasher_eat_z_b"
					if self:SequenceHasSpace(seq) then
						if !IsValid(v) then return end

						self.RegenCooldown = CurTime() + 10

						self:TimeOut(0.25)

						self.Regen = true

						self:SetCurrentZombie(v)

						self:TempBehaveThread(function(self)
							if !IsValid(self:GetCurrentZombie()) then return end
							local zomb = self:GetCurrentZombie()

							self:SetSpecialAnimation(true)
							self:SetIsBusy(true)
							self.TraversalAnim = true
							self.Acting = true
							local pos = self:GetPos() + self:GetRight() * -6 + self:GetForward() * 70

							debugoverlay.Sphere(pos, 50, 5, Color( 255, 255, 255 ), false)

							--zomb:ApproachPosAndWait(pos, 13)
							zomb:SetPos(pos)
							zomb:SetAngles(self:GetAngles())

							self:FaceTowards(zomb:GetPos())

							zomb:DoSpecialAnimation("nz_zombie_eaten_by_thrasher_f", false, false, false)
							self:PlaySequenceAndMove(seq, 1)

							self:RegenSpore()
							self.Regen = false
							self:SetSpecialAnimation(false)
							self:SetIsBusy(false)
							self.TraversalAnim = false
							self.Acting = false
						end)
					end
				end
			end
		end
	end

	-- TELEPORT
	if IsValid(self.Target) and !self:TargetInRange(750) and CurTime() > self.TeleportCooldown then
		if !self.Target:IsPlayer() then return end

		local target = self.Target
		local pos = self:FindSpotBehindPlayer(target:GetPos(), 10)

		self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)

		self:CreateVinesOut()
		self:PlaySequenceAndWait("nz_thrasher_teleport_out")
		self:SetSpecialAnimation(true)


		self:SetPos( pos )
		self:FaceTowards(self.Target)

		self:CreateVinesIn()
		self:PlaySequenceAndWait("nz_thrasher_teleport_in")
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()

		self.TeleportCooldown = CurTime() + 7
	end

	-- ABDUCTION
	for k,v in pairs(player.GetAll()) do
		
		if #player.GetAllPlaying() <= 1 then return end

		if IsValid(v) and !v:GetNotDowned() and !IsValid(self:GetCurrentPlayer()) and !v:NZIsThrasherVictim() and math.random(3) == 1 then
			
			self:SetTarget(v)

			if !self:TargetInRange(450) then return end

			local pos = v:GetPos()

			self:ResetMovementSequence()
			self:MoveToPos(pos, {
				lookahead = 1,
				tolerance = 75,
				draw = false,
				repath = 3,
				maxage = 5,
			})

			self:FaceTowards(v:GetPos())
			self:DoSpecialAnimation("nz_thrasher_eat", 1)
			if IsValid(self) and self:IsAlive() then
				if !v:GetNotDowned() and !v:NZIsThrasherVictim() then
					--v:Kill()
					v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
					self:SetCurrentPlayer(v)
					v.ThrasherParent = self
				end
			end
		end
	end
end

function ENT:OnThink()
	local victim = self:GetCurrentPlayer()

	if self.Acting and !IsValid(self:GetCurrentZombie()) then
		self.Acting = false
		self:SetCurrentZombie(nil)
		self.CancelCurrentAction = true
	end

	if IsValid(victim) and victim:Alive() then
		victim:NZThrasherVictim(0.5, victim)
	elseif IsValid(victim) and !victim:Alive() then
		victim:SetParent(nil)
		self:SetCurrentPlayer(nil)
	end

	-- Spore Scales
	local spore1 = self:LookupBone("tag_spore_leg")
	local spore2 = self:LookupBone("tag_spore_chest")
	local spore3 = self:LookupBone("tag_spore_back")
	if self:GetManipulateBoneScale(spore1) == Vector(1,1,1) then
		if !self.BackSpore then
			self.BackSpore = true
		end
	else
		if self.BackSpore then
			self.BackSpore = false
		end
	end
	if self:GetManipulateBoneScale(spore2) == Vector(1,1,1) then
		if !self.LegSpore then
			self.LegSpore = true
		end
	else
		if self.LegSpore then
			self.LegSpore = false
		end
	end
	if self:GetManipulateBoneScale(spore3) == Vector(1,1,1) then
		if !self.ChestSpore then
			self.ChestSpore = true
		end
	else
		if self.ChestSpore then
			self.ChestSpore = false
		end
	end
end

function ENT:RegenSpore()
	-- Thrasher can only gain a spore back up to 3 times

	local healththreshold1 = self:GetMaxHealth() * 0.85
	local healththreshold2 = self:GetMaxHealth() * 0.45
	local hpgained = false

	self.RegenCount = self.RegenCount + 1
	self.SporeCount = self.SporeCount - 1

	-- Health just goes back up to previous threshold
	if self:Health() < healththreshold2 and !hpgained then 
		self:SetHealth(healththreshold2) 
		hpgained = true
	elseif self:Health() < healththreshold1 and !hpgained then
		self:SetHealth(healththreshold1)
		hpgained = true
	end

	if !self.LegSpore then
		self.LegSpore = true
		self:ManipulateBoneScale(self:LookupBone("tag_spore_leg"), Vector(1,1,1))
		return
	end
	if !self.ChestSpore then
		self.ChestSpore = true
		self:ManipulateBoneScale(self:LookupBone("tag_spore_chest"), Vector(1,1,1))
		return
	end
	if !self.BackSpore then
		self.BackSpore = true
		self:ManipulateBoneScale(self:LookupBone("tag_spore_back"), Vector(1,1,1))
		return
	end
end

function ENT:OnInjured(dmginfo)
	if !self:IsAlive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()

	local leg = self:LookupBone("tag_spore_leg")
	local legpos = self:GetBonePosition(leg)

	local chest = self:LookupBone("tag_spore_chest")
	local chestpos = self:GetBonePosition(chest)

	local back = self:LookupBone("tag_spore_back")
	local backpos = self:GetBonePosition(back)

	local healththreshold1 = self:GetMaxHealth() * 0.65
	local healththreshold2 = self:GetMaxHealth() * 0.35

	if CurTime() > self.IFrames then
		if self:Health() <= healththreshold1 and self.SporeCount == 0 then
			self:TestChestSpore(dmginfo)
			self:TestLegSpore(dmginfo)
			self:TestBackSpore(dmginfo)
		elseif self:Health() <= healththreshold2 and self.SporeCount == 1 then
			self:TestChestSpore(dmginfo)
			self:TestLegSpore(dmginfo)
			self:TestBackSpore(dmginfo)
		end
	end

	if hitpos:DistToSqr(legpos) < 18^2 and self.LegSpore and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.85)
	elseif hitpos:DistToSqr(chestpos) < 18^2 and self.ChestSpore and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.85)
	elseif hitpos:DistToSqr(backpos) < 18^2 and self.BackSpore and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.85)
	else
		dmginfo:ScaleDamage(0.25)
	end

	if !self.Enraged and math.random(100) < 25 then -- Have a chance of becoming enraged from just being shot.
		self.EnrageTime = 0
	end
end

function ENT:TestChestSpore(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local chest = self:LookupBone("tag_spore_chest")
	local chestpos = self:GetBonePosition(chest)
	if hitpos:DistToSqr(chestpos) < 20^2 and self.ChestSpore then
		local attacker = dmginfo:GetAttacker()

		self.RegenCooldown = CurTime() + 10
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self.ChestSpore = false
		self.SporeCount = self.SporeCount + 1

		self:PopChestSporeEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
    	timer.Simple(engine.TickInterval(), function()
			if self.SporeCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_thrasher_stunned_v1", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:TestLegSpore(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local leg = self:LookupBone("tag_spore_leg")
	local legpos = self:GetBonePosition(leg)
	if hitpos:DistToSqr(legpos) < 20^2 and self.LegSpore then
		local attacker = dmginfo:GetAttacker()

		self.RegenCooldown = CurTime() + 10
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self.LegSpore = false
		self.SporeCount = self.SporeCount + 1

		self:PopLegSporeEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
    	timer.Simple(engine.TickInterval(), function()
			if self.SporeCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_thrasher_stunned_v2", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:TestBackSpore(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local back = self:LookupBone("tag_spore_back")
	local backpos = self:GetBonePosition(back)
	if hitpos:DistToSqr(backpos) < 20^2 and self.BackSpore then
		local attacker = dmginfo:GetAttacker()


		self.RegenCooldown = CurTime() + 10
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self.BackSpore = false
		self.SporeCount = self.SporeCount + 1

		self:PopBackSporeEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
    	timer.Simple(engine.TickInterval(), function()
			if self.SporeCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_thrasher_stunned_v3", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:PopChestSporeEffect()
	local chest = self:LookupBone("tag_spore_chest")
	local chestpos = self:GetBonePosition(chest)

	self:ManipulateBoneScale(chest, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",chestpos, Angle(0,0,0), nil)
	self:EmitSound(self.SporeExplodeSounds[math.random(#self.SporeExplodeSounds)], 511)
end

function ENT:PopLegSporeEffect()
	local leg = self:LookupBone("tag_spore_leg")
	local legpos = self:GetBonePosition(leg)

	self:ManipulateBoneScale(leg, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",legpos, Angle(0,0,0), nil)
	self:EmitSound(self.SporeExplodeSounds[math.random(#self.SporeExplodeSounds)], 511)
end

function ENT:PopBackSporeEffect()
	local back = self:LookupBone("tag_spore_back")
	local backpos = self:GetBonePosition(back)

	self:ManipulateBoneScale(back, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",backpos, Angle(0,0,0), nil)
	self:EmitSound(self.SporeExplodeSounds[math.random(#self.SporeExplodeSounds)], 511)
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:CreateVinesIn()
	if !IsValid(self) then return end
	
	local vines = ents.Create("nz_ent_fx_thrasher_vines")
	vines:SetPos(self:GetPos())
	vines:SetAngles(self:GetAngles())

	vines:Spawn()

	vines:VinesIn() 
end

function ENT:CreateVinesOut()

	local vines = ents.Create("nz_ent_fx_thrasher_vines")
	vines:SetPos(self:GetPos())
	vines:SetAngles(self:GetAngles())

	vines:Spawn()
	
	vines:VinesOut()
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "step_right_small" or e == "step_left_small" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)], 80, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_thrasher/fall_swt/fall_swt_0"..math.random(0,6)..".mp3", 80)
		util.ScreenShake(self:GetPos(),1,1,0.2,450)
	end
	if e == "step_right_large" or e == "step_left_large" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)], 80, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_thrasher/fall_swt/fall_swt_0"..math.random(0,6)..".mp3", 80)
		util.ScreenShake(self:GetPos(),1,1,0.2,450)
	end
	if e == "thrasher_fall" then
		self:EmitSound("nz_moo/zombies/vox/_thrasher/fall/fall_0"..math.random(0,3)..".mp3", 90)
		self:EmitSound("nz_moo/zombies/vox/_thrasher/fall_swt/fall_swt_0"..math.random(0,6)..".mp3", 90)
	end
	if e == "thrasher_grab" then
		if math.random(100) == 69  or comedyday then
			self:EmitSound("Thrasher_roar_laby.wav",511)
		end
		self:EmitSound("nz_moo/zombies/vox/_thrasher/grab/grab_0"..math.random(0,3)..".mp3", 90)
	end
	if e == "thrasher_pain" then
		self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 80, math.random(95,105), 1, 2)
	end
	if e == "thrasher_eat" then
		self:EmitSound(self.BiteSounds[math.random(#self.BiteSounds)], 80, math.random(95,105))
		ParticleEffectAttach("bo3_thrasher_blood", 4, self, 8)
	end
	if e == "thrasher_emerge" then
		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)

		self:EmitSound("nz_moo/zombies/vox/_thrasher/teleport_in/tele_hand_up.mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_0"..math.random(5)..".mp3",511)
		for i=1,1 do
			ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(i*2),20,0)),Angle(0,0,0),nil)
		end
	end
	if e == "thrasher_burrow" then
		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)

		self:EmitSound("nz_moo/zombies/vox/_thrasher/teleport_in/tele_hand_up.mp3", 100, math.random(95,105))
		self:EmitSound("enemies/bosses/thrasher/teleport_in_01.ogg",511)
		self:EmitSound("enemies/bosses/thrasher/dst_rock_quake_0"..math.random(1,5)..".ogg",511)
		for i=1,1 do
			ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(i*2),20,0)),Angle(0,0,0),nil)
		end
	end
	if e == "thrasher_explode" then
		if IsValid(self) then

			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			self:Remove()
		end
	end
end

function ENT:OnRemove()
	if IsValid(self:GetCurrentPlayer()) then
		local ply = self:GetCurrentPlayer()
		ply:SetParent(nil)
		ply:SetNoDraw(false)
		ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	end
end
