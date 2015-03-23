# Message describing the current state of one object in the
# current scene on the the SAR Opal tablet app

# name of object
string name

# (x, y, z) position of object
float32[3] position 

# state of object
string state

# distance to current goal if there is one
# set to -1 if no goal
float32 distance

