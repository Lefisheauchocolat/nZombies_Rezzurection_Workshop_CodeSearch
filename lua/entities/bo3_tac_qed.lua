
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Q.E.D."

--[Sounds]--

--[Parameters]--
ENT.Delay = 2.5

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

local BounceSound = {
	[MAT_DIRT] = "TFA_BO3_QED.Bounce.Earth",
	[MAT_METAL] = "TFA_BO3_QED.Bounce.Metal",
	[MAT_WOOD] = "TFA_BO3_QED.Bounce.Wood",
	[0] = "TFA_BO3_QED.Bounce.Metal",
}

BounceSound[MAT_GRATE] = BounceSound[MAT_METAL]
BounceSound[MAT_VENT] = BounceSound[MAT_METAL]
BounceSound[MAT_GRASS] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Vector", 0, "TelePos")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		local norm = (data.HitPos - self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = BounceSound[tr.MatType] or BounceSound[0]
			self:EmitSound(finalsound)
		end

		sound.EmitHint(SOUND_DANGER, data.HitPos, 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetActivated(true)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet("TFA_BO3_QED.Think")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	self.killtime = CurTime() + self.Delay

	self.QEDEffectsList = {
		[1] = self.Pop,
		[2] = self.Grenade,
		[3] = self.Semtex,
		[4] = self.Matryoshka,
		[5] = self.Gersch,

		[6] = self.RandomTeleport,
		[7] = self.DamagePlayers,
		[8] = self.StealAmmo,
		[9] = self.StealWeapon,

		[10] = self.RandomWeapon,
		[11] = self.MaxAmmo,
		[12] = self.DeathMachine,
		[13] = self.WunderWaffe,

		[14] = self.SpinningRaygun,
		[15] = self.SpinningKN44,
		[16] = self.SpinningHaymaker,
		[17] = self.SpinningMAXGL,

		[18] = self.ScavengerEffect,
		[19] = self.WaffeEffect,
		[20] = self.WavegunEffect,
		[21] = self.ShrinkrayEffect,

		[22] = self.Explode,
		[23] = self.SpawnEnemies,
	}

	if CLIENT then return end
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 20)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			local mul = math.Rand(0.6,1.1)

			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = 200*mul
			dlight.g = 220*mul
			dlight.b = 50*mul
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 64*mul
			dlight.DieTime = CurTime() + 1
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:DoRandomEffect()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

local weighted_random = function(pool) --thank you random reddit user from like 6 years ago
	local poolsize = 0
	for k,v in pairs(pool) do
		poolsize = poolsize + v[1]
	end
	local selection = math.random(1,poolsize)
	for k,v in pairs(pool) do
		selection = selection - v[1] 
		if (selection <= 0) then
			return v[2]
		end
	end
end

local fx_weights = {
	//{weight, effect num}
	{35, 1}, //Astronaut Pop --
	{8, 2}, //Spawn Grenade --
	{8, 3}, //Spawn Semtex --
	{5, 4}, //Spawn Matryoshka --
	{4, 5}, //Spawn Gersch --
	{5, 6}, //Random Teleport --
	{1, 7}, //Damage Players --
	{0.5, 8}, //Steal Ammo --
	{0.5, 9}, //Steal Weapon --
	{2, 10}, //Weapon Powerup --
	{2, 11}, //MaxAmmo Powerup --
	{2, 12}, //Deathmachine Powerup --
	{1, 13}, //Wunderwaffe Powerup --
	{1, 14}, //Spinning Raygun --
	{4, 15}, //Spinning KN44 --
	{4, 16}, //Spinning Haymaker --
	{4, 17}, //Spinning MAXGL --
	{3, 18}, //Scavenger Effect --
	{2, 19}, //Wunderwaffe Effect --
	{2, 20}, //Wavegun Effect --
	{2, 21}, //Shrinkray Effect --
	{5, 22}, //Explode --
	{2, 23}, //Spawn Enemies --
}

