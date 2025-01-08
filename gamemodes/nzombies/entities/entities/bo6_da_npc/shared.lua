AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true

local function playRandomSound(ent, path)
    local files, _ = file.Find("sound/" .. path .. "/*", "GAME")
    if not files or #files == 0 then return end

    local randomSound = path .. "/" .. files[math.random(#files)]
    EmitSound(randomSound, ent:GetBonePosition(0), 0, CHAN_AUTO, 70)
end

local function decalBlood(pos, chance)
    if not chance or chance < math.random(1,100) then return end
    util.Decal("Blood", pos+Vector(0,0,32), pos-Vector(math.random(-20,20),math.random(-20,20),100))
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/bo6/hari/da_anims.mdl")
    end

    function ENT:SetBonemerge(ent)
        local bm = ents.Create("base_anim")
        bm:SetModel(ent:GetModel())
        bm:SetSkin(ent:GetSkin())
        bm:SetColor(ent:GetColor())
        for i = 0, ent:GetNumBodyGroups() - 1 do
            local bg = ent:GetBodygroup(i)
            self:SetBodygroup(i, bg)
        end
        bm:SetPos(self:GetPos())
        bm:SetParent(self)
        bm:AddEffects(1)
        bm:Spawn()
        self:DeleteOnRemove(bm)
        self:SetNoDraw(true)
    end

    function ENT:PlayDeathAnim(anim, tab, ent)
        if self.IsZombie then
            self:ResetSequence(string.format(anim, "zombie"))
            timer.Simple(tab.dur, function()
                if !IsValid(self) or !IsValid(ent) then return end
                local pos, ang = self:GetBonePosition(self:LookupBone("j_ankle_ri"))
                ent:SetPos(pos)
                ent:SetAngles(Angle(0,ang.y-90,0))
            end)
            SafeRemoveEntityDelayed(self, tab.dur)
        else
            self:ResetSequence(string.format(anim, "human"))
            for k, v in pairs(tab.eff) do
                timer.Simple(k, function()
                    if !IsValid(self) then return end
                    if v == "fear" then
                        playRandomSound(self, "bo6/da/fear")
                    elseif v == "pain" then
                        playRandomSound(self, "bo6/da/pain")
                    elseif v == "touch" then
                        playRandomSound(self, "bo6/da/touch")
                    elseif v == "drop" then
                        playRandomSound(self, "bo6/da/drop")
                    elseif v == "bite" then
                        for i=1,80 do
                            timer.Simple(i/10, function()
                                if !IsValid(self) then return end
                                local ef = EffectData()
                                local att = self:GetAttachment(self:LookupAttachment("eyes"))
                                if not att then return end
                                local pos = att.Pos+att.Ang:Forward()*math.random(-8,8)+att.Ang:Up()*math.random(-8,-4)+att.Ang:Right()*math.random(-8,8)
                                ef:SetOrigin(pos)
                                util.Effect("BloodImpact", ef)
                                decalBlood(pos, 10)
                            end)
                        end
                        playRandomSound(self, "bo6/da/bite")
                    end
                end)
            end
            SafeRemoveEntityDelayed(self, 60)
        end
    end

    function ENT:Think()
        self:NextThink(CurTime())
        return true
    end 
end
