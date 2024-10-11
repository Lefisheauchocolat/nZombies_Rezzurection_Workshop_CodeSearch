AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Power-Up Spawner"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PowerUp")
	self:NetworkVar("String", 1, "DoorFlag")

	self:NetworkVar("Bool", 0, "DoScroll")
	self:NetworkVar("Bool", 1, "Randomize")
	self:NetworkVar("Bool", 2, "Sequential")
	self:NetworkVar("Bool", 3, "Door")

	self:NetworkVar("Int", 0, "RandomizeRound")

	self:NetworkVar("Float", 0, "ScrollTime")
	self:NetworkVar("Float", 1, "ScrollTimeRare")
end

function ENT:Initialize()
	local pdata = nzPowerUps:Get(self:GetPowerUp())
	self:SetModel(pdata.model)
	self:SetModelScale(pdata.scale or 1, 0)

	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self:UseTriggerBounds(true, 8)
	self:DrawShadow(false)

	self:SetAutomaticFrameAdvance(true)

	self:SetColor(Color(255, 255, 255, 100))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(16)

	if CLIENT then return end

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

function ENT:SpawnPowerUp()
	local id = self:GetPowerUp()

	local ent = ents.Create("drop_powerup")
	id = hook.Call("OnPowerUpSpawned", nil, id, ent) or id
	if not IsValid(ent) then return end

	local data = nzPowerUps:Get(id)

	ent.PowerUpSpawner = self
	ent.RollTime = self:GetScrollTime()
	ent.RollTimeRare = self:GetScrollTimeRare()

	ent:SetPowerUp(id)
	ent:SetSpawnedPowerUp(true)

	ent:SetModel(data.model)
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles() + data.angle)
	ent:Spawn()

	if self:GetDoScroll() then
		ent.RollSequential = self:GetSequential()
		ent:StartRolling()
	end

	self:SetSolid(SOLID_NONE)
	self:PhysicsDestroy()
end
