function EFFECT:Init(data)
    local BloodMaterials = {"bo6/da/decals/pool1", "bo6/da/decals/pool2", "bo6/da/decals/pool3", "bo6/da/decals/pool4", "bo6/da/decals/pool5", "bo6/da/decals/pool6"}
    local chosenMat = table.Random(BloodMaterials)
    local emitter = ParticleEmitter(data:GetOrigin(), true)
    local tr = util.TraceLine({
        start = data:GetOrigin(),
        endpos = data:GetOrigin()-Vector(0,0,100),
        mask = MASK_SOLID,
    })
    local particle = emitter:Add(chosenMat, tr.HitPos)
    if particle then
        particle:SetAngles(Angle(-90,0,0))
        particle:SetDieTime(6)
        particle:SetStartAlpha(255)
        particle:SetEndAlpha(255)
        particle:SetStartSize(10)
        particle:SetEndSize(12)
    end
    emitter:Finish()
end

function EFFECT:Think()
    return true
end

function EFFECT:Render()
    return true
end