function ENT:DoRandomEffect()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
		if math.random(1, 10) == 1 then --10%
			if v:GetClass() == "func_door_rotating" or v:GetClass() == "prop_door_rotating" then
				self:OpenDoors(v)
				return
			end
		end
	end

	self.QEDEffectsList[weighted_random(fx_weights)](self)

	SafeRemoveEntity(self)
end

function ENT:DoCustomRemove(effect, val)
	if effect then
		ParticleEffect("bo3_qed_explode_"..val, self:GetPos(), angle_zero)
	end
	self:EmitSound("TFA_BO3_QED.Poof")
	SafeRemoveEntity(self)
end

//////////////////////////////////////////////////////////////////////////
//--------------------------- QED Effects ------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.Pop = function(self)
	self:GetOwner():ChatPrint("QED Effect: Astronaut Pop")

	self:EmitSound("TFA_BO3_QED.AstroPop")
	ParticleEffect("bo3_astronaut_pulse",self:GetPos(),self:GetAngles())

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_CRUSH)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if not v:IsPlayer() then
				v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized() * 500) + v:GetUp()*120)

				damage:SetDamage(v:Health())
				damage:SetDamageForce(v:GetUp()*22000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
				damage:SetDamagePosition(v:GetPos())
				v:TakeDamageInfo(damage)
			end
			if v:IsPlayer() then
				v:ViewPunch(Angle(-25,math.random(-10, 10),0))
				v:SetGroundEntity(nil)
				v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized() * 200) + v:GetUp()*200)
			end
		end
	end

	self:DoCustomRemove(false)
end

ENT.Grenade = function(self)
	self:GetOwner():ChatPrint("QED Effect: Spawn Grenade")

	local grenade = ents.Create("bo3_misc_frag")
	grenade:SetModel("models/weapons/tfa_bo3/grenade/grenade_prop.mdl")
	grenade:SetPos(self:GetPos() + Vector(0,0,24))
	grenade:SetAngles(self:GetAngles())
	grenade:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	grenade.Damage = 500
	grenade.mydamage = 500
	grenade.Delay = 1.2

	grenade:Spawn()

	local phys = grenade:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(Vector(0,0,250)+VectorRand(-100,100))
	end

	grenade:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	grenade.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 1)
end

ENT.Semtex = function(self)
	self:GetOwner():ChatPrint("QED Effect: Spawn Semtex")

	local semtex = ents.Create("bo3_misc_semtex")
	semtex:SetModel("models/weapons/tfa_bo3/semtex/w_semtex.mdl")
	semtex:SetPos(self:GetPos() + Vector(0,0,24))
	semtex:SetAngles(self:GetAngles())
	semtex:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	semtex.Damage = 1300
	semtex.mydamage = 1300
	semtex.Delay = 1.2

	semtex:Spawn()

	local phys = semtex:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(Vector(0,0,250)+VectorRand(-100,100))
	end

	semtex:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	semtex.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 1)
end

ENT.Matryoshka = function(self)
	self:GetOwner():ChatPrint("QED Effect: Matryoshka Doll")

	local doll = ents.Create("bo3_tac_matryoshka")
	doll:SetModel("models/weapons/tfa_bo3/matryoshka/matryoshka_prop.mdl")
	doll:SetPos(self:GetPos() + Vector(0,0,6))
	doll:SetAngles(angle_zero)
	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	doll.Damage = 100000
	doll.mydamage = 100000
	doll.Delay = 1
	doll:SetCharacter(math.random(4))

	doll:Spawn()

	local phys = doll:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(Vector(0,0,250)+VectorRand(-50,50))
	end

	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	doll.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 2)
end

ENT.Gersch = function(self)
	self:GetOwner():ChatPrint("QED Effect: Gersh Device")

	local bhbomb = ents.Create("bo3_tac_gersch")
	bhbomb:SetModel("models/weapons/tfa_bo3/gersch/w_gersch.mdl")
	bhbomb:SetPos(self:GetPos() + Vector(0,0,24))
	bhbomb:SetAngles(angle_zero)
	bhbomb:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	bhbomb.Damage = 115
	bhbomb.mydamage = 115

	bhbomb:Spawn()

	local phys = bhbomb:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(VectorRand(-25,25))
	end

	bhbomb:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	bhbomb.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 2)
