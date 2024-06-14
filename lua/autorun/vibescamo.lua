if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.vibes.camos", function()
		nzCamos:NewCamo("bo3_datter_matter", {
			name = "Dark Matter (BO3)",
			camotable = {
				"camos/vibes/nz/darkmatter.vmt",
			},
		})
		
		nzCamos:NewCamo("black_hole", {
			name = "Black Hole",
			camotable = {
				"camos/vibes/nz/blackhole.vmt",
			},
		})
		
		nzCamos:NewCamo("dark_pulse", {
			name = "Dark Pulse",
			camotable = {
				"camos/vibes/nz/dark_pulse.vmt",
			},
		})
		
		nzCamos:NewCamo("dragon", {
			name = "Dragon",
			camotable = {
				"camos/vibes/nz/dragon.vmt",
			},
		})
		
		nzCamos:NewCamo("hologram", {
			name = "Hologram",
			camotable = {
				"camos/vibes/nz/holo.vmt",
			},
		})
		
		nzCamos:NewCamo("stars", {
			name = "Starry Night",
			camotable = {
				"camos/vibes/nz/stars.vmt",
			},
		})
		
			nzCamos:NewCamo("static", {
			name = "Bad Signal",
			camotable = {
				"camos/vibes/nz/static.vmt",
			},
		})

		nzCamos:NewCamo("bo3_diamond", {
			name = "Diamond (BO3)",
			camotable = {
				"camos/vibes/nz/diamond.vmt",
			},
		})
	end)
end