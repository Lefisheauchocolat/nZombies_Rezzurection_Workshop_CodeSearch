AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local wep = weapons.Get(self:GetWepClass())
	local model
	if !wep then
		model = "models/weapons/w_crowbar.mdl"
	else
		model = wep.WM or wep.WorldModel
	end

	self:SetModel(model)

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_OBB)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:SetFlipped(true)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	self:SetUsed(false)
end

function ENT:Use(ply)
	if CLIENT then return end
	if self:GetUsed() then return end

	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if nzChalks:GetPlayerChalk(ply) then
		ply:Buy(math.huge, self, function() end)
		return
	end

	if self.NextUse and self.NextUse > CurTime() then return end

	self:EmitSound("NZ.Chalks.Pickup")
	local msg = "Entity("..self:EntIndex().."):Flashbangg()"
	for k, v in ipairs(player.GetAll()) do
		if v:TestPVS(self) then
			v:SendLua(msg)
		end
	end

	if nzRound:InState(ROUND_CREATE) then
		self.NextUse = CurTime() + 1
		return
	end

	self:Trigger()
	nzChalks:GivePlayerChalk(ply, self)

	local wep = weapons.Get(self:GetWepClass())
	if wep then
		PrintMessage(HUD_PRINTTALK, ply:Nick().." Picked up "..wep.PrintName.." wallybuy chalk")
	end

	hook.Call("PlayerPickupWeaponChalk", nil, ply, self)
end

function ENT:ToggleRotate()
	local ang = self:GetAngles()
	self:SetFlipped(!self:GetFlipped())
	ang:RotateAroundAxis(ang:Up(), 90)
	self:SetAngles(ang)
end

function ENT:Reset()
	self.NextUse = nil
	self:SetUsed(false)
	self:SetSolid(SOLID_OBB)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Trigger()
	self:SetUsed(true)
	self:SetSolid(SOLID_NONE)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end