end

local function GetClearPaths(ply, pos, tiles)
	local clearPaths = {}
	local filter = player.GetAll()
	for _, tile in pairs( tiles ) do
		local tr = util.TraceLine({
			start = pos,
			endpos = tile,
			filter = filter,
			mask = MASK_PLAYERSOLID
		})
		
		if not tr.Hit and util.IsInWorld(tile) then
			table.insert( clearPaths, tile )
		end
	end
	
	return clearPaths
end

local function GetSurroundingTiles(ply, pos)
	local tiles = {}
	local x, y, z
	local minBound, maxBound = ply:GetHull()
	local checkRange = math.max(12, maxBound.x, maxBound.y)
	
	for z = -1, 1, 1 do
		for y = -1, 1, 1 do
			for x = -1, 1, 1 do
				local testTile = Vector(x,y,z)
				testTile:Mul( checkRange )
				local tilePos = pos + testTile
				table.insert( tiles, tilePos )
			end
		end
	end
	
	return tiles
end

local function CollisionBoxClear(ply, pos, minBound, maxBound)
	local filter = {ply}
	local tr = util.TraceEntity({
		start = pos,
		endpos = pos,
		filter = filter,
		mask = MASK_PLAYERSOLID
	}, ply)

	return !tr.StartSolid || !tr.AllSolid
end

ENT.RandomTeleport = function(self)
	self:GetOwner():ChatPrint("QED Effect: Random Teleport")

	local ply = self:GetOwner()

	if navmesh.IsLoaded() then
		local tab = navmesh.Find(self:GetPos(), 60000, 60000, 60000)
		for _, nav in RandomPairs(tab) do
			if IsValid(nav) and not nav:IsUnderwater() then
				self:SetTelePos(nav:GetRandomPoint())
				break
			end
		end
	else
		self:SetTelePos(self:GetSpawnPos())
	end

	local minBound, maxBound = ply:GetHull()
	if not CollisionBoxClear( ply, self:GetTelePos(), minBound, maxBound ) then
		ply:PrintMessage(2, "// Teleport Location Blocked //")
		local surroundingTiles = GetSurroundingTiles( ply, self:GetTelePos() )
		local clearPaths = GetClearPaths( ply, self:GetTelePos(), surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if CollisionBoxClear( ply, tile, minBound, maxBound ) then
				self:SetTelePos( tile )
				ply:PrintMessage(2, "// Teleport Retry Count : "..table.Count( clearPaths ).." //")
				break
			end
		end
	end

	if IsValid(ply) then
		ply:ViewPunch(Angle(-5, math.Rand(-10, 10), 0))
		ply:SetPos(self:GetTelePos())
		ply:SetLocalVelocity(Vector(0,0,0))
		timer.Simple(0, function()
			if ply:GetPos():DistToSqr(self:GetTelePos()) >= 25 then
				ply:SetPos(self:GetTelePos())
				ply:PrintMessage(2, "// Teleport Failed, Forcing  //")
			end
		end)
		ply:EmitSound("TFA_BO3_QED.Teleport")
		ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)
	end

	self:DoCustomRemove(true, 3)
end

