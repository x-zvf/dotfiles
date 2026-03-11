#!/bin/sh

set -x
systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME NIXOS_OZONE_WL

execifn() {
    if [ -z "$(pgrep -f $1)" ];
    then
        shift
        $@ &
    fi
}

execifn dunst dunst
execifn shikane shikane

pkill waybar; waybar &

execifn pasystray pasystray
execifn nm-applet nm-applet

#execifn wpaper wpaperd -d
execifn kwalletd6 kwalletd6 -d

execifn wl-paste wl-paste --watch cliphist store

#swaymsg 'workspace number 1; layout tabbed'
execifn firefox firefox

#swaymsg 'workspace number 9; layout tabbed'

execifn ferdium ferdium
execifn signal-desktop signal-desktop --password-store="kwallet6"
execifn thunderbird thunderbird
execifn nextcloud nextcloud

execifn hypridle hypridle

#sleep 1

#swaymsg 'workspace number 2'

shikanectl reload
hyprpm reload -n
