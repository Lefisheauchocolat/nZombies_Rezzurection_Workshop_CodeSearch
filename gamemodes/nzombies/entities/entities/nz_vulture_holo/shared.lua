AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Vulture-aid Hologram"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

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
	self:SetAutomaticFrameAdvance(true)
	self:ResetSequence("idle")
	self:SetColor(Color(255, 255, 255, 127))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(15)
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end
