AddCSLuaFile()

hook.Add( "EntityTakeDamage", "CloverfieldEXECUTION", function( target, dmginfo )
	
	if ( target:IsPlayer()) then
	local attacker = (dmginfo:GetAttacker()):GetClass()
	--local entName = ent:GetClass()
	if  string.StartsWith( attacker, "nz_zombie_special_cloverfield" ) and target:Health()<40   then
	--PrintMessage(HUD_PRINTTALK, "THIS BORING MOTHER FUCKER -->"..activator:Nick().."<-- JUST DEACTIVATED THE MALDOMETER AND GOT SENT TO THE CUM ZONE")
	net.Start("nzPowerUps.PickupHud")
			net.WriteString(target:Nick().." is going to fucking explode, goodbye nigga")
			net.WriteBool(true)
		net.Broadcast()
	timer.Create( "CLOVERFIELDPARASITE_KILL", 5, 1, function() 
	print( "bye nigga" ) 
	if IsValid(target) then
	ParticleEffect("bo3_margwa_death",target:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		target:EmitSound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		target:EmitSound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3", 100)
		target:EmitSound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_07.mp3", 100)
		ParticleEffect("nbnz_gib_explosion",target:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
				ParticleEffect("baby_dead",target:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
				for k, v in pairs(ents.FindInSphere(target:GetPos(), 200)) do
            	if v:IsPlayer() then
					if v == target then continue end
                	if v:Health() <= 0 then continue end
                	local expdamage = DamageInfo()
					local damage = target:HasPerk("danger") and 100 or 50
                	expdamage:SetAttacker(attacker)
                	expdamage:SetInflictor(attacker)
                	expdamage:SetDamageType(DMG_BLAST)
                	local distfac = target:GetPos():Distance(v:WorldSpaceCenter())
                	distfac = 1 - math.Clamp((distfac/200), 0, 1)
                	expdamage:SetDamage(damage * distfac)
                	expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - target:GetPos()):GetNormalized() * 10000)
                	v:TakeDamageInfo(expdamage)
            	end
        	end
	target:Kill()
	target:Kill()
	end
	end )
		dmginfo:ScaleDamage( 0 ) 
		end
	end
end )




ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Cloverfield Parasite"
ENT.Category = "Brainz"
ENT.Author = "Laby"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true

ENT.Models = {
	{Model = "models/enemies/zombies/cloverfield.mdl", Skin = 0, Bodygroups = {0,0}},
}


ENT.AttackRange = 80

ENT.DamageRange = 80

ENT.AttackDamage = 40

ENT.JumpAttackDamage = 45

ENT.JumpDamageRange = 80

ENT.IdleSequence = "idle"


local SpawnSequences = {"climbdismount"}

ENT.BarricadeTearSequences = {
	"melee",
}

local AttackSequences = {
	{seq = "BR2_Attack"},
}

local JumpSequences = {
	{seq = "climbdismount"},
}

local walksounds = {
	Sound("enemies/zombies/cloverfield/walk1.wav"),
	Sound("enemies/zombies/cloverfield/walk2.wav"),
	Sound("enemies/zombies/cloverfield/walk3.wav"),
	Sound("enemies/zombies/cloverfield/walk4.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"walk_all",
			},
			AttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/crawler/voicedeath/death1.wav",
	"wavy_zombie/crawler/voicedeath/death2.wav",
	"wavy_zombie/crawler/voicedeath/death3.wav",
	"wavy_zombie/crawler/voicedeath/death4.wav",
	"wavy_zombie/crawler/voicedeath/death5.wav",
	"wavy_zombie/crawler/voicedeath/death6.wav",
	"wavy_zombie/crawler/voicedeath/death7.wav",
	"wavy_zombie/crawler/voicedeath/death8.wav",
}

ENT.AttackSounds = {
	"enemies/zombies/cloverfield/attack1.wav",
	"enemies/zombies/cloverfield/attack2.wav",
	"enemies/zombies/cloverfield/attack3.wav",
	"enemies/zombies/cloverfield/attack4.wav",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/husk/tile1.wav",
	"wavy_zombie/husk/tile2.wav",
	"wavy_zombie/husk/tile3.wav",
	"wavy_zombie/husk/tile4.wav",
	"wavy_zombie/husk/tile5.wav",
	"wavy_zombie/husk/tile6.wav",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/husk/tile1.wav",
	"wavy_zombie/husk/tile2.wav",
	"wavy_zombie/husk/tile3.wav",
	"wavy_zombie/husk/tile4.wav",
	"wavy_zombie/husk/tile5.wav",
	"wavy_zombie/husk/tile6.wav",
}
ENT.CustomAttackImpactSounds = {
	"enemies/zombies/cloverfield/chomp1.wav",
	"enemies/zombies/cloverfield/chomp2.wav",
}

ENT.BehindSoundDistance = 1 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(100)
		else
			self:SetHealth( nzRound:GetZombieHealth() )
		end
		
		self:SetCollisionBounds(Vector(-20,-20, 0), Vector(20, 20, 70))
		self:SetRunSpeed(36)
		
		self.JumpCooldown = CurTime() + 2
		self.CanJump = false
		self.Jumping = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:CollideWhenPossible()

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)
end


function ENT:PerformDeath(dmginfo)
	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
	self:BecomeRagdoll(dmginfo)
end



function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step"  then
		if self.CustomWalkFootstepsSounds then
			--self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 70)
		else
			--self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "melee" then
		if self.AttackSounds then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 105), 1, 2)
		end
		local target = self:GetTarget()
		if target:Health() < 40 then
		self:DoAttackDamage()
		self:FleeTarget(5)
		else
		self:DoAttackDamage()
		end
	end
	if e == "jump_attack" then
		self:DoJumpAttackDamage()
	end
end
