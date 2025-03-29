local searchFolders = {
    "models/aw",
    "models/bo6",
    "models/hari",
    "models/devi"
}

local function PrecacheModelsInFolder(folder)
    local files, directories = file.Find(folder .. "/*", "GAME")
    
    for _, fileName in ipairs(files) do
        if string.EndsWith(fileName, ".mdl") then
            local modelPath = folder .. "/" .. fileName
            util.PrecacheModel(modelPath)
            print("[Precache] " .. modelPath)
        end
    end
    
    for _, subDir in ipairs(directories) do
        PrecacheModelsInFolder(folder .. "/" .. subDir)
    end
end

for _, folder in ipairs(searchFolders) do
    PrecacheModelsInFolder(folder)
end

--------------------------------
--------------------------------

hook.Add("InitPostEntity", "nzrAddVultureNewIcons", function()
    nzPerks:AddVultureClass("aw_exostation")
    nzDisplay:AddVultureIcon("aw_exostation", Material("bo6/other/vulture_exo.png", "mips unlitgeneric"))
    nzPerks:AddVultureClass("bo6_arsenal")
    nzDisplay:AddVultureIcon("bo6_arsenal", Material("bo6/other/vulture_arsenal.png", "smooth unlitgeneric"))
    nzPerks:AddVultureClass("bo6_crafting_table")
    nzDisplay:AddVultureIcon("bo6_crafting_table", Material("bo6/other/vulture_craft.png", "smooth unlitgeneric"))
    nzPerks:AddVultureClass("ammo_box")
    nzDisplay:AddVultureIcon("ammo_box", Material("bo6/other/vulture_ammobox.png", "smooth unlitgeneric"))
end)