
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
ENT.PrintName = "Q.E.D. (nZombies)"

--[Parameters]--
ENT.Delay = 2.5
ENT.NZThrowIcon = Material("vgui/icon/hud_quantum_bomb.png", "unlitgeneric smooth")

local comedyday = os.date("%d-%m") == "01-04"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

DEFINE_BASECLASS(ENT.Base)

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
		[6] = self.Explode,

		[7] = self.DropMaxAmmo,
		[8] = self.DropDoublePoints,
		[9] = self.DropInstakill,
		[10] = self.DropNuke,
		[11] = self.DropCarpenter,
		[12] = self.DropFiresale,
		[13] = self.DropDeathmachine,
		[14] = self.DropZombieCash,
		[15] = self.DropBonfireSale,

		[16] = self.ZombieTeleport,
		[17] = self.RandomTeleport,
		[18] = self.RandomTeleportAll,
		[19] = self.RandomWeapon,
		[20] = self.RandomPerk,

		[21] = self.SpinningRaygun,
		[22] = self.SpinningKN44,
		[23] = self.SpinningHaymaker,
		[24] = self.SpinningMAXGL,

		[25] = self.ScavengerEffect,
		[26] = self.WaffeEffect,
		[27] = self.WavegunEffect,
		[28] = self.ShrinkrayEffect,
		[29] = self.MonkeybombEffect,

		[30] = self.AntiMaxAmmo,
		[31] = self.AntiInstakill,
		[32] = self.AntiPerkbottle,
		[33] = self.AntiFiresale,
		[34] = self.AntiZombieCash,
		[35] = self.AntiDoublePoints,
		[36] = self.AntiCarpenter,
		[37] = self.AntiNuke,

		[38] = self.UpgradeWeapon,
		[39] = self.DowngradeWeapon,
		[40] = self.DownPlayer,
		[41] = self.TakeWeapon,
		[42] = self.SpawnZombies,
		[43] = self.SpawnBoss,
		[44] = self.Door,
		[45] = self.COTDSprinter,
		[46] = self.QEDPowerup,
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
		if self.killtime < CurTime() and !self.DontDelete then
			self:DoRandomEffect()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

local weighted_random = function(pool) //thank you reddit user 'ws-ilazki' from 6 years ago
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
	{10, 2}, //Spawn Grenade --
	{10, 3}, //Spawn Semtex --
	{5, 4}, //Spawn Matryoshka --
	{4, 5}, //Spawn Gersch --
	{6, 6}, //Spawn Explosion -- 70

	{.4, 7}, //Powerup MaxAmmo --
	{.6, 8}, //Powerup Double Points --
	{.4, 9}, //Powerup Instakill --
	{.5, 10}, //Powerup Nuke --
	{.8, 11}, //Powerup Carpenter --
	{.6, 12}, //Powerup Firesale --
	{.5, 13}, //Powerup Deathmachine --
	{1, 14}, //Powerup Zombie Cash --
	{.2, 15}, //Powerup Bonfire Sale -- 5

	{1, 16}, //Zombie Teleport --
	{3.5, 17}, //Random Teleport --
	{1.5, 18}, //Random Teleport All --
	{.4, 19}, //Random Weapon --
	{.1, 20}, //Random Perk -- 6.5

	{1, 21}, //Spinning Raygun --
	{2, 22}, //Spinning KN44 --
	{2, 23}, //Spinning Haymaker --
	{1, 24}, //Spinning MAXGL -- 6

	{2, 25}, //Scavenger Effect --
	{1, 26}, //Wunderwaffe Effect --
	{1, 27}, //Wavegun Effect --
	{2, 28}, //Shrinkray Effect --
	{2, 29}, //Monkeybomb Effect -- 8

	{.2, 30}, //Anti Maxammo --
	{.3, 31}, //Anti Instakill --
	{.1, 32}, //Anti Perk Bottle --
	{.4, 33}, //Anti Firesale -- 
	{.5, 34}, //Anti Zombie Cash --
	{.2, 34}, //Anti Double Points --
	{.2, 34}, //Anti Carpenter --
	{.1, 34}, //Anti Nuke -- 2

	{.1, 35}, //Upgrade Weapon --
	{.1, 36}, //Downgrade Weapon -- 
	{.1, 37}, //Down Player --
	{.1, 38}, //Take Weapon -- 
	{.2, 39}, //Spawn Zombies --
	{.2, 40}, //Spawn Boss --
	{.7, 41}, //Open Door --
	{.5, 42}, //Sprinter Zombies --
	{.5, 43}, //QED Powerup -- 2.5
}

