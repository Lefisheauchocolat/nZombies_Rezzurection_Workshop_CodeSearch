AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Widows Refill"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false

--[Parameters]--
ENT.Delay = 30
ENT.NextDraw = 0

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Blinking")
	self:NetworkVar("Float", 0, "KillTime")
	self:NetworkVar("Float", 1, "BlinkTime")
end

function ENT:Draw()
	self:DrawModel()

	if nzPowerUps.PowerUpGlowTypes and (!self.loopglow or !IsValid(self.loopglow)) then
		local colorvec1 = nzMapping.Settings.powerupcol["local"][1]
		local colorvec2 = nzMapping.Settings.powerupcol["local"][2]
		local colorvec3 = nzMapping.Settings.powerupcol["local"][3]

		if nzMapping.Settings.powerupstyle then
			local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
			self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_ABSORIGIN_FOLLOW)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		else
			self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_ABSORIGIN_FOLLOW)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		end
	end
end

function ENT:StartTouch(ply)
	if ply:IsPlayer() and ply:HasPerk("widowswine") and ply:GetAmmoCount(GetNZAmmoID("grenade")) < 4 then
		self:StopSound(self.LoopSound)
		self:EmitSound(self.GrabSound)

		ply:SetAmmo(ply:GetAmmoCount(GetNZAmmoID("grenade")) + (ply:HasUpgrade("widowswine") and 2 or 1), GetNZAmmoID("grenade"))
		self:Remove()
	end
end

function ENT:Initialize(...)
	self:SetModel("models/nzr/2022/powerups/powerup_widows.mdl")

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 8)

	self.LoopSound =  "nz_moo/powerups/powerup_lp_zhd.wav"
	self.GrabSound = "nz_moo/powerups/powerup_pickup_zhd.mp3"
	self.SpawnSound = "nz_moo/powerups/powerup_spawn_zhd_"..math.random(1,3)..".mp3"
	if !table.IsEmpty(nzSounds.Sounds.Custom.Loop) then
		self.LoopSound = tostring(nzSounds.Sounds.Custom.Loop[math.random(#nzSounds.Sounds.Custom.Loop)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Grab) then
		self.GrabSound = tostring(nzSounds.Sounds.Custom.Grab[math.random(#nzSounds.Sounds.Custom.Grab)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Spawn) then
		self.SpawnSound = tostring(nzSounds.Sounds.Custom.Spawn[math.random(#nzSounds.Sounds.Custom.Spawn)])
	end

	self:EmitSound(self.SpawnSound, 100)
	self:EmitSound(self.LoopSound, 75, 100, 1, 3)

	self:SetKillTime(CurTime() + self.Delay)
	self:SetBlinkTime(CurTime() + (self.Delay - 5))

	if CLIENT then return end
	-- Move up from ground
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() - Vector(0,0,50),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
	})

	if tr.HitWorld then
		self:SetPos(tr.HitPos + Vector(0,0,50))
	end

	nzPowerUps:PowerupHudSync(self)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos()) //position
	fx:SetAngles(angle_zero) //angle
	fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
	fx:SetFlags(2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

	local filter = RecipientFilter()
	filter:AddPVS(self:GetPos())
	if filter:GetCount() > 0 then
		util.Effect("nz_powerup_poof", fx, true, filter)
	end

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
	end

	if self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + (1 * final)

		if not self:GetNoDraw() and final > 0.25 then
			ParticleEffectAttach("nz_powerup_local", PATTACH_ABSORIGIN_FOLLOW, self, 1)
		end
	end

	if not self:GetBlinking() and self:GetBlinkTime() < CurTime() then
		self:SetBlinking(true)
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
	if SERVER then
		nzPowerUps:PowerupHudRemove(self)

		local fx = EffectData()
		fx:SetOrigin(self:GetPos()) //position
		fx:SetAngles(angle_zero) //angle
		fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
		fx:SetFlags(2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

		local filter = RecipientFilter()
		filter:AddPVS(self:GetPos())
		if filter:GetCount() > 0 then
			util.Effect("nz_powerup_poof", fx, true, filter)
		end
	end
end
