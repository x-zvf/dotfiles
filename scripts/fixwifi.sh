#!/bin/sh

sudo systemctl stop NetworkManager
sudo rmmod iwlmvm
sudo rmmod iwlwifi
sudo modprobe iwlmvm
sudo systemctl start NetworkManager
