AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Animal Trap"

--[Sounds]--
ENT.AttackSound = "TFA_BO2_BEARTRAP.Snap"
ENT.MortarSound = "TFA_BO2_BEARTRAP.Mortar"
ENT.MolotovSound = "TFA_BO2_MOLOTOV.Explode"

--[Parameters]--
ENT.TrapTime = 5
ENT.Delay = 1
ENT.HP = 180

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Mortar" )
	self:NetworkVar( "Bool", 1, "Molotov" )
	self:NetworkVar( "Bool", 2, "Deactivated" )
	self:NetworkVar( "Bool", 3, "Trapped" )
end

function ENT:PhysicsCollide(data, phys)
	phys:EnableMotion(false)
	phys:Sleep()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:NextThink(CurTime())
	
	if SERVER then
		self:SetHealth(self.HP)
		self:SetMaxHealth(self.HP)

		self:SetTrigger(true)
		self:SetUseType(SIMPLE_USE)
		if self:GetOwner():IsNPC() then
			local chance = math.random(9)
			/*if chance == 2 then
				self:SetBodygroup(1, 1)
				self:SetMortar(true)
			end*/
			if chance == 1 then
				self:SetBodygroup(2, 1)
				self:SetMolotov(true)
			end
		end
	end
end

function ENT:InflictDamage(ent)
	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end
	self.Damage = self.mydamage or self.Damage
	damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(self.Inflictor)
	damage:SetDamageType(DMG_SLASH)
	ent:TakeDamageInfo(damage)
	
	local jitter = VectorRand() * 25
	jitter.z = 20

	local qtr = util.QuickTrace(self:GetPos() + jitter, Vector(0,0,-256), self)
	util.Decal("Blood", qtr.HitPos - qtr.HitNormal, qtr.HitPos + qtr.HitNormal)
end

function ENT:TrapPlayer(ply)
	if ply:IsPlayer() then
		self:InflictDamage(ply)
		
		ply.Old_RunSpeed = ply:GetRunSpeed()
		ply.Old_WalkSpeed = ply:GetWalkSpeed()
		ply.Old_JumpPower = ply:GetJumpPower()
		ply:SetJumpPower(0)
		ply:SetRunSpeed(1)
		ply:SetWalkSpeed(1)

		self:Trigger()
		self:Reset()
		
		timer.Simple(self.TrapTime,function()
			if IsValid(ply) then
				ply:SetJumpPower(ply.Old_JumpPower)
				ply:SetRunSpeed(ply.Old_RunSpeed)
				ply:SetWalkSpeed(ply.Old_WalkSpeed)
			end
		end)
	end
end

function ENT:TrapNextBot(bot)
	if bot:IsNextBot() then
		self:InflictDamage(bot)
		
		self:Trigger()
		self:Reset()

		bot.Old_Accel = bot.loco:GetAcceleration()
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		timer.Simple(self.TrapTime,function()
			if IsValid(bot) then
				bot.loco:SetAcceleration(bot.Old_Accel)
				bot.loco:SetDesiredSpeed(bot.Old_Accel)
			end
		end)
	end
end

function ENT:TrapNPC(npc)
	if npc:IsNPC() then
		self:InflictDamage(npc)
		
		npc:StopMoving()
		npc:SetSchedule(SCHED_WAIT_FOR_SCRIPT)
		
		self:Trigger()
		self:Reset()
		
		timer.Simple(self.TrapTime,function()
			if IsValid(npc) then 
				npc:SetSchedule(68)
			end 
		end)
	end
end

function ENT:Reset()
	timer.Simple(self.TrapTime,function()
		if self:IsValid() and not self:GetDeactivated() then
			self:SetTrapped(false)
			self:SetSequence("idle_open")
		end
	end)
end

function ENT:FriendCheck(ent)
	if DLib then
		if ent:IsPlayer() and self:GetOwner():IsValid() and self:GetOwner():IsPlayer() then
			if self:GetOwner():IsDLibFriend(ent) then 
				return true 
			end
		end
	end
	return false
