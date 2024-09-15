if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nZ.Moo.Stole.From.The.Owl.Camos", function()
		nzCamos:NewCamo("cc_cheesecubepap", {
			name = "Cheese-Cube (W@W)",
			camotable = {
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
			},
		})
		nzCamos:NewCamo("ugx_lavamagma", {
			name = "UGX Lava (W@W)",
			camotable = {
				"nz_moo/camo/ugx_lava/ugx_lava_red.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_green.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_blue.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_cyan.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_yellow.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_pink.vmt",
				"nz_moo/camo/ugx_lava/ugx_lava_purple.vmt",
			},
		})
		nzCamos:NewCamo("mwz_dnapapilovecontracts", {
			name = "DNA (MWZ)",
			camotable = {
				"nz_moo/camo/mw3_dna/mwz_pap_lvl1.vmt",
				"nz_moo/camo/mw3_dna/mwz_pap_lvl2.vmt",
				"nz_moo/camo/mw3_dna/mwz_pap_lvl3.vmt",
			},
		})
		nzCamos:NewCamo("fearreaper_powerofskittles", {
			name = "Stained Glass (W@W)",
			camotable = {
				"nz_moo/camo/stained_glass/fearreaper_stainedglass.vmt",
			},
		})
		nzCamos:NewCamo("sethnorris_madeagoodmapforwaw_thenmesseditupforbo3", {
			name = "Das Herrenhaus (W@W)",
			camotable = {
				"nz_moo/camo/herrenhaus/flutentooten.vmt",
			},
		})
		nzCamos:NewCamo("derburgerking", {
			name = "Der Berg (W@W)",
			camotable = {
				"nz_moo/camo/derberg/der_burger.vmt",
			},
		})
	end)
end