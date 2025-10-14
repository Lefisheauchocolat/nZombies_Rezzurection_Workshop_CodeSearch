
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:Initialize()
	self:SetModel("models/zmb/bo2/tomb/zm_tm_shovel.mdl")

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)

	self:SetUseCount(0)
end

function ENT:Use(ply)
	//if not nzRound:InProgress() then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if ply == self:GetParent() then return end
	if ply.GetShovel and IsValid(ply:GetShovel()) then self:EmitSound("NZ.Buildable.Deny") return end
	if IsValid(self:GetParent()) then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.65

	self:SetSpawnPos(self:GetPos())
	self:SetSpawnAng(self:GetAngles())
	self:SetSkin(1)

	ply:EmitSound("NZ.Buildable.Foley")
	self:EmitSound("NZ.Buildable.Stinger")

	ply:SetShovel(self)
	ply:DontDeleteOnRemove(self)
	hook.Call("PlayerPickupShovel", nil, ply, self)

	self:SetParent(ply)
	self:AddEffects(EF_BONEMERGE)
	self:SetSolid(SOLID_NONE)
	self:SetTrigger(false)
end

function ENT:Reset()
	if IsValid(self:GetParent()) then
		self:GetParent():SetShovel(nil)
	else
		self:SetSpawnPos(self:GetPos())
		self:SetSpawnAng(self:GetAngles())
	end

	self:SetParent(nil)
	self:RemoveEffects(EF_BONEMERGE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)

	self:SetPos(self:GetSpawnPos())
	self:SetAngles(self:GetSpawnAng())

	self:SetUseCount(0)
	self:SetSkin(0)
end
