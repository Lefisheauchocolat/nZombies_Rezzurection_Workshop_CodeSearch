AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Hacker Device"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_hacker.png", "smooth unlitgeneric")

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()
