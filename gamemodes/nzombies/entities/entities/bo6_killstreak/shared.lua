AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Killstreak"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    local tab = {
        ["bo6_killstreak_rcxd"] = 50,
        ["bo6_killstreak_cannon"] = 50,
        ["bo6_killstreak_ldbr"] = 50,
        ["bo6_killstreak_napalm"] = 45,
        ["bo6_killstreak_hellstorm"] = 45,
        ["bo6_killstreak_sentry"] = 30,
        ["bo6_killstreak_death"] = 30,
        ["bo6_killstreak_vtol"] = 30,
        ["bo6_killstreak_mangler"] = 20,
        ["bo6_killstreak_chopper"] = 20,
        ["bo6_killstreak_dna"] = 5,
    }
    
    function ENT:RandomKillstreak()
        local selected = "bo6_killstreak_cannon"

        local totalWeight = 0
        for _, weight in pairs(tab) do
            totalWeight = totalWeight + weight
        end
    
        local randomWeight = math.random(1, totalWeight)
        local cumulativeWeight = 0
        for class, weight in pairs(tab) do
            cumulativeWeight = cumulativeWeight + weight
            if randomWeight <= cumulativeWeight then
                selected = class
                break
            end
        end
    
        self:SetNWString("Class", selected)
    end    

    function ENT:Initialize()
        self:SetNWString("Class", "bo6_killstreak_rcxd")
        self:SetModel("models/bo6/ks/tablet.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
        self:SetModelScale(1.8)
        self:SetNWString("OutlineType", "killstreak")
        self:SetSkin(1)
    end

    function ENT:Use(ply)
        if ply:HasWeapon(self:GetNWString('Class')) then return end
        ply:GiveKillstreak(self:GetNWString('Class'))
        ply:EmitSound("items/ammo_pickup.wav", 60)
        self:Remove()
    end

    function ENT:Think()
        local ang = self:GetAngles()
        self:SetAngles(Angle(0,ang.y,0))
    end
end

if CLIENT then
    local function wepname(class)
        local weapon = weapons.Get(class)
        if weapon and weapon.PrintName then
            return weapon.PrintName
        end
        return "Killstreak"
    end

	local displayfont = "BO6_Exfil32_2"
	local drawdistance = 800^2
	local size = 0.25

	function ENT:Draw()
		self:DrawModel()

		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = self:GetAngles()
			angle:RotateAroundAxis( angle:Up(), 90 )
			angle:RotateAroundAxis( angle:Forward(), 0 )
			cam.Start3D2D(self:GetPos() + self:GetUp()*2.2, angle, 0.1)
                local icon = nzKillstreak.ClassToIcon[self:GetNWString('Class')]
                if icon then
                    local name = wepname(self:GetNWString('Class'))
                    surface.SetMaterial(icon)
                    surface.SetDrawColor(255,255,255)
				    surface.DrawTexturedRect(-53,-32,96,96)
                    draw.SimpleText(string.upper(name), "BO6_Exfil26", -5, -40, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
			cam.End3D2D()
		end
	end
end