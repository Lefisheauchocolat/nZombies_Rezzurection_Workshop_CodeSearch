
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
ENT.PrintName = "Chomper"

--[Parameters]--
ENT.Delay = 5
ENT.RangeSqr = 90500
ENT.Attacked = false

ENT.MoveSpeed = 275
ENT.CurveStrengthMin = 0
ENT.CurveStrengthMax = 0

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "SoundDelay")
    self:NetworkVar("Entity", 0, "Victim")
end

function ENT:StartTouch(ply)
    if ply.IsMooZombie and !ply.IsMooSpecial and !ply.IsMooBossZombie and !ply.IsMiniBoss then
        ply:Flames(true)
    end

    if not ply:IsPlayer() then return end
    if not ply:GetNotDowned() or not ply:Alive() then return end
    if self.Attacked then return end
    self.Attacked = true

    --[[local rand = VectorRand(-21,21)
    rand = Vector(rand.x, rand.y, 1)
    util.Decal("Blood", ply:GetPos() - rand, ply:GetPos() + rand) //floor blood

    local att = self:GetAttachment(2)

    local tr = util.QuickTrace(att.Pos, att.Ang:Forward()*64, {self, ply})
    if tr.Hit and tr.HitWorld then
        util.Decal("Blood", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal) //wall blood
    end

    ParticleEffect("blood_impact_red_01", att.Pos, self:GetForward():Angle())]]
    --self:EmitSound("TFA_BO3_DEMONBOW.Chomper.Bite")

    ply:TakeDamage(75, self, self)

    self:SetVictim(nil)

    self:Explode()
    SafeRemoveEntityDelayed(self, 0.5)
end

function ENT:Explode(ent)
    local dmg = 100
    if !self.Exploded then
        self.Exploded = true
        if SERVER then
            local pos = self:WorldSpaceCenter()

            local tr = {
                start = pos,
                filter = self,
                mask = MASK_NPCSOLID_BRUSHONLY
            }

            for k, v in pairs(ents.FindInSphere(pos, 125)) do
                local expdamage = DamageInfo()
                expdamage:SetDamageType(DMG_ENERGYBEAM)

                local distfac = pos:Distance(v:WorldSpaceCenter())
                distfac = 1 - math.Clamp((distfac/50), 0, 1)

                expdamage:SetAttacker(self)
                expdamage:SetDamage(dmg * distfac)
                expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

                if v.IsMooZombie and !v.IsMooSpecial and !v.IsMooBossZombie and !v.IsMiniBoss then
                    v:Flames(true)
                end

                if v:IsPlayer() then
                    v:TakeDamageInfo(expdamage)
                    v:NZSonicBlind(0.75)
                    if v:IsOnGround() then
                        v:SetVelocity( (v:GetPos() - self:GetPos()) * 10 + Vector( 0, 35, 0 ) )
                    else
                        v:SetVelocity( (v:GetPos() - self:GetPos()) * 2 + Vector( 0, 35, 14 ) )
                    end
                end
            end

            local effectdata = EffectData()
            effectdata:SetOrigin(self:GetPos())

            --util.Effect("Explosion", effectdata)
            util.ScreenShake(self:GetPos(), 20, 255, 0.5, 100)

            ParticleEffect("doom_avile_blast",self:GetPos()+Vector(0,0,1),self:GetAngles(),nil)
            self:EmitSound("nz_moo/zombies/vox/_margwa/elemental/fire/attack_main_imp.mp3", 100, math.random(95,105))
            self:EmitSoundNet("nz_moo/zombies/vox/_margwa/elemental/fire/attack_slam_swt.mp3")
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
    self:UseTriggerBounds(true, 75)

    self:EmitSoundNet("nz_moo/zombies/vox/_margwa/elemental/fire/firepit_lp.wav", 100)
    self:EmitSoundNet("nz_moo/zombies/vox/_margwa/elemental/fire/attack_slam_swt.mp3")

    self:SetVictim(self:FindNearestEntity(self:GetPos(), self.RangeSqr))
    self:SetSoundDelay(CurTime() + math.Rand(0.35, 0.8))

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableDrag(false)
        phys:EnableGravity(false)
    end

    ParticleEffectAttach("zmb_fire_margwa_firewave", PATTACH_ABSORIGIN_FOLLOW, self, 1)

    self.killtime = CurTime() + self.Delay

    if CLIENT then return end
    self:SetTrigger(true)
end

function ENT:Think()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:SetVelocity(self:GetForward() * self.MoveSpeed)
        phys:AddAngleVelocity(VectorRand() * (math.sin(CurTime() * 30))* math.random(self.CurveStrengthMin, self.CurveStrengthMax))
        self:SetAngles(phys:GetVelocity():Angle())
    end

    if self:GetSoundDelay() < CurTime() then
        --self:EmitSound("TFA_BO3_DEMONBOW.Chomper.Vox.Short")
        self:SetSoundDelay(CurTime() + math.Rand(1,2))
    end

    if SERVER then
        local ply = self:GetVictim()
        --[[if (not IsValid(ply) or not ply:Alive() or not ply:GetNotDowned()) and not self.Attacked then
            self:SetVictim(self:FindNearestEntity(self:GetPos(), self.RangeSqr))
        end]]

        if IsValid(ply) and ply:Health() > 0 then
            local tang = (ply:WorldSpaceCenter() - (self:GetPos())):GetNormalized()
            local finalang = LerpAngle(0.0145, self:GetAngles(), tang:Angle())
            self:SetAngles(finalang)
        end

        if self.killtime < CurTime() or (self:GetCreationTime() + 1 < CurTime() and not self:IsInWorld()) then
            self:StopSound("nz_moo/zombies/vox/_margwa/elemental/fire/firepit_lp.wav")
            self:Explode()
            return false
        end
    end
    if CLIENT then
        local dlight = DynamicLight(self:EntIndex())
        if (dlight) then
            dlight.pos = self:GetPos()
            dlight.dir = self:GetPos()
            dlight.r = 235
            dlight.g = 75
            dlight.b = 15
            dlight.brightness = 1
            dlight.Decay = 200
            dlight.Size = 400
            dlight.DieTime = CurTime() + 1
        end
    end

    self:NextThink(CurTime())
    return true
end

function ENT:FindNearestEntity(pos, rangesqr)
    local ply

    for k, v in RandomPairs(player.GetAll()) do
        if (not v:Alive()) or (not v:GetNotDowned()) then continue end
        if v:GetPos():DistToSqr(self:GetPos()) > rangesqr then continue end
        ply = v
        break
    end

    return ply
end

function ENT:OnRemove()
    --[[if CLIENT and IsValid(self) and DynamicLight then
        local dlight = DynamicLight(self:EntIndex())
        if dlight then
            dlight.pos = self:WorldSpaceCenter()
            dlight.r = 120
            dlight.g = 80
            dlight.b = 255
            dlight.brightness = 2
            dlight.Decay = 2000
            dlight.Size = 400
            dlight.DieTime = CurTime() + 0.5
        end
    end]]

    self:StopSound("nz_moo/zombies/vox/_margwa/elemental/fire/firepit_lp.wav")
    --self:EmitSound("TFA_BO3_DEMONBOW.Chomper.Disappear")
end
