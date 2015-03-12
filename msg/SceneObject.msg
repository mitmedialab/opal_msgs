# Message describing the current state of one object in the
# current scene on the the SAR Opal tablet app

# name of object
string name

# (x, y, z) position of object
float32[3] position 

# state of object
string state

# has goal? 
bool hasgoal

# distance to current goal if there is one
float32 distance

