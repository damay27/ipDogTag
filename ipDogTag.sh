#!/bin/bash

#Delay to make sure the /dev/serial/by-id folder structure already been created
#(This is probably not necessary)
sleep 1

#For the time being the device ID is being treated like a constant
VENDOR_ID=1a86

DEV_FILE=$(ls /dev/serial/by-id/ | grep -E ".*"$VENDOR_ID".*")

#This string of commands gets the current IP address.
#Command 1: ifconfig prints information about the network connections
#Command 2: grep for "inet (some IP address)"
#Command 3: Use awk to drop the "inet " portion from the second commands output
#Command 4: grep for any IP address not matching the loop back address
IP_ADDR=$(ip a | grep -Eoh "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk '{print $2}' | grep -v "127.0.0.1")

#Configure the serial port with the following parameters
#   Input speed = 9600 bps
#   Output speed = 9600 bps
#   No parity bits
#   8 bit characters
#   Allow reading from serial port
#   Echo input character to the serial port
stty -F /dev/serial/by-id/"${DEV_FILE}" ispeed 9600 ospeed 9600 -ignpar cs8 cread -echo

#The above command will cause the arduino to reset. Because of this this script
#needs to sleep for at least 2 seconds so that the arduino can restart and be
#ready to receive the data.
sleep 2

echo $IP_ADDR > /dev/serial/by-id/"${DEV_FILE}"

echo $(date): ipDogTag sent value $IP_ADDR >> /var/log/ipDogTag.log 
