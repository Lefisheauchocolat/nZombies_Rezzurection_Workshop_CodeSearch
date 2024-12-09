-- Effect: Circular Dust Particles
-- File: lua/effects/effect_dust.lua

-- Initialization of the effect
function EFFECT:Init(data)
    -- The origin point of the effect
    local origin = data:GetOrigin()
    
    -- Emit particles using a Particle Emitter
    local emitter = ParticleEmitter(origin)
    if not emitter then return end

    -- Create particles
    for i = 1, 150 do
        -- Generate a circular direction
        local angle = math.Rand(0, 360) -- Angle in degrees
        local distance = math.Rand(100, 200) -- Initial distance from center

        -- Calculate particle position
        local position = origin + Vector(
            math.cos(math.rad(angle)) * distance, 
            math.sin(math.rad(angle)) * distance, 
            0 -- Keep particles on a flat plane initially
        )

        -- Create a particle
        local particle = emitter:Add("particle/smokesprites_000" .. math.random(1, 9), position)
        if particle then
            -- Set circular velocity for spreading effect
            local circularVelocity = Vector(
                math.cos(math.rad(angle)) * math.Rand(150, 250), 
                math.sin(math.rad(angle)) * math.Rand(150, 250), 
                math.Rand(5, 10) -- Small upward lift
            )

            particle:SetVelocity(circularVelocity)
            particle:SetDieTime(math.Rand(2.5, 3.0))  -- Lifetime of the particle
            particle:SetStartAlpha(50)
            particle:SetEndAlpha(0)
            particle:SetStartSize(math.Rand(5, 15))
            particle:SetEndSize(math.Rand(25, 50))
            particle:SetRoll(math.Rand(0, 360))
            particle:SetRollDelta(math.Rand(-1, 1))
            particle:SetColor(160, 150, 150)  -- Gray dust color
            particle:SetAirResistance(10)
            particle:SetGravity(Vector(0, 0, 0)) -- Slight downward gravity
            particle:SetCollide(true)
            particle:SetBounce(0.2)
        end
    end

    emitter:Finish()  -- Release the emitter
end

-- Think function: Ends the effect immediately after initialization.
function EFFECT:Think()
    return false
end

-- Render function: Not needed for particles.
function EFFECT:Render()
end
