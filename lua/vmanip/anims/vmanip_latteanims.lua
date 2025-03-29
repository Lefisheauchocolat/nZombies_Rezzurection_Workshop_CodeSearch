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

-- Bo3 Downed Crawl Anims

VManip:RegisterAnim("crawl_in",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl.mdl",
["lerp_peak"]=0.8,
["lerp_speed_in"]= 1,
["lerp_speed_out"]= 1,
["speed"]= 0.7,
["sounds"]={},
["loop"]=false
}
)

VManip:RegisterAnim("crawl_out",
{
["model"]="nzr/2025/gestures/t7/crawl/vm_t7_crawl.mdl",
["lerp_peak"]=0.8,
["lerp_speed_in"]= 1,
["lerp_speed_out"]= 1,
["speed"]= 0.7,
["sounds"]={},
["loop"]=false
}
)

VManip:RegisterAnim("crawl_forward",
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

VManip:RegisterAnim("crawl_back",
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

VManip:RegisterAnim("crawl_left",
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

VManip:RegisterAnim("crawl_right",
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