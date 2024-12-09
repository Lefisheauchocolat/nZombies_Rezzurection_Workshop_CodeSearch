AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "GET TO THA CHOPPA"
ENT.PrintName = "The Terminator"
ENT.Category = "Brainz"
ENT.Author = "Laby"

function ENT:InitDataTables()
	self:NetworkVar("Bool", 6, "IsIdle")
	self:NetworkVar("Bool", 7, "IsEnraged")
end

if CLIENT then 
	local eyeglow =  Material("nz/zlight")
	function ENT:Draw() //Runs every frame
		self:DrawModel()
		if self:Alive() then
			self:DrawEyeGlow()
		end



		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end



	function ENT:DrawEyeGlow()
		local eyeColor = Color(240,28,36)

		local latt = self:LookupAttachment("lefteye")
		

		if latt == nil then return end
		

		local leye = self:GetAttachment(latt)
		

		if leye == nil then return end
		


		local lefteyepos = leye.Pos + leye.Ang:Forward()*2

		if lefteyepos  then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 6, 6, eyeColor)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 80

ENT.TraversalCheckRange = 40

ENT.Models = {
	{Model = "models/bosses/nzr_arnold.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_firestaff_death_collapse_a",
	"nz_firestaff_death_collapse_a",
	"nz_death_1",
}

ENT.SuperTauntSequences = {
	"nz_legacy_taunt_v11",
	"nz_legacy_taunt_v11",
}

ENT.StepSounds = {
	Sound("nz_moo/zombies/vox/_mechz/step/anim_decepticon_lg_run_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/step/anim_decepticon_lg_run_02.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/step/anim_decepticon_lg_run_03.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/step/anim_decepticon_lg_run_04.mp3"),
}

ENT.ServoSounds = {
	Sound("nz_moo/zombies/vox/_mechz/servo/anim_ratc_srvo_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/servo/anim_ratc_srvo_02.mp3"),
}

ENT.MetalImpactSounds = {
	Sound("physics/metal/metal_solid_impact_bullet1.wav"),
	Sound("physics/metal/metal_solid_impact_bullet2.wav"),
	Sound("physics/metal/metal_solid_impact_bullet3.wav"),
	Sound("physics/metal/metal_solid_impact_bullet4.wav"),
}

local AttackSequences = {
	{seq = "nz_walk_ad_attack_v8"},
	{seq = "nz_walk_ad_attack_v9"},
	{seq = "nz_legacy_attack_v3"},
	{seq = "nz_base_zombie_cellbreaker_attack_02"},
	{seq = "nz_base_zombie_cellbreaker_attack_03"},
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				--"nz_gm_run",
				"nz_base_zombie_boss_run_01",
				--"nz_base_zombie_cellbreaker_walk_01", endo
				--"nz_l4d_walk",
				
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_base_zombie_boss_run_01",
				"nz_base_zombie_boss_sprint_01",
				"nz_base_zombie_cellbreaker_run_03",
				"nz_base_zombie_cellbreaker_run_04",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/mute_00.wav"
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 500 + (97500 * count), 97500, 500000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 500 + (97500 * count), 97500, 500000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end
		self.heldperks = 0
		self.bonezone = false
		self.perklimit=4
		self.sticky = false
		self.liposafe = false
		self.flakjacket = false
		self.painkiller = false
		self.rob = false
		self:SetRunSpeed(69)
		self:SetTargetCheckRange(60000) -- I can smell you
		self.Damaged = false
		self.spawnHealth = self:GetMaxHealth()
		self:SetIsIdle(true)
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:SetBodygroup(0,0)
	self:SetBodygroup(1,0)
	self:SetBodygroup(2,0)
	self:SetBodygroup(3,0)
	self:SetBodygroup(4,0)
	self:SetBodygroup(5,0)
	self:SetBodygroup(6,0)
	self:SetMaterial("invisible")
	self:SetInvulnerable(true)
	self:SetBlockAttack(true)
	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/pre_spawn.mp3",511,100)
	ParticleEffect("hound_summon",self:GetPos(),self:GetAngles(),nil)
	ParticleEffect("panzer_spawn_tp",self:GetPos(),self:GetAngles(),nil)
	--ParticleEffect("fx_hellhound_summon",self:GetPos(),self:GetAngles(),nil)

	self:TimeOut(0.85)
	
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/strikes_00.mp3",511,100)

	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/spn_flux_l.mp3",100,100)
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/spn_flux_r.mp3",100,100)

	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	--self:EmitSound(self.IdleAmbience, 70, math.random(95, 105), 1, 3)
	self:SetMaterial("")
	self:SetInvulnerable(nil)
	self:SetBlockAttack(false)
	self:CollideWhenPossible()
	--self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 511, math.random(85, 105), 1, 2)
	self.spawnHealth = self:Health()
	self:SetRunSpeed( 36 )
	self.loco:SetDesiredSpeed( 36 )
end

function ENT:PerformDeath(dmginfo)
		
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
	self:Explode(25)
		ParticleEffectAttach("bo3_explosion_micro", PATTACH_POINT_FOLLOW, self, 9)
	if self.bonezone then
		self.fuckyouimnotdead = ents.Create("nz_zombie_boss_arnold_boney")
		self.fuckyouimnotdead:SetPos(self:GetPos())
		self.fuckyouimnotdead:Spawn()
	self:Remove()
	else
	self:Remove()
	end
	


end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_hilter/the_chase_1.wav")
	self:StopSound("nz_moo/zombies/vox/_hilter/the_chase_2.wav")
	self:StopSound("nz_moo/zombies/vox/_hilter/adolf_hitler_loop.wav")
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	
	if dmginfo:IsDamageType(DMG_BLAST) then
	dmginfo:ScaleDamage(self.flakjacket and 0.01 or 1.2)
	return end
	
	
	if dmginfo:IsDamageType(DMG_BURN) and self.LipoSafe then
		dmginfo:ScaleDamage(self.LipoSafe and 0.01 or 1.2)
	return end
	
	
	if  self.painkiller then
	if not dmginfo:IsDamageType(DMG_BULLET) and not dmginfo:IsDamageType(DMG_CRUSH)  and not dmginfo:IsDamageType(DMG_SLASH) then
	dmginfo:ScaleDamage(0.01)
	return end
	end
		

	if dmginfo:IsDamageType(DMG_BULLET) then
	dmginfo:ScaleDamage(0.2)
	end
	
	if self:Health() < (self.spawnHealth/2) and not self.Damaged  then
	self:SetBodygroup(0,1)
	self:SetBodygroup(1,1)
	self:SetBodygroup(2,1)
	self:SetBodygroup(3,1)
	self:SetBodygroup(4,1)
	self:SetBodygroup(5,1)
	self:ResetMovementSequence()
	end
end

function ENT:StealPerk()
self.heldperks = self.heldperks + 1
local target = self:GetTarget()
if self.sticky then
--target:NZSonicBlind(1)
end
if target:GetPerks() then
			perks = target:GetPerks()
			if not table.IsEmpty(perks) then
				perkLost = perks[math.random(#perks)]
				target:RemovePerk(perkLost, true)
				print(perkLost)
				if perkLost == "jugg" then
				self:SetHealth( self.spawnHealth )
				end
				if perkLost == "revive" or perkLost == "tombstone" or perkLost == "whoswho" then
				self.bonezone = true 
				--sets self to spawn as metal man when killed
				end
				if perkLost == "dtap" or perkLost =="dtap2" or perkLost == "vigor" then
				ENT.AttackDamage = 80
				end
				if perkLost == "speed" or perkLost =="time" then
				self.CanCancelAttack = true 
				end
				if perkLost == "mulekick" or perkLost == "gin" then
				self.perklimit = self.perklimit +3
				end
				if perkLost == "staminup" then
				self:SetRunSpeed( 250 )
				self.loco:SetDesiredSpeed( 250 )
				self:SpeedChanged()
				end
				if perkLost == "winters" or perkLost == "widows" then
				self.sticky = true
				end
				if perkLost == "fire" or perkLost == "everclear" then
				self.LipoSafe = true
				end
				if perkLost == "phd" or perkLost == "danger" or perkLost == "mask" then
				self.FlakJacket = true
				end
				if perkLost == "vulture" or perkLost == "vt" or perkLost == "pop" or perkLost == "random" then
				self.painkiller = true
				end
				if perkLost == "deadshot" or perkLost == "sake" or perkLost == "death" then
				self.rob = true
				end
				if perkLost == "amish"then
				self:SetBodygroup(6,1)
				end
				--PERK STEALING SYSTEM
				--cherry: Causes arnold to be immune to electricity
			end
		end
end


function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_left_small" or e == "step_left_large" then
	self:EmitSound(self.StepSounds[math.random(#self.StepSounds)], 80, math.random(95, 100))
		self:EmitSound(self.ServoSounds[math.random(#self.ServoSounds)], 70, math.random(95, 100))
	end
	if e == "step_right_small" or e == "step_right_large" then
	self:EmitSound(self.StepSounds[math.random(#self.StepSounds)], 80, math.random(95, 100))
		self:EmitSound(self.ServoSounds[math.random(#self.ServoSounds)], 70, math.random(95, 100))
	end
	if e == "melee_whoosh" then
	self:EmitSound(self.ServoSounds[math.random(#self.ServoSounds)], 80)
	end
	if e == "melee" or e == "melee_heavy" then
			if self.AttackSounds then
				self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			end
		self:DoAttackDamage()
		if self.rob then
		self:DoAttackDamage()
		end
		if math.random(0,5) > 3 and self.heldperks < self.perklimit then 
		self:StealPerk()
		end
	end


	if e == "pull_plank" then
		if IsValid(self) and self:Alive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
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
	if e == "remove_zombie" then
		self:Remove()
	end

end