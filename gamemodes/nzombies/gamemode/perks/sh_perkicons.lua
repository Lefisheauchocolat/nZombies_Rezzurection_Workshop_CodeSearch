function nzPerks:RegisterIconSet(setName, iconPath, borderPath)
	nzPerks.IconSets = nzPerks.IconSets or {}

	nzPerks.IconSets[setName] = {
		iconPath = iconPath,
		borderPath = borderPath
	}
end

nzPerks.IconCache = nzPerks.IconCache or {}
nzPerks.BorderCache = nzPerks.BorderCache or {}

local zmhud_icon_missing = Material("nz_moo/perk_icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
local zmhud_icon_frame = Material("nz_moo_21/icons/perk_frame.png", "unlitgeneric smooth")

function nzPerks:GetPerkIcon(perk, setName)
if setName then
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
	else
	return nil
	end
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
nzPerks:RegisterIconSet("World at War/ Black Ops 1", "nz_moo/perk_icons/bo1/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Black Ops 2", "nz_moo/perk_icons/faithful_charred/", "nz_moo/perk_icons/charred_frame.png")
nzPerks:RegisterIconSet("Black Ops 3", "nz_moo/perk_icons/faitful_bo3/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Black Ops 4", "nz_moo/perk_icons/bo4/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Infinite Warfare", "nz_moo/perk_icons/iw/", "nz_moo/perk_icons/iw_frame.png")
nzPerks:RegisterIconSet("Modern Warfare", "nz_moo/perk_icons/mw/", "nz_moo/perk_icons/mw_frame.png")
nzPerks:RegisterIconSet("Cold War", "nz_moo/perk_icons/cw/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Vanguard", "nz_moo/perk_icons/griddy/", "nz_moo/perk_icons/griddy_frame.png")
nzPerks:RegisterIconSet("Classic Vanguard", "nz_moo/perk_icons/vangriddy_owl/", "nz_moo/perk_icons/griddy_frame.png")
nzPerks:RegisterIconSet("April Fools", "nz_moo/perk_icons/aprilfools/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("No Background", "nz_moo/perk_icons/no_background/", "nz_moo/perk_icons/no_frame.png")
nzPerks:RegisterIconSet("Shadows of Evil", "nz_moo/perk_icons/soe_v2/", "nz_moo/perk_icons/zod_frame.png")
nzPerks:RegisterIconSet("Classic Shadows of Evil", "nz_moo/perk_icons/soe/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("The Giant", "nz_moo/perk_icons/the_giant/", "nz_moo/perk_icons/zod_frame.png")
nzPerks:RegisterIconSet("WW2", "nz_moo/perk_icons/ww2/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Halloween", "nz_moo/perk_icons/halloween/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Christmas", "nz_moo/perk_icons/christmas/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Christmas", "nz_moo/perk_icons/christmas_classic/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Classic Halloween", "nz_moo/perk_icons/halloween_classic/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Neon", "nz_moo/perk_icons/neon/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Overgrown", "nz_moo/perk_icons/overgrown/", "nz_moo/perk_icons/perk_frame.png")
-- nzPerks:RegisterIconSet("Classic Overgrown", "nz_moo/perk_icons/overgrown_old/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("MW3 Zombies", "nz_moo/perk_icons/mw3z/", "nz_moo/perk_icons/mw3_frame.png")
nzPerks:RegisterIconSet("Frosted Flakes", "nz_moo/perk_icons/frosted_flakes/", "nz_moo/perk_icons/frosted_frame.png")
nzPerks:RegisterIconSet("Classic Frosted Flakes", "nz_moo/perk_icons/frosted/", "nz_moo/perk_icons/frost_frame.png")
nzPerks:RegisterIconSet("Pickle Glow", "nz_moo/perk_icons/pickle/", "nz_moo/perk_icons/pickle_frame.png")
nzPerks:RegisterIconSet("Herrenhaus", "nz_moo/perk_icons/herren/", "nz_moo/perk_icons/herren_frame.png")
nzPerks:RegisterIconSet("Paper", "nz_moo/perk_icons/paper/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Cheese Cube", "nz_moo/perk_icons/cheese/", "nz_moo/perk_icons/cheddar_frame.png")
nzPerks:RegisterIconSet("Charred", "nz_moo/perk_icons/bo2/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Ragnarok", "nz_moo/perk_icons/ragnarok/", "nz_moo/perk_icons/rag_frame.png")
nzPerks:RegisterIconSet("So Retro", "nz_moo/perk_icons/so_retro/", "nz_moo/perk_icons/pickle_frame.png")
nzPerks:RegisterIconSet("Thin & Simple", "nz_moo/perk_icons/bo3/", "nz_moo/perk_icons/perk_frame.png")
nzPerks:RegisterIconSet("Rezzurrection", "nz_moo/perk_icons/sam/", "nz_moo/perk_icons/sam_frame.png")
nzPerks:RegisterIconSet("Squared", "nz_moo/perk_icons/fizzy/", "nz_moo/perk_icons/fizzy_frame.png")
nzPerks:RegisterIconSet("Comic", "nz_moo/perk_icons/comic/", "nz_moo/perk_icons/comic_frame.png")
nzPerks:RegisterIconSet("Flask", "nz_moo/perk_icons/alchemy/", "nz_moo/perk_icons/sam_frame.png")
nzPerks:RegisterIconSet("Dead By Daylight", "nz_moo/perk_icons/dbd/", "nz_moo/perk_icons/dbd_frame.png")
nzPerks:RegisterIconSet("No Background Classic", "nz_moo/perk_icons/no_background_classic/", "nz_moo/perk_icons/no_frame.png")