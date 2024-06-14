AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "pap_weapon_trigger"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "WepClass")
	self:NetworkVar("Entity", 0, "PaPOwner")
end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:SetModel("models/hunter/blocks/cube05x1x025.mdl")
	self:DrawShadow(false)

	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
end

function ENT:Use(ply, caller)
	if ply == self:GetPaPOwner() then
		nzPowerUps.HasPaped = true

		if ply.PAPBackupWeapon and IsValid(ply.PAPBackupWeapon) then
			ply:StripWeapon(ply.PAPBackupWeapon:GetClass())
		end

		local class = self:GetWepClass()
		local wep

		if self.RerollingAtts then
			wep = ply:GiveNoAmmo(class)
		else
			wep = ply:Give(class)
		end

		if IsValid(self.wep) and self.wep.lastcamo then
			wep.LastCamo = self.wep.lastcamo
		end

		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(wep) then return end

			wep:ApplyNZModifier("pap")
			if self.RerollingAtts then
				wep:ApplyNZModifier("repap")
			end

			if wep.IsTFAWeapon then
				wep:SetClip1(wep.Primary_TFA.ClipSize)
				if wep.Secondary_TFA and wep.Secondary_TFA.ClipSize and wep.Secondary_TFA.ClipSize > 0 then
					wep:SetClip2(wep.Secondary_TFA.ClipSize)
				end
				if wep.Tertiary and wep.SetClip3 and wep.Tertiary.ClipSize and wep.Tertiary.ClipSize > 0 then
					wep:SetClip3(wep.Tertiary.ClipSize)
				end
			else
				wep:SetClip1(wep.Primary.ClipSize)
				if wep.Secondary and wep.Secondary.ClipSize > 0 then
					wep:SetClip2(wep.Secondary.ClipSize)
				end
			end

			if IsValid(self.wep) then
				--self.wep.machine:SetBeingUsed(false)
				self.wep:Remove()
			end

			self:Remove()
		end)
	else
		if IsValid(self:GetPaPOwner()) then
			ply:PrintMessage( HUD_PRINTTALK, "This is " .. self:GetPaPOwner():Nick() .. "'s gun. You cannot take it." )
		end
	end
end

if CLIENT then
	function ENT:Draw()
		return
	end
end
