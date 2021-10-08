#!/bin/sh
nmcli con add type wifi ifname wlo1 con-name Rhsp autoconnect yes ssid HailStallman
nmcli con modify Rhsp wifi-sec.key-mgmt wpa-psk
nmcli con modify Rhsp wifi-sec.psk "RichardStallman"
nmcli con modify Rhsp 802-11-wireless.mode ap
nmcli con modify Rhsp 802-11-wireless.band bg
nmcli con modify Rhsp ipv4.method shared
nmcli con modify Rhsp ifname wlp2s0
nmcli con up Rhsp

