-- CODE BY REIKOOW THANK YOU SO MUCH - latte 

nzKeyConfig = nzKeyConfig or {}

nzKeyConfig.keyDisplayNames = {
    -- Numbers
    [KEY_0] = "0", [KEY_1] = "1", [KEY_2] = "2", [KEY_3] = "3", [KEY_4] = "4",
    [KEY_5] = "5", [KEY_6] = "6", [KEY_7] = "7", [KEY_8] = "8", [KEY_9] = "9",
    
    -- Letters
    [KEY_A] = "A", [KEY_B] = "B", [KEY_C] = "C", [KEY_D] = "D", [KEY_E] = "E",
    [KEY_F] = "F", [KEY_G] = "G", [KEY_H] = "H", [KEY_I] = "I", [KEY_J] = "J",
    [KEY_K] = "K", [KEY_L] = "L", [KEY_M] = "M", [KEY_N] = "N", [KEY_O] = "O",
    [KEY_P] = "P", [KEY_Q] = "Q", [KEY_R] = "R", [KEY_S] = "S", [KEY_T] = "T",
    [KEY_U] = "U", [KEY_V] = "V", [KEY_W] = "W", [KEY_X] = "X", [KEY_Y] = "Y",
    [KEY_Z] = "Z",

    -- Function Keys
    [KEY_F1] = "F1", [KEY_F2] = "F2", [KEY_F3] = "F3", [KEY_F4] = "F4",
    [KEY_F5] = "F5", [KEY_F6] = "F6", [KEY_F7] = "F7", [KEY_F8] = "F8",
    [KEY_F9] = "F9", [KEY_F10] = "F10", [KEY_F11] = "F11", [KEY_F12] = "F12",
    
    -- Modifiers
    [KEY_LSHIFT] = "LSHIFT", [KEY_RSHIFT] = "RSHIFT",
    [KEY_LALT] = "LALT", [KEY_RALT] = "RALT",
    [KEY_LCONTROL] = "LCTRL", [KEY_RCONTROL] = "RCTRL",
    [KEY_LWIN] = "LWIN", [KEY_RWIN] = "RWIN",
    
    -- Special Keys
    [KEY_SPACE] = "SPACE", [KEY_TAB] = "TAB", [KEY_ENTER] = "ENTER",
    [KEY_BACKSPACE] = "BACKSPACE", [KEY_ESCAPE] = "ESC",
    [KEY_INSERT] = "INSERT", [KEY_DELETE] = "DELETE",
    [KEY_HOME] = "HOME", [KEY_END] = "END",
    [KEY_PAGEUP] = "PAGE UP", [KEY_PAGEDOWN] = "PAGE DOWN",
    [KEY_CAPSLOCK] = "CAPSLOCK", [KEY_NUMLOCK] = "NUMLOCK",
    [KEY_SCROLLLOCK] = "SCROLLLOCK",
    
    -- Arrow Keys
    [KEY_UP] = "UP", [KEY_DOWN] = "DOWN", [KEY_LEFT] = "LEFT", [KEY_RIGHT] = "RIGHT",
    
    -- Numpad
    [KEY_PAD_0] = "NUMPAD 0", [KEY_PAD_1] = "NUMPAD 1", [KEY_PAD_2] = "NUMPAD 2",
    [KEY_PAD_3] = "NUMPAD 3", [KEY_PAD_4] = "NUMPAD 4", [KEY_PAD_5] = "NUMPAD 5",
    [KEY_PAD_6] = "NUMPAD 6", [KEY_PAD_7] = "NUMPAD 7", [KEY_PAD_8] = "NUMPAD 8",
    [KEY_PAD_9] = "NUMPAD 9", [KEY_PAD_DIVIDE] = "NUMPAD /",
    [KEY_PAD_MULTIPLY] = "NUMPAD *", [KEY_PAD_MINUS] = "NUMPAD -",
    [KEY_PAD_PLUS] = "NUMPAD +", [KEY_PAD_ENTER] = "NUMPAD ENTER",
    [KEY_PAD_DECIMAL] = "NUMPAD .",
    
    -- Symbols
    [KEY_MINUS] = "-", [KEY_EQUAL] = "=",
    [KEY_LBRACKET] = "[", [KEY_RBRACKET] = "]",
    [KEY_SEMICOLON] = ";", [KEY_APOSTROPHE] = "'",
    [KEY_COMMA] = ",", [KEY_PERIOD] = ".", [KEY_SLASH] = "/",
    [KEY_BACKSLASH] = "\\",
    
    -- Mouse Buttons
    [MOUSE_LEFT] = "MOUSE 1", [MOUSE_RIGHT] = "MOUSE 2", [MOUSE_MIDDLE] = "MOUSE 3",
    [MOUSE_4] = "MOUSE 4", [MOUSE_5] = "MOUSE 5",
}

