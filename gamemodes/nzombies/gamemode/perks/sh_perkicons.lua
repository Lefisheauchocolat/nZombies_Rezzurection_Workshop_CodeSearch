function nzPerks:RegisterIconSet(setName, iconPath, borderPath)
	nzPerks.IconSets = nzPerks.IconSets or {}

	nzPerks.IconSets[setName] = {
		iconPath = iconPath,
		borderPath = borderPath
	}
end

nzPerks.IconCache = nzPerks.IconCache or {}
nzPerks.BorderCache = nzPerks.BorderCache or {}

local zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
local zmhud_icon_frame = Material("nz_moo_21/icons/perk_frame.png", "unlitgeneric smooth")

function nzPerks:GetPerkIcon(perk, setName)
if setName == nil then
setName = "PRESS SUBMIT RIGHT NOW"
end
	local cacheKey = setName .. perk
	if nzPerks.IconCache[cacheKey] then
		return nzPerks.IconCache[cacheKey]
	end

	local iconSet = nzPerks.IconSets[setName]
	if not iconSet then return zmhud_icon_missing end

	local filePath = iconSet.iconPath .. perk .. ".png"
	local icon = Material(filePath, "smooth unlitgeneric")

	nzPerks.IconCache[cacheKey] = icon:IsError() and zmhud_icon_missing or icon
	return nzPerks.IconCache[cacheKey]
end

function nzPerks:GetPerkBorder(setName)
	if nzPerks.BorderCache[setName] then
		return nzPerks.BorderCache[setName]
	end

	local iconSet = nzPerks.IconSets[setName]
	if not iconSet then return zmhud_icon_frame end

	local border = Material(iconSet.borderPath, "smooth unlitgeneric")

	nzPerks.BorderCache[setName] = border:IsError() and zmhud_icon_frame or border
	return nzPerks.BorderCache[setName]
end

-- Register perk icon sets with THIS HAHAHAHA IT WORKED YEAH FUCK YOU SH_SPECIAL_ROUND :wind_blowing_face:
nzPerks:RegisterIconSet("World at War/ Black Ops 1", "nz_moo_21/icons/bo1/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Black Ops 2", "nz_moo_21/icons/faithful_charred/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Black Ops 3", "nz_moo_21/icons/faitful_bo3/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Black Ops 4", "nz_moo_21/icons/bo4/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Infinite Warfare", "nz_moo_21/icons/iw/", "nz_moo_21/icons/iw_frame.png")
nzPerks:RegisterIconSet("Modern Warfare", "nz_moo_21/icons/mw/", "nz_moo_21/icons/mw_frame.png")
nzPerks:RegisterIconSet("Cold War", "nz_moo_21/icons/cw/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Vanguard", "nz_moo_21/icons/griddy/", "nz_moo_21/icons/griddy_frame.png")
nzPerks:RegisterIconSet("Classic Vanguard", "nz_moo_21/icons/vangriddy_owl/", "nz_moo_21/icons/griddy_frame.png")
nzPerks:RegisterIconSet("April Fools", "nz_moo_21/icons/aprilfools/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("No Background", "nz_moo_21/icons/no background/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Shadows of Evil", "nz_moo_21/icons/soe_v2/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Shadows of Evil", "nz_moo_21/icons/soe/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("The Giant", "nz_moo_21/icons/soe_giant/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("WW2", "nz_moo_21/icons/ww2/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Halloween", "nz_moo_21/icons/halloween/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Christmas", "nz_moo_21/icons/christmas/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Christmas", "nz_moo_21/icons/christmas_classic/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Halloween", "nz_moo_21/icons/halloween_classic/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Neon", "nz_moo_21/icons/neon/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Overgrown", "nz_moo_21/icons/overgrown/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Overgrown", "nz_moo_21/icons/overgrown_old/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("MW3 Zombies", "nz_moo_21/icons/mw3z/", "nz_moo_21/icons/mw3_frame.png")
nzPerks:RegisterIconSet("Frosted Flakes", "nz_moo_21/icons/frosty/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Frosted Flakes", "nz_moo_21/icons/frosted/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Pickle Glow", "nz_moo_21/icons/pickle/", "nz_moo_21/icons/pickle_frame.png")
nzPerks:RegisterIconSet("Herrenhaus", "nz_moo_21/icons/herren/", "nz_moo_21/icons/herren_frame.png")
nzPerks:RegisterIconSet("Paper", "nz_moo_21/icons/paper/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Cheese Cube", "nz_moo_21/icons/cheese/", "nz_moo_21/icons/cheddar_frame.png")
nzPerks:RegisterIconSet("Charred", "nz_moo_21/icons/bo2/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Ragnarok", "nz_moo_21/icons/ragnarok/", "nz_moo_21/icons/rag_frame.png")
nzPerks:RegisterIconSet("So Retro", "nz_moo_21/icons/so_retro/", "nz_moo_21/icons/pickle_frame.png")
nzPerks:RegisterIconSet("Thin & Simple", "nz_moo_21/icons/bo3/", "nz_moo_21/icons/perk_frame.png")
nzPerks:RegisterIconSet("Rezzurrection", "nz_moo_21/icons/sam/", "nz_moo_21/icons/sam_frame.png")
nzPerks:RegisterIconSet("Squared", "nz_moo_21/icons/fizzy/", "nz_moo_21/icons/fizzy_frame.png")
nzPerks:RegisterIconSet("Comic", "nz_moo_21/icons/comic/", "nz_moo_21/icons/comic_frame.png")
nzPerks:RegisterIconSet("Flask", "nz_moo_21/icons/alchemy/", "nz_moo_21/icons/alchemy_frame.png")