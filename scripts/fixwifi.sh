#!/bin/sh

echo '[     ]'
sudo systemctl stop NetworkManager
echo '[#    ]'
sudo rmmod iwlmvm
echo '[##   ]'
sudo rmmod iwlwifi
echo '[###  ]'
sudo modprobe iwlmvm
echo '[#### ]'
sudo systemctl start NetworkManager
echo '[#####]'
