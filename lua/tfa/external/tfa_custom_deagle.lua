local hudcolor = Color(255, 80, 0, 191)

path = "weapons/tfa_custom_deagle/"
pref = "TFA_CUSTOM_DEAGLE"

TFA.AddFireSound(pref .. ".1", { path .. "DesertEagle-1.wav", path .. "DesertEagle-2.wav", path .. "DesertEagle-3.wav" }, true, ")")
TFA.AddFireSound(pref .. ".50", { path .. "Deagle-1.wav", path .. "Deagle-2.wav", path .. "Deagle-3.wav" }, true, ")")
TFA.AddWeaponSound(pref .. ".Draw", path .. "uni_weapon_raise_01.wav")
TFA.AddWeaponSound(pref .. ".Holster", path .. "uni_ads_out_01.wav")
TFA.AddWeaponSound(pref .. ".Pull", path .. "Deagle-SlideBack.wav")
TFA.AddWeaponSound(pref .. ".Release", path .. "Deagle-SlideRelease.wav")
TFA.AddWeaponSound(pref .. ".ClipOut", path .. "Deagle-Out.wav")
TFA.AddWeaponSound(pref .. ".ClipIn", path .. "Deagle-In.wav")
TFA.AddWeaponSound(pref .. ".Chamber", path .. "Deagle-SlideRelease.wav")
TFA.AddWeaponSound(pref .. ".Look", { path .. "uni_lean_out_02.wav", path .. "uni_lean_out_04.wav" })
TFA.AddWeaponSound(pref .. ".Lift", path .. "uni_lean_in_04.wav")
--TFA.AddWeaponSound(pref .. ".IronIn", path .. "uni_lean_out_02.wav")
--TFA.AddWeaponSound(pref .. ".IronOut", path .. "uni_lean_out_04.wav")

if killicon and killicon.Add then
	killicon.Add("tfa_custom_deagle", "vgui/killicons/tfa_custom_deagle", hudcolor)
end