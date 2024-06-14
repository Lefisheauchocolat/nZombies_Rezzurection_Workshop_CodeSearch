if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nZ.Moo.Stole.From.The.Owl.Camos", function()
		nzCamos:NewCamo("cc_cheesecubepap", {
			name = "Cheese-Cube (Kinda)",
			camotable = {
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
				"nz_moo/camo/cheesecube/zk_cheese.vmt",
			},
		})
		nzCamos:NewCamo("ugx_lavamagma", {
			name = "UGX Lava",
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
	end)
end