AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:PhysicsCollide(data, phys)
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Initialize()
	self:SetModel("models/zmb/bo2/tranzit/zm_work_bench.mdl")

	local buildtab = nzBuilds:GetBuildable(self:GetBuildable())

	if buildtab.weapon then
		self.WeaponClass = tostring(buildtab.weapon)
	end
	if buildtab.remove then
		self.RemoveOnUse = tobool(buildtab.remove)
	end
	if buildtab.boxweapon then
		self.BoxWeapon = tobool(buildtab.boxweapon)
	end
	if buildtab.model then
		self:CreateFakeModel()
	end
	if buildtab.model2 then
		self:CreateFakeModel2()
	end
	if buildtab.notable or self.HideTableModel then
		if not self.HideTableModel then
			self.HideTableModel = true
		end
		self:SetModel(tostring(buildtab.model))
		self:SetMaterial("null")
	end
	if buildtab.requiredtable then
		self.RequiredTable = tostring(buildtab.requiredtable)
	end

	if self.ClassicSounds then
		self.BuildLoopSound = "NZ.BO2.Buildable.Craft.Loop"
		self.BuildEndSound = "NZ.BO2.Buildable.Craft.Finish"
		self.BuildDenySound = "NZ.BO2.Buildable.Deny"
		self.BuildPickupSound = "NZ.BO2.Buildable.PickUp"
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)

	self:SetUsed(false)
	self:SetCompleted(false)
	self:SetBrutusLocked(false)
	self:SetTargetPriority(TARGET_PRIORITY_MONSTERINTERACT)

	local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
	if buildtab.init then
		buildtab.init(self)
	end
end

function ENT:CreateFakeModel()
	if IsValid(self.CraftedModel) then return end

	local tbl = nzBuilds:GetBuildable(self:GetBuildable())
	local pos = tbl.pos or Vector(0,0,45)
	if tbl.model2 then
		pos = pos + self:GetRight()*5
	end

	self.CraftedModel = ents.Create("nz_buildholo")
	self.CraftedModel:SetParent(self)
	self.CraftedModel:SetModel(tbl.model)
	if self.HideTableModel then
		self.CraftedModel:SetPos(self:GetPos())
	else
		self.CraftedModel:SetPos(self:GetPos() + (self:GetRight()*pos[1]) + (self:GetForward()*pos[2]) + (self:GetUp()*pos[3]))
	end
	self.CraftedModel:SetAngles(self:GetAngles() + (tbl.ang or angle_zero))

	self.CraftedModel.RelayUse = self
	self.CraftedModel:Spawn()
end

function ENT:CreateFakeModel2()
	if IsValid(self.CraftedModel2) then return end

	local tbl = nzBuilds:GetBuildable(self:GetBuildable())
	if not tbl.model2 then return end

	local pos = (tbl.pos or Vector(0,0,45)) - self:GetRight()*5

	self.CraftedModel2 = ents.Create("nz_buildholo")
	self.CraftedModel2:SetParent(self)
	self.CraftedModel2:SetModel(tbl.model2)
	self.CraftedModel2:SetPos(self:GetPos() + (self:GetRight()*pos[1]) + (self:GetForward()*pos[2]) + (self:GetUp()*pos[3]))
	self.CraftedModel2:SetAngles(self:GetAngles() + (tbl.ang or angle_zero))
	self.CraftedModel.RelayUse = self

	self.CraftedModel2:Spawn()
end

