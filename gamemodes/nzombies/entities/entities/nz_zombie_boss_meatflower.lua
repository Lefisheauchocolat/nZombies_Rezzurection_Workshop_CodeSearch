AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Panzermordar"
ENT.Category = "Brainz"
ENT.Author = "Laby and GhostlyMoo"

--Satan's Gloryhole

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.DamageRange = 250
ENT.AttackDamage = 65
ENT.AttackRange = 245

ENT.TraversalCheckRange = 80


ENT.Models = {
	{Model = "models/bosses/meatflower.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"s2_zom_brt_stun_up_v1"}

ENT.DeathSequences = {
	"reference"
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}


local AttackSequencesWALK = {
	{seq = "s2_zom_brt_walk_attack_v2"},
	{seq = "s2_zom_brt_walk_attack_ground_v2"},
	{seq = "s2_zom_brt_walk_attack_v1"}
}

local AttackSequencesRUN = {
	{seq = "s2_zom_brt_run_attack_v1"}
}

local JumpSequences = {
	{seq = "s2_zom_brt_walk_trav_exit_v1"}
}
	
local walksounds = {
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_walk_trav_exit_v1_01.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_walk_trav_exit_v1_02.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_walk_trav_exit_v1_03.ogg"),

}

local runsounds = {
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_run_01.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_run_02.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_run_03.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_run_04.ogg"),
	Sound("enemies/bosses/panzermorder/vox/s2_zom_brt_run_05.ogg"),

}

ENT.AttackSounds = {
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v1_01.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v1_02.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v1_03.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v2_01.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v2_02.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_walk_attack_v2_03.ogg"
}

ENT.AttackSoundsMAD = {
	"enemies/bosses/panzermorder/vox/s2_zom_brt_run_attack_v1_01.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_run_attack_v1_02.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_run_attack_v1_03.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_run_attack_v1_04.ogg",
	"enemies/bosses/panzermorder/vox/s2_zom_brt_run_attack_v1_05.ogg"
}

ENT.PainSounds = {
	"nz/zombies/death/nz_flesh_impact_1.wav",
	"nz/zombies/death/nz_flesh_impact_2.wav",
	"nz/zombies/death/nz_flesh_impact_3.wav",
	"nz/zombies/death/nz_flesh_impact_4.wav"
}

ENT.DeathSounds = {
	"enemies/bosses/brute/brut_vx_death_01_nr_00.ogg"
}

ENT.IdleSequence = "idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"s2_zom_brt_walk"
			},
			AttackSequences = {AttackSequencesWALK},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 100, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"s2_zom_brt_run"
			},
			AttackSequences = {AttackSequencesRUN},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
}

function ENT:StatsInitialize()
    if SERVER then
        local data = nzRound:GetBossData(self.NZBossType)
        local count = #player.GetAllPlaying()
        if nzRound:InState( ROUND_CREATE ) then
            self:SetHealth(500)
            self:SetMaxHealth(500)
        else
            self:SetHealth(nzRound:GetNumber() * data.scale + (data.health * count))
            self:SetMaxHealth(nzRound:GetNumber() * data.scale + (data.health * count))
        end
        self.racismblocker = false
        self.down=false
        self.revives = 3
        self.NextAction = 0
        self:SetMooSpecial(true)
        self:SetRunSpeed( 55 )
        self.loco:SetDesiredSpeed( 55 )
		self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
        self:SetSurroundingBounds(Vector(-50,-50, 0), Vector(50, 50, 250))
    end
end
function ENT:OnSpawn()

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetNoDraw(false)
		ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(1),20,0)),Angle(0,0,0),nil)
		
		util.ScreenShake(self:GetPos(),5,1000,1.2,2048)
	
		self:EmitSound("enemies/bosses/thrasher/tele_hand_up.ogg",511)
	self:SetSpecialAnimation(true)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
		self.revives = 3
	end
end
				
function ENT:OnInjured( dmgInfo )
		if self.down then
		dmgInfo:ScaleDamage(0)
		if dmgInfo:IsDamageType(DMG_SHOCK) then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if not self.racismblocker then
		self.revives = self.revives-1
		self.racismblocker = true
		end
		print(self.revives)
		end
		end
		if dmgInfo:GetDamage() > self:Health() and not self.down then
		self.down = true
		dmgInfo:ScaleDamage(0)
		self:SetInvulnerable(true)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/re2/em7100/down.ogg", 94, math.random(90,100))
		self:DoSpecialAnimation("s2_zom_brt_stun_up_v1")
		self:DoSpecialAnimation("s2_zom_brt_stun_loop_v1")
		self:DoSpecialAnimation("s2_zom_brt_stun_down_v1")
		 self:SetHealth(self:GetMaxHealth())
		self.down = true
		if self.revives < 1 and self.down then 
		self:PerformDeath()
		else
		--self:SetInvulnerable(false)
		if self.revives < 2 then
		self:SetRunSpeed(230)
				self.loco:SetDesiredSpeed(230)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
		end
		end
		end
