AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Dig Mound Hologram"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.NZOnlyVisibleInCreative = true

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	if SERVER then
		self:DrawShadow(false)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(false)
	end

	self:SetColor(Color(255, 255, 255, 100))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(16)
end
