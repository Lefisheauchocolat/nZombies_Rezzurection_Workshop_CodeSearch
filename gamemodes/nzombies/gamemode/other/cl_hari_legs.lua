local legs_convar = CreateConVar("nz_downed_legs", 1, FCVAR_ARCHIVE, "Enable legs, when you downed.", 0, 1)
local clientModel = nil
local lastAngles = Angle(0, 0, 0)

local offsetTab = {
    ["default"] = Vector(-32, 0, 0),
    ["bo3_crawl_idle"] = Vector(-2, 4, 0),
    ["bo3_crawl_back"] = Vector(-4, 4, 0),
    ["bo3_crawl_forward"] = Vector(-4, 4, 0),
}
local hideBones = {"ValveBiped.Bip01_L_Upperarm", "ValveBiped.Bip01_R_Upperarm", "ValveBiped.Bip01_Head1"}

local function HideBoneRecursive(ent, boneID, rotate)
    if not IsValid(ent) or boneID < 1 then return end

    ent:ManipulateBoneScale(boneID, Vector(0, 0, 0))
    if rotate then
        ent:ManipulateBoneAngles(boneID, Angle(0, 270, 0))
    end
    local tab = ent:GetChildBones(boneID)
    for i, b in pairs(tab) do
        HideBoneRecursive(ent, b, false)
    end
end

local function UpdateClientModel(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    local allowwep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() != "tfa_zomdeath" or !IsValid(ply:GetActiveWeapon())
    if legs_convar:GetBool() and not ply:GetNotDowned() and ply:Alive() and !ply:ShouldDrawLocalPlayer() and allowwep then
        if not IsValid(ply.clientModel) then
            ply.clientModel = ClientsideModel(ply:GetModel(), RENDERGROUP_OPAQUE)
        end

        local clientModel = ply.clientModel
        local targetAngles = Angle(0, ply:GetAngles().y, 0)

        clientModel:SetPos(ply:GetPos())
        clientModel:SetAngles(targetAngles)
        clientModel:SetupBones()
        clientModel:SetCycle(ply:GetCycle())
        clientModel:SetSequence(ply:GetSequence())

        local animName = ply:GetSequenceName(ply:GetSequence())
        local off = offsetTab[animName]
        if isvector(off) then
            clientModel:SetPos(ply:GetPos() + targetAngles:Forward() * off.x + targetAngles:Right() * off.y + targetAngles:Up() * off.z)
        else
            off = offsetTab["default"]
            clientModel:SetPos(ply:GetPos() + targetAngles:Forward() * off.x + targetAngles:Right() * off.y + targetAngles:Up() * off.z)
        end
        clientModel:DrawModel()
        
        for k, b in pairs(hideBones) do
            local id = ply:LookupBone(b)
            if id < 1 then continue end
            HideBoneRecursive(clientModel, id, true)
        end
    elseif IsValid(ply.clientModel) then
        ply.clientModel:Remove()
        ply.clientModel = nil
    end
end

hook.Add("Think", "nZR.DrawDownedModel", function()
    UpdateClientModel(LocalPlayer())
end)