nzKeyConfig.theOtherNZkeys = {
    ["gum"] = KEY_5,
    ["slide"] = KEY_LCONTROL,
    ["dtp"] = KEY_LALT,
    ["settings"] = KEY_F1,
    ["voteyes"] = KEY_9,
    ["voteno"] = KEY_0,
    ["armor"] = KEY_H,
}

nzKeyConfig.customText = {
    ["gum"] = "Use Gobblegum (POUF!)",
    ["slide"] = "Slide (Must be same as crouch bind)",
    ["dtp"] = "Dolphin Dive",
    ["settings"] = "nZ Menu",
    ["voteyes"] = "Vote Yes",
    ["voteno"] = "Vote No",
    ["armor"] = "Insert Armor",   
}

function nzKeyConfig:getAllBinds()
    local mergedTable = {}
    for category, key in pairs(nzSpecialWeapons.Keys) do
        mergedTable[category] = key
    end
    for category, key in pairs(nzKeyConfig.theOtherNZkeys) do
        mergedTable[category] = key
    end
    return mergedTable
end

if (file.Exists("nzKeybindSave.json", "DATA")) then
    print("[nZombies Keybinds] SAVE FILE FOR BINDS FOUND!!")
    local savedTable = util.JSONToTable( file.Read("nzKeybindSave.json", "DATA"), false, true )
    
    for k, v in pairs(savedTable) do
        RunConsoleCommand("nz_key_" .. string.lower(k), v)
        print("[nZombies Keybinds] Binding from saved file: "..k)
    end
    
end

concommand.Add("nz_save_key", function(ply, cmd, args)
    local saveTable = {}

	for k,_ in pairs(nzKeyConfig:getAllBinds()) do
        saveTable[k] = GetConVar("nz_key_"..k):GetInt() or nil
    end

    file.Write("nzKeybindSave.json", util.TableToJSON(saveTable))
    print("[nZombies Keybinds] Binds saved successfully (nzKeybindSave.json)")
end)

