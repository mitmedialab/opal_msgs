# Message for logging actions that have occurred on the SAR Opal tablet app

# name of the object on which the action occurred
# or an empty string if no object
string objectName

# action type that occurred, e.g., "tap" or "press_begin" 
string action

# (x, y, z) position where the object was when this action occurred
float32[3] position 

# time of action
time timestamp

