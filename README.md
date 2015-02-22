# sar_opal_msgs
A ROS package containing custom ROS messages for communication with the SAR Opal tablet app

## Commands
The message definition includes constants for the different commands that can be sent to the tablet:
- reset scene
- disable touch
- enable touch
- sidekick say
- sidekick do
- load object

The command can be optionally accompanied by a set of properties. For example, if you send the command "sidekick say", the properties field should contain a string that is the speech the sidekick should say. If you send the command "load object", the properties should be a JSON string of the object-to-load's properties (e.g., name, tag, initial position). 

See the ROS package [sar_opal_sender] (https://github.com/personal-robots/sar_opal_sender "sar opal sender") for an example of how to send different commands and how to format the properties.
