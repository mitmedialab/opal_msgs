# Message for logging actions that have occurred on the SAR Opal tablet app
Header header

# Name of the object on which the action occurred
# or an empty string if no object
string objectName

# Name of the second object involved in the action (e.g., a collision)
# or an empty string if no object
string objectTwoName

# Action type that occurred, e.g., "tap" or "press_begin" 
string action

# (x, y, z) position where the object was when this action occurred
float32[] position 

# (x, y, z) position where the second object was when this 
# action occurred
float32[] positionTwo

# Additional information about the action that occurred, such as 
# whether it is a correct or incorrect action (based on the flags in 
# the object's saved properties). Or an empty string if no additional
# information is required.
string message
