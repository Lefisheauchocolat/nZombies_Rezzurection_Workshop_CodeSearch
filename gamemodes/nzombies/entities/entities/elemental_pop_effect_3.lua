AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Firework"
ENT.Spawnable = false

--[Parameters]--
ENT.RPM = 400
ENT.ClipSize = 20
ENT.MuzzleAttach = 1
ENT.Kills = 0
ENT.MaxKills = 24
ENT.NumShots = 1
ENT.Range = 200

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Silenced")

	self:NetworkVar("Int", 0, "Clip1")
	self:NetworkVar("Int", 1, "RPM")

	self:NetworkVar("Int", 2, "CurrentWeaponProficiency")
	self:NetworkVar("Int", 3, "AmmoCount")

	self:NetworkVar("Vector", 0, "AimVector")
	self:NetworkVar("Vector", 1, "ShootPos")

	self:NetworkVar("Float", 0, "NextPrimaryFire")

	self:NetworkVar("Entity", 0, "ActiveWeapon")
	self:NetworkVar("Entity", 1, "Attacker")
	self:NetworkVar("Entity", 2, "Inflictor")
end

function ENT:Initialize()
	if SERVER then
		SafeRemoveEntityDelayed(self, 40)
	end

	self:SetParent(nil)

	self:SetModel("models/weapons/tfa_bo3/qed/w_kn44.mdl")

	self:SetRPM(self.RPM)
	self:SetClip1(self.ClipSize)
	self:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_PERFECT)
	self:SetAimVector(self:GetForward())
	self:SetShootPos(self:GetPos())
	self:SetAmmoCount(self.ClipSize)

	local attacker = self:GetAttacker()
	local inflictor = self:GetInflictor()

	if IsValid(inflictor) and inflictor.IsTFAWeapon then
		self.NumShots = inflictor.Primary.NumShots
		self:SetModel(inflictor.WorldModel)
		self:SetRPM(math.Clamp(inflictor.Primary.RPM, self.RPM, 1200))
		self:SetClip1(math.Clamp(inflictor.Primary.ClipSize, self.ClipSize, 100))
		self:SetAmmoCount(self:GetClip1())
		self:SetShootPos(inflictor.GetMuzzlePos and inflictor:GetMuzzlePos().Pos or inflictor:GetPos())
		self:SetSilenced(inflictor.GetSilenced and inflictor:GetSilenced() or false)
	end

	ParticleEffectAttach("bo3_aat_fireworks", PATTACH_ABSORIGIN, self, 0)

	self:DrawShadow(true)
	self:SetNoDraw(true)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self.TargetsToIgnore = {}
	self.Ratio = engine.TickInterval()*5
	self.FinalPos = self:GetPos() + Vector(0,0,36)
	self.ActivateTime = CurTime() + 0.5
	self.WhistleDelay = CurTime()
	self.ExplodeDelay = CurTime()

	if CLIENT then return end

	local tickrate = 1 / engine.TickInterval()
	local time = (tickrate / self:GetRPM()) * self:GetClip1()
	SafeRemoveEntityDelayed(self, time + 0.5)

	if IsValid(attacker) and IsValid(inflictor) and inflictor.IsTFAWeapon and not inflictor.NZSpecialCategory then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = nzCurves.GenerateHealthCurve(round)

		local weapon = ents.Create(inflictor:GetClass())
		self:SetActiveWeapon(weapon)
		weapon.NZIgnorePickup = true

		weapon.NZMaxAmmo = function()
		end

		weapon:Spawn()

		/*if attacker.HasUpgrade and attacker:HasUpgrade("pop") and weapon.OnPaP and not weapon.NZPaPReplacement then
			weapon:ApplyNZModifier("pap")
		end*/

		weapon.StatCache_Blacklist["PumpAction"] = true
		weapon.StatCache_Blacklist["Primary.Damage"] = true
		weapon.StatCache_Blacklist["Primary.RPM"] = true
		weapon.StatCache_Blacklist["Primary.ClipSize"] = true
		weapon.StatCache_Blacklist["Primary.NumShots"] = true

		weapon.PumpAction = nil
		weapon.TracerCount = 1
		weapon.FiresUnderwater = true
		weapon.Primary_TFA.Damage = health + 666
		weapon.Primary_TFA.RPM = self:GetRPM()
		weapon.Primary_TFA.ClipSize = self:GetClip1()
		weapon.Primary_TFA.NumShots = self.NumShots

		weapon:SetClip1(weapon.Primary_TFA.ClipSize)
		if weapon.GetSilenced then
			weapon:SetSilenced(self:GetSilenced())
		end
		weapon.Silenced = self:GetSilenced()

		weapon:SetMoveType(MOVETYPE_NONE)
		weapon:SetOwner(self)
		weapon:SetParent(self)
		weapon:AddEffects(EF_BONEMERGE)

		local oldbullet = weapon.CustomBulletCallback
		weapon.CustomBulletCallback = function(ply, trace, dmginfo)
			local ent = trace.Entity
			if IsValid(ent) and ent:IsValidZombie() then
				local gun = dmginfo:GetAttacker()
				local headpos = ent:EyePos()
				local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = ent:LookupBone("j_head") end
				if headbone then headpos = ent:GetBonePosition(headbone) end

				dmginfo:SetDamage(ent:Health() + 666)
				if ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss") then
					dmginfo:SetDamage(ent:GetMaxHealth() / gun.ClipSize)
				end

				dmginfo:SetDamagePosition(headpos)
				dmginfo:SetDamageForce(gun:GetForward()*50000)
				dmginfo:SetDamageType(DMG_MISSILEDEFENSE)
			end

			dmginfo:SetAttacker(attacker)
			dmginfo:SetInflictor(inflictor)
			if oldbullet then
				oldbullet(ply, trace, dmginfo)
			end
		end

		local oldpre = weapon.PreSpawnProjectile
		if oldpre then
			weapon.PreSpawnProjectile = function(self, ent)
				oldpre(self, ent)
				ent:SetOwner(attacker)
				ent.Inflictor = inflictor

				if ent.SetAttacker then
					ent:SetAttacker(attacker)
				end
				if ent.SetInflictor then
					ent:SetInflictor(inflictor)
				end
			end
		end

		local oldpost = weapon.PostSpawnProjectile
		if oldpost then
			weapon.PostSpawnProjectile = function(self, ent)
				oldpost(self, ent)
				ent:SetOwner(attacker)
				ent.Inflictor = inflictor

				if ent.SetAttacker then
					ent:SetAttacker(attacker)
				end
				if ent.SetInflictor then
					ent:SetInflictor(inflictor)
				end
			end
		end

		hook.Add("PlayerCanPickupWeapon", "fireworks_gun"..self:EntIndex(), function(ply, wep)
			if not IsValid(ply) or not IsValid(self:GetActiveWeapon()) then return end
			if wep == self:GetActiveWeapon() then return false end
		end)
	end
