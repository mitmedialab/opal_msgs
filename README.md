# sar\_opal\_msgs
A ROS package containing custom ROS messages for communication with the SAR Opal tablet app

## Commands
The message definition includes constants for the different commands that can be sent to the tablet. Each command is an int32. Some commands must be accompanied by a JSON string that is a set of properties relevant to the command, such as the name of the object to move and where to move it to. 
- 0 reset scene \(no properties\)
- 1 disable touch \(no properties\)
- 2 enable touch \(no properties\)
- 3 sidekick do \(string name of action to do\)
- 4 sidekick say \(string name of audio to play\)
- 5 load object \(JSON object with relevant properties, see below\)
- 6 clear scene \(no properties\)
- 7 move object \(JSON object with relevant properties, see below\)
- 8 highlight object \(string name of object to highlight\)
- 9 request keyframe \(no properties\)

Some commands should be accompanied by a set of properties. For example, if you send the command "sidekick say", the properties field should contain a string that is the speech the sidekick should say. If you send the command "load object", the properties should be a JSON string of the object-to-load's properties (e.g., name, tag, initial position). 

See the ROS package [sar\_opal\_sender] (https://github.com/personal-robots/sar_opal_sender "sar opal sender") for an example of how to send different commands. 

## Load object and move object JSON properties 
The properties should be a JSON string with the relevant properties for the object to load, move, or highlight. For example, if you want to load the "dragon" image as a draggable PlayObject, with the audio file "chimes" attached (so that "chimes" plays whenever you tap the object), and you want this object to be created at \(0,0,0\) in the tablet screen world, you would write:
> {  
>    "name": "dragon",  
>    "tag": "PlayObject",  
>    "draggable": "true",  
>    "audioFile": "chimes",  
>    "initPosition": ["0","0","0"]  
> }

If you wanted to specify that the object has a target end point (i.e., something special should happen if the object reaches a target position on the screen), you would add the field "endPositions":
> {  
>    "name": "dragon",  
>    "tag": "PlayObject",  
>    "draggable": "true",  
>    "audioFile": "chimes",  
>    "initPosition": ["0","0","0"],  
>    "endPositions": [ ["100", "200", "0"] ]  
> }

Note that here, "endPositions" is an array of arrays, because you can specify *multiple* target end positions.

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
