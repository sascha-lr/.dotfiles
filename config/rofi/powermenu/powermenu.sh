#!/usr/bin/env bash
set -euo pipefail

# Current theme
THEME="$HOME/.config/rofi/powermenu/theme.rasi"

# Options
shutdown=''
reboot=''
lock=''
suspend='󰤄'
logout='󰍃'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -a 3 \
        -u 4 \
        -theme "$THEME"
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        sleep 0.08
        runapp -- hyprlock
        ;;
    $suspend)
        sleep 0.08
        systemctl suspend
        ;;
    $logout)
        uwsm stop
        ;;
esac
