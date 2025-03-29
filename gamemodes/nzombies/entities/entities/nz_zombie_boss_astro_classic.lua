AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Astronaut(Assdonut) or THE CYCLOPS: Classic Edition"
ENT.PrintName = ""
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("String", 1, "AstroName")
end

if CLIENT then 


	function ENT:Draw3DText( pos, ang, scale, text, flipView )
		local astro_color = Color(255, 0, 0, 255)
		if ( flipView ) then
			ang:RotateAroundAxis( vector_up, 180 )
		end

		cam.Start3D2D(pos, ang, scale)
			cam.IgnoreZ(true)
			draw.DrawText(tostring(text), nzombies and "nz.small."..GetFontType(nzMapping.Settings.smallfont) or "ChatFont", 0, 0, astro_color, TEXT_ALIGN_CENTER)
			cam.IgnoreZ(false)
		cam.End3D2D()
	end

	function ENT:PostDraw()
		self:EffectsAndSounds()

		local text = self:GetAstroName()

		local pos = self:GetPos() + self:GetUp()*79
		local ang = LocalPlayer():EyeAngles()
		ang = Angle(ang.x, ang.y, 0)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Forward(), 90)

		self:Draw3DText( pos, ang, 0.2, text, false )
		self:Draw3DText( pos, ang, 0.2, text, true )
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then
				self.Draw_FX = "nz_moo/zombies/vox/_astro/breath.wav"

				self:EmitSound(self.Draw_FX, 75, math.random(95, 105), 1, 3)
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
ENT.IsMooBossZombie = true

ENT.AttackRange = 72

ENT.TraversalCheckRange = 40

ENT.Models = {
	{Model = "models/moo/_codz_ports/t5/moon/moo_codz_t5_moon_assdonut.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_astro/amb_vox/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_astro/amb_vox/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_astro/amb_vox/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_astro/amb_vox/amb_03.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_astro_walk_v1",
				"nz_astro_walk_v2",
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
				"nz_supersprint_lowg",
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
	}}
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/mute_00.wav"
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

ENT.AstronautNames = {
	"Astronaut","AssDonut","The Imposter","Wavy","GhostlyMoo","Owlie","Laby","Latte","FlamingFox","Glongo",
	"KILLA_GLISCORPION75","iServerOutVibes","Lester","Mello","Gabe Newell","Jeff Kaplan","TheNumberOneFan",
	"Slogo_Marmite","John F. Kennedy","DeaJay98","A Friend!","Cosmonaut","Spaceman","Scuba Steve","Cyclops",
	"Jack S.","Mike Hunt","Ben Dover","A Foe!","Mouth Breather","Yanoss","Tim Hansen","Noah J.","The One.",
	":)",":D",">:(","Tired Bread","Black Ops 1 Guy","Owl Boy","Licky Lee","Dioxazine","SimplySerdna22","SimplyAwesome22",
	"Renaissance Man","Ahmed_K","Doodoocacaballsdick","nZombies 3","The Thing","Average CoD Player","FatManGangster",
	"AwesomePieMan","Ege115","RedSpace200","StevieWonder08","FearXReaper666","FlamingFox5","Ghostlycreep434","HarryDivorceCount21",
	"JBird632","APlatypus","Bloxotrot","shippuden1592","25 Cent","tom_bmx","HitmanVere","MakeCents","ZK","Anthony","GooB","ZCTxCHAOSx",
	"Ping998","MJPWGaming","MidgetBlaster","Michelle Raymond","RichGaming","Zet0r","Alig96","E-Girl","Dan's Red Corvette","#1 Die Rise Hater",
	"Saving Private Racist","DiedRise","LoonicityHOUND","Hidden","TheDoorMatt655","Ruko","Filth","Sergeant Four Twenty","OceanFruit","Lolle",
	"Chtidino","S.Cawthon","T.Fox","Owilliam","Bring on the BBQ!","GEX","Gordon Freeman","Doctor HAX","DasBoSchitt","kitty0706","ThatBluntoBoi",
	"Malevolent Backshots","Noah Gay","TheRelaxingEnd","JIMBOTHY","Cruppz","PenileExploder44","Magnussy","Octogonal Robber","Megumongoloid",
	"Fucker","J.Zielinski","J.Blundell","robothegod","Homer Simpson","Peter Griffin","Prick","DathiDNogla","BEEEEEAAAANSS!!!","Jerry","Ziggy","Duke","fortnitelover92",
	"Garry Newman","Rubat","Rubutt","hickok45","Brandon Herrera","FPSRussia","Ahoy","LayzuhCatz","Leyerr","Otzdarva","Stanley557","Soap_Legends",
	"Timothy","Wallace","Dimitrius","Sullivan","I_ARE_WELDKAT","Baiwar72","KelpoGaming","Spencer","JoseRicoTacoNachoQuesadillaMandillaJones","WELDCAT",
	"CloysterXploder","Jerma985","Bazamalam","D.Vonderhaar","Peebody Yonce","Gleebop The Alien","ExcuseMe!","The Gripper","KnobGobbler69",
	"The Freaky Astronaut","The Freaky ASStronaut","The Secret Zombie","Toro","Glep","Pinkie Pie","N.Armstrong","Tony Soprano","Salvatore 'Big Pussy' Bonpensiero",
	"Rick","Morty","Doomfist","Akande Ogundimu","McCree","Cassidy","Winston","Dr.Winston","winton","ENT.AstronautNames","null","nil","null Jr.","Moe Syzlak","Lionel Hutz",
	"Kuro","Mario","Wario","McAfee","OJ Simpson","Saddam Hussein","ENA","The Two.","Dr.Pepper","House M.D.","Herobrine","Herobrin","King Tut",
	"Ra God of The Sun","Orenthal James Simpson","Rand Ridley","Mordecai","Rigby","Skips","Benson","Bo Narr","Wir Suchen Dich!","Flapjack",
	"Captain K'nuckles","mf doom","Eugene Krabs","John Bone","Red Skeleton","Gray Grayson","InkNoodleSoup","Dr.Kleiner","Morgan Friedman","Saltine Cracker",
	"MoistCr1TiKaL","Jonesey the First","NickEh30","Ronald Raygun","S.Gojo","E.Yeager","M.Ackerman","S.Geto",
	"Demonless1","KellDoStuff","The Professional","TheGraveKeeper","Timka Kidala","Simian Smasher","Spunchbop","Pumpkin Spice","Mauga Main",
	"MrStealYoPerks",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local hp = nzRound:GetZombieHealth()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(hp * 4 * count, 1000, 60000 * count))
				self:SetMaxHealth(math.Clamp(hp * 4 * count, 1000, 60000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self:SetRunSpeed(35)

		grabbing = false
		gobyebye = false
		trexarms = 0
		malding = false

		local name = "Astronaut"
		for k, v in RandomPairs(self.AstronautNames) do
			name = v
			break
		end
		self:SetAstroName(name)
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:EmitSound("nz_moo/zombies/vox/_astro/spawn_flux.mp3", 511, math.random(95, 105))
	ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,50)),Angle(0,0,0),nil)
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:StopSound("nz_moo/zombies/vox/_astro/breath.wav")
	self:Explode(0)
	self:Remove(dmgInfo)
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_astro/breath.wav")
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

