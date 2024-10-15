
-- Moo Particles
game.AddParticles("particles/moo_misc_fx.pcf")
game.AddParticles("particles/loonicity_particles.pcf")
game.AddParticles("particles/temp_fx.pcf")
game.AddParticles("particles/tomb_pap_red.pcf")

PrecacheParticleSystem("zmb_mutated_electric_aura")
PrecacheParticleSystem("zmb_mutated_electric_attack")
PrecacheParticleSystem("zmb_mutated_electric_attack_tell")
PrecacheParticleSystem("zmb_mutated_electric_step")
PrecacheParticleSystem("zmb_mutated_water_aura")
PrecacheParticleSystem("zmb_mutated_water_step")
PrecacheParticleSystem("zmb_mutated_plasma_aura")
PrecacheParticleSystem("zmb_mutated_plasma_step")

PrecacheParticleSystem("zmb_firepit")
PrecacheParticleSystem("zmb_dog_spawn_fireball")

PrecacheParticleSystem("zmb_abom_beam")

PrecacheParticleSystem("zmb_smoker_aura")
PrecacheParticleSystem("zmb_smoker_cloud")

PrecacheParticleSystem("zmb_disciple_aura")
PrecacheParticleSystem("zmb_disciple_blast")
PrecacheParticleSystem("zmb_disciple_hand_blast")
PrecacheParticleSystem("zmb_disciple_lifedrain")

PrecacheParticleSystem("zmb_trickster_aura")
PrecacheParticleSystem("zmb_trickster_portal")
PrecacheParticleSystem("zmb_trickster_charge_tell")
PrecacheParticleSystem("zmb_trickster_mine")
PrecacheParticleSystem("zmb_trickster_mine_blast")

PrecacheParticleSystem("zmb_mimic_mouth")
PrecacheParticleSystem("zmb_mimic_trans")
PrecacheParticleSystem("zmb_mimic_hide")

PrecacheParticleSystem("zmb_explosive_zombie_aura")
PrecacheParticleSystem("zmb_explosive_zombie_step")
PrecacheParticleSystem("zmb_explosive_zombie_explo")

PrecacheParticleSystem("zmb_screamer_shoulder")

PrecacheParticleSystem("zmb_monster_explosion")

PrecacheParticleSystem("tomb_pap_eye")
PrecacheParticleSystem("tomb_pap_roller")
PrecacheParticleSystem("tomb_pap_roller_lens_flare")
PrecacheParticleSystem("tomb_pap_eye_red")
PrecacheParticleSystem("tomb_pap_roller_red")
PrecacheParticleSystem("tomb_pap_roller_lens_flare_red")

PrecacheParticleSystem("tomb_box_aura")


-- SNPC Particles
game.AddParticles("particles/horror/bloodsplosion.pcf")
game.AddParticles("particles/alien_swarm/mnb_flamethrower.pcf")
game.AddParticles("particles/starship_troopers/sst_acidbug_fx.pcf")
game.AddParticles("particles/halo/main_effects.pcf")
game.AddParticles("particles/doom/doom_fx.pcf")
game.AddParticles("particles/half-life_alyx/hla_antlion_blue_fx.pcf")
game.AddParticles("particles/half-life_alyx/hla_antlion_orange_fx.pcf")
game.AddParticles("particles/npcarmor.pcf")

PrecacheParticleSystem("spit_impact_blue")
PrecacheParticleSystem("spit_impact_orange")
PrecacheParticleSystem("spit_impact_yellow") -- Was blue, but recolored it yellow.
PrecacheParticleSystem("spit_trail_blue")
PrecacheParticleSystem("spit_trail_orange")
PrecacheParticleSystem("spit_trail_glow_yellow")
PrecacheParticleSystem("asw_mnb_flamethrower")
PrecacheParticleSystem("acidbug_spit_trail")
PrecacheParticleSystem("acidbug_spit_impact")
PrecacheParticleSystem("horror_bloodgibs")
PrecacheParticleSystem("horror_bloodsplosion")
PrecacheParticleSystem("horror_bloodsplosion_gib")
PrecacheParticleSystem("hcea_hunter_ab_charge")
PrecacheParticleSystem("hcea_hunter_ab_muzzle")
PrecacheParticleSystem("doom_wraith_teleport")
PrecacheParticleSystem("doom_hellunit_aura")
PrecacheParticleSystem("doom_caco_blast")
PrecacheParticleSystem("doom_mancu_blast")
PrecacheParticleSystem("ins_blood_impact_generic")
PrecacheParticleSystem("npcarmor_hit")
PrecacheParticleSystem("npcarmor_break")

-- Misc/Other Particles
game.AddParticles("particles/drops_powerups_new.pcf")
PrecacheParticleSystem("nz_powerup_classic_intro")
PrecacheParticleSystem("nz_powerup_classic_loop")
PrecacheParticleSystem("nz_powerup_poof")

game.AddParticles("particles/driese_fx.pcf")
game.AddParticles("particles/brutus_burning_footstep.pcf")
game.AddParticles("particles/vman_explosion.pcf")

PrecacheParticleSystem("driese_tp_arrival_ambient")
PrecacheParticleSystem("driese_tp_arrival_ambient_lightning")
PrecacheParticleSystem("driese_tp_arrival_ambient_xy")
PrecacheParticleSystem("driese_tp_arrival_phase1")
PrecacheParticleSystem("driese_tp_arrival_phase2")
PrecacheParticleSystem("driese_tp_arrival_impact_fx02_a")
PrecacheParticleSystem("driese_tp_arrival_lightning_static_1")
PrecacheParticleSystem("driese_tp_departure_phase1")
PrecacheParticleSystem("driese_tp_departure_phase2")
PrecacheParticleSystem("lightning_hit_swave_xy")
PrecacheParticleSystem("lightning_hit_swave_xz")
PrecacheParticleSystem("brutus_burning_footstep")
PrecacheParticleSystem("dusty_explosion_rockets")


