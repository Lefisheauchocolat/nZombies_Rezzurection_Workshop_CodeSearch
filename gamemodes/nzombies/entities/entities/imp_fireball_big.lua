ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Doom Imp Big Fireball"
ENT.Author = "Wavy"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Delay = 2.5
ENT.MoveSpeed = 800
ENT.CurveStrengthMin = 0
ENT.CurveStrengthMax = 0

DEFINE_BASECLASS( ENT.Base )

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Victim")
end

if SERVER then
	AddCSLuaFile()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self,...)
	
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl") -- Change later
	ParticleEffectAttach("doom_de_imp_bigfireball",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffectAttach("doom_mancu_blast",PATTACH_ABSORIGIN,self,0)
	self:PhysicsInit(SOLID_OBB)
	self:SetSolid(SOLID_VPHYSICS)
	--self:SetTrigger(true)
	--self:UseTriggerBounds(true, 0)
	--self:SetMoveType(MOVETYPE_FLY)

	local phys = self:GetPhysicsObject()

    if IsValid(phys) then
        phys:EnableDrag(false)
        phys:EnableGravity(false)
    end
	
    self.killtime = CurTime() + self.Delay

    if CLIENT then return end
end

--[[function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 900)
	self:SetAngles((dir*-1):Angle())
end]]

function ENT:PhysicsCollide(data, phys)
    if data.HitEntity.IsMooZombie then return end
    if self:GetNW2Bool("Impacted") then return end

    self:Explode()
    self:SetNW2Bool("Impacted", true)
end

function ENT:Explode()
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
            expdamage:SetDamage(80)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
            end
        end

		ParticleEffect("doom_de_imp_bigfireballexplosion",self:GetPos(),angle_zero,nil)
		self:EmitSound("wavy_zombie/doom/imp/imp_fireball_special_impact_"..math.random(1,3)..".ogg", 400)

		self:Remove()
	end
end

--[[function ENT:StartTouch(ent)
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
            expdamage:SetDamage(80)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
            end
        end

		ParticleEffect("doom_de_imp_bigfireballexplosion",self:GetPos(),angle_zero,nil)
		self:EmitSound("wavy_zombie/doom/imp/imp_fireball_special_impact_"..math.random(1,3)..".ogg", 400)

		self:Remove()
	end
end]]

function ENT:Think()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocity(self:GetForward() * self.MoveSpeed)
        phys:AddAngleVelocity(VectorRand() * (math.sin(CurTime() * 30))* math.random(self.CurveStrengthMin, self.CurveStrengthMax))
        self:SetAngles(phys:GetVelocity():Angle())
    end

    if SERVER then
        local ply = self:GetVictim()

        if IsValid(ply) and ply:Health() > 0 then
            local tang = (((ply:GetShootPos() - Vector(0,0,7) + ply:GetVelocity() * math.Clamp(ply:GetVelocity():Length2D(),0,0.5)) - self:GetPos()):GetNormalized())
            local finalang = LerpAngle(0.025, self:GetAngles(), tang:Angle())
            self:SetAngles(finalang)
        end

        if self.killtime < CurTime() then
            self:Explode()
            return false
        end
    end

    self:NextThink(CurTime())
    return true
end
