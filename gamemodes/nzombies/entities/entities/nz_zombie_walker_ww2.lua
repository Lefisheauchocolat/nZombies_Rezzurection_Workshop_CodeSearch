AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/s2_zombies/gen/mtl_zom_eye_fdr03.vmt"),
		[1] = Material("models/moo/codz/s2_zombies/gen/mtl_zom_eye_fdr04_org1.vmt"),
		[2] = Material("models/moo/codz/s2_zombies/gen/mtl_zom_head_fdr02_gore.vmt"),
	}

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self.RedEyes == true and self:IsAlive() and !self:GetDecapitated() and !self:GetMooSpecial() and !self.IsMooSpecial then
			self:DrawEyeGlow() 
		end

		if self:WaterBuff() and !self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 50
				elight.b = 255
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:BomberBuff() and !self:WaterBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 150
				elight.g = 255
				elight.b = 75
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:WaterBuff() and self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 0
				elight.b = 0
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end

		self:ZCTFire()
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
	end

	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105
ENT.SoundVolume = 95

ENT.Models = {
	{Model = "models/moo/_codz_ports/s2/zombie/moo_codz_s2_zom_infantrya_3arc.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s2/zombie/moo_codz_s2_zom_snipera_3arc.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

local crawlspawnwalk = {"nz_base_zombie_crawl_out_walk_01",}
local crawlspawnrun = {"nz_base_zombie_crawl_out_run_01","nz_base_zombie_crawl_out_run_02",}
local crawlspawnsprint = {"nz_base_zombie_crawl_out_sprint_01","nz_base_zombie_crawl_out_sprint_01",}
ENT.DeathSequences = {
	"nz_death_1",
	"nz_death_2",
	"nz_death_3",
	"nz_death_f_1",
	"nz_death_f_2",
	"nz_death_f_3",
	"nz_death_f_4",
	"nz_death_f_5",
	"nz_death_f_6",
	"nz_death_f_7",
	"nz_death_f_8",
	"nz_death_f_9",
	"nz_death_f_10",
	"nz_death_f_11",
	"nz_death_f_12",
	"nz_death_f_13",
	"nz_l4d_death_running_11a",
	"nz_l4d_death_running_11g",
	"nz_l4d_death_02a",
	"nz_l4d_death_11_02d",
	"nz_t9_dth_f_chest_lt_00",
	"nz_t9_dth_f_chest_lt_01",
	"nz_t9_dth_f_chest_lt_02",
	"nz_t9_dth_f_chest_lt_03",
	"nz_t9_dth_f_chest_lt_04",
	"nz_t9_dth_f_chest_lt_05",
	"nz_t9_dth_f_chest_lt_06",
	"nz_t9_dth_f_chest_lt_07",
	"nz_t9_dth_f_chest_lt_08",
	"nz_t9_dth_f_chest_lt_09",
	"nz_t9_dth_f_head_lt_00",
	"nz_t9_dth_f_head_lt_01",
	"nz_t9_dth_f_head_lt_02",
}

ENT.CrawlDeathSequences = {
	"nz_crawl_death_v1",
	"nz_crawl_death_v2",
}

ENT.SparkySequences = {
	"nz_s2_core_stunned_electrobolt_v1",
	"nz_s2_core_stunned_electrobolt_v2",
	"nz_s2_core_stunned_electrobolt_v3",
	"nz_s2_core_stunned_electrobolt_v4",
	"nz_s2_core_stunned_electrobolt_v5",
}

local CrawlAttackSequences = {
	{seq = "nz_iw7_cp_zom_prone_attack_2h_01"},
	{seq = "nz_iw7_cp_zom_prone_attack_l_01"},
	{seq = "nz_iw7_cp_zom_prone_attack_l_02"},
	{seq = "nz_iw7_cp_zom_prone_attack_r_01"},
}

local CrawlJumpSequences = {
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_03"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_03"},
}

ENT.ElectrocutionSequences = {
	"nz_death_elec_1",
	"nz_death_elec_2",
	"nz_death_elec_3",
	"nz_death_elec_4",
	"nz_zombie_tesla_death_e",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local AttackSequences = {
	{seq = "nz_iw7_cp_zom_stand_attack_l_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_l_02"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_02"},
	{seq = "nz_zom_core_stand_attack_2h_01"},
	{seq = "nz_zom_core_stand_attack_2h_02"},
}

local WalkAttackSequences = {
	{seq = "nz_s2_core_walk_attack_v1"},
	{seq = "nz_s2_core_walk_attack_v2"},
	{seq = "nz_s2_core_walk_attack_v3"},
	{seq = "nz_s2_core_walk_attack_v4"},
	{seq = "nz_s2_core_walk_attack_v5"},
	{seq = "nz_s2_core_walk_attack_v6"},
	{seq = "nz_s2_core_walk_attack_v7"},
	{seq = "nz_s2_core_walk_attack_v8"},
	{seq = "nz_s2_core_walk_attack_v9"},
	{seq = "nz_s2_core_walk_attack_v10"},
	{seq = "nz_s2_core_walk_attack_v11"},
	{seq = "nz_s2_core_walk_attack_v12"},
}

local RunAttackSequences = {
	{seq = "nz_s2_core_run_attack_v1"},
	{seq = "nz_s2_core_run_attack_v2"},
	{seq = "nz_s2_core_run_attack_v3"},
	{seq = "nz_s2_core_run_attack_v4"},
	{seq = "nz_s2_core_run_attack_v5"},
	{seq = "nz_s2_core_run_attack_v6"},
	{seq = "nz_s2_core_run_attack_v7"},
	{seq = "nz_s2_core_run_attack_v8"},
	{seq = "nz_s2_core_run_attack_v9"},
	{seq = "nz_s2_core_run_attack_v10"},
	{seq = "nz_s2_core_run_attack_v11"},
	{seq = "nz_s2_core_run_attack_v12"},
	{seq = "nz_s2_core_run_attack_v13"},
}

local StinkyRunAttackSequences = {
	{seq = "nz_run_ad_attack_v1"},
	{seq = "nz_run_ad_attack_v2"},
	{seq = "nz_run_ad_attack_v3"},
	{seq = "nz_run_ad_attack_v4"},

	-- The REAL Bad Attack Anims
	{seq = "nz_legacy_run_attack_v1"},
	{seq = "nz_legacy_run_attack_v2"},
	{seq = "nz_legacy_run_attack_v3"},
	{seq = "nz_legacy_run_attack_v4"},
}

local SprintAttackSequences = {
	{seq = "nz_s2_core_sprint_attack_v1"},
	{seq = "nz_s2_core_sprint_attack_v2"},
	{seq = "nz_s2_core_sprint_attack_v3"},
	{seq = "nz_s2_core_sprint_attack_v4"},
	{seq = "nz_s2_core_sprint_attack_v5"},
	{seq = "nz_s2_core_sprint_attack_v6"},
	{seq = "nz_s2_core_sprint_attack_v7"},
	{seq = "nz_s2_core_sprint_attack_v8"},
	{seq = "nz_s2_core_sprint_attack_v9"},
	{seq = "nz_s2_core_sprint_attack_v10"},
	{seq = "nz_s2_core_sprint_attack_v11"},
	{seq = "nz_s2_core_sprint_attack_v12"},
	{seq = "nz_s2_core_sprint_attack_v13"},
	{seq = "nz_s2_core_sprint_attack_v14"},
	{seq = "nz_s2_core_sprint_attack_v15"},
	{seq = "nz_s2_core_sprint_attack_v16"},
}

local WalkJumpSequencesMiddle = {
	{seq = "nz_base_zombie_walk_win_trav_m_01"},
	{seq = "nz_base_zombie_walk_win_trav_m_02"},
	{seq = "nz_base_zombie_walk_win_trav_m_03"},
}

local WalkJumpSequencesLeft = {
	{seq = "nz_base_zombie_walk_win_trav_l_01"},
}

local WalkJumpSequencesRight = {
	{seq = "nz_base_zombie_walk_win_trav_r_01"},
}

local RunJumpSequencesMiddle = {
	{seq = "nz_base_zombie_run_win_trav_m_01"},
}

local RunJumpSequencesLeft = {
	{seq = "nz_base_zombie_run_win_trav_l_01"},
}

local RunJumpSequencesRight = {
	{seq = "nz_base_zombie_run_win_trav_r_01"},
}

local SprintJumpSequencesMiddle = {
	{seq = "nz_base_zombie_sprint_win_trav_m_01"},
	{seq = "nz_base_zombie_sprint_win_trav_m_02"},
}

local SprintJumpSequencesLeft = {
	{seq = "nz_base_zombie_sprint_win_trav_l_01"},
}

local SprintJumpSequencesRight = {
	{seq = "nz_base_zombie_sprint_win_trav_r_01"},
}
local walksounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),
	
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_growl_lev4_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev1_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev2_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev3_05.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_growl_lev4_05.mp3"),

	-- Speaking
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_27.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_28.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_29.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_30.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_31.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_32.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_33.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_34.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_35.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_36.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_37.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_38.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_39.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_40.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_41.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_42.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_43.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_44.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_45.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_46.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_47.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_48.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_15.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_16.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_17.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_18.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_19.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_20.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_21.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_22.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_23.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_24.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_25.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_26.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_27.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_28.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_29.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_30.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_31.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_32.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_33.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_34.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_35.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_charge_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_charge_10.mp3"),
}

ENT.IdleSequence = "nz_iw7_cp_zom_stand_idle_01"

ENT.IdleSequenceAU = "nz_iw7_cp_zom_stand_idle_02"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_s2_core_walk_v1",
				"nz_s2_core_walk_v2",
				"nz_s2_core_walk_v3",
				"nz_s2_core_walk_v4",
				"nz_s2_core_walk_v5",
				"nz_s2_core_walk_v6",
				"nz_s2_core_walk_v7",
				"nz_s2_core_walk_v8",
				"nz_s2_core_walk_v9",
				"nz_s2_core_walk_v10",
				"nz_s2_core_walk_v11",
				"nz_s2_core_walk_v12",
			},
			LowgMovementSequence = {
				"nz_walk_lowg_v1",
				"nz_walk_lowg_v2",
				"nz_walk_lowg_v3",
				"nz_walk_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
				--[["nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",]]
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			TurnedMovementSequence = {
				--"nz_pb_zombie_sprint_v6",
				--"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v8", -- The Tranzit Sprinter one.
				--"nz_pb_zombie_sprint_v9",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {WalkJumpSequencesMiddle},
			JumpSequencesLeft = {WalkJumpSequencesLeft},
			JumpSequencesRight = {WalkJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_s2_core_run_v1",
				"nz_s2_core_run_v2",
				"nz_s2_core_run_v3",
				"nz_s2_core_run_v4",
				"nz_s2_core_run_v5",
				"nz_s2_core_run_v6",
				"nz_s2_core_run_v7",
				"nz_s2_core_run_v8",
				"nz_s2_core_run_v9",
				"nz_s2_core_run_v10",
				"nz_s2_core_run_v11",
				"nz_s2_core_run_v12",
				"nz_s2_core_run_v13",
			},
			LowgMovementSequence = {
				"nz_run_lowg_v1",
				"nz_run_lowg_v2",
				"nz_run_lowg_v3",
				"nz_run_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
				--[["nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",]]
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			TurnedMovementSequence = {
				--"nz_pb_zombie_sprint_v6",
				--"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v8", -- The Tranzit Sprinter one.
				--"nz_pb_zombie_sprint_v9",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {RunJumpSequencesMiddle},
			JumpSequencesLeft = {RunJumpSequencesLeft},
			JumpSequencesRight = {RunJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_s2_core_sprint_v1",
				"nz_s2_core_sprint_v2",
				"nz_s2_core_sprint_v3",
				"nz_s2_core_sprint_v4",
				"nz_s2_core_sprint_v5",
				"nz_s2_core_sprint_v6",
				"nz_s2_core_sprint_v7",
				"nz_s2_core_sprint_v8",
				"nz_s2_core_sprint_v9",
				"nz_s2_core_sprint_v10",
				"nz_s2_core_sprint_v11",
				"nz_s2_core_sprint_v12",
				"nz_s2_core_sprint_v13",
				"nz_s2_core_sprint_v14",
				"nz_s2_core_sprint_v15",
				"nz_s2_core_sprint_v16",
			},
			LowgMovementSequence = {
				"nz_sprint_lowg_v1",
				"nz_sprint_lowg_v2",
				"nz_sprint_lowg_v3",
				"nz_sprint_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
				--[["nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",]]
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			TurnedMovementSequence = {
				--"nz_pb_zombie_sprint_v6",
				--"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v8", -- The Tranzit Sprinter one.
				--"nz_pb_zombie_sprint_v9",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequencesMiddle},
			JumpSequencesLeft = {SprintJumpSequencesLeft},
			JumpSequencesRight = {SprintJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 125, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_s2_core_sprint_v5",
				--"nz_s2_core_sprint_v6",
				"nz_s2_core_sprint_v7",
				"nz_s2_core_sprint_v8",
				"nz_s2_core_sprint_v9",
				"nz_s2_core_sprint_v10",
				"nz_s2_core_sprint_v11",
			},
			LowgMovementSequence = {
				"nz_sprint_lowg_v1",
				"nz_sprint_lowg_v2",
				"nz_sprint_lowg_v3",
				"nz_sprint_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
				--[["nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",]]
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			TurnedMovementSequence = {
				--"nz_pb_zombie_sprint_v6",
				--"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v8", -- The Tranzit Sprinter one.
				--"nz_pb_zombie_sprint_v9",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequencesMiddle},
			JumpSequencesLeft = {SprintJumpSequencesLeft},
			JumpSequencesRight = {SprintJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {runsounds},
		},
	}},
}

ENT.TauntSequences = {
	"nz_taunt_v1",
	"nz_taunt_v2",
	"nz_taunt_v3",
	"nz_taunt_v4",
	"nz_taunt_v5",
	"nz_taunt_v6",
	"nz_taunt_v7",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_13.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_07.mp3"),
}

ENT.NukeDeathSounds = {
	Sound("nz_moo/zombies/vox/nuke_death/soul_00.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_01.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_02.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_03.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_04.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_05.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_06.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_07.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_08.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_09.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_10.mp3")
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_death_13.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_death_07.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_hit_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_melee_miss_09.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_hit_09.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_melee_miss_10.mp3"),
}

ENT.SpeakSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_27.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_28.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_29.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_30.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_31.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_32.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_33.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_34.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_35.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_36.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_37.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_38.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_39.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_40.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_41.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_42.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_43.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_44.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_45.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_46.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_47.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_zde_gen2_ml_taunt_48.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_15.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_16.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_17.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_18.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_19.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_20.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_21.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_22.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_23.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_24.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_25.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_26.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_27.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_28.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_29.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_30.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_31.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_32.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_33.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_34.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_zde_ft_gen_taunt_35.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_15.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_16.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_taunt_17.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_taunt_08.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_13.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_14.mp3"),

	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_01.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_13.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_13.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_14.mp3"),

	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_01.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_13.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_00.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_03.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_00.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_02.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_13.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_14.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_15.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_16.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_17.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_18.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_busted_19.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_busted_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_11.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_14.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_15.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_16.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_17.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_pain_18.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_pain_10.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_hiss_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_spawn_vocal_10.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_snarl_10.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end

		self:SetHealth( nzRound:GetZombieHealth() )
		self.AttackDamage = nzRound:GetZombieDamage() or 50
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if dirt then
		local SpawnMatSound = {
			[MAT_DIRT] = "nz_moo/zombies/spawn/dirt/pfx_zm_spawn_dirt_0"..math.random(0,1)..".mp3",
			[MAT_SNOW] = "nz_moo/zombies/spawn/snow/pfx_zm_spawn_snow_0"..math.random(0,1)..".mp3",
			[MAT_SLOSH] = "nz_moo/zombies/spawn/mud/pfx_zm_spawn_mud_00.mp3",
			[0] = "nz_moo/zombies/spawn/default/pfx_zm_spawn_default_00.mp3",
		}
		SpawnMatSound[MAT_GRASS] = SpawnMatSound[MAT_DIRT]
		SpawnMatSound[MAT_SAND] = SpawnMatSound[MAT_DIRT]

		local norm = (self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = SpawnMatSound[tr.MatType] or SpawnMatSound[0]
			self:EmitSound(finalsound)
		end

		ParticleEffect("zmb_zombie_spawn_dirt",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	end

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		
		self:PlaySequenceAndMove(animation, {gravity = grav})

		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

ENT.CustomTauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomTauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_10.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen2/zmb_vox_gen2_sneakattack_success_11.mp3"),

	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_05.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_06.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_07.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_08.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_09.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen_v2/zmb_vox_gen_sneakattack_success_10.mp3"),
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_gen/gen/zmb_vox_gen_charge_01.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen/zmb_vox_gen_charge_02.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen/zmb_vox_gen_charge_03.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen/zmb_vox_gen_charge_04.mp3"),
	Sound("nz_moo/zombies/vox/_gen/gen/zmb_vox_gen_charge_05.mp3"),
}