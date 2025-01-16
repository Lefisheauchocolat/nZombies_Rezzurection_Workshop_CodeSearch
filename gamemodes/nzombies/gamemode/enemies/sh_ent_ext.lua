TARGET_PRIORITY_NONE = 0
TARGET_PRIORITY_MONSTERINTERACT = 1
TARGET_PRIORITY_PLAYER = 2
TARGET_PRIORITY_SPECIAL = 3
TARGET_PRIORITY_MAX = 3
-- Someone could add a new priority level by doing this:
-- TARGET_PRIORITY_CUSTOM = TARGET_PRIORITY_MAX + 1
-- TARGET_PRIORITY_MAX = TARGET_PRIORITY_MAX + 1
-- would be limited to 7 custom levels before overwritting TARGET_PRIORITY_ALWAYS, which shoiuld be enough.
TARGET_PRIORITY_ALWAYS = 10 --make this entity a global target (not recommended)

--WARNING THIS IS ONLY PARTIALLY SHARED its not recommended to use it clientside.

local meta = FindMetaTable("Entity")

function meta:SetIsZombie(value)
	self.bIsZombie = value
end

function meta:SetIsActivatable(value)
	self.bIsActivatable = value
end

function meta:IsActivatable()
	return self.bIsActivatable or false
end

function meta:GetTargetPriority()
	return self.iTargetPriority or TARGET_PRIORITY_NONE
end

function meta:SetTargetPriority(value)
	if nzLevel and nzLevel.TargetCache then
		if value > 0 then
			if !table.HasValue(nzLevel.TargetCache, self) then
				table.insert(nzLevel.TargetCache, self)
			end
		else
			for i = 1, #nzLevel.TargetCache do
				if nzLevel.TargetCache[i] == self then
					table.remove(nzLevel.TargetCache, i)
					break
				end
			end
		end
	end

	self.iTargetPriority = value
end

function meta:SetDefaultTargetPriority()
	if self:IsPlayer() then
		if self:GetNotDowned() and self:IsPlaying() then
			self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		else
			self:SetTargetPriority(TARGET_PRIORITY_NONE)
		end
	else
		self:SetTargetPriority(TARGET_PRIORITY_NONE) -- By default all entities are non-targetable
	end
end

if SERVER then
	function UpdateAllZombieTargets(target)
		if IsValid(target) then
			for k,v in pairs(ents.GetAll()) do
				if nzConfig.ValidEnemies[v:GetClass()] then
					v:SetTarget(target)
				end
			end
		end
	end

	function meta:ApplyWebFreeze(time)
		local block = false
		if self.Freeze then
			block = self:Freeze(time) -- Return true to not apply effect
		else
			self.loco:SetDesiredSpeed(0)
			timer.Simple(time, function()
				if IsValid(self) then
					self.WebAura = nil
					local speeds = nzRound:GetZombieSpeeds()
					if speeds then
						self.loco:SetDesiredSpeed( nzMisc.WeightedRandom(speeds) )
					else
						self.loco:SetDesiredSpeed( 100 )
					end
				end
			end)
		end

		if block then return end
		
		local e = EffectData()
		e:SetMagnitude(1.5)
		e:SetScale(time) -- The time the effect lasts
		e:SetEntity(self)
		util.Effect("web_aura", e)
		--self.WebAura = CurTime() + time
	end
end

local validenemies = {}
function nzEnemies:AddValidZombieType(class)
	validenemies[class] = true
end

function meta:IsValidZombie()
	return self.bIsZombie or validenemies[self:GetClass()] != nil
end

nzEnemies:AddValidZombieType("nz_zombie_special_hunterbeta")
nzEnemies:AddValidZombieType("nz_zombie_special_frog")

--nzEnemies:AddValidZombieType("nz_zombie_special_cosmo_monkey")
nzEnemies:AddValidZombieType("nz_zombie_special_l4d_hunter")
nzEnemies:AddValidZombieType("nz_zombie_special_l4d_smoker")

nzEnemies:AddValidZombieType("nz_zombie_special_alien_scout")
nzEnemies:AddValidZombieType("nz_zombie_special_alien_scorpion")
nzEnemies:AddValidZombieType("nz_zombie_special_alien_seeker")

