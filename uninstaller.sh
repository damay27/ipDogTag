#!/bin/bash

#Remove the udev rule
rm /lib/udev/rules.d/ipDogTag.rules

#Remove service
rm /etc/systemd/system/ipDogTag.service
systemctl daemon-reload

#Remove the script tirggered by the udev rule
rm /usr/local/bin/ipDogTag.sh

#Update the udev rules so that it won't trigger a rule that does not exist
udevadm control --reload