function ENT:GetSpawnPos()
	local ply = self:GetOwner()
	if !IsTableOfEntitiesValid(self.SpawnPoints) then
		self.LastSpawnPoint = 0
		self.SpawnPoints = ents.FindByClass( "info_player_start" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )

		-- CS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_counterterrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_terrorist" ) )

		-- DOD Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_axis" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_allies" ) )

		-- (Old) GMod Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "gmod_player_start" ) )

		-- TF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_teamspawn" ) )

		-- INS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "ins_spawnpoint" ) )

		-- AOC Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "aoc_spawnpoint" ) )

		-- Dystopia Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "dys_spawn_point" ) )

		-- PVKII Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_pirate" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_viking" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_knight" ) )

		-- DIPRIP Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_red" ) )

		-- OB Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_blue" ) )

		-- SYN Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_coop" ) )

		-- ZPS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_human" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombie" ) )

		-- ZM Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombiemaster" ) )

		-- FOF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_fof" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_desperado" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_vigilante" ) )

		-- L4D Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_survivor_rescue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_survivor_position" ) )
	end

	local count = table.Count(self.SpawnPoints)
	local spawn

	-- Try to work out the best, random spawnpoint
	for i = 1, count do
		spawn = table.Random(self.SpawnPoints)
		if IsValid(spawn) and spawn:IsInWorld() then
			if spawn == self.LastSpawnPoint and count > 1 then continue end
			if hook.Call("IsSpawnpointSuitable", GAMEMODE, ply, spawn, i == count) then
				self.LastSpawnPoint = spawn
				return spawn:GetPos()
			end
		end
	end
end

ENT.DamagePlayers = function(self)
	self:GetOwner():ChatPrint("QED Effect: Damage Nearby Players")

	for _, ply in pairs(ents.FindInSphere(self:GetPos(), 512)) do
		if ply:IsPlayer() and ply:Alive() then
			ply:SetArmor(0)
			ply:TakeDamage(ply:GetMaxHealth()-1, ply, ply:GetActiveWeapon())
			ParticleEffect("bo3_qed_explode_3", ply:GetPos(), angle_zero)
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.StealAmmo = function(self)
	self:GetOwner():ChatPrint("QED Effect: Empty Reserve Ammo")

	for _, ply in pairs(ents.FindInSphere(self:GetPos(), 1024)) do
		if ply:IsPlayer() and ply:Alive() then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then
				ply:SetAmmo(0, wep:GetPrimaryAmmoType())
				ply:SetAmmo(0, wep:GetSecondaryAmmoType())
				if SERVER then
					net.Start("TFA.BO3.QED_SND")
					net.WriteString("StealAmmo")
					net.Send(ply)
				end
			end
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.StealWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Strip Weapon")

	local ply = self:GetOwner()
	if IsValid(ply) then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			ply:SetActiveWeapon(nil)
			ply:Give("tfa_bo3_wepsteal")
			ply:SelectWeapon("tfa_bo3_wepsteal")
			ply:StripWeapon(wep:GetClass())

			if SERVER then
				net.Start("TFA.BO3.QED_SND")
				net.WriteString("WeaponTake")
				net.Send(ply)
			end
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.MaxAmmo = function(self)
	self:GetOwner():ChatPrint("QED Effect: Max Ammo")

	local ply = self:GetOwner()
	for _, wep in pairs(ply:GetWeapons()) do
		if IsValid(wep) then
			if wep.NZMaxAmmo then
				wep:NZMaxAmmo()
			else
				local AmmoToAdd = wep:GetMaxClip1() * 5
				local AmmoToAdd2 = wep:GetMaxClip2() * 5

				ply:GiveAmmo(AmmoToAdd, wep:GetPrimaryAmmoType())
				ply:GiveAmmo(AmmoToAdd2, wep:GetSecondaryAmmoType())
				wep:SetClip1(wep:GetMaxClip1())
				wep:SetClip2(wep:GetMaxClip2())
			end
		end
	end

	ply:EmitSound("TFA_BO3_QED.MaxAmmo")

	if SERVER then
		net.Start("TFA.BO3.QED_SND")
		net.WriteString("MaxAmmo")
		net.Send(ply)
	end

	self:DoCustomRemove(true, 2)
end