function ENT:StartTimedUse(ply)
	if CLIENT then return end
	if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then
		local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
		local hasweapon = false
		if not buildtab.use and self.WeaponClass and weapons.Get(self.WeaponClass) and not ply:HasWeapon(self.WeaponClass) then
			ply:EmitSound(self.BuildPickupSound)
			ply:Give(self.WeaponClass)
			hasweapon = true
		end

		if hasweapon then return end
		if self.NextUse and self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 4.5

		if self.HideTableModel then
			timer.Simple(0, function()
				ParticleEffectAttach("nzr_building_model", PATTACH_ABSORIGIN_FOLLOW, self, 1)
			end)
		else
			timer.Simple(0, function()
				ParticleEffectAttach("nzr_building_loop", PATTACH_POINT_FOLLOW, self, 1)
			end)
		end

		timer.Simple(3, function()
			self:StopParticles()
			timer.Simple(0, function()
				if not IsValid(self) then return end
				self:StopParticles()
			end)

			self:StopSound(self.BuildLoopSound)
			if not self.ClassicSounds then
				self:StopSound("NZ.Buildable.Craft.LoopSweet")
			end

			self:EmitSound(self.BuildEndSound)
			if not self.ClassicSounds then
				self:EmitSound("NZ.Buildable.Craft.FinishSweet")
			end
		end)

		self:EmitSound(self.BuildLoopSound)
		if not self.ClassicSounds then
			self:EmitSound("NZ.Buildable.Craft.LoopSweet")
		end

		return
	end
	if not IsValid(ply) then return end
	if ply.NextUse and ply.NextUse > CurTime() then return end

	if self:GetNoDraw() then return end

	ply.NextUse = CurTime() + 0.45

	if self:GetBrutusLocked() then
		ply:Buy(2000, self, function() self:BrutusUnlock() return true end)
		return
	end

	if self:GetUsed() then self:EmitSound(self.BuildDenySound) return end
	if self:GetRemainingParts() > 0 then self:EmitSound(self.BuildDenySound) return end

	local buildtab = nzBuilds:GetBuildable(self:GetBuildable())

	if self:GetCompleted() then
		if buildtab.use then
			buildtab.use(self, ply)
			if self.RemoveOnUse then
				self:RemoveTable()
			end
		else
			self:Purchase(ply)
		end

		ply.NextUse = CurTime() + 0.45
	else
		if self.HideTableModel then
			timer.Simple(0, function()
				ParticleEffectAttach("nzr_building_model", PATTACH_ABSORIGIN_FOLLOW, self, 1)
			end)
		else
			timer.Simple(0, function()
				ParticleEffectAttach("nzr_building_loop", PATTACH_POINT_FOLLOW, self, 1)
			end)
		end

		self:EmitSound(self.BuildLoopSound)
		if not self.ClassicSounds then
			self:EmitSound("NZ.Buildable.Craft.LoopSweet")
		end
		ply:Give("tfa_paparms")

		return ply:HasPerk("time") and 1.5 or 3
	end
end

function ENT:StopTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	self:StopSound(self.BuildLoopSound)
	if not self.ClassicSounds then
		self:StopSound("NZ.Buildable.Craft.LoopSweet")
	end

	self:StopParticles()
	timer.Simple(0, function()
		self:StopParticles()
	end)

	ply:SetUsingSpecialWeapon(false)
	ply:EquipPreviousWeapon()
	ply:StripWeapon("tfa_paparms")
end

function ENT:FinishTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	self:StopSound(self.BuildLoopSound)
	if not self.ClassicSounds then
		self:StopSound("NZ.Buildable.Craft.LoopSweet")
	end

	self:StopParticles()
	timer.Simple(0, function()
		self:StopParticles()
	end)

	if not self:GetCompleted() then
		if IsValid(self.CraftedModel) then
			self.CraftedModel:Reset()
		end
		if IsValid(self.CraftedModel2) then
			self.CraftedModel2:Reset()
		end
		self:SetCompleted(true)
		self:EmitSound(self.BuildEndSound)
		if not self.ClassicSounds then
			self:EmitSound("NZ.Buildable.Craft.FinishSweet")
		end

		for k, v in pairs(ents.FindByClass("nz_buildable")) do
			if v:GetBuildable() == self:GetBuildable() and table.HasValue(nzBuilds.Parts, v) then
				nzBuilds:UpdateHeldParts(v)
			end
		end

		local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
		if buildtab.completed then
			buildtab.completed(self, ply)
		end

		hook.Call("PlayerCompletedBuildable", nil, ply, self)
	end
end

function ENT:Purchase(ply)
	if not self.WeaponClass then return end

	local price = self:GetPrice()
	if price > 0 then
		if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound) return end

		local wep = ply:GetWeapon(self.WeaponClass)
		if IsValid(wep) then
			if wep:Clip1() < wep.Primary.DefaultClip and ply:CanAfford(price*2) then
				wep:SetClip1(wep.Primary.DefaultClip)
				if wep.Secondary and wep.Secondary.ClipSize then
					wep:SetClip2(wep.Secondary.ClipSize)
				end

				if wep.ShieldEnabled and ply.GetShield and IsValid(ply:GetShield()) then
					ply:GetShield():SetHealth(ply:GetShield():GetMaxHealth())
					if IsValid(ply:GetShield():GetWeapon()) then
						ply:GetShield():GetWeapon():SetDamage(0)
					end
				end

				ply:TakePoints(math.Round(price * 2))

				hook.Call("PlayerBuyBuildable", nil, ply, self, wep)
			else
				self:EmitSound(self.BuildDenySound)
			end
		else
			local weptab = weapons.Get(self.WeaponClass)
			if weptab and weptab and weptab.ShieldEnabled and ply.GetShield and IsValid(ply:GetShield()) then
				self:EmitSound(self.BuildDenySound)
			return end

			ply:EmitSound(self.BuildPickupSound)
			local wep = ply:Give(self.WeaponClass)
			ply:TakePoints(price)
			if self.BoxWeapon then
				self:AddToBox()
			end
			if self.RemoveOnUse then
				self:RemoveTable()
			end

			hook.Call("PlayerBuyBuildable", nil, ply, self, wep)
		end
	else
		local weptab = weapons.Get(self.WeaponClass)
		if weptab and weptab.ShieldEnabled and ply.GetShield and IsValid(ply:GetShield()) then
			self:EmitSound(self.BuildDenySound)
		return end

		if not ply:HasWeapon(self.WeaponClass) then
			ply:EmitSound(self.BuildPickupSound)
			local wep = ply:Give(self.WeaponClass)
			if self.BoxWeapon then
				self:AddToBox()
			end
			if self.RemoveOnUse then
				self:RemoveTable()
			end

			hook.Call("PlayerBuyBuildable", nil, ply, self, wep)
		else
			self:EmitSound(self.BuildDenySound)
		end
	end
