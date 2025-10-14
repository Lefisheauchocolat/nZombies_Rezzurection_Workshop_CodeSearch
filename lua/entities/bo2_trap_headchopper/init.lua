
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

	self.AutomaticFrameAdvance = true
	self:EmitSound("TFA_BO2_SHIELD.Plant")
	self:EmitSound("TFA_BO2_HEADCHOP.Start")
	self:SetDestroyed(false)
	self:SetLastAttack(CurTime() - (self.Delay * 0.5))

	if nzombies then
		local count = 0
		for k, v in ipairs(ents.FindByClass(self:GetClass())) do
			if v:GetOwner() == self:GetOwner() and v ~= self then
				if #player.GetAllPlaying() <= 1 then
					if count >= 1 then
						v:SetHealth(1)
						v:TakeDamage(666, self, self)
						continue
					end

					count = count + 1
				else
					v:SetHealth(1)
					v:TakeDamage(666, self, self)
				end
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
			if self:GetUp():Dot(vector_up) < 0 then
				self:SetAngles(ply:GetForward())
			end
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

	if self:GetLastAttack() == 0 then
		local pos = self:GetAttachment(3).Pos
		local num = 0
		local tr = {
			start = pos,
			filter = self,
			mask = MASK_SOLID_BRUSHONLY
		}

		for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
			if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
				if v:Health() <= 0 then continue end
				if nzombies and v:IsPlayer() then continue end
				if v:IsPlayer() and v:Crouching() then continue end
				if num > 4 then continue end

				tr.endpos = v:WorldSpaceCenter()
				local tr1 = util.TraceLine(tr)
				if tr1.HitWorld then continue end

				if nzombies and IsValid(ply) then
					self:ResetSequence(ply:HasPerk("time") and "swing_fast" or "swing")
				else
					self:ResetSequence("swing")
				end
				self:EmitSound("TFA_BO2_HEADCHOP.Start")
				self:EmitSound("TFA_BO2_HEADCHOP.Swing")
				self:SetLastAttack(CurTime())

				self:InflictDamage(v)
				self:TakeDamage(math.random(5)*5, v, v)
				self:StopParticles()
				num = num + 1
			end
		end
	end

	local fuck = self.Delay
	if nzombies and IsValid(ply) then
		fuck = ply:HasPerk("time") and 1 or self.Delay
	end

	if self:GetLastAttack() ~= 0 and self:GetLastAttack() + fuck < CurTime() then
		self:SetLastAttack(0)
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

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local self_pos = self:GetAttachment(3).Pos
	local eye_position = nzombies and ent:GetAttachment(2).Pos or ent:EyePos()
	local head_position = eye_position[3] + 10
	local foot_position = ent:GetPos()[3]
	local length_head_to_toe = math.abs(head_position - foot_position)
	local length_head_to_toe_25_percent = length_head_to_toe * 0.25
	local is_headchop = tobool(self_pos[3] <= head_position and self_pos[3] >= head_position - length_head_to_toe_25_percent)
	local is_torsochop = tobool(self_pos[3] <= head_position - length_head_to_toe_25_percent and self_pos[3] >= foot_position + length_head_to_toe_25_percent)
	local is_footchop = tobool(math.abs(foot_position - self_pos[3]) <= length_head_to_toe_25_percent)

	local mydamage = 40
	if is_headchop then
		mydamage = ent:Health() + 666
	elseif is_torsochop then
		local rand = math.random(5,10) //10% to 20% base health as dmg

		if nzombies and ent:IsValidZombie() then
			local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
			local health = tonumber(nzCurves.GenerateHealthCurve(round))

			mydamage = math.max(mydamage, health / rand)
		else
			mydamage = math.max(mydamage, ent:GetMaxHealth() / rand)
		end
	elseif is_footchop then
		if nzombies and ent:IsValidZombie() and ent.BecomeCrawler and !ent.IsMooSpecial and !ent.HasGibbed then //crawl
			timer.Simple(0, function()
				if not IsValid(ent) then return end
				if ent.Alive and not ent:Alive() then return end
				if ent:Health() <= 0 then return end
				if ent.ShouldCrawl then return end
				if ent.HasGibbed then return end

				local lleg = ent:LookupBone("j_knee_le")
				local rleg = ent:LookupBone("j_knee_ri")
				local randleggib = math.random(4)

				if (lleg and !ent.LlegOff) and (randleggib == 1 or randleggib == 3) then
					ent.LlegOff = true
					ent:DeflateBones({
						"j_knee_le",
						"j_knee_bulge_le",
						"j_ankle_le",
						"j_ball_le",
					})

					ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 7)
				end

				if (rleg and !ent.RlegOff) and (randleggib == 2 or randleggib == 3) then
					ent.RlegOff = true
	    			ent:DeflateBones({
						"j_knee_ri",
						"j_knee_bulge_ri",
						"j_ankle_ri",
						"j_ball_ri",
					})

					ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 8)
				end

				ent:EmitSound("nz_moo/zombies/gibs/bodyfall/fall_0"..math.random(2)..".mp3",100)
				ent.ShouldCrawl = true
				ent:BecomeCrawler()
			end)
		end

		mydamage = 20
	end

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(self:GetAttachment(2).Ang:Up()*10000 + ent:GetUp()*5000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if ent.NZBossType then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 12))
	end

	if ent == ply then
		damage:SetDamage(20)
	end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		ParticleEffect("blood_impact_red_01", ent:WorldSpaceCenter() + (ent:OBBCenter() * .7), ent:GetForward():Angle())
		local rand = VectorRand(-12,12)
		rand = Vector(rand.x, rand.y, 1)
		util.Decal("Blood", ent:GetPos() - rand, ent:GetPos() + rand)
	end

	ent:TakeDamageInfo(damage)
	ent:EmitSound("TFA_BO3_GENERIC.Gib")
end