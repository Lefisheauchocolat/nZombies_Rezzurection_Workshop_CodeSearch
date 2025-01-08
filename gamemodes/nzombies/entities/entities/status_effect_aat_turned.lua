AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Turned Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	local oldturnednames = {
		"Odious Individual", "Laby after Taco Bell", "Fucker.lua", "Turned",
		"Shitass", "Miscellaneous Intent", "The Imposter", "Zobie",
		"Creeper, aww man", "Herbin", "Category Five", "TheRelaxingEnd",
		"Zet0r", "Dead By Daylight", "Cave Johnson", "Vinny Vincesauce",
		"Who's Who?", "MR ELECTRIC, KILL HIM!", "Jerma985", "Steve Jobs",
		"BRAAAINS...", "The False Shepherd", "Timer Failed!", "r_flushlod",
		"Doctor Robotnik", "Clown", "Left 4 Dead 2", "Squidward Tortellini",
		"Five Nights at FNAF", "Minecraft Steve", "Wowee Zowee", "Gorgeous Freeman",
		"fog rolling in", "Exotic Butters", "Brain Rot", "Team Fortress 2",
		"Roblox", "Cave1.ogg", "Fin Fin", "Jimmy Gibbs Jr.", "Brain Blast",
		"Sheen"
	}

	entMeta.AATTurned = function(self, duration, attacker, dance)
		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if dance == nil then
			dance = false
		end

		if IsValid(self.perk_turned_logic) then
			self.perk_turned_logic:UpdateDuration(duration)
			return self.perk_turned_logic
		end

		local name = "Turned"
		local turnedlist = nzMapping.Settings.turnedlist
		if turnedlist then
			for k, v in RandomPairs(nzMapping.Settings.turnedlist) do
				if k ~= "" then
					name = k
					break
				end
			end
		else
			for k, v in RandomPairs(oldturnednames) do
				name = v
				break
			end
		end

		self.perk_turned_logic = ents.Create("status_effect_aat_turned")
		self.perk_turned_logic:SetPos(self:WorldSpaceCenter())
		self.perk_turned_logic:SetParent(self)
		self.perk_turned_logic:SetOwner(self)
		self.perk_turned_logic:SetAttacker(attacker)
		self.perk_turned_logic:SetDance(dance)
		self.perk_turned_logic:SetTurnedName(name)

		self.perk_turned_logic:Spawn()
		self.perk_turned_logic:Activate()

		self.perk_turned_logic:SetOwner(self)
		self.perk_turned_logic:UpdateDuration(duration)
		self:SetNW2Entity("PERK.TurnedLogic", self.perk_turned_logic)
		return self.perk_turned_logic
	end

	hook.Add("OnZombieKilled", "PERK.TurnedLogic", function(self)
		if IsValid(self.perk_turned_logic) then
			return self.perk_turned_logic:Remove()
		end
	end)
end

entMeta.IsAATTurned = function(self)
	return IsValid(self:GetNW2Entity("PERK.TurnedLogic"))
end

ENT.UpdateTransmitState = function(self)
	return TRANSMIT_ALWAYS
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Bool", 0, "Dance")
	self:NetworkVar("String", 0, "TurnedName")
end

local turned_color = Color(40, 255, 0, 255)
local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		ang:RotateAroundAxis( vector_up, 180 )
	end

	cam.Start3D2D(pos, ang, scale)
		cam.IgnoreZ(true)
		draw.DrawText(tostring(text), nzombies and "nz.small."..GetFontType(nzMapping.Settings.smallfont) or "ChatFont", 0, 0, turned_color, TEXT_ALIGN_CENTER)
		cam.IgnoreZ(false)
	cam.End3D2D()
end

