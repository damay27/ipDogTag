#!/bin/bash

#For the time being the device ID is being treated like a constant
DEV_ID=0043

#This string of commands gets the current IP address.
#Command 1: ifconfig prints information about the network connections
#Command 2: grep for "inet (some IP address)"
#Command 3: Use awk to drop the "inet " portion from the second commands output
#Command 4: grep for any IP address not matching the loop back address
IP_ADDR=$(ifconfig | grep -Eoh "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk '{print $2}' | grep -v "127.0.0.1")
 
#DEV_FILE=ls /dev/serial/by-id | grep 
echo $IP_ADDR > $(ls /dev/serial/by-id/*_${DEV_IN}_*)
