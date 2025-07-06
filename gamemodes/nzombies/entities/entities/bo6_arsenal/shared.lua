AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Arsenal"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "ElecState")
end

local color_red = Color(255,0,0)
local color_green = Color(0,255,0)
local onlight = Material( "sprites/physg_glow1" )
local usedcolor = Color(255,240,225)

function ENT:OnRemove()
    self:StopSound("nz_moo/machines/weaponmachine/t10_evt_arsenal_machine_loop.wav")
end

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

            if math.Rand(0,100) < 50 then
                ent:EmitSound("nz_moo/machines/weaponmachine/_music/t10_evt_arsenal_machine_stinger_0"..math.random(2)..".mp3", 75, math.random(95,105))
            else
                ent:EmitSound("nz_moo/machines/weaponmachine/_voice/use/wm_vox_use_"..math.random(70)..".mp3", 75, math.random(95,105), 1, 2)
            end
        end
    end)

    function ENT:Initialize()
        self:SetModel("models/moo/_codz_ports_props/t10/t10_zm_weapon_machine/moo_codz_t10_zm_weapon_machine.mdl")
        self:SetMoveType( MOVETYPE_NONE )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( true )
        self:SetUseType( SIMPLE_USE )

        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableMotion(false)
            phys:Sleep()
        end

        if nzRound:InState(ROUND_CREATE) and !nzSettings:GetSimpleSetting("ArsenalRequirePower") then
            self:TurnOn()
        end

        self.NextIdleVoice = CurTime() + math.Rand(25.24, 110.47)
    end

    function ENT:Think()
        if CurTime() > self.NextIdleVoice and self:GetElecState() then
            self.NextIdleVoice = CurTime() + math.Rand(25.24, 110.47)
            if math.Rand(0,100) < 50 then
                self:EmitSound("nz_moo/machines/weaponmachine/_voice/idle/wm_vox_idle_"..math.random(28)..".mp3", 80, math.random(95,105), 1, 2)
            else
                self:EmitSound("nz_moo/machines/weaponmachine/_music/t10_evt_arsenal_machine_jingle_0"..math.random(6)..".mp3", 80, math.random(95,105), 1, 2)
            end
        end

        self:NextThink(CurTime())
        return true
    end

    function ENT:TurnOn()
        if IsValid(self) and (nzSettings:GetSimpleSetting("ArsenalRequirePower") and !self:GetElecState() or !nzSettings:GetSimpleSetting("ArsenalRequirePower")) then
            self:SetElecState(true)
            self:SetSkin(1)
            self:ToggleSmoke(true)
        end
    end

    function ENT:TurnOff()
        if IsValid(self) then
            self:SetElecState(false)
            self:SetSkin(0)
            self:ToggleSmoke(false)
        end
    end

    function ENT:Use(ply)
        if self:GetElecState() then
            net.Start("nzArsenal_Use")
            net.WriteEntity(self)
            net.Send(ply)
        end
    end


    function ENT:ToggleSmoke(toggle)
        if self:GetNoDraw() then return end

        if toggle then
            local emitter = ents.Create("env_smokestack")
            emitter:SetParent(self)
            emitter:SetLocalPos(self:WorldToLocal(self:GetAttachment(3).Pos))
            emitter:SetAngles(self:GetAngles() + Angle(0,0,10))
            emitter:SetKeyValue("InitialState", "1")
            emitter:SetKeyValue("BaseSpread", "1")
            emitter:SetKeyValue("SpreadSpeed", "0")
            emitter:SetKeyValue("Speed", "15")
            emitter:SetKeyValue("StartSize", "8")
            emitter:SetKeyValue("EndSize", "19")
            emitter:SetKeyValue("Rate", "3")
            emitter:SetKeyValue("JetLength", "40")
            emitter:SetKeyValue("SmokeMaterial", "particle/smokesprites_0004.vmt")
            emitter:SetKeyValue("rendercolor", "1 1 1")
            emitter:SetKeyValue("renderamt", "150")
            emitter:Spawn()
        else
            for k,v in pairs(ents.FindByClass("env_smokestack")) do
                if IsValid(v) and v:GetParent() == self then
                    v:Remove()
                end
            end
        end
    end
