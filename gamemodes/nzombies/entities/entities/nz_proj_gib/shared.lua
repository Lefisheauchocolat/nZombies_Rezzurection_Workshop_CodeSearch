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
ENT.LoopSound = Sound("nz_moo/zombies/fly/attack/gut_throw/zmb_gut_projectile_lp.wav")
ENT.ExplodeSound = {
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_01.mp3"),
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_02.mp3"),
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_03.mp3"),
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_04.mp3"),
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_05.mp3"),
    Sound("nz_moo/zombies/fly/attack/gut_throw/impacts/zmb_gut_projectile_impact_06.mp3"),
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
    
    self:EmitSound(self.ExplodeSound[math.random(#self.ExplodeSound)], 95,math.random(95,105))
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

function ENT:CreateRocketTrail()
    self:SetNoDraw(false)
    ParticleEffectAttach("ins_blood_dismember_limb",PATTACH_ABSORIGIN_FOLLOW,self,0)
    if SERVER then
        util.SpriteTrail(self, 0, Color(255, 0, 0, 100), false, 12, 0, 0.3, 1 / 40 * 0.3, "trails/plasma")
    end
end

function ENT:Initialize(...)
    BaseClass.Initialize(self, ...)

    self:SetModel("models/props_junk/watermelon01_chunk02a.mdl")
    self:SetMaterial("models/flesh")
    self:SetModelScale(1)

    if self.HasTrail then
        self:CreateRocketTrail()
    end
end

function ENT:Think()
    local ply = self:GetOwner()
    if SERVER then
        if !self.StartLP and !self:GetNW2Bool("Impacted") then
            self.StartLP = true
            self:EmitSound(self.LoopSound, 70, math.random(95,105))
        end
    end
    
    if not self:GetNW2Bool("Impacted") then
        self:NextThink(CurTime())
    else
        self:StopSound(self.LoopSound)
        self:NextThink( CurTime() + math.Rand( 0.75, 0.9 ) )
    end
    return true
end

function ENT:DoExplosionEffect()
    ParticleEffect("ins_blood_impact_headshot", self:GetPos(), Angle(-90,0,0))
end

function ENT:Explode(ent)
    local dmg = 50

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 50)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_GENERIC)
            expdamage:SetAttacker(self)
            expdamage:SetDamage(dmg)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
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
    self:StopSound(self.LoopSound)
end