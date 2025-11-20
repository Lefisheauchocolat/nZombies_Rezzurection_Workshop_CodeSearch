ENT.Type = "anim"
ENT.PrintName = "Spike"
ENT.Author = "TFA"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.glitchthreshold = 6 --threshold distance from bone to reset pos
ENT.glitchthresholds = {}
ENT.glitchthresholds["ValveBiped.Bip01_Head1"] = 8
ENT.glitchthresholds["ValveBiped.Bip01_Head"] = 8
ENT.glitchthresholds["ValveBiped.Bip01_R_Hand"] = 1
ENT.glitchthresholds["ValveBiped.Bip01_L_Hand"] = 1
ENT.glitchthresholds["ValveBiped.Bip01_Spine2"] = 24

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "BoneTarget")
end

local function GetBoneCenter(ent, bone)
	local bonechildren = ent:GetChildBones(bone)

	if #bonechildren <= 0 then
		return ent:GetBonePosition(bone)
	else
		local bonepos = ent:GetBonePosition(bone)
		local tmppos = bonepos

		if tmppos then
			for i = 1, #bonechildren do
				local childpos = ent:GetBonePosition(bonechildren[i])

				if childpos then
					tmppos = (tmppos + childpos) / 2
				end
			end
		else
			return ent:GetPos()
		end

		return tmppos
	end
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)

	local p = self:GetOwner()
	if IsValid(p) and not p:IsPlayer() then
		if not p.SpikemoreSpikes then p.SpikemoreSpikes = {} end
		table.insert(p.SpikemoreSpikes, self)
	end

	self:TargetEnt(true)

	if CLIENT then return end
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(2)
		phys:EnableGravity(false)
		phys:EnableCollisions(false)
	end

	SafeRemoveEntityDelayed(self, math.Rand(10,12))
end

function ENT:TargetEnt( init )
	local ent = self:GetOwner()
	if not IsValid(ent) then return end

	if init then
		local bone, bonepos, bonerot
		bone = ent:TranslatePhysBoneToBone(self:GetBoneTarget())
		self.targbone = bone

		if not ent:GetBoneCount() or ent:GetBoneCount() <= 1 or string.find(ent:GetModel(), "door") then
			bonepos = ent:GetPos()
			bonerot = ent:GetAngles()
			self.enthasbones = false
		else
			if ent.SetupBones then
				ent:SetupBones()
			end

			bonepos, bonerot = ent:GetBonePosition(bone)
			self.enthasbones = true
		end

		if self.enthasbones then
			local gpos = self:GetPos()
			local bonepos2 = GetBoneCenter(ent, bone)
			local tmpgts = self.glitchthresholds[ent:LookupBone(bone)] or self.glitchthreshold

			while gpos:Distance(bonepos2) > tmpgts do
				self:SetPos((gpos + bonepos2) / 2)
				gpos = (gpos + bonepos2) / 2
			end
		end

		if not bonepos then
			bonepos = ent:GetPos()
			bonerot = ent:GetAngles()
		end

		self.posoff, self.angoff = WorldToLocal(self:GetPos(), self:GetAngles(), bonepos, bonerot)
	end

	self:FollowBone( ent, (self.targbone and self.targbone >= 0) and self.targbone or 0 )
	self:SetOwner( ent )
	self:SetLocalPos( self.posoff )
	self:SetLocalAngles( self.angoff )

	self.HTE = true
end

function ENT:Think()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply:Health() <= 0 then
			if ply.GetRagdollEntity then
				local rag = ply:GetRagdollEntity()
				if IsValid(rag) then
					self:SetOwner(rag)
					self:TargetEnt(false)
				end
			else
				SafeRemoveEntityDelayed(self, engine.TickInterval()*2)
				return false
			end
		end

		if not self.HTE then
			self:TargetEnt( true )
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	local p = self:GetOwner()
	if IsValid(p) and not p:IsPlayer() and p.SpikemoreSpikes and table.HasValue(p.SpikemoreSpikes, self) then
		table.RemoveByValue(p.SpikemoreSpikes, self)
	end
end
