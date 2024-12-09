ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Explosive Barrel"
ENT.Author = "Wavy"

ENT.Spawnable = false
ENT.AdminSpawnable = false

DEFINE_BASECLASS(ENT.Base)

if SERVER then
	AddCSLuaFile()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/wavy_ports/waw/explosive_barrel.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE_DEBRIS )
		self:SetHealth( 666 )
		self:SetMaxHealth( 666 )
		self:DrawShadow( false )
		
		self.OnFire = false
		self.Destroyed = false
		self.ExplodeTimer = 0
		self.VanishTimer = 0 -- not implemented, ideally used to make the barrel visually dissapear (and maybe reappear later...)
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local maxhp = self:GetMaxHealth()
	if not IsValid(attacker) then return end
	
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	
	if self:Health() <= (maxhp / 3) and !self.OnFire and !self.Destroyed then
		print("im on fire")
		self.OnFire = true
		self:Ignite(30)
		self.ExplodeTimer = CurTime() + math.Rand(3,7)
	end
	
	if self:Health() <= 0 and !self.Destroyed then
		self.Destroyed = true
		self:Explode(self:GetPos())
	end
	
end

function ENT:Explode(pos)

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }
		
		if not IsValid(self.Inflictor) then
			self.Inflictor = self
		end
		
        local expdamage = DamageInfo()
		expdamage:SetDamageType(DMG_BLAST)
        expdamage:SetAttacker(self)
		expdamage:SetInflictor(self.Inflictor)
		expdamage:SetDamage(100)

        for k, v in pairs(ents.FindInSphere(pos, 200)) do

			if not v:IsWorld() and v:IsSolid() then
				tr.endpos = v:WorldSpaceCenter()
				local tr1 = util.TraceLine(tr)
				if tr1.HitWorld then continue end
			
				if v:IsPlayer() then
					expdamage:SetDamage(100)
				end

				if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
					expdamage:SetDamage(v:GetMaxHealth() / 4)
				elseif v:IsValidZombie() then
					v:SetHealth(1)
					expdamage:SetDamageType(DMG_MISSILEDEFENSE)
				end

				expdamage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

				v:TakeDamageInfo(expdamage)

				local effectdata = EffectData()
				effectdata:SetOrigin(self:GetPos())

				util.Effect("HelicopterMegaBomb", effectdata)
				util.Effect("Explosion", effectdata)
				util.ScreenShake(self:GetPos(), 20, 255, 1, 350)

			end
		end	
	end	
	self:IHaveExploded()
end

function ENT:IHaveExploded()
	print("i exploded")
	--self.Destroyed = true
	if self.OnFire then self.OnFire = false end
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self:SetBodygroup( 0,1 )
	
	--[[if self:IsOnFire() then
		self:Extinguish()
	end]]

end


function ENT:Think()

	if SERVER then
		if IsValid(self) and self.OnFire and !self.Destroyed then
			if CurTime() > self.ExplodeTimer then
				self.Destroyed = true
				self:Explode(self:GetPos())
			end
		end
	end
end