
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

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(CONTINUOUS_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)

	self:EmitSound("TFA_BO2_SHIELD.Plant")
	self:SetDestroyed(false)
	self:SetNextAttack(0)
	self:SetActivated(true)
	self:SetNextAttack(CurTime() + 1)

	if nzombies then
		for k, v in ipairs(ents.FindByClass(self:GetClass())) do
			if v:GetOwner() == self:GetOwner() and v:EntIndex() ~= self:EntIndex() then
				v:SetHealth(1)
				v:TakeDamage(666, self, self)
				continue
			end
		end
	end

	local ply = self:GetOwner()
	if IsValid(ply) then
		if nzombies and ply:IsPlayer() then
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(self) then return end
				ply:AddBuildable(self)
			end)
		end

		ply.NextTrapUse = CurTime() + 0.35 //use delay

		if not util.IsInWorld(self:GetPos()) then
			self:SetPos(ply:GetPos()) //plz dont get stuck in walls
		end
	end
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	if self:GetActivated() and self:GetNextAttack() < CurTime() then
		self.Kills = 0
		if nzombies and IsValid(ply) then
			self:SetNextAttack(CurTime() + (ply:HasPerk("time") and 1 or 2))
		else
			self:SetNextAttack(CurTime() + 2)
		end
		self:EmitSound("TFA_BO2_WOOFER.Explo")
		self:EmitSound("TFA_BO2_WOOFER.Sweet")

		self:CylinderDamageCheck()
		self:TakeDamage(10, self, self)

		ParticleEffectAttach("bo3_thundergun_muzzleflash", PATTACH_POINT_FOLLOW, self, 1)

		util.ScreenShake(self:GetPos(), 10, 255, 1, 250)
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	self:SetHealth(self:Health() - dmginfo:GetDamage())

	if self:Health() <= 0 then
		if IsValid(ply) then
			ply:EmitSound("TFA_BO2_SHIELD.Break")
		end
		self:SetDestroyed(true)
		self:Remove()
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if self:GetDestroyed() then return end
	if not IsValid(ply) then return end
	if not nzombies and ply ~= self:GetOwner() then return end
	if ply.NextTrapUse and ply.NextTrapUse > CurTime() then return end

	local own = self:GetOwner()
	if nzombies and IsValid(own) and own:IsPlayer() and ply ~= own and own:GetInfoNum("nz_buildable_sharing", 0) < 1 then return end

	if not ply:HasWeapon(self:GetTrapClass()) then
		ply.NextTrapUse = CurTime() + 0.25

		local wep = ply:Give(self:GetTrapClass())
		if IsValid(wep) then
			local hp = math.Clamp(self:Health() / self:GetMaxHealth(), 0, 1)
			wep:SetClip1(math.Round(hp * wep.Primary_TFA.ClipSize))
		end

		self:EmitSound("TFA_BO2_SHIELD.Pickup")
		self:Remove()
	end
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function ENT:CylinderDamageCheck()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	local outer_range = self.CylinderRange
	local cylinder_radius = self.CylinderRadius
	local kill_range = self.CylinderKillRange

	local ang = math.cos(math.rad(45))
	local view_pos = self:GetAttachment(1).Pos
	local forward_view_angles = self:GetForward()
	local end_pos = view_pos + (forward_view_angles * outer_range)

	local ball = ents.Create("bo3_ww_thundergun")
	ball:SetModel("models/dav0r/hoverball.mdl")
	ball:SetPos(view_pos)
	ball:SetOwner(ply)
	ball:SetAngles(forward_view_angles:Angle())
	ball.Delay = 0.4

	ball:Spawn()

	local dir = forward_view_angles
	dir:Mul(1500)

	ball:SetVelocity(dir)

	local phys = ball:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(dir)
	end

	ball:SetOwner(ply)
	ball.Inflictor = wep

	local outer_range_squared = outer_range * outer_range
	local cylinder_radius_squared = cylinder_radius * cylinder_radius
	local kill_range_squared = kill_range * kill_range

	for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
		if not (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then continue end
		if nzombies and ent:IsPlayer() then continue end
		if ent == ply then continue end
		if ent:Health() <= 0 then continue end

		local test_origin = ent:WorldSpaceCenter()
		local test_range_squared = view_pos:DistToSqr(test_origin)
		if test_range_squared > outer_range_squared then
			continue // everything else in the list will be out of range
		end

		local normal = (test_origin - view_pos):GetNormalized()
		local dot = forward_view_angles:Dot(normal)
		if 0 > dot then
			continue // guy's behind us
		end

		local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
		if test_origin:DistToSqr(radial_origin) > cylinder_radius_squared then
			continue // guy's outside the range of the cylinder of effect
		end

		tr1 = util.TraceLine({
			start = view_pos,
			endpos = test_origin,
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
		})

		if tr1.HitWorld then
			continue // guy can't actually be hit from where we are
		end

		self:DoCylinderDamage(ent, test_range_squared < kill_range_squared)
	end
end

function ENT:DoCylinderDamage(ent, kill)
	local norm = (ent:GetPos() - self:GetPos()):GetNormalized()
	local ply = self:GetOwner()

	local damage = DamageInfo()
	damage:SetDamage(kill and ent:Health() + 666 or 75)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetDamageForce(ent:GetUp()*20000 + norm*50000)

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(400, ent:GetMaxHealth() / 12))
	end

	ent:TakeDamageInfo(damage)

	if (ent:IsNPC() or ent:IsNextBot()) and kill and IsValid(ply) and ply:IsPlayer() then
		self.Kills = self.Kills + 1
		if self.Kills == 10 and not ply.bo2subwooferachievment then
			TFA.BO3GiveAchievement("Death From Below", "vgui/overlay/achievment/basscannon.png", ply)
			ply.bo2subwooferachievment = true
		end
	end
end
