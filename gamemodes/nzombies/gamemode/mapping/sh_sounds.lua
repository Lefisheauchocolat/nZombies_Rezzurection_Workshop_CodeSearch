if (SERVER) then
    util.AddNetworkString("nzSounds.PlaySound")
    util.AddNetworkString("nzSounds.RefreshSounds")
    util.AddNetworkString("nzSounds.PlaySoundString")

    hook.Add("PlayerSpawn", "NZForceSyncSounds", function(ply)
        net.Start("nzSounds.RefreshSounds")
        net.Send(ply)
    end)
end

nzSounds = nzSounds or AddNZModule("Sounds")
nzSounds.struct = { -- For use with 'data' when creating config menu options
    "roundstartsnd", 
    "roundendsnd", 
    "specialroundstartsnd", 
    "specialroundendsnd", 
    "dogroundsnd", 

    "gameendsnd", -- main event sounds
    "spawnsnd", 
    "grabsnd", 
    "instakillsnd", 
    "firesalesnd", 
    "deathmachinesnd", 
    "carpentersnd", 
    "nukesnd", 
    "doublepointssnd", 
    "maxammosnd", 
    "zombiebloodsnd", -- power up sounds
    "boxshakesnd", 
    "boxpoofsnd", 
    "boxlaughsnd", 
    "boxbyesnd", 
    "boxjinglesnd", 
    "boxopensnd", 
    "boxclosesnd",	-- mystery box sounds
	"eesong",
    "papshot", 
    "bonuspointssnd", 
    "bonfiresalesnd", 
    "firstroundstartsnd", 
    "powloopsnd",
    "timewarpsnd",
	"berzerksnd",
	"infiniteammosnd",
	"godmodesnd",
	"quickfootsnd",
	"brokenbottlesnd",
	"perkbottlesnd",
	"packapunchsnd",
	"randomweaponsnd",		   
	"purchasesnd",
	"poweronsnd",
	--"underscoresong",
	--"specunderscoresong",
    "whoswholoopersnd", 
    "revivalstingersnd",
	"radio",
}

nzSounds.Sounds = {}
nzSounds.Sounds.Custom = {}
nzSounds.Sounds.Default = {}

