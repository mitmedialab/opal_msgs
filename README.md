# sar\_opal\_msgs
A ROS package containing custom ROS messages for communication with the SAR Opal tablet app

## OpalCommand
The OpalCommand message definition includes constants for the different commands that can be sent to the tablet. Each command is an int32. Some commands must be accompanied by a JSON string that is a set of properties relevant to the command, such as the name of the object to move and where to move it to. 
- 0 reset scene
    no properties (properties = null)
- 1 disable touch
    no properties
- 2 enable touch
    no properties
- 3 sidekick do
    string name of action to do, use the provided constants
- 4 sidekick say
    string name of audio to play, assumes .wav file extension
- 5 load object
    JSON object with relevant properties, see below
- 6 clear scene
    no properties
- 7 move object
    JSON object with relevant properties, see below
- 8 highlight object
    string name of object to highlight
- 9 request keyframe
    no properties
- 10 fade screen
    no properties
- 11 unfade screen
    no properties

Some commands should be accompanied by a set of properties. For example, if you send the command "sidekick say", the properties field should contain a string that is the speech the sidekick should say. If you send the command "load object", the properties should be a JSON string of the object-to-load's properties (e.g., name, tag, initial position). 

See the ROS package [sar\_opal\_sender] (https://github.com/personal-robots/sar_opal_sender "sar opal sender") for an example of how to send different commands. 

### Load object and move object JSON properties 
The properties should be a JSON string with the relevant properties for the object to load, move, or highlight. For example, if you want to load the "dragon" image as a draggable PlayObject, with the audio file "chimes" attached (so that "chimes" plays whenever you tap the object), and you want this object to be created at \(0,0,0\) in the tablet screen world, you would write:
> {  
>    "name": "dragon",  
>    "tag": "PlayObject",  
>    "draggable": "true",  
>    "audioFile": "chimes",  
>    "position": ["0","0","0"], 
>    "scale": ["100","100","100"]
> }

Here is another example:
> {  
>    "name": "ball1",  
>    "tag": "PlayObject",  
>    "draggable": "false",  
>    "audioFile": "wakeup",  
>    "position": ["300","10","0"],  
>    "scale": ["100","100","100"]
> }

If you want to load a background image instead of a draggable object, you would specify just the name of the image and the tag:
> {  
>    "name": "playground",  
>    "tag": "Background"  
> }  

If you want to specify which object to move, you would write:
> {
>     "name": "dragon",
>     "moveTo": ["100","200","0"]
> }

## OpalAction
The OpalAction message is sent from the tablet whenever actions occur on the tablet. It's essentially a log message. The action types that are currently sent from the tablet include:

- tap
- press
- release
- pan \(i.e., drag\)
- pan complete

Note that these actions are only what the tablet sends right now (see [SAR\-opal\-base] (https://github.com/personal-robots/SAR-opal-base "sar opal base"). This could change. Although we could define a set of constants for the types of actions that be sent (i.e., a set of string action types), because the tablet could theoretically send a bunch of different actions beyond what is currently sent, we don't want to require whoever rights tablet code to also modify this message definition whenever they want to log a new action.

## OpalScene
When the OpalCommand "request keyframe" is sent to the tablet, the tablet sends back an OpalScene message, which contains the string name of the background image currently displayed and an array of all the different objects present in the scene. Each string in the array is the JSON configuration of the object, which includes all the information needed to reload that object later (i.e., name, tag, position, scale, which audio file is attached, whether the object is draggable).
