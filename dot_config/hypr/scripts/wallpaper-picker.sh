#!/bin/bash

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin"

THEME_WALL_DIR="$HOME/.config/hypr/themes/current_theme/wallpapers"
GLOBAL_WALL_DIR="$HOME/Pictures/wallpapers"
MENU_THEME="$HOME/.config/rofi/switcher.rasi"
GRID_THEME="$HOME/.config/rofi/wallpaper.rasi"

# Step 1: Ask the user where they want to look
CHOICE=$(echo -e "󰏘  Current Theme Wallpapers\n  Global Wallpapers" | /usr/bin/rofi -dmenu -theme "$MENU_THEME" -p "Wallpaper Source:")

# Route to the directory chosen
if [ "$CHOICE" == "󰏘  Current Theme Wallpapers" ]; then
    TARGET_DIR="$THEME_WALL_DIR"
elif [ "$CHOICE" == "  Global Wallpapers" ]; then
    TARGET_DIR="$GLOBAL_WALL_DIR"
else
    exit 0 # Pressed ESC
fi

# Safety check: ensure directory exists and isn't empty
if [ ! -d "$TARGET_DIR" ] || [ -z "$(ls -A "$TARGET_DIR")" ]; then
    notify-send "Wallpaper Picker" "Selected folder is empty or missing!"
    exit 1
fi

# Step 2: Build a visual icon menu list for Rofi
ROFI_OPTIONS=""
while IFS= read -r file; do
    # Skip directories if any
    [ -d "$TARGET_DIR/$file" ] && continue
    # Format: DisplayName\x00icon\x1f/absolute/path/to/image
    ROFI_OPTIONS+="$file\x00icon\x1f$TARGET_DIR/$file\n"
done < <(ls "$TARGET_DIR" | grep -E "\.(png|jpg|jpeg|webp)$")

# Step 3: Launch the Grid Rofi menu
CHOSEN_WALL=$(echo -e "$ROFI_OPTIONS" | /usr/bin/rofi -dmenu -theme "$GRID_THEME" -show-icons -p "  Select Wallpaper:")

[ -z "$CHOSEN_WALL" ] && exit 0

FULL_PATH="$TARGET_DIR/$CHOSEN_WALL"

# Step 4: Apply the wallpaper! 
# (Swap this out depending on what wallpaper utility you prefer, like hyprpaper, swww, or swaybg)
if command -v awww &> /dev/null; then
    awww img "$FULL_PATH"  --transition-type grow --transition-fps 165 --transition-duration 2.5
elif command -v hyprpaper &> /dev/null; then
    # If using hyprpaper, you'd typically unload/preload via hyprctl
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$FULL_PATH"
    hyprctl hyprpaper wallpaper "Virtual-1,$FULL_PATH"
fi

# Save the current wallpaper path to a file so other scripts can reference it if needed
echo "$FULL_PATH" > "$HOME/.cache/current_wallpaper"