local april_fx_weights = {
	//{weight, effect num}
	{5, 2}, //Spawn Grenade --
	{5, 3}, //Spawn Semtex -- 10

	{15, 16}, //Zombie Teleport --
	{30, 17}, //Random Teleport --
	{10, 18}, //Random Teleport All -- 55

	{1, 21}, //Spinning Raygun --
	{4, 22}, //Spinning KN44 --
	{4, 23}, //Spinning Haymaker --
	{1, 24}, //Spinning MAXGL -- 10

	{2, 30}, //Anti Maxammo --
	{3, 31}, //Anti Instakill --
	{1, 32}, //Anti Perk Bottle --
	{4, 33}, //Anti Firesale --
	{5, 34}, //Anti Zombie Cash -- 15

	{1, 36}, //Downgrade Weapon --
	{0.1, 37}, //Down Player --
	{1, 38}, //Take Weapon --
	{2.9, 39}, //Spawn Zombies --
	{1, 40}, //Spawn Boss --
	{4, 42}, //Sprinter Zombies -- 10
}

function ENT:DoRandomEffect()
	local tab = player.GetAllPlaying()
	if not tab or table.IsEmpty(tab) then
		tab = player.GetAll()
	end

	//check for players to be revived first
	for _, ply in pairs(tab) do
		if not ply:GetNotDowned() then
			if math.random(15) <= (1 * #tab) then --6.6%
				self:RevivePlayers()
				return
			end
		end
	end

	//check for open box
	if math.random(200) <= 1 and !nzPowerUps:IsPowerupActive("firesale") then --0.5%
		local box = ents.FindByClass("random_box")[1]
		if IsValid(box) and box.Close and box.GetOpen and box:GetOpen() then
			self:CloseBox(box)
			return
		end
	end

	//check nearby entities
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
		//perk machine
		if v:GetClass() == 'perk_machine' then
			if math.random(100) <= 1 then --1%
				self:PerkMachine(v)
				return
			end
		end

		//blackhole
		if v:GetClass() == 'nz_bo3_tac_gersch' then
			if math.random(25) <= 1 then --4%
				self:GerschPowerup()
				return
			end
		end

		//excavator
		if v:GetClass() == 'prop_dynamic' then
			if v:GetName() == 'piblade' and v:GetSequence() == 3 then
				local pi = ents.FindByName("picons")[1]
				pi:Fire("Press")

				self:GetOwner():ChatPrint("QED Effect: Recall Excavator Pi")
				self:DoCustomRemove(true, 1)
				return
			end

			if v:GetName() == 'omicronblade' and v:GetSequence() == 3 then
				local omicron = ents.FindByName("omicroncons")[1]
				omicron:Fire("Press")

				self:GetOwner():ChatPrint("QED Effect: Recall Excavator Omicron")
				self:DoCustomRemove(true, 1)
				return
			end

			if v:GetName() == 'epsilonblade' and v:GetSequence() == 3 then
				local epsilon = ents.FindByName("epsiloncons")[1]
				epsilon:Fire("Press")

				self:GetOwner():ChatPrint("QED Effect: Recall Excavator Epsilon")
				self:DoCustomRemove(true, 1)
				return
			end
		end
	end

	//you already know who it is
	if comedyday then
		local effect = weighted_random(april_fx_weights)
		self.QEDEffectsList[effect](self)
		print("QED Effect: April Fools")
	else
		local effect = weighted_random(fx_weights)
		self.QEDEffectsList[effect](self)
	end
end

function ENT:DoCustomRemove(effect, val)
	if effect then
		ParticleEffect("bo3_qed_explode_"..val, self:GetPos(), angle_zero)
	end
	self:EmitSound("TFA_BO3_QED.Poof")
	SafeRemoveEntity(self)
end

//////////////////////////////////////////////////////////////////////////
//------------------------ Explosion / Nades ---------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.Pop = function(self)
	self:GetOwner():ChatPrint("QED Effect: Astronaut Pop")

	self:EmitSound("TFA_BO3_QED.AstroPop")
	ParticleEffect("bo3_astronaut_pulse",self:GetPos(),self:GetAngles())

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsValidZombie() then
				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*22000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
				damage:SetDamagePosition(v:WorldSpaceCenter())

				if v.NZBossType or v.IsMooBossZombie then
					damage:SetDamage(v:GetMaxHealth()/6)
				end

				v:TakeDamageInfo(damage)
			end

			if v:IsPlayer() then
				v:ViewPunch(Angle(-25,math.random(-10, 10),0))
				v:SetGroundEntity(nil)
				v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized()*200) + v:GetUp()*200)
			end
		end
	end

	self:DoCustomRemove(false)
end

ENT.Grenade = function(self)
	self:GetOwner():ChatPrint("QED Effect: Frag Grenade")

	local frag = nzMapping.Settings.grenade or ""
	local wepdata = weapons.Get(tostring(frag))
	if wepdata and wepdata.IsTFAWeapon and (wepdata.ProjectileEntity or wepdata.Primary.Projectile or wepdata.Primary.Round) then
		local max = math.random(2)
		for i=1, max do
			local grenade = ents.Create(wepdata.ProjectileEntity or wepdata.Primary.Projectile or wepdata.Primary.Round)
			grenade:SetModel(wepdata.Primary.ProjectileModel or wepdata.ProjectileModel or "models/weapons/tfa_bo3/grenade/grenade_prop.mdl")
			grenade:SetPos(self:GetPos() + Vector(0,0,24))
			grenade:SetAngles(self:GetAngles())
			grenade:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

			grenade.Damage = 500
			grenade.mydamage = 500
			grenade.Delay = max == 2 and 2.1 or 1.2

			grenade:Spawn()

			local phys = grenade:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(Vector(0,0,250)+VectorRand(-100,100))
				if wepdata.ThrowSpin then
					phys:AddAngleVelocity(Vector(math.random(-2000,-500),math.random(-500,-2000),math.random(-500,-2000)))
				end
			end

			grenade:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
			grenade.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
		end
	else
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
	end

	self:DoCustomRemove(true, 1)
