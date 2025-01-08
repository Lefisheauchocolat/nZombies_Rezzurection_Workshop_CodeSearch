AddCSLuaFile()

ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true

ENT.TypeOfInfil = {
    ["Van"] = {
        model = "models/bo6/van_hackney/van_hackney.mdl",
        seq = "spawn",
        chiefmodel = "models/bo6/van_hackney/players.mdl",
        chiefseq = "spawnChief",
        drivermodel = "models/bo6/van_hackney/players.mdl",
        driverseq = "spawnDriver",
        haveweapons = true,
        playermodel = {
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn1",
                delay = 12.5,
                pos = Vector(-250, 75, 0),
                ang = Angle(0,180,0),
            },
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn2",
                delay = 13,
                pos = Vector(-260, -82, 0),
                ang = Angle(0,180,0),
            },
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn3",
                delay = 13.5,
                pos = Vector(-236, 2, 0),
                ang = Angle(0,180,0),
            },
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn4",
                delay = 14,
                pos = Vector(-198, -50, 0),
                ang = Angle(0,180,0),
            },
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn5",
                delay = 14.5,
                pos = Vector(-200, 42, 0),
                ang = Angle(0,180,0),
            },
            {
                model = "models/bo6/van_hackney/players.mdl",
                seq = "spawn6",
                delay = 15,
                pos = Vector(-187, -6, 0),
                ang = Angle(0,180,0),
            },
        },
        sounds = {
            {
                path = "bo6/van/alqatala1_veh1_int_front_ster_pan.wav",
                delay = 0,
            },
            {
                path = "bo6/van/alqatala1_veh1_int_rear_ster_pan.wav",
                delay = 0,
            },
            {
                path = "bo6/van/alqatala1_veh1_door_ster_pan.wav",
                delay = 7.5,
            },
            {
                path = "bo6/van/alqatala1_veh1_door_ster_pan2.wav",
                delay = 15,
            },
            {
                path = "bo6/van/alqatala1_foley_seat1_npc.wav",
                delay = 8,
                crewmin = 1,
            },
            {
                path = "bo6/van/alqatala1_foley_seat2_npc.wav",
                delay = 8.5,
                crewmin = 2,
            },
            {
                path = "bo6/van/alqatala1_foley_seat3_npc.wav",
                delay = 9,
                crewmin = 3,
            },
            {
                path = "bo6/van/alqatala1_foley_seat4_npc.wav",
                delay = 9.5,
                crewmin = 4,
            },
            {
                path = "bo6/van/alqatala1_foley_seat5_npc.wav",
                delay = 10,
                crewmin = 5,
            },
            {
                path = "bo6/van/alqatala1_foley_seat6_npc.wav",
                delay = 10.5,
                crewmin = 6,
            },
        },
        animdelay = 0.0,
        delaystep = 17.5,
        offset = Vector(0,0,0),
        angle = Angle(0,180,0),
        driveaway = true,
        removetime = 10,
    },
    ["Heli"] = {
        model = "models/bo6/exfil/veh/heli.mdl",
        seq = "spawn",
        chiefmodel = "models/bo6/exfil/veh/chiefl.mdl",
        chiefseq = "spawn",
        playermodel = {
            {
                model = "models/bo6/exfil/veh/guy01.mdl",
                seq = "spawn",
                pos = Vector(112.3, -73.6, 0),
                ang = Angle(0,180,0),
                delay = 12,
            },
            {
                model = "models/bo6/exfil/veh/guy02.mdl",
                seq = "spawn",
                pos = Vector(66.85, -115.5, 0),
                ang = Angle(0,180,0),
                delay = 13.5,
            },
            {
                model = "models/bo6/exfil/veh/guy03.mdl",
                seq = "spawn",
                pos = Vector(73.1, -40.8, 0),
                ang = Angle(0,180,0),
                delay = 15,
            },
        },
        sounds = {
            {
                delay = 0,
                path = "bo6/heli/sas1_veh1_int_quad_front_stat.wav",
            },
            {
                delay = 0,
                path = "bo6/heli/sas1_veh1_ceilingrattles_spot_stat.wav",
            },
            {
                delay = 0,
                path = "bo6/heli/sas1_veh1_int_quad_rear_stat.wav",
            },
            {
                delay = 22 / 30,
                path = "bo6/heli/sas1_veh1_foley_doorman_npc.wav",
            },
            {
                delay = 22 / 30,
                path = "bo6/heli/sas1_veh1_door_ster_pan.wav",
            },
            {
                delay = 0,
                path = "bo6/heli/sas1_veh1_foley_seat1_plr.wav",
            },
            {
                delay = 42 / 30,
                path = "bo6/heli/sas1_veh1_rope_spot_stat.wav",
            },
            {
                delay = 184 / 30,
                path = "bo6/heli/sas1_veh1_foley_seat1_npc.wav",
            },
            {
                delay = 190 / 30,
                path = "bo6/heli/sas1_veh1_foley_seat2_npc.wav",
            },
            {
                delay = 280 / 30,
                path = "bo6/heli/sas1_veh1_foley_seat3_npc.wav",
            },
            {
                delay = 328 / 30,
                path = "bo6/heli/sas1_veh1_ext_ster_pan.wav",
            },
        },
        animdelay = 0.0,
        delaystep = 15,
        offset = Vector(0,0,4),
        angle = Angle(0,180,0),
        driveaway = false,
        removetime = 20,
    },
    ["Teleport"] = {
        offset = {
            {
                pos = Vector(50, 50, 10),
                ang = Angle(0,0,0),
            },
            {
                pos = Vector(50, -50, 10),
                ang = Angle(0,0,0),
            },
            {
                pos = Vector(-50, 0, 10),
                ang = Angle(0,0,0),
            },
        },
    },
}