nzSounds.Sounds.Default.RoundStart = "nz_moo/round_and_eesongs/waw/classic_redone/start3.mp3"
nzSounds.Sounds.Default.RoundEnd = "nz_moo/round_and_eesongs/waw/classic_redone/end3.mp3"
nzSounds.Sounds.Default.SpecialRoundStart = "nz_moo/round_and_eesongs/waw/classic_redone/special_start.mp3"
nzSounds.Sounds.Default.SpecialRoundEnd = "nz_moo/round_and_eesongs/waw/classic_redone/special_end.mp3"
nzSounds.Sounds.Default.DogRound = "nz/round/dog_start.wav"
nzSounds.Sounds.Default.GameEnd = "nz/round/game_over_4.mp3"
nzSounds.Sounds.Default.Spawn = "nz/powerups/power_up_spawn.wav"
nzSounds.Sounds.Default.Grab = "nz/powerups/power_up_grab.wav"
nzSounds.Sounds.Default.InstaKill = "nz/powerups/insta_kill.mp3"
nzSounds.Sounds.Default.FireSale = "nz/powerups/fire_sale_announcer.wav"
nzSounds.Sounds.Default.DeathMachine = "nz/powerups/deathmachine.mp3"
nzSounds.Sounds.Default.Carpenter = "nz/powerups/carpenter.wav"
nzSounds.Sounds.Default.Nuke = "nz/powerups/nuke.wav"
nzSounds.Sounds.Default.DoublePoints = "nz/powerups/double_points.mp3"
nzSounds.Sounds.Default.MaxAmmo = "nz/powerups/max_ammo.mp3"
nzSounds.Sounds.Default.ZombieBlood = "nz/powerups/zombie_blood.wav"
nzSounds.Sounds.Default.Shake = "nzr/announcer/mysterybox/box_spinning.wav"
nzSounds.Sounds.Default.Poof = "nz/randombox/poof.wav"
nzSounds.Sounds.Default.Laugh = "nz/randombox/teddy_bear_laugh.wav"
nzSounds.Sounds.Default.Bye = "nz/randombox/Announcer_Teddy_Zombies.wav"
nzSounds.Sounds.Default.Jingle = "nz/randombox/random_box_jingle.wav"
nzSounds.Sounds.Default.Open = "nzr/announcer/mysterybox/box_open.mp3"
nzSounds.Sounds.Default.Close = "nzr/announcer/mysterybox/box_close.mp3"
nzSounds.Sounds.Default.Music = ""
nzSounds.Sounds.Default.UpgradedShoot = "nz/effects/pap_shoot_glock20.wav"
nzSounds.Sounds.Default.BonusPoints = "nz_moo/announcer/sammantha/announce_bonus.mp3"
nzSounds.Sounds.Default.BonFireSale = "nz_moo/announcer/sammantha/announce_bonsale.mp3"
nzSounds.Sounds.Default.FirstRoundStart = "nz_moo/round_and_eesongs/waw/classic_redone/start3.mp3"
nzSounds.Sounds.Default.Loop = "nz_moo/powerups/powerup_lp_classic.wav"
nzSounds.Sounds.Default.TimeWarp = "powerups/timewarp.wav"
nzSounds.Sounds.Default.Berzerk = "powerups/berzerk_pickup.wav"
nzSounds.Sounds.Default.InfiniteAmmo = "powerups/infiniteammo.mp3"
nzSounds.Sounds.Default.Invulnerability = "powerups/godmode.mp3"
nzSounds.Sounds.Default.QuickFoot = "powerups/quickfoot.mp3"
nzSounds.Sounds.Default.BrokenBottle = "powerups/brokenbottle.mp3"
nzSounds.Sounds.Default.PerkBottle = "powerups/randomperk.mp3"
nzSounds.Sounds.Default.PackAPunch = "powerups/freepap.mp3"
nzSounds.Sounds.Default.RandomWeapon = "powerups/randomweapon.mp3"															  
nzSounds.Sounds.Default.Purchase = "nz_moo/effects/purchases/buy_classic.mp3"
nzSounds.Sounds.Default.Poweron = "nz/machines/power_up.wav"
nzSounds.Sounds.Default.UnderScore = ""
nzSounds.Sounds.Default.SpecialUnderScore = ""
nzSounds.Sounds.Default.WhosWhoLooper = "nzr/2022/perks/chuggabud/ww_looper.wav"
nzSounds.Sounds.Default.RevivalStinger = "nz_moo/effects/revive/zmb_revive_music_03_lr.mp3"