sound.Add(
{
    name = "CoDZ_Zombie.BodyFall",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_00.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_01.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_02.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_03.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_04.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_05.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_06.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_07.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_08.mp3",
        "nz_moo/zombies/fly/bodyfall/fly_bodyfall_generic_09.mp3",
    }
})
sound.Add(
{
    name = "CoDZ_Zombie.JumpLand_Heavy",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_00.mp3",
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_01.mp3",
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_02.mp3",
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_03.mp3",
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_04.mp3",
        "nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_05.mp3",
    }
})
sound.Add(
{
    name = "CoDZ_Zombie.JumpLand_Light",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_00.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_01.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_02.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_03.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_04.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_05.mp3",
        "nz_moo/zombies/fly/jumpland_light/bodyfall_light_06.mp3",
    }
})
sound.Add(
{
    name = "CoDZ_Zombie.Ground_ClimbOut",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/traverse_ground_climbout/fly_zombie_crawl_dirt_00.mp3",
        "nz_moo/zombies/fly/traverse_ground_climbout/fly_zombie_crawl_dirt_01.mp3",
        "nz_moo/zombies/fly/traverse_ground_climbout/fly_zombie_crawl_dirt_02.mp3",
    }
})
sound.Add(
{
    name = "CoDZ_Zombie.Mantle_Slow",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/mantle_slow/mantle_slow_00.mp3",
        "nz_moo/zombies/fly/mantle_slow/mantle_slow_01.mp3",
        "nz_moo/zombies/fly/mantle_slow/mantle_slow_02.mp3",
    }
})
sound.Add(
{
    name = "CoDZ_Zombie.Mantle_Quick",
    channel = CHAN_AUTO,
    volume = 0.90,
    soundlevel = 50,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/zombies/fly/mantle_quick/mantle_quick_00.mp3",
        "nz_moo/zombies/fly/mantle_quick/mantle_quick_01.mp3",
        "nz_moo/zombies/fly/mantle_quick/mantle_quick_02.mp3",
    }
})

--[[ PLANKS ]]--


sound.Add(
{
    name = "CoDZ_Barricade.Snap",
    channel = CHAN_AUTO,
    volume = 1.50,
    soundlevel = 100,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/snap/_old/snap_00.mp3",
        "nz_moo/barricade/snap/_old/snap_01.mp3",
        "nz_moo/barricade/snap/_old/snap_02.mp3",
        "nz_moo/barricade/snap/_old/snap_03.mp3",
        "nz_moo/barricade/snap/_old/snap_04.mp3",
        "nz_moo/barricade/snap/_old/snap_05.mp3",
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Slam",
    channel = CHAN_AUTO,
    volume = 1.10,
    soundlevel = 100,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/slam/slam_00.mp3",
        "nz_moo/barricade/slam/slam_01.mp3",
        "nz_moo/barricade/slam/slam_02.mp3",
        "nz_moo/barricade/slam/slam_03.mp3",
        "nz_moo/barricade/slam/slam_04.mp3",
        "nz_moo/barricade/slam/slam_05.mp3",
    }
})


sound.Add(
{
    name = "CoDZ_Barricade.SlatSnap",
    channel = CHAN_AUTO,
    volume = 1.50,
    soundlevel = 100,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/vent_slats/remove/evt_slat_remove_00.mp3",
        "nz_moo/barricade/vent_slats/remove/evt_slat_remove_01.mp3",
        "nz_moo/barricade/vent_slats/remove/evt_slat_remove_02.mp3",
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.SlatSlam",
    channel = CHAN_AUTO,
    volume = 1.10,
    soundlevel = 100,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/vent_slats/repair/evt_slat_repair_00.mp3",
        "nz_moo/barricade/vent_slats/repair/evt_slat_repair_01.mp3",
        "nz_moo/barricade/vent_slats/repair/evt_slat_repair_02.mp3",
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Float",
    channel = CHAN_AUTO,
    volume = 1.10,
    soundlevel = 150,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/float_00.mp3"
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Repair",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = 150,
    --pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/board_repair_old.mp3"
    }
})


sound.Add(
{
    name = "CoDZ_Barricade.Snap_ZHD",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = SNDLVL_NORM,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/snap/_zhd/snap_zhd_00.mp3",
        "nz_moo/barricade/snap/_zhd/snap_zhd_01.mp3",
        "nz_moo/barricade/snap/_zhd/snap_zhd_02.mp3",
        "nz_moo/barricade/snap/_zhd/snap_zhd_03.mp3",
        "nz_moo/barricade/snap/_zhd/snap_zhd_04.mp3",
        "nz_moo/barricade/snap/_zhd/snap_zhd_05.mp3",
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Slam_ZHD",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = SNDLVL_NORM,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/slam/new/slam_new_00.mp3",
        "nz_moo/barricade/slam/new/slam_new_01.mp3",
        "nz_moo/barricade/slam/new/slam_new_02.mp3",
        "nz_moo/barricade/slam/new/slam_new_03.mp3",
        "nz_moo/barricade/slam/new/slam_new_04.mp3",
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Repair_ZHD",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = SNDLVL_NORM,
    --pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/board_repair_zhd.mp3",
    }
})
