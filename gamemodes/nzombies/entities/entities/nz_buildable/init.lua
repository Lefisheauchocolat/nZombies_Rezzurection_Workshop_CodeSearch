AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/nzr/song_ee/teddybear.mdl")
		PrintMessage(HUD_PRINTTALK, "model for buildable failed, falling back to teddybear")
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)

	self:SetActivated(true)
end

function ENT:Think()
	if not self:GetActivated() and self.nextloop < CurTime() then
		self:EmitSound("NZ.Buildable.Loop")
		self.nextloop = CurTime() + math.random(8, 16)
	end
	if self:GetActivated() and self.nextloop ~= 0 and self.nextloop < CurTime() then
		self:StopSound("NZ.Buildable.Loop")
		self.nextloop = 0
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Use(ply)
	if self.NextUse and self.NextUse > CurTime() then return end
	if nzRound:InState(ROUND_CREATE) and ply:IsInCreative() then
		self.NextUse = CurTime() + 2
		ply:EmitSound("NZ.Buildable.Foley")
		self:EmitSound("NZ.Buildable.Stinger")
		return
	end
	if not nzRound:InProgress() then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if self:GetActivated() then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.25

	ply:EmitSound("NZ.Buildable.Foley")
	self:EmitSound("NZ.Buildable.Stinger")
	self:StopSound("NZ.Buildable.Loop")

	self:Trigger()

	local parttab = nzBuilds:GetBuildParts(self:GetBuildable())
	local name = parttab[self:GetPartID()].id

	PrintMessage(HUD_PRINTTALK, ply:Nick().." Picked up "..name)
	nzBuilds:UpdateHeldParts(self)
	hook.Call("PlayerPickupBuildpart", nil, ply, self)
end

function ENT:Reset()
	self.NextUse = nil
	self:SetActivated(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Trigger()
	self:SetActivated(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end
