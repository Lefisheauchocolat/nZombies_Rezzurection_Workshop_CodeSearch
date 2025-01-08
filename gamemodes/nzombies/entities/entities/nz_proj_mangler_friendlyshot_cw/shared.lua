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
ENT.PrintName = "Mangler Shot"

--[Parameters]--
ENT.Delay = 1.75
ENT.RangeSqr = 90500
ENT.Attacked = false

ENT.MoveSpeed = 575
ENT.CurveStrengthMin = 0
ENT.CurveStrengthMax = 0

ENT.PulseSounds = {
    Sound("nz_moo/zombies/vox/_raz/mangler/pop/pulse_00.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/pop/pulse_01.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/pop/pulse_02.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/pop/pulse_03.mp3"),
}

ENT.ImpSounds = {
    Sound("nz_moo/zombies/vox/_raz/mangler/imp/imp_00.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/imp/imp_01.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/imp/imp_02.mp3"),
    Sound("nz_moo/zombies/vox/_raz/mangler/imp/imp_03.mp3"),
}

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "SoundDelay")
    self:NetworkVar("Entity", 0, "Victim")
end

function ENT:PhysicsCollide(data, phys)
    if self:GetNW2Bool("Impacted") then return end
    if IsValid(data.Entity) and data.Entity:IsPlayer() then return end
    
    --self:EmitSound(self.ImpSounds[math.random(#self.ImpSounds)], 95,math.random(95,105))
    self:StopParticles()
    self:Explode()
    self:SetNoDraw(true)
    self:DrawShadow(false)
    phys:EnableMotion(false)
    phys:Sleep()
    self:SetNW2Bool("Impacted", true)

    timer.Simple(0, function()
        if IsValid(self) then
            self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        end
    end)
end

function ENT:Explode(ent)
    local dmg = math.max(15000+(2500*nzRound:GetNumber()), 15000)

    if !self.HasExploded then 
        self.HasExploded = true
        if SERVER then
            local pos = self:WorldSpaceCenter()

            local tr = {
                start = pos,
                filter = self,
                mask = MASK_NPCSOLID_BRUSHONLY
            }

            for k, v in pairs(ents.FindInSphere(pos, 256)) do
                local expdamage = DamageInfo()
                expdamage:SetDamageType(DMG_ENERGYBEAM)

                expdamage:SetAttacker(self.Player or self)
                expdamage:SetDamage(dmg)
                expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

                if !v:IsPlayer() then
                    v:TakeDamageInfo(expdamage)
                end
            end

            local effectdata = EffectData()
            effectdata:SetOrigin(self:GetPos())

            --util.Effect("Explosion", effectdata)
            util.ScreenShake(self:GetPos(), 20, 255, 0.5, 100)

            self:EmitSound(self.ImpSounds[math.random(#self.ImpSounds)], 577, math.random(95,105))
            ParticleEffect("cw_mangler_blast",self:GetPos()+Vector(0,0,1),self:GetAngles(),nil)
            --[[for i = 1, 6 do
                ParticleEffect("bo3_mangler_blast",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
            end]]

            self:Remove()
        end
    end
end

function ENT:Initialize(...)
    BaseClass.Initialize(self,...)

    self:SetModel("models/dav0r/hoverball.mdl")
    self:SetNoDraw(true)
    self:DrawShadow(false)
    self.AutomaticFrameAdvance = true
    self:SetSolid(SOLID_VPHYSICS)
    --self:UseTriggerBounds(true, 25)

    self.NextPulse = 0

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableDrag(false)
        phys:EnableGravity(false)
    end

    ParticleEffectAttach("cw_mangler_pulse",PATTACH_ABSORIGIN_FOLLOW,self,1)

    self.killtime = CurTime() + self.Delay

    if CLIENT then return end
    --self:SetTrigger(true)
end

function ENT:Think()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocity(self:GetForward() * self.MoveSpeed)
        phys:AddAngleVelocity(VectorRand() * (math.sin(CurTime() * 30))* math.random(self.CurveStrengthMin, self.CurveStrengthMax))
        self:SetAngles(phys:GetVelocity():Angle())
    end

    if SERVER then
        if self.killtime < CurTime() or (self:GetCreationTime() + 1 < CurTime() and not self:IsInWorld()) then
            self:Explode()
            return false
        end

        if CurTime() > self.NextPulse then
            self:EmitSound(self.PulseSounds[math.random(#self.PulseSounds)], 75, math.random(95,105))
            ParticleEffectAttach("cw_mangler_blast_wave",PATTACH_ABSORIGIN_FOLLOW,self,0)

            self.NextPulse = CurTime() + 0.25
        end
    end

    self:NextThink(CurTime())
    return true
end

function ENT:OnRemove()

end
