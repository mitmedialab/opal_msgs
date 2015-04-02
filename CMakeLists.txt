cmake_minimum_required(VERSION 2.8.3)
project(sar_opal_msgs)

## Find catkin macros and libraries, and other catkin packages
find_package(catkin REQUIRED COMPONENTS 
	roscpp 
	rospy 
	std_msgs 
	message_generation)

################################################
## Declare ROS messages, services and actions ##
################################################
## Generate messages in the 'msg' folder
 add_message_files(
   FILES
   OpalCommand.msg
   OpalAction.msg
   OpalScene.msg
 )

## Generate added messages and services with any dependencies listed here
generate_messages(
   DEPENDENCIES
   std_msgs  
 )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES sar_opal_msgs
  CATKIN_DEPENDS message_runtime std_msgs
#  DEPENDS system_lib
)

