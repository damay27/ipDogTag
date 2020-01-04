#!/bin/bash

#For the time being the device ID is being treated like a constant
VENDOR_ID=1a86

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
stty -F $(ls /dev/serial/by-id/*${VENDOR_ID}*) ispeed 9600 ospeed 9600 -ignpar cs8 cread -echo


echo $IP_ADDR > $(ls /dev/serial/by-id/*${VENDOR_ID}*)

echo ipDogTag sent value $IP_ADDR >> /var/log/ipDogTag.log 

#See if data was sent back from the device. For debugging only
# RETURN_VAL=$(cat $(ls /dev/serial/by-id/*${VENDOR_ID}*))

# if [$IP_ADDR != RETURN_VAL]
# then
#     echo ERROR: Return value $RETURN_VAL != to $IPADDR >> /var/log/ipDogTag.log
# fi