AddCSLuaFile()

SWEP.ViewModel			= Model("models/bo6/ks/sentry.mdl")
SWEP.WorldModel			= "models/bo6/ks/sentry.mdl"
SWEP.ViewModelFOV		= 80
SWEP.NZSpecialCategory = "killstreak"
SWEP.Type_Displayed = "Killstreak"
SWEP.CanChangeWeapon = true

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

SWEP.PrintName			= "Sentry Turret"
SWEP.Slot				= 0
SWEP.SlotPos			= 5
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false

function SWEP:Initialize()
	self:SetWeaponHoldType("duel")
end

function SWEP:PrimaryAttack() 
	if SERVER then
		self:SetNextPrimaryFire(CurTime()+1)
		local ply = self:GetOwner()

		if !nzKillstreak:CheckLimit("sentry") then
			ply:ChatPrint("Sentry limit reached!")
			return
		end

		local ang = Angle(0,ply:EyeAngles().y,0)
		local pos = ply:GetPos()+ang:Forward()*32

		local sentry = ents.Create("bo6_sentry")
		sentry:SetPos(pos)
		sentry:SetAngles(ang)
		sentry.Player = ply
		sentry:Spawn()

		local wep = ""
		if IsValid(ply:GetPreviousWeapon()) then
			wep = ply:GetPreviousWeapon():GetClass()
		end
		ply:SetActiveWeapon(nil)
		self:Remove()
		timer.Simple(0, function()
			ply:SetUsingSpecialWeapon(false)
			ply:SelectWeapon(wep)
			print(wep)
		end)
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Think() end

function SWEP:OnDrop()
	self:Remove()
end

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			local offsetVec = Vector(-24, -8, 38)
			local offsetAng = Angle(210, 180, 0)
			
			local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand")
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

            WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end

	function SWEP:CalcViewModelView(ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng)
		local pos, ang = EyePos+EyeAng:Forward()*32-EyeAng:Up()*64, EyeAng

		return pos, ang
	end
end

function SWEP:Deploy() end
