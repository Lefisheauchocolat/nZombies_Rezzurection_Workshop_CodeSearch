AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Bouncing Betty"

--[Sounds]--
ENT.BounceSound = "TFA_WAW_BBETTY.Plant"

--[Parameters]--
ENT.Exploded = false
ENT.Impacted = false
ENT.HasJumped = false
ENT.Range = 250
ENT.HP = 55

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Impacted")
end

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer() == self:GetOwner() and self:GetImpacted() then
		local num = render.GetBlend()

		render.SuppressEngineLighting(false)
		render.MaterialOverride(Material("models/weapons/tfa_waw/bbetty/mtl_weapon_bbetty_mine_glow"))
		render.SetBlend(0.1)
		self:DrawModel()
		render.SetBlend(num)
		render.MaterialOverride(nil)
		render.SuppressEngineLighting(false)
	end
end

function ENT:PhysicsCollide(data, phys)
	self:EmitSound(self.BounceSound)
	phys:EnableMotion(false)
	phys:Sleep()

	self:SetImpacted(true)
	sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)

	local ang = self:GetAngles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetAngles(self.DesiredAng or ang)
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	//self:PhysicsInitSphere(0.1, "metal_bouncy")
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)
	self.RangeSqr = self.Range*self.Range

	self:NextThink(CurTime())

	if CLIENT then return end
	self:OverflowCheck()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local max_bbettys = GetConVar("sv_tfa_miscww_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activebbettys then ply.activebbettys = {} end
	table.insert(ply.activebbettys, self)

	if #ply.activebbettys > max_bbettys:GetInt() then
		for k, v in pairs(ply.activebbettys) do
			if not IsValid(v) then continue end
			if v == self then continue end
			v:Jump()
			break
		end
	end
end

function ENT:Think()
	if SERVER and self:GetImpacted() and self:GetCreationTime() + 0.5 < CurTime() then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 40)) do
			if v == self:GetOwner() then continue end
			if v:IsNPC() or v:IsNextBot() then
				if v:IsNPC() then
					if v:Disposition((IsValid(self:GetOwner()) and self:GetOwner() or self)) ~= 3 then
						self:Jump()
					end
				else
					self:Jump()
				end
			elseif v:IsPlayer() then
				if self:FriendCheck(v) then continue end
				self:Jump()
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FriendCheck(ent)
	local ply = self:GetOwner()
	if DLib and ent:IsPlayer() and IsValid(ply) and ply:IsPlayer() and ply:IsDLibFriend(ent) then
		return true 
	end
	return false
end

function ENT:Use(activator, caller)
	if CLIENT then return end
	if IsValid(activator) and activator == self:GetOwner() then
		activator:Give("tfa_waw_bbetty", true)
		activator:GiveAmmo(1, "slam", false)
		self:Remove()
	end
end

function ENT:OnTakeDamage(dmg)
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self.Exploded then return end
	if dmg:IsExplosionDamage() then dmg:SetMaxDamage(math.Rand(10,20)) end
	if self.HP > 0 and self.HP - dmg:GetMaxDamage() <= 0 then
		self:Jump()
		self.Exploded = true
	end
	self.HP = self.HP - dmg:GetMaxDamage()
	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
end

function ENT:Jump()
	if not SERVER then return end
	if self.HasJumped then return end
	self.HasJumped = true

	self:EmitSound("TFA_WAW_BBETTY.Trigger")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(true)
		phys:Wake()
		phys:ApplyForceCenter(vector_up*4200)
	end

	timer.Simple(0.5, function() --im stupid so im using a timer
		if not self:IsValid() then return end
		self:Explode()
	end)
end

function ENT:DoExplosionEffect()
	local tr = util.QuickTrace(self:GetPos(), Vector(0,0,-64), self)
	util.Decal("Scorch", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", fx)
	util.Effect("Explosion", fx)
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_BLAST)

	self.Damage = self.mydamage or self.Damage
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if not pvp_bool:GetBool() and v:IsPlayer() and v ~= ply then continue end
		if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

		local own = v:GetOwner()
		if IsValid(own) and (own == ply or (nzombies and own:IsPlayer())) then continue end

		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end

		local dist = self:GetPos():DistToSqr(tr.endpos)
		dist = math.Remap(1 - math.Clamp(dist/self.RangeSqr, 0, 1), 0, 1, 0.5, 1)

		damage:SetDamage(self.Damage * dist)
		damage:SetDamagePosition(tr1.Entity == v and tr1.HitPos or tr.endpos)

		if v == ply then
			damage:SetDamage(90 * dist)
		end

		if v:IsPlayer() and v:Crouching() then
			damage:ScaleDamage(0.5)
		end

		damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized()*10000)

		v:TakeDamageInfo(damage)

		damage:SetDamage(self.Damage)
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply.activebbettys and table.HasValue(ply.activebbettys, self) then
			table.RemoveByValue(ply.activebbettys, self)
		end
	end
end