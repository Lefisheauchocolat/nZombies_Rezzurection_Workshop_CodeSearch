AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:StartTouch(ent)
	if self:GetRed() and IsValid(ent) and ent:GetClass() == "bo1_semtex_grenade" and not self:GetSemtexHack() then
		self:SetSemtexHack(true)
	end
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo2/tomb/zm_tm_dig_mound.mdl")
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:Reset()

	self:CreateFakeModel()
end

function ENT:CreateFakeModel()
	if IsValid(self.BuildPartModel) then return end
	if not self:GetOverride() then return end

	local parttab = nzBuilds:GetBuildParts(self:GetBuildable())
	if not parttab then return end

	self.BuildPartModel = ents.Create("nz_digholo")
	self.BuildPartModel:SetParent(self)
	self.BuildPartModel:SetModel(tostring(parttab[self:GetPartID()].mdl))
	self.BuildPartModel:SetPos(self:WorldSpaceCenter() + self:GetUp()*20)
	self.BuildPartModel:SetAngles(self:GetAngles())

	self.BuildPartModel:Spawn()
end

function ENT:StartTimedUse(ply)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if ply:IsInCreative() or nzRound:InState(ROUND_CREATE) then
		if self.NextUse and self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 2

		timer.Simple(0, function()
			if not IsValid(self) then return end
			ParticleEffectAttach("nzr_digsite_loop", PATTACH_ABSORIGIN_FOLLOW, self, 1)
		end)
		timer.Simple(1, function()
			self:StopParticles()
			timer.Simple(0, function()
				if not IsValid(self) then return end
				self:StopParticles()
			end)
		end)

		self:EmitSound("NZ.BO2.DigSite.Dig")
		return
	end

	if not ply.GetShovel or not IsValid(ply:GetShovel()) then return end
	if self:GetActivated() then return end

	if self:GetRed() then
		if not ply:GetShovel():IsGolden() then return end
		if not nzPowerUps.ActivePlayerPowerUps[ply] then nzPowerUps.ActivePlayerPowerUps[ply] = {} end //yes it is fucking rediculous i had to do this
		if not nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then return end
	end

	timer.Simple(0, function()
		if not IsValid(self) then return end
		ParticleEffectAttach("nzr_digsite_loop", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	end)
	self:EmitSound("NZ.BO2.DigSite.Dig")

	return ply:GetShovel():IsGolden() and 0.5 or 1
end

function ENT:StopTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	self:StopSound("NZ.BO2.DigSite.Dig")
	self:StopParticles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
	end)
end

function ENT:FinishTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not ply.GetShovel and not IsValid(ply:GetShovel()) then return end

	self:StopSound("NZ.BO2.DigSite.Dig")
	self:StopParticles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
	end)

	if self:GetActivated() then return end

	local shovel = ply:GetShovel()
	shovel:SetUseCount(shovel:GetUseCount() + 1)
	if shovel:GetUseCount() == shovel.GoldAmount then
		shovel:EmitSound("NZ.BO2.Shovel.Upgrade")
	end

	self:Reward(ply, shovel)
	self:Trigger()
end