end

function ENT:PerformDeath(dmgInfo)
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:PlaySound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
			ParticleEffect("baby_dead",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			nzPowerUps:SpawnPowerUp(self:GetPos(), "bottle")
			self:Remove()
		end
end


function ENT:OnPathTimeOut()
	local target = self:GetTarget()
	local actionchance = math.random(10)
	local comedyday = os.date("%d-%m") == "01-04"
	
		
	if  actionchance == 1 and CurTime() > self.NextAction then
		-- angry meatflower noises
		--self:EmitSound("enemies/bosses/panzermorder/vox/s2_zom_brt_roar_0"..math.random(1,5)..".ogg",511)
		self:EmitSound("enemies/bosses/panzermorder/vox/s2_zom_brt_roar_0"..math.random(1,5)..".ogg",511)
		self:DoSpecialAnimation("s2_zom_brt_roar")
		self.NextAction = CurTime() + math.random(20)
		end
	end




function ENT:HandleAnimEvent(a,b,c,d,e)
	
	if e == "ps s2_zom_brt_stun_up_v1" then
		self.down = false
		self.racismblocker = false
		self:SetInvulnerable(false)
	end
	
	if e == "ps s2_zom_brt_roar" then
		
		--ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),3,1000,0.5,2048)
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
			if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) and !v:IsNextBot() then
				v:NZSonicBlind(3)
				v:TakeDamage( 25, self,self )
			end
		end
	--	if self.revives < 2 then
		--		self:SetRunSpeed(230)
		--		self.loco:SetDesiredSpeed(230)
		--		self:SpeedChanged() -- Updates current anim to be a sprinting one.
			--	end
	end
	
	if e == "footstep_walk_right_brute" then
		self:EmitSound("enemies/bosses/panzermorder/zmb_fs_run_brute_default2_0"..math.random(1,9)..".ogg")
util.ScreenShake(self:GetPos(),3,1000,0.5,2048)
	end
	
	if e == "attack" then
		
		self:DoAttackDamage()
	end
	if e == "footstep_walk_right_brute" then
		self:EmitSound("enemies/bosses/panzermorder/zmb_fs_run_brute_default2_0"..math.random(1,9)..".ogg")
util.ScreenShake(self:GetPos(),3,1000,0.5,2048)
	end
	if e == "footstep_walk_left_brute" then
		self:EmitSound("enemies/bosses/panzermorder/zmb_fs_run_brute_default2_0"..math.random(1,9)..".ogg")
util.ScreenShake(self:GetPos(),3,1000,0.5,2048)
		
	end
	if e == "fx_vfx zmb_brute_slam" then
	--self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		--self:EmitSound("enemies/bosses/re2/em7100/slam"..math.random(1,2)..".ogg", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		local clawpos = self:GetBonePosition(self:LookupBone("j_wrist_ri"))
		ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(1),20,0)),Angle(0,0,0),nil)
		ParticleEffect("bo3_margwa_slam",clawpos,self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
				for k, v in pairs(ents.FindInSphere(self:GetPos(), 350)) do
            	if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
                	if v:GetClass() == self:GetClass() then continue end
                	if v == self then continue end
                	if v:EntIndex() == self:EntIndex() then continue end
                	if v:Health() <= 0 then continue end
                	--if !v:Alive() then continue end
                	local expdamage = DamageInfo()
                	expdamage:SetAttacker(self)
                	expdamage:SetInflictor(self)
                	expdamage:SetDamageType(DMG_CRUSH)
                	expdamage:SetDamage(75)
                	expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
                	v:TakeDamageInfo(expdamage)
					--v:NZSonicBlind(1)
            	end
        	end
	end

if e == "bodyfall_large" then
	--self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		--self:EmitSound("enemies/bosses/re2/em7100/slam"..math.random(1,2)..".ogg", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(1),20,0)),Angle(0,0,0),nil)
		ParticleEffect("bo3_margwa_slam",self:GetPos(),self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
	end
end

-- A standard attack you can use it or create something fancy yourself
	function ENT:Attack( data )

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
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
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
	end



function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end
