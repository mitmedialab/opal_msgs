# sar\_opal\_msgs
A ROS package containing custom ROS messages for communication with a SAR Opal game.

## OpalCommand
The OpalCommand message definition contains a standard ROS message header, a command to send, and (for some commands) properties relevant to the command.  

Constants are provided for the different commands that can be sent to the tablet. Each command is an int8. Some commands must be accompanied by a JSON string that is a set of properties relevant to the command, such as the name of the object to move and where to move it to, as follows: 

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
   - plays about an audio clip while the sidekick character plays a talking
     animation

- 5 load object: 
    - JSON object with relevant properties, see below
    - adds a graphic object to the scene

- 6 clear scene: 
    - no properties OR a string name of the type of objects to clear
    - if no properties, removes all objects from the scene
    - if a string is provided, it is used to determine which objects to remove
      from the scene

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
    - in a social stories game, indicates which story scenes or answers are
      correct or incorrect responses for questions that may be asked

- 16 show correct:
    - no properties
    - shows "correct" and "incorrect" visual feedback for all objects tagged
      correct or incorrect

- 17 hide correct:
    - no properties
    - hides all "correct" and "incorrect" visual feedback for all objects
      tagged correct or incorrect

- 18 setup story scene:
    - JSON object with relevant properties, see below
    - in a social stories game, sets up the initial game scene that the story
      scenes are loaded into

Some commands should be accompanied by a set of properties. For example, if you
send the command "sidekick say", the properties field should contain a
string that is the speech the sidekick should say. If you send the command
"load object", the properties should be a JSON string of the
object-to-load's properties (e.g., name, tag, initial position). 

See the ROS package [sar\_opal\_sender] (https://github.com/personal-robots/sar_opal_sender "sar opal sender") for an example of how to send different commands. 

### Load object JSON properties 

The properties should be a JSON string with the relevant properties for the
object to load, move, or highlight. Available properties for loading objects include:

- name (string, default "")
- tag (string, default "")
- draggable (bool, default true)
- position (Vector3, default 0,0,0)
- scale (Vector3, default 1,1,1)
- audioFile (string, default null)
- slot (int, default -1)
- isAnswerSlot (bool, default false)
- correctSlot (int, default -1)
- isCorrect (bool, default false)
- isIncorrect (bool, default false)

Depending on what kind of object is being loaded, some property fields may be
ignored. For example, if you are not loading an object for a social stories
game, the properties slot, isAnswerSlot, correctSlot, isCorrect, and
isIncorrect will all be ignored. If you are loading a graphic that has the tag
"Background", only the name and tag fields are used.

For example, if you want to load the "dragon" image as a draggable PlayObject,
with the audio file "chimes" attached (so that "chimes" plays whenever you tap
the object), and you want this object to be created at \(0,0,0\) in the game
screen world, at a scale of \(100,100,100\), you would write:

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

If you want to load a background image instead of a draggable object, you would
specify just the name of the image and the tag:

> {  
>    "name": "playground",  
>    "tag": "Background"  
> }  

If you are loading objects as part of a social stories game, where graphics get
loaded into particular scene or answer slots, you would use the following
properties. This example would load the graphic named "scene1" as a playobject that is not draggable into the first scene slot:

> { 
>    "name": "scene1",
>    "tag": "PlayObject",
>    "draggable": "false",
>    "slot": "1",
>    "isAnswerSlot": "false"
> }

In some versions of the social stories game, the story scenes may be presented
out of order, with the user required to drag them back into order. Here's an
example of loading an out of order draggable scene graphic named "scene1" into
the second scene slot:

> { 
>    "name": "scene1",
>    "tag": "PlayObject",
>    "draggable": "true",
>    "slot": "2",
>    "isAnswerSlot": "false",
>    "correctSlot": "1"
> }

When loading graphics for answer slots for a social stories game, you should
use the following properties to indicate whether it is a correct answer or not
using the "isCorrect" or "isIncorrect" flags. Since objects can be either
correct, incorrect, or neither, both flags exist. Both flags default to
"false".

> { 
>    "name": "answer1",
>    "tag": "PlayObject",
>    "draggable": "false",
>    "slot": "1",
>    "isAnswerSlot": "true",
>    "isCorrect": "true"
> }


### Move object JSON properties

If you want to specify which object to move, you would specify the name of the
object to move and where to move it to:

> {
>    "name": "dragon",
>    "moveTo": ["100","200","0"]
> }

### Set correct JSON properties

If you want to specify which objects are "correct" or "incorrect" answer
responses, you would specify the names of the objects that should be marked
correct or incorrect:

> {
>    "correct":["dragon"],
>    "incorrect":["ball1","cat"]
> }

### Setup Story Scene JSON properties

If you want to set up a social stories game scene, you specify the number of
scenes in the story, whether the scenes will be presented in order or not, and
the number of answer options available when questions are asked about the
story. For example:

> {
>    "numScenes":"4",
>    "scenesInOrder":true,
>    "numAnswers":"4"
> }


## OpalAction

The OpalAction message is sent from a SAR opal game whenever actions occur in the
game. It's essentially a log message. It includes six fields:

- action
- objectName
- objectTwoName
- position
- positionTwo
- message

Some actions refer to specific objects and take place in specific positions in
the game scene (e.g., a tap takes place in a specific location and is
registered by a specific game object). Some actions involve two separate
objects (e.g., collisions). When a field is not required, it will be an empty
string (e.g., a tap action involves only one object, so the objectTwoName and
positionTwo will be empty strings).

The action types that are currently sent include:

- tap
- press \(i.e., any touch\)
- release
- pan \(i.e., drag\)
- pancomplete \(i.e., drag end \)
- collide
- collideEnd

Note that these actions are only what SAR opal games send right now (see
[SAR\-opal\-base] (https://github.com/personal-robots/SAR-opal-base "sar opal
base")). This could change. Although we could define a set of constants for the
types of actions that be sent (i.e., a set of string action types), because the
game could theoretically send a bunch of different actions beyond what is
currently sent, we don't want to require whoever writes game code to also
modify this message definition whenever they want to log a new action. That
said, we strongly encourage anyone who changes the types of actions sent to
update this file with the current list, since anyone receiving OpalAction
messages will likely want to do different things based on the action type.

The message field is used to provide additional information about the action
that occurred, such as whether it is a correct or incorrect action (based on
the flags in the object's saved properties). This field should be an empty
string if no additional information is required.

## OpalScene

When the OpalCommand "request keyframe" is sent to the tablet, the tablet sends
back an OpalScene message, which contains the string name of the background
image currently displayed and an array of all the different objects present in
the scene. Each string in the array is the JSON configuration of the object,
which includes all the information needed to reload that object later (i.e.,
name, tag, position, scale, which audio file is attached, whether the object is
draggable).

## Version and dependency notes

This node was built and tested with:

- Python 2.7.6
- ROS Indigo
- Ubuntu 14.04 LTS (64-bit)

## Bugs and issues

Please report all bugs and issues on the [sar\_opal\_msgs github issues
page](https://github.com/personal-robots/sar_opal_msgs/issues).
