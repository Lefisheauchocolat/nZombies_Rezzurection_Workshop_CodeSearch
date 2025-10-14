local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

SWEP.Base = "tfa_melee_base"
SWEP.StatCache_Blacklist = {
	["Bodygroups_V"] = true,
	["Bodygroups_W"] = true,
}
SWEP.ElectricHitsMax = nzombies and 12 or 6
SWEP.ElectricHitDamage = 15

DEFINE_BASECLASS(SWEP.Base)

function SWEP:SwitchToPreviousWeapon()
	local wep = LocalPlayer():GetPreviousWeapon()

	if IsValid(wep) and wep:IsWeapon() and wep:GetOwner() == LocalPlayer() then
		input.SelectWeapon(wep)
	else
		wep = LocalPlayer():GetWeapon(cl_defaultweapon:GetString())

		if IsValid(wep) then
			input.SelectWeapon(wep)
		else
			local _
			_, wep = next(LocalPlayer():GetWeapons())

			if IsValid(wep) then
				input.SelectWeapon(wep)
			end
		end
	end
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Int", "DamagedVariant")
	self:NetworkVarTFA("Int", "ElectricHits")
	self:NetworkVarTFA("Bool", "Electrified")
end

function SWEP:DrawWorldModel(...)
	if self:GetElectrified() then
		local ply = self:GetOwner()
		if ply.GetShield then
			local shield = ply:GetShield()
			if shield.CL_3PDrawFX and shield.CL_3PDrawFX:IsValid() then
				shield.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
			end
		end

		if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX = CreateParticleSystem(self, "bo3_shield_electrify", PATTACH_ABSORIGIN_FOLLOW, 0)
		end
	elseif self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
		self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
	end

	return BaseClass.DrawWorldModel(self, ...)
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self:GetElectrified() then
		if !self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid() then
			self.CL_FPDrawFX = CreateParticleSystem(vm, "bo3_shield_electrify", PATTACH_ABSORIGIN_FOLLOW, 0)
		end
	elseif self.CL_FPDrawFX and self.CL_FPDrawFX:IsValid() then
		self.CL_FPDrawFX:StopEmissionAndDestroyImmediately()
	end

	return BaseClass.PreDrawViewModel(self, vm, wep, ply)
end

function SWEP:CreateBackShield(ply)
	ply:SetShield(ents.Create("cod_backshield"))

	self.Shield = ply:GetShield()
	self.Shield:SetModel(self.ShieldModel)
	self.Shield:SetOwner(ply)
	self.Shield:SetWeapon(self)
	self.Shield:Spawn()
	self.Shield:SetOwner(ply)
end

function SWEP:CallWeaponSwap()
	if nzombies then
		self:GetOwner():SetUsingSpecialWeapon(false)
		self:GetOwner():EquipPreviousWeapon()
		return
	end

	if CLIENT and not sp then
		self:SwitchToPreviousWeapon()
	elseif SERVER then
		self:CallOnClient("SwitchToPreviousWeapon", "")
	end
end

function SWEP:SetDamage(value)
	if self:GetDamagedVariant() == value then return end

	self:SetDamagedVariant(value)
	if value > self:GetDamagedVariant() then
		self:EmitSound(self.ShieldHitSound or "TFA_BO3_SHIELD.Hit")
	end
	if value == 0 then
		self:SetClip1(self.Primary_TFA.ClipSize)
	end
end

