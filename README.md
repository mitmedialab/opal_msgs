# sar\_opal\_msgs
A ROS package containing custom ROS messages for communication with the SAR Opal tablet app

## OpalCommand
The OpalCommand message definition includes constants for the different commands that can be sent to the tablet. Each command is an int8. Some commands must be accompanied by a JSON string that is a set of properties relevant to the command, such as the name of the object to move and where to move it to. 

- 0 reset scene: 
   - no properties (properties = null)
   - moves all objects back to their start positions in the scene

- 1 disable touch: 
    - no properties
    - disables ability to use touch actions on the screen (will not respond to tap, drag, etc.)

- 2 enable touch: 
    - no properties
    - enables ability to use touch actions on the screen

- 3 sidekick do: 
    - string name of action to do, use the provided constants
    - tells the sidekick character to play an animation

- 4 sidekick say: 
   - string name of audio to play, assumes .wav file extension
   - plays about an audio clip while the sidekick character plays a talking animation

- 5 load object: 
    - JSON object with relevant properties, see below
    - adds a graphic object to the scene

- 6 clear scene: 
    - no properties
    - removes all objects from the scene

- 7 move object: 
    - JSON object with relevant properties, see below
    - moves an object from one place to another in the scene

- 8 highlight object: 
    - string name of object to highlight
    - moves a glowy highlight object behind the indicated object

- 9 request keyframe: 
    - no properties
    - asks tablet app to send out an OpalScene keyframe message

- 10 fade screen: 
    - no properties
    - fade out the scene with a white cloud-like fader

- 11 unfade screen: 
    - no properties
    - stop fading out the scene

- 12 next page: 
    - no properties
    - in a story, go to the next page in the story

- 13 previous page: 
    - no properties
    - in a story, go to the previous page in the story

- 14 exit: 
    - no properties
    - closes the app

- 15 set correct:
    - JSON object with relevant properties, see below
    - in a social stories game, indicates which story scenes or answers are correct or incorrect responses for questions that may be asked

- 16 show correct:
    - no properties
    - shows "correct" and "incorrect" visual feedback for all objects tagged correct or incorrect

- 17 hide correct:
    - no properties
    - hides all "correct" and "incorrect" visual feedback for all objects tagged correct or incorrect

Some commands should be accompanied by a set of properties. For example, if you
send the command "sidekick say", the properties field should contain a
string that is the speech the sidekick should say. If you send the command
"load object", the properties should be a JSON string of the
object-to-load's properties (e.g., name, tag, initial position). 

See the ROS package [sar\_opal\_sender] (https://github.com/personal-robots/sar_opal_sender "sar opal sender") for an example of how to send different commands. 

### Load object JSON properties 
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
>    "audioFile": "",  
>    "position": ["300","10","0"],  
>    "scale": ["100","100","100"]
> }

If you want to load a background image instead of a draggable object, you would specify just the name of the image and the tag:
> {  
>    "name": "playground",  
>    "tag": "Background"  
> }  

### Move object JSON properties
If you want to specify which object to move, you would specify the name of the object to move and where to move it to:
> {
>     "name": "dragon",
>     "moveTo": ["100","200","0"]
> }

### Set correct JSON properties
If you want to specify which objects are "correct" or "incorrect" answer responses, you would specify the names of the objects that should be marked correct or incorrect:
> {
>       "correct":["dragon"],
>       "incorrect":["ball1","cat"]
> }

## OpalAction

The OpalAction message is sent from the tablet whenever actions occur on the
tablet. It's essentially a log message. The action types that are currently
sent from the tablet include:

- tap
- press
- release
- pan \(i.e., drag\)
- pan complete

Note that these actions are only what the tablet sends right now (see [SAR\-opal\-base] (https://github.com/personal-robots/SAR-opal-base "sar opal base"). This could change. Although we could define a set of constants for the types of actions that be sent (i.e., a set of string action types), because the tablet could theoretically send a bunch of different actions beyond what is currently sent, we don't want to require whoever rights tablet code to also modify this message definition whenever they want to log a new action.

## OpalScene

When the OpalCommand "request keyframe" is sent to the tablet, the tablet sends
back an OpalScene message, which contains the string name of the background
image currently displayed and an array of all the different objects present in
the scene. Each string in the array is the JSON configuration of the object,
which includes all the information needed to reload that object later (i.e.,
name, tag, position, scale, which audio file is attached, whether the object is
draggable).
