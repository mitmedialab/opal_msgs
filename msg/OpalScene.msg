# Message for logging the entire state of the scene in
# the SAR Opal tablet app

# name of the current background image
string background

# array of objects present in the scene
# each string is a JSON string with the properties of the object
# these should be the same properties that are send when we load an
# object with an OpalCommand load object message - i.e., name, tag,
# position, scale, etc.
string[] objects 
