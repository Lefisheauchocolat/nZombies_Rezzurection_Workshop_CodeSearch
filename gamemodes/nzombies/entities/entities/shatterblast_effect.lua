
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
ENT.PrintName = "Shatter Blast"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.Range = 200

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()

	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:EmitSound("NZ.ShatterBlast.Exp")
	self:EmitSound("NZ.ShatterBlast.Deep")
	self:EmitSound("NZ.ShatterBlast.Low")

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", fx)
	util.Effect("Explosion", fx)

	if CLIENT then return end
	local damage = DamageInfo()
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsValidZombie() then
				damage:SetDamage(v:Health() + 666)
				damage:SetDamageForce(v:GetUp()*math.random(8000,12000) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(12000,14000))
				damage:SetDamagePosition(v:EyePos())

			if v.NZBossType and v.IsMooBossZombie then
				damage:SetDamage(v:GetMaxHealth()/5)
			end
				v:TakeDamageInfo(damage)
			end
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, 400)
	self:Remove()
end