ENT.Draw = function(self)
	local text = self:GetTurnedName()

	local pos = self:GetPos() + self:GetUp()*42
	local ang = LocalPlayer():EyeAngles()
	ang = Angle(ang.x, ang.y, 0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	Draw3DText( pos, ang, 0.2, text, false )
	Draw3DText( pos, ang, 0.2, text, true )
end

local bigbrain = {
	["Big Head"] = true,
	["Brain Blast"] = true,
	["Sheen"] = true,
}

ENT.Initialize = function(self)
	self:SetMaterial("null")
	self:DrawShadow(false)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		if p:GetClass() == "nz_zombie_boss_astro" then
			self:SetTurnedName("The Imposter")
			p:SetColor(Color(255, 0, 0, 255))
		end

		ParticleEffectAttach("bo3_aat_turned", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		p:EmitSound("NZ.POP.Turned.Impact")

		if bigbrain[self:GetTurnedName()] then
			local headbone = p:LookupBone("j_head")
			if headbone then
				p:ManipulateBoneScale(headbone, Vector(3,3,3))
			end
		end

		if self:GetDance() then
			if SERVER and p.SetTargetPriority then
				p:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
			end
		else
			p.IsTurned = true
			p:EmitSound("NZ.POP.Turned.Loop")
		end
	end

	if CLIENT then return end
	if IsValid(p) and p:IsNextBot() then
		if self:GetDance() or (p.IsMooSpecial and not p.MooSpecialZombie and !p.AffectedByTurned) then
			p.loco:SetVelocity(vector_origin)
			p.loco:SetAcceleration(0)
			p.loco:SetDesiredSpeed(0)
			if nzombies and p:IsValidZombie() then
				p:SetBlockAttack(true)
			end
		end
		p:SetTarget(nil)
	end

	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end
	local p = self:GetParent()
	if (p.IsMooSpecial and not p.MooSpecialZombie and !p.AffectedByTurned) and p.Freeze then
		p:Freeze(newtime)
	end

    self.duration = newtime
    self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end
	local p = self:GetParent()
	for k, v in pairs(ents.FindInSphere(self:EyePos(), 58)) do
		if nzombies and v:GetClass() == "drop_powerup" then
			local ply = self:GetAttacker()
			if IsValid(ply) and v:GetPowerUp() ~= "nuke" then
				nzPowerUps:Activate(v:GetPowerUp(), ply, v)
				ply:EmitSound(nzPowerUps:Get(v:GetPowerUp()).collect or "nz_moo/powerups/powerup_pickup_zhd.mp3")
				v:Remove()
			end
		end

		if self:GetDance() then
			if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 and v ~= p then
				if nzombies and (v.NZBossType or v.IsMooBossZombie or v.IsMiniBoss or string.find(v:GetClass(), "zombie_boss")) then continue end
				if v:IsAATTurned() then continue end

				v:BO3Mystify(0.35)
			end
		end
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.Explode = function(self)
	if SERVER then
		local ent = self:GetParent()
		local damage = DamageInfo()
		damage:SetDamage(54000)
		damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
		damage:SetInflictor(IsValid(ent) and ent or self)
		damage:SetDamageType(DMG_MISSILEDEFENSE)

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
			if (v:IsNPC() or v:IsNextBot()) then
				damage:SetDamageForce(v:GetUp()*math.random(8000,12000) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(12000,14000))
				v:TakeDamageInfo(damage)
			end
		end

		util.ScreenShake(self:GetPos(), 10, 255, 1.5, 400)
	end

	if IsFirstTimePredicted() then
		ParticleEffect("grenade_explosion_01", self:GetPos(), angle_zero)
		ParticleEffect("bo3_annihilator_blood", self:GetPos(), angle_zero)

		self:EmitSound("TFA_BO3_GRENADE.Dist")
		self:EmitSound("TFA_BO3_GRENADE.Exp")
		self:EmitSound("TFA_BO3_GENERIC.Gib")
		self:EmitSound("TFA_BO3_ANNIHILATOR.Exp")
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p.IsTurned = false
		p:StopParticles()
		p:StopSound("NZ.POP.Turned.Loop")

		self:Explode()
		if SERVER and p:IsNextBot() or p:IsNPC() then
			p:Remove()
			if nzombies and nzRound:InProgress() then
				nzRound:SetZombiesKilled(nzRound:GetZombiesKilled() + 1)
			end
		end
	end
end
