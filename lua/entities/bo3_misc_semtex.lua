
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
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Semtex"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_SPIDERNADE.Explode"

--[Parameters]--
ENT.Delay = 1
ENT.Range = 256
ENT.NZThrowIcon = Material("vgui/icon/hud_icon_sticky_grenade.png", "unlitgeneric smooth")

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	local ent = data.HitEntity
	local ang = self:GetAngles()

	timer.Simple(0, function()
		if not self:IsValid() then return end
		self:SetAngles(ang)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
	end)

	self:EmitSound("TFA_BO3_SEMTEX.Stick")

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:StartTouch(ent)
	if self:GetActivated() then return end
	if not ent:IsSolid() then return end
	if ent:IsPlayer() then return end

	self:SetActivated(true)

	self:SetParent(ent)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:UseTriggerBounds(true, 4)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	self:EmitSoundNet("TFA_BO3_GRENADE.Pin")

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 1, Color(200,200,200,200), true, 5, 0, 0.5, 0.1, "trails/smoke")
end

function ENT:DoExplosionEffect()
	ParticleEffect("bo3_spider_impact", self:GetPos(), Angle(0,0,0))

	self:EmitSound(self.ExplosionSound1)
end

function ENT:Explode()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if (v:IsNPC() or v:IsNextBot()) then
			if nzombies and v.NZBossType then continue end
			v:BO3SpiderWeb(10, self:GetOwner())
		end
	end

	self:DoExplosionEffect()
	self:Remove()
end
