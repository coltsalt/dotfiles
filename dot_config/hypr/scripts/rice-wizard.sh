#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin"

# Define the absolute paths to your sub-scripts
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/wallpaper-picker.sh"
WAYBAR_SCRIPT="$HOME/.config/waybar/waybar-layout.sh"
THEME_SCRIPT="$HOME/.config/hypr/scripts/theme-switcher.sh"

MENU_THEME="$HOME/.config/rofi/switcher.rasi"


OPTION_WALL="  Change Wallpaper"
OPTION_WAYBAR="  Switch Waybar Layout"
OPTION_THEME="  Change Theme"

# Build the list for Rofi
CHOICE=$(echo -e "$OPTION_THEME\n$OPTION_WALL\n$OPTION_WAYBAR" | /usr/bin/rofi -dmenu -theme "$MENU_THEME" -p "Appearance:")

# Route the selection to the correct script
case "$CHOICE" in
    "$OPTION_THEME")
        [ -f "$THEME_SCRIPT" ] && bash "$THEME_SCRIPT"
        ;;
    "$OPTION_WALL")
        [ -f "$WALLPAPER_SCRIPT" ] && bash "$WALLPAPER_SCRIPT"
        ;;
    "$OPTION_WAYBAR")
        [ -f "$WAYBAR_SCRIPT" ] && bash "$WAYBAR_SCRIPT"
        ;;
    *)
        exit 0 # Pressed ESC or closed the menu
        ;;
esac