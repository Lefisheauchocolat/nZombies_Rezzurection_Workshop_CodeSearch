AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "invis_wall"
ENT.Author			= "Zet0r"
ENT.Contact			= "youtube.com/Zet0r"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	-- Min bound is for now just the position
	--self:NetworkVar("Vector", 0, "MinBound")
	self:NetworkVar("Vector", 0, "MaxBound")
	self:NetworkVar("Int", 0, "DamageWallType")
	self:NetworkVar("Int", 1, "Damage")
	self:NetworkVar("Float", 0, "Delay")
	self:NetworkVar("Bool", 0, "RespawnZombie")
	self:NetworkVar("Bool", 1, "Electric")
end

function ENT:Initialize()
	--self:SetMoveType( MOVETYPE_NONE )
	//self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetModel("models/BarneyHelmet_faceplate.mdl")
	self:DrawShadow( false )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	if self.SetRenderBounds then
		self:SetRenderBounds(Vector(0,0,0), self:GetMaxBound())
	end

	if SERVER then
		self.PlayersInside = {}
		self.ZombiesInside = {}
	else
		self.NextPoisonCloud = 0
	end

	self.NextDamage = 0
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() and !table.HasValue(self.PlayersInside, ent) then
		table.insert(self.PlayersInside, ent)
	end
	if ent:IsValidZombie() and ent:Alive() and !table.HasValue(self.ZombiesInside, ent) then
		table.insert(self.ZombiesInside, ent)
	end
end

function ENT:Touch(ent)
	--print("Touch", ent)
end

function ENT:EndTouch(ent)
	if table.HasValue(self.PlayersInside, ent) then
		table.RemoveByValue(self.PlayersInside, ent)
	end
	if table.HasValue(self.ZombiesInside, ent) then
		table.RemoveByValue(self.ZombiesInside, ent)
	end
end

//hee hee hoo hoo ha ha
function ENT:GetRadiation()
	return self:GetDamageWallType() == 1
end

function ENT:GetPoison()
	return self:GetDamageWallType() == 2
end

function ENT:GetTesla()
	return self:GetDamageWallType() == 3
end

function ENT:GetWarp()
	return self:GetDamageWallType() == 4
end

ENT.DamageWallEnums = {
	[1] = DMG_RADIATION,
	[2] = DMG_POISON,
	[3] = DMG_SHOCK,
	[4] = DMG_FALL,
}

function ENT:Think()
	local ct = CurTime()
	if SERVER and (!self.NextAttack or self.NextAttack < ct) and (!self:GetElectric() or (self:GetElectric() and nzElec:IsOn())) then
		local dmg = DamageInfo()
		dmg:SetDamage(self:GetDamage())
		dmg:SetAttacker(self)
		dmg:SetDamageType(self.DamageWallEnums[self:GetDamageWallType()])

		for k, v in ipairs(self.PlayersInside) do
			if !IsValid(v) then self.PlayersInside[k] = nil continue end

			if self:GetWarp() then
				self:WarpPlayer(v)
			elseif self:GetTesla() and v:GetNotDowned() then
				v:EmitSound("weapons/physcannon/superphys_small_zap" .. math.random(1,4) .. ".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
			elseif self:GetRadiation() and v:GetNotDowned() then
				v:EmitSound("player/geiger"..math.random(1,3)..".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
			end

			if !v:GetNotDowned() then continue end

			local data = self:GetTouchTrace()
			local tr = util.TraceLine({
				start = data.HitPos,
				endpos = v:EyePos(),
				mask = MASK_SHOT_HULL,
				filter = {self},
			})

			dmg:SetDamagePosition(tr.Entity == v and tr.HitPos or v:WorldSpaceCenter())
			dmg:SetReportedPosition(data.HitPos)

			v:TakeDamageInfo(dmg)
		end

		for k, v in ipairs(self.ZombiesInside) do
			if !IsValid(v) then self.ZombiesInside[k] = nil continue end

			if !v:Alive() then
				self:EndTouch(v)
			else
				if self:GetRespawnZombie() == true then
					v:RespawnZombie(false)
				end
			end
		end

		self.NextAttack = ct + self:GetDelay()
	end

	self:NextThink(ct)
	return true
end

function ENT:WarpPlayer(ply)
	local pspawns = ents.FindByClass("player_spawns")
	local pos = ply:GetPos()

	if IsValid(pspawns[1]) then
		pos = pspawns[math.random(#pspawns)]:GetPos()
	else
		ply:ChatPrint("[NZ] No player spawns to teleport to, failed.")
	end

	sound.Play("nzr/2022/perks/chuggabud/teleport_out_0"..math.random(0,1)..".wav", ply:EyePos(), SNDLVL_GUNFIRE, math.random(97,103), 1)

	ply:SetLocalVelocity(vector_origin)
	ply:SetPos(pos)

	ply:StopSound("nz_moo/effects/out_of_play_area.wav")
	ply:EmitSound("nz_moo/effects/out_of_play_area.wav", SNDLVL_IDLE, math.random(97, 103), 1, CHAN_STATIC)

	ParticleEffect("nz_perks_chuggabud_tp", pos + vector_up, angle_zero)
end

local mat = Material("color")
local white = Color(255,0,0,30)

if CLIENT then

	if not ConVarExists("nz_creative_preview") then CreateClientConVar("nz_creative_preview", "0") end
	
	local particles = {
		Model("particle/particle_smokegrenade"),
		Model("particle/particle_noisesphere")
	}

	function ENT:Draw()
		if ConVarExists("nz_creative_preview") and !GetConVar("nz_creative_preview"):GetBool() and nzRound:InState( ROUND_CREATE ) then
			cam.Start3D()
				render.SetMaterial(mat)
				render.DrawBox(self:GetPos(), self:GetAngles(), Vector(0,0,0), self:GetMaxBound(), white, true)
			cam.End3D()
		end
		
		if self:GetPoison() then
			if self:GetElectric() and !nzElec:IsOn() then
				if self.PoisonEmitter and IsValid(self.PoisonEmitter) then
					self.PoisonEmitter:Finish()
				end
				return
			end

			local size = self:GetMaxBound()
			local scale = math.abs(size.x * size.y * size.z)
			
			if !IsValid(self.PoisonEmitter) then
				self.PoisonEmitter = ParticleEmitter(self:GetPos())
			end
			if self.NextPoisonCloud < CurTime() then
				local count = math.Clamp(math.Round(0.00000001 * scale), 1, 100)
				
				for i = 1, count do
					local pos = self:GetPos() + Vector(size.x * math.Rand(0,1), size.y * math.Rand(0,1), size.z * math.Rand(0,1))
					local p = self.PoisonEmitter:Add(particles[math.random(#particles)] , pos)
					p:SetColor(math.random(30,40), math.random(40,70), math.random(0,30))
					p:SetStartAlpha(255)
					p:SetEndAlpha(150)
					p:SetLifeTime(0)
					p:SetDieTime(math.Rand(1, 2.5))
					p:SetStartSize(math.random(45, 50))
					p:SetEndSize(math.random(20, 30))
					p:SetRoll(math.random(-180, 180))
					p:SetRollDelta(math.Rand(-0.1, 0.1))
					p:SetLighting(false)
				end
				self.NextPoisonCloud = CurTime() + 0.1
			end
		end
	end
	
	function ENT:OnRemove()
		if self.PoisonEmitter then self.PoisonEmitter:Finish() end
	end
end

hook.Add("PhysgunPickup", "nzInvisWallDamageNotPickup", function(ply, wall)
	if wall:GetClass() == "invis_damage_wall" then return false end
end)
