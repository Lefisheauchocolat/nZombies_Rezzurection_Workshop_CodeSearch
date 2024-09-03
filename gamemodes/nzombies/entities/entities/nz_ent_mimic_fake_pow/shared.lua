AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "drop_powerups"
ENT.Spawnable = false

ENT.Author = "Moo"
ENT.Contact = "dont"

game.AddParticles("particles/moo_powerup_fx.pcf")

ENT.NextDraw = 0

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PowerUp")

	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Blinking")

	self:NetworkVar("Float", 0, "ActivateTime")
	self:NetworkVar("Float", 1, "BlinkTime")
	self:NetworkVar("Float", 2, "KillTime")
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()

	local mdls = {
		"models/powerups/w_double.mdl",
		"models/powerups/w_maxammo.mdl",
		"models/powerups/w_insta.mdl",
		"models/powerups/w_nuke.mdl",
		"models/powerups/w_perkbottle.mdl",
		"models/powerups/w_bonfire.mdl",
		"models/powerups/w_packapunch.mdl",
	}

	self:SetModel(mdls[math.random(#mdls)])

	--self:PhysicsInitSphere(60, "default_silent")
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 1)
	self:DrawShadow(false)

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

	local colorvec1 = nzMapping.Settings.powerupcol["global"][1]
	local colorvec2 = nzMapping.Settings.powerupcol["global"][2]
	local colorvec3 = nzMapping.Settings.powerupcol["global"][3]

	if CLIENT then
		local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
		self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_ABSORIGIN_FOLLOW)
		self.loopglow:SetControlPoint(2, colorvec1)
		self.loopglow:SetControlPoint(3, colorvec2)
		self.loopglow:SetControlPoint(4, colorvec3)
		self.loopglow:SetControlPoint(1, Vector(1,1,1))
	end

	self:SetActivateTime(0)
	self:SetBlinkTime(CurTime() + 25)
	self:SetKillTime(CurTime() + 30)

	self:SetActivated(false)
	self:SetBlinking(false)

	if CLIENT then return end
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
	end

	if not self:GetActivated() then
		self:DrawShadow(true)

		self:EmitSound(self.LoopSound,75, 100, 1, 3)
		self:EmitSound(self.SpawnSound,100)
		self:StopSound("nz_moo/powerups/powerup_intro_lp.wav")
		self:SetActivated(true)
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if IsValid(self) then
		self:StopParticles()

		self:StopSound("nz_moo/powerups/powerup_intro_lp.wav")
		self:StopSound("nz_moo/powerups/powerup_lp_zhd.wav")
		self:StopSound(self.LoopSound)
	end
end
