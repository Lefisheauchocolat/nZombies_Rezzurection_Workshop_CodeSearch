AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Atomwaffe Charge"
ENT.HasTrail = true

--[Sounds]--
ENT.PropelSound = "TFA_BO3_WAFFE.Loop"

--[Parameters]--
ENT.Delay = 10
ENT.ArcDelay = 0.2
ENT.MaxChain = 5
ENT.ZapRange = 100
ENT.ShockTime = 0.5
ENT.ShockDamage = 250

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")
local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Int", 0, "Kills")
end

function ENT:Initialize(...)
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel(self.DefaultModel)
	end

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetNotSolid(true)
	self:EmitSound(self.PropelSound)

	self.killtime = CurTime() + self.Delay
	self.TargetsToIgnore = {}

	ParticleEffectAttach("bo3_cng_trail", PATTACH_POINT_FOLLOW, self, 1)

	self:NextThink(CurTime())

	if CLIENT then return end
	self:StartHunting()
end

function ENT:Think(...)
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 215
			dlight.g = 230
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 128
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.NextPrimaryFire and self.NextPrimaryFire < CurTime() then
			local target = self:GetTarget()
			if (not IsValid(target) or target:Health() <= 0) then
				self:SetTarget(self:FindNearestEntity(self.StartPos, self.TargetsToIgnore))

				if not IsValid(self:GetTarget()) then
					self:StopParticles()
					self:StopSound(self.PropelSound)
					self:Remove()
					return false
				end
			end

			if (IsValid(target) and target:Health() > 0) then
				local finalpos = target:WorldSpaceCenter()
				local bone = (target:LookupBone("j_spineupper") or target:LookupBone("j_spinelower")) or (target:LookupBone("ValveBiped.Bip01_Spine2") or target:LookupBone("ValveBiped.Bip01_Pelvis"))
				if !bone then
					for i = 0, target:GetHitBoxCount(0) do
						if target:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
							bone = target:GetHitBoxBone(i, 0)
							break
						end
					end
				end

				if bone then
					local pos = target:GetBonePosition(bone)
					if pos == target:GetPos() then
						pos = target:GetBoneMatrix(bone):GetTranslation()
					end

					if pos and pos ~= vector_origin then
						finalpos = pos
					end
				end

				local dist = self:GetPos():Distance(finalpos)
				local norm = (finalpos - self:GetPos()):GetNormalized()
				self:SetPos(self:GetPos() + norm*math.min(24, dist))

				if dist <= 12 then
					self:Zap(self:GetTarget(), finalpos)
				end
			end
		end

		if self.killtime < CurTime() then
			self:StopSound(self.PropelSound)
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:StartHunting()
	self.StartPos = self:GetPos()

	local ent = self:GetTarget()
	if IsValid(ent) then
		local finalpos = ent:WorldSpaceCenter()
		local bone = (ent:LookupBone("j_spineupper") or ent:LookupBone("j_spinelower")) or (ent:LookupBone("ValveBiped.Bip01_Spine2") or ent:LookupBone("ValveBiped.Bip01_Pelvis"))
		if !bone then
			for i = 0, ent:GetHitBoxCount(0) do
				if ent:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
					bone = ent:GetHitBoxBone(i, 0)
					break
				end
			end
		end

		if bone then
			local pos = ent:GetBonePosition(bone)
			if pos == ent:GetPos() then
				pos = ent:GetBoneMatrix(bone):GetTranslation()
			end

			if pos and pos ~= vector_origin then
				finalpos = pos
			end
		end

		self:Zap(ent, finalpos)
	end

	self:SetKills(0)
end

function ENT:Zap(ent, finalpos)
	finalpos = finalpos or ent:EyePos()

	ent:EmitSound("TFA_BO3_WAFFE.Bounce")

	self.LastAttackPos = finalpos

	local damage = DamageInfo()
	damage:SetDamage(self.ShockDamage)
	damage:SetDamageType(DMG_SHOCK)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(finalpos)

	if damage:GetDamage() >= ent:Health() and ent:IsNPC() then
		ent:SetSchedule(SCHED_ALERT_STAND)
	end

	ent.NukeGunShocked = true
	ent:TakeDamageInfo(damage)
	ent:Extinguish()
	ent.NukeGunShocked = nil

	self.TargetsToIgnore[self:GetKills()] = ent
	self.NextPrimaryFire = CurTime() + self.ArcDelay
	self:SetKills(self:GetKills() + 1)

	if self.Decay then
		self.ZapRange = self.ZapRange - (self.Decay * 1)
	end

	if self:GetKills() >= self.MaxChain then
		self:Remove()
		return
	end
end

function ENT:FindNearestEntity(pos, tab)
	local nearbyents = {}
	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.ZapRange)) do
		if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if !v:VisibleVec(pos) then continue end

			if !table.HasValue(tab, v) then
				table.insert(nearbyents, v)
			end
		end
	end

	table.sort(nearbyents, function(a, b) return tobool(a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos)) end)
	return nearbyents[1]
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_WAFFE.Loop")
	self:StopSound(self.PropelSound)
end
