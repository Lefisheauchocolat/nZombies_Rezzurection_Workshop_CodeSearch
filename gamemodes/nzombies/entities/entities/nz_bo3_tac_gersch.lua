
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
ENT.PrintName = "Black Hole (nZombies)"

--[Sounds]--
ENT.BlackHoleStartSND = "TFA_BO3_GERSCH.BHStart"

ENT.BlackHoleLoopFarSND = Sound("TFA_BO3_GERSCH.BHLoopFar")
ENT.BlackHoleLoopCloseSND = Sound("TFA_BO3_GERSCH.BHLoopClose")

ENT.BlackHoleEndingSND = "TFA_BO3_GERSCH.BHPrePop"
ENT.BlackHoleCollapseSND = "TFA_BO3_GERSCH.BHPop"

--[Parameters]--
ENT.BHBomb = true
ENT.BossRange = 600
ENT.Delay = 8
ENT.DelayPaP = 16
ENT.Kills = 0
ENT.NZThrowIcon = Material("vgui/icon/hud_blackhole.png", "unlitgeneric smooth")
ENT.NZTacticalPaP = true

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Dying")
	self:NetworkVar("Bool", 2, "Activated")

	self:NetworkVar("Vector", 0, "TelePos")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self:EmitSound("TFA_BO3_GERSCH.Bounce")
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:ActivateCustom(phys)
	if CLIENT then return end
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	util.ScreenShake(self:GetPos(), 10, 255, 1, 512)

	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	UpdateAllZombieTargets(self)

	self:CreateCore()
	self:CreateExitCore()

	self.killtime = CurTime() + (self:GetUpgraded() and self.DelayPaP or self.Delay)
	self:SetActivated(true)

	/*if game.GetMap() == "nz_moon" then //i dont know how to do this, and why it wont work
		local plate = ents.FindByName("plates_urt_trigger")[1]
		local filter = ents.FindByName('gersh_filter')[1]
		if IsValid(plate) and IsValid(filter) then
			plate:Fire("OnTrigger", "", 2.5, filter, filter)
		end
	end*/
end

function ENT:CreateCore()
	local core = ents.Create("prop_physics")
	core:SetModel("models/dav0r/hoverball.mdl")
	core:SetModelScale(0.4, 0)
	core:SetPos(self:GetPos() + Vector(0,0,64))
	core:SetAngles(angle_zero)
	core:SetParent(self)

	core:Spawn()

	timer.Simple(0, function()
		core:SetCollisionGroup(COLLISION_GROUP_NONE)
		core:SetSolid(SOLID_NONE)
	end)
	core:SetMaterial("models/weapons/tfa_bo3/gersch/lambert1")

	local phys = core:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.CoreMDL = core

	self.CoreMDL:EmitSound(self.BlackHoleStartSND)
	self.CoreMDL:EmitSound(self.BlackHoleLoopFarSND)
	self.CoreMDL:EmitSound(self.BlackHoleLoopCloseSND)

	timer.Simple(0, function()
		if not (IsValid(self) and IsValid(self.CoreMDL)) then return end
		ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_loop_pap" or "bo3_gersch_loop", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL, 0)
	end)
end