function nzSounds:RefreshSounds()
    
	nzSounds.Sounds.Custom.RoundStart = nzMapping.Settings.roundstartsnd
    nzSounds.Sounds.Custom.RoundEnd = nzMapping.Settings.roundendsnd
    nzSounds.Sounds.Custom.SpecialRoundStart = nzMapping.Settings.specialroundstartsnd
    nzSounds.Sounds.Custom.SpecialRoundEnd = nzMapping.Settings.specialroundendsnd
    nzSounds.Sounds.Custom.DogRound = nzMapping.Settings.dogroundsnd
    nzSounds.Sounds.Custom.GameEnd = nzMapping.Settings.gameendsnd
    nzSounds.Sounds.Custom.Spawn = nzMapping.Settings.spawnsnd
    nzSounds.Sounds.Custom.Grab = nzMapping.Settings.grabsnd
    nzSounds.Sounds.Custom.InstaKill = nzMapping.Settings.instakillsnd
    nzSounds.Sounds.Custom.FireSale = nzMapping.Settings.firesalesnd
    nzSounds.Sounds.Custom.DeathMachine = nzMapping.Settings.deathmachinesnd
    nzSounds.Sounds.Custom.Carpenter = nzMapping.Settings.carpentersnd
    nzSounds.Sounds.Custom.Nuke = nzMapping.Settings.nukesnd
    nzSounds.Sounds.Custom.DoublePoints = nzMapping.Settings.doublepointssnd
    nzSounds.Sounds.Custom.MaxAmmo = nzMapping.Settings.maxammosnd
    nzSounds.Sounds.Custom.ZombieBlood = nzMapping.Settings.zombiebloodsnd
    nzSounds.Sounds.Custom.Shake = nzMapping.Settings.boxshakesnd
    nzSounds.Sounds.Custom.Poof = nzMapping.Settings.boxpoofsnd
    nzSounds.Sounds.Custom.Laugh = nzMapping.Settings.boxlaughsnd
    nzSounds.Sounds.Custom.Bye = nzMapping.Settings.boxbyesnd
    nzSounds.Sounds.Custom.Jingle = nzMapping.Settings.boxjinglesnd
    nzSounds.Sounds.Custom.Open = nzMapping.Settings.boxopensnd
    nzSounds.Sounds.Custom.Close = nzMapping.Settings.boxclosesnd
	nzSounds.Sounds.Custom.Music = nzMapping.Settings.eesong
	nzSounds.Sounds.Custom.UpgradedShoot = nzMapping.Settings.papshot
    nzSounds.Sounds.Custom.BonusPoints = nzMapping.Settings.bonuspointssnd
    nzSounds.Sounds.Custom.BonFireSale = nzMapping.Settings.bonfiresalesnd
    nzSounds.Sounds.Custom.FirstRoundStart = nzMapping.Settings.firstroundstartsnd
    nzSounds.Sounds.Custom.Loop = nzMapping.Settings.powloopsnd
    nzSounds.Sounds.Custom.TimeWarp = nzMapping.Settings.timewarpsnd
	nzSounds.Sounds.Custom.Berzerk = nzMapping.Settings.berzerksnd
	nzSounds.Sounds.Custom.InfiniteAmmo = nzMapping.Settings.infiniteammosnd
	nzSounds.Sounds.Custom.Invulnerability = nzMapping.Settings.godmodesnd
	nzSounds.Sounds.Custom.QuickFoot = nzMapping.Settings.quickfootsnd
	nzSounds.Sounds.Custom.BrokenBottle = nzMapping.Settings.brokenbottlesnd
	nzSounds.Sounds.Custom.PerkBottle = nzMapping.Settings.perkbottlesnd
	nzSounds.Sounds.Custom.PackAPunch = nzMapping.Settings.packapunchsnd
	nzSounds.Sounds.Custom.RandomWeapon = nzMapping.Settings.randomweaponsnd													 
	nzSounds.Sounds.Custom.UnderScore = nzMapping.Settings.underscoresong
	nzSounds.Sounds.Custom.SpecialUnderScore = nzMapping.Settings.specunderscoresong
	nzSounds.Sounds.Custom.Purchase = nzMapping.Settings.purchasesnd
	nzSounds.Sounds.Custom.Poweron = nzMapping.Settings.poweronsnd
    nzSounds.Sounds.Custom.WhosWhoLooper = nzMapping.Settings.whoswholoopersnd
    nzSounds.Sounds.Custom.RevivalStinger = nzMapping.Settings.revivalstingersnd
    if (!table.IsEmpty(nzMapping.Settings) and table.IsEmpty(nzSounds.Sounds.Custom)) then
        nzSounds.Sounds.Custom = table.Copy(nzSounds.Sounds.Default)
    end
    
    if (SERVER) then
        net.Start("nzSounds.RefreshSounds")
        net.Broadcast()
    end
end 
nzSounds:RefreshSounds()