end

ENT.Semtex = function(self)
	self:GetOwner():ChatPrint("QED Effect: Semtex Grenade")

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

	local doll = ents.Create("nz_bo3_tac_matryoshka")
	doll:SetModel("models/weapons/tfa_bo3/matryoshka/matryoshka_prop.mdl")
	doll:SetPos(self:GetPos() + Vector(0,0,6))
	doll:SetAngles(angle_zero)
	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	doll.Damage = 100000
	doll.mydamage = 100000
	doll:SetCharacter(math.random(4))

	doll:Spawn()

	local phys = doll:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(Vector(0,0,250) + VectorRand(-50,50))
	end

	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	doll.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:DoCustomRemove(true, 1)
end

ENT.Gersch = function(self)
	self:GetOwner():ChatPrint("QED Effect: Gersh Device")

	local bhbomb = ents.Create("nz_bo3_tac_gersch")
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

ENT.Explode = function(self)
	self:GetOwner():ChatPrint("QED Effect: Explosion")

	ParticleEffect("bo3_panzer_explosion", self:GetPos(), angle_zero)

	self:EmitSound("TFA_BO3_QED.NukeFlux")

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsPlayer() then continue end
			damage:SetDamage(12000)
			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetPos(), 20, 255, 1.5, 500)

	self:DoCustomRemove(false, 1)
end