else
    function ENT:Draw()
        self:DrawModel()

        if self:GetElecState() then

            if !IsValid(self) then return end
            if !self.Draw_SFX or !IsValid(self.Draw_SFX) then
                self.Draw_SFX = "nz_moo/machines/weaponmachine/t10_evt_arsenal_machine_loop.wav"

                self:EmitSound(self.Draw_SFX, 65, math.random(95, 105), 1, 3)
            end

            render.SetMaterial(onlight)
            render.DrawSprite(self:GetAttachment(2).Pos, math.Rand(13,15), math.Rand(13,15), color_red)

            local dlight = DynamicLight(self:EntIndex(), true)
            if ( dlight ) then
                dlight.pos = self:GetPos() + Vector(0, 0, 55) - self:GetRight() * 10
                dlight.r = 175
                dlight.g = 255
                dlight.b = 255
                dlight.brightness = 1.5
                dlight.Decay = 2000
                dlight.Size = 256
                dlight.DieTime = CurTime() + 0.5
            end
        end
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
        frame.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 240)
            surface.DrawRect(0, 0, w, h)

            surface.SetMaterial(craftBg)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(0, 0, w, h)
            draw.SimpleText("ARSENAL", "BO6_Exfil96", w / 2, 50 * scale, Color(255, 225, 170), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            surface.SetDrawColor(100, 100, 100, 100)
            surface.DrawRect(w / 2 - (200 * scale), 98 * scale, 400 * scale, 50 * scale)
            draw.SimpleText("MY SALVAGE", "BO6_Exfil48", w / 2, 120 * scale, Color(175, 155, 115), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

            surface.SetMaterial(salvageIcon)
            surface.SetDrawColor(255, 255, 255)
            surface.DrawTexturedRect(w / 2 + (18 * scale), 104 * scale, 32 * scale, 32 * scale)
            draw.SimpleText(ply:GetNWInt('Salvage', 0), "BO6_Exfil32", w / 2 + (50 * scale), 120 * scale, Color(180, 180, 180), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            draw.SimpleText(string.upper(kname), "BO6_Exfil72", w / 2, h - (300 * scale) - (100 * scale), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(kdesc, "BO6_Exfil32", w / 2, h - (300 * scale) - (60 * scale), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local grid = vgui.Create("DGrid", frame)
        grid:SetSize(800 * scale, 450 * scale)
        grid:SetPos(w / 2 - (450 * scale), h - (335 * scale))
        grid:SetCols(7)
        grid:SetColWide(130 * scale)
        grid:SetRowHeight(170 * scale)

        for name, tab in pairs(nzAATs.Data) do
            local but = vgui.Create("DButton")
            but:SetText("")
            but:SetSize(110 * scale, 160 * scale)
            grid:AddItem(but)
            but.Paint = function(self, w, h)
                surface.SetMaterial(cardBg)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(0, 0, w, h)

                if self:IsHovered() then
                    surface.SetDrawColor(255, 255, 255, 5)
                    surface.DrawRect(0, 0, w, h)
                end

                surface.SetMaterial(tab.icon)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(5 * scale, 10 * scale, 100 * scale, 100 * scale)

                surface.SetMaterial(salvageIcon)
                surface.SetDrawColor(255, 255, 255)
                surface.DrawTexturedRect(w / 2 - (36 * scale), h - (44 * scale), 32 * scale, 32 * scale)

                draw.SimpleText(nzSettings:GetSimpleSetting("ArsenalSalvageCost" .. name, 500), "BO6_Exfil26", w / 2, h - (25 * scale), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetNW2String("nzAATType") == name then
                    surface.SetDrawColor(0, 0, 0, 200)
                    surface.DrawRect(0, 0, w, h)
                    surface.SetDrawColor(200, 200, 200, 200)
                    surface.DrawRect(0, 0, w, 24 * scale)
                    draw.SimpleText("SELECTED", "BO6_Exfil24", w / 2, 0, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                elseif ply:GetNWInt('Salvage') < nzSettings:GetSimpleSetting("ArsenalSalvageCost" .. name, 500) then
                    surface.SetDrawColor(0, 0, 0, 200)
                    surface.DrawRect(0, 0, w, h)
                    surface.SetDrawColor(200, 100, 100, 200)
                    surface.DrawRect(0, 0, w, 24 * scale)
                    draw.SimpleText("NO SALVAGE", "BO6_Exfil24", w / 2, 0, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
                end
            end
            but.DoClick = function(self)
                net.Start("nzArsenal_Use")
                net.WriteString(name)
                net.WriteEntity(craftent)
                net.SendToServer()
            end
            but.OnCursorEntered = function(self)
                kname, kdesc = tab.name, tab.desc
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
        local myhint = "Use Arsenal"
        if !self:GetElecState() then
            return "You must turn on the electricity first!"
        end

        return "Press "..string.upper(input.LookupBinding("+USE")).." - "..myhint
    end

    net.Receive("nzArsenal_Use", function()
        local ent = net.ReadEntity()
        openCraftMenu(ent)
    end)
end