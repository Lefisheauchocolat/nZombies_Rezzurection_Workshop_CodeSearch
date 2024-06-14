
--[[ PLANKS ]]--

sound.Add(
{
    name = "CoDZ_Barricade.Slam_ZHD",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = 100,
    pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/slam/new/slam_new_00.mp3",
        "nz_moo/barricade/slam/new/slam_new_01.mp3",
        "nz_moo/barricade/slam/new/slam_new_02.mp3",
        "nz_moo/barricade/slam/new/slam_new_03.mp3",
        "nz_moo/barricade/slam/new/slam_new_04.mp3"
    }
})

sound.Add(
{
    name = "CoDZ_Barricade.Repair_ZHD",
    channel = CHAN_AUTO,
    volume = 1.00,
    soundlevel = 150,
    --pitch = { 95, 105 },
    sound = {
        "nz_moo/barricade/board_repair_zhd.mp3"
    }
})


-- Zombies
util.PrecacheModel("models/moo/_codz_ports/moo_codz_anims_base.mdl")
util.PrecacheModel("models/moo/_codz_ports/s2/zombie_island/moo_codz_s2_assassin.mdl")
util.PrecacheModel("models/moo/_codz_ports/t8/escape/moo_codz_t8_mob_warden.mdl")
util.PrecacheModel("models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_mechz.mdl")
util.PrecacheModel("models/moo/_codz_ports/t7/castle/moo_codz_t7_mechz.mdl")
util.PrecacheModel("models/moo/_codz_ports/s2/zombie/moo_codz_s2_fireman.mdl")
util.PrecacheModel("models/moo/_codz_ports/s2/zombie/moo_codz_s2_infantrya.mdl")
util.PrecacheModel("models/moo/_codz_ports/s2/zombie/moo_codz_s2_snipera.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_honorguard.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_honorguard_ww1.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_honorguard_green.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_shirtless.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_shirtless_green.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_tanktop.mdl")
util.PrecacheModel("models/moo/_codz_ports/t9/silver/moo_codz_t9_silver_tanktop_gore.mdl")