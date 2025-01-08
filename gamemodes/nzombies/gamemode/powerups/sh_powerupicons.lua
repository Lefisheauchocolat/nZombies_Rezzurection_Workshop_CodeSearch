nzPowerUps.IconSets = nzPowerUps.IconSets or {}
nzPowerUps.IconCache = nzPowerUps.IconCache or {}

local missing_icon = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")

function nzPowerUps:RegisterIconSet(setName, basePath)
    nzPowerUps.IconSets[setName] = {
        basePath = basePath
    }
end

function nzPowerUps:GetPowerupIcon(powerupName, setName)
    local cacheKey = setName .. powerupName
    if nzPowerUps.IconCache[cacheKey] then
        return nzPowerUps.IconCache[cacheKey]
    end

    local iconSet = nzPowerUps.IconSets[setName]
    if not iconSet then return missing_icon end

    local filePath = iconSet.basePath .. powerupName .. ".png"
    local icon = Material(filePath, "smooth unlitgeneric")

    nzPowerUps.IconCache[cacheKey] = icon:IsError() and missing_icon or icon
    return nzPowerUps.IconCache[cacheKey]
end

nzPowerUps:RegisterIconSet("Black Ops 1", 	"nz_moo/powerup_icons/bo1/")
nzPowerUps:RegisterIconSet("Black Ops 2", 	"nz_moo/powerup_icons/bo2/")
nzPowerUps:RegisterIconSet("Black Ops 3", 	"nz_moo/powerup_icons/bo3/")
nzPowerUps:RegisterIconSet("Shadows of Evil (Incomplete)", 	"nz_moo/powerup_icons/zod/")
nzPowerUps:RegisterIconSet("Black Ops 4", 	"nz_moo/powerup_icons/bo4/")
nzPowerUps:RegisterIconSet("Cold War", 		"nz_moo/powerup_icons/cw/")
nzPowerUps:RegisterIconSet("Black Ops 6", 	"nz_moo/powerup_icons/bo6/")
nzPowerUps:RegisterIconSet("Comic Book", 	"nz_moo/powerup_icons/comic/")
nzPowerUps:RegisterIconSet("Velvet", 		"nz_moo/powerup_icons/yuija/")
nzPowerUps:RegisterIconSet("Christmas", 	"nz_moo/powerup_icons/xmas/")
nzPowerUps:RegisterIconSet("Modern Warfare Zombies", 	"nz_moo/powerup_icons/mwz/")