if SERVER then
    util.AddNetworkString("nZR.InfilCrewCam")

    function ENT:MakePlayerTable(index, max)
        local tab = {}
        local count = 0
        local plys = team.GetPlayers(index)
        table.Shuffle(plys)

        for k, v in pairs(plys) do
            if not v.UsingInfil and count < max then
                table.insert(tab, v)
                v.UsingInfil = true
                count = count + 1
            end
        end

        if #tab > 0 then
            self.PlayerTable = tab
        end
    end
    
    function ENT:Initialize()
        self.InfilType = self.TypeOfInfil[self.Infil]
        local tab = self.InfilType

        if self.Infil == "Teleport" then
            self:MakePlayerTable(self.TeamChoose, 3)
            if #self.PlayerTable > 0 then
                for k, v in pairs(self.PlayerTable) do
                    local t = tab.offset[k]
                    timer.Simple(1, function()
                        if !IsValid(v) then return end
                        v.UsingInfil = false
                    end)
                    if !istable(t) then continue end
                    v:SetPos(self:LocalToWorld(t.pos))
                    v:SetEyeAngles(Angle(0,self:GetAngles().y,0))
                    nzFuncs:ShowTeleportGif(v)
                end
            end
            self:Remove()
            return
        end

        self:SetAngles(self:GetAngles()+tab.angle)
        self:SetModel(tab.model)
        self.CrewTable = {}
        self:MakePlayerTable(self.TeamChoose, #tab.playermodel)
        if not self.PlayerTable then
            self:Remove()
        end
        self.DriveVel = 0

        local chiefmod = self.InfilChief

        timer.Simple(0.01, function()
            if !IsValid(self) or not self.PlayerTable then return end

            self:SetPos(tab.offset+self:GetPos())
            timer.Simple(tab.animdelay, function()
                if !IsValid(self) then return end
                self:ResetSequence(tab.seq)
            end)
            for k, v in pairs(self.PlayerTable) do
                if k <= #tab.playermodel then
                    local tab1 = tab.playermodel[k]
                    self:AddCrewModel(tab1.model, tab1.seq, tab1.delay, v, tab1.pos, tab1.ang)
                end
            end

            for k, v in pairs(tab.sounds) do
                timer.Simple(v.delay, function()
                    if !IsValid(self) or v.crewmin and v.crewmin > #self.CrewTable-2 then return end
                    nzFuncs:PlayClientSound(v.path)
                end)
            end
    
            self:AddCrewModel(tab.chiefmodel, tab.chiefseq, 0, chiefmod)

            if tab.drivermodel then
                self:AddCrewModel(tab.drivermodel, tab.driverseq, 0, chiefmod)
            end

            timer.Simple(tab.delaystep, function()
                if !IsValid(self) then return end

                self:SetBodygroup(3, 1)
                self.DriveAway = tab.driveaway
                timer.Simple(tab.removetime, function()
                    if !IsValid(self) then return end

                    self:Remove()
                end)
            end)
        end)
    end

    function ENT:ConnectWeapon(ply)
        if !IsValid(ply) then return end
        local wep = ents.Create('base_anim')
        local attach = ply:GetAttachment(ply:LookupAttachment("anim_attachment_RH"))
        if attach then
            wep:SetPos(attach.Pos)
            wep:SetModel("models/bo6/wep/rifle.mdl")
            wep:SetAngles(attach.Ang)
            wep:SetParent(ply, ply:LookupAttachment("anim_attachment_RH"))
            wep:Spawn()
            wep:SetLocalAngles(Angle(0,0,0))
            wep:SetLocalPos(Vector(-4,-2,-0))
            ply:DeleteOnRemove(wep)
        end
        return wep
    end

    function ENT:AddCrewModel(model, sequence, deletetime, ply, pos, ang)
        local modelply = "models/player/urban.mdl"
        local wepenable = false

        if ply and !isstring(ply) then
            modelply = ply:GetModel()
            ply:Freeze(true)
            ply:SetNoDraw(true)
            ply:GodEnable()
            ply.PreviousInfilWeapon = ply:GetActiveWeapon()
            ply:SetActiveWeapon(nil)
            wepenable = true
        elseif ply and isstring(ply) then
            modelply = ply
        end

        local m = ents.Create("bo6_animated")
        m:SetPos(self:GetPos())
        m:SetAngles(self:GetAngles())
        m:Spawn()
        m:SetModel(model)
        m:ResetSequence(sequence)
        m.Player = ply
        self:DeleteOnRemove(m)
    
        local b = ents.Create("base_anim")
        b:SetModel(modelply)
        if IsValid(ply) and ply:IsPlayer() then
            nzFuncs:TransformModelData(ply, b)
        end
        b:SetPos(self:GetPos())
        b:AddEffects(1)
        b:SetParent(m)
        b:Spawn()
        b:SetNWEntity('Vehicle', self)
        m:DeleteOnRemove(b)
        if wepenable and self.InfilType.haveweapons then
            self:ConnectWeapon(b)
        end

        table.insert(self.CrewTable, m)

        local time1 = deletetime
        if time1 == 0 then
            time1 = select(2, m:LookupSequence(sequence))
        end

        timer.Simple(0.9, function()
            if !IsValid(b) or !IsValid(ply) then return end

            net.Start("nZR.InfilCrewCam")
            net.WriteEntity(b)
            net.Send(ply)
        end)

        timer.Simple(time1, function()
            if !IsValid(m) then return end

            local ply1 = m.Player
            if IsValid(ply1) then
                ply1:Freeze(false)
                ply1:SetNoDraw(false)
                ply1:GodDisable()
                ply1:SetPos(self:LocalToWorld(pos-self.InfilType.offset))
                ply1:SetEyeAngles(self:GetAngles()+ang)
                ply1.UsingInfil = false
                if IsValid(ply.PreviousInfilWeapon) then
                    ply1:SelectWeapon(ply1.PreviousInfilWeapon:GetClass())
                    ply1.PreviousInfilWeapon = nil
                end
            end

            m:Remove()
        end)

        return m, b
    end

    function ENT:Think()
        if self.DriveAway then
            self.DriveVel = self.DriveVel + FrameTime()*2
            self:SetPos(self:GetPos()+self:GetForward()*self.DriveVel)
        end

        self:NextThink(CurTime())
        return true
    end
else
    net.Receive("nZR.InfilCrewCam", function()
        local ent = net.ReadEntity()
        hook.Add("CalcView", "InfilCrewCam", function(ply, pos, angles, fov)
            if IsValid(ent) then
                --[[local veh = ent:GetNWEntity('Vehicle')
                if IsValid(veh) then
                    print( ent:GetPos()-veh:GetPos() )
                end]]--

                RunConsoleCommand("cl_drawhud", "0")

                ent:ManipulateBoneScale(ent:LookupBone("ValveBiped.Bip01_Head1"), Vector(0,0,0))
                pos = ent:GetAttachment(ent:LookupAttachment("eyes")).Pos
                angles = ent:GetAttachment(ent:LookupAttachment("eyes")).Ang
                angles.z = 0
                local view = {
                    origin = pos,
                    angles = angles,
                    fov = fov,
                    drawviewer = false
                }

                return view
            else
                hook.Remove("CalcView", "InfilCrewCam")
                RunConsoleCommand("cl_drawhud", "1")
            end
        end)
    end)
end