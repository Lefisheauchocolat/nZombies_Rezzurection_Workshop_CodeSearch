AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Black Hole"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.BlackHoleStartSND = "TFA_BO3_GERSCH.BHStart"

ENT.BlackHoleLoopFarSND = Sound("TFA_BO3_GERSCH.BHLoopFar")
ENT.BlackHoleLoopCloseSND = Sound("TFA_BO3_GERSCH.BHLoopClose")

ENT.BlackHoleEndingSND = "TFA_BO3_GERSCH.BHPrePop"
ENT.BlackHoleCollapseSND = "TFA_BO3_GERSCH.BHPop"

ENT.BHBomb = true
ENT.BossRange = 600
ENT.Delay = 4.6
ENT.NZThrowIcon = Material("vgui/icon/t7_zm_hud_blackhole.png", "unlitgeneric smooth")

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
	self:NetworkVar("Bool", 0, "Dying")
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Vector", 0, "TelePos")
end

function ENT:Initialize()
	self:SetParent(nil)
	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	if CLIENT then return end
	util.ScreenShake(self:GetPos(), 10, 5, 1, 512)

	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	self:ConstructTeleportPos()
	self:CreateCore()
	self:CreateExitCore()

	self.killtime = CurTime() + self.Delay
	self:SetActivated(true)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 24)
end

function ENT:CreateCore()
	local core = ents.Create("prop_physics")
	core:SetModel("models/dav0r/hoverball.mdl")
	core:SetModelScale(0.4, 0)
	core:SetPos(self:GetPos() + Vector(0,0,64))
	core:SetAngles(angle_zero)
	core:SetParent(self)
	core:SetMoveType(MOVETYPE_NONE)

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

	ParticleEffectAttach("bo3_gersch_loop", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL, 0)
end

function ENT:CreateExitCore()
	local core2 = ents.Create("prop_physics")
	core2:SetModel("models/dav0r/hoverball.mdl")
	core2:SetModelScale(0.4, 0)
	core2:SetPos(self:GetTelePos() + Vector(0,0,64))
	core2:SetAngles(angle_zero)
	core2:SetParent(self)
	core2:SetMoveType(MOVETYPE_NONE)
	
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

	ParticleEffectAttach("bo3_gersch_loop_2", PATTACH_ABSORIGIN_FOLLOW, self.CoreMDL2, 0)
end

function ENT:Think()
	if CLIENT and DynamicLight then
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

					self:InflictDamage(v)
				end

				if v:IsPlayer() and not v:IsOnGround() then
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
			self:EmitSound("TFA_BO3_GERSCH.BHPrePop")

			core:StopSound(self.BlackHoleLoopFarSND)
			core:StopSound(self.BlackHoleLoopCloseSND)
			core:StopParticles()

			timer.Simple(0, function()
				if not (IsValid(self) and IsValid(core)) then return end
				ParticleEffectAttach("bo3_gersch_end", PATTACH_ABSORIGIN_FOLLOW, core, 0)
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
		if not string.find(ent:GetClass(), "zombie_boss") then continue end
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

	if ent:IsValidZombie() and ent.DoDeathAnimation and ent.BlackHoleDeathSequences then
		if (ent.ShouldCrawl or ent:GetCrawler()) and ent.BlackHoleCrawlDeathSequences then
			ent:DoDeathAnimation(ent.BlackHoleCrawlDeathSequences[math.random(#ent.BlackHoleCrawlDeathSequences)])
		else
			ent:DoDeathAnimation(ent.BlackHoleDeathSequences[math.random(#ent.BlackHoleDeathSequences)])
		end
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

	if IsValid(available[1]) then
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
			ParticleEffect("bo3_gersch_explode", self.CoreMDL:GetPos(), angle_zero)

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