ENT.DeathMachine = function(self)
	self:GetOwner():ChatPrint("QED Effect: Death Machine")

	local ply = self:GetOwner()

	ply:EmitSound("TFA_BO3_QED.Pickup")

	if SERVER then
		ply:Give("tfa_bo3_deathmachine")
		ply:SelectWeapon("tfa_bo3_deathmachine")
		net.Start("TFA.BO3.QED_SND")
		net.WriteString("DeathMachine")
		net.Send(ply)
	end

	self:DoCustomRemove(true, 2)
end

ENT.WunderWaffe = function(self)
	self:GetOwner():ChatPrint("QED Effect: WunderWaffe Powerup")

	local ply = self:GetOwner()

	ply:EmitSound("TFA_BO3_QED.Pickup")

	if SERVER then
		ply:Give("tfa_bo3_wunderwaffe")
		ply:SelectWeapon("tfa_bo3_wunderwaffe")
		net.Start("TFA.BO3.QED_SND")
		net.WriteString("Tesla")
		net.Send(ply)
	end

	self:DoCustomRemove(true, 2)
end

ENT.RandomWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Random Weapon Powerup")

	if SERVER then
		local weapon = ents.Create("bo3_powerup_weapon")
		weapon:SetPos(self:GetPos() + Vector(0,0,54))
		weapon:SetOwner(self:GetOwner())
		weapon:SetAngles(angle_zero)

		weapon:Spawn()
	end

	self:DoCustomRemove(true, 2)
end

ENT.SpinningMAXGL = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon MAX-GL")

	if SERVER then
		local spingun = ents.Create("bo3_misc_spingun")
		spingun:SetModel("models/weapons/tfa_bo3/qed/w_maxgl.mdl")
		spingun:SetPos(self:GetPos() + Vector(0,0,54))
		spingun:SetAngles(angle_zero)
		spingun:SetOwner(self:GetOwner())

		spingun.ShootSound = "TFA_BO3_QED.MAXGL.Fire"
		spingun.NumShots = 1
		spingun.Damage = 500
		spingun.RPM = 500
		spingun.ClipSize = 30

		spingun.Projectile = "bo3_misc_40mm"
		spingun.ProjectileVelocity = 3000
		spingun.ProjectileModel = "models/weapons/tfa_bo3/qed/w_maxgl_proj.mdl"

		spingun:Spawn()
	end

	self:DoCustomRemove(true, 3)
end

ENT.SpinningKN44 = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon KN-44")

	if SERVER then
		local spingun = ents.Create("bo3_misc_spingun")
		spingun:SetModel("models/weapons/tfa_bo3/qed/w_kn44.mdl")
		spingun:SetPos(self:GetPos() + Vector(0,0,54))
		spingun:SetAngles(angle_zero)
		spingun:SetOwner(self:GetOwner())

		spingun.ShootSound = "TFA_BO3_QED.KN44.Fire"
		spingun.NumShots = 1
		spingun.Damage = 35
		spingun.RPM = 500
		spingun.ClipSize = 30
		spingun.Spread = Vector(0.05, 0.05, 0)

		spingun:Spawn()
	end

	self:DoCustomRemove(true, 3)
end

ENT.SpinningHaymaker = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon Haymaker-12")

	if SERVER then
		local spingun = ents.Create("bo3_misc_spingun")
		spingun:SetModel("models/weapons/tfa_bo3/qed/w_haymaker.mdl")
		spingun:SetPos(self:GetPos() + Vector(0,0,54))
		spingun:SetAngles(angle_zero)
		spingun:SetOwner(self:GetOwner())

		spingun.ShootSound = "TFA_BO3_QED.HMKR.Fire"
		spingun.NumShots = 8
		spingun.Damage = 8
		spingun.RPM = 500
		spingun.ClipSize = 30
		spingun.Spread = Vector(0.1, 0.1, 0)
		spingun.MuzzleType = 7

		spingun:Spawn()
	end

	self:DoCustomRemove(true, 3)
end

