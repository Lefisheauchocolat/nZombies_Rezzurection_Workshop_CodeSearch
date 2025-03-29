AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Arsenal"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    util.AddNetworkString("nzArsenal_Use")

    net.Receive("nzArsenal_Use", function(len, ply)
        local ks = net.ReadString()
        local ent = net.ReadEntity()
        if !IsValid(ent) or ent:GetClass() != "bo6_arsenal" or ent:GetPos():Distance(ply:GetPos()) > 128 then return end

        local tab = nzAATs.Data[ks]
        if !istable(tab) then return end

        local wep = ply:GetActiveWeapon()
        if ply:GetNWInt('Salvage', 0) < nzSettings:GetSimpleSetting("ArsenalSalvageCost"..ks, 500) or IsValid(wep) and wep:GetNW2String("nzAATType") == ks then
            ply:SendLua([[surface.PlaySound("bo6/other/craft_no.wav")]]) 
            return 
        end

        if IsValid(wep) then
            ply:SetNWInt('Salvage', ply:GetNWInt('Salvage')-nzSettings:GetSimpleSetting("ArsenalSalvageCost"..ks, 500))
            ply:SendLua([[surface.PlaySound("bo6/other/craft_yes.wav")]]) 
            wep:SetNW2String("nzAATType", ks)
            ply.LastNZAATType = ks
        end
    end)

    function ENT:Initialize()
        self:SetModel("models/hari/props/arsenal.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(false)
        self:SetUseType(SIMPLE_USE)
    end

    function ENT:Use(ply)
        net.Start("nzArsenal_Use")
        net.WriteEntity(self)
        net.Send(ply)
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
    
    local function We(x)
        return (x / 1920) * ScrW()
    end
    
    local function He(y)
        return (y / 1080) * ScrH()
    end
    
    local craftBg = Material("bo6/hud/craft_bg.png")
    local cardBg = Material("bo6/hud/card.png")
    local salvageIcon = Material("bo6/other/salvage.png", "mips")
    
    local function openCraftMenu(craftent)
        local ply = LocalPlayer()
        local kname, kdesc = "", ""
    
        local frame = vgui.Create("DFrame")
        frame:SetSize(ScrW(), ScrH())
        frame:SetTitle("")
        frame:MakePopup()
        frame:ShowCloseButton(false)
        frame.Paint = function(self,w,h)
            surface.SetDrawColor(0,0,0,240)
            surface.DrawRect(0,0,w,h)
    
            surface.SetMaterial(craftBg)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRect(0,0,w,h)
            draw.SimpleText("ARSENAL", "BO6_Exfil96", w/2, He(50), Color(255,225,170), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
            surface.SetDrawColor(100,100,100,100)
            surface.DrawRect(w/2-We(200),He(98),We(400),He(50))
            draw.SimpleText("MY SALVAGE", "BO6_Exfil48", w/2, He(120), Color(175,155,115), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
            surface.SetMaterial(salvageIcon)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRect(w/2+We(18),He(104),We(32),He(32))
            draw.SimpleText(ply:GetNWInt('Salvage', 0), "BO6_Exfil32", w/2+We(50), He(120), Color(180,180,180), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    
            draw.SimpleText(string.upper(kname), "BO6_Exfil72", w/2, h/2+He(130), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(kdesc, "BO6_Exfil32", w/2, h/2+He(170), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    
        local grid = vgui.Create("DGrid", frame)
        grid:SetSize(We(800), He(450))
        grid:SetPos(ScrW()/2-We(450), ScrH()-He(335))
        grid:SetCols(7)
        grid:SetColWide(We(130))
        grid:SetRowHeight(He(170))
        
        for name, tab in pairs(nzAATs.Data) do
            local but = vgui.Create( "DButton" )
            but:SetText("")
            but:SetSize(We(110), He(160))
            grid:AddItem(but)
            but.Paint = function(self,w,h)
                surface.SetMaterial(cardBg)
                surface.SetDrawColor(255,255,255)
                surface.DrawTexturedRect(0,0,w,h)
    
                if self:IsHovered() then
                    surface.SetDrawColor(255,255,255,5)
                    surface.DrawRect(0,0,w,h)
                end
    
                surface.SetMaterial(tab.icon)
                surface.SetDrawColor(255,255,255)
                surface.DrawTexturedRect(We(5),He(10),We(100),He(100))
    
                surface.SetMaterial(salvageIcon)
                surface.SetDrawColor(255,255,255)
                surface.DrawTexturedRect(w/2-We(36),h-He(44),We(32),He(32))
    
                draw.SimpleText(nzSettings:GetSimpleSetting("ArsenalSalvageCost"..name, 500), "BO6_Exfil26", w/2, h-He(25), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetNW2String("nzAATType") == name then
                    surface.SetDrawColor(0,0,0,200)
                    surface.DrawRect(0,0,w,h)
                    surface.SetDrawColor(200,200,200,200)
                    surface.DrawRect(0,0,w,He(24))
                    draw.SimpleText("SELECTED", "BO6_Exfil24", w/2, 0, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                elseif ply:GetNWInt('Salvage') < nzSettings:GetSimpleSetting("ArsenalSalvageCost"..name, 500) then
                    surface.SetDrawColor(0,0,0,200)
                    surface.DrawRect(0,0,w,h)
                    surface.SetDrawColor(200,100,100,200)
                    surface.DrawRect(0,0,w,He(24))
                    draw.SimpleText("NO SALVAGE", "BO6_Exfil24", w/2, 0, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                end
            end
            but.DoClick = function(self)
                net.Start("nzArsenal_Use")
                net.WriteString(name)
                net.WriteEntity(craftent)
                net.SendToServer()
            end
            but.OnCursorEntered = function(self)
                kname, kdesc = tab.name, "Ammo mod for weapons."
                surface.PlaySound("bo6/other/hover.wav")
            end
            but.OnCursorExited = function(self)
                kname, kdesc = "", ""
            end
        end

        local but = vgui.Create( "DButton", frame )
        but:SetText("")
        but:SetSize(We(200), He(50))
        but:SetPos(We(1200), ScrH()-He(100))
        but.Paint = function(self,w,h)
            surface.SetMaterial(cardBg)
            surface.SetDrawColor(255,255,255)
            surface.DrawTexturedRect(0,0,w,h)

            if self:IsHovered() then
                surface.SetDrawColor(255,255,255,5)
                surface.DrawRect(0,0,w,h)
            end

            draw.SimpleText("CLOSE", "BO6_Exfil32", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        but.OnCursorEntered = function(self)
            surface.PlaySound("bo6/other/hover.wav")
        end
        but.DoClick = function(self)
            frame:Remove()
        end
    end
    
    net.Receive("nzArsenal_Use", function()
        local ent = net.ReadEntity()
        openCraftMenu(ent)
    end)
end