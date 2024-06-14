ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Scorpion Projectile"
ENT.Author = "GhostlyMoo"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/dav0r/hoverball.mdl")
		self:SetNoDraw(true)
		ParticleEffectAttach("acidbug_spit_trail",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self:PhysicsInit(SOLID_OBB)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)
		self:SetMoveType(MOVETYPE_FLY)

		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 1750)
	self:SetAngles((dir*-1):Angle())
end

function ENT:StartTouch(ent)
	if !ent:IsWorld() and (!ent:IsPlayer() or ent.IsMooZombie) then return end

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        self:CreateBombAOE(pos)

        for k, v in pairs(ents.FindInSphere(pos, 50)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_POISON)

            local distfac = pos:Distance(v:WorldSpaceCenter())
            distfac = 1 - math.Clamp((distfac/50), 0, 1)

            expdamage:SetAttacker(self)
            expdamage:SetDamage(50 * distfac)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
				v:NZSonicBlind(0.75)
            end
        end

		if IsValid(self) then ParticleEffectAttach("hcea_flood_runner_death", 3, self, 2) end
		self:EmitSound("nz_moo/zombies/vox/_aliens/spitter/spitter_batch3_goop_projectile_"..math.random(1,2)..".mp3")
        util.ScreenShake(self:GetPos(), 20, 255, 0.5, 100)

		self:Remove()
	end
end

function ENT:CreateBombAOE(pos)
	if !IsValid(pos) then end
	if self.Exploded then return end
	self.Exploded = true -- Prevent a possible infinite loop that causes crashes.
	--print("Stinky Child... Gross")
	local fuckercloud = ents.Create("nova_gas_cloud")
	fuckercloud:SetPos(pos)
	fuckercloud:SetAngles(Angle(0,0,0))
	fuckercloud:Spawn()
end

function ENT:Think()
end

function ENT:OnRemove()
end