end

function ENT:Think()
	local gun = self:GetInflictor()
	local weapon = self:GetActiveWeapon()

	if CLIENT then
		if IsValid(weapon) and IsValid(gun) and gun.TPaPOverrideMat and weapon:HasNZModifier("pap") then
			for k, v in pairs(gun.TPaPOverrideMat) do
				if weapon:GetSubMaterial(k) == "" then
					weapon:SetSubMaterial(k, gun.nzPaPCamo)
				end
			end

			if weapon.WElements and gun.WPaPOverrideMat then
				for _, element in pairs(weapon.WElements) do
					local model = element.curmodel
					if IsValid(model) and gun.WPaPOverrideMat[model] then
						for k, v in pairs(gun.WPaPOverrideMat[model]) do
							if model:GetSubMaterial(k) == "" then
								model:SetSubMaterial(k, gun.nzPaPCamo)
							end
						end
					end
				end
			end
		end
	end

	if SERVER then
		if self:GetPos() ~= self.FinalPos then
			self:SetPos(LerpVector(self.Ratio, self:GetPos(), self.FinalPos))
		end

		if self.WhistleDelay < CurTime() then
			self:EmitSound("NZ.POP.Fireworks.Whistle")
			self.WhistleDelay = CurTime() + math.Rand(0.4,0.8)
		end

		if self.ExplodeDelay < CurTime() then
			self:EmitSound("NZ.POP.Fireworks.Expl")
			self.ExplodeDelay = CurTime() + math.Rand(0.4,0.8)
		end

		if self:GetActivated() and IsValid(weapon) then
			if weapon:GetNextPrimaryFire() < CurTime() and weapon:CanPrimaryAttack() then
				self:FakePrimaryAttack()
			end
			if weapon:GetNextSecondaryFire() < CurTime() and weapon:CanSecondaryAttack() then
				if weapon.data then
					local ads = weapon.data.ironsights
					if ads and ads < 1 then
						weapon:SecondaryAttack()
					end
				else
					weapon:SecondaryAttack()
				end
			end
		end

		if self.ActivateTime < CurTime() and not self:GetActivated() then
			self:SetActivated(true)
		end

		if self.Kills >= self.MaxKills then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FakePrimaryAttack()
	local wep = self:GetActiveWeapon()
	if not IsValid(wep) then return end

	local shootpos = wep.GetMuzzlePos and wep:GetMuzzlePos().Pos
	if not shootpos or not isvector(shootpos) or shootpos == vector_origin then
		shootpos = wep:GetPos()
	end

	self:SetShootPos(shootpos)
	self:SetAimVector(self:GetForward())

	for k, v in pairs(ents.FindInSphere(shootpos, self.Range)) do
		if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
			if self.Kills >= self.MaxKills then break end
			if v.NZBossType or v.IsMooBossZombie then continue end
			if string.find(v:GetClass(), "nz_zombie_boss") then continue end
			if v.Alive and not v:Alive() then continue end
			if table.HasValue(self.TargetsToIgnore, v) then continue end

			self:InflictDamage(v)
			self.TargetsToIgnore[self.Kills] = v
			self.Kills = self.Kills + 1
			break
		end
	end

	//i literally have no idea why this works
	wep:PrimaryAttack()
	/*if wep:HasNZModifier("pap") and not (wep.Primary.Projectile or wep.IsMelee or wep.IsKnife) then
		local papsound = tostring(nzSounds.Sounds.Custom.UpgradedShoot[math.random(#nzSounds.Sounds.Custom.UpgradedShoot)])
		wep:EmitSound(papsound, SNDLVL_TALKING, math.random(90,110), 1, CHAN_STATIC)
	end*/

	self:SetClip1(self:GetClip1() - wep.Primary_TFA.AmmoConsumption)
	self:SetAngles(Angle(math.random(-90,90),math.random(-90,90),math.random(-90,90)))
end

function ENT:InflictDamage(ent)
	local attacker = self:GetAttacker()
	local inflictor = self:GetInflictor()

	local headpos = ent:EyePos()
	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone then headpos = ent:GetBonePosition(headbone) end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(IsValid(attacker) and attacker or self)
	damage:SetInflictor(IsValid(inflictor) and inflictor or self)
	damage:SetDamageForce(self:GetForward()*50000)
	damage:SetDamagePosition(headpos)
	damage:SetDamage(ent:Health() + 666)

	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopParticles()
	if CLIENT then return end

	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		wep:Remove()
		hook.Remove("PlayerCanPickupWeapon", "fireworks_gun"..self:EntIndex())
	end
end