nzEnemies:AddValidZombieType("nz_zombie_special_dog_zhd")
nzEnemies:AddValidZombieType("nz_zombie_special_dog_gas")
nzEnemies:AddValidZombieType("nz_zombie_special_dog_fire")
nzEnemies:AddValidZombieType("nz_zombie_special_dog_jup")
nzEnemies:AddValidZombieType("nz_zombie_special_dog_cyborg")

nzEnemies:AddValidZombieType("nz_zombie_special_goliathcodol")

nzEnemies:AddValidZombieType("nz_zombie_special_disciple")
nzEnemies:AddValidZombieType("nz_zombie_special_mimic")
nzEnemies:AddValidZombieType("nz_zombie_special_raz")
nzEnemies:AddValidZombieType("nz_zombie_special_raz_jup")
nzEnemies:AddValidZombieType("nz_zombie_special_raz_t10")

nzEnemies:AddValidZombieType("nz_zombie_special_grenade")
nzEnemies:AddValidZombieType("nz_zombie_special_terrorist")
nzEnemies:AddValidZombieType("nz_zombie_special_toxic_hazmat")
nzEnemies:AddValidZombieType("nz_zombie_special_toxic_hazmat_codol")
nzEnemies:AddValidZombieType("nz_zombie_special_toxic_hazmat_zhd")

nzEnemies:AddValidZombieType("nz_zombie_special_za_suicider")

nzEnemies:AddValidZombieType("nz_zombie_special_cloaker")

nzEnemies:AddValidZombieType("nz_zombie_special_ss_fire")

nzEnemies:AddValidZombieType("nz_zombie_special_husk")
nzEnemies:AddValidZombieType("nz_zombie_special_crawler")
nzEnemies:AddValidZombieType("nz_zombie_special_leaper")

nzEnemies:AddValidZombieType("nz_zombie_special_xeno_runner")
nzEnemies:AddValidZombieType("nz_zombie_special_xeno_spitter")
nzEnemies:AddValidZombieType("nz_zombie_special_xeno_brute")

nzEnemies:AddValidZombieType("nz_zombie_special_clown")
nzEnemies:AddValidZombieType("nz_zombie_special_fury")
nzEnemies:AddValidZombieType("nz_zombie_special_tempest")
nzEnemies:AddValidZombieType("nz_zombie_special_tormentor")

nzEnemies:AddValidZombieType("nz_zombie_special_catalyst_electric")
nzEnemies:AddValidZombieType("nz_zombie_special_catalyst_decay")
nzEnemies:AddValidZombieType("nz_zombie_special_catalyst_water")
nzEnemies:AddValidZombieType("nz_zombie_special_catalyst_plasma")

nzEnemies:AddValidZombieType("nz_zombie_walker_floodbrute")
nzEnemies:AddValidZombieType("nz_zombie_walker_floodunsc")
nzEnemies:AddValidZombieType("nz_zombie_walker_floodunsc3")
nzEnemies:AddValidZombieType("nz_zombie_walker_floodelite")
nzEnemies:AddValidZombieType("nz_zombie_walker_floodelite3")

nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_airport")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_military")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_hospital")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_riot")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu")

nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_c_ci")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_c_ci_hospital")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenflu_c_ci_airport")

nzEnemies:AddValidZombieType("nz_zombie_walker_blud")
nzEnemies:AddValidZombieType("nz_zombie_walker_anchovy")
nzEnemies:AddValidZombieType("nz_zombie_walker_fredricks")
nzEnemies:AddValidZombieType("nz_zombie_walker_fredricks_canon")
nzEnemies:AddValidZombieType("nz_zombie_walker_kleiner")
nzEnemies:AddValidZombieType("nz_zombie_walker_cheaple")
nzEnemies:AddValidZombieType("nz_zombie_walker_elf")
nzEnemies:AddValidZombieType("nz_zombie_walker_headcrab")
nzEnemies:AddValidZombieType("nz_zombie_walker_nut")

nzEnemies:AddValidZombieType("nz_zombie_walker_seal")
nzEnemies:AddValidZombieType("nz_zombie_walker_lmghost")

