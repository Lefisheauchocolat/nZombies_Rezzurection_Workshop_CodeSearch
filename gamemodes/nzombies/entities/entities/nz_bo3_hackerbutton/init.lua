AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	end

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)
	self:SetActivated(false)
end

function ENT:Hide()
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetTrigger(false)
	self:SetNoDraw(true)
end

function ENT:Reset()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)
	self:SetNoDraw(false)
end

function ENT:Hack(ply)
	self:SetActivated(true)

	local b_allopen = true
	for _, ent in pairs(ents.FindByClass(self:GetClass())) do
		if ent:GetFlag() == self:GetFlag() and not ent:GetActivated() then
			b_allopen = false
			break
		end
	end

	if b_allopen then
		nzDoors:OpenLinkedDoors(self:GetFlag())
	end

	if IsValid(ply) and ply:IsPlayer() and self:GetPrice() > 0 then
		ply:Buy(self:GetPrice(), self, function() return true end)
	end
end
