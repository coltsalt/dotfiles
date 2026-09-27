#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin"

LAYOUT_DIR="$HOME/.config/waybar/layouts"
CURRENT_LAYOUT_LINK="$HOME/.config/waybar/current_layout"
CURRENT_STYLE_LINK="$HOME/.config/waybar/current_style"

# # 1. Grab layouts from the folder and check for the active one
ACTIVE_FILE=$(basename "$(readlink "$CURRENT_LAYOUT_LINK" 2>/dev/null)")
ACTIVE_NAME="${ACTIVE_FILE%.jsonc}"

LAYOUT_LIST=""
while IFS= read -r file; do
    clean_name="${file%.jsonc}"
    if [ "$clean_name" = "$ACTIVE_NAME" ]; then
        LAYOUT_LIST+="|$clean_name\n"
    else
        LAYOUT_LIST+=" $clean_name\n"
    fi
done < <(ls "$LAYOUT_DIR" | grep '\.jsonc$')

CHOSEN_NAME=$(printf "$LAYOUT_LIST" | /usr/bin/rofi -dmenu -theme "$HOME/.config/rofi/switcher.rasi" -p "Select Waybar Layout:")

[ -z "$CHOSEN_NAME" ] && exit 0

# Strip out the leading pipe and any visual spacing safely
CLEAN_BASENAME=$(echo "$CHOSEN_NAME" | sed -e 's/^|//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Re-assign variables to match your Section #2 symlinks cleanly
CHOSEN_LAYOUT="${CLEAN_BASENAME}.jsonc"
BASENAME="$CLEAN_BASENAME"

# 2. Swap BOTH Symlinks safely
rm "$CURRENT_LAYOUT_LINK" "$CURRENT_STYLE_LINK" 2>/dev/null

ln -s "$LAYOUT_DIR/$CHOSEN_LAYOUT" "$CURRENT_LAYOUT_LINK"
ln -s "$LAYOUT_DIR/$BASENAME.css" "$CURRENT_STYLE_LINK"

# 3. Use your killall fix and restart
killall waybar
sleep 0.1

/usr/bin/waybar -c "$CURRENT_LAYOUT_LINK" -s "$CURRENT_STYLE_LINK" > /dev/null 2>&1 &

exit 0

