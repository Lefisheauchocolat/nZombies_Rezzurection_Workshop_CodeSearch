AddCSLuaFile( )
 
ENT.Type = "anim"
ENT.Base = "base_entity"
 
ENT.PrintName       = "nz_spawn_zombie_vign"

ENT.NZOnlyVisibleInCreative = true
 
function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Link")
	self:NetworkVar("String", 1, "Link2")
	self:NetworkVar("String", 2, "Link3")
	self:NetworkVar("String", 3, "ZombieType")
	self:NetworkVar("Float", 0, "SpawnChance")
	self:NetworkVar("Int", 0, "SpawnType")
	self:NetworkVar("Int", 1, "AwakeRadius")
	self:NetworkVar("Bool", 0, "InstantAwake")
end

function ENT:Initialize()
	if !NZNukeSpawnDelay then NZNukeSpawnDelay = 0 end
	self:SetModel("models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl")
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:DrawShadow( false )

	self.AutomaticFrameAdvance = true

	if self:GetSpawnChance() == 0 or self:GetSpawnChance() == nil then
		self:SetSpawnChance(100)
	end

	self.Types = {
		[0] = {
			name 		= "Harmful - Slumped",
			inactive 	= "nz_base_zombie_vig_living_world_slumber_over_sleep_01",
			loop 		= nil,
			activate 	= "nz_base_zombie_vig_living_world_slumber_over_wake_01",
			death 		= nil,
		},
		[1] = {
			name 		= "Harmful - Tranzit",
			inactive 	= "nz_base_zombie_inert_01",
			loop 		= nil,
			activate 	= "nz_base_zombie_inert_2_awake_v1",
			death 		= nil,
		},
		[2] = {
			name 		= "Harmful - Eating Corpse 1",
			inactive 	= "nz_base_zombie_vig_living_world_multi_eating_corpse_zmb1_loop_01",
			loop 		= nil,
			activate 	= "nz_base_zombie_vig_living_world_multi_eating_corpse_zmb1_awaken_01",
			death 		= nil,
		},
		[3] = {
			name 		= "Harmful - Eating Corpse 2",
			inactive 	= "nz_base_zombie_vig_living_world_multi_eating_corpse_zmb2_loop_01",
			loop 		= nil,
			activate 	= "nz_base_zombie_vig_living_world_multi_eating_corpse_zmb2_awaken_01",
			death 		= nil,
		},
		[4] = {
			name 		= "Harmless - Car Left Seat",
			inactive 	= "nz_base_zombie_vig_living_world_backseat_car_l_sleep_01",
			loop 		= "nz_base_zombie_vig_living_world_backseat_car_l_loop_01",
			activate 	= "nz_base_zombie_vig_living_world_backseat_car_l_awaken_01",
			death 		= "nz_base_zombie_vig_living_world_backseat_car_l_death_01",
		},
		[5] = {
			name 		= "Harmless - Car Right Seat",
			inactive 	= "nz_base_zombie_vig_living_world_backseat_car_r_sleep_01",
			loop 		= "nz_base_zombie_vig_living_world_backseat_car_r_loop_01",
			activate 	= "nz_base_zombie_vig_living_world_backseat_car_r_awaken_01",
			death 		= "nz_base_zombie_vig_living_world_backseat_car_r_death_01",
		},
	}

	self.Spawns = {}
	self.MiscSpawns = {}

	self.TotalSpawns = 0
	self.NextRound = 0
	self.MarkRound = false
	self.MarkedRound = 0

	self.CurrentSpawnType = "nil"
	self:UpdateSpawnType()

	self.NukeDelay = false
	
	self.NextUse = CurTime() + 1

	if CLIENT then
		self:SetLOD(8)
	end
end

function ENT:UpdateSpawnType()
	self.CurrentSpawnType = self.Types[self:GetSpawnType()].name
end

function ENT:Think()
	if SERVER then
		local creative = nzRound:InState(ROUND_CREATE)
		if creative then
			self:ResetSequence(self.Types[self:GetSpawnType()].inactive)
		elseif nzRound:InState(ROUND_PREP) or nzRound:InState(ROUND_PROG) then
			if (self.link == "" or nzDoors:IsLinkOpened(self.link or nzDoors:IsLinkOpened(self.link2 or nzDoors:IsLinkOpened(self.link3)))) then
				self:SpawnVignZombie()
			end
		end
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:Use(ply)
	if nzRound:InState(ROUND_CREATE) then
		if CurTime() > self.NextUse then
			self:EmitSound("nz_moo/effects/ui/main_click_rear.mp3")
			self.NextUse = CurTime() + 1

			local class
			local zombie
			local zombietype = self:GetZombieType()

			-- Now we're gonna see if the spawner has a zombie type set.
			if zombietype ~= "none" then
				class = zombietype	
			else
				class = "nz_zombie_walker"
			end

			zombie = ents.Create(class)
			zombie:SetPos(self:GetPos())
			zombie:SetAngles(self:GetAngles())

			zombie.IsENVZombie = true

			zombie:Spawn()
			zombie:Activate()
			
			if self:GetInstantAwake() then
				zombie.ENVZombieInstantAwake = true
			end
		end
	end
end

function ENT:SpawnVignZombie()
	if !self.SpawnedZombie then
		self.SpawnedZombie = true

		local class = nzRound:GetZombieType(nzMapping.Settings.zombietype) -- Default to mapsetting zombie selection.
		local zombietype = self:GetZombieType()
		local zombie

		if zombietype ~= "none" then
			-- Override to specific zombie type if selected.
			class = zombietype
		end

		if math.Rand(0,100) < self:GetSpawnChance() then
			zombie = ents.Create(class)
			zombie:SetPos(self:GetPos())
			zombie:SetAngles(self:GetAngles())

			zombie.IsENVZombie = true

			zombie:Spawn()
			zombie:Activate()

			if self:GetInstantAwake() then
				zombie.ENVZombieInstantAwake = true
			end
		end
	end
end

hook.Add("OnGameBegin", "nZ_Reset_Vignette_Spawns", function()
	for k,v in nzLevel.GetVignetteSpawnArray() do
		v.SpawnedZombie = false
	end
end)

if CLIENT then
	local nz_preview = GetConVar("nz_creative_preview")
	local displayfont = "ChatFont"
	local outline = Color(0,0,0,59)
	local drawdistance = 800^2
	local size = 0.25
	local col = Color(255,255,0)

	function ENT:Draw()
		if not nzRound:InState( ROUND_CREATE ) then return end
		if nz_preview:GetBool() then return end

		self:DrawModel()

		local ourcolor = Color(255,255,255)
		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
				if self.CurrentSpawnType then
					draw.SimpleText("Sleep Type: "..self.CurrentSpawnType.."", displayfont, 0, 0, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetSpawnChance then
					draw.SimpleText("Chance: "..self:GetSpawnChance().."", displayfont, 0, -15, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetInstantAwake and self:GetInstantAwake() then
					draw.SimpleText("Spawns Awake", displayfont, 0, -30, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetZombieType then
					draw.SimpleText("Zombie Type: "..self:GetZombieType().."", displayfont, 0, -45, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetLink then
					draw.SimpleText("Link: "..self:GetLink().."", displayfont, 0, -60, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetLink2 then
					draw.SimpleText("Link2: "..self:GetLink2().."", displayfont, 0, -75, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				if self.GetLink3 then
					draw.SimpleText("Link3: "..self:GetLink3().."", displayfont, 0, -90, ourcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			cam.End3D2D()
		end
	end
end
 