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
rstrt() {
    pkill -9 $1
    $@ &
}
pkill -9 kded6

rstrt waybar
rstrt swaybg -i ~/.config/wallpaper
execifn dunst dunst
execifn shikane shikane
execifn kwalletd6 kwalletd6 -d
execifn wl-paste wl-paste --watch cliphist store


execifn firefox firefox
execifn ferdium ferdium
execifn signal-desktop signal-desktop --password-store="kwallet6"
execifn thunderbird thunderbird
execifn nextcloud nextcloud

rstrt pasystray
rstrt nm-applet

shikanectl reload
