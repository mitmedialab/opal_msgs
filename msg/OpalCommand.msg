# Message for requesting actions from the SAR Opal tablet app

int32 command # which command will be sent
# properties of command in json format
# could be:
#   name of action for sidekick to do
#   name of sound for sidekick to play
#   properties of object to load
#   null if no extra properties needed
string properties 

# Commands
int32 RESET = 0
int32 DISABLE_TOUCH = 1
int32 ENABLE_TOUCH = 2
int32 SIDEKICK_DO = 3
int32 SIDEKICK_SAY = 4
int32 LOAD_OBJECT = 5
int32 CLEAR = 6
int32 MOVE_OBJECT = 7
int32 HIGHLIGHT_OBJECT = 8
int32 REQUEST_KEYFRAME = 9
int32 AT_GOAL = 10
