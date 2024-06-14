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
	self:SetModelScale(1, 0)

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

	ParticleEffectAttach("nz_powerup_local", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	self:SetKillTime(CurTime() + self.Delay)
	self:SetBlinkTime(CurTime() + (self.Delay - 5))

	if CLIENT then return end
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
end