-- ⠀⠀⠀⠀⠀⢀⡴⡒⠒⠲⠶⠒⠒⠛⠓⠲⠶⠒⠒⠚⠓⠶⠶⠤⠤⠤⠶⠶⠦⠤⠤⠴⠶⠦⠤⠤⠤⠤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⢠⠟⠀⢱⠀⠀⠀⢀⠴⠒⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠤⢤⠈⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⣠⠶⠋⣀⡀⠸⡆⠀⠀⢏⠀⠀⡠⠃⢰⣄⠀⣸⣇⣀⣴⠇⠀⠀⠀⣶⡀⢀⣿⠀⠀⣤⠀⠸⠤⠊⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⣠⠏⠀⡜⠁⢸⠀⠙⡄⠀⠀⢉⢉⠀⠀⡠⠛⠉⠉⠉⠉⠉⠳⣄⢀⠴⠊⠉⠉⠉⠉⠙⢧⡀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⣾⠁⠀⠀⢇⠀⡼⠀⠀⢱⠀⠀⠉⠁⠀⡞⠀⠀⠀⠀⠀⡠⠤⣀⠈⡏⠀⢀⣀⣀⡀⠀⠀⠀⢱⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⢛⡗
-- ⣷⡀⠀⠀⠈⠙⠀⠀⠀⢸⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⡎⣴⣿⡎⡆⠸⠀⡏⣶⣷⣽⡄⠀⠀⠀⡇⠀⠀⢀⡏⠀⠀⠀⠀⠀⠀⠀⠀⡼⢁⡼⠋⠀
-- ⠈⢳⡄⠀⠀⠀⣀⡀⠀⠘⡆⠀⠀⠀⠀⣧⣀⣀⣀⠀⠘⠪⠭⠛⢠⡇⠀⠑⠭⠭⠞⠀⠀⣀⣸⣀⠀⠀⢸⠃⠀⠀⠀⠀⠀⣴⠚⠺⣟⣩⠷⡄⠀
-- ⠀⠘⣧⠀⠀⡎⠀⡇⠀⠀⡇⠀⠀⠀⠀⡅⠈⠀⠘⠙⢦⣀⡠⠖⠁⠈⢢⣄⣠⠤⠔⠂⠉⠀⢀⡸⠀⠀⢸⡆⠀⠀⠀⠀⠐⡇⠑⡶⣏⣀⢆⡇⠀
-- ⠀⠀⠙⣦⠀⠧⠴⢁⣀⣀⢡⠀⠀⠀⠀⠀⠈⢻⡀⠀⠉⠀⠀⠀⠀⠀⠀⠠⢤⣤⣤⡤⠴⠖⠋⠀⠀⠀⢸⠇⠀⠀⠀⠀⠀⠙⡆⢀⣈⣡⠟⠀⠀
-- ⠀⠀⠀⠈⡇⠀⠀⢸⠀⠈⡏⡄⠀⠀⠀⠀⠀⢸⣿⣶⣦⣤⣤⣤⣤⣤⣤⣤⡤⠤⣭⠶⠄⠀⠀⠀⠀⠀⡾⠀⠀⠀⠀⠀⠀⣰⠃⡞⠁⠀⠀⠀⠀
-- ⠀⠀⠀⠀⢧⡀⠀⠸⡄⡰⠁⢱⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠀⠀⢸⣿⡇⠀⠀⡇⠀⠀⢠⠖⠓⢢⠀⢇⠀⠀⠀⠀⠀⣰⠃⡼⠁⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⢱⡀⠀⠈⠀⠀⢸⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠉⠉⠀⠀⠀⠸⣤⠤⠊⠀⣾⣀⣀⡀⠀⣰⠋⡼⠁⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠈⣧⣄⡀⠎⡐⠈⡆⠀⣰⠆⠀⠘⢏⠉⠙⠛⠟⠛⠿⣿⣿⡇⠀⠀⠀⠀⠀⣀⠤⡄⠀⢸⠋⢠⡶⠗⢚⣡⠾⠁⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⢰⠃⠀⠹⡋⠀⠀⠃⠀⠠⠒⢢⠀⢄⠙⠒⠶⠶⠶⠶⠞⠛⠀⠀⠀⠀⠀⠀⠧⠴⠃⠀⢸⠀⢀⣻⠏⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⣾⠀⠀⠀⣇⣀⠀⠀⠀⠣⠤⠊⠀⠀⠉⠛⠚⠛⠒⠒⠒⠚⠁⠀⠀⠀⠀⠀⠀⠀⣀⣠⡟⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠙⢦⠤⡴⠋⠉⠉⠙⡟⠛⠉⠙⠛⠻⢟⡉⠉⢉⠟⢖⠒⡻⠻⣍⢉⡽⠛⠉⠉⠉⠉⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⢸⡄⡟⣶⣶⣦⠴⡧⠤⠤⠤⠤⠤⠤⠬⠭⢥⣤⡼⠉⢷⣤⣤⣁⡀⣀⣀⣀⣠⡶⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⡇⣿⠀⠉⠉⠀⡇⠀⠛⠛⠛⠛⠀⠘⠛⠛⠛⢧⠀⡸⠛⠛⠛⠁⠙⠛⠛⠛⠃⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⢀⠇⠘⢶⣤⣄⣀⡇⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣉⣀⣀⣀⣀⣀⣀⣀⣀⣀⣠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⡞⠀⠀⠸⣆⠸⣏⠉⠉⠉⠉⠉⣹⠏⠉⠉⠉⠉⠙⠯⣍⣉⣉⣀⡤⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⣧⣦⠸⡗⠋⠀⠈⠙⡗⣶⠒⠉⠁⠀⠀⠀⠀⠀⠀⠀⢸⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠈⠻⠶⠃⠀⠀⠀⠀⡇⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣗⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣹⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣷⣿⣦⣄⣀⡀⠀⠀⠀⠀⠀⢾⣿⣿⣿⣶⣾⣷⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⠿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
-- ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠻⠿⠿⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