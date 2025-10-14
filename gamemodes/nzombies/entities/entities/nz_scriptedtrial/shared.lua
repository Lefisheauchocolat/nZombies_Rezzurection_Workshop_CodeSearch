AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Challenge Totem"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "ScriptedTrial")
	self:NetworkVar("Bool", 0, "PressUse")
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo2/alcatraz/zm_al_skull.mdl")
	end

	if SERVER then
		self:SetCollisionGroup(COLLISION_GROUP_PUSHAWAY)
		self:PhysicsInit(SOLID_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger(true)
	end

	self:SetAutomaticFrameAdvance(true)
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

function ENT:GetUseRandom()
	return self:GetScriptedTrial() == "random"
end
