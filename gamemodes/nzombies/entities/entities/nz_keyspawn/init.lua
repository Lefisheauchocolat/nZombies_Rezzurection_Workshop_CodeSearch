AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	self:SetUsed(false)
end

function ENT:Use(ply)
	if nzRound:InState(ROUND_CREATE) then
		if ply:KeyDown(IN_SPEED) then return end
		if ply.NextUse and ply.NextUse > CurTime() then return end
		ply.NextUse = CurTime() + 1

		local msg1 = "LocalPlayer():StopSound('"..self.ActivateSound.."')"
		local msg2 = "surface.PlaySound('"..self.ActivateSound.."')"
		ply:SendLua(msg1)
		ply:SendLua(msg2)
		return
	end

	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if self:GetUsed() then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.65

	local msg1 = "LocalPlayer():StopSound('"..self.ActivateSound.."')"
	local msg2 = "surface.PlaySound('"..self.ActivateSound.."')"
	for k, v in ipairs(player.GetAll()) do
		v:SendLua(msg1)
		v:SendLua(msg2)
	end

	self:Trigger()

	if self:GetSingleUse() then
		nzLocker.KeyConsume = true
	end
	nzLocker:PickupKey(self)

	hook.Call("PlayerPickupLockerKey", nil, ply, self)
end

function ENT:Reset()
	self:SetUsed(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Trigger()
	self:SetUsed(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end
