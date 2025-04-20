
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
ENT.PrintName = "Random Weapon"
ENT.Purpose = "Spawns a random weapon drop."
ENT.Instructions = "Pickup"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "TFA Other"

--[Sounds]--

--[Parameters]--
ENT.Delay = 30

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "Gun")
end

function ENT:SpawnFunction( ply, tr, ClassName )
	if ( !tr.Hit ) then return end

	local size = 54
	local SpawnPos = tr.HitPos + tr.HitNormal * size

	-- Make sure the spawn position is not out of bounds
	local oobTr = util.TraceLine( {
		start = tr.HitPos,
		endpos = SpawnPos,
		mask = MASK_SOLID_BRUSHONLY
	} )

	if ( oobTr.Hit ) then
		SpawnPos = oobTr.HitPos + oobTr.HitNormal * ( tr.HitPos:Distance( oobTr.HitPos ) / 2 )
	end

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetOwner( ply )
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		self:StopSound("TFA_BO3_QED.DropLoop")
		ent:EmitSound("TFA_BO3_QED.Pickup")
		self:Effect(ent)
		self:Remove()
	end
end

function ENT:Initialize(...)
	self:SetModel("models/dav0r/hoverball.mdl")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self:SetNoDraw(true)
	self:PhysicsInitSphere(60, "default_silent")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 10)

	self.killtime = CurTime() + self.Delay
	self:EmitSound("TFA_BO3_QED.DropSpawn")
	self:EmitSound("TFA_BO3_QED.DropLoop")

	ParticleEffectAttach("bo3_qed_powerup_local", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	if CLIENT then return end
	self:SpawnWeapon()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

function ENT:SpawnWeapon()
	local weapon
	if IsValid(self:GetGun()) then
		weapon = self:GetGun()
	else
		for _, SWEP in RandomPairs(weapons.GetList()) do
			if SWEP.Spawnable == true and !SWEP.AdminOnly then
				if SWEP.ClassName and SWEP.Primary.Damage then
					if (not self:GetOwner():HasWeapon(SWEP.ClassName)) then
						weapon = SWEP.ClassName
					end
				end
			end
		end
	end

	local wepdrop = ents.Create(weapon)
	wepdrop:SetPos(self:GetPos())
	wepdrop:SetAngles(Angle(0,0,0))
	wepdrop:SetParent(self)
	wepdrop:Spawn()
	local phys = wepdrop:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	local wepdropspin = tostring("qed_wepdrop_spin"..wepdrop:EntIndex())
	timer.Create(wepdropspin, engine.TickInterval(), 0, function()
		if not IsValid(wepdrop) then timer.Stop(wepdropspin) timer.Remove(wepdropspin) end
		if IsValid(wepdrop) then
			wepdrop:SetLocalAngles(wepdrop:GetLocalAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
		end
	end)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Effect(ply)
	if SERVER then
		net.Start("TFA.BO3.QED_SND")
		net.WriteString("WeaponGive")
		net.Send(ply)
	end
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_QED.DropLoop")
end
