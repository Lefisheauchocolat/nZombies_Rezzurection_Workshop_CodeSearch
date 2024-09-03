ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Evil Energy Mine"
ENT.Author = "GhostlyMoo"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
    AddCSLuaFile()
end

ENT.PulseChargeSounds = {
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_00.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_01.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_02.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_03.mp3"),
}

ENT.PulsePopChargeSounds = {
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_00.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_01.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_02.mp3"),
    Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_03.mp3"),
}

function ENT:Initialize()
    if SERVER then 
        self:SetModel("models/dav0r/hoverball.mdl")
        self:SetNoDraw(true)
        ParticleEffectAttach("zmb_trickster_mine",PATTACH_ABSORIGIN_FOLLOW,self,0)
        
        self:PhysicsInit(SOLID_OBB)
        self:SetSolid(SOLID_NONE)
        self:SetTrigger(false)
        self:UseTriggerBounds(false, 0)
        self:SetMoveType(MOVETYPE_FLY)

        phys = self:GetPhysicsObject()

        self.NextPulse = 0
        self.Lifetime = CurTime() + 1.15

        if phys and phys:IsValid() then
            phys:Wake()
        end

        self:EmitSound(self.PulseChargeSounds[math.random(#self.PulseChargeSounds)], 85)
    end
end

function ENT:Launch(dir)
    self:SetLocalVelocity(dir * 950)
    self:SetAngles((dir*-1):Angle())
end

--[[function ENT:StartTouch(ent)
    if !ent:IsWorld() and (!ent:IsPlayer() or ent.IsMooZombie) then return end

    self:Explode(ent)
end]]

function ENT:Explode(ent)
    local dmg = 90

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 50)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_ENERGYBEAM)

            local distfac = pos:Distance(v:WorldSpaceCenter())
            distfac = 1 - math.Clamp((distfac/50), 0, 1)

            expdamage:SetAttacker(self)
            expdamage:SetDamage(dmg * distfac)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
                v:NZSonicBlind(0.75)
            end
        end

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())

        --util.Effect("Explosion", effectdata)
        util.ScreenShake(self:GetPos(), 20, 255, 0.5, 100)

        self:EmitSound(self.PulsePopChargeSounds[math.random(#self.PulsePopChargeSounds)], 577, math.random(95,105))
        --ParticleEffectAttach("cw_mangler_blast",PATTACH_ABSORIGIN,self,0)
        for i = 1, 2 do
            ParticleEffect("zmb_trickster_mine_blast",self:GetPos()+Vector(0,0,1),self:GetAngles(),nil)
        end

        self:Remove()
    end
end

function ENT:Think()

    if SERVER then
        --[[if CurTime() > self.NextPulse then
            self:EmitSound(self.PulseSounds[math.random(#self.PulseSounds)], 75, math.random(95,105))
            ParticleEffectAttach("cw_mangler_blast_wave",PATTACH_ABSORIGIN_FOLLOW,self,0)

            self.NextPulse = CurTime() + 0.25
        end]]
        if CurTime() > self.Lifetime and !self.HasExploded then
            self.HasExploded = true
            self:Explode()
        end
    end

    self:NextThink(CurTime())
    return true
end

function ENT:OnRemove()
end
