AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Crafting Table"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    util.AddNetworkString("nzCraftingTable_Use")

    net.Receive("nzCraftingTable_Use", function(len, ply)
        local ks = net.ReadString()
        local ent = net.ReadEntity()
        if !IsValid(ent) or ent:GetClass() != "bo6_crafting_table" or ent:GetPos():Distance(ply:GetPos()) > 128 then return end

        local tab = nzKillstreak.List[ks]
        if !istable(tab) then return end
        if !nzSettings:GetSimpleSetting("BO6_Killstreak_"..ks, true) then return end

        if ply:GetNWInt('Salvage', 0) < tab.cost or !tab.check(ply) then
            ply:SendLua([[surface.PlaySound("bo6/other/craft_no.wav")]]) 
            return 
        end

        ply:SetNWInt('Salvage', ply:GetNWInt('Salvage')-tab.cost)
        ply:SendLua([[surface.PlaySound("bo6/other/craft_yes.wav")]]) 
        tab.buy(ply)
    end)

    function ENT:Initialize()
        self:SetModel("models/zmb/bo2/tranzit/zm_work_bench.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(false)
        self:SetUseType(SIMPLE_USE)
    end

    function ENT:Use(ply)
        net.Start("nzCraftingTable_Use")
        net.WriteEntity(self)
        net.Send(ply)
    end
else
    local drawdistance = 800^2
    local size = 0.2

    function ENT:Draw()
        self:DrawModel()

        local add = -20*math.sin(CurTime())

        local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
        if oh_god_what_the_fuck then
            local angle = EyeAngles()
            angle:RotateAroundAxis( angle:Up(), -90 )
            angle:RotateAroundAxis( angle:Forward(), 90 )
            cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
                draw.SimpleText("CRAFTING TABLE", "BO6_Exfil32", 0, 40+add, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText("(Press E to open menu)", "BO6_Exfil12", 0, 55+add, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
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
            draw.SimpleText("CRAFTING TABLE", "BO6_Exfil96", w/2, He(50), Color(255,225,170), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
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
        
        for name, tab in SortedPairsByMemberValue(nzKillstreak.List, "cost", false) do
            if !nzSettings:GetSimpleSetting("BO6_Killstreak_"..name, true) then continue end
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
    
                draw.SimpleText(tab.cost, "BO6_Exfil26", w/2, h-He(25), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                if !tab.check(ply) then
                    surface.SetDrawColor(0,0,0,200)
                    surface.DrawRect(0,0,w,h)
                    surface.SetDrawColor(200,200,200,200)
                    surface.DrawRect(0,0,w,He(24))
                    draw.SimpleText("SELECTED", "BO6_Exfil24", w/2, 0, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                elseif ply:GetNWInt('Salvage') < tab.cost then
                    surface.SetDrawColor(0,0,0,200)
                    surface.DrawRect(0,0,w,h)
                    surface.SetDrawColor(200,100,100,200)
                    surface.DrawRect(0,0,w,He(24))
                    draw.SimpleText("NO SALVAGE", "BO6_Exfil24", w/2, 0, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                end
            end
            but.DoClick = function(self)
                net.Start("nzCraftingTable_Use")
                net.WriteString(name)
                net.WriteEntity(craftent)
                net.SendToServer()
            end
            but.OnCursorEntered = function(self)
                kname, kdesc = name, tab.desc
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
    
    net.Receive("nzCraftingTable_Use", function()
        local ent = net.ReadEntity()
        openCraftMenu(ent)
    end)
end