if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.owl.camos", function()
		nzCamos:NewCamo("cdm_floral", {
			name = "Floral",
			camotable = {
				"camos/floral/floralcdm.vmt",
				"camos/floral/floralcdm_2.vmt",
				"camos/floral/floralcdm_3.vmt",
			},
		})
		nzCamos:NewCamo("mw_gold", {
			name = "Gold",
			camotable = {
				"camos/gold/saxxy_beast.vmt",
			},
		})
		nzCamos:NewCamo("blueprint", {
			name = "Classified",
			camotable = {
				"camos/blueprint/blueprint_1.vmt",
				"camos/blueprint/blueprint_2.vmt",
				"camos/blueprint/blueprint_3.vmt",
				"camos/blueprint/blueprint_4.vmt",
				"camos/blueprint/blueprint_5.vmt",
			},
		})
		nzCamos:NewCamo("mello", {
			name = "Crazy Place",
			camotable = {
				"camos/mello/mello_pap.vmt",
				"camos/mello/mello_pap2.vmt",
				"camos/mello/mello_pap3.vmt",
				"camos/mello/mello_pap4.vmt",
				"camos/mello/mello_pap5.vmt",
			},
		})
		nzCamos:NewCamo("tiger", {
			name = "Night Tiger",
			camotable = {
				"camos/tiger/tigerpap.vmt",
				"camos/tiger/tigerpap2.vmt",
				"camos/tiger/tigerpap3.vmt",
				"camos/tiger/tigerpap4.vmt",
				"camos/tiger/tigerpap5.vmt",
				"camos/tiger/tigerpap6.vmt",
			},
		})
		nzCamos:NewCamo("bocw", {
			name = "Conviction",
			camotable = {
				"camos/bocw/bocw_pap.vmt",
				"camos/bocw/bocw_pap2.vmt",
				"camos/bocw/bocw_pap3.vmt",
				"camos/bocw/bocw_pap4.vmt",
				"camos/bocw/bocw_pap5.vmt",
				"camos/bocw/bocw_pap6.vmt",
				"camos/bocw/bocw_pap7.vmt",
			},
		})
		nzCamos:NewCamo("pride", {
			name = "Pride Camo",
			camotable = {
				"camos/pride/pride_1.vmt",
				"camos/pride/pride_2.vmt",
				"camos/pride/pride_3.vmt",
				"camos/pride/pride_4.vmt",
				"camos/pride/pride_5.vmt",
				"camos/pride/pride_6.vmt",
				"camos/pride/pride_7.vmt",
				"camos/pride/pride_8.vmt",
				"camos/pride/pride_9.vmt",
				"camos/pride/pride_10.vmt",
				"camos/pride/pride_11.vmt",
				"camos/pride/pride_12.vmt",
				"camos/pride/pride_13.vmt",
			},
		})
	end)
end