nzEnemies:AddValidZombieType("nz_zombie_walker_leviathan")
nzEnemies:AddValidZombieType("nz_zombie_walker_mannequin")

nzEnemies:AddValidZombieType("nz_zombie_walker_jup")
nzEnemies:AddValidZombieType("nz_zombie_walker_jup_charred")
nzEnemies:AddValidZombieType("nz_zombie_walker_jup_heavy")
nzEnemies:AddValidZombieType("nz_zombie_walker_ww2")
nzEnemies:AddValidZombieType("nz_zombie_walker_ww2_3arc")
nzEnemies:AddValidZombieType("nz_zombie_walker_griddy")
nzEnemies:AddValidZombieType("nz_zombie_walker_quartz_lab")
nzEnemies:AddValidZombieType("nz_zombie_walker_quartz_hazmat")

nzEnemies:AddValidZombieType("nz_zombie_walker_sentinel")
nzEnemies:AddValidZombieType("nz_zombie_walker_mansion")
nzEnemies:AddValidZombieType("nz_zombie_walker_titanic")
nzEnemies:AddValidZombieType("nz_zombie_walker_ix")
nzEnemies:AddValidZombieType("nz_zombie_walker_dierise")
nzEnemies:AddValidZombieType("nz_zombie_walker_prototype")
nzEnemies:AddValidZombieType("nz_zombie_walker_prototype_enhanced")
nzEnemies:AddValidZombieType("nz_zombie_walker_derriese")
nzEnemies:AddValidZombieType("nz_zombie_walker_derriese_enhanced")
nzEnemies:AddValidZombieType("nz_zombie_walker_derriese_wwii")
nzEnemies:AddValidZombieType("nz_zombie_walker_derriese_pro")
nzEnemies:AddValidZombieType("nz_zombie_walker_haus")
nzEnemies:AddValidZombieType("nz_zombie_walker_sumpf_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_ascension_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_classic_wii")
nzEnemies:AddValidZombieType("nz_zombie_walker_moon_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_moon_classic_guard")
nzEnemies:AddValidZombieType("nz_zombie_walker_five_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_orange")
nzEnemies:AddValidZombieType("nz_zombie_walker_diemachine")
nzEnemies:AddValidZombieType("nz_zombie_walker_gold")
nzEnemies:AddValidZombieType("nz_zombie_walker_armoredheavy")
nzEnemies:AddValidZombieType("nz_zombie_walker_park_cop")
nzEnemies:AddValidZombieType("nz_zombie_walker_park")
nzEnemies:AddValidZombieType("nz_zombie_walker_park_3arc")

nzEnemies:AddValidZombieType("nz_zombie_walker_poolday")
nzEnemies:AddValidZombieType("nz_zombie_walker_cyborg")

