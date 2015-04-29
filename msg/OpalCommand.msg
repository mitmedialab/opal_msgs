# Message for requesting actions from the SAR Opal tablet app

int8 command # which command will be sent

# properties of command, such as:
#   string name of action for sidekick to do (use constants below)
#   string name of sound for sidekick to play
#   json string that is the set of properties of the object to load
#   null if no extra properties needed
string properties 

# Commands
int8 RESET = 0
int8 DISABLE_TOUCH = 1
int8 ENABLE_TOUCH = 2
int8 SIDEKICK_DO = 3
int8 SIDEKICK_SAY = 4
int8 LOAD_OBJECT = 5
int8 CLEAR = 6
int8 MOVE_OBJECT = 7
int8 HIGHLIGHT_OBJECT = 8
int8 REQUEST_KEYFRAME = 9
int8 FADE_SCREEN = 10
int8 UNFADE_SCREEN = 11

# Sidekick animations
string ANIM_SPEAK = "BeakOpenClose" 
string ANIM_FLAP = "FlapWings"
string ANIM_FLAP_BEAKOPEN = "FlapBeakOpen"
