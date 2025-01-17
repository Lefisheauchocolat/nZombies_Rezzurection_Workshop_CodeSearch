function EFFECT:Init(data)
    self.Position = data:GetOrigin()
    self.Direction = data:GetNormal()
    local tr = util.TraceLine({
        start = data:GetOrigin(),
        endpos = data:GetOrigin()+Vector(0,0,3200),
        filter = function( ent ) return ( ent:GetClass() == "prop_physics" ) end
    })
    self.Speed = math.abs(tr.HitPos.z-data:GetOrigin().z)/3.2
    self.Lifetime = 3
    self.DieTime = CurTime() + self.Lifetime

    if CLIENT then
        EmitSound(")bo6/exfil/effects/flare_launch.wav", self.Position, 0, CHAN_AUTO, 1, 120)
    end

    for i = 1, self.Lifetime*25 do
        timer.Simple(i/25, function()
            if !isvector(self.Position) then return end
            local emitter = ParticleEmitter(self.Position)
            local particle = emitter:Add("trails/smoke.vmt", self.Position)
            if particle then
                particle:SetVelocity(Vector(0, 0, 5))
                particle:SetColor(0, 255, 0)
                particle:SetDieTime(self.Lifetime)
                particle:SetStartAlpha(200)
                particle:SetEndAlpha(0)
                particle:SetStartSize(10)
                particle:SetEndSize(10)
                particle:SetGravity(Vector(0, 0, 5))
                particle:SetAirResistance(50)
            end
            emitter:Finish()
        end)
    end
end

function EFFECT:Think()
    if CurTime() > self.DieTime then
        self:Explosion()
        return false
    end

    self.Position = self.Position + self.Direction * self.Speed * FrameTime()
    return true
end

function EFFECT:Explosion()
    local explosionPos = self.Position

    local emitter = ParticleEmitter(explosionPos)
    for i = 1, 100 do
        local particle = emitter:Add("sprites/light_glow02_add", explosionPos)
        if particle then
            particle:SetVelocity(VectorRand() * 1000)
            particle:SetColor(0, 200, 0)
            particle:SetDieTime(4)
            particle:SetStartAlpha(150)
            particle:SetEndAlpha(0)
            particle:SetStartSize(75)
            particle:SetEndSize(1)
            particle:SetRoll(math.Rand(0, 360))
            particle:SetRollDelta(math.Rand(-2, 2))
            particle:SetGravity(Vector(0, 0, -250))
            particle:SetAirResistance(100)
        end
    end
    local particle = emitter:Add("sprites/light_glow02_add", explosionPos)
    if particle then
        particle:SetVelocity(Vector(0,0,100))
        particle:SetColor(0, 255, 0)
        particle:SetDieTime(8)
        particle:SetStartAlpha(100)
        particle:SetEndAlpha(0)
        particle:SetStartSize(750)
        particle:SetEndSize(0)
        particle:SetRoll(math.Rand(0, 360))
        particle:SetRollDelta(math.Rand(-2, 2))
        particle:SetGravity(Vector(0, 0, -250))
        particle:SetAirResistance(100)
    end
    emitter:Finish()

    if CLIENT then
        EmitSound(")bo6/exfil/effects/flare_explosion.wav", self.Position, 0, CHAN_AUTO, 1, 120)
    end
end

function EFFECT:Render()
    return true
end
