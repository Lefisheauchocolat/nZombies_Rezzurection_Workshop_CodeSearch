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
        ent:ResetSequence("use")
    end)

    function ENT:Initialize()
        self:SetModel("models/moo/_codz_ports_props/t10/t10_zm_machine_crafting/moo_codz_t10_zm_machine_crafting_fxanim.mdl")
        self:SetMoveType( MOVETYPE_NONE )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( true )
        self:SetUseType( SIMPLE_USE )
        self.AutomaticFrameAdvance = true

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(false)
            phys:Sleep()
        end
    end

    function ENT:Use(ply)
        net.Start("nzCraftingTable_Use")
        net.WriteEntity(self)
        net.Send(ply)
    end

    function ENT:Think()
        self:NextThink( CurTime() )
        return true
    end
else
    local drawdistance = 800^2
    local size = 0.2

    function ENT:Draw()
        self:DrawModel()
    end
    
    local w, h = ScrW(), ScrH()
    local scale = ((w / 1920) + 1) / 2
    
    local craftBg = Material("bo6/hud/craft_bg.png")
    local cardBg = Material("bo6/hud/card.png")
    local salvageIcon = Material("bo6/other/salvage.png", "mips")
    
    local function openCraftMenu(craftent)
        local ply = LocalPlayer()
        local kname, kdesc = "", ""

        local frame = vgui.Create("DFrame")
        frame:SetSize(w, h)
        frame:SetTitle("")
        frame:MakePopup()
        frame:ShowCloseButton(false)
        frame.Paint = function(self, fw, fh)
            surface.SetDrawColor(0, 0, 0, 240)
            surface.DrawRect(0, 0, fw, fh)

            surface.SetMaterial(craftBg)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(0, 0, fw, fh)

            draw.SimpleText("CRAFTING TABLE", "BO6_Exfil96", fw / 2, 50 * scale, Color(255, 225, 170), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            surface.SetDrawColor(100, 100, 100, 100)
            surface.DrawRect(fw / 2 - (200 * scale), 98 * scale, 400 * scale, 50 * scale)
            draw.SimpleText("MY SALVAGE", "BO6_Exfil48", fw / 2, 120 * scale, Color(175, 155, 115), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

            surface.SetMaterial(salvageIcon)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(fw / 2 + (18 * scale), 104 * scale, 32 * scale, 32 * scale)
            draw.SimpleText(ply:GetNWInt("Salvage", 0), "BO6_Exfil32", fw / 2 + (50 * scale), 120 * scale, Color(180, 180, 180), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            draw.SimpleText(string.upper(kname), "BO6_Exfil72", w / 2, h - (300 * scale) - (100 * scale), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(kdesc, "BO6_Exfil32", w / 2, h - (300 * scale) - (60 * scale), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local grid = vgui.Create("DGrid", frame)
        grid:SetSize(800 * scale, 450 * scale)
        grid:SetPos(w / 2 - (450 * scale), h - (335 * scale))
        grid:SetCols(7)
        grid:SetColWide(130 * scale)
        grid:SetRowHeight(170 * scale)

        for name, tab in SortedPairsByMemberValue(nzKillstreak.List, "cost", false) do
            if not nzSettings:GetSimpleSetting("BO6_Killstreak_" .. name, true) then continue end

            local but = vgui.Create("DButton")
            but:SetText("")
            but:SetSize(110 * scale, 160 * scale)
            grid:AddItem(but)

            but.Paint = function(self, bw, bh)
                surface.SetMaterial(cardBg)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(0, 0, bw, bh)

                if self:IsHovered() then
                    surface.SetDrawColor(255, 255, 255, 5)
                    surface.DrawRect(0, 0, bw, bh)
                end

                surface.SetMaterial(tab.icon)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(5 * scale, 10 * scale, 100 * scale, 100 * scale)

                surface.SetMaterial(salvageIcon)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(bw / 2 - (36 * scale), bh - (44 * scale), 32 * scale, 32 * scale)

                draw.SimpleText(tab.cost, "BO6_Exfil26", bw / 2, bh - (25 * scale), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                if not tab.check(ply) then
                    surface.SetDrawColor(0, 0, 0, 200)
                    surface.DrawRect(0, 0, bw, bh)
                    surface.SetDrawColor(200, 200, 200, 200)
                    surface.DrawRect(0, 0, bw, 24 * scale)
                    draw.SimpleText("OWNED", "BO6_Exfil24", bw / 2, 0, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                elseif ply:GetNWInt("Salvage") < tab.cost then
                    surface.SetDrawColor(0, 0, 0, 200)
                    surface.DrawRect(0, 0, bw, bh)
                    surface.SetDrawColor(200, 100, 100, 200)
                    surface.DrawRect(0, 0, bw, 24 * scale)
                    draw.SimpleText("NO SALVAGE", "BO6_Exfil24", bw / 2, 0, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
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
    
    function ENT:GetNZTargetText()
        local myhint = "Use Crafting Table"
        return "Press "..string.upper(input.LookupBinding("+USE")).." - "..myhint
    end

    net.Receive("nzCraftingTable_Use", function()
        local ent = net.ReadEntity()
        openCraftMenu(ent)
    end)
end