function ENT:CreateExitCore()
	local core2 = ents.Create("prop_physics")
	core2:SetModel("models/dav0r/hoverball.mdl")
	core2:SetModelScale(0.4, 0)
	core2:SetPos(self:GetTelePos() + Vector(0,0,64))
	core2:SetAngles(angle_zero)
	core2:SetParent(self)
	
	core2:Spawn()

	timer.Simple(0, function()
		core2:SetCollisionGroup(COLLISION_GROUP_NONE)
		core2:SetSolid(SOLID_NONE)
	end)
	core2:SetMaterial("models/weapons/tfa_bo3/gersch/lambert1")

	local phys = core2:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.CoreMDL2 = core2

	self.CoreMDL2:EmitSound(self.BlackHoleLoopCloseSND)

	timer.Simple(0, function()
		if not (IsValid(self) and IsValid(self.CoreMDL2)) then return end
		ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_loop_2_pap" or "bo3_gersch_loop_2", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL2, 0)
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	if CLIENT then return end
	self:ConstructTeleportPos()

	timer.Simple(5, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if self:GetActivated() and (dlight) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = 185
			dlight.g = 70
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.2
		end
	end

	if SERVER then
		local core = self.CoreMDL
		if self:GetActivated() and IsValid(core) then
			local killtrigger = ents.FindInSphere(core:GetPos(), 42)

			for k, v in pairs(killtrigger) do
				if v:IsValidZombie() then
					if string.find(v:GetClass(), "zombie_boss") then continue end
					if v.Alive and not v:Alive() then continue end
					if v.NZBossType or v.IsMooBossZombie then continue end
					if v.SpawnProtection then continue end

					self:InflictDamage(v)
				end

				if v:IsPlayer() and not v:IsOnGround() and math.abs(v:GetVelocity()[3]) > 0 then //what the fuck even
					local vel = v:GetVelocity()
					v:SetPos(self:GetTelePos() + Vector(0,0,4))
					v:SetGroundEntity(nil)
					v:SetLocalVelocity(vel)

					self:EmitSound("TFA_BO3_GERSCH.Teleport")
					v:EmitSound("TFA_BO3_GERSCH.TeleOut")

					ParticleEffectAttach("bo3_gersch_player_insanity", PATTACH_ABSORIGIN_FOLLOW, v, 0)
					self:BossCheck(v)
				end
			end
		end

		if self:GetActivated() and self.killtime < CurTime() and !self:GetDying() then
			self:EmitSound(self.BlackHoleEndingSND)

			core:StopSound(self.BlackHoleLoopFarSND)
			core:StopSound(self.BlackHoleLoopCloseSND)
			core:StopParticles()

			timer.Simple(0, function()
				if not (IsValid(self) and IsValid(core)) then return end
				ParticleEffectAttach(self:GetUpgraded() and "bo3_gersch_end_pap" or "bo3_gersch_end", PATTACH_ABSORIGIN_FOLLOW, core, 0)
			end)

			SafeRemoveEntityDelayed(self, 1.4)
			self:SetDying(true)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:BossCheck(ply)
	if not IsValid(ply) then return end

	for k, ent in pairs(ents.FindInSphere(self:GetPos(), self.BossRange)) do
		if not ent.IsMooBossZombie then continue end
		if not ent.GetTarget then continue end

		local target = ent:GetTarget()
		local core = self.CoreMDL
		local goalpos = core:GetPos()

		if IsValid(target) and target:EntIndex() == ply:EntIndex() then
			local timername = "panzer_redirect"..ent:EntIndex()
			local tickrate = 1 / engine.TickInterval()

			timer.Create(timername, 0, 4*tickrate, function() //4 seconds
				if not IsValid(ent) or not IsValid(core) or not IsValid(self) then timer.Remove(timername) return end

				ent.loco:FaceTowards(goalpos)
				ent.loco:Approach(goalpos, 99)

				if ent:GetPos():DistToSqr(goalpos) < 10000 then
					ent:SetPos(self:GetTelePos() + vector_up)
					core:EmitSound("TFA_BO3_GERSCH.Teleport")
					ent:EmitSound("TFA_BO3_GERSCH.TeleOut")

					ParticleEffectAttach("bo3_gersch_player_insanity", PATTACH_POINT_FOLLOW, ent, 1)

					if IsValid(ply) and not ply.ugxbossachievment then
						TFA.BO3GiveAchievement("They can Teleport too!?", "vgui/overlay/achievment/Full_Lockdown.png", ply, 1)
						ply.ugxbossachievment = true
					end
					timer.Remove(timername)
				end
			end)
		end
	end
end

function ENT:GerschSuck(ent)
	if not IsValid(ent) then return end

	if ent.HasSequence then
		if ent:HasSequence(ent.BlackHoleDeathSequences[1]) then
			if (ent.ShouldCrawl or ent:GetCrawler()) and ent.BlackHoleCrawlDeathSequences then
				ent:DoDeathAnimation(ent.BlackHoleCrawlDeathSequences[math.random(#ent.BlackHoleCrawlDeathSequences)])
			else
				ent:DoDeathAnimation(ent.BlackHoleDeathSequences[math.random(#ent.BlackHoleDeathSequences)])
			end
		end
	else
		if (ent.ShouldCrawl or ent:GetCrawler()) and ent.BlackHoleCrawlDeathSequences then
			ent:DoDeathAnimation(ent.BlackHoleCrawlDeathSequences[math.random(#ent.BlackHoleCrawlDeathSequences)])
		else
			ent:DoDeathAnimation(ent.BlackHoleDeathSequences[math.random(#ent.BlackHoleDeathSequences)])
		end
	end
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetInflictor(self)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)

	if ent.BlackHoleDeathSequences then
		damage:SetDamageType(DMG_NEVERGIB)
		ent:SetNW2Bool("GerschSuckd", true)
	else
		damage:SetDamageType(DMG_REMOVENORAGDOLL)
		ParticleEffect("bo3_gersch_kill", ent:WorldSpaceCenter(), angle_zero)
		ent:EmitSound("TFA_BO3_GERSCH.Suck")
	end

	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)

	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)

	if (ent:IsNPC() or ent:IsNextBot()) then
		self.Kills = self.Kills + 1
		if self.Kills == 6 and IsValid(ply) and ply:IsPlayer() then
			if not ply.bo3gerschachievement then
				TFA.BO3GiveAchievement("They are going THROUGH!", "vgui/overlay/achievment/blackhole.png", ply, 1)
				ply.bo3gerschachievement = true
			end
		end
	end

	if ent:IsValidZombie() and ent.DoDeathAnimation and ent.BlackHoleDeathSequences then
		self:GerschSuck(ent)
	end

	local gib = ents.Create("bo3_misc_gib")
	gib:SetPos(self.CoreMDL2:GetPos())
	gib:Spawn()
	local phys = gib:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(Vector(0,math.random(10,20)*100,0))
		phys:SetVelocity(Vector(math.random(-100,100), math.random(-100,100), math.random(5,15)*10))
	end
end

function ENT:ConstructTeleportPos()
	local available = ents.FindByClass("nz_spawn_zombie_special")
	local pos = vector_origin
	local spawns = {}

	if IsValid(available[1]) and !nzMapping.Settings.specialsuseplayers then
		for k,v in pairs(available) do
			if v.link == nil or nzDoors:IsLinkOpened( v.link ) then -- Only for rooms that are opened (using links)
				if v:IsSuitable() then -- And nothing is blocking it
					table.insert(spawns, v)
				end
			end
		end
		if !IsValid(spawns[1]) then -- Still no open linked ones?! Spawn at a random player spawnpoint
			local pspawns = ents.FindByClass("player_spawns")
			if !IsValid(pspawns[1]) then
				--ply:Spawn()
				ply:ChatPrint("Couldnt Find Exit Location for Gersch")
			else
				pos = pspawns[math.random(#pspawns)]:GetPos()
			end
		else
			pos = spawns[math.random(#spawns)]:GetPos()
		end
	else -- There exists no special spawnpoints - Use regular player spawns
		local pspawns = ents.FindByClass("player_spawns")
		if IsValid(pspawns[1]) then
			pos = pspawns[math.random(#pspawns)]:GetPos()
		end
	end

	self:SetTelePos(pos)
end

function ENT:OnRemove()
	if SERVER then
		if IsValid(self.CoreMDL) and IsValid(self.CoreMDL2) then
			ParticleEffect(self:GetUpgraded() and "bo3_gersch_explode_pap" or "bo3_gersch_explode", self.CoreMDL:GetPos(), angle_zero)

			util.ScreenShake(self:GetPos(), 10, 255, 1, 512)

			self.CoreMDL:StopSound(self.BlackHoleLoopFarSND)
			self.CoreMDL:StopSound(self.BlackHoleLoopCloseSND)
			self.CoreMDL:EmitSound(self.BlackHoleCollapseSND)

			self.CoreMDL2:StopSound(self.BlackHoleLoopFarSND)
			self.CoreMDL2:StopSound(self.BlackHoleLoopCloseSND)
			self.CoreMDL2:EmitSound(self.BlackHoleCollapseSND)
		end
	end
end