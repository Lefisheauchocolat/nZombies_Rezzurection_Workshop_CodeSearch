if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.kate.camos", function()
		nzCamos:NewCamo("bo3_datter_matter", {
			name = "Dark Matter (BO3)",
			camotable = {
				"camos/kate/nz/darkmatter.vmt",
			},
		})
		
		nzCamos:NewCamo("black_hole", {
			name = "Black Hole",
			camotable = {
				"camos/kate/nz/blackhole.vmt",
			},
		})

		nzCamos:NewCamo("worm_hole", {
			name = "Worm Hole (Loonicity)",
			camotable = {
				"camos/kate/nz/void.vmt",
			},
		})

		nzCamos:NewCamo("nebula", {
			name = "Nebula (Loonicity)",
			camotable = {
				"camos/kate/nz/nebula/nebula.vmt",
			},
		})

		nzCamos:NewCamo("rainbow_ghost", {
			name = "Rainbow Ghost (Loonicity)",
			camotable = {
				"camos/kate/nz/rainbow_ghost/rainbow_ghost.vmt",
			},
		})

		nzCamos:NewCamo("aether_crystal", {
			name = "Aether Crystal (Loonicity)",
			camotable = {
				"camos/kate/nz/aether_crystal/aether_crystal.vmt",
			},
		})

		nzCamos:NewCamo("cult_skull", {
			name = "Cult Skull (Loonicity)",
			camotable = {
				"camos/kate/nz/cult_skull/cult_skull.vmt",
				"camos/kate/nz/cult_skull/cult_skull2.vmt",
			},
		})

		nzCamos:NewCamo("storm", {
			name = "Storm (BO3)",
			camotable = {
				"camos/vibes/nz/storm(BO3).vmt",
			},
		})

		nzCamos:NewCamo("blue_ritual", {
			name = "Blue Ritual (BO3)",
			camotable = {
				"camos/vibes/nz/BlueRitual(BO3).vmt",
			},
		})

		nzCamos:NewCamo("pnb_lines", {
			name = "PnB Lines (BO3)",
			camotable = {
				"camos/vibes/nz/PnB_lines.vmt",
			},
		})

		nzCamos:NewCamo("ice_fire", {
			name = "IceFire 115 (BO3)",
			camotable = {
				"camos/vibes/nz/IceFire115(BO3).vmt",
			},
		})
		nzCamos:NewCamo("bo2_motd", {
			name = "Afterlife (BO2)",
			camotable = {
				"camos/vibes/nz/pap_camo_motd.vmt",
			},
		})

		nzCamos:NewCamo("nuketown_remaster", {
			name = "Nuketown Remastered (BO3)",
			camotable = {
				"camos/kate/nz/vikky/tranzit_blue.vmt",
				"camos/kate/nz/vikky/tranzit_green.vmt",
				"camos/kate/nz/vikky/tranzit_purple.vmt",
				"camos/kate/nz/vikky/tranzit_red.vmt",
				"camos/kate/nz/vikky/tranzit_yellow.vmt",
			},
		})

		nzCamos:NewCamo("runes", {
			name = "Runes (Loonicity)",
			camotable = {
				"camos/kate/nz/runes/runes.vmt",
			},
		})

		nzCamos:NewCamo("i_diner", {
			name = "Diner (BO3)",
			camotable = {
				"camos/kate/nz/diner/i_diner_camo.vmt",
				"camos/kate/nz/diner/i_diner_camo_b.vmt",
				"camos/kate/nz/diner/i_diner_camo_c.vmt",
				"camos/kate/nz/diner/i_diner_camo_d.vmt",
			},
		})

		nzCamos:NewCamo("the_archon", {
			name = "The Archon (VG)",
			camotable = {
				"camos/kate/nz/archon/s4_archon1.vmt",
				"camos/kate/nz/archon/s4_archon2.vmt",
				"camos/kate/nz/archon/s4_archon3.vmt",
			},
		})

		nzCamos:NewCamo("the_archon_gradient", {
			name = "Prismatic Gems (Loonicity)",
			camotable = {
				"camos/kate/nz/archon/s4_archon_gradient1.vmt",
				"camos/kate/nz/archon/s4_archon_gradient2.vmt",
				"camos/kate/nz/archon/s4_archon_gradient3.vmt",
				"camos/kate/nz/archon/s4_archon_gradient4.vmt",
				"camos/kate/nz/archon/s4_archon_gradient5.vmt",
				"camos/kate/nz/archon/s4_archon_gradient6.vmt",
				"camos/kate/nz/archon/s4_archon_gradient7.vmt",
				"camos/kate/nz/archon/s4_archon_gradient8.vmt",
				"camos/kate/nz/archon/s4_archon_gradient9.vmt",
				"camos/kate/nz/archon/s4_archon_gradient10.vmt",
			},
		})

				nzCamos:NewCamo("the_archon_lava", {
			name = "Charcoal (Loonicity)",
			camotable = {
				"camos/kate/nz/archon/s4_archon_lava.vmt",
			},
		})

				nzCamos:NewCamo("the_archon_divine", {
			name = "Divine Breakthrough (Loonicity)",
			camotable = {
				"camos/kate/nz/archon/s4_archon_divine.vmt",
			},
		})


			nzCamos:NewCamo("legacy_archon", {
			name = "The Archon - Legacy (VG)",
			camotable = {
				"camos/kate/nz/archon/s4_archon1_legacy.vmt",
				"camos/kate/nz/archon/s4_archon2_legacy.vmt",
				"camos/kate/nz/archon/s4_archon3_legacy.vmt",
			},
		})

		nzCamos:NewCamo("der_anfang", {
			name = "Der Anfang (VG)",
			camotable = {
				"camos/kate/nz/anfang/s4_anfang.vmt",
				"camos/kate/nz/anfang/s4_anfang2.vmt",
				"camos/kate/nz/anfang/s4_anfang3.vmt",
			},
		})

		nzCamos:NewCamo("legacy_anfang", {
			name = "Der Anfang - Legacy (VG)",
			camotable = {
				"camos/kate/nz/anfang/s4_anfang_legacy.vmt",
				"camos/kate/nz/anfang/s4_anfang2_legacy.vmt",
				"camos/kate/nz/anfang/s4_anfang3_legacy.vmt",
			},
		})

				nzCamos:NewCamo("115_red", {
			name = "Element 115 (Red)",
			camotable = {
				"camos/kate/nz/115_red/115hd_red.vmt",
			},
		})
		
		nzCamos:NewCamo("dark_pulse", {
			name = "Dark Pulse",
			camotable = {
				"camos/kate/nz/dark_pulse.vmt",
			},
		})
		
		nzCamos:NewCamo("dragon", {
			name = "Dragon",
			camotable = {
				"camos/kate/nz/dragon.vmt",
			},
		})
		
		nzCamos:NewCamo("hologram", {
			name = "Hologram",
			camotable = {
				"camos/kate/nz/holo.vmt",
			},
		})
		
		nzCamos:NewCamo("stars", {
			name = "Starry Night",
			camotable = {
				"camos/kate/nz/stars.vmt",
			},
		})
		
			nzCamos:NewCamo("static", {
			name = "Bad Signal",
			camotable = {
				"camos/kate/nz/static.vmt",
			},
		})

		nzCamos:NewCamo("bo3_diamond", {
			name = "Diamond (BO3)",
			camotable = {
				"camos/kate/nz/diamond.vmt",
			},
		})
		
				nzCamos:NewCamo("spooky_night", {
			name = "Spooky Night (Loonicity)",
			camotable = {
				"camos/kate/nz/spooky_night.vmt",
			},
		})

				nzCamos:NewCamo("the_jack_o_lantern", {
			name = "Halloween (Loonicity)",
			camotable = {
				"camos/kate/nz/halloween/spook.vmt",
				"camos/kate/nz/halloween/candy_corn.vmt",
				"camos/kate/nz/halloween/stars.vmt",
				"camos/kate/nz/halloween/ghost.vmt",
				"camos/kate/nz/halloween/skulls.vmt",
				"camos/kate/nz/halloween/monster_mash.vmt",
			},
		})
		
		nzCamos:NewCamo("bacon", {
			name = "Bacon (BO2)",
			camotable = {
				"camos/kate/nz/bacon.vmt",
			},
		})
		
		nzCamos:NewCamo("plaguediamond", {
			name = "Plague Diamond (BOCW)",
			camotable = {
				"camos/kate/nz/plaguediamond.vmt",
			},
		})
		
		nzCamos:NewCamo("gold_matter", {
			name = "Gold Matter",
			camotable = {
				"camos/kate/nz/gold_matter.vmt",
			},
		})
		
		nzCamos:NewCamo("aetherial_wave", {
			name = "Aetherial Wave (Loonicity)",
			camotable = {
				"camos/kate/nz/aetherial_wave/blue_wave.vmt",
				"camos/kate/nz/aetherial_wave/green_wave.vmt",
				"camos/kate/nz/aetherial_wave/magenta_wave.vmt",
				"camos/kate/nz/aetherial_wave/red_wave.vmt",
				"camos/kate/nz/aetherial_wave/mtndew_wave.vmt",
				"camos/kate/nz/aetherial_wave/xray_wave.vmt",
				"camos/kate/nz/aetherial_wave/shit_wave.vmt",
				"camos/kate/nz/aetherial_wave/turqoise_wave.vmt",
				"camos/kate/nz/aetherial_wave/rose_wave.vmt",
				"camos/kate/nz/aetherial_wave/electric_wave.vmt",
				"camos/kate/nz/aetherial_wave/yellow_wave.vmt",
				"camos/kate/nz/aetherial_wave/urple_wave.vmt",
			},
		})
		
		nzCamos:NewCamo("burn", {
			name = "Solar Flare",
			camotable = {
				"camos/kate/nz/burn.vmt",
			},
		})
		
		nzCamos:NewCamo("ripple", {
			name = "Ripple",
			camotable = {
				"camos/kate/nz/ripple.vmt",
			},
		})
	end)
end