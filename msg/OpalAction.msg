# Message for logging actions that have occurred on the SAR Opal tablet app

# name of the object on which the action occurred
# or an empty string if no object
string objectName

# name of the second object involved in the action (e.g., a collision)
# or an empty string if no object
string objectTwoName

# action type that occurred, e.g., "tap" or "press_begin" 
string action

# (x, y, z) position where the object was when this action occurred
float32[] position 

# (x, y, z) position where the second object was when this 
# action occurred
float32[] positionTwo
