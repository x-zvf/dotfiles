#!/usr/bin/env bash

logger -t LATEINIT "late starting nmb/smb"
sudo systemctl start nmb.service
sudo systemctl start smb.service

# while true;
# do
# 	hubstate="$(cat /sys/bus/usb/devices/1-4/power/control)"
# 	mtstate="$(cat /sys/bus/usb/devices/1-5/power/control)"
# 	if [ "$mtstate" != "on" ] || [ "$hubstate" != "on" ];
# 	then
# 		echo "Someone screwed with usb power: hub=$hubstate mt=$mtstate" | logger -t "lateinit - fixmouse"
# 		echo on | sudo tee /sys/bus/usb/devices/1-4/power/control >/dev/null
# 		echo on | sudo tee /sys/bus/usb/devices/1-5/power/control >/dev/null
# 	fi
# 	sleep 1
# done
