-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

ENT = {}
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
    self:SetModel("models/bo6/exfil/veh/guy01.mdl")
    self:SetNoDraw(false)
    self:SetPlaybackRate(1)
end

function ENT:SetAnim(modelPath, animName, startCycle, rate)
    startCycle = startCycle or 0
    rate = rate or 1
    if IsValid(self.BoneMergeModel) then
        self.BoneMergeModel:Remove()
    end
    
    self.BoneMergeModel = ClientsideModel(modelPath, RENDERGROUP_OPAQUE)
    if not IsValid(self.BoneMergeModel) then return end

    self.BoneMergeModel:SetParent(self)
    self.BoneMergeModel:AddEffects(EF_BONEMERGE)

    local animID = self:LookupSequence(animName)
    if animID >= 0 then
        self:ResetSequence(animID)
        self:SetCycle(startCycle)
        self:SetPlaybackRate(rate)
    end
end

function ENT:OnRemove()
    if IsValid(self.BoneMergeModel) then
        self.BoneMergeModel:Remove()
    end
end

function ENT:Think()
    self:FrameAdvance()
    self:NextThink(CurTime())
    return true
end

function ENT:Draw()
    self:DrawModel()
    if IsValid(self.BoneMergeModel) then
        self.BoneMergeModel:DrawModel()
    end
end

scripted_ents.Register(ENT, "bo6_bonemerge", true)