end

function ENT:StartTouch(ent)
	if self:GetDeactivated() then return end
	if self:FriendCheck(ent) then return end
	if ent ~= self:GetOwner() and not self:GetTrapped() then
		if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
			self:MortarCheck()
			self:TrapPlayer(ent)
			self:TrapNextBot(ent)
			self:TrapNPC(ent)
		end
	end
end

function ENT:Think()

	self:NextThink(CurTime())
	return true
end

function ENT:OnTakeDamage(dmg)
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self:GetDeactivated() then return end
	if dmg:IsExplosionDamage() then return end

	if self:Health() > 0 and math.floor(self:Health() - dmg:GetDamage()) <= 0 then
		self:Trigger()
		self:MortarCheck()
		self:SetDeactivated(true)
	end

	self:SetHealth(self:Health() - dmg:GetDamage())

	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
end

function ENT:Trigger()
	self:EmitSound(self.AttackSound)
	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetNormal(self:GetUp():GetNormalized()*15)
	fx:SetMagnitude(2)
	fx:SetScale(2)
	
	util.Effect("ElectricSpark", fx)
	self:SetTrapped(true)
	self:SetSequence("idle_closed")
end

function ENT:MortarCheck()
	if self:GetMortar() then
		self:MortarExplode()
		self:SetBodygroup(1, 0)
		self:SetMortar(false)
	end
	if self:GetMolotov() then
		self:MolotovExplode()
		self:SetBodygroup(2, 0)
		self:SetMolotov(false)
	end
end

function ENT:Use(act, call)
	if CLIENT then return end
	if not IsValid(act) then return end
	if act == self:GetOwner() and not self:GetDeactivated() then
		if not self:GetMortar() and not self:GetMolotov() then
			if act:GetActiveWeapon():GetClass() == ("tfa_bo2_mortar") then
				self:SetBodygroup(1, 1)
				self:SetMortar(true)
				self:EmitSound(self.MortarSound)
				if act:GetAmmoCount("grenade") > 0 then
					act:RemoveAmmo(1, "grenade", false)
				else
					act:StripWeapon("tfa_bo2_mortar")
				end
				return
			end

			if act:GetActiveWeapon():GetClass() == ("tfa_bo2_molotov")then
				self:SetBodygroup(2, 1)
				self:SetMolotov(true)
				self:EmitSound(self.MortarSound)
				if act:GetAmmoCount("grenade") > 0 then
					act:RemoveAmmo(1, "grenade", false)
				else
					act:StripWeapon("tfa_bo2_molotov")
				end
				return
			end
		end

		if not self:GetMortar() and not self:GetMolotov() then
			act:Give("tfa_bo2_beartrap", true)
			act:GiveAmmo(1, "slam", false)
			self:Remove()
		end
	elseif self:GetDeactivated() then
		act:Give("tfa_bo2_beartrap", true)
		act:GiveAmmo(1, "slam", false)
		self:Remove()
	end
end

function ENT:MortarExplode()
	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end

	self.Damage = self.mydamage or self.Damage
	local dmg = DamageInfo()
	dmg:SetInflictor(self.Inflictor)
	dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	dmg:SetDamage(self.Damage * 5)
	dmg:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	util.BlastDamageInfo(dmg, self:GetPos(), 200)
	util.ScreenShake(self:GetPos(), 10, 255, 1.5, 450)

	self:DoExplosionEffect()
end

function ENT:MolotovExplode()
	local ent = ents.Create("bo1_molotov")
	ent:SetPos(self:GetPos() + vector_up)
	ent:SetAngles(angle_zero)
	ent:SetOwner(self:GetOwner())
	ent.Inflictor = self.Inflictor

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	ent:SetVelocity(vector_up*-500)
	if IsValid(phys) then
		phys:SetVelocity(vector_up*-500)
	end
end