ENT.SpinningRaygun = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon Raygun")

	local raychance = math.random(2)
	local mdl1 = "models/weapons/tfa_bo3/raygun/w_raygun.mdl"
	local mdl2 = "models/weapons/tfa_bo3/mk2/w_mk2.mdl"
	local mk2 = raychance == 1

	if SERVER then
		local spingun = ents.Create("bo3_misc_spingun")
		spingun:SetModel(mk2 and mdl2 or mdl1)
		spingun:SetPos(self:GetPos() + Vector(0,0,54))
		spingun:SetAngles(angle_zero)
		spingun:SetOwner(self:GetOwner())

		spingun.ShootSound = mk2 and "TFA_BO3_MK2.Shoot" or "TFA_BO3_RAYGUN.Shoot"
		spingun.NumShots = 1
		spingun.Damage = 1150
		spingun.RPM = 600
		spingun.ClipSize = 20

		spingun.MuzzleFlashEffect = mk2 and "tfa_bo3_muzzleflash_raygunmk2_qed" or "tfa_bo3_muzzleflash_raygun_qed"
		spingun.MuzzleFlashColor = Color(90, 255, 10)
		
		spingun.Projectile = mk2 and "bo3_ww_mk2" or "bo3_ww_raygun"
		spingun.ProjectileVelocity = 3500
		spingun.ProjectileModel = "models/dav0r/hoverball.mdl"
		
		spingun:Spawn()
	end

	self:DoCustomRemove(true, 3)
end

ENT.OpenDoors = function(self, v)
	self:GetOwner():ChatPrint("QED Effect: Unlock Door")

	if v.TFADoorUntouchable and v.TFADoorUntouchable > CurTime() then self:DoCustomRemove(true) end
	v:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(90, 110))
	self.oldname = self:GetName()
	self:SetName("bashingent" .. self:EntIndex())
	v:Fire("unlock", "", .01)
	v:SetKeyValue("Speed", "500")
	v:SetKeyValue("Open Direction", "Both directions")
	v:SetKeyValue("opendir", "0")
	v:Fire("openawayfrom", "bashingent" .. self:EntIndex(), .01)

	timer.Simple(0.02, function()
		if IsValid(self) then
			self:SetName(self.oldname)
		end
	end)
	timer.Simple(0.3, function()
		if IsValid(v) then
			v:SetKeyValue("Speed", "100")
		end
	end)
	v.TFADoorUntouchable = CurTime() + 5

	self:DoCustomRemove(true, 2)
end

ENT.ScavengerEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Scavenger Explosion")

	if math.random(0, 3) == 1 then
		self:EmitSound("TFA_BO3_SCAVENGER.ExplodePaP")
		ParticleEffect("bo3_scavenger_explosion_2", self:GetPos(), angle_zero)
	else
		self:EmitSound("TFA_BO3_SCAVENGER.Explode")
		ParticleEffect("bo3_scavenger_explosion", self:GetPos(), angle_zero)
	end

	util.ScreenShake(self:GetPos(), 20, 255, 1, 500)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			local damage = DamageInfo()
			damage:SetDamage(11500)

			if v == self:GetOwner() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/250, 0.1, 0.9)
				damage:SetDamage(150*distfac)
			end

			damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageForce(v:GetUp()*20000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)
			damage:SetDamageType(bit.bor(DMG_BLAST, DMG_ALWAYSGIB))
			damage:SetDamagePosition(v:WorldSpaceCenter())

			v:TakeDamageInfo(damage)
		end
	end

	self:DoCustomRemove(false, 2)
end

ENT.WaffeEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Wunderwaffe Effect")

	local waff = ents.Create("bo3_ww_wunderwaffe")
	waff:SetModel("models/dav0r/hoverball.mdl")
	waff:SetPos(self:GetPos() + Vector(0,0,24))
	waff:SetAngles(Angle(90,0,0))
	waff:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	waff.Damage = 11500
	waff.mydamage = 11500

	waff:Spawn()

	ang = Angle(90,0,0)
	local dir = ang:Forward() 
	dir:Mul(500)

	waff:SetVelocity(dir)
	local phys = waff:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(dir)
	end

	waff:SetOwner(self:GetOwner())
	waff.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 2)