function ENT:Reward(ply, shovel)
	if not IsValid(ply) then return end
	if not IsValid(shovel) then
		shovel = ply:GetShovel()
	end

	if self:GetOverride() then
		hook.Call("PlayerUseDigsite", nil, ply, self, 0) //buildable reward
		self:SpawnBuildablePart(ply)
	else
		if self:GetRed() and shovel:IsGolden() then
			hook.Call("PlayerUseDigsite", nil, ply, self, 4) //super reward
			if nzPowerUps.Data["emptybottle"] then
				nzPowerUps:SpawnPowerUp(self:GetPos(), "emptybottle")
			else
				nzPowerUps:SpawnPowerUp(self:GetPos(), "bottleslot")
			end
		else
			if not ply.n_losing_streak then ply.n_losing_streak = 0 end

			local n_price_roll = math.random(100)
			local n_good_chance = shovel:IsGolden() and 70 or 50
			if shovel:GetUseCount() <= 1 or ply.n_losing_streak == 3 then
				ply.n_losing_streak = 0
				n_good_chance = 100
			end

			if n_price_roll > n_good_chance then //negative reward
				if math.random(2) == 1 then
					self:SpawnGrenade(ply)
					timer.Simple(0.15, function()
						if not IsValid(self) or not IsValid(ply) then return end
						self:SpawnGrenade(ply)
					end)
				else
					if nzRound:InState(ROUND_PROG) then
						self:SpawnZombie(ply)
					else
						self:SpawnGrenade(ply)
					end
				end

				ply.n_losing_streak = ply.n_losing_streak + 1
				hook.Call("PlayerUseDigsite", nil, ply, self, 1) //bad reward
			elseif math.random(2) == 1 then //positive reward
				if shovel:IsGolden() and not nzDigs.dig_last_prize_rare and math.random(100) < 80 then
					self:SpawnPowerup(ply)

					nzDigs.dig_last_prize_rare = true
				else
					if nzDigs.dig_n_zombie_bloods_spawned < 1 and math.random(100) > 70 then
						self:SpawnZombieBlood(ply)
						nzDigs:IncrementZombieBloodSpawned()
					else
						self:SpawnBonusPoints(ply)

						nzDigs.dig_last_prize_rare = false
					end
				end

				hook.Call("PlayerUseDigsite", nil, ply, self, 2) //powerup reward
			else //weapon reward
				self:SpawnBoxWeapon(ply)
				hook.Call("PlayerUseDigsite", nil, ply, self, 3) //gun reward
			end
		end
	end
end

function ENT:BloodMound()
	self:Reset()

	self:SetRed(true)
	self:SetBodygroup(0, 1)
	self:DrawShadow(false)
	self:Ignite(1)
end

function ENT:Reset()
	self:SetSemtexHack(false)
	self:SetRed(false)
	self:SetBodygroup(0, 0)

	if not self:GetOverride() then
		nzDigs.n_dig_spots_cur = math.Clamp(nzDigs.n_dig_spots_cur + 1, 0, nzDigs.n_dig_spots_max)
	end

	self:SetActivated(false)
	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Trigger()
	if not self:GetOverride() then
		nzDigs.n_dig_spots_cur = math.Clamp(nzDigs.n_dig_spots_cur - 1, 0, nzDigs.n_dig_spots_max)
	end

	self:SetActivated(true)
	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end

function ENT:DecideWeapon()
	if not nzMapping.Settings.rboxweps then PrintMessage(HUD_PRINTTALK, "No box weapons setup, cannot reward gun") return end

	local guns = {}
	local blacklist = table.Copy(nzConfig.WeaponBlackList)

	if nzDigs.weapons_dig_list and not table.IsEmpty(nzDigs.weapons_dig_list) then
		for k, v in pairs(nzDigs.weapons_dig_list) do
			guns[k] = v
		end
	else
		local weplist = weapons.GetList()
		for _, wep in pairs(weplist) do
			if wep.NZSpecialCategory or wep.NZWonderWeapon then
				blacklist[wep.ClassName] = true
			end
		end

		for k, v in pairs(nzMapping.Settings.rboxweps) do
			if !blacklist[k] then
				guns[k] = v
			end
		end
	end

	if table.IsEmpty(guns) then PrintMessage(HUD_PRINTTALK, "No selectable guns found, cannot reward gun") return end

	local class = nzMisc.WeightedRandom(guns)

	return class
end

function ENT:SpawnGrenade(ply)
	if not IsValid(ply) then return end
	ply:ChatPrint("Spawn Grenade")

	local grenade = ents.Create("bo1_m67_grenade")
	grenade:SetModel("models/nzr/2022/weapons/m67_projectile.mdl")
	grenade:SetPos(self:GetPos())
	grenade:SetAngles(self:GetAngles())
	grenade:SetOwner(ply)

	grenade.Damage = 300
	grenade.mydamage = 300
	grenade.Delay = 2

	grenade:Spawn()
	grenade:EmitSound("NZ.BO2.DigSite.Grenade")

	local phys = grenade:GetPhysicsObject()
	if IsValid(phys) then //pls dont look at me, im high as shit
		local fuck1 = math.random(2) == 2 and 10 or -10
		local fuck2 = math.random(2) == 1 and -10 or 10
		phys:SetVelocity(Vector(0,0,math.random(200,400)) + Vector(math.random(8)*fuck1, math.random(8)*fuck2, 0))
	end

	grenade:SetOwner(ply)
	grenade.Inflictor = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or ply
