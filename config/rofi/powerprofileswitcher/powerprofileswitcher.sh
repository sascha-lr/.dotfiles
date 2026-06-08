#!/usr/bin/env bash
set -euo pipefail

# Current Theme
THEME="$HOME/.config/rofi/powerprofileswitcher/theme.rasi"

# Options
performance=''
balanced='󰓅'
powersaver=''

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -u 0 \
        -a 2 \
        -theme "$THEME"
}

run_rofi() {
    echo -e "$performance\n$balanced\n$powersaver" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $performance)
        powerprofilesctl set performance
        ;;
    $balanced)
        powerprofilesctl set balanced
        ;;
    $powersaver)
        powerprofilesctl set power-saver
        ;;
esac