//////////////////////////////////////////////////////////////////////////
//------------------------------- Give ---------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.DropMaxAmmo = function(self)
	self:GetOwner():ChatPrint("QED Effect: Max Ammo Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "maxammo")

	self:DoCustomRemove(true, 2)
end

ENT.DropDoublePoints = function(self)
	self:GetOwner():ChatPrint("QED Effect: Double Points Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "dp")

	self:DoCustomRemove(true, 2)
end

ENT.DropInstakill = function(self)
	self:GetOwner():ChatPrint("QED Effect: Instakill Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "insta")

	self:DoCustomRemove(true, 2)
end

ENT.DropNuke = function(self)
	self:GetOwner():ChatPrint("QED Effect: Nuke Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "nuke")

	self:DoCustomRemove(true, 2)
end

ENT.DropCarpenter = function(self)
	self:GetOwner():ChatPrint("QED Effect: Carpenter Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "carpenter")

	self:DoCustomRemove(true, 2)
end

ENT.DropFiresale = function(self)
	self:GetOwner():ChatPrint("QED Effect: Firesale Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "firesale")

	self:DoCustomRemove(true, 2)
end

ENT.DropDeathmachine = function(self)
	self:GetOwner():ChatPrint("QED Effect: Deathmachine Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "deathmachine")

	self:DoCustomRemove(true, 2)
end

ENT.DropZombieCash = function(self)
	self:GetOwner():ChatPrint("QED Effect: Zombie Cash Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "bonuspoints")

	self:DoCustomRemove(true, 2)
end

ENT.DropBonfireSale = function(self)
	self:GetOwner():ChatPrint("QED Effect: Bonfire Sale Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "bonfiresale")

	self:DoCustomRemove(true, 2)
end

//////////////////////////////////////////////////////////////////////////
//------------------------------ Random --------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.RandomTeleport = function(self)
	local ply = self:GetOwner()
	self:GetOwner():ChatPrint("QED Effect: Teleport Random Player")

	local tab = player.GetAllPlayingAndAlive()
	if tab and not table.IsEmpty(tab) then
		ply = table.Random(tab)
	end

	local available = ents.FindByClass("nz_spawn_zombie_special")
	if nzMapping.Settings.specialsuseplayers then
		available = ents.FindByClass("player_spawns")
	end

	local pos = ply:GetPos()
	local spawns = {}

	if IsValid(available[1]) and !nzMapping.Settings.specialsuseplayers then
		for k,v in pairs(available) do
			if v.link == nil or nzDoors:IsLinkOpened( v.link ) then -- Only for rooms that are opened (using links)
				if v:IsSuitable() then -- And nothing is blocking it
					table.insert(spawns, v)
				end
			end
		end
		if !IsValid(spawns[1]) then -- Still no open linked ones?! Spawn at a random player spawnpoint
			local pspawns = ents.FindByClass("player_spawns")
			if !IsValid(pspawns[1]) then
				ply:ChatPrint("Couldnt Find Exit Location for QED Teleport")
			else
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		else
			pos = spawns[math.random(#spawns)]:GetPos()
		end
	else -- There are no special spawnpoints - Use regular player spawns
		local pspawns = ents.FindByClass("player_spawns")
		if IsValid(pspawns[1]) then
			pos = pspawns[math.random(#pspawns)]:GetPos()
		end
	end

	self:SetTelePos(pos)

	if IsValid(ply) then
		ply:ViewPunch(Angle(-5, math.Rand(-10, 10), 0))
		ply:SetPos(self:GetTelePos())
		ply:SetLocalVelocity(vector_origin)
		timer.Simple(0, function()
			if ply:GetPos() ~= self:GetTelePos() then
				ply:SetPos(self:GetTelePos())
				ply:PrintMessage(2, "// Teleport Failed, Forcing //")
			end
		end)
		ply:EmitSound("TFA_BO3_QED.Teleport")
	end

	self:DoCustomRemove(true, 3)
end

ENT.RandomTeleportAll = function(self)
	self:GetOwner():ChatPrint("QED Effect: Teleport All Players")

	local tab = player.GetAllPlayingAndAlive()
	if not tab or table.IsEmpty(tab) then
		tab = player.GetAll()
	end

	for _, ply in ipairs(tab) do
		local available = ents.FindByClass("nz_spawn_zombie_special")
		local pos = ply:GetPos()
		local spawns = {}

		if IsValid(available[1]) and !nzMapping.Settings.specialsuseplayers then
			for k,v in pairs(available) do
				if v.link == nil or nzDoors:IsLinkOpened( v.link ) then -- Only for rooms that are opened (using links)
					if v:IsSuitable() then -- And nothing is blocking it
						table.insert(spawns, v)
					end
				end
			end
			if !IsValid(spawns[1]) then -- Still no open linked ones?! Spawn at a random player spawnpoint
				local pspawns = ents.FindByClass("player_spawns")
				if !IsValid(pspawns[1]) then
					ply:ChatPrint("Couldnt Find Exit Location for QED Teleport")
				else
					pos = pspawns[math.random(#pspawns)]:GetPos()
				end
			else
				pos = spawns[math.random(#spawns)]:GetPos()
			end
		else -- There are no special spawnpoints - Use regular player spawns
			local pspawns = ents.FindByClass("player_spawns")
			if IsValid(pspawns[1]) then
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		end

		if IsValid(ply) then
			ply:ViewPunch(Angle(-5, math.Rand(-10, 10), 0))
			ply:SetPos(pos)
			ply:SetLocalVelocity(vector_origin)
			ply:EmitSound("TFA_BO3_QED.Teleport")
			ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.RandomPowerup = function(self)
	self:GetOwner():ChatPrint("QED Effect: Random Powerup")

	nzPowerUps:SpawnPowerUp(self:GetPos())

	self:DoCustomRemove(true, 2)
end

ENT.RandomWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Random Weapon")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "weapondrop")

	/*if GetConVar("nz_randombox_maplist"):GetBool() and nzMapping.Settings.rboxweps then
		local keys = table.GetKeys(nzMapping.Settings.rboxweps)
		local class = keys[math.random(#keys)]

		local weap = ents.Create("nz_bo3_drop_weapon")
		weap:SetGun(class)
		weap:SetPos(self:GetPos() + Vector(0,0,48))
		weap:Spawn()
	end*/

	self:DoCustomRemove(true, 2)
end

ENT.RandomPerk = function(self)
	self:GetOwner():ChatPrint("QED Effect: Random Perk")

	nzPowerUps:SpawnPowerUp(self:GetPos(), "bottle")

	self:DoCustomRemove(true, 2)
end

//////////////////////////////////////////////////////////////////////////
//---------------------------- Spin Gun --------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.SpinningMAXGL = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon MAX-GL")

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

	spingun:SetOwner(self:GetOwner())

	self:DoCustomRemove(true, 1)
end

ENT.SpinningKN44 = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon KN-44")

	local spingun = ents.Create("bo3_misc_spingun")
	spingun:SetModel("models/weapons/tfa_bo3/qed/w_kn44.mdl")
	spingun:SetPos(self:GetPos() + Vector(0,0,54))
	spingun:SetAngles(angle_zero)
	spingun:SetOwner(self:GetOwner())

	spingun.ShootSound = "TFA_BO3_QED.KN44.Fire"
	spingun.Damage = 900
	spingun.RPM = 500
	spingun.ClipSize = 30
	spingun.Spread = Vector(0.05, 0.05, 0)

	spingun:Spawn()

	spingun:SetOwner(self:GetOwner())

	self:DoCustomRemove(true, 1)
end

ENT.SpinningHaymaker = function(self)
	self:GetOwner():ChatPrint("QED Effect: Summon Haymaker-12")

	local spingun = ents.Create("bo3_misc_spingun")
	spingun:SetModel("models/weapons/tfa_bo3/qed/w_haymaker.mdl")
	spingun:SetPos(self:GetPos() + Vector(0,0,54))
	spingun:SetAngles(angle_zero)
	spingun:SetOwner(self:GetOwner())

	spingun.ShootSound = "TFA_BO3_QED.HMKR.Fire"
	spingun.NumShots = 8
	spingun.Damage = 400
	spingun.RPM = 500
	spingun.ClipSize = 30
	spingun.Spread = Vector(0.1, 0.1, 0)
	spingun.MuzzleType = 7

	spingun:Spawn()

	spingun:SetOwner(self:GetOwner())

	self:DoCustomRemove(true, 1)
end

ENT.SpinningRaygun = function(self)
	local ply = self:GetOwner()
	ply:ChatPrint("QED Effect: Summon Raygun")

	local raychance = math.random(3)
	local mdl1 = "models/weapons/tfa_bo3/raygun/w_raygun.mdl"
	local mdl2 = "models/weapons/tfa_bo3/mk2/w_mk2.mdl"
	local mdl3 = "models/weapons/tfa_bo3/mk3/w_mk3.mdl"
	local mk2 = raychance == 2
	local mk3 = raychance == 3

	local spingun = ents.Create("bo3_misc_spingun")
	spingun:SetModel((mk3 and mdl3) or (mk2 and mdl2) or mdl1)
	spingun:SetPos(self:GetPos() + Vector(0,0,54))
	spingun:SetAngles(angle_zero)
	spingun:SetOwner(ply)

	spingun.ShootSound = (mk3 and "TFA_BO3_MK3.Shoot") or (mk2 and "TFA_BO3_MK2.Shoot") or "TFA_BO3_RAYGUN.Shoot"
	spingun.NumShots = 1
	spingun.Damage = 2400
	spingun.RPM = 600
	spingun.ClipSize = 20
	spingun.MuzzleFlashEffect = (mk3 and "tfa_bo3_muzzleflash_mk3_qed") or (mk2 and "tfa_bo3_muzzleflash_raygunmk2_qed") or "tfa_bo3_muzzleflash_raygun_qed"

	spingun.Projectile = (mk3 and "bo3_ww_mk3") or (mk2 and "bo3_ww_mk2") or "bo3_ww_raygun"
	spingun.ProjectileVelocity = 3500
	spingun.ProjectileModel = "models/dav0r/hoverball.mdl"

	spingun:Spawn()

	spingun:SetOwner(ply)

	self:DoCustomRemove(true, 1)
end

//////////////////////////////////////////////////////////////////////////
//--------------------------- WW Effects -------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.ScavengerEffect = function(self)
	local ply = self:GetOwner()
	ply:ChatPrint("QED Effect: Scavenger Effect")

	local pap = math.random(3) == 1
	if pap then
		self:EmitSound("TFA_BO3_SCAVENGER.ExplodePaP")
		ParticleEffect("bo3_scavenger_explosion_2", self:GetPos(), angle_zero)
	else
		self:EmitSound("TFA_BO3_SCAVENGER.Explode")
		ParticleEffect("bo3_scavenger_explosion", self:GetPos(), angle_zero)
	end

	util.ScreenShake(self:GetPos(), 20, 5, 1, 500)

	local damage = DamageInfo()
	damage:SetDamage(pap and 24000 or 11500)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_ALWAYSGIB))

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsPlayer() and v ~= ply then continue end

			if v:IsPlayer() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/250, 0, 1)
				damage:SetDamage(200 * distfac)
			end

			damage:SetDamagePosition(v:WorldSpaceCenter())
			damage:SetDamageForce(v:GetUp()*20000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

			if v.NZBossType or v.IsMooBossZombie then
				damage:SetDamage(math.max(2000, v:GetMaxHealth()/6))
			end

			v:TakeDamageInfo(damage)

			damage:SetDamage(pap and 24000 or 11500)
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
	waff.ZapRange = 600
	waff.Decay = 45

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

	self:DoCustomRemove(false, 2)
end

ENT.WavegunEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Wavegun Effect")

	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
		if (v:IsNPC() or v:IsNextBot()) and not v:BO3IsCooking() then
			v:BO3Microwave(3, self:GetOwner(), self.Inflictor)
		end
	end

	self:EmitSound("TFA_BO3_ZAPGUN.Flux")

	self:DoCustomRemove(true, 4)
end

ENT.ShrinkrayEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Shrinkray Effect")

	self:EmitSound("TFA_BO3_JGB.Flux")

	ParticleEffect("bo3_jgb_impact", self:GetPos(), angle_zero)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if (v:IsNPC() or v:IsNextBot()) and not v:BO3IsShrunk() then
			v:BO3Shrink(15, false)
		end
	end

	self:DoCustomRemove(false, 2)
end

ENT.MonkeybombEffect = function(self)
	self:GetOwner():ChatPrint("QED Effect: Monkeybomb Effect")

	self:EmitSound("TFA_BO3_QED.Flare")

	ParticleEffectAttach("bo3_qed_flare", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	UpdateAllZombieTargets(self)

	self:CallOnRemove("nz.QED.Flare", function(self)
		self:EmitSound("TFA_BO3_GENERIC.Lightning.Close")
		self:EmitSound("TFA_BO3_GENERIC.Lightning.Flash")
		self:EmitSound("TFA_BO3_GENERIC.Lightning.Snap")
		ParticleEffect("driese_tp_arrival_phase2", self:WorldSpaceCenter(), angle_zero)

		if SERVER then
			local damage = DamageInfo()
			damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageForce(Vector(0,0,1000))
			damage:SetDamageType(DMG_SHOCK)

			for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
				if v:IsValidZombie() then
					if v:Health() <= 0 then continue end

					damage:SetDamagePosition(v:WorldSpaceCenter())
					damage:SetDamage(v:Health() + 666)

					ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, v, 2)
					if v:OnGround() then
						ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, v, 0)
					end

					v:EmitSound("TFA_BO3_WAFFE.Sizzle")
					v:EmitSound("TFA_BO3_WAFFE.Zap")
					
					if v.NZBossType or v.IsMooBossZombie then
						damage:SetDamage(math.max(3000, v:GetMaxHealth() / 6))
					end

					v:TakeDamageInfo(damage)
				end
			end
		end

		util.ScreenShake(self:GetPos(), 20, 255, 1.5, 500)
	end)

	self.DontDelete = true
	SafeRemoveEntityDelayed(8)
end

//////////////////////////////////////////////////////////////////////////
//-------------------------- Anti Powerups -----------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.AntiMaxAmmo = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-MaxAmmo")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "maxammo")

	self:DoCustomRemove(true, 3)
end

ENT.AntiInstakill = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-Instakill")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "insta")

	self:DoCustomRemove(true, 3)
end

ENT.AntiPerkbottle = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-PerkBottle")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "bottle")

	self:DoCustomRemove(true, 3)
end

ENT.AntiFiresale = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-Firesale")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "firesale")

	self:DoCustomRemove(true, 3)
end

ENT.AntiZombieCash = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-ZombieCash")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "bonuspoints")

	self:DoCustomRemove(true, 3)
end

ENT.AntiDoublePoints = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-DoublePoints")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "dp")

	self:DoCustomRemove(true, 3)
end

ENT.AntiCarpenter = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-Carpenter")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "carpenter")

	self:DoCustomRemove(true, 3)
end

ENT.AntiNuke = function(self)
	self:GetOwner():ChatPrint("QED Effect: Anti-Nuke")

	nzPowerUps:SpawnAntiPowerUp(self:GetPos(), "nuke")

	self:DoCustomRemove(true, 3)
end

//////////////////////////////////////////////////////////////////////////
//------------------------------ Misc ----------------------------------//
//////////////////////////////////////////////////////////////////////////

ENT.UpgradeWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Upgrade all Player's Held Weapon")

	local tab = player.GetAllPlaying()
	if not tab or table.IsEmpty(tab) then
		tab = player.GetAll()
	end

	for _, ply in ipairs(tab) do
		local wep = ply:GetActiveWeapon()
		if wep.NZSpecialCategory and !wep.OnPaP then
			for k, v in pairs(ply:GetWeapons()) do
				if v:GetNWInt("SwitchSlot", 0) > 0 and not v:HasNZModifier("pap") then
					wep = v
					break
				end
			end
		end

		if not IsValid(wep) then continue end
		local repap = wep.Ispackapunched

		ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)

		if nzWeps.Updated then
			if wep.NZPaPReplacement then
				local wep2 = ply:Give(wep.NZPaPReplacement)
				wep2:ApplyNZModifier("pap")
				ply:SelectWeapon(wep2:GetClass())
				ply:StripWeapon(wep:GetClass())
			elseif wep.OnPaP then
				if wep:HasNZModifier("pap") then
					wep:ApplyNZModifier("repap")
				else
					wep:ApplyNZModifier("pap")
				end

				wep:ResetFirstDeploy()
				wep:CallOnClient("ResetFirstDeploy", "")
				wep:Deploy()
				wep:CallOnClient("Deploy", "")
			end
		else
			if wep.NZPaPReplacement then
				ply:StripWeapon(wep:GetClass())
				local wep2 = ply:Give(wep.NZPaPReplacement)
				ply:SelectWeapon(wep2)
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end

					wep2:ApplyNZModifier("pap")
				end)
			elseif wep.OnPaP then
				ply:StripWeapon(wep:GetClass())
				local wep2 = ply:Give(wep:GetClass())
				ply:SelectWeapon(wep2)
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end

					wep2:ApplyNZModifier("pap")
				end)
			end
		end
	end

	net.Start("TFA.BO3.QED_SND")
	net.WriteString("WeaponGive")
	net.Broadcast()

	self:DoCustomRemove(true, 2)
end

ENT.DowngradeWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Downgrade Random Player's Weapon")

	local ply = self:GetOwner()
	local tab = player.GetAllPlayingAndAlive()
	for k, v in RandomPairs(tab) do
		if not IsValid(v) then continue end

		local gun = v:GetActiveWeapon()
		if IsValid(gun) and gun:HasNZModifier("pap") then
			ply = v
			break
		end
	end

	local wep = ply:GetActiveWeapon()
	if not wep:HasNZModifier("pap") then return end

	ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)

	timer.Simple(0, function()
		if not IsValid(ply) or not IsValid(wep) then return end
		ply:StripWeapon(wep:GetClass())
		ply:Give(wep:GetClass())
	end)

	nzSounds:PlayEnt("Laugh", ply)

	self:DoCustomRemove(true, 3)
end

ENT.DownPlayer = function(self)
	local ply = self:GetOwner()
	ply:ChatPrint("QED Effect: Down Random Player")

	local tab = player.GetAllPlayingAndAlive()
	if tab and not table.IsEmpty(tab) then
		ply = table.Random(tab)
	end

	ply:DownPlayer()
	ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)
	nzSounds:PlayEnt("Laugh", ply)

	self:DoCustomRemove(true, 3)
end

ENT.TakeWeapon = function(self)
	self:GetOwner():ChatPrint("QED Effect: Take Player's Weapon")

	local ply = self:GetOwner()
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		ply:Give("tfa_bo3_wepsteal")
		ply:SelectWeapon("tfa_bo3_wepsteal")

		nzSounds:PlayEnt("Bye", ply)
	end

	self:DoCustomRemove(true, 3)
end

local function FindNearestSpawner(pos)
	local nearbyents = {}
	for k, v in pairs(ents.FindByClass("nz_spawn_zombie_normal")) do
		if v.GetSpawner and v:GetSpawner() and v:IsSuitable() then
			table.insert(nearbyents, v)
		end
	end

	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
	return nearbyents[1]
end

ENT.SpawnZombies = function(self)
	self:GetOwner():ChatPrint("QED Effect: Spawn Horde of Zombies")

	local numspawn = nzMapping.Settings.startingspawns
	if not numspawn or numspawn <= 0 then
		numspawn = 24
	end

	for i=1, numspawn do
		local zspawn = FindNearestSpawner(self:GetPos())

		if nzRound:InState(ROUND_PROG) and IsValid(zspawn) then
			if zspawn:IsSuitable() then
				local class = nzMisc.WeightedRandom(zspawn:GetZombieData(), "chance")
				local zombie = ents.Create(class)
				zombie:SetPos(zspawn:GetPos())
				zombie:SetAngles(zspawn:GetAngles())
				zombie:Spawn()

				zombie:SetSpawner(zspawn:GetSpawner())
				zombie:Activate()

				hook.Call("OnZombieSpawned", nzEnemies, zombie, zspawn)

				if nzRound:IsSpecial() then
					local data = nzRound:GetSpecialRoundData()
					if data and data.spawnfunc then
						data.spawnfunc(zombie)
					end
				end
			end

			//zspawn:SetNextSpawn(CurTime() + zspawn:GetSpawner():GetDelay() * 2)
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.SpawnBoss = function(self)
	self:GetOwner():ChatPrint("QED Effect: Spawn Boss Zombie")

	nzRound:SpawnBoss(nzMapping.Settings.bosstype)

	self:DoCustomRemove(true, 3)
end

ENT.RevivePlayers = function(self)
	self:GetOwner():ChatPrint("QED Effect: Revive Downed Players")

	local tab = player.GetAllPlaying()
	if not tab or table.IsEmpty(tab) then
		tab = player.GetAll()
	end

	for _, ply in ipairs(tab) do
		if !ply:GetNotDowned() then
			ply:RevivePlayer()
		end
	end

	self:DoCustomRemove(true, 2)
end

ENT.PerkMachine = function(self, perk)
	self:GetOwner():ChatPrint("QED Effect: Give All Players ".. perk:GetPerkID())

	local tab = player.GetAllPlaying()
	if not tab or table.IsEmpty(tab) then
		tab = player.GetAll()
	end

	local id = perk:GetPerkID()
	if not id then return end

	local data = nzPerks:Get(id)
	if not data then return end

	if id == "pap" then
		self:UpgradeWeapon()
	elseif !data.specialmachine then
		for _, ply in ipairs(tab) do
			if not ply:HasPerk(id) then
				ply:GivePerk(id)
			end
		end
	end

	self:DoCustomRemove(true, 2)
end

ENT.GerschPowerup = function(self)
	self:GetOwner():ChatPrint("QED Effect: Gersh Device Powerup Drop")

	local weap = ents.Create("nz_bo3_drop_weapon")
	weap:SetGun("tfa_bo3_gersch")
	weap:SetPos(self:GetPos() + Vector(0,0,48))
	weap:Spawn()

	self:DoCustomRemove(true, 2)
end

ENT.QEDPowerup = function(self)
	self:GetOwner():ChatPrint("QED Effect: Q.E.D Powerup Drop")

	local weap = ents.Create("nz_bo3_drop_weapon")
	weap:SetGun("tfa_bo3_qed")
	weap:SetPos(self:GetPos() + Vector(0,0,48))
	weap:Spawn()

	self:DoCustomRemove(true, 2)
end

ENT.Door = function(self, data)
	local ply = self:GetOwner()
	ply:ChatPrint("QED Effect: Open a Random Door")

	local tab = ents.FindInSphere(self:GetPos(), 2048)
	for k, v in RandomPairs(tab) do
		local data = v:GetDoorData()
		if data then
			local datalink = data.link
			if datalink then
				nzDoors:OpenLinkedDoors(datalink, ply)
				ParticleEffect("bo3_qed_explode_1", v:GetPos(), angle_zero)
				print("saved ya "..string.Comma(data.price).." points")
			end
			break
		end
	end

	self:DoCustomRemove(true, 1)
end

ENT.CloseBox = function(self, box)
	self:GetOwner():ChatPrint("QED Effect: Close the box")

	if not IsValid(box) then
		self:DoCustomRemove(true, 3)
	return end

	box:Close()

	for _, ent in pairs(ents.FindByClass("random_box_windup")) do
		if IsValid(ent) and ent.Box and (ent.Box == box) then
			if ent.GetWinding and ent:GetWinding() then
				print("//////////////////////////////////////////////////////")
				print("If the weapon windup errors, it can be safely ingnored")
				print("//////////////////////////////////////////////////////")
			end

			ent:Remove()
			break
		end
	end

	self:DoCustomRemove(true, 3)
end

ENT.COTDSprinter = function(self)
	local ply = self:GetOwner()
	if nzRound:IsSpecial() then
		ply:ChatPrint("QED Effect: Nothing!")
		self:DoCustomRemove(true, 2)
		return
	end

	ply:ChatPrint("QED Effect: Zombies Become Super-Sprinters")

	for k, v in nzLevel.GetZombieArray() do
		if not IsValid(v) then continue end
		if v:IsValidZombie() and !(v.NZBossType or v.IsMooBossZombie) and (!v.IsMooSpecial or v.IsMooSpecial and !v.MooSpecialZombie) and v:Alive() then
			v:SetRunSpeed(200)
			v:SpeedChanged()
			v:Retarget()
		end
	end

	self:DoCustomRemove(true, 3)
end

local function GetClearPaths(ent, pos, tiles)
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

local function GetSurroundingTiles(ent, pos)
	local tiles = {}
	local x, y, z
	local minBound, maxBound = ent:OBBMins(), ent:OBBMaxs()
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

function ENT:FindSpotNearPlayer(ent, pos, accuracy, range, stepd, stepu)
	local targ = ent:GetTarget()

	pos = pos or targ:GetPos()
	range = range or 100
	stepd = stepd or 25
	stepu = stepu or 25
	accuracy = accuracy or 6

	local posOG = pos
	local failed = true
	local navfailed = true

	if navmesh.IsLoaded() then
		local tab = navmesh.Find(pos, range, stepd, stepu)
		local postab = {}

		for i=1, accuracy do
			for _, nav in RandomPairs(tab) do
				if IsValid(nav) and not nav:IsUnderwater() then
					local testpos = nav:GetRandomPoint()
					if testpos:DistToSqr(pos) > 256 then
						table.insert(postab, testpos)
						break
					end
				end
			end
		end

		if not table.IsEmpty(postab) then
			table.sort(postab, function(a, b) return a:DistToSqr(pos) < b:DistToSqr(pos) end)
			pos = postab[1]
		else
			navfailed = true
		end
	end

	local minBound, maxBound = ent:OBBMins(), ent:OBBMaxs()
	if not ent:CollisionBoxClear( ent, pos, minBound, maxBound ) then
		local surroundingTiles = GetSurroundingTiles( ent, pos )
		local clearPaths = GetClearPaths( ent, pos, surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if ent:CollisionBoxClear( ent, tile, minBound, maxBound ) and tile:DistToSqr(posOG) > 256 then
				pos = tile
				failed = false
				break
			end
		end
	else
		if pos ~= posOG then
			failed = false
		end
	end

	return pos + vector_up, failed or navfailed
end

ENT.ZombieTeleport = function(self)
	local ply = self:GetOwner()

	if not nzLevel or not IsValid(nzLevel.ZombieCache[1]) then
		ply:ChatPrint("QED Effect: Nothing!")
		self:DoCustomRemove(true, 1)
	return end

	for k, ent in nzLevel.GetZombieArray() do
		if not (IsValid(ent) and ent:IsValidZombie() and ent.IsMooZombie and IsValid(ent:GetTarget()) and ent:Alive() and !ent:GetSpecialAnimation() and !ent:GetBlockAttack()) then continue end

		local pos, success = self:FindSpotNearPlayer(ent, ply:GetPos(), 6, 82, 24, 24)
		if not success then
			ply:ChatPrint("QED Effect: Nothing!")
			break
		end

		ply:ChatPrint("QED Effect: Teleport Random Zombie to Player")

		ent:SetPos(pos)
		if IsValid(ent:GetPhysicsObject()) then
			ent:GetPhysicsObject():SetPos(pos)
		end
		ent.loco:FaceTowards(ply:GetPos())

		if ent.TempBehaveThread then
			timer.Simple(engine.TickInterval(), function()
				ent:SetPos(pos)
				ent.loco:FaceTowards(ply:GetPos())

				sound.Play("weapons/tfa_bo3/qed/teleports.wav", pos, SNDLVL_TALKING, math.random(97,103), 1)
				ParticleEffect("bo3_qed_explode_1", pos, angle_zero)

				ent.HeavyAttack = true
				ent:TempBehaveThread(function(ent)
					ent:Attack()
				end)
			end)
		end

		break
	end

	self:DoCustomRemove(true, 3)
end

function ENT:OnRemove()
	self:StopParticles()
end