end

function ENT:SpawnBoxWeapon(ply)
	if not IsValid(ply) then return end
	ply:ChatPrint("Spawn Box Weapon")

	local class = self:DecideWeapon()

	local gun = weapons.Get(class)
	if not gun then self:SpawnGrenade(ply) return end //failsafe if u fuck up box list
	ply:ChatPrint(tostring(gun.PrintName))

	local wep = ents.Create("nz_powerup_drop_weapon")
	wep:SetGun(class)
	wep:SetPos(self:GetPos() + Vector(0,0,48))
	wep:Spawn()
end

function ENT:SpawnBonusPoints(ply)
	ply:ChatPrint("Spawn Bonus Points")

	if nzPowerUps:Get("bloodmoney") then
		nzPowerUps:SpawnPowerUp(self:GetPos(), "bloodmoney")
	else
		local bonus = ents.Create("nz_powerup_drop_bloodmoney")
		bonus:SetPos(self:GetPos() + Vector(0,0,48))
		bonus:Spawn()
	end
end

function ENT:SpawnZombieBlood(ply)
	ply:ChatPrint("Spawn Zombie Blood")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "zombieblood")
end

function ENT:SpawnPowerup(ply)
	ply:ChatPrint("Spawn Powerup")
	local powerups = {
		"maxammo", "dp", "insta",
		"nuke", "carpenter", "deathmachine"
	} //limit what kinda powerups it drops, for simplicity

	local powerup = powerups[math.random(#powerups)]
	ply:ChatPrint(powerup)
	nzPowerUps:SpawnPowerUp(self:GetPos(), powerup)
end

function ENT:SpawnBuildablePart(ply)
	ply:ChatPrint("Spawn Build Part")

	local build = self:GetBuildable()
	local id = self:GetPartID()
	local parttab = nzBuilds:GetBuildParts(build)
	if not parttab then return end

	local ent = ents.Create("nz_buildable")
	ent:SetPos(self:GetPos() + self:GetUp())
	ent:SetAngles(self:GetAngles())
	ent:SetModel(tostring(parttab[id].mdl))

	ent:SetBuildable(build)
	ent:SetPartID(id)
	ent.DigsiteBuildable = true

	ent:Spawn()
	ent:Reset()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	self:EmitSound("NZ.BO2.DigSite.Part")
end

local function FindNearestSpawner(pos)
	local nearbyents = {}
	for k, v in pairs(ents.FindByClass("nz_spawn_zombie_normal")) do
		if v.GetSpawner and v:GetSpawner() then
			if v:IsSuitable() then
				table.insert(nearbyents, v)
			end
		end
	end

	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
	return nearbyents[1]
end

function ENT:SpawnZombie(ply)
	ply:ChatPrint("Spawn Zombie")
	if not nzRound:InState(ROUND_PROG) then print("Digsite failed to spawn zombie. Round not in progress") return end

	local zspawn = FindNearestSpawner(self:GetPos())
	if IsValid(zspawn) then
		local spawner = zspawn:GetSpawner()
		local class = nzMisc.WeightedRandom(zspawn:GetZombieData(), "chance")
		local zombie = ents.Create(class)
		zombie:SetPos(self:GetPos())
		zombie:SetAngles(zspawn:GetAngles())
		zombie:Spawn()
		zombie:SetSpawner(spawner)
		zombie:Activate()

		hook.Call("OnZombieSpawned", nzEnemies, zombie, zspawn)

		if nzRound:IsSpecial() then
			local data = nzRound:GetSpecialRoundData()
			if data and data.spawnfunc then
				data.spawnfunc(zombie)
			end
		end

		spawner:SetNextSpawn(CurTime() + spawner:GetDelay())
		zspawn:SetNextSpawn(CurTime() + spawner:GetDelay() * 2 + math.Rand(0,0.1))
	end
end

function ENT:OnRemove()
	if IsValid(self.BuildPartModel) then
		SafeRemoveEntity(self.BuildPartModel)
	end
end