end

function ENT:AddToBox()
	if not self.WeaponClass then return end
	if self:GetUsed() then return end

	if not nzMapping.Settings.rboxweps[self.WeaponClass] then
		self.FixBoxList = true
		nzMapping.Settings.rboxweps[self.WeaponClass] = self.WeaponWeight
		timer.Simple(0, function()
			nzMapping:SendMapData()
		end)
	end

	self:SetUsed(true)

	if IsValid(self.CraftedModel) then
		ParticleEffect("nzr_building_poof", self.CraftedModel:WorldSpaceCenter(), angle_zero)
		self.CraftedModel:EmitSound("NZ.BO2.DigSite.Part")
		self.CraftedModel:GoGhost()
	end
	if IsValid(self.CraftedModel2) then
		self.CraftedModel2:GoGhost()
	end
end

function ENT:RemoveTable()
	if not self.RemoveOnUse then return end

	//nzSounds:PlayEnt("Bye", self)
	ParticleEffect("nzr_building_poof", self:WorldSpaceCenter(), angle_zero)
	self:EmitSound("NZ.BO2.DigSite.Part")

	self:SetTrigger(false)
	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)

	if IsValid(self.CraftedModel) then
		SafeRemoveEntity(self.CraftedModel)
	end
	if IsValid(self.CraftedModel2) then
		SafeRemoveEntity(self.CraftedModel2)
	end
end

function ENT:ResetParts()
	self:Reset()

	local buildables = ents.FindByClass("nz_buildable")
	for k, v in pairs(buildables) do
		if v:GetBuildable() == self:GetBuildable() then
			v:Trigger()
		end
	end

	for i=1, #nzBuilds:GetBuildParts(self:GetBuildable()) do
		for k, v in RandomPairs(buildables) do
			if v:GetBuildable() == self:GetBuildable() and v:GetActivated() and v:GetPartID() == i then
				v:Reset()
				break
			end
		end
	end
end

function ENT:TriggerParts()
	self:Reset()

	for k, v in pairs(ents.FindByClass("nz_buildable")) do
		if v:GetBuildable() == self:GetBuildable() then
			v:Trigger()
		end
	end
end

function ENT:Reset()
	self:CreateFakeModel()
	if IsValid(self.CraftedModel) then
		self.CraftedModel:GoGhost()
	end
	if IsValid(self.CraftedModel2) then
		self.CraftedModel2:GoGhost()
	end

	if self.FixBoxList and self:GetUsed() and self.WeaponClass then
		self.FixBoxList = false
		nzMapping.Settings.rboxweps[self.WeaponClass] = nil
		timer.Simple(0, function()
			nzMapping:SendMapData()
		end)
	end

	self:SetUsed(false)
	self:SetCompleted(false)

	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)

	self:SetColor(Color(255, 255, 255, 255))
	self:SetRenderMode(RENDERMODE_NORMAL)
	self:SetRenderFX(0)
	self:SetBrutusLocked(false)

	local buildtab = nzBuilds:GetBuildable(self:GetBuildable())
	if buildtab.reset then
		buildtab.reset(self)
	end
end

function ENT:BrutusUnlock()
	self:SetBrutusLocked(false)
	self:SetColor(Color(255, 255, 255, 255))
	self:SetRenderMode(RENDERMODE_NORMAL)
	self:SetRenderFX(0)
end

function ENT:OnBrutusLocked()
	self:SetColor(Color(255, 255, 255, 100))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(15)
	self:SetBrutusLocked(true)
end
