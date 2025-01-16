DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.Health				= nzMapping.Settings.hp
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400
PLAYER.JumpPower			= 200
PLAYER.CanUseFlashlight     = true

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Bool", 0, "UsingSpecialWeapon")
	self.Player:NetworkVar("Entity", 0, "TeleporterEntity")
	self.Player:NetworkVar("Int", 0, "DownButtons") //KeyDown is not networked, so we do this
	self.Player:NetworkVar("Int", 1, "LastPressedButtons") //idk maybe this will be usefull
	self.Player:NetworkVar("Float", 0, "LastSpawnTime")
end

function PLAYER:Init()
end

function PLAYER:Loadout()
	-- Creation Tools
	self.Player:Give( "weapon_physgun" )
	self.Player:Give( "weapon_hands" )
	self.Player:Give( "nz_multi_tool" )
end

local cvar_bleedout = GetConVar("nz_downtime")
local cvar_revive = GetConVar("nz_revivetime")
local cvar_perkmax = GetConVar("nz_difficulty_perks_max")
local cvar_skyintro = GetConVar("nz_sky_intro_server_allow")

function PLAYER:Spawn()
	self.Player:SetHealth(nzMapping.Settings.hp or 150)
	self.Player:SetMaxHealth(nzMapping.Settings.hp or 150)
	self.Player:SetArmor(nzMapping.Settings.startarmor or 0)
	self.Player:SetMaxArmor(nzMapping.Settings.armor or 200)
	self.Player:SetJumpPower(nzMapping.Settings.jumppower or 200)

	self.Player:AllowFlashlight(true)
	self.Player:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	self.Player:SetUsingSpecialWeapon(false)

	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())

	self.Player:MoveToSpawn()
	self.Player:SetLastSpawnTime(CurTime())

	local nz_skyintro = nzMapping.Settings.skyintro
	local cl_skyintro = self.Player:GetInfoNum("nz_sky_intro_always", 0) > 0
	local sv_skyintro = cvar_skyintro:GetBool()
	if (nz_skyintro or (cl_skyintro and sv_skyintro)) and !nzSettings:GetSimpleSetting("InfilEnabled", false) then
		local skytime = !nz_skyintro and 1.4 or math.max(nzMapping.Settings.skyintrotime or 1.4, 0)
		local skyheight = math.Clamp((nzMapping.Settings.skyintroheight or 6000), -30000, 30000)

		local QueueStructure = {
			time = skytime, //camera duration
			start = (self.Player:GetPos() + vector_up*skyheight) - self.Player:GetForward(),
			endpos = self.Player:EyePos(),
			angle = nil, //custom angle for camera to follow, (endpos - start):Angle() otherwise
			fade = false, //black fade in and out when transitioning between camera queues
			rotation = self.Player:EyeAngles(), //angle to rotate to partway through
			rotateratio = 0.2, //at what percentage left to start rotating camera
			viewpunch = self.Player:GetInfoNum("nz_sky_intro_viewpunch", 1) > 0 and Angle(10,0,0) or nil, //viewpunch after camera queue plays out
			followplayer = true, //follow provided player as endpos instead of given endpos
			allowmove = true, //allow player movement during camera animation
			bloom = self.Player:GetInfoNum("nz_sky_intro_bloom", 1) > 0, //bloom fade in and out when transitioning between camera queues
			faderatio = 0.25, //at what percentage left to start fadeout
		}

		local mapsound = nzMapping.Settings.skyintrosnd
		local oursound = next(mapsound) ~= nil and mapsound or "nz_moo/effects/viewin"..math.random(2)..".wav"
		if istable(oursound) then
			oursound = table.Random(oursound)
		end

		nzEE.Cam:QueueViewData(QueueStructure, self.Player)
		nzEE.Cam:Music(oursound, self.Player)
		nzEE.Cam:Begin(self.Player)
	end
end

/*function PLAYER:ViewModelChanged(vm, oldmodel, newmodel)
	local wep
	for k, v in ipairs(self.Player:GetWeapons()) do
		if v:GetWeaponViewModel() == newmodel then
			wep = v
			break
		end
	end

	if not IsValid(vm) or not IsValid(wep) then return end
	if wep.NZCamoBlacklist then return end
	if wep.NZSpecialCategory then return end
	if not wep:HasNZModifier("pap") then return end

	nzCamos:UpdatePlayerViewmodel(self.Player, newmodel)
end*/

player_manager.RegisterClass( "player_create", PLAYER, "player_default" )
