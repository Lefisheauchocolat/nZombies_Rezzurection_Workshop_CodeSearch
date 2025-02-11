
function nzQMenu.AddNewEntity( ent, icon, name )
	table.insert(nzQMenu.Data.Entities, {ent, icon, name})
end

-- QuickFunctions
PropMenuAddEntity = nzQMenu.AddNewEntity

--PropMenuAddEntity("edit_fog", "entities/edit_fog.png", "Base Fog Editor") -- Murdered for sucking
--PropMenuAddEntity("edit_fog_special", "entities/edit_fog.png", "Special Round Fog Editor") -- Also murdered for the same reason

PropMenuAddEntity("edit_sky", "entities/edit_sky.png", "Sky Editor")
PropMenuAddEntity("edit_sun", "entities/edit_sun.png", "Sun Editor")
PropMenuAddEntity("edit_color", "gmod/demo.png", "Color Correction Editor")
PropMenuAddEntity("nz_fire_effect", "icon16/fire.png", "Fire Effect")
--[[PropMenuAddEntity("nz_pparticle_ballcore", "icon16/cd.png", "Ball Core")
PropMenuAddEntity("nz_pparticle_core", "icon16/cd.png", "Core")
PropMenuAddEntity("nz_pparticle_portal", "icon16/ruby.png", "Magic Portal")
PropMenuAddEntity("nz_pparticle_magicflame", "icon16/fire.png", "Magic Flame")
PropMenuAddEntity("nz_pparticle_redvortex", "icon16/stop.png", "Red Vortex")
PropMenuAddEntity("nz_pparticle_snow", "icon16/weather_snow.png", "Snow")
PropMenuAddEntity("nz_pparticle_rain", "icon16/weather_rain.png", "Rain")
PropMenuAddEntity("nz_pparticle_wind", "icon16/weather_cloudy.png", "Wind")
PropMenuAddEntity("nz_pparticle_starfield", "icon16/star.png", "Starfield")
PropMenuAddEntity("nz_pparticle_africa", "icon16/contrast.png", "Black Hole")
PropMenuAddEntity("nz_pparticle_mcore", "icon16/pill.png", "Matrix Core")
PropMenuAddEntity("nz_pparticle_elecbeam", "icon16/lightning.png", "Electric Beam")
PropMenuAddEntity("nz_pparticle_rod_y", "icon16/lightning.png", "Energy Rod (Yellow)")
PropMenuAddEntity("nz_pparticle_rod_r", "icon16/lightning.png", "Energy Rod (Red)")
PropMenuAddEntity("nz_pparticle_rod_g", "icon16/lightning.png", "Energy Rod (Green)")
PropMenuAddEntity("nz_pparticle_rod_b", "icon16/lightning.png", "Energy Rod (Blue)")
PropMenuAddEntity("nz_pparticle_arc_s", "icon16/lightning.png", "Electricity Arc (Small)")
PropMenuAddEntity("nz_pparticle_arc", "icon16/lightning.png", "Electricity Arc")
PropMenuAddEntity("nz_pparticle_leaves", "icon16/world.png", "Leaves")
PropMenuAddEntity("nz_pparticle_forehead", "icon16/world.png", "Sakura Leaves")
PropMenuAddEntity("nz_pparticle_shrekseed", "icon16/bug.png", "Acid Puddle")
PropMenuAddEntity("nz_pparticle_gasleak", "icon16/fire.png", "Gas Leak Fire")
PropMenuAddEntity("nz_pparticle_fire_b", "icon16/tag_blue.png", "Small Fire (Blue)")
PropMenuAddEntity("nz_pparticle_fire_p", "icon16/tag_purple.png", "Small Fire (Purple)")
PropMenuAddEntity("nz_pparticle_fire_y", "icon16/tag_yellow.png", "Small Fire (Yellow)")
PropMenuAddEntity("nz_pparticle_fire_r", "icon16/tag_red.png", "Small Fire (Red)")
PropMenuAddEntity("nz_pparticle_fire_g", "icon16/tag_green.png", "Small Fire (Green)")
PropMenuAddEntity("nz_pparticle_fire_smol", "icon16/tag_orange.png", "Small Fire")
PropMenuAddEntity("nz_pparticle_bluntsmoke", "icon16/bomb.png", "Smoke Cloud")
PropMenuAddEntity("nz_pparticle_firestream", "icon16/fire.png", "Flame Stream(Large)")
PropMenuAddEntity("nz_pparticle_firestream2", "icon16/fire.png", "Flame Stream(Small)")
PropMenuAddEntity("nz_pparticle_firepit", "icon16/fire.png", "Ground Fire")
PropMenuAddEntity("nz_pparticle_firepit2", "icon16/fire.png", "Ground Fire(Alt)")
PropMenuAddEntity("nz_pparticle_firepit3", "icon16/fire.png", "Ground Fire(Alt 2)")
PropMenuAddEntity("nz_pparticle_embers", "icon16/fire.png", "Embers")
PropMenuAddEntity("nz_pparticle_embers2", "icon16/fire.png", "Embers(Secondary)")
PropMenuAddEntity("nz_pparticle_cykafire", "icon16/fire.png", "Molotov Fire")
PropMenuAddEntity("nz_pparticle_candle", "icon16/fire.png", "Candle Flame")]]
PropMenuAddEntity("edit_dynlight", "icon16/lightbulb.png", "Dynamic Light")
--PropMenuAddEntity("edit_damage", "icon16/lightbulb.png", "Damage")