nzEnemies:AddValidZombieType("nz_zombie_walker")
nzEnemies:AddValidZombieType("nz_zombie_walker_buried")
nzEnemies:AddValidZombieType("nz_zombie_walker_eisendrache")
nzEnemies:AddValidZombieType("nz_zombie_walker_exo")
nzEnemies:AddValidZombieType("nz_zombie_walker_exo_brg")
nzEnemies:AddValidZombieType("nz_zombie_walker_moon")
nzEnemies:AddValidZombieType("nz_zombie_walker_moon_guard")
nzEnemies:AddValidZombieType("nz_zombie_walker_moon_tech")
nzEnemies:AddValidZombieType("nz_zombie_walker_origins")
nzEnemies:AddValidZombieType("nz_zombie_walker_origins_soldier")
nzEnemies:AddValidZombieType("nz_zombie_walker_origins_templar")
nzEnemies:AddValidZombieType("nz_zombie_walker_origins_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_origins_templar_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_outbreak")
nzEnemies:AddValidZombieType("nz_zombie_walker_shangrila")
nzEnemies:AddValidZombieType("nz_zombie_walker_shangrila_classic")
nzEnemies:AddValidZombieType("nz_zombie_walker_sumpf")
nzEnemies:AddValidZombieType("nz_zombie_walker_ascension")
nzEnemies:AddValidZombieType("nz_zombie_walker_escape")
nzEnemies:AddValidZombieType("nz_zombie_walker_hellcatraz")
nzEnemies:AddValidZombieType("nz_zombie_walker_cotd")
nzEnemies:AddValidZombieType("nz_zombie_walker_five")
nzEnemies:AddValidZombieType("nz_zombie_walker_genesis")
nzEnemies:AddValidZombieType("nz_zombie_walker_gorodkrovi")
nzEnemies:AddValidZombieType("nz_zombie_walker_zod")
nzEnemies:AddValidZombieType("nz_zombie_walker_nuketown")
nzEnemies:AddValidZombieType("nz_zombie_walker_hazmat")
nzEnemies:AddValidZombieType("nz_zombie_walker_clown")
nzEnemies:AddValidZombieType("nz_zombie_walker_greenrun")
nzEnemies:AddValidZombieType("nz_zombie_walker_deathtrooper")
nzEnemies:AddValidZombieType("nz_zombie_walker_skeleton")
nzEnemies:AddValidZombieType("nz_zombie_walker_zetsubou")
nzEnemies:AddValidZombieType("nz_zombie_walker_xeno")
nzEnemies:AddValidZombieType("nz_zombie_walker_necromorph")
nzEnemies:AddValidZombieType("nz_zombie_walker_former")
nzEnemies:AddValidZombieType("nz_zombie_special_keeper")
nzEnemies:AddValidZombieType("nz_zombie_special_nova")
nzEnemies:AddValidZombieType("nz_zombie_special_nova_moon")
nzEnemies:AddValidZombieType("nz_zombie_special_nova_electric")
nzEnemies:AddValidZombieType("nz_zombie_special_nova_bomber")
nzEnemies:AddValidZombieType("nz_zombie_special_roach")
nzEnemies:AddValidZombieType("nz_zombie_special_dog")
nzEnemies:AddValidZombieType("nz_zombie_special_donkey")
nzEnemies:AddValidZombieType("nz_zombie_special_raptor")
nzEnemies:AddValidZombieType("nz_zombie_special_facehugger")
nzEnemies:AddValidZombieType("nz_zombie_special_chestburster")
nzEnemies:AddValidZombieType("nz_zombie_special_bot")
nzEnemies:AddValidZombieType("nz_zombie_special_bomba")
nzEnemies:AddValidZombieType("nz_zombie_special_pack")
nzEnemies:AddValidZombieType("nz_zombie_special_licker")
nzEnemies:AddValidZombieType("nz_zombie_special_screamer")
nzEnemies:AddValidZombieType("nz_zombie_special_spooder")
nzEnemies:AddValidZombieType("nz_zombie_special_sprinter")
nzEnemies:AddValidZombieType("nz_zombie_special_sire")
nzEnemies:AddValidZombieType("nz_zombie_special_siz")
nzEnemies:AddValidZombieType("nz_zombie_special_follower")
nzEnemies:AddValidZombieType("nz_zombie_special_ticker")
nzEnemies:AddValidZombieType("nz_zombie_special_wildticker")
nzEnemies:AddValidZombieType("nz_zombie_special_nemacyte")
nzEnemies:AddValidZombieType("nz_zombie_special_wretch")
nzEnemies:AddValidZombieType("nz_zombie_special_deathclaw")
nzEnemies:AddValidZombieType("nz_zombie_special_glowingone")
nzEnemies:AddValidZombieType("nz_zombie_special_electrician")
nzEnemies:AddValidZombieType("nz_zombie_special_ghost")
nzEnemies:AddValidZombieType("nz_zombie_special_spook")
nzEnemies:AddValidZombieType("nz_zombie_special_juggernaut")
nzEnemies:AddValidZombieType("nz_zombie_special_l4d_charger")
nzEnemies:AddValidZombieType("nz_zombie_special_scrake")
nzEnemies:AddValidZombieType("nz_zombie_special_snowman")
nzEnemies:AddValidZombieType("nz_zombie_special_elf_bomber")

function meta:ShouldPhysgunNoCollide()
	return self.bPhysgunNoCollide
end
