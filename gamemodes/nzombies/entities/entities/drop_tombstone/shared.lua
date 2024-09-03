AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "drop_tombstone"
ENT.Spawnable = false

ENT.Author = "Moo, Fox, Jen"
ENT.Contact = "dont"

ENT.OwnerData = {}
ENT.NextDraw = 0

ENT.Delay = 180
ENT.BlinkDelay = 30

ENT.pmpath = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
ENT.nickcage = Material("models/nzr/2023/powerups/tombstone/ugxm_nicky_cage_c.png", "unlitgeneric smooth")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Blinking")
	self:NetworkVar("Bool", 2, "Funny")

	self:NetworkVar("Float", 1, "BlinkTime")
	self:NetworkVar("Float", 2, "KillTime")
end

local color_black_180 = Color(0, 0, 0, 180)
local zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")

local function Draw3DText( pos, ang, scale, flipView, icon, name )
	if ( flipView ) then
		ang:RotateAroundAxis( vector_up, 180 )
	end
	if not icon or icon:IsError() then
		icon = zmhud_icon_missing
	end

	cam.Start3D2D(pos, ang, scale)
		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(-16, -16, 48,48)

		draw.SimpleTextOutlined(name, "nz.points."..GetFontType(nzMapping.Settings.smallfont), 8, 42, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_180)
	cam.End3D2D()
end

function ENT:Draw()
	local perkply = self:GetOwner()
	self.pmpath = Material("spawnicons/"..string.gsub(perkply:GetModel(),".mdl",".png"), "unlitgeneric smooth")

	local pos = self:GetPos() + self:GetUp()*42
	local ang = LocalPlayer():EyeAngles()

	ang = Angle(ang.x, ang.y, 0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	Draw3DText( pos, ang, 0.2, false, self:GetFunny() and self.nickcage or self.pmpath, perkply:Nick())

	self:DrawModel()

	if !self.loopglow or !IsValid(self.loopglow) then
		local colorvec1 = nzMapping.Settings.powerupcol["tombstone"][1]
		local colorvec2 = nzMapping.Settings.powerupcol["tombstone"][2]
		local colorvec3 = nzMapping.Settings.powerupcol["tombstone"][3]

		if nzMapping.Settings.powerupstyle then
			local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
			self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		else
			self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		end
	end
end

function ENT:Initialize()
	self:SetModel("models/nzr/2023/powerups/ch_tombstone1.mdl")

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 8)

	self:SetActivated(false)
	self:SetBlinking(false)

	if self:GetFunny() then
		self:SetMaterial("models/nzr/2023/powerups/tombstone/nick_cage_tombstone")
	else
		self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")
	end

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

	self:EmitSound(self.SpawnSound, 75)
	self:EmitSound(self.LoopSound, 75, 100, 0.5, 3)

	if CLIENT then return end
	-- Move up from ground
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() - Vector(0,0,50),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY,
	})

	if tr.HitWorld then
		self:SetPos(tr.HitPos + vector_up*38)
	end

	nzPowerUps:PowerupHudSync(self)

	local fx = EffectData()
	fx:SetOrigin(self:GetAttachment(1).Pos) //position
	fx:SetAngles(angle_zero) //angle
	fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
	fx:SetFlags(5) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

	local filter = RecipientFilter()
	filter:AddPVS(self:GetPos())
	if filter:GetCount() > 0 then
		util.Effect("nz_powerup_poof", fx, true, filter)
	end

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

function ENT:StartTouch(ply)
	if CLIENT then return end
	if IsValid(ply) and ply:IsPlayer() and ply == self:GetOwner() and ply:GetNotDowned() then
		local weps = self.OwnerData.weps
		if not table.IsEmpty(weps) then
			local active = ply:GetActiveWeapon()
			if IsValid(active) and !active:IsSpecial() then
				ply:StripWeapon(active:GetClass())
			end

			for i=1, #weps do
				timer.Simple(engine.TickInterval()*i, function()
					if not IsValid(ply) then return end

					local wep = ply:Give(weps[i].class)
					timer.Simple(engine.TickInterval(), function()
						if not IsValid(wep) then return end
						if weps[i].pap then
							wep:ApplyNZModifier("pap")
						end
						wep:GiveMaxAmmo()
					end)
				end)
			end
		end

		for _, perk in pairs(self.OwnerData.perks) do
			if perk == "tombstone" then continue end
			ply:GivePerk(perk)
		end

		if self.OwnerData.upgrade then
			ply:GivePoints(6000)
		end

		ply:EmitSound(self.GrabSound)

		self:Remove()
	end
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(0,50,0)*math.sin(CurTime()/10)*FrameTime())

		if !self:GetRenderOrigin() then self:SetRenderOrigin(self:GetPos()) end
		self:SetRenderOrigin(self:GetRenderOrigin() + Vector(0,0,4)*math.sin(CurTime()*2)*FrameTime())
		return
	end

	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:Remove()
		return false
	end

	if not self:GetActivated() then
		if ply:Alive() and ply:GetNotDowned() and (ply:IsPlayer() or ply:IsInCreative()) then
			self:SetBlinkTime(CurTime() + (self.Delay - self.BlinkDelay))
			self:SetKillTime(CurTime() + self.Delay)
			self:SetActivated(true)

			ply:ChatPrint('Tombstone activated, you have '..self.Delay..' seconds to grab your shit')
		end
	elseif self:GetActivated() then
		if (not ply:GetNotDowned() or not ply:Alive()) and (self:GetKillTime() - CurTime()) >= self.BlinkDelay then
			if not self.Fuckerdown then
				self.DownedAt = CurTime()
				self.Fuckerdown = self:GetKillTime() - CurTime()
			end
			self:SetKillTime(CurTime() + self.Fuckerdown)
			self:SetBlinkTime(CurTime() + (self.Fuckerdown - self.BlinkDelay))
		elseif self.Fuckerdown then
			ply:ChatPrint('Tombstone: Paused at '..math.Round(self.Fuckerdown, 2)..' second left, for '..math.Round(CurTime() - self.DownedAt, 2)..' seconds')

			self.DownedAt = nil
			self.Fuckerdown = nil
		end

		if self:GetKillTime() > 0 and self:GetKillTime() < CurTime() then
			self:Remove()
			return false
		end
	end

	if self:GetActivated() and self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + math.Clamp(1 * final, 0.1, 1)
	end

	if self:GetActivated() and not self:GetBlinking() and self:GetBlinkTime() < CurTime() then
		self:SetBlinking(true)
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.LoopSound)

	if SERVER then
		nzPowerUps:PowerupHudRemove(self)

		local fx = EffectData()
		fx:SetOrigin(self:GetPos()) //position
		fx:SetAngles(angle_zero) //angle
		fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
		fx:SetFlags(5) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

		local filter = RecipientFilter()
		filter:AddPVS(self:GetPos())
		if filter:GetCount() > 0 then
			util.Effect("nz_powerup_poof", fx, true, filter)
		end
	end
end