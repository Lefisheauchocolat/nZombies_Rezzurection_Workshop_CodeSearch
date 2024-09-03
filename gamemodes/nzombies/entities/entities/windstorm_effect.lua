
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
ENT.PrintName = "Wind Storm (AAT)"
ENT.Spawnable = false
ENT.AdminOnly = false

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
	
	if CLIENT then return end

	local tornado = ents.Create("nz_aat_windstorm_proj")
		tornado:SetModel("models/dav0r/hoverball.mdl")
		tornado:SetPos(self:GetPos() + Vector(0,0,24))
		tornado:SetAngles(Angle(90,0,0))
		tornado:SetOwner(self:GetOwner())
		tornado.Inflictor = self
		tornado.Life = 7

		tornado.Damage = 115
		tornado.mydamage = 115

		tornado:Spawn()

		local ang = Angle(90,0,0)
		local dir = ang:Forward() 
		dir:Mul(500)

		tornado:SetVelocity(dir)
		local phys = tornado:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(dir)
		end
		
		tornado.Life = 7
		tornado:SetOwner(self:GetOwner())
		tornado.Inflictor = self
	self:Remove()
end
