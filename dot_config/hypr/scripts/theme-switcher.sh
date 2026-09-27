#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin"

THEME_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_LINK="$THEME_DIR/current_theme"
MENU_THEME="$HOME/.config/rofi/switcher.rasi"
SCRIPT_DIR="$HOME/.config/hypr/scripts/app-themes"

# # 1. Open Rofi menu to pick an available theme folder (With Active Indicator)
ACTIVE_THEME=$(basename "$(readlink "$CURRENT_THEME_LINK" 2>/dev/null)")

THEME_LIST=""
while IFS= read -r dir; do
    theme_name=$(basename "$dir")
    if [ "$theme_name" = "$ACTIVE_THEME" ]; then
        THEME_LIST+="|$theme_name\n"
    else
        THEME_LIST+=" $theme_name\n"
    fi
done < <(find "$THEME_DIR" -maxdepth 1 -mindepth 1 -type d ! -name "current_theme")

CHOSEN_THEME=$(printf "$THEME_LIST" | /usr/bin/rofi -dmenu -theme "$MENU_THEME" -p " Select Theme:")

[ -z "$CHOSEN_THEME" ] && exit 0

# Strip the active label out so the rest of the script gets a clean folder name
CHOSEN_THEME=$(echo "$CHOSEN_THEME" | sed 's/^|//')
CHOSEN_THEME=$(echo "$CHOSEN_THEME" | sed -e 's/^[[:space:]]//' -e 's/[[:space:]]$//')

rm "$CURRENT_THEME_LINK" 2>/dev/null
ln -s "$THEME_DIR/$CHOSEN_THEME" "$CURRENT_THEME_LINK"

# App theme switching

"$SCRIPT_DIR/wallpaper.sh"
"$SCRIPT_DIR/hyprland.sh"
"$SCRIPT_DIR/waybar.sh"
"$SCRIPT_DIR/swaync.sh"

# notification

notify-send "Theme Switch" "Successfully changed theme to $CHOSEN_THEME!"
exit 0