function nzSounds:GetSound(event, id)
    local snd = !nzSounds.Sounds.Custom[event] and nzSounds.Sounds.Default[event] or nzSounds.Sounds.Custom[event]

	if (istable(snd)) then
		if id and snd[id] then
			snd = snd[id]
    	else
			snd = table.Random(snd) -- ^ is a table of sounds, but we can only play 1
		end
	end

    if (SERVER) then
        if (!nzSounds.Sounds.Default[event]) then 
            if (isstring(event)) then
                ServerLog("[nZombies] Tried to play an invalid Sound Event! (" .. event .. ")\n")
            else
                ServerLog("[nZombies] Tried to play an invalid Sound Event!\n")
            end

            snd = nzSounds:GetDefaultSound(event)
        end

        if snd == nil then return nzSounds:GetDefaultSound(event) end
        -- if (!file.Exists("sound/" .. snd, "GAME")) then
        --     ServerLog("[nZombies] Tried to play an invalid sound file (" .. snd .. ") for Event: " .. event .. "\n")
        -- end
    end

    if (CLIENT) then
        -- FALLBACK in case for some reason the client has not gotten their sounds to refresh yet
        if (nzSounds and nzSounds.Sounds and table.IsEmpty(nzSounds.Sounds.Custom)) then    
            if (!table.IsEmpty(nzMapping.Settings)) then -- Stops endless loop from non-submitted configs
                nzSounds:RefreshSounds()
                snd = nzSounds:GetSound(event)
            end
        end

        if (snd == nil or !nzSounds.Sounds.Default[event]) then 
            if (!nzSounds.Sounds.Default[event]) then
                if (isstring(event)) then
                    print("[nZombies] Tried to play an invalid Sound Event! (" .. event .. ")")
                else
                    print("[nZombies] Tried to play an invalid Sound Event!")
                end
            end 

            snd = nzSounds:GetDefaultSound(event)
        end  

        if snd == nil then return end

        if (snd and !file.Exists("sound/" .. snd, "GAME")) then
            print("[nZombies] Tried to play a sound file you don't have! (" .. snd .. ") for Event: " .. event)
            snd = nzSounds:GetDefaultSound(event)
        end
    end

    return snd
end

function nzSounds:GetDefaultSound(event)
    return nzSounds.Sounds.Default[event]
end

function nzSounds:PlayEnt(event, ent, noOverlap) -- Plays on an entity (and must be close to actually hear it)
    local snd = nzSounds:GetSound(event)
    if (snd == nil || !isstring(snd)) then return end

    if (IsValid(ent)) then
        if (noOverlap) then
            ent:StopSound(snd)
        end

        ent:EmitSound(snd)
    end
end

function nzSounds:Play(event, ply, id) -- Plays everywhere either for 1 or all players
	local snd = nil

	if id then
		snd = nzSounds:GetSound(event, id)
	else
		snd = nzSounds:GetSound(event)
	end

	if (snd == nil || !isstring(snd)) then return end

    if (SERVER) then
        net.Start("nzSounds.PlaySound")
        net.WriteString(event)
        if !ply then
            net.Broadcast()
        else 
            net.Send(ply)
        end
    end

    if (CLIENT) then
        if (event == "GameEnd") then
            nzSounds:StopAll()
        else
            nzSounds:Stop(event)
        end

        surface.PlaySound(snd)
    end
end

function nzSounds:PlayFile(snd, ply) //alt to play sound file directly on client
	if (snd == nil || !isstring(snd)) then return end
	if not file.Exists("sound/"..snd, "GAME") then return end

	if (SERVER) then
		net.Start("nzSounds.PlaySoundString")
		net.WriteString(snd)
		if !ply then
			net.Broadcast()
		elseif IsValid(ply) then
			net.Send(ply)
		end
	end

	if (CLIENT) then
		LocalPlayer():StopSound(snd)
		surface.PlaySound(snd)
	end
end

if (CLIENT) then
    function nzSounds:Stop(event) -- Stops all sounds bound to an event
        if (!IsValid(LocalPlayer())) then return end -- The client has not fully loaded yet, LocalPlayer() does not exist.
        
        local notValid = !nzSounds.Sounds.Custom[event] or table.IsEmpty(nzSounds.Sounds.Custom)
        local snds = notValid and nzSounds.Sounds.Default[event] or nzSounds.Sounds.Custom[event]

        if (istable(snds)) then
            for k,v in pairs(snds) do
                v = !file.Exists("sound/" .. v, "GAME") and nzSounds.Sounds.Default[event] or v
                LocalPlayer():StopSound(v)
            end
        else
            LocalPlayer():StopSound(snds)
        end
    end

	function nzSounds:StopAll() -- Stops ALL event sounds
		for k,v in pairs(nzSounds.Sounds.Default) do
			nzSounds:Stop(k)
		end
	end

	net.Receive("nzSounds.PlaySound", function()
		local event = net.ReadString()
		nzSounds:Play(event, nil)
	end)

	net.Receive("nzSounds.PlaySoundString", function()
		local snd = net.ReadString()
		nzSounds:PlayFile(snd)
	end)

	net.Receive("nzSounds.RefreshSounds", function()
		nzSounds:RefreshSounds()  
		nzSounds:StopAll()
	end)

	hook.Add("InitPostEntity", "NZSyncCustomSounds", function()
		timer.Simple(2, function()
			nzSounds:RefreshSounds()  
		end)
	end)
