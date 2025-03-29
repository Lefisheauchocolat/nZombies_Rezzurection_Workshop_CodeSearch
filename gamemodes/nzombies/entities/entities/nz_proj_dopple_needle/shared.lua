
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Dopple Ghast Needle"
ENT.Author = "GhostlyMoo"

ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:Initialize()
	self:SetModel("models/moo/_codz_ports_props/t10/t10_zm_needle_cluster/moo_codz_t10_zm_needle_cluster.mdl")
	self:SetModelScale(2, 0.000001)

	if SERVER then
		self:PhysicsInit(SOLID_OBB)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)
		self:SetMoveType(MOVETYPE_FLY)

		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end

		util.SpriteTrail(self, 9, Color(255, 0, 5, 255), true, 15, 5, 0.75, 1 / 40 * 0.3, "materials/trails/plasma")
	end
end

function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 1750)
	self:SetAngles((dir*-1):Angle())
end

function ENT:StartTouch(ent)
	if !ent:IsWorld() and (ent.IsMooZombie) then return end

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 100)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_POISON)

            local distfac = pos:Distance(v:WorldSpaceCenter())
            distfac = 1 - math.Clamp((distfac/50), 0, 1)

            expdamage:SetAttacker(self)
            expdamage:SetDamage(50 * distfac)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
				v:NZSonicBlind(1)
            end
        end

		self:Remove()
	end
end

function ENT:Think() end

function ENT:OnRemove() end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end