function SWEP:ApplyDamage(trace, dmginfo, attk)
	local ply = self:GetOwner()
	local ent = trace.Entity
	if not IsValid(ent) then return end

	local dam, force = dmginfo:GetBaseDamage(), dmginfo:GetDamageForce()
	dmginfo:SetDamagePosition(trace.HitPos)
	dmginfo:SetReportedPosition(trace.StartPos)
	dmginfo:SetDamageForce(ply:GetAimVector()*20000 + ent:GetUp()*15000)

	if nzombies then
		dam = math.huge
		if ent.NZBossType or ent.IsMooBossZombie or ent.IsMiniBoss or string.find(ent:GetClass(), "nz_zombie_boss") then
			dam = ent:GetMaxHealth() / 14
		end

		dmginfo:SetDamage(dam)

		if SERVER then
			ply:GetShield():TakeDamage(math.random(5)*5, ent, ent)
		end
	end

	if self:GetElectrified() then
		dmginfo:SetDamageType(DMG_SHOCK)

		ent:EmitSound("weapons/physcannon/superphys_small_zap"..math.random(4)..".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
		util.ParticleTracerEx("bo3_waffe_jump", trace.StartPos, trace.HitPos, false, ply:EntIndex(), 0)

		if nzombies and ent:IsValidZombie() then
			dmginfo:SetDamageForce(vector_up)
			ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
			ParticleEffectAttach("bo3_shield_electrify_zomb", PATTACH_ABSORIGIN_FOLLOW, ent, 2)
		end
	end

	ent:DispatchTraceAttack(dmginfo, trace, ply:GetAimVector())

	dmginfo:SetDamage(dam)
	dmginfo:SetDamageForce(force)

	self:ApplyForce(ent, dmginfo:GetDamageForce(), trace.HitPos)

	if self:GetElectrified() then
		self:SetElectricHits(self:GetElectricHits() + 1)
		if self:GetElectricHits() >= self.ElectricHitsMax then
			self:DeElectrify()
		end
	end
end

function SWEP:Think2()
	local ply = self:GetOwner()
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if !self.ShieldNoDamagedSkin and self.Bodygroups_V[0] ~= self:GetDamagedVariant() then
		self.Bodygroups_V = {[0] = self:GetDamagedVariant()}
		self.Bodygroups_W = {[0] = self:GetDamagedVariant()}
	end

	if stat == TFA.Enum.STATUS_HOLSTER and statusend then
		if SERVER then
			if IsValid(ply) and IsValid(self.Shield) then
				ply:GetShield():SetNoDraw(false)
			else
				if IsValid(ply:GetShield()) then
					self:Remove()
				end
			end
		end
	end

	return BaseClass.Think2(self)
end

function SWEP:Equip(ply)
	if ply:IsPlayer() and not IsValid(ply:GetShield()) then
		self:CreateBackShield(ply)
	end

	return BaseClass.Equip(self, ply)
end

function SWEP:Deploy(...)
	local ply = self:GetOwner()
	if SERVER then
		if IsValid(ply) and IsValid(ply:GetShield()) then
			ply:GetShield():SetNoDraw(true)
		else
			if IsValid(ply:GetShield()) then
				self:Remove()
			end
		end
	end

	return BaseClass.Deploy(self, ...)
end

function SWEP:OnRemove(...)
	if SERVER then
		if IsValid(self.Shield) then
			self:DeElectrify(true)
			self.Shield:Remove()
		end
	end

	return BaseClass.OnRemove(self, ...)
end

function SWEP:OnDrop(...)
	if SERVER then
		if IsValid(self.Shield) then
			self.Shield:Remove()
		end
	end

	return BaseClass.OnDrop(self, ...)
end

function SWEP:OwnerChanged(...)
	if SERVER then
		if IsValid(self.Shield) then
			self.Shield:Remove()
		end
	end

	return BaseClass.OwnerChanged(self, ...)
end

//Electric shield shit
function SWEP:ShockBlock(ply, ent, dmginfo)
	if CLIENT then return end
	if not IsValid(ply) or not IsValid(ent) then return end
	if not dmginfo then return end

	if ent.WasShockedThisTick then return end //shitty protection against inf loops
	if nzombies and !ent:IsValidZombie() then return end

	local hurtpos = dmginfo:GetReportedPosition()
	if hurtpos == vector_origin then
		hurtpos = ent:IsPlayer() and ent:GetShootPos() or ent:EyePos()
	end

	local shockdmg = DamageInfo()
	shockdmg:SetDamage(self.ElectricHitDamage or 15)
	shockdmg:SetAttacker(ply)
	shockdmg:SetInflictor(self)
	shockdmg:SetDamageType(DMG_SHOCK)
	shockdmg:SetDamagePosition(hurtpos)
	shockdmg:SetReportedPosition(ply:GetShootPos())
	shockdmg:SetDamageForce(dmginfo:GetDamageForce()*-1.5)

	if nzombies and (ent:Health() - shockdmg:GetDamage()) > 0 then
		if ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss") then
			shockdmg:SetDamage(math.max(200, ent:GetMaxHealth() / 18))
		elseif ent.TempBehaveThread and ent.SparkySequences then
			ParticleEffectAttach("bo3_shield_electrify_zomb", PATTACH_ABSORIGIN_FOLLOW, ent, 2)
			if ent.PlaySound and ent.ElecSounds then
				ent:PlaySound(ent.ElecSounds[math.random(#ent.ElecSounds)], ent.SoundVolume or SNDLVL_NORM, math.random(ent.MinSoundPitch or 97, ent.MaxSoundPitch or 103), 1, 2)
			end

			ent:TempBehaveThread(function(ent)
				local seq = ent.SparkySequences[math.random(#ent.SparkySequences)]
				local id, time = ent:LookupSequence(seq)
				ent:PlaySequenceAndWait(seq)
				ent:StopParticles()
			end)
		end
	end

	ent.WasShockedThisTick = true
	ent:EmitSound("weapons/physcannon/superphys_small_zap"..math.random(4)..".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
	util.ParticleTracerEx("bo3_waffe_jump", ply:GetShootPos(), hurtpos, false, ply:EntIndex(), 0)

	ent:TakeDamageInfo(shockdmg)

	timer.Simple(0, function()
		if not IsValid(ent) then return end
		ent.WasShockedThisTick = nil
	end)

	self:SetElectricHits(self:GetElectricHits() + 1)
	if self:GetElectricHits() >= (self.ElectricHitsMax or 6) then
		self:DeElectrify()
	end
end

function SWEP:Electrify(amount)
	if self:GetElectrified() then return end
	self:SetElectrified(true)
	self:SetElectricHits(amount or 0)
end

function SWEP:DeElectrify(nosound)
	if !self:GetElectrified() then return end
	self:SetElectrified(false)
	self:SetElectricHits(0)
	self:CleanParticles()

	if !nosound then
		self:EmitSound("weapons/tfa_bo2/etrap/electrap_stop.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
	end
end
