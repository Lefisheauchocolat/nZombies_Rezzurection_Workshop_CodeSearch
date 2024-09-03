nzGum = nzGum or {}

nzGum.Gums = {}

nzGum.Types = {
	USABLE = 1, //purple
	USABLE_WITH_TIMER = 2, //purple
	ROUNDS = 3, //blue
	SPECIAL = 4, //orange
	TIME = 5, //green
}

nzGum.RareTypes = {
	DEFAULT = 1,
	MEGA = 2,
	RAREMEGA = 3,
	ULTRARAREMEGA = 4,
	PINWHEEL = 5,
}

nzGum.RarityNames = {
	[nzGum.RareTypes.DEFAULT] = "Normal",
	[nzGum.RareTypes.MEGA] = "Mega",
	[nzGum.RareTypes.RAREMEGA] = "Rare Mega",
	[nzGum.RareTypes.ULTRARAREMEGA] = "Ultra",
	[nzGum.RareTypes.PINWHEEL] = "Whimsical",
}

nzGum.TypeColors = {
	[nzGum.Types.USABLE] = Color(156, 41, 194, 255),
	[nzGum.Types.USABLE_WITH_TIMER] = Color(156, 41, 194, 255),
	[nzGum.Types.ROUNDS] = Color(16, 170, 206, 255),
	[nzGum.Types.SPECIAL] = Color(206, 156, 24, 255),
	[nzGum.Types.TIME] = Color(51, 195, 54, 255),
}

nzGum.Skins = {
	[nzGum.RareTypes.DEFAULT] = {
		[nzGum.Types.USABLE] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_regular_purple.vmt",
		[nzGum.Types.USABLE_WITH_TIMER] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_regular_purple.vmt",
		[nzGum.Types.TIME] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_regular_green.vmt",
		[nzGum.Types.ROUNDS] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_regular_blue.vmt",
		[nzGum.Types.SPECIAL] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_regular_orange.vmt",
	},
	[nzGum.RareTypes.MEGA] = {
		[nzGum.Types.USABLE] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_mega_purple.vmt",
		[nzGum.Types.USABLE_WITH_TIMER] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_mega_purple.vmt",
		[nzGum.Types.TIME] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_mega_green.vmt",
		[nzGum.Types.ROUNDS] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_mega_blue.vmt",
		[nzGum.Types.SPECIAL] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_mega_orange.vmt",
	},
	[nzGum.RareTypes.RAREMEGA] = {
		[nzGum.Types.USABLE] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_rare_mega_purple.vmt",
		[nzGum.Types.USABLE_WITH_TIMER] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_rare_mega_purple.vmt",
		[nzGum.Types.TIME] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_rare_mega_green.vmt",
		[nzGum.Types.ROUNDS] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_rare_mega_blue.vmt",
		[nzGum.Types.SPECIAL] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_rare_mega_orange.vmt",
	},
	[nzGum.RareTypes.ULTRARAREMEGA] = {
		[nzGum.Types.USABLE] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_ultra_rare_mega_purple.vmt",
		[nzGum.Types.USABLE_WITH_TIMER] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_ultra_rare_mega_purple.vmt",
		[nzGum.Types.TIME] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_ultra_rare_mega_green.vmt",
		[nzGum.Types.ROUNDS] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_ultra_rare_mega_blue.vmt",
		[nzGum.Types.SPECIAL] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_ultra_rare_mega_orange.vmt",
	},
	[nzGum.RareTypes.PINWHEEL] = {
		[nzGum.Types.USABLE] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_whim_purple.vmt",
		[nzGum.Types.USABLE_WITH_TIMER] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_whim_purple.vmt",
		[nzGum.Types.TIME] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_whim_green.vmt",
		[nzGum.Types.ROUNDS] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_whim_blue.vmt",
		[nzGum.Types.SPECIAL] = "models/bo3/gobblegum/gum/mtl_p7_zm_bgb_whim_orange.vmt",
	},
}

//for selecting a random gum
nzGum.RollData = {}

//default chance for all gums
nzGum.RollChance = 10

//default round modulo for resetting all gum chances
nzGum.RollChanceResetRounds = 10

//default round interval for a gum's count to get reset
nzGum.RollCountResetRounds = {
	[nzGum.RareTypes.DEFAULT] = 4,
	[nzGum.RareTypes.MEGA] = 4,
	[nzGum.RareTypes.RAREMEGA] = 6,
	[nzGum.RareTypes.ULTRARAREMEGA] = 8,
	[nzGum.RareTypes.PINWHEEL] = 2,
}

//default chance modifier for gums based on rarity
nzGum.ChanceMultiplier = {
	[nzGum.RareTypes.DEFAULT] = 1,
	[nzGum.RareTypes.MEGA] = 0.4,
	[nzGum.RareTypes.RAREMEGA] = 0.2,
	[nzGum.RareTypes.ULTRARAREMEGA] = 0.1,
	[nzGum.RareTypes.PINWHEEL] = 0.2,
}

//default amount of each gum based on rarity
nzGum.RollCounts = {
	[nzGum.RareTypes.DEFAULT] = 4,
	[nzGum.RareTypes.MEGA] = 2,
	[nzGum.RareTypes.RAREMEGA] = 2,
	[nzGum.RareTypes.ULTRARAREMEGA] = 1,
	[nzGum.RareTypes.PINWHEEL] = 1,
}

//default prices for spinning a gum
nzGum.RoundPrices = {
	[1] = 1500, //1-9
	[2] = 2500, //10-19
	[3] = 4500, //20-29
	[4] = 9500, //30-39
	[5] = 16500, //40-49
	[6] = 32500, //50-59
	[7] = 64500, //60-69
	[8] = 128500, //70-79
	[9] = 256500, //80-89
	[10] = 512500, //90-99
	[11] = 1024500, //100-255
}

//gum specific data
nzGum.TemporalGiftTime = 0
nzGum.ProfitSharingDist = 1024^2
nzGum.ProfitSharingPlayers = {}
