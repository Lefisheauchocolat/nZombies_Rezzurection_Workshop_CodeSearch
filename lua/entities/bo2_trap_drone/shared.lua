
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Maxis Drone"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.RPM = 500
ENT.RPMRapid = 700
ENT.Delay = 60
ENT.bIsTrap = true

//ENT.NZHudIcon = Material("vgui/icon/hud_quadrotor_tomb.png", "smooth unlitgeneric")
ENT.NZThrowIcon = Material("vgui/icon/hud_quadrotor_tomb.png", "smooth unlitgeneric")

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "NextAttack")
	self:NetworkVar("String", 0, "TrapClass")
	self:NetworkVar("Bool", 0, "Destroyed")
end

function ENT:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end

		self:EmitSound(sound)
		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())
	if IsValid(self:GetOwner()) then
		filter:RemovePlayer(self:GetOwner())
	end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end

function ENT:OnRemove()
	self:StopSound("TFA_BO2_ZMDRONE.Idle")
	self:StopSound("TFA_BO2_ZMDRONE.Hum")

	if SERVER then
		if nzombies and self:GetDestroyed() then
			self:EmitSound("TFA_BO2_ZMDRONE.Teleport")
			ParticleEffect("bo3_qed_explode_1", self:GetPos(), angle_zero)

			for k, v in pairs(ents.FindByClass("nz_buildtable")) do
				if v:GetNW2Bool("MaxisDeployed", false) then
					v:EmitSound("TFA_BO2_ZMDRONE.Recharging")
					v:SetNW2Float("MaxisCooldown", CurTime() + 100)
					if IsValid(v.CraftedModel) then
						ParticleEffect("nzr_building_poof", v.CraftedModel:WorldSpaceCenter(), angle_zero)
					end
					break
				end
			end

			hook.Call("RespawnMaxisDrone")
		end

		local ply = self:GetOwner()
		if nzombies and IsValid(ply) and ply:IsPlayer() then
			ply:RemoveBuildable(self)
		end

		util.ScreenShake(self:GetPos(), 10, 255, 0.5, 150)
	end
end
