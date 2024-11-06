AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "Nuketown Perk Spawner"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Landed")
end

function ENT:Initialize()
	self:SetModel("models/moo/_codz_ports_props/t6/zm/p6_zm_cratepile/_codz_p6_zm_cratepile.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetLanded(false)

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.TimeToImpact and self.TimeToImpact < CurTime() then
			self.TimeToImpact = nil

			self:EmitSound("nz_moo/perkacola/perk_m_land.wav", SNDLVL_GUNFIRE, 100, 1, CHAN_STATIC)
			ParticleEffect("bo3_panzer_explosion", self:GetPos(), angle_zero)

			self:SpawnMachine()
			self:Hide()
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self.TimeToImpact = nil
	if self.LaunchedPerk and IsValid(self.LaunchedPerk) then
		self.LaunchedPerk:Remove()
		self.LaunchedPerk = nil
	end
end

function ENT:Launch()
	if not self.PerkData then return end

	self.TimeToImpact = CurTime() + 5

	self:EmitSound("nz_moo/perkacola/perk_m_incoming.wav", SNDLVL_GUNFIRE, 100, 1, CHAN_WEAPON)

	local perkid = self.PerkData["id"]
	local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)

	self.LaunchedPerk = ents.Create("perk_launched")
	if perkid == "wunderfizz" then
		if nzMapping.Settings.cwfizz then
			self.LaunchedPerk:SetModel("models/moo/_codz_ports_props/t10/jup_zm_machine_wunderfizz/moo_codz_jup_zm_machine_wunderfizz.mdl")
		else
			if perktype == "CLASSIC" then
				self.LaunchedPerk:SetModel("models/nzr/2022/machines/wonder/vending_wonder.mdl")
			else
				self.LaunchedPerk:SetModel("models/perks/machines/wonder/vending_wunderfizz.mdl")
			end
		end
	else
		local pdata = nzPerks:Get(perkid)
		local kystable = {
			["OG"] = pdata.model,
			["CLASSIC"] = pdata.model_classic,
			["IW"] = pdata.skin,
			["CW"] = pdata.model_cw,
			["VG"] = pdata.model_vg,
		}

		self.LaunchedPerk:SetModel(kystable[perktype] or pdata.model or "")
	end

	local pos = self:GetPos() + vector_up*4000
	if nzMapping.Settings.nukedspawn then
		pos = nzMapping.Settings.nukedspawn
	end

	self.LaunchedPerk:SetPos(pos)
	self.LaunchedPerk:SetAngles(self:GetAngles())
	self.LaunchedPerk:SetOwner(self)
	self.LaunchedPerk:SetNoDraw(true)
	self.LaunchedPerk:Spawn()
	self.LaunchedPerk:SetNoDraw(true)
	self.LaunchedPerk:SetSolid(SOLID_NONE)
end

function ENT:SpawnMachine()
	if self.PerkData then
		local newdata = table.Copy(self.PerkData)
		newdata.door = nil //incompatible
		newdata.doorflag = nil //incompatible
		newdata.doorflag2 = nil //incompatible
		newdata.doorflag3 = nil //incompatible

		self.PerkMachine = nzMapping:PerkMachine(self:GetPos(), self:GetAngles(), newdata)
		if not IsValid(self.PerkMachine) then return end

		if nzMapping.Settings.randompap and self.PerkData["id"] == "pap" and (!nzPerks.PackAPunchCount or nzPerks.PackAPunchCount == 0) and not self.PerkMachine:GetSelected() then
			self.PerkMachine:SetSelected(true)
			self.PerkMachine.MarkedForRemoval = nil
		end

		//this makes no sense since only 1 perk machine falls at a time, there would be nothing to randomize with
		//and its already randomized when game starts
		/*if self.PerkMachine.Randomize then
			self.PerkMachine:StartRolling()
		end*/

		local class = self.PerkMachine:GetClass()
		if (nzElec:IsOn() and (nzMapping.Settings.cwfizz or class ~= "wunderfizz_machine")) or (#player.GetAllPlaying() <= 1 and self.PerkData["id"] == "revive") then
			self.PerkMachine:TurnOn()
			return
		end

		if nzElec:IsOn() and class == "wunderfizz_machine" then
			local fizzies = ents.FindByClass("wunderfizz_machine")
			for k, v in pairs(fizzies) do
				if v:IsOn() then
					return
				end
			end

			self.PerkMachine:TurnOn()
		end
	end
end

function ENT:Hide()
	if self.LaunchedPerk and IsValid(self.LaunchedPerk) then
		self.LaunchedPerk:Remove()
		self.LaunchedPerk = nil
	end

	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetLanded(true)
end

if CLIENT then
	function ENT:Draw()
		if self.GetLanded and self:GetLanded() then return end
		self:DrawModel()
	end
end
