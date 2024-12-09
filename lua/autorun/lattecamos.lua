if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.latte.camos", function()
		
		nzCamos:NewCamo("suits", {
			name = "Suits (latte)",
			camotable = {
				"camos/nz/suits/suits_1.vmt",
				"camos/nz/suits/suits_2.vmt",
				"camos/nz/suits/suits_3.vmt",
				"camos/nz/suits/suits_4.vmt",
				"camos/nz/suits/suits_5.vmt",
				"camos/nz/suits/suits_6.vmt",
				"camos/nz/suits/suits_7.vmt",
				"camos/nz/suits/suits_8.vmt",
				"camos/nz/suits/suits_9.vmt",
				"camos/nz/suits/suits_10.vmt",
			},
		})

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

		nzCamos:NewCamo("holographic_latte", {
			name = "Holographic (latte)",
			camotable = {
				"camos/nz/holographic/holo1.vmt",
				"camos/nz/holographic/holo2.vmt",
				"camos/nz/holographic/holo3.vmt",
				"camos/nz/holographic/holo4.vmt",
				"camos/nz/holographic/holo5.vmt",
				"camos/nz/holographic/holo6.vmt",
				"camos/nz/holographic/holo7.vmt",
				"camos/nz/holographic/holo8.vmt",
				"camos/nz/holographic/holo9.vmt",
			},
		})

		nzCamos:NewCamo("christmas_space_latte", {
			name = "Jolly Night (latte)",
			camotable = {
				"camos/nz/nz/starryjolly/starryjolly.vmt",
			},
		})
		nzCamos:NewCamo("cdm_floral", {
			name = "Floral (Owl)",
			camotable = {
				"camos/nz/floral/floralcdm.vmt",
				"camos/nz/floral/floralcdm_2.vmt",
				"camos/nz/floral/floralcdm_3.vmt",
			},
		})
		nzCamos:NewCamo("mw_gold", {
			name = "Gold (Owl)",
			camotable = {
				"camos/nz/gold/saxxy_beast.vmt",
			},
		})
		nzCamos:NewCamo("blueprint", {
			name = "Classified (Owl)",
			camotable = {
				"camos/nz/blueprint/blueprint_1.vmt",
				"camos/nz/blueprint/blueprint_2.vmt",
				"camos/nz/blueprint/blueprint_3.vmt",
				"camos/nz/blueprint/blueprint_4.vmt",
				"camos/nz/blueprint/blueprint_5.vmt",
			},
		})
		nzCamos:NewCamo("mello", {
			name = "Crazy Place (Owl)",
			camotable = {
				"camos/nz/mello/mello_pap.vmt",
				"camos/nz/mello/mello_pap2.vmt",
				"camos/nz/mello/mello_pap3.vmt",
				"camos/nz/mello/mello_pap4.vmt",
				"camos/nz/mello/mello_pap5.vmt",
			},
		})
		nzCamos:NewCamo("tiger", {
			name = "Night Tiger (Owl)",
			camotable = {
				"camos/nz/tiger/tigerpap.vmt",
				"camos/nz/tiger/tigerpap2.vmt",
				"camos/nz/tiger/tigerpap3.vmt",
				"camos/nz/tiger/tigerpap4.vmt",
				"camos/nz/tiger/tigerpap5.vmt",
				"camos/nz/tiger/tigerpap6.vmt",
			},
		})
		nzCamos:NewCamo("bocw", {
			name = "Conviction (Owl)",
			camotable = {
				"camos/nz/bocw/bocw_pap.vmt",
				"camos/nz/bocw/bocw_pap2.vmt",
				"camos/nz/bocw/bocw_pap3.vmt",
				"camos/nz/bocw/bocw_pap4.vmt",
				"camos/nz/bocw/bocw_pap5.vmt",
				"camos/nz/bocw/bocw_pap6.vmt",
				"camos/nz/bocw/bocw_pap7.vmt",
			},
		})
		nzCamos:NewCamo("pride", {
			name = "Pride Camo (Owl)",
			camotable = {
				"camos/nz/pride/pride_1.vmt",
				"camos/nz/pride/pride_2.vmt",
				"camos/nz/pride/pride_3.vmt",
				"camos/nz/pride/pride_4.vmt",
				"camos/nz/pride/pride_5.vmt",
				"camos/nz/pride/pride_6.vmt",
				"camos/nz/pride/pride_7.vmt",
				"camos/nz/pride/pride_8.vmt",
				"camos/nz/pride/pride_9.vmt",
				"camos/nz/pride/pride_10.vmt",
				"camos/nz/pride/pride_11.vmt",
				"camos/nz/pride/pride_12.vmt",
				"camos/nz/pride/pride_13.vmt",
			},
		})
	end)
end