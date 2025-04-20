AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/tfa_bo3/pes/p7_zm_moo_space_suit_body_lod7.mdl")
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)
	self:SetActive(true)
end

function ENT:Use(ply)
	if !IsValid(ply) or !ply:IsPlayer() then return end
	if ply:HasWeapon('tfa_bo3_pes') then return end
	if not self:GetActive() then return end
	ply:Give('tfa_bo3_pes')
end
