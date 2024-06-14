if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.latte.camos", function()
		
--		nzCamos:NewCamo("boykisser_camo_latte", {
--			name = "I know what you are (latte)",
--			camotable = {
--				"camos/nz/boykisser.vmt",
--			},
--		})

		nzCamos:NewCamo("Milk", {
			name = "Milk (latte)",
			camotable = {
				"camos/nz/milk/milk1.vmt",
				"camos/nz/milk/milk2.vmt",
				"camos/nz/milk/milk3.vmt",
				"camos/nz/milk/milk4.vmt",
				"camos/nz/milk/milk5.vmt",
				"camos/nz/milk/milk6.vmt",
			},
		})
		
		nzCamos:NewCamo("christmas_space_latte", {
			name = "Jolly Night (latte)",
			camotable = {
				"camos/nz/starryjolly.vmt",
			},
		})
	end)
end