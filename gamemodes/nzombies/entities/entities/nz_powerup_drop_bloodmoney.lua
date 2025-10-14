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

AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Blood Money"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false

--[Parameters]--
ENT.Delay = 30

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Points")
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		self:StopSound("NZ.BO2.DigSite.SpecialLoop")
		self:EmitSound("nz_moo/powerups/powerup_pickup_zhd.mp3")

		ent:GivePoints(self:GetPoints())

		timer.Simple(0.2, function()
			if not IsValid(ent) then return end
			ent:EmitSound("nz_moo/announcer/tomb/vox_zmba_powerup_blood_money_d_0.wav", SNDLVL_NORM, 100, 1, CHAN_AUTO, 1024)
		end)

		if self:GetPoints() == 50 then
			nzSounds:PlayEnt("Laugh", ent)
		end

		self:Remove()
	end
end

function ENT:Initialize()
	self:SetModel("models/nzpowerups/bloodmoney.mdl")
	self:SetModelScale(1, 0)

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:UseTriggerBounds(true, 10)

	self:SetColor(Color(0,0,0))
	self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")

	self:EmitSound("NZ.BO2.DigSite.Special")
	self:EmitSound("NZ.BO2.DigSite.SpecialLoop")

	ParticleEffectAttach("bo3_qed_powerup_local", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	self:SetPoints(math.random(1,6)*50)

	if CLIENT then return end
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound("NZ.BO2.DigSite.SpecialLoop")
end
