#!/bin/bash

#Add the script tirggered by the udev rule
cp ./ipDogTag.sh /usr/local/bin/ipDogTag.sh

#Add the servcie
cp ./ipDogTag.service /etc/systemd/system/ipDogTag.service

#Add the udev rule
cp ./ipDogTag.rules /lib/udev/rules.d/ipDogTag.rules
systemctl daemon-reload

#Update the udev rules so that the new rule will be triggered
udevadm control --reload