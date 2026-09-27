#!/bin/bash

WAYBAR_CONFIG="$HOME/.config/waybar/current_layout"
WAYBAR_STYLE="$HOME/.config/waybar/current_style"

killall waybar 2>/dev/null
sleep 0.2

if [ -L "$WAYBAR_CONFIG" ] && [ -L "$WAYBAR_STYLE" ]; then
    /usr/bin/waybar \
        -c "$WAYBAR_CONFIG" \
        -s "$WAYBAR_STYLE" \
        > /dev/null 2>&1 &
fi