end

ENT.WavegunEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Wavegun Effect")

	if not IsValid(self.Inflictor) then self.Inflictor = self end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if (v:IsNPC() or v:IsNextBot()) and not v:BO3IsCooking() then
			v:BO3Microwave(math.Rand(2.8,3.4), self:GetOwner(), self.Inflictor)
		end
	end

	self:EmitSound("TFA_BO3_ZAPGUN.Flux")

	self:DoCustomRemove(true, 4)
end

ENT.ShrinkrayEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: 31-79 JGb215 Effect")

	self:EmitSound("TFA_BO3_JGB.Flux")

	ParticleEffect("bo3_jgb_impact", self:GetPos(), angle_zero)

	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if (v:IsNPC() or v:IsNextBot()) and not v:BO3IsShrunk() then
			v:BO3Shrink(5, false)
		end
	end

	self:DoCustomRemove(false, 2)
end

ENT.Explode = function(self)
	self:GetOwner():ChatPrint("QED Effect: Explosion")

	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamage(2500)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			
			if v:IsPlayer() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/250, 0, 1)
				damage:SetDamage(200*distfac)
			end
			
			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
			
			v:TakeDamageInfo(damage)
		end
	end
	
	util.ScreenShake(self:GetPos(), 20, 255, 1.2, 500)

	ParticleEffect("bo3_panzer_explosion", self:GetPos(), angle_zero)
	self:EmitSound("TFA_BO3_QED.NukeFlux")

	self:DoCustomRemove(false, 1)
end

ENT.SpawnEnemies = function(self)
	self:GetOwner():ChatPrint("QED Effect: Spawn Enemies")

	local radv = 128
	local pos = self:GetPos()
	local ply = self:GetOwner()
	local enttype = math.random(2)

	local tr = {}
	tr.start = pos
	tr.filter = self

	local models = {
		[1] = "models/combine_soldier.mdl",
		[2] = "models/combine_soldier.mdl",
		[3] = "models/combine_super_soldier.mdl"
	}
	local nades = {
		[1] = 5,
		[2] = 0,
		[3] = 10
	}
	local weapon = {
		[1] = "weapon_smg1",
		[2] = "weapon_shotgun",
		[3] = "weapon_ar2"
	}

	local i=1
	while i<=9 do
		local chance = math.random(3)
		local offset = VectorRand()*Vector(radv,radv,0)
		tr.endpos = pos + offset
		local traceres = util.TraceLine(tr)
		local entpos = pos + traceres.Normal*math.Clamp(traceres.Fraction,0,1)*offset:Length()

		if enttype == 1 then
			local zombies = {
				[1] = "npc_zombie",
				[2] = "npc_fastzombie",
				[3] = "npc_poisonzombie"
			}

			local ent = ents.Create(zombies[chance])
			ent:SetPos(entpos)
			ent:Spawn()
			self:UndoAdd(ent, enttype)
		else
			local ent = ents.Create("npc_combine_s")
			ent:SetPos(entpos)
			ent:SetModel(models[chance])
			ent:SetKeyValue( "SquadName", "overwatch" )
			ent:SetKeyValue( "Numgrenades", nades[chance] )
			if chance == 2 then
				ent:SetKeyValue( "skin", 1 )
			end

			ent:Spawn()
			ent:Give(weapon[chance])
			self:UndoAdd(ent, enttype)
		end
		i=i+1
	end

	self:DoCustomRemove(true, 3)
end

function ENT:UndoAdd(ent, qtype)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		local name = "Q.E.D. Enemy"
		if qtype then
			if qtype == 1 then
				name = "Q.E.D. Zombie"
			else
				name = "Q.E.D. Combine"
			end
		end

		cleanup.Add(ply, "NPC", ent)

		undo.Create(name)
		undo.AddEntity(ent)
		undo.SetPlayer(ply)
		undo.Finish()
	end
end

function ENT:OnRemove()
	self:StopParticles()
end
