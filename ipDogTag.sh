#!/bin/bash

#For the time being the device ID is being treated like a constant
VENDOR_ID=1a86

#This string of commands gets the current IP address.
#Command 1: ifconfig prints information about the network connections
#Command 2: grep for "inet (some IP address)"
#Command 3: Use awk to drop the "inet " portion from the second commands output
#Command 4: grep for any IP address not matching the loop back address
IP_ADDR=$(ip a | grep -Eoh "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk '{print $2}' | grep -v "127.0.0.1")

stty -F $(ls /dev/serial/by-id/*${VENDOR_ID}*) ispeed 9600 ospeed 9600 -ignpar cs8 cread -cstopb -echo

#DEV_FILE=ls /dev/serial/by-id | grep
echo $IP_ADDR
echo $IP_ADDR > $(ls /dev/serial/by-id/*${VENDOR_ID}*)
# echo ZZZ > $(ls /dev/serial/by-id/*${VENDOR_ID}*)
tail -f $(ls /dev/serial/by-id/*${VENDOR_ID}*)




# #!/bin/bash

# echo "DEVICE DETECTED" > /var/log/ipDogTag.log

# #For the time being the device ID is being treated like a constant
# #DEV_ID=0043
# VEND_ID=1a86
# DEV_ID=7523

# #This string of commands gets the current IP address.
# #Command 1: ifconfig prints information about the network connections
# #Command 2: grep for "inet (some IP address)"
# #Command 3: Use awk to drop the "inet " portion from the second commands output
# #Command 4: grep for any IP address not matching the loop back address
# IP_ADDR=$(ip a | grep -Eoh "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk '{print $2}' | grep -v "127.0.0.1")
 

# USB=$( lsusb -d $VEND_ID:$DEV_ID )
# BUS=$(echo $USB | grep -Eo "Bus [0-9]{3}" | grep -Eo "[0-9]{3}")
# DEVICE=$(echo $USB | grep -Eo "Device [0-9]{3}" | grep -Eo "[0-9]{3}")
# echo $IP_ADDR
# echo $USB
# echo $BUS
# echo $DEVICE

# # stty -F /dev/bus/usb/$BUS/$DEVICE cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts 


# #idVendor=1a86, idProduct=7523su
