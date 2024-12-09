-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzSettings = nzSettings or {}
nzSettings.ConfigSettings = nzSettings.ConfigSettings or {}

function nzSettings:SetSimpleSetting(name, value)
    nzSettings.ConfigSettings[name] = value
    if SERVER then
        nzSettings:SendToClient()
    else
        nzSettings:SendToServer(name, value)
    end
end

function nzSettings:GetSimpleSetting(name, value)
    local val = nzSettings.ConfigSettings[name]
    if val == nil then
        val = value
    end
    return val
end

if SERVER then
    util.AddNetworkString("nZr.HariSettings")
    net.Receive("nZr.HariSettings", function()
        if not nzRound:InState( ROUND_CREATE ) then return end
        local name = net.ReadString()
        local value = net.ReadTable()[1]
        nzSettings:SetSimpleSetting(name, value)
    end)

    function nzSettings:SendToClient(ply)
        net.Start("nZr.HariSettings")
        net.WriteTable(nzSettings.ConfigSettings)
        if ply then
            net.Send(ply)
        else
            net.Broadcast()
        end
    end

    hook.Add("PlayerInitialSpawn", "nZr_SyncSettingsOnJoin", function(ply)
        nzSettings:SendToClient(ply)
    end)

    hook.Call("PreConfigLoad", "nZr_ClearConfigSettings", function()
        nzSettings.ConfigSettings = {}
    end)

    nzMapping:AddSaveModule("HariSettings", {
		savefunc = function()
			local tab = nzSettings.ConfigSettings
			return tab
		end,
		loadfunc = function(data)
            nzSettings.ConfigSettings = {}
            for name, value in pairs(data) do
                nzSettings:SetSimpleSetting(name, value)
            end
		end,
		cleanents = {},
	})
else
    local elementsTab = {}

    function nzSettings:SendToServer(name, value)
        if not nzRound:InState( ROUND_CREATE ) then return end
        net.Start("nZr.HariSettings")
        net.WriteString(name)
        net.WriteTable({value})
        net.SendToServer()
    end

    function nzSettings:SyncValueToElement(name, element)
        elementsTab[name] = element
    end

    net.Receive("nZr.HariSettings", function()
        local tab = net.ReadTable()
        print(tab)
        if #elementsTab > 0 then
            for name, value in pairs(tab) do
                if not elementsTab[name] then continue end
                elementsTab[name]:SetValue(value)
                LocalPlayer():ChatPrint(name.."  "..tostring(value))
            end
        end
        nzSettings.ConfigSettings = tab
    end)
end