if SERVER then
	function ENT:GetFleeDestination(target) -- Get the place where we are fleeing to, added by: Ethorbit
		return self:GetPos() + (self:GetPos() - target:GetPos()):GetNormalized() * (self.FleeDistance or 300)
	end
end

function ENT:Attack()
	--print("Give me your assets.")
	if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
		if malding then
			self:GetTarget():NZAstroSlow(3)
		else
			self:GetTarget():NZAstroSlow(2)
		end
	end

	self:PlaySequenceAndWait("nz_astro_headbutt", 1, self.FaceEnemy)
	if self:TargetInAttackRange() then
		local target = self:GetTarget()

		--print("You go to brazil now.")
		if IsValid(target) then
			self:EmitSound("weapons/tfa_bo3/gersch/gersh_teleport.wav",511)
			local d = DamageInfo()
			d:SetDamage( target:Health() - 90 )
			d:SetAttacker( self )
			d:SetDamageType( DMG_VEHICLE ) 
			target:TakeDamageInfo( d )
		end
		if self:GetTarget():IsPlayer() then
			self:GetTarget():ViewPunch( VectorRand():Angle() * 0.1 )
		end
		if malding then
			--print("He's no longer malding.")
			self:SetRunSpeed(35)
			self:SpeedChanged()
			malding = false
			trexarms = 0
		end
	else
		self:PlaySequenceAndWait("nz_astro_headbutt_release")
		trexarms = trexarms + 1
		if trexarms > 2 and not malding then -- If you somehow manage to make him mald unintentionally... You're bad at video games.
			print("Look what you've done Yoshi... You've angered the Scuba Diver.")
			--print("F L I N T L O C K W O O D ! ! !")
			self:SetRunSpeed(70)
			self:SpeedChanged()
			malding = true
		end
	end
end


function ENT:Explode(dmg, suicide)
    for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
        if not v:IsWorld() and v:IsSolid() then
            v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized()*175) + v:GetUp()*225)
            
            if v:IsValidZombie() then
                if v == self then continue end
                if v:EntIndex() == self:EntIndex() then continue end
                if v:Health() <= 0 then continue end
                if !v:IsAlive() then continue end
                local damage = DamageInfo()
                damage:SetAttacker(self)
                damage:SetDamageType(DMG_MISSILEDEFENSE)
                damage:SetDamage(v:Health() + 666)
                damage:SetDamageForce(v:GetUp()*22000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
                damage:SetDamagePosition(v:EyePos())
                v:TakeDamageInfo(damage)
            end

            if v:IsPlayer() then
            	v:SetGroundEntity(nil)
                v:ViewPunch(Angle(-25,math.random(-10, 10),0))
            end
        end
    end
	ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,50)),Angle(0,0,0),nil)
	self:EmitSound("nz_moo/zombies/vox/_astro/death/astro_pop.mp3", 511, math.random(95, 105))
	self:EmitSound("nz_moo/zombies/vox/_astro/death/astro_flux.mp3", 511, math.random(95, 105))
    if suicide then self:TakeDamage(self:Health() + 666, self, self) end
end

function ENT:ZombieStatusEffects()
	if CurTime() > self.LastStatusUpdate then
		if !self:IsAlive() then return end
		if self:GetSpecialAnimation() then return end

		if self.IsAATTurned and self:IsAATTurned() then
			self:TimeOut(0)
			self:SetSpecialShouldDie(true)
			self:PlaySound(self.AstroDanceSounds[math.random(#self.AstroDanceSounds)], 511)
			self:DoSpecialAnimation(self.DanceSequences[math.random(#self.DanceSequences)])
		end

		self.LastStatusUpdate = CurTime() + 0.25
	end
end

ENT.AstroDanceSounds = {
	Sound("nz_moo/effects/aats/turned/drip.mp3"),
}

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
		if IsValid(self) and self:IsAlive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
		end
	end

	if e == "astro_grab" then
		self:EmitSound("nz_moo/zombies/vox/_astro/grab/grab_0"..math.random(0,1)..".mp3", 100)
	end
	if e == "astro_swell" then
		self:EmitSound("nz_moo/zombies/vox/_astro/grab/static_swell.mp3", 100)
	end
end

