AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:Think()
	if not nzPowerUps:IsPowerupActive("security") then
		self:Remove()
		return false
	end

	local p = self:GetParent()
	if not IsValid(p) then
		self:Remove()
		return false
	end

	local mins, maxs = p:GetCollisionBounds()
	for _, ent in pairs(ents.FindInBox(p:LocalToWorld(mins) + self:GetForward()*16, p:LocalToWorld(maxs) - self:GetForward()*48)) do
		if ent:IsValidZombie() and ent:Alive() and !ent.MarkedBySecurity and (ent.Barricade and !ent.Big_Jump_area_start) then
			local barricade = ent.Barricade
			if IsValid(barricade) and barricade:GetTriggerJumps() and ent.TriggerBarricadeJump then
				if !ent:GetSpecialAnimation() or !ent:GetIsBusy() then
					continue //if cade has jump bool, only mark zombies actively vaulting thru cade
				end
			end

			ent.MarkedBySecurity = CurTime()
			ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
			self:EmitSound("nz_moo/powerups/security/energy_shield_hit_0"..math.random(0,5)..".wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
			ParticleEffectAttach("bo1_molotov_zomb", PATTACH_ABSORIGIN_FOLLOW, ent, 0)

			local ourname = "security_lazytimer"..ent:EntIndex()
			timer.Create(ourname, engine.TickInterval(), 0, function()
				if not IsValid(ent) or not ent:Alive() then 
					if timer.Exists(ourname) then
						timer.Remove(ourname)
					end
					return
				end
				if ent.MarkedBySecurity + 2 > CurTime() then return end
				if ent:GetSpecialAnimation() then return end

				local damage = DamageInfo()
				damage:SetAttacker(Entity(0))
				damage:SetInflictor(IsValid(self) and self or Entity(0))
				damage:SetDamage(ent:Health() + 666)
				damage:SetDamageType(DMG_BURN)
				damage:SetDamagePosition(ent:EyePos())

				if IsValid(self) then
					damage:SetReportedPosition(self:WorldSpaceCenter())
					damage:SetDamageForce((ent:GetPos() - self:GetPos()):GetNormalized())
				end

				ent:StopParticles()

				if ent.IsMooBossZombie or ent.IsMooMiniBoss then
					damage:SetDamage(math.max(1000, ent:GetMaxHealth()/3))

					ent:TakeDamageInfo(damage)
				else
					ent:SetHealth(1)
					ent:EmitSound("TFA_BO3_GENERIC.Gib")
					ent:GibHead()

					ent:TakeDamageInfo(damage)
				end

				timer.Simple(0, function()
					if not IsValid(ent) then return end
					ParticleEffectAttach("bo1_icelazer_pop", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
				end)

				if timer.Exists(ourname) then
					timer.Remove(ourname)
				end
			end)
		end
	end

	self:NextThink(CurTime())
	return true
end