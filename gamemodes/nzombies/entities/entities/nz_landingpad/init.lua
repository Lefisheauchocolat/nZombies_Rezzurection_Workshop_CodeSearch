
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
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo1/moon/zom_moon_jump_pad_cushions.mdl")
	end

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)

	timer.Simple(engine.TickInterval(), function()
		if not IsValid(self) then return end
		self:SyncLaunchPad()
	end)
end

function ENT:SyncLaunchPad()
	if self:GetRequireActive() then return end
	for k, v in pairs(ents.FindByClass("nz_launchpad")) do
		if v:GetFlag() == self:GetFlag() and v:GetRequireActive() then
			self:SetRequireActive(true)
		break end
	end
end

function ENT:Use(ply)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 1/3

	if self:GetActivated() then return end
	self:SetActivated(true)
	self:SetSkin(1)

	if self:GetRequireActive() then
		self:EmitSound("NZ.Jumppad.Fun")
		util.ScreenShake(self:GetPos(), 255, 2, 0.5, 120)
	end
end

function ENT:Reset()
	self:SetActivated(false)
	self:SetSkin(0)
end
