#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"
THEME_WALL_DIR="$THEME_DIR/current_theme/wallpapers"

if [ -d "$THEME_WALL_DIR" ]; then
    FIRST_WALL=$(find "$THEME_WALL_DIR" -maxdepth 1 -type f \
        \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) \
        | head -n 1)

    if [ -n "$FIRST_WALL" ] && command -v awww &>/dev/null; then
        awww img "$FIRST_WALL" \
            --transition-type grow \
            --transition-pos 0.5,0.5 \
            --transition-duration 2.3 \
            --transition-fps 165

        echo "$FIRST_WALL" > "$HOME/.cache/current_wallpaper"
    fi
fi