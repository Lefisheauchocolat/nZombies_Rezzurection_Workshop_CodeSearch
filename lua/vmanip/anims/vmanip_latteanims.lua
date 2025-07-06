AddCSLuaFile()

--[[ IN BOTH CASES: NAME SHOULD BE THE ACTUAL SEQUENCE NAME
You don't have to put every value, but some like model are obviously needed

Hands
"model" - path to model
"lerp_peak" - time when the hand should transition back to the weapon
"lerp_speed_in" - speed at which the hand transitions into the anim
"lerp_speed_out" - speed at which the hand transitions out of the anim
"lerp_curve" - power of the curve
"speed" - playback speed
"startcycle" - time to start the anim at
"cam_ang" - angle offset for the camera
"cam_angint" - intensity multiplier of the camera
"sounds" - table of sounds, keys represent the path and their value the time it plays at. do not use past holdtime lmao
"loop" - loop the anim instead of stopping
"segmented" - when anim is over, freezes it and waits for SegmentPlay(sequence,lastanim). Repeat if lastanim is false
^Note: lerp peak and related values are used for the "last segment" instead.

"holdtime" - the time when the anim should be paused
"preventquit" - ONLY accept QuitHolding request if the argument is our anim. Use very cautiously
"assurepos" - for important anims, makes sure the position isn't offset by sweps. Use locktoply it's better
"locktoply" - for when assurepos isn't enough.


Legs
"model" - path to model
"speed" - playback speed 
"forwardboost" - forward offset
"upboost" - vertical offset (in actual hammer units)

]]
-- IW Power On
VManip:RegisterAnim("vm_iw_poweron",
{
["model"]="nzr/2025/gestures/iw7/poweron/vm_iw7_poweron.mdl",
["lerp_peak"]=0.8,
["lerp_speed_in"]= 1,
["lerp_speed_out"]= 1,
["speed"]= 0.7,
["sounds"]={},
["loop"]=false
}
)

-- IW Pick Up
VManip:RegisterAnim("vm_iw_pickup",
{
["model"]="nzr/2025/gestures/iw7/pickup/vm_iw7_pickup.mdl",
["lerp_peak"]=1.04,
["lerp_speed_in"]= 1,
["lerp_speed_out"]= 1,
["speed"]= 0.7,
["sounds"]={},
["loop"]=false
}
)


-- Bo3 Downed Crawl Anims

VManip:RegisterAnim("crawl_forward_t7",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_back_t7",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_left_t7",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl_side.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_right_t7",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl_side.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

-- BOCW Downed Crawl Anims

VManip:RegisterAnim("crawl_forward_t9",
{
["model"]="nzr/2025/gestures/t9/crawl/vm_t9_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_back_t9",
{
["model"]="nzr/2025/gestures/t9/crawl/vm_t9_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_left_t9",
{
["model"]="nzr/2025/gestures/t9/crawl/vm_t9_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

VManip:RegisterAnim("crawl_right_t9",
{
["model"]="nzr/2025/gestures/t9/crawl/vm_t9_crawl.mdl",
["lerp_peak"]=0.1,
["lerp_speed_in"]= 2,
["lerp_speed_out"]= 0.5,
["speed"]= 0.7,
["sounds"]={},
["loop"]=true
}
)

-- BO6 Armor Plate
VManip:RegisterAnim("replate_t10",
{
["model"]="nzr/2025/gestures/t10/replate/vm_t10_replate.mdl",
["lerp_peak"]=0.9,
["lerp_speed_in"]= 0.5,
["lerp_speed_out"]= 0.7,
["speed"]= 0.7,
["sounds"]={
	["Latte_Armor.Open"] = 0,
	["Latte_Armor.Insert"] = 0.1,
},
["loop"]=false
}
)

VManip:RegisterAnim("replate_fast_t10",
{
["model"]="nzr/2025/gestures/t10/replate/vm_t10_replate.mdl",
["lerp_peak"]=0.6,
["lerp_speed_in"]= 0.5,
["lerp_speed_out"]= 1,
["speed"]= 1,
["sounds"]={
	["Latte_Armor.Open"] = 0,
	["Latte_Armor.Insert"] = 0.05,
},
["loop"]=false
}
)