end

//credit yobson1 <https://github.com/yobson1/glua-soundduration>
//credit ddsol <https://github.com/ddsol/mp3-duration>

--[[-------------------------------------------------------------------------
MIT License

Copyright (c) 2020 yobson1

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
---------------------------------------------------------------------------]]

local debug = false
local sprint = debug and print or function() end

local MP3Data = {
	versions = {"2.5", "x", "2", "1"},
	layers = {"x", "3", "2", "1"},
	bitrates = {
		["V1Lx"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		["V1L1"] = {0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448},
		["V1L2"] = {0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 384},
		["V1L3"] = {0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320},
		["V2Lx"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		["V2L1"] = {0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 256, 288},
		["V2L2"] = {0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160},
		["V2L3"] = {0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160},
		["VxLx"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		["VxL1"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		["VxL2"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		["VxL3"] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	},
	sampleRates = {
		["x"] = {0, 0, 0},
		["1"] = {44100, 48000, 32000},
		["2"] = {22050, 24000, 16000},
		["2.5"] = {11025, 12000, 8000}
	},
	samples = {
		x = {
			["x"] = 0,
			["1"] = 0,
			["2"] = 0,
			["3"] = 0
		},
		["1"] = {
			["x"] = 0,
			["1"] = 384,
			["2"] = 1152,
			["3"] = 1152
		},
		["2"] = {
			["x"] = 0,
			["1"] = 384,
			["2"] = 1152,
			["3"] = 576
		}
	}
}

local function MP3FrameSize(samples, layer, bitrate, sampleRate, paddingBit)
	local size

	if layer == 1 then
		size = math.floor(((samples * bitrate * 125) / sampleRate) + paddingBit * 4)
	else
		size = math.floor(((samples * bitrate * 125) / sampleRate) + paddingBit)
	end

	return (size == size and size < math.huge) and size or 0
end

local function ParseMP3FrameHeader(buffer)
	buffer:Skip(1)
	local b1, b2 = buffer:ReadByte(), buffer:ReadByte()

	-- Get the version
	local versionBits = bit.rshift(bit.band(b1, 0x18), 3)
	local version = MP3Data.versions[versionBits + 1]
	local simpleVersion = version == "2.5" and "2" or version

	-- Get the layer
	local layerBits = bit.rshift(bit.band(b1, 0x06), 1)
	local layer = MP3Data.layers[layerBits + 1]

	-- Get the bitrate
	local bitrateKey = "V" .. simpleVersion .. "L" .. layer
	local bitrateIndex = bit.rshift(bit.band(b2, 0xf0), 4)
	local bitrate = MP3Data.bitrates[bitrateKey][bitrateIndex + 1] or 0

	-- Get the sample rate
	local sampleRateIdx = bit.rshift(bit.band(b2, 0x0c), 2)
	local sampleRate = MP3Data.sampleRates[version][sampleRateIdx + 1] or 0

	local sample = MP3Data.samples[simpleVersion][layer]

	-- Get padding bit
	local paddingBit = bit.rshift(bit.band(b2, 0x02), 1)

	-- Seek back to where we were
	buffer:Skip(-3)

	return {
		bitrate = bitrate,
		sampleRate = sampleRate,
		frameSize = MP3FrameSize(sample, layer, bitrate, sampleRate, paddingBit),
		samples = sample
	}
end

local soundDecoders = {
	mp3 = function(buffer)
		local duration = 0

		-- Check for ID3v2 metadata and skip it if present
		if buffer:Read(3) == "ID3" then
			//sprint("ID3v2 metadata detected")

			-- Skip the version and revision
			buffer:Skip(2)

			-- Read the flags byte
			local ID3Flags = buffer:ReadByte()

			-- Check for footer flag
			local footerSize = bit.band(ID3Flags, 0x10) == 0x10 and 10 or 0

			-- Calculate total ID3v2 size
			local z0, z1, z2, z3 = buffer:ReadByte(), buffer:ReadByte(), buffer:ReadByte(), buffer:ReadByte()
			local ID3Size = 10 + ((bit.band(z0, 0x7f) * 2097152) + (bit.band(z1, 0x7f) * 16384) + (bit.band(z2, 0x7f) * 128) + bit.band(z3, 0x7f)) + footerSize
			//sprint("Total ID3v2 size: ", ID3Size, " bytes")

			-- Skip the total ID3v2 size - 10 since we already seeked past the first 10 bytes, which is the header
			buffer:Skip(ID3Size - 10)
		else
			-- Go back to the start of the buffer
			buffer:Skip(-buffer:Tell())
		end

		local prevTell = buffer:Tell()
		while buffer:Tell() < buffer:Size() - 10 do
			-- Read the next 4 bytes from the buffer
			local b1, b2, b3, b4 = buffer:ReadByte(), buffer:ReadByte(), buffer:ReadByte(), buffer:ReadByte()

			-- Sometimes it doesn't seek by 4 bytes properly?
			buffer:Seek(prevTell + 4)

			-- Looking for 1111 1111 111 (frame synchronization bits)
			if b1 == 0xff and bit.band(b2, 0xe0) == 0xe0 then
				-- Go back to the start of the header
				buffer:Skip(-4)

				-- Parse the header and add to the duration of this frame
				local frameHeader = ParseMP3FrameHeader(buffer)
				//sprint("Found next MP3 frame header @ ", buffer:Tell(), ":", frameHeader.frameSize)

				if frameHeader.frameSize > 0 and frameHeader.samples > 0 then
					buffer:Skip(frameHeader.frameSize)
					duration = duration + (frameHeader.samples / frameHeader.sampleRate)
				else
					buffer:Skip(1)
				end
			-- Skip ID3v1 metadata
			elseif b1 == 0x54 and b2 == 0x41 and b3 == 0x47 then -- "TAG"
				if b4 == 0x2b then -- "+"
					//sprint("Skipping ID3v1+ metadata")
					buffer:Skip(227 - 4)
				else
					//sprint("Skipping ID3v1 metadata")
					buffer:Skip(128 - 4)
				end
			else
				-- Skip ahead a total of 1 byte
				buffer:Skip(-3)
			end

			prevTell = buffer:Tell()
		end

		return duration
	end,
	-- Reference: http://soundfile.sapp.org/doc/WaveFormat/
	wav = function(buffer)
		-- Get channels
		buffer:Seek(22)
		local channels = buffer:ReadShort()

		-- Get sample rate
		local sampleRate = buffer:ReadLong()

		-- Get samples
		buffer:Seek(34)
		local bitsPerSample = buffer:ReadShort()
		local divisor = bitsPerSample / 8
		local samples = (buffer:Size() - 44) / divisor

		return samples / sampleRate / channels
	end
}

//i think with this, finding sound duration requires reading the entire file
//so if called clientside (or in singleplayer) the client will temporarily freeze
//the duration of the freeze depends on filesize (i think), a 9mb mp3 (~4min) is ~200ms
//added a cache to mitigate this after first call

local duration_cache = {}
function nzSounds:SoundDuration(soundPath) //ONLY WORKS FOR .WAV AND .MP3, will return 0 otherwise
	if duration_cache[soundPath] then return duration_cache[soundPath] end

	local extension = soundPath:GetExtensionFromFilename()
	if extension and soundDecoders[extension] then
		local buffer = file.Open(soundPath, "r", "GAME")
		local result = soundDecoders[extension](buffer)
		buffer:Close()

		if !duration_cache[soundPath] then
			duration_cache[soundPath] = result
		end

		return duration_cache[soundPath]
	end

	return 0
end