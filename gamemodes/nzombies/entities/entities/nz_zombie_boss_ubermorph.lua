AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "im fucking invincible"
ENT.Category = "Brainz"
ENT.Author = "Laby and GhostlyMoo"

--I'm like a creepy old man except I have a rocket launcher

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackDamage = 55
ENT.AttackRange = 100
ENT.DamageRange = 100


ENT.Models = {
	{Model = "models/bosses/zombie_hunter_ubermorph.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"ready"}

ENT.DeathSequences = {

}

local AttackSequences = {
	{seq = "attack"},
	{seq = "attack2"},
	{seq = "attack3"}
}

local CrawlingAttackSequence = {
	{seq = "attack4"}
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}



local walksounds = {
Sound("enemies/bosses/ubr/idle/hunter_merge_00.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_01.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_02.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_03.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_04.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_05.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_06.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_07.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_08.ogg"),
Sound("enemies/bosses/ubr/idle/hunter_merge_09.ogg")
}

ENT.AttackSounds = {
	"enemies/bosses/ubr/attack/ubermorph_090.ogg",
	"enemies/bosses/ubr/attack/ubermorph_091.ogg",
	"enemies/bosses/ubr/attack/ubermorph_092.ogg",
	"enemies/bosses/ubr/attack/ubermorph_093.ogg",
	"enemies/bosses/ubr/attack/ubermorph_094.ogg",
	"enemies/bosses/ubr/attack/ubermorph_095.ogg",
	"enemies/bosses/ubr/attack/ubermorph_096.ogg",
	"enemies/bosses/ubr/attack/ubermorph_097.ogg",
}

ENT.PainSounds = {
	"nz/zombies/death/nz_flesh_impact_1.wav",
	"nz/zombies/death/nz_flesh_impact_2.wav",
	"nz/zombies/death/nz_flesh_impact_3.wav",
	"nz/zombies/death/nz_flesh_impact_4.wav"
}

ENT.DeathSounds = {
	"enemies/bosses/nemesis/madge.ogg"
}

ENT.IdleSequence = "idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"crawl"
			},
			AttackSequences = {CrawlingAttackSequence},
			PassiveSounds = {walksounds},
		},
	}},
		{Threshold = 70, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"walk"
			},
			AttackSequences = {AttackSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

function ENT:StatsInitialize()
	if SERVER then
		local data = nzRound:GetBossData(self.NZBossType)
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			self:SetHealth(nzRound:GetNumber() * data.scale + (data.health * count))
			self:SetMaxHealth(nzRound:GetNumber() * data.scale + (data.health * count))
		end
		baseHealth = 0
		self.Crawling = false
		self.NextAction = 0
		self.NextHealTime = 0
		self:SetMooSpecial(true)
		self:SetRunSpeed( 90 )
		self.loco:SetDesiredSpeed( 90 )
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 90))
	end
end

function ENT:OnSpawn()

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	ParticleEffect("brute_jumped",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		self:EmitSound("enemies/bosses/ubr/alret/hunter_merge_3"..math.random(4,7)..".ogg")
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	self:SetBodygroup( 4,0)
	self:SetBodygroup(5,0 )
	self:SetBodygroup( 3,0)
	self:SetBodygroup(2,0 )
	self:SetBodygroup( 0,0)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
		baseHealth = self:Health()
	end
end

function ENT:PerformDeath(dmgInfo)
		if IsValid(self) then
		self:EmitSound("enemies/bosses/ubr/dead/ubermorph_10"..math.random(1,2)..".wav")
			ParticleEffect("baby_dead",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			self:Remove()
		end

end

function ENT:OnInjured( dmgInfo )
			if dmgInfo:IsDamageType( 2097152 )  then
				dmgInfo:ScaleDamage( 3 )
			end
			
			if  self:Health() < (baseHealth / 3) and self.Crawling == false then
			self:SetInvulnerable(true)
				self:SetSpecialAnimation(true)
				self:SetBlockAttack(true)
				self:DoSpecialAnimation("change")
				self:SetBodygroup( 4,1)
				self:SetBodygroup(5,1 )
				self.loco:SetDesiredSpeed(50)
					self:SetRunSpeed(50)
					self:SpeedChanged()
					self.NextHealTime = CurTime() + 50
					self.Crawling = true
					self:SetBlockAttack(false)
					
			end
end


function ENT:OnPathTimeOut()
	if CurTime() < self.NextHealTime then return end
	if self.NextHealTime < CurTime() and self.Crawling == true then
	if IsValid(self) then
					
				self:SetInvulnerable(true)
				self:SetSpecialAnimation(true)
				self:SetBlockAttack(true)
				self:DoSpecialAnimation("health2")
				self:SetBodygroup(4,0)
				self:SetBodygroup(5,0)
				self:SetHealth(baseHealth * 1.25)
				self.loco:SetDesiredSpeed(90)
				self:SetRunSpeed(90)
				self:SpeedChanged()
				self:SetInvulnerable(false)
				self:SetSpecialAnimation(false)
				self:SetBlockAttack(false)
				self.Crawling = false
					end
					end
end

function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "Hit" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "Step" then
		self:EmitSound("enemies/bosses/divider/footstep/divider_body_footstep-0"..math.random(1,9)..".ogg",80,math.random(95,100))
	end
	if e == "Gore" then
		ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		self:PlaySound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
				ParticleEffect("divider_slash2",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
				ParticleEffect("divider_slash3",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
				ParticleEffect("baby_dead",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
	end 

end





-- A standard attack you can use it or create something fancy yourself

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid( ent ) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end