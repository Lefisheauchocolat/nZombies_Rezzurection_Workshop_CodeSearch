AddCSLuaFile()

SWEP.ViewModel			= Model("models/bo6/wep/c_handlooker.mdl")
SWEP.WorldModel			= ""
SWEP.ViewModelFOV		= 80
SWEP.NZSpecialCategory = "killstreak"
SWEP.Type_Displayed = "Killstreak"
SWEP.UseHands = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Mangler Injection"
SWEP.Slot				= 0
SWEP.SlotPos			= 5
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

function SWEP:PrimaryAttack() end

function SWEP:SecondaryAttack() end

function SWEP:Think() end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "reference" ) )
	timer.Simple(0.1, function()
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "seq_admire_bms_old" ) )
	end)
	
	if SERVER then
		timer.Simple(2, function()
			if !IsValid(self.Owner) then return end
			self.Owner:ScreenFade(SCREENFADE.OUT, color_white, 1, 0.6)
			self.Owner:EmitSound("ambient/levels/citadel/zapper_warmup4.wav", 60)
		end)
		timer.Simple(3.6, function()
			if !IsValid(self.Owner) then return end
			nzKillstreak:ManglerInjection(self.Owner)
			self:Remove()
		end)
	end

	return true
end
