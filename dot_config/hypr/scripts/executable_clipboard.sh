#!/bin/bash
MENU_THEME="$HOME/.config/rofi/switcher.rasi"
# Fetch history, display via Rofi, decode selection, and copy to clipboard
selection=$(cliphist list | rofi -dmenu -theme "$MENU_THEME" -display-columns 2 -p "clipboard")

if [ -n "$selection" ]; then
    echo "$selection" | cliphist decode | wl-copy
fi