ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Doom Imp Fireball"
ENT.Author = "Wavy"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl") -- Change later
		ParticleEffectAttach("doom_de_imp_fireball",PATTACH_ABSORIGIN_FOLLOW,self,0)
		ParticleEffectAttach("doom_mancu_blast",PATTACH_ABSORIGIN,self,0)
		self:PhysicsInit(SOLID_OBB)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)
		self:SetMoveType(MOVETYPE_FLY)

		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 1200)
	self:SetAngles((dir*-1):Angle())
end

function ENT:StartTouch(ent)
	if !ent:IsPlayer() and ent.IsMooZombie then return end

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 60)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_BLAST)
            expdamage:SetAttacker(self)
            expdamage:SetDamage(40)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
            end
        end

		ParticleEffect("doom_de_imp_fireballexplosion",self:GetPos(),angle_zero,nil)
		self:EmitSound("wavy_zombie/doom/imp/imp_fireball_impact_"..math.random(1,3)..".ogg", 400)

		self:Remove()
	end
end

function ENT:Think()
end
