local PLAYER = FindMetaTable("Player")

if PLAYER then
	function PLAYER:GetShield()
		return self:GetNW2Entity("nZ.ShieldEnt")
	end

	function PLAYER:SetShield(ent)
		return self:SetNW2Entity("nZ.ShieldEnt", ent)
	end
end

-- Tortoise upgrade and Explosion
hook.Add("OnEntityCreated", "nz.Perk.Tortoise_Upgrade", function(ent)
	timer.Simple(engine.TickInterval(), function() //1 tick delay to get owner info
		if not IsValid(ent) then return end
		local ply = ent:GetOwner()
		if not IsValid(ply) or not ply:IsPlayer() then return end

		if ply:HasPerk("tortoise") and IsValid(ply:GetShield()) and ent == ply:GetShield() then
			ent:CallOnRemove("nz.Perk.Tortoise_Exp", function(ent)
				if ent:Health() > 0 then return end

				if SERVER then
					local damage = DamageInfo()
					damage:SetDamage(54000)
					damage:SetAttacker(IsValid(ply) and ply or ent)
					damage:SetInflictor(IsValid(ply:GetShield().Weapon) and ply:GetShield().Weapon or ent)
					damage:SetDamageType(DMG_BLAST_SURFACE)

					for k, v in pairs(ents.FindInSphere(ply:GetPos(), 512)) do
						if v:IsValidZombie() then
							damage:SetDamageForce(v:GetUp()*8000 + (v:GetPos() - ent:GetPos()):GetNormalized()*10000)
							v:TakeDamageInfo(damage)
						end
					end

					util.ScreenShake(ply:GetPos(), 10, 255, 1.5, 600)
				end

				ParticleEffect("grenade_explosion_01", ply:WorldSpaceCenter(), Angle(0,0,0))

				ply:EmitSound("Perk.Tortoise.Exp")
				ply:EmitSound("Perk.Tortoise.Exp_Firey")
				ply:EmitSound("Perk.Tortoise.Exp_Decay")
			end)
		end
	end)
end)

if SERVER then
	-- Basic shield functionality
	hook.Add("PlayerShouldTakeDamage", "nzShieldBlock", function(ply, ent)
		if ent:IsValidZombie() and IsValid(ply:GetShield()) and IsValid(ply:GetShield():GetWeapon()) then
			local dot = (ent:GetPos() - ply:GetPos()):Dot(ply:GetAimVector())
			local wep = ply:GetActiveWeapon()

			local shield = IsValid(wep) and wep == ply:GetShield():GetWeapon()

			if ply:HasPerk("tortoise") and shield then
				ply:GetShield():TakeDamage(30, ent, ent)
				return false
			end

			if (dot < 0 and not shield) or (dot >= 0 and shield) then
				ply:GetShield():TakeDamage(30, ent, ent)

				if ply:HasUpgrade("tortoise") and math.Rand(100) <= 25 then
					ent:PerformStun(math.Rand(1.25, 3.7))
				end
				return false
			end
		end
	end)
end