
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
ENT.PrintName = "Blob"

--[Sounds]--
ENT.ImpactSound = "TFA_BO3_MIRG.Impact"
ENT.ExplosionSound = "TFA_BO3_MIRG.Explode"
ENT.SporeGrowSound = "TFA_BO3_MIRG.Spore.Grow"
ENT.SporeExplSound = "TFA_BO3_MIRG.Spore.Explode"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 80
ENT.RangePaP = 90
ENT.Kills = 0
ENT.MaxKills = 3
ENT.MaxKillsPaP = 6

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar( "Int", 0, "Charge")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data,phys)
	if self.Impacted then return end

	if self:GetCharge() > 1 then
		if data.HitNormal:Dot(vector_up*-1)>0.9 then
			local pos = data.HitPos
			timer.Simple(0, function()
				self:CreateSlipPlate(pos, Angle(0,0,0))
			end)

			self.Impacted = true
			self:Impact(data.HitEntity, data.HitPos)
			self:SetHitPos(data.HitPos)

			ParticleEffect(self:GetUpgraded() and "bo3_mirg2k_impact_2" or "bo3_mirg2k_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
			self:Remove()
		elseif data.Speed > 60 then
			local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
			local NewVelocity = phys:GetVelocity()
			NewVelocity:Normalize()

			LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
			local TargetVelocity = NewVelocity * LastSpeed * 0.2
			phys:SetVelocity( TargetVelocity )
		end
	else
		self.Impacted = true
		self:Impact(data.HitEntity, data.HitPos)
		self:SetHitPos(data.HitPos)

		ParticleEffect(self:GetUpgraded() and "bo3_mirg2k_impact_2" or "bo3_mirg2k_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
		self:Remove()
	end
end

function ENT:StartTouch(ent)
	if self.Impacted then return end

	if not (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then return end

	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	self.Impacted = true
	self:OnCollide(ent)
	self:Impact(ent, self:GetPos())
	self:SetHitPos(self:GetPos())

	ParticleEffect(self:GetUpgraded() and "bo3_mirg2k_impact_2" or "bo3_mirg2k_impact", self:GetPos(), angle_zero)
	self:Remove()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_mirg2k_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(0, 255, 235)
		self.Range = self.RangePaP
		self.MaxKills = self.MaxKillsPaP
	else
		ParticleEffectAttach("bo3_mirg2k_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(65, 235, 20)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Impact(ent, pos)
	self:EmitSound("TFA_BO3_MIRG.Impact")
	self:EmitSound("TFA_BO3_MIRG.ImpactSwt")

	if self:GetCharge() <= 1 then
		local ply = self:GetOwner()
		for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
			if (v:IsNPC() or v:IsNextBot() or v:IsPlayer()) then
				if v:BO3IsSpored() then continue end
				if v == ply then continue end
				if nzombies and v:IsPlayer() then continue end
				if v:Health() <= 0 then continue end
				if nzombies and (v.NZBossType or v.IsMooBossZombie) then
					self:InflictDamage(v)
					continue
				end

				v:BO3Spore(math.Rand(1,1.4), ply, self.Inflictor, self:GetUpgraded())

				self.Kills = self.Kills + 1
				if self.Kills > self.MaxKills then break end
			end
		end
	end
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(math.max(2200, ent:GetMaxHealth() / 8))
	//damage:ScaleDamage(math.Round(nzRound:GetNumber()/8))
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_RADIATION)
	ent:TakeDamageInfo(damage)
end

function ENT:OnCollide(ent)
	self:StopParticles()

	if ent:IsOnGround() and self:GetCharge() > 1 then
		local pos = ent:GetPos()
		timer.Simple(0, function()
			self:CreateSlipPlate(pos, Angle(0,0,0))
		end)
	end
end

function ENT:CreateSlipPlate(pos, ang)
	local qty = 10 --number of puddles you want
    local randomintensity = 0.8 --how intense the randomness should be
    local radv = 50 --size of circle
    local pi = math.pi / (qty/2)

    pos = pos + vector_up*2

	local tr = {
		start = pos,
		filter = {self},
		mask = MASK_SOLID_BRUSHONLY,
	}

	for i = 1, qty do
		local posx, posy = radv * math.sin(pi * i), radv * math.cos(pi * i)
        local offset = Vector(posx + (math.Rand(-radv, radv) * randomintensity), posy + (math.Rand(-radv, radv) * randomintensity), 0)
		tr.endpos = pos + offset
		local traceres = util.TraceLine(tr)
		local pos = pos + traceres.Normal * math.Clamp(traceres.Fraction,0,1) * offset:Length()

		local tr1 = util.TraceLine({
			start = pos,
			endpos = pos - Vector(0,0,24),
			filter = self,
			mask = MASK_SOLID,
		})

		if tr1.AllSolid or tr1.StartSolid or tr1.Fraction == 1 then
			continue
		end

		local goo = ents.Create("bo3_ww_mirg_puddle")
		goo:SetModel("models/hunter/plates/plate075x075.mdl")
		goo:SetPos(pos)
		goo:SetOwner(self:GetOwner())
		goo:SetAngles(ang)

		goo:SetUpgraded(self:GetUpgraded())
		goo:SetCharge(self:GetCharge())

		goo.Damage = self.mydamage
		goo.mydamage = self.mydamage
				
		goo:Spawn()

		goo:SetOwner(self:GetOwner())
		goo.Inflictor = self.Inflictor

		table.insert(tr.filter, goo)
	end
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end
end