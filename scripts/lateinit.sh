#!/bin/sh

logger -t LATEINIT "late starting nmb/smb"
sudo systemctl start nmb.service
sudo systemctl start smb.service

