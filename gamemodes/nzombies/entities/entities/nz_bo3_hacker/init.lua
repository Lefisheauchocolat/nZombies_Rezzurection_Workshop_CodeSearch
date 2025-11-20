AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/tfa_bo3/hacker/hacker_prop.mdl")
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if ply:HasWeapon('tfa_bo3_hacker') then return end

	ply:EmitSound("weapon_bo3_cloth.med")
	self:EmitSound("weapon_bo3_gear.rattle")
	ply:Give('tfa_bo3_hacker')
	self:Remove()
end
