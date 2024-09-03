
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
ENT.PrintName = "Contact Explosive"
ENT.HasTrail = true 

--[Sounds]--
ENT.ExplodeSound = {
    Sound("weapons/c4/c4_explode1.wav"),
}

--[Parameters]--
ENT.Impacted = false
ENT.IsDetonated = false
ENT.TriggerSphere = false

ENT.StartLP = false

local nzombies = engine.ActiveGamemode() == "nzombies"

DEFINE_BASECLASS(ENT.Base)

function ENT:UpdateTransmitState()
    return TRANSMIT_ALWAYS
end

function ENT:PhysicsCollide(data, phys)
    if data.HitEntity.IsMooZombie then return end
    if self:GetNW2Bool("Impacted") then return end
    
    self:EmitSound("weapons/c4/c4_plant.wav", 75, math.random(95,105))

    self:StopParticles()
    phys:EnableMotion(false)
    phys:Sleep()
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
    self:SetNW2Bool("Impacted", true)
end

function ENT:CreateRocketTrail()
    if SERVER then
        util.SpriteTrail(self, 0, Color(255, 0, 0, 255), false, 25, 15, 0.15, 1 / 40 * 0.3, "trails/electric")
    end
end

function ENT:Initialize(...)
    BaseClass.Initialize(self, ...)

    self:SetModel("models/totu/detonator_bomb.mdl")
    self.Lifetime = CurTime() + 60
    self.NextPing = CurTime() + 0.9

    self.PlayerCheck = CurTime() + 0.85

    if self.HasTrail then
        self:CreateRocketTrail()
    end
end

function ENT:Think()
    local ply = self:GetOwner()
    if SERVER then
        if CurTime() > self.Lifetime and !self.HasExploded then
            self.HasExploded = true
            self:Explode()
        end
        if CurTime() > self.NextPing then
            self:EmitSound("weapons/c4/c4_click.wav", 70)
            ParticleEffect("npc_gearsofwar_locust_ticker_explosion_flash", self:GetPos(), Angle(0,0,0), self)
            self.NextPing = CurTime() + 0.9 
        end
        if CurTime() > self.PlayerCheck then
            for k,v in nzLevel.GetTargetableArray() do
                if IsValid(v) and v:IsPlayer() and self:GetPos():DistToSqr(v:GetPos()) <= 200^2 then
                    if !self.HasExploded then
                        self.HasExploded = true
                        self:Explode()
                    end
                end
            end
            self.PlayerCheck = CurTime() + 0.5
        end
    end
    
    self:NextThink(CurTime())
    return true
end

function ENT:DoExplosionEffect()
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos())

    util.Effect("HelicopterMegaBomb", effectdata)
    util.Effect("Explosion", effectdata)
    self:EmitSound(self.ExplodeSound[math.random(#self.ExplodeSound)], 95,math.random(95,105))
end

function ENT:Explode(ent)
    local dmg = 125

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 150)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_ENERGYBEAM)

            local distfac = pos:Distance(v:WorldSpaceCenter())
            distfac = 1 - math.Clamp((distfac/150), 0, 1)

            expdamage:SetAttacker(self)
            expdamage:SetDamage(dmg * distfac)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
                v:NZSonicBlind(0.45)
            end
        end

        self:DoExplosionEffect()
        SafeRemoveEntity(self)
    end
end

--Below function credited to CmdrMatthew
function ENT:getvel(pos, pos2, time)    -- target, starting point, time to get there
    local diff = pos - pos2 --subtract the vectors
     
    local velx = diff.x/time -- x velocity
    local vely = diff.y/time -- y velocity
 
    local velz = (diff.z - 0.5*(-GetConVarNumber( "sv_gravity"))*(time^2))/time --  x = x0 + vt + 0.5at^2 conversion
     
    return Vector(velx, vely, velz)
end 
    
function ENT:LaunchArc(pos, pos2, time, t)  -- target, starting point, time to get there, fraction of jump
    local v = self:getvel(pos, pos2, time).z
    local a = (-GetConVarNumber( "sv_gravity"))
    local z = v*t + 0.5*a*t^2
    local diff = pos - pos2
    local x = diff.x*(t/time)
    local y = diff.y*(t/time)
    
    return pos2 + Vector(x, y, z)
end

function ENT:OnRemove() 
    self:StopParticles()
end