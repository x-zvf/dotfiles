#!/usr/bin/env bash
set -x
BG="$(realpath "$1")"
WLP="$HOME/.config/wallpaper"

rm $WLP
ln -s "$BG" $WLP
wal